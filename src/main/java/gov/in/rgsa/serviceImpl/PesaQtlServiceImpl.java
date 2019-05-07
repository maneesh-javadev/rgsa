package gov.in.rgsa.serviceImpl;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.*;
import gov.in.rgsa.inbound.QprEGovReq;
import gov.in.rgsa.inbound.QprQuartReply;
import gov.in.rgsa.outbound.QprQuartProgress;
import gov.in.rgsa.service.PesaQtlService;
import gov.in.rgsa.user.preference.UserPreference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Transactional
@Service
public class PesaQtlServiceImpl implements PesaQtlService {

    @Autowired
    UserPreference userPreference;

    @Autowired
    CommonRepository commonRepository;

    @SuppressWarnings("Duplicates")
    @Override
    public Map<String, Object> getPesaFormMap(Integer quarterId) {
        Map<String, Object> qParams = new HashMap<>();
        String userType = userPreference.getUserType();
        Integer finYearId = userPreference.getFinYearId();
        qParams.put("quarterId", quarterId);
        qParams.put("stateCode", userPreference.getStateCode());
        qParams.put("yearId", finYearId);
        qParams.put("userType", userType);

        List<QprQuartProgress> qprQuarts = commonRepository.findAll("FETCH_QPR_PESA", qParams);
        Map<String, Object> response = new HashMap<>();
        List<Map<String, Object>> expList = new ArrayList<>();
        boolean topInserted = false, isNew = true;
        for(QprQuartProgress qprQuart: qprQuarts) {

            if(!topInserted) {
                response.put("pesaPlanId", qprQuart.pesaPlanId);
                response.put("qprPesaId", qprQuart.qprPesaId);
                isNew = isNew && (qprQuart.qprPesaId==-1);
                response.put("quarterId", quarterId);
                response.put("additional", qprQuart.additionalRequirement);
                response.put("isFreeze", qprQuart.getIsFreeze());  // @TODO
                response.put("userType", userType);
                response.put("addReqUsed", qprQuart.getAddReqUsed());
                topInserted = true;
            }
            Map<String, Object> single = new HashMap<>();
            single.put("qprPesaDetailsId", qprQuart.qprPesaDetailsId);
            single.put("pesaPlanDetailsId", qprQuart.pesaPlanDetailsId);
            single.put("designationId", qprQuart.designationId);
            single.put("designationName", qprQuart.pesaPostName);
            single.put("unitApproved", qprQuart.noOfUnits );
            single.put("costApproved", qprQuart.unitCostPerMonth);
            single.put("unitCompleted", qprQuart.noOfUnitsFilled);
            single.put("expenditure", qprQuart.expenditureIncurred);
            single.put("ceilingValue", qprQuart.ceilingValue);
            single.put("spent", qprQuart.getSpent());
            single.put("funds", qprQuart.getFunds());
            expList.add(single);
        }
        response.put("expenditures", expList);
        response.put("isNew", isNew);
        return response;
    }

