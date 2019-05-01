package gov.in.rgsa.serviceImpl;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.*;
import gov.in.rgsa.inbound.QprEGovReq;
import gov.in.rgsa.outbound.QprEGovResponse;
import gov.in.rgsa.service.EGovQtlService;
import gov.in.rgsa.user.preference.UserPreference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class EGovQtlServiceImpl implements EGovQtlService {

    @Autowired
    UserPreference userPreference;

    @Autowired
    CommonRepository commonRepository;

    @Override
    public Map<String, Object> getEGovFormMap(Integer quarterId) {
        Map<String, Object> qParams = new HashMap<>();
        String userType = userPreference.getUserType();
        Integer finYearId = userPreference.getFinYearId();
        qParams.put("quarterId", quarterId);
        qParams.put("stateCode", userPreference.getStateCode());
        qParams.put("yearId", finYearId);
        qParams.put("userType", userType);

        List<QprEGovResponse> qprEGovs = commonRepository.findAll("FETCH_QPR_EGOV_SUPPORT", qParams);
        Map<String, Object> response = new HashMap<>();
        List<Map<String, Object>> expList = new ArrayList<>();
        boolean topInserted = false, isNew = true;
        for(QprEGovResponse qprEGov: qprEGovs) {

            if(!topInserted) {
                response.put("qprEGovId", qprEGov.getQprEGovId());
                isNew = isNew && (qprEGov.getQprEGovId()==-1);
                response.put("egovSupportActivityId", qprEGov.getEgovSupportActivityId());
                response.put("stateCode", qprEGov.getStateCode());
                response.put("yearId", qprEGov.getYearId());
                response.put("quarterId", quarterId);
                response.put("versionNo", qprEGov.getVersionNo());
                response.put("additionalRequirement", qprEGov.getAdditionalRequirement());
                response.put("isFreeze", qprEGov.getIsFreez());
                topInserted = true;
            }
            Map<String, Object> single = new HashMap<>();
            single.put("qprEGovDetailsId", qprEGov.getQprEGovDetailsId());
            single.put("egovSupportActivityDetailsId", qprEGov.getEgovSupportActivityDetailsId());
            single.put("egovPostLevelId", qprEGov.getEgovPostLevelId());
            single.put("egovPostLevelName", qprEGov.getEgovPostLevelName());
            single.put("postApproved", qprEGov.getPostApproved());
            single.put("costApproved", qprEGov.getCostApproved());
            single.put("isApproved", qprEGov.getIsApproved());
            single.put("egovPostName", qprEGov.getEgovPostName());
            single.put("egovPostId", qprEGov.getEgovPostId());
            single.put("postFilled", qprEGov.getPostFilled());
            single.put("incurred", qprEGov.getIncurred());
            expList.add(single);
        }
        response.put("expenditures", expList);
        response.put("isNew", isNew);
        return response;
    }

    public void save(QprEGovReq qprEGovReq) {
        // Check whether an update or new instance
        QprEGov qprEGov = null;
        if(qprEGovReq.getQprEGovId() == -1) {
            qprEGov = new QprEGov();
            qprEGov.setCreatedBy(userPreference.getUserId());
        }else {
            qprEGov = commonRepository.find(QprEGov.class, qprEGovReq.getQprEGovId());
            boolean isFreezed = qprEGov.getIsFreeze() == null? false : qprEGov.getIsFreeze();
            if(isFreezed) {
                throw new IllegalArgumentException("Form is freezed please unfreeze first.");
            }
        }

        EGovSupportActivity eGovSA = commonRepository.find(EGovSupportActivity.class, qprEGovReq.getEgovSupportActivityId());
        if(eGovSA == null)
            throw new IllegalArgumentException(String.format("Invalid EGovSupportActivityId: %d", qprEGovReq.getEgovSupportActivityId()));
        QprQuarterDetail qprQuarterDetail = commonRepository.find(QprQuarterDetail.class, qprEGovReq.getQuarterId());
        if(qprQuarterDetail == null)
            throw new IllegalArgumentException(String.format("Invalid QuartedId: %d", qprEGovReq.getQuarterId()));

        qprEGov.setIsFreeze(false);
        qprEGov.setEgovSupportActivity(eGovSA);
        qprEGov.setAdditionalRequirement(qprEGovReq.getAdditionalRequirement());
        qprEGov.setQprQuarterDetail(qprQuarterDetail);
        qprEGov.setMenuId(0);
        qprEGov.setLastUpdatedBy(userPreference.getUserId());
        commonRepository.save(qprEGov);

        for(QprEGovReq.Expenditure exp: qprEGovReq.getExpenditures()) {
            QprEGovDetails qprEGovDetails = null;
            EGovPost eGovPost = commonRepository.find(EGovPost.class, exp.getEgovPostId());
            if(eGovPost == null)
                throw new IllegalArgumentException(String.format("Invalid EGovPostId: %d", exp.getEgovPostId()));
            EGovSupportActivityDetails eGovSAD = commonRepository.find(EGovSupportActivityDetails.class, exp.getEgovSupportActivityDetailsId());
            if(eGovSAD == null)
                throw new IllegalArgumentException(String.format("Invalid EGovSupportActivityDetailsId: %d",  exp.getEgovSupportActivityDetailsId()));

            if(exp.getQprEGovDetailsId() == -1) {
                qprEGovDetails = new QprEGovDetails();
            }else {
                qprEGovDetails = commonRepository.find(QprEGovDetails.class, exp.getQprEGovDetailsId());
            }
            Integer postFilled = exp.getPostFilled() == null? 0: exp.getPostFilled();
            Integer unitCost = eGovSAD.getUnitCost() == null? 0: eGovSAD.getUnitCost();
            Double totalExpenditure = postFilled * unitCost * 1.00;
            if(exp.getIncurred() > totalExpenditure)
                throw new IllegalArgumentException(String.format("%s's expenditure can't be above: %.2f",  eGovPost.getEGovPostName(), totalExpenditure));
            qprEGovDetails.setExpenditureIncurred(exp.getIncurred());
            qprEGovDetails.setNoOfUnitsFilled(exp.getPostFilled());
            qprEGovDetails.seteGovPost(eGovPost);
            qprEGovDetails.setQprEgov(qprEGov);
            commonRepository.save(qprEGovDetails);
        }
    }

    public void unFreeze(QprEGovReq qprEGovReq) {
        QprEGov qprEGov = commonRepository.find(QprEGov.class, qprEGovReq.getQprEGovId());
        if(qprEGov == null)
            throw new IllegalArgumentException(String.format("Invalid QprPesaId: %d", qprEGovReq.getQprEGovId()));
        qprEGov.setIsFreeze(false);
        commonRepository.save(qprEGov);
    }

    public void freeze(QprEGovReq qprEGovReq) {
        QprEGov qprEGov = commonRepository.find(QprEGov.class, qprEGovReq.getQprEGovId());
        if(qprEGov == null)
            throw new IllegalArgumentException(String.format("Invalid QprPesaId: %d", qprEGovReq.getQprEGovId()));
        qprEGov.setIsFreeze(true);
        commonRepository.save(qprEGov);
    }
}
