package gov.in.rgsa.serviceImpl;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.*;
import gov.in.rgsa.inbound.QprEGovReq;
import gov.in.rgsa.outbound.QprEGovResponse;
import gov.in.rgsa.service.EGovQtlService;
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
        qParams.put("userType", Users.getTypeForCEC());
        List<QprEGovResponse> qprEGovs = commonRepository.findAll("FETCH_QPR_EGOV_SUPPORT", qParams);
        Map<String, Object> map = new HashMap<>();
        map.put("quarterId", quarterId);
        map.put("eGovSupportActivityId", qprEGovs.get(0).getEgovSupportActivityId());
        List<QprEGov> listExceptCurrentQtr=commonRepository.findAll("FETCH_QPR_EGOV_EXCEPT_THIS_QTR_ID", map);
        Map<String, Object> response = new HashMap<>();
        List<Map<String, Object>> expList = new ArrayList<>();
        boolean topInserted = false, isNew = true , qtrOneAndTwoNotPresent=false;
        int totalExpendIncuuredInQtr1and2=0;
        if(!listExceptCurrentQtr.isEmpty() && quarterId >= 3) {
        	List<QprEGovDetails> detailListExceptCurrentQtr = new ArrayList<QprEGovDetails>();
        	for(QprEGov qEgov : listExceptCurrentQtr) {
        		if(qEgov.getQprQuarterDetail().getQtrId() < 3) {
        			Map<String, Object> innerMap = new HashMap<>();
        			innerMap.put("qprEgovId", qEgov.getQprEgovId());
        		detailListExceptCurrentQtr.addAll(commonRepository.findAll("DETAILS_BY_QPR_EGOV_ACTIVITY_ID", innerMap));
        		}
        	}
        	if(!detailListExceptCurrentQtr.isEmpty()) {
        		for(QprEGovDetails detail : detailListExceptCurrentQtr) {
        			if(detail.getExpenditureIncurred() != null) {
        				totalExpendIncuuredInQtr1and2 += detail.getExpenditureIncurred();
        			}
        		}
        	}
        }
        if(totalExpendIncuuredInQtr1and2 == 0 && quarterId >= 3) {
        	qtrOneAndTwoNotPresent = true;
        }
        for(QprEGovResponse qprEGov: qprEGovs) {

            if(!topInserted) {
                response.put("qprEGovId", qprEGov.getQprEGovId());
                isNew = isNew && (qprEGov.getQprEGovId()==-1);
                response.put("egovSupportActivityId", qprEGov.getEgovSupportActivityId());
                response.put("stateCode", qprEGov.getStateCode());
                response.put("yearId", qprEGov.getYearId());
                response.put("quarterId", quarterId);
                response.put("versionNo", qprEGov.getVersionNo());
                response.put("addReqSpmu", qprEGov.getAdditionalReqSpmu());
                response.put("addReqDpmu", qprEGov.getAdditionalReqDpmu());
                response.put("isFreeze", qprEGov.getIsFreez());
                response.put("addReqSpmuApproved", qprEGov.getAddReqSpmuApproved());
                response.put("addReqDpmuApproved", qprEGov.getAddReqDpmuApproved());
                response.put("addReqSpmuUsed", qprEGov.getAddReqSpmuUsed());
                response.put("addReqDpmuUsed", qprEGov.getAddReqDpmuUsed());
                response.put("qtrOneAndTwoNotPresent", qtrOneAndTwoNotPresent);
                topInserted = true;
            }
            Map<String, Object> single = new HashMap<>();
            single.put("qprEGovDetailsId", qprEGov.getQprEGovDetailsId());
            single.put("egovSupportActivityDetailsId", qprEGov.getEgovSupportActivityDetailsId());
            single.put("egovPostLevelId", qprEGov.getEgovPostLevelId());
            single.put("egovPostLevelName", qprEGov.getEgovPostLevelName());
            single.put("isPost", qprEGov.getIsPost());
            single.put("postApproved", qprEGov.getPostApproved());
            single.put("costApproved", qprEGov.getCostApproved());
            single.put("isApproved", qprEGov.getIsApproved());
            single.put("egovPostName", qprEGov.getEgovPostName());
            single.put("egovPostId", qprEGov.getEgovPostId());
            single.put("postFilled", qprEGov.getPostFilled());
            single.put("incurred", qprEGov.getIncurred());
            single.put("spent", qprEGov.getSpent());
            single.put("funds", qprEGov.getFunds());
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
        qprEGov.setAdditionalReqSpmu(qprEGovReq.getAddReqSpmu());
        qprEGov.setAdditionalReqDpmu(qprEGovReq.getAddReqDpmu());
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

            Map<String, Object> conditionMap = new HashMap<>(3);
            conditionMap.put("eGovSupportActivityDetails", eGovSAD);
            List<QprEGovDetails> otherQprDetails = commonRepository.findAllByCondition(QprEGovDetails.class, conditionMap);
            Double amountSpent = 0.0;
            for (QprEGovDetails otherQprDetail: otherQprDetails) {
                if(otherQprDetail.getQprEgov().getQprQuarterDetail().getQtrId() < qprEGovReq.getQuarterId())
                    amountSpent += otherQprDetail.getExpenditureIncurred();
            }
            Double maxAllowedExpenditure = eGovSAD.getFunds() - amountSpent;

            if(exp.getQprEGovDetailsId() == -1) {
                qprEGovDetails = new QprEGovDetails();
            }else {
                qprEGovDetails = commonRepository.find(QprEGovDetails.class, exp.getQprEGovDetailsId());
            }
            if(exp.getIncurred() > maxAllowedExpenditure)
                throw new IllegalArgumentException(String.format("%s's expenditure can't be above: %.2f",  eGovPost.getEGovPostName(), maxAllowedExpenditure));
            qprEGovDetails.setExpenditureIncurred(exp.getIncurred());
            if(eGovPost.getPost())
                qprEGovDetails.setNoOfUnitsFilled(exp.getPostFilled());
            else
                qprEGovDetails.setNoOfUnitsFilled(0);
            qprEGovDetails.seteGovPost(eGovPost);
            qprEGovDetails.setQprEgov(qprEGov);
            qprEGovDetails.seteGovSupportActivityDetails(eGovSAD);
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