    @SuppressWarnings("Duplicates")
    @Override
    public void save(QprQuartReply qprQuartReply) {
        // Check whether an update or new instance
        QprPesa qprPesa = null;
        if(qprQuartReply.getQprPesaId() == -1) {
            qprPesa = new QprPesa();
            qprPesa.setIsFreeze(false);
            qprPesa.setCreatedBy(userPreference.getUserId());
        }else {
            qprPesa = commonRepository.find(QprPesa.class, qprQuartReply.getQprPesaId());
            boolean isFreezed = qprPesa.getIsFreeze() == null? false : qprPesa.getIsFreeze();
            if(isFreezed) {
                throw new IllegalArgumentException("Form is freezed please unfreeze first.");
            }
        }

        PesaPlan pesaPlan = commonRepository.find(PesaPlan.class, qprQuartReply.getPesaPlanId());
        if(pesaPlan == null)
            throw new IllegalArgumentException(String.format("Invalid PesaplanId: %d", qprQuartReply.getPesaPlanId()));
        QprQuarterDetail qprQuarterDetail = commonRepository.find(QprQuarterDetail.class, qprQuartReply.getQuarterId());
        if(qprQuarterDetail == null)
            throw new IllegalArgumentException(String.format("Invalid QuartedId: %d", qprQuartReply.getQuarterId()));

        qprPesa.setPesaPlan(pesaPlan);
        qprPesa.setAdditionalRequirement(qprQuartReply.getAdditionalRequirement());
        qprPesa.setQprQuarterDetail(qprQuarterDetail);
        qprPesa.setMenuId(0);
        qprPesa.setLastUpdatedBy(userPreference.getUserId());
        commonRepository.save(qprPesa);

        for(QprQuartReply.Expenditure exp: qprQuartReply.getExpenditure()) {
            QprPesaDetails qprPesaDetails = null;
            PesaPost pesaPost = commonRepository.find(PesaPost.class, exp.getDesignationId());
            if(pesaPost == null)
                throw new IllegalArgumentException(String.format("Invalid DesignationId: %d", exp.getDesignationId()));
            PesaPlanDetails pesaPlanDetails = commonRepository.find(PesaPlanDetails.class, exp.getPlanDetailsId());
            if(pesaPlanDetails == null)
                throw new IllegalArgumentException(String.format("Invalid PesaPlanDetailsId: %d",  exp.getPlanDetailsId()));

            Map<String, Object> conditionMap = new HashMap<>(3);
            conditionMap.put("pesaPlanDetails", pesaPlanDetails);
            List<QprPesaDetails> otherQprDetails = commonRepository.findAllByCondition(QprPesaDetails.class, conditionMap);
            Double amountSpent = 0.0;
            for (QprPesaDetails otherQprDetail: otherQprDetails) {
                if(otherQprDetail.getQprPesa().getQprQuarterDetail().getQtrId() < qprQuartReply.getQuarterId())
                    amountSpent += otherQprDetail.getExpenditureIncurred();
            }
            Double maxAllowedExpenditure = pesaPlanDetails.getFunds() - amountSpent;

            if(exp.getQprPesaDetailsId() == -1) {
                qprPesaDetails = new QprPesaDetails();
            }else {
                qprPesaDetails = commonRepository.find(QprPesaDetails.class, exp.getQprPesaDetailsId());
            }
            if(exp.getExpenditure() > maxAllowedExpenditure)
                throw new IllegalArgumentException(String.format("%s's expenditure can't be above: %.2f",  pesaPost.getPesaPostName(), maxAllowedExpenditure));
            qprPesaDetails.setExpenditureIncurred(exp.getExpenditure());
            qprPesaDetails.setNoOfUnitsFilled(exp.getUnitCompleted());
            qprPesaDetails.setPesaPost(pesaPost);
            qprPesaDetails.setQprPesa(qprPesa);
            qprPesaDetails.setPesaPlanDetails(pesaPlanDetails);
            commonRepository.save(qprPesaDetails);
        }

    }

    @Override
    public void freeze(QprQuartReply qprQuartReply) {
        QprPesa qprPesa = commonRepository.find(QprPesa.class, qprQuartReply.getQprPesaId());
        if(qprPesa == null)
            throw new IllegalArgumentException(String.format("Invalid QprPesaId: %d", qprQuartReply.getPesaPlanId()));
        qprPesa.setIsFreeze(true);
        commonRepository.save(qprPesa);
    }

    @Override
    public void unFreeze(QprQuartReply qprQuartReply) {
        QprPesa qprPesa = commonRepository.find(QprPesa.class, qprQuartReply.getQprPesaId());
        if(qprPesa == null)
            throw new IllegalArgumentException(String.format("Invalid QprPesaId: %d", qprQuartReply.getPesaPlanId()));
        qprPesa.setIsFreeze(false);
        commonRepository.save(qprPesa);
    }
}
