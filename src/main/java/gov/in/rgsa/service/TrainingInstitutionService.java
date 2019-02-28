package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.SchemeMaster;
import gov.in.rgsa.entity.TrainingInstitueActivityType;
import gov.in.rgsa.entity.TrainingInstitueType;
import gov.in.rgsa.entity.TrainingInstituteCarryForward;
import gov.in.rgsa.entity.TrainingInstituteCurrentStatus;

public interface TrainingInstitutionService {
	
	public List<TrainingInstitueActivityType> fetchTypesOfTrainingInstitue();
	
	public void saveTrainingInstituetionCF(TrainingInstituteCarryForward carryForward);
	
	public TrainingInstituteCarryForward getDetailsOfTrainingInstituetionCF();

	public List<TrainingInstitueType> fetchInstituteTypes(Integer selectedLevel);

	public List<SchemeMaster> fetchScheme();

	public void saveInfrastructureDetails(TrainingInstituteCurrentStatus trainingInstituteCurrentStatus);

	public TrainingInstituteCurrentStatus fetchTrainingInstituteDetails(final Integer locations, Integer level);

	public TrainingInstituteCurrentStatus fetchTrainingInstituteBasedOnFinYearAndStateCode();

	public void deleteTrainingInfrastructureDetails(Integer infractureDetailsObjToDelete);
	
	public List<TrainingInstitueType> getTrainingIsntituteType();

}
