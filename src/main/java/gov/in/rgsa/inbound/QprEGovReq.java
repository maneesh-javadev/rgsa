package gov.in.rgsa.inbound;

import java.util.List;

public class QprEGovReq {
	Integer quarterId;
	String action;
	Integer egovSupportActivityId;
	Integer qprEGovId;
	Double addReqSpmu = 0.0;
	Double addReqDpmu = 0.0;
	Boolean isNew;

	List<Expenditure> expenditures;
	
	public static class Expenditure{
		
		private Integer egovSupportActivityDetailsId;
		private Integer qprEGovDetailsId;
		private Integer egovPostLevelId;
		private Integer egovPostId;
		private Integer postFilled;
		private Double incurred;
		
		public Integer getEgovSupportActivityDetailsId() {
			return egovSupportActivityDetailsId;
		}
		public void setEgovSupportActivityDetailsId(Integer egovSupportActivityDetailsId) {
			this.egovSupportActivityDetailsId = egovSupportActivityDetailsId;
		}
		public Integer getQprEGovDetailsId() {
			return qprEGovDetailsId;
		}
		public void setQprEGovDetailsId(Integer qprEGovDetailsId) {
			this.qprEGovDetailsId = qprEGovDetailsId;
		}
		public Integer getEgovPostLevelId() {
			return egovPostLevelId;
		}
		public void setEgovPostLevelId(Integer egovPostLevelId) {
			this.egovPostLevelId = egovPostLevelId;
		}
		public Integer getEgovPostId() {
			return egovPostId;
		}
		public void setEgovPostId(Integer egovPostId) {
			this.egovPostId = egovPostId;
		}
		public Integer getPostFilled() {
			return postFilled;
		}
		public void setPostFilled(Integer postFilled) {
			this.postFilled = postFilled;
		}
		public Double getIncurred() {
			return incurred;
		}
		public void setIncurred(Double incurred) {
			this.incurred = incurred;
		}
		
	}

	public Integer getQuarterId() {
		return quarterId;
	}

	public void setQuarterId(Integer quarterId) {
		this.quarterId = quarterId;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public Integer getEgovSupportActivityId() {
		return egovSupportActivityId;
	}

	public void setEgovSupportActivityId(Integer egovSupportActivityId) {
		this.egovSupportActivityId = egovSupportActivityId;
	}

	public Integer getQprEGovId() {
		return qprEGovId;
	}

	public void setQprEGovId(Integer qprEGovId) {
		this.qprEGovId = qprEGovId;
	}

	public Double getAddReqSpmu() {
		return addReqSpmu;
	}

	public void setAddReqSpmu(Double addReqSpmu) {
		this.addReqSpmu = addReqSpmu;
	}

	public Double getAddReqDpmu() {
		return addReqDpmu;
	}

	public void setAddReqDpmu(Double addReqDpmu) {
		this.addReqDpmu = addReqDpmu;
	}

	public Boolean getIsNew() {
		return isNew;
	}

	public void setIsNew(Boolean isNew) {
		this.isNew = isNew;
	}

	public List<Expenditure> getExpenditures() {
		return expenditures;
	}

	public void setExpenditures(List<Expenditure> expenditure) {
		this.expenditures = expenditure;
	}
	
	

}
