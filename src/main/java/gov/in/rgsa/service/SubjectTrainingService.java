package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.Subjects;
import gov.in.rgsa.entity.TrainingCategory;
import gov.in.rgsa.model.SubjectTrainingModel;
public interface SubjectTrainingService {
	
public void save(SubjectTrainingModel model);

public List<TrainingCategory> findAllCategory();

public List<Subjects> findSubjects(Integer finYearId);

public Subjects findSubjectById(Integer subjectId);

public void update(SubjectTrainingModel form);

public void delete(SubjectTrainingModel form);





}
