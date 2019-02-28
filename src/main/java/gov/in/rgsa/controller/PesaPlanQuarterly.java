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
import gov.in.rgsa.entity.ExtentOfCoverage;
import gov.in.rgsa.entity.PesaPlan;
import gov.in.rgsa.entity.PesaPlanDetails;
import gov.in.rgsa.entity.PesaPost;
import gov.in.rgsa.entity.QprPesa;
import gov.in.rgsa.entity.QprPesaDetails;
import gov.in.rgsa.entity.QprQuarterDetail;
import gov.in.rgsa.inbound.QprQuartReply;
import gov.in.rgsa.inbound.QprQuartReply.Expenditure;
import gov.in.rgsa.outbound.MsgReply;
import gov.in.rgsa.outbound.QprQuartProgress;
import gov.in.rgsa.service.ProgressReportService;
import gov.in.rgsa.user.preference.UserPreference;

@Controller
public class PesaPlanQuarterly {

	private static final String Pesa_Plan_Quarterly ="pesaPlanQuaterly";
	
	@Autowired
	private ProgressReportService progressReportService;
	
	@Autowired
	UserPreference userPreference;
	
	@Autowired
	private CommonRepository commonRepository;
	
	@PersistenceContext
	private EntityManager entityManager;

	@RequestMapping(value="pesaPlanQuaterly" , method=RequestMethod.GET)
	public String qprGetFormpesaPlanQuarterly(@ModelAttribute("ADMIN_QUADERLY") ExtentOfCoverage extentOfCoverage, Model model) {		
		model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
		return Pesa_Plan_Quarterly;
	}
	
	// Loads asynchronously
	
	@ResponseBody
	@RequestMapping(value="fetchQuartExp", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
	public MsgReply<Object> getQuartExp(@RequestParam("qid") Integer quarterId) {
		
		Map<String, Object> qParams = new HashMap<>();
		String userType = userPreference.getUserType();
		Integer finYearId = userPreference.getFinYearId();
		qParams.put("quarterId", quarterId);
		qParams.put("stateCode", userPreference.getStateCode());
		qParams.put("yearId", finYearId);
		qParams.put("userType", userType);
		try {
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
	@RequestMapping(value="postQuartExp", method=RequestMethod.POST,consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE)
	private  MsgReply<Object> postQuartExp(@RequestBody QprQuartReply qprQuartReply) {
		try {
			switch(qprQuartReply.getAction()) {
				case "save":
					return this.save(qprQuartReply);
				case "freeze":
					if(qprQuartReply.getQprPesaId()==-1) {
						MsgReply<Object> result = this.save(qprQuartReply);
						if(!result.isSuccess())
							return result;
					}
					return this.freeze(qprQuartReply);
				case "unfreeze":
					return this.unFreeze(qprQuartReply);
				}
		}catch(Exception e) {
			System.out.println(e);
			System.out.println(e.getMessage());
			return MsgReply.failMessage(e.getMessage()); // new MsgReply<String>(false, e.getMessage(), httpStatus);
		}
		return MsgReply.failMessage("Unknown command");	
	}
	
	private MsgReply<Object> save(QprQuartReply qprQuartReply) {
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
			
			for(Expenditure exp: qprQuartReply.getExpenditure()) {
				QprPesaDetails qprPesaDetails = null;
				PesaPost pesaPost = commonRepository.find(PesaPost.class, exp.getDesignationId());
				if(pesaPost == null)
					throw new IllegalArgumentException(String.format("Invalid DesignationId: %d", exp.getDesignationId()));
				PesaPlanDetails pesaPlanDetails = commonRepository.find(PesaPlanDetails.class, exp.getPlanDetailsId()); 
				if(pesaPlanDetails == null)
					throw new IllegalArgumentException(String.format("Invalid PesaPlanDetailsId: %d",  exp.getPlanDetailsId()));
				
				if(exp.getQprPesaDetailsId() == -1) {
					qprPesaDetails = new QprPesaDetails();				
				}else {
					qprPesaDetails = commonRepository.find(QprPesaDetails.class, exp.getQprPesaDetailsId());
				}
				Double totalExpenditure = exp.getUnitCompleted() * pesaPlanDetails.getUnitCostPerMonth() * 1.00;
				if(exp.getExpenditure() > totalExpenditure)
					throw new IllegalArgumentException(String.format("%s's expenditure can't be above: %.2f",  pesaPost.getPesaPostName(), totalExpenditure));
				qprPesaDetails.setExpenditureIncurred(exp.getExpenditure());
				qprPesaDetails.setNoOfUnitsFilled(exp.getUnitCompleted());
				qprPesaDetails.setPesaPost(pesaPost);
				qprPesaDetails.setQprPesa(qprPesa);
				commonRepository.save(qprPesaDetails);				
			}
			return getQuartExp(qprQuartReply.getQuarterId());
		
	}
	
	private MsgReply<Object> freeze(QprQuartReply qprQuartReply) {
		QprPesa qprPesa = commonRepository.find(QprPesa.class, qprQuartReply.getQprPesaId());
		if(qprPesa == null)
			throw new IllegalArgumentException(String.format("Invalid QprPesaId: %d", qprQuartReply.getPesaPlanId()));
		qprPesa.setIsFreeze(true);
		commonRepository.save(qprPesa);
		return getQuartExp(qprQuartReply.getQuarterId());
	}
	
	private MsgReply<Object> unFreeze(QprQuartReply qprQuartReply) {
		QprPesa qprPesa = commonRepository.find(QprPesa.class, qprQuartReply.getQprPesaId());
		if(qprPesa == null)
			throw new IllegalArgumentException(String.format("Invalid QprPesaId: %d", qprQuartReply.getPesaPlanId()));
		qprPesa.setIsFreeze(false);
		commonRepository.save(qprPesa);
		return getQuartExp(qprQuartReply.getQuarterId());
	}
}
