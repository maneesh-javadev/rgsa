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
	
	@Autowired
	private ProgressReportServiceImpl  progressReportServiceImpl;

	

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
		}else{
			return null;
		}
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
		
		satcomActivityProgress.setCreatedBy(userPreference.getUserId());
		satcomActivityProgress.setLastUpdatedBy(userPreference.getUserId());
		List<SatcomActivityProgressDetails> satcomActivityProgressDetails = satcomActivityProgress.getSatcomActivityProgressDetails();
		if (satcomActivityProgress.getSatcomActivityProgressId() == null) {
			for (SatcomActivityProgressDetails Details : satcomActivityProgressDetails) {
				if (satcomActivityProgressDetails != null) {
					Details.setSatcomActivityProgress(satcomActivityProgress);
					Details.setQuarterDuration(satcomActivityProgressDetails.get(0).getQuarterDuration());
				}

			}
			commonRepository.save(satcomActivityProgress);
		} else {
			for (SatcomActivityProgressDetails Details : satcomActivityProgressDetails) {
				if (satcomActivityProgressDetails != null) {
					Details.setSatcomActivityProgress(satcomActivityProgress);
					Details.setQuarterDuration(satcomActivityProgressDetails.get(0).getQuarterDuration());
				}
			}
			commonRepository.update(satcomActivityProgress);
		}
		/* this method is to insert and update record in quater_wise_fund table*/
		progressReportServiceImpl.saveQprWiseFundData(userPreference.getStateCode(),userPreference.getFinYearId(),satcomActivityProgressDetails.get(0).getQuarterDuration().getQtrId(),7);
	}


	@Override
	public List<SatcomActivityProgressDetails> getDetailsBasedOnActIdAndQtrId(Integer satcomActivityProgressId,int quarterId) {
		Map<String, Object> params = new HashMap();
		params.put("satcomActivityProgressId", satcomActivityProgressId);
		params.put("quarterId", quarterId);	
		return commonRepository.findAll("FETCH_DETAILS_BY_QTR_ID_AND_ACT_ID", params);
	}
}
	
	

