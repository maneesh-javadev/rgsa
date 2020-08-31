package gov.in.rgsa.validater;

import java.util.List;

import org.springframework.stereotype.Component;

import gov.in.rgsa.entity.PmuActivity;
import gov.in.rgsa.entity.PmuActivityDetails;
import gov.in.rgsa.model.Response;

@Component()
public class PMUValidator  {

	
	
	public Response validate(Object object) {
		
		StringBuilder errMsg=new StringBuilder("");
		Response response=new Response();
		response.setResponseCode(200);
		PmuActivity form=(PmuActivity)object;
		List<PmuActivityDetails> pmuActivityDetails=form.getPmuActivityDetails();
		for(PmuActivityDetails obj:pmuActivityDetails) {
			if(obj.getPmuActivityType().getPmuActivityTypeId()==1 || obj.getPmuActivityType().getPmuActivityTypeId()==2) {
				if(!(obj.getNoOfUnits()==null && obj.getNoOfMonths()==null && obj.getFund()==null)) {
					
					if(!(obj.getNoOfUnits()>0 && obj.getFund()>0 && obj.getNoOfMonths()>0 && obj.getNoOfMonths()<=12)) {
						response.setResponseCode(500);
						
						if(!( obj.getNoOfUnits()!=null && obj.getNoOfUnits()>0) ) {
							errMsg.append("No. of Units can't be blank or 0 ");	
						} if(!(obj.getNoOfMonths()!=null && obj.getNoOfMonths()>0 && obj.getNoOfMonths()<=12)) {
							errMsg.append(" No. of Months must be (1-12) ");
						}
						if(!( obj.getFund()!=null && obj.getFund()>0) ) {
							errMsg.append("Funds  can't be blank or 0 ");
						}
						errMsg.append(" in "+getPMUActivityTypeName (obj.getPmuActivityType().getPmuActivityTypeId()));
						
					}
				}
				
			}else {
				if(obj.getFund()!=null ) {
					
					if(!( obj.getFund()!=null && obj.getFund()>0) ) {
						response.setResponseCode(500);
						errMsg.append("Funds  can't be blank or 0 ");
						errMsg.append(" in "+getPMUActivityTypeName (obj.getPmuActivityType().getPmuActivityTypeId()));
					}
					
					
				}
			}
			
		}
		
		if(response.getResponseCode()==500) {
			response.setResponseMessage(errMsg.toString());
		}
		return response;
		
	}
	
	
	private String getPMUActivityTypeName(Integer activityId)
	{
		String name="";
		switch(activityId) {
		case 1: name="Domain Experts";break;
		case 2: name="Administrative Staff";break;
		case 3: name="Other Expenditure";break;
		default:name="New Entity";break;
		}
		return name;
	}

}


