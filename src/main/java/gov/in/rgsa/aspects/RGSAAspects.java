package gov.in.rgsa.aspects;

import java.util.List;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;

import gov.in.rgsa.entity.Plan;
import gov.in.rgsa.entity.StateAllocation;
import gov.in.rgsa.service.ActionPlanService;
import gov.in.rgsa.service.PlanAllocationService;


@Aspect
public class RGSAAspects {

	@Autowired
	private PlanAllocationService planAllocationService;
	
	@Autowired
	private ActionPlanService actionPlanService;
	
	public static final String REDIRECT_PLAN_ALLOCATION = "redirect:planAllocationQPR.html";
	
	private static final Integer PLAN_STATUS_APPROVED=5;
	
	@Around("allProgressReportControllerpointcut()")
	public String qprAdvice(ProceedingJoinPoint proceedingJoinPoint)  {
	boolean flag=false;
	System.out.println("******************into AOP method********************************");
	List<Plan> planList=actionPlanService.fetchPlanDetailbyStatus(PLAN_STATUS_APPROVED);
		if(planList!=null && !planList.isEmpty()){
			Plan plan=planList.get(0);
			List<StateAllocation> stateAllocationList=planAllocationService.fetchStateAllocationList(plan.getPlanCode(), 1);
			if(stateAllocationList!=null && !stateAllocationList.isEmpty() && stateAllocationList.get(0).getStatus().charAt(0)=='F') {
				flag=true;
			}
		}
		
		if(flag) {
			Object[] args = proceedingJoinPoint.getArgs(); // change the args if you want to
		    try {
				String retVal =(String) proceedingJoinPoint.proceed(args);
				return retVal;
			} catch (Throwable e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}		
		}else {
			return REDIRECT_PLAN_ALLOCATION;
		}
		 return null;
	
	}
	
	
	
	@Pointcut("execution(* gov.in.rgsa.controller.ProgressReportController.qprGetForm*(..)) ||  execution(* gov.in.rgsa.controller.QprTrainingActivityController.qprGetForm*(..)) "
	+ "|| execution(* gov.in.rgsa.controller.EGovernQuaterly.qprGetForm*(..) )||  execution(* gov.in.rgsa.controller.PesaPlanQuarterly.qprGetForm*(..)) ")
	public void allProgressReportControllerpointcut() {}

}
