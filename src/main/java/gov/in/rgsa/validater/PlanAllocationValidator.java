package gov.in.rgsa.validater;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import gov.in.rgsa.entity.ReleaseIntallment;
import gov.in.rgsa.entity.StateAllocation;
import gov.in.rgsa.model.StateAllocationModal;
import gov.in.rgsa.service.MOPRService;

@Component()
public class PlanAllocationValidator implements Validator {
	
	
	@Autowired
	private MOPRService moprService;

	@Override
	public boolean supports(Class<?> arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void validate(Object obj, Errors errors) {
		// TODO Auto-generated method stub
		StateAllocationModal stateAllocationModal=(StateAllocationModal)obj;
		if(stateAllocationModal.getStatus().charAt(0)=='F') {
			Double totalRelFound=null;
			Double totalFund=0D;
			Double temp=0D;
			List<ReleaseIntallment> releaseIntallmentList =moprService.fetchReleaseIntallment(stateAllocationModal.getPlanCode(), stateAllocationModal.getInstallmentNo());
			if(releaseIntallmentList!=null && !releaseIntallmentList.isEmpty()) {
			totalRelFound=	releaseIntallmentList.get(0).getStatusCentralShare();
			}
			for(StateAllocation stateAllocation: stateAllocationModal.getStateAllocationList()) {
				temp=stateAllocation.getFundsAllocated()!=null?stateAllocation.getFundsAllocated():0;
				totalFund=totalFund+temp;
			}
			if(totalRelFound!=null && totalFund!=null) {
				if(totalRelFound.doubleValue()!=totalFund.doubleValue()) {
					errors.rejectValue("totalAmount","Please allocate fund equal to release fund of installment");
				}
			}else {
				errors.rejectValue("totalAmount","data not proper format");
			}
		}
		
		
		
		
		
		
	}

	

}
