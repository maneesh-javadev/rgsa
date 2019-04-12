package gov.in.rgsa.service;

import java.util.List;
import java.util.Map;

import gov.in.rgsa.entity.FetchTraining;
import gov.in.rgsa.entity.FetchTrainingDetails;
import gov.in.rgsa.entity.Subjects;
import gov.in.rgsa.entity.TargetGroupMaster;
import gov.in.rgsa.entity.TrainingActivity;
import gov.in.rgsa.entity.TrainingActivityDetails;
import gov.in.rgsa.entity.TrainingCategories;
import gov.in.rgsa.entity.TrainingMode;
import gov.in.rgsa.entity.TrainingVenueLevel;
import gov.in.rgsa.entity.TrainingWiseCategory;
import gov.in.rgsa.model.Response;

/**
 * @author Mohammad Ayaz 06/09/2018
 *
 */

public interface TrainingActivityService {

	public void save(TrainingActivity activity);
	
	public void update(TrainingActivity trainingActivity);
	
	public List<TrainingActivity> findAllTrainingActivity(final Character userType);
	
	public List<TrainingActivityDetails> findActivityById(int id);
	
	public void delete(int id);

	public List<TrainingActivity> findTrainingActivity();
	
	public void freezeUnfreeze(TrainingActivity trainingActivity);
	
	public List<TargetGroupMaster> targetGroupMastersList();
	
	public List<Subjects> subjectsList();
	
	public List<TrainingCategories> trainingCategoriesList();
	
	public List<TrainingVenueLevel> trainingVenueLevelsList();
	
	public List<TrainingActivity> getApprovedTrainingActivity();

	public void saveAndUpdateMopr(TrainingActivity trainingActivity);

	public List<TrainingMode> fetchModeOfTraining();


	public void saveAndUpdateCEC(TrainingActivity trainingActivity);
	
	public Map<String,Object> fetchTrainingDetails(final Character userType);
	
	public Map<String,Object> fetchTrainingDetailsbyId(Integer trngId);
	
	public Response saveorUpdateTrainingActivityDetails(FetchTrainingDetails fetchTrainingDetails);
	
	public List<Subjects> fetchSubjectsList(String strTrainingCategoryIds);
	
	public Response updateTrainingActivity(FetchTraining fetchTraining);
	
	public void deleteMultiple(List<Integer> deleteIds);
	
	public Map<String,Object> fetchTrainingDetailsMOPRCEC();
	
	public Response saveorUpdateTrainingActivityDetailsCECMOPR(FetchTraining FetchTraining);
	
	public List<TrainingWiseCategory> fetchTrainingWiseCategoryList(Integer trngId);
	
}
