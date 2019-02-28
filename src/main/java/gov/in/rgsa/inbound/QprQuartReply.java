package gov.in.rgsa.inbound;

import java.util.List;
import java.util.Map;


public class QprQuartReply {
	Integer quarterId;
	String action;
	Integer pesaPlanId;
	Integer qprPesaId;
	Double additionalRequirement = 0.0;
	Boolean isDirty = false;
	List<Expenditure> expenditure;
	
	public static class Expenditure{
		Integer designationId;
		Double expenditure;
		Integer qprPesaDetailsId;
		Integer unitCompleted;
		Integer pesaPlanDetailsId;
		
		public Integer getPlanDetailsId() {
			return pesaPlanDetailsId;
		}
		public void setPesaPlanDetailsId(Integer pesaPlanDetailsId) {
			this.pesaPlanDetailsId = pesaPlanDetailsId;
		}
		public Integer getDesignationId() {
			return designationId;
		}
		public void setDesignationId(Integer designationId) {
			this.designationId = designationId;
		}
		public Double getExpenditure() {
			return expenditure;
		}
		public void setExpenditure(Double expenditure) {
			this.expenditure = expenditure;
		}
		public Integer getQprPesaDetailsId() {
			return qprPesaDetailsId;
		}
		public void setQprPesaDetailsId(Integer qprPesaDetailsId) {
			this.qprPesaDetailsId = qprPesaDetailsId;
		}
		public Integer getUnitCompleted() {
			return unitCompleted;
		}
		public void setUnitCompleted(Integer unitCompleted) {
			this.unitCompleted = unitCompleted;
		}
		
	}
	
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public Integer getPesaPlanId() {
		return pesaPlanId;
	}
	public void setPesaPlanId(Integer pesaPlanId) {
		this.pesaPlanId = pesaPlanId;
	}
	public Integer getQprPesaId() {
		return qprPesaId;
	}
	public void setQprPesaId(Integer qprPesaId) {
		this.qprPesaId = qprPesaId;
	}
	public Double getAdditionalRequirement() {
		return additionalRequirement;
	}
	public void setAdditionalRequirement(Double additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}
	public List<Expenditure> getExpenditure() {
		return expenditure;
	}
	public void setExpenditure(List<Expenditure> expenditure) {
		this.expenditure = expenditure;
	}
	public Boolean getIsDirty() {
		return isDirty;
	}
	public void setIsDirty(Boolean isDirty) {
		this.isDirty = isDirty;
	}
	public Integer getQuarterId() {
		return quarterId;
	}
	public void setQuarterId(Integer quarterId) {
		this.quarterId = quarterId;
	}
	
	
}
