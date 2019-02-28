package gov.in.rgsa.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.EGovPost;
import gov.in.rgsa.entity.EGovSupportActivity;
import gov.in.rgsa.entity.EGovSupportActivityDetails;
import gov.in.rgsa.entity.ExtentOfCoverage;
import gov.in.rgsa.entity.QprEGov;
import gov.in.rgsa.entity.QprEGovDetails;
import gov.in.rgsa.entity.QprQuarterDetail;
import gov.in.rgsa.inbound.QprEGovReq;
import gov.in.rgsa.inbound.QprEGovReq.Expenditure;
import gov.in.rgsa.outbound.MsgReply;
import gov.in.rgsa.outbound.QprEGovResponse;
import gov.in.rgsa.service.ProgressReportService;
import gov.in.rgsa.user.preference.UserPreference;

@Controller
public class EGovernQuaterly {

	private static final String EGovt_Quaderly ="eGovtQuaderly";
	
	@Autowired
	private ProgressReportService progressReportService;
	
	@Autowired
	UserPreference userPreference;
	
	@Autowired
	private CommonRepository commonRepository;
	
	@PersistenceContext
	private EntityManager entityManager;

	@RequestMapping(value="eGovtQuaderly" , method=RequestMethod.GET)
	public String qprGetFormeGovtQuaderly(@ModelAttribute("ADMIN_QUADERLY") ExtentOfCoverage extentOfCoverage, Model model) {
		model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
		return EGovt_Quaderly;
	}
	
	@ResponseBody
	@RequestMapping(value="getPostApproveReport", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
	public MsgReply<Object> getPostApproveReport(@RequestParam("qid") Integer quarterId) {
		Map<String, Object> qParams = new HashMap<>();
		String userType = userPreference.getUserType();
		Integer finYearId = userPreference.getFinYearId();
		qParams.put("quarterId", quarterId);
		qParams.put("stateCode", userPreference.getStateCode());
		qParams.put("yearId", finYearId);
		qParams.put("userType", userType);
		
		try {
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
			return MsgReply.okMessage(response);
		}catch(Exception e) {
			return MsgReply.failMessage(e.getMessage());
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value="postPostApproveReport", method=RequestMethod.POST,consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE)
	private  MsgReply<Object> postPostApproveReport(@RequestBody QprEGovReq qprEGovReq){
		try {
			switch(qprEGovReq.getAction()) {
				case "save":
					return this.save(qprEGovReq);
				case "freeze":
					if(qprEGovReq.getIsNew() || qprEGovReq.getQprEGovId()==-1) {
						MsgReply<Object> result = this.save(qprEGovReq);
						if(!result.isSuccess())
							return result;
					}
					return this.freeze(qprEGovReq);
				case "unfreeze":
					return this.unFreeze(qprEGovReq);
				}
		}catch(Exception e) {
			return MsgReply.failMessage(e.getMessage()); // new MsgReply<String>(false, e.getMessage(), httpStatus);
		}
		return MsgReply.failMessage("Unknown command");
	}

	private MsgReply<Object> save(QprEGovReq qprEGovReq) {
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
		
		for(Expenditure exp: qprEGovReq.getExpenditures()) {
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
		return getPostApproveReport(qprEGovReq.getQuarterId()) ;
	}

	private MsgReply<Object> unFreeze(QprEGovReq qprEGovReq) {
		QprEGov qprEGov = commonRepository.find(QprEGov.class, qprEGovReq.getQprEGovId());
		if(qprEGov == null)
			throw new IllegalArgumentException(String.format("Invalid QprPesaId: %d", qprEGovReq.getQprEGovId()));
		qprEGov.setIsFreeze(false);
		commonRepository.save(qprEGov);
		return getPostApproveReport(qprEGovReq.getQuarterId());
	}

	private MsgReply<Object> freeze(QprEGovReq qprEGovReq) {
		QprEGov qprEGov = commonRepository.find(QprEGov.class, qprEGovReq.getQprEGovId());
		if(qprEGov == null)
			throw new IllegalArgumentException(String.format("Invalid QprPesaId: %d", qprEGovReq.getQprEGovId()));
		qprEGov.setIsFreeze(true);
		commonRepository.save(qprEGov);
		return getPostApproveReport(qprEGovReq.getQuarterId());
	}
}
