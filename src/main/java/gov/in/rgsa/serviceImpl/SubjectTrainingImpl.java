package gov.in.rgsa.serviceImpl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.Subjects;
import gov.in.rgsa.entity.TrainingCategories;
import gov.in.rgsa.entity.TrainingCategory;
import gov.in.rgsa.model.SubjectTrainingModel;
import gov.in.rgsa.service.SubjectTrainingService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class SubjectTrainingImpl implements SubjectTrainingService {

	@Autowired
	public UserPreference user;

	@Autowired
	private CommonRepository dao;

	@Override
	public void save(SubjectTrainingModel model) {
		Subjects subjtrain = new Subjects();
		subjtrain.setSubjectName(model.getTrainingSubject());
		subjtrain.setCreatedBy(user.getUserId());
		subjtrain.setStateCode(user.getStateCode());
		subjtrain.setFinYearId(user.getFinYearId());
		TrainingCategories categories = new TrainingCategories();
		categories.setTrainingCategoryId(model.getTrainingCtgId());
		subjtrain.setTrainingCtgId(categories);
		subjtrain.setCreatedOn(new Date());
		subjtrain.setIsActive(true);
		dao.save(subjtrain);

	}

	@Override
	public List<TrainingCategory> findAllCategory() {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("active", true);
		return dao.findAll("FIND_All_TRAINING_CATEGORY", params);
	}

	@Override
	public List<Subjects> findSubjects(Integer finYearId) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("finYearId", finYearId);
		return dao.findAll("FIND_SUBJECT_BY_FIN_YEAR_ID", params);
	}

	@Override
	public Subjects findSubjectById(Integer subjectId) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("subjectId", subjectId);

		return dao.find("FIND_SUBJECT_ID", params);
	}

	@Override
	public void update(SubjectTrainingModel form) {

			Subjects subjtrain = new Subjects();
			subjtrain.setSubjectId(form.getSubjectId());
			subjtrain.setSubjectName(form.getTrainingSubject());
			subjtrain.setCreatedBy(user.getUserId());
			subjtrain.setStateCode(user.getStateCode());
			subjtrain.setFinYearId(user.getFinYearId());
		TrainingCategories categories = new TrainingCategories();
			categories.setTrainingCategoryId(form.getTrainingCtgId());
			subjtrain.setTrainingCtgId(categories);
			subjtrain.setCreatedOn(new Date());
			subjtrain.setIsActive(true);

		dao.update(subjtrain);

	}

	@Override
	public void delete(SubjectTrainingModel form) {
		Map<String, Object> param = new HashMap<>();
		param.put("subjectId", form.getSubjectId());
		dao.excuteUpdate("DELETE_BY_SUBJECT_ID", param);
		//dao.delete(Subjects.class, form.getSubjectId());

	}

}
