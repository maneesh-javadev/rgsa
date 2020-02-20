package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.entity.QuarterDuration;
import gov.in.rgsa.entity.State;

public interface OtherAchievementsDetailService {
	
	public List<FinYear> fetchFinYearList();

	public List<State> fetchStateList();

	public List<QuarterDuration> fetchQuarterList();
	
	
    public String basicOrientationTrainingofER(Integer trCategory);
    
    public String enablementsOfPanchat(Integer levelId);
    
    public String enablementsOfPanchyatComputerization(Integer trCategory);
    
    public String exposureVisit(Integer cbMasterId);
    
    public String supportForPanchayatAsset(String bhawanStatus,String activityId);
    
    public String panchyatStakehlderTrained();
    
    public List fetchQprEenablementProgressReport( );

}
