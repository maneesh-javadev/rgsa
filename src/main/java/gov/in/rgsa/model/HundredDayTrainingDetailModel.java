package gov.in.rgsa.model;

public class HundredDayTrainingDetailModel {

	private Long id;
	
	private Integer noOfParticipantsSC;
	
	private Integer noOfParticipantsST;
	
	private Integer noOfParticipantsWomen;
	
	private Integer noOfParticipantsOthers;
	
	private Integer noOfTrainingsConducted;
	
	private Boolean isFreeze;
	
	private String msg;
	
	public Integer getNoOfParticipantsSC() {
		return noOfParticipantsSC;
	}

	public void setNoOfParticipantsSC(Integer noOfParticipantsSC) {
		this.noOfParticipantsSC = noOfParticipantsSC;
	}

	public Integer getNoOfParticipantsST() {
		return noOfParticipantsST;
	}

	public void setNoOfParticipantsST(Integer noOfParticipantsST) {
		this.noOfParticipantsST = noOfParticipantsST;
	}

	public Integer getNoOfParticipantsWomen() {
		return noOfParticipantsWomen;
	}

	public void setNoOfParticipantsWomen(Integer noOfParticipantsWomen) {
		this.noOfParticipantsWomen = noOfParticipantsWomen;
	}

	public Integer getNoOfParticipantsOthers() {
		return noOfParticipantsOthers;
	}

	public void setNoOfParticipantsOthers(Integer noOfParticipantsOthers) {
		this.noOfParticipantsOthers = noOfParticipantsOthers;
	}

	public Integer getNoOfTrainingsConducted() {
		return noOfTrainingsConducted;
	}

	public void setNoOfTrainingsConducted(Integer noOfTrainingsConducted) {
		this.noOfTrainingsConducted = noOfTrainingsConducted;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

}
