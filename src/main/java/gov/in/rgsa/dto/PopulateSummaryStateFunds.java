package gov.in.rgsa.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;


	@Entity
	@NamedNativeQueries({
	@NamedNativeQuery(name="POPULATE_SUMMARY_STATE_FUNDS", query = " select * from rgsa.populate_summary_state_funds(:stateCode,:yearId,:componentIds)"),
	@NamedNativeQuery(name="POPULATE_SUMMARY_MINISTRY_FUNDS", query = " select * from rgsa.populate_summary_ministry_funds(:stateCode,:yearId,:componentIds)"),
	@NamedNativeQuery(name="POPULATE_SUMMARY_CEC_FUNDS", query = " select * from rgsa.populate_summary_state_funds(:stateCode,:yearId,:componentIds)") 
	})
	public class PopulateSummaryStateFunds {

		
		@Column(name="plan_code")
		private Integer planCode;
		
	     @Id
		@Column(name="plan_subcomponent_id")
		private Integer planSubcomponentId;
		
		@Column(name="state_proposed_funds")
		private Integer stateProposedFunds;
		
		
		@Column(name="state_proposed_units")
		private Integer stateProposedUnits;
		
		@Column(name="ministry_recomended_funds")
		private Integer ministryRecomendedFunds;
		
		@Column(name="cec_approved_funds")
		private Integer cecApprovedFunds;
		

		@Column(name="cec_approved_units")
		private Integer cecApprovedUnits;

		public Integer getStateProposedFunds() {
			return stateProposedFunds;
		}


		public void setStateProposedFunds(Integer stateProposedFunds) {
			this.stateProposedFunds = stateProposedFunds;
		}


		public Integer getStateProposedUnits() {
			return stateProposedUnits;
		}


		public void setStateProposedUnits(Integer stateProposedUnits) {
			this.stateProposedUnits = stateProposedUnits;
		}


		public Integer getMinistryRecomendedFunds() {
			return ministryRecomendedFunds;
		}


		public void setMinistryRecomendedFunds(Integer ministryRecomendedFunds) {
			this.ministryRecomendedFunds = ministryRecomendedFunds;
		}


		public Integer getCecApprovedFunds() {
			return cecApprovedFunds;
		}


		public void setCecApprovedFunds(Integer cecApprovedFunds) {
			this.cecApprovedFunds = cecApprovedFunds;
		}


		public Integer getCecApprovedUnits() {
			return cecApprovedUnits;
		}


		public void setCecApprovedUnits(Integer cecApprovedUnits) {
			this.cecApprovedUnits = cecApprovedUnits;
		}


		public Integer getPlanCode() {
			return planCode;
		}


		public void setPlanCode(Integer planCode) {
			this.planCode = planCode;
		}


		public Integer getPlanSubcomponentId() {
			return planSubcomponentId;
		}


		public void setPlanSubcomponentId(Integer planSubcomponentId) {
			this.planSubcomponentId = planSubcomponentId;
		}
		
		
}
