package gov.in.rgsa.serviceImpl;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.CategoriesOfParticipant;
import gov.in.rgsa.entity.SatcomActivityProgress;
import gov.in.rgsa.entity.SatcomActivityProgressDetails;
import gov.in.rgsa.entity.TrainingDetailsProgressReport;
import gov.in.rgsa.entity.TrainingProgressReport;
import gov.in.rgsa.service.SatcomActivityProgressService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class SatcomActivityProgressServiceImpl implements SatcomActivityProgressService{

	@Autowired 
	CommonRepository commonRepository;
	
	@Autowired
	UserPreference userPreference;

	

	@Override
	public List<SatcomActivityProgress> fetchSatcomProgress() {
		Map<String, Object> params = new HashMap<String, Object>();
		List<SatcomActivityProgress> satcomActivityProgress = new ArrayList<>()	;
		params.put("qtrId", satcomActivityProgress.get(0).getSatcomActivityProgressDetails().get(0).getQuarterDuration().getQtrId());
		satcomActivityProgress =commonRepository.findAll("FETCH_SATCOM_progress_report_BASED_ID", params);
		
		return satcomActivityProgress;
	}
	
	
	@Override
	public SatcomActivityProgress getSatcomProgress(int satcomActivityId, int quarterId) {
		Map<String, Object> params = new HashMap();
		
		params.put("satcomActivityId", satcomActivityId);
		params.put("qtrId", quarterId);
		List<SatcomActivityProgress> satcomActivityProgress =commonRepository.findAll("FETCH_SATCOM_progress_report_DETAILS", params);
		if(!satcomActivityProgress.isEmpty() && satcomActivityProgress.get(0) != null) {
			return satcomActivityProgress.get(0);
		}else
		return null;
	
	}
	

	
	@Override
	public SatcomActivityProgress getSatcomProgressReportToGeReportId(int satcomActivityId) {
		Map<String, Object> params = new HashMap();
		params.put("satcomActivityId", satcomActivityId);
		List<SatcomActivityProgress> satcomActivityProgress =commonRepository.findAll("FETCH_SATCOM_progress_report_BASED_ID", params);
		if(!satcomActivityProgress.isEmpty() && satcomActivityProgress.get(0) != null) {
			return satcomActivityProgress.get(0);
		}else
		return null;
	}
		
	@Override
	public void savesatcomProgress(SatcomActivityProgress satcomActivityProgress) {
		
		if(satcomActivityProgress.getSatcomActivityProgressId() == null) {
		List<SatcomActivityProgressDetails> satcomActivityProgressDetails = satcomActivityProgress.getSatcomActivityProgressDetails();
		  satcomActivityProgress.setLastUpdatedBy(userPreference.getUserId());
	        satcomActivityProgress.setCreatedBy(userPreference.getUserId());
	
		
		for (SatcomActivityProgressDetails Details : satcomActivityProgressDetails) {
			if(satcomActivityProgressDetails != null)
			{
								Details.setSatcomActivityProgress(satcomActivityProgress);
								Details.setQuarterDuration(satcomActivityProgressDetails.get(0).getQuarterDuration());
										}
			
		}	
		commonRepository.save(satcomActivityProgress);
		}
		else
		{
			List<SatcomActivityProgressDetails> satcomActivityProgressDetails = satcomActivityProgress.getSatcomActivityProgressDetails();

			for (SatcomActivityProgressDetails Details : satcomActivityProgressDetails) {
				if(satcomActivityProgressDetails != null)
				{
					
					Details.setSatcomActivityProgress(satcomActivityProgress);
					Details.setQuarterDuration(satcomActivityProgressDetails.get(0).getQuarterDuration());
					
				}
				
			}	
			commonRepository.update(satcomActivityProgress);
		}
	
	
	}
}
	
	

