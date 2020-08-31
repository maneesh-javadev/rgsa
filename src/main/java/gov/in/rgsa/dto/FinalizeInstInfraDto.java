package gov.in.rgsa.dto;

public class FinalizeInstInfraDto {

	private Integer instId;
	private Integer instDtlsId;
	private int workLocation;
	private Character workType;
	private Integer activityId;
	private int count;
		
	public FinalizeInstInfraDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Integer getInstId() {
		return instId;
	}
	public void setInstId(Integer instId) {
		this.instId = instId;
	}
	public Integer getInstDtlsId() {
		return instDtlsId;
	}
	public void setInstDtlsId(Integer instDtlsId) {
		this.instDtlsId = instDtlsId;
	}
	public int getWorkLocation() {
		return workLocation;
	}
	public void setWorkLocation(int workLocation) {
		this.workLocation = workLocation;
	}
	public Character getWorkType() {
		return workType;
	}
	public void setWorkType(Character workType) {
		this.workType = workType;
	}
	public Integer getActivityId() {
		return activityId;
	}
	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
}
