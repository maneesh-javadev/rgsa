package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.transaction.TransactionStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.CapacityBuildingActivityGPs;
import gov.in.rgsa.entity.Plan;
import gov.in.rgsa.entity.PlanComponents;
import gov.in.rgsa.entity.ReleaseIntallment;
import gov.in.rgsa.entity.State;
import gov.in.rgsa.entity.StateAllocation;
import gov.in.rgsa.model.StateAllocationModal;
import gov.in.rgsa.service.ActionPlanService;
import gov.in.rgsa.service.MOPRService;
import gov.in.rgsa.service.PlanAllocationService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class PlanAllocationServiceImpl implements PlanAllocationService{

	@Autowired
	private CommonRepository commonRepository; 
	
	@Autowired
	 private UserPreference userPreference;
	
	@PersistenceContext
	private EntityManager entityManager;
	
	@Autowired
	private ActionPlanService actionPlanService;
	
	@Autowired
	private MOPRService moprService;
	
	private static final Integer PLAN_STATUS_APPROVED=5;
	
	private PlatformTransactionManager transactionManager;
	
	@Override
	public List<PlanComponents> getPlanComponents() {
		// TODO Auto-generated method stub
		
		return commonRepository.findAll("PLAN_COMPONENTS_LIST", null);
	}
	
	
	@Override
	public Boolean approveCecPlan() {
		
		Map<String, Object> params=new HashMap<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		Boolean flag = false;
		Query query = entityManager.createNativeQuery("select * from rgsa.approve_plan(:stateCode,:yearId)");
			query.setParameter("stateCode", userPreference.getStateCode());
			query.setParameter("yearId", userPreference.getFinYearId());
			 Boolean value = (Boolean) query.getSingleResult();
		/* int value = commonRepository.excuteUpdate("APPROVED_CEC_PLAN", params); */
		  if(value == true)
		  { flag=true; }
		  
		  else
			  flag = false;
		 
		return flag;
	}

	@Override
	public List<State> states(int stateCode) {
		Map<String, Object> stateParams = new HashMap<>();
		stateParams.put("id", stateCode);
		List<State> states = commonRepository.findAll("FETCH_STATE_BY_CODE",stateParams );
		return states;
	}
	
	public List<Plan> showHidePlanStatus(int stateCode)
	{
		Map<String, Object> param=new HashMap<>();
		param.put("yearId", userPreference.getFinYearId());
		param.put("stateCode", stateCode);
		//param.put("planStatusId", 1);
		List<Plan> planList = commonRepository.findAll("SHOW_HIDE_BUTTON_PLAN_STATUS",param);
		return planList;
		
	}
	 
	@Override
	public StateAllocationModal getBasicDetailofPlanAllocation(StateAllocationModal stateAllocationModal){
		List<Plan> planList=actionPlanService.fetchPlanDetailbyStatus(PLAN_STATUS_APPROVED);
		if(planList!=null && !planList.isEmpty()){
			Plan plan=planList.get(0);
			List<ReleaseIntallment> releaseIntallmentList =moprService.fetchReleaseIntallment(plan.getPlanPK().getPlanCode(), 1);
			List<StateAllocation> stateAllocationList= this.fetchStateAllocationList(plan.getPlanPK().getPlanCode(), 1);
			if(stateAllocationList!=null && !stateAllocationList.isEmpty()) {
				stateAllocationModal.setStateAllocationList(stateAllocationList);
				stateAllocationModal.setStatus(stateAllocationList.get(0).getStatus());
			}
			
			if(releaseIntallmentList!=null && !releaseIntallmentList.isEmpty()){
				ReleaseIntallment releaseIntallment=releaseIntallmentList.get(0);
				stateAllocationModal.setTotalAmount(releaseIntallment.getStatusCentralShare()); 
				stateAllocationModal.setInstallmentNo(releaseIntallment.getInstallmentNo());
				stateAllocationModal.setPlanCode(plan.getPlanPK().getPlanCode());
				stateAllocationModal.setSanctionOrderExist(Boolean.TRUE);
			}else{
				stateAllocationModal.setSanctionOrderExist(Boolean.FALSE);
			}
		
		}else{
			stateAllocationModal.setSanctionOrderExist(Boolean.FALSE);
		}
		//temp add for testing
		List<StateAllocation> stateAllocationList= this.fetchStateAllocationList(5, 1);
		stateAllocationModal.setStateAllocationList(stateAllocationList);
		stateAllocationModal.setSanctionOrderExist(true);
		return stateAllocationModal;
	}
	
	public void setTransactionManager(PlatformTransactionManager txManager) {
		this.transactionManager = txManager;
	}

	
	@Override
	public boolean  savePlanAllocation(StateAllocationModal stateAllocationModal) {
		for(StateAllocation obj: stateAllocationModal.getStateAllocationList()) {
			
			obj.setInstallmentNo(stateAllocationModal.getInstallmentNo());
			obj.setPlanCode(stateAllocationModal.getPlanCode());
			obj.setStatus(stateAllocationModal.getStatus());
			if(obj.getSrNo()!=null) {
				commonRepository.update(obj);
			}
			else {
				commonRepository.save(obj);
			}
		}
		return true;
	}
	
	@Override
	public List<StateAllocation> fetchStateAllocationList(Integer planCode,Integer installmentNo){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("planCode", planCode);
		params.put("installmentNo", installmentNo);
		List<StateAllocation>  stateAllocationList= commonRepository.findAll("FIND_STALE_ALLOCATION", params);
		if(stateAllocationList!=null && !stateAllocationList.isEmpty()) {
			return stateAllocationList;
		}
		return (stateAllocationList=new  ArrayList<StateAllocation>());
	}
}
