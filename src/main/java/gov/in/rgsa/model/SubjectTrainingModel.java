package gov.in.rgsa.model;

public class SubjectTrainingModel {

	private Integer trainingCtgId;
	private String parentCategory;
	private String trainingSubject;
	private Integer subjectId;

	public String getParentCategory() {
		return parentCategory;
	}

	public void setParentCategory(String parentCategory) {
		this.parentCategory = parentCategory;
	}

	public String getTrainingSubject() {
		return trainingSubject;
	}

	public void setTrainingSubject(String trainingSubject) {
		this.trainingSubject = trainingSubject;
	}

	public Integer getTrainingCtgId() {
		return trainingCtgId;
	}

	public void setTrainingCtgId(Integer trainingCtgId) {
		this.trainingCtgId = trainingCtgId;
	}

	public Integer getSubjectId() {
		return subjectId;
	}

	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
	}

}
