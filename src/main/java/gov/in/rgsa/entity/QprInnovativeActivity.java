package gov.in.rgsa.entity;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;


	
	
	@Entity
	@Table(name= "qpr_ia" , schema="rgsa")
	@NamedQueries ({@NamedQuery(name="FETCH_INNOVATIVE_REPORT_DETAILS", query="Select IA from QprInnovativeActivity IA RIGHT OUTER JOIN FETCH IA.qprInnovativeActivityDetails IQA where IA.innovativeActivity.innovativeActivityId=:innovativeActivityId AND IA.quarterDuration.qtrId=:qtrId "),
	@NamedQuery(name="FETCH_INNOVATIVE__REPORT_BASED_ID", query="Select IA from QprInnovativeActivity IA where IA.innovativeActivity.innovativeActivityId=:innovativeActivityId")
	})
	public class QprInnovativeActivity {


		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		@Column(name="qpr_ia_id")
		private Integer qprIaId;
				
		@ManyToOne(fetch=FetchType.LAZY)
		@JoinColumn(name="innovative_activity_id")
		private InnovativeActivity innovativeActivity;

		
		@ManyToOne(fetch=FetchType.LAZY)
		@JoinColumn(name="qtr_id")
		private QuarterDuration quarterDuration;
		
		@OneToMany(cascade=CascadeType.ALL,mappedBy="qprInnovativeActivity",fetch=FetchType.EAGER)
		private List<QprInnovativeActivityDetails> qprInnovativeActivityDetails;

		@Column(name="created_by")
		private Integer createdBy;
			
		@Column(name="menu_id")
		private Integer menuId;
			
		
		@Column(name="created_on",updatable=false)
		@CreationTimestamp
		private Timestamp createdOn;
		
		@Column(name="last_updated_by")
		private Integer lastUpdatedBy;
			
		@Column(name="last_updated_on")
		@UpdateTimestamp
		private Timestamp lastUpdatedOn;
		
		@Transient
		private Integer qtrId;
		
		@Column(name="additional_requirement")
		private Integer additioinalRequirements;
		
		@Transient
		private String origin;
		
		@Column(name="is_freeze")
		private Boolean isFreeze;

		public Integer getQprIaId() {
			return qprIaId;
		}


		public void setQprIaId(Integer qprIaId) {
			this.qprIaId = qprIaId;
		}


		public InnovativeActivity getInnovativeActivity() {
			return innovativeActivity;
		}


		public void setInnovativeActivity(InnovativeActivity innovativeActivity) {
			this.innovativeActivity = innovativeActivity;
		}


		public QuarterDuration getQuarterDuration() {
			return quarterDuration;
		}


		public void setQuarterDuration(QuarterDuration quarterDuration) {
			this.quarterDuration = quarterDuration;
		}


		public List<QprInnovativeActivityDetails> getQprInnovativeActivityDetails() {
			return qprInnovativeActivityDetails;
		}


		public void setQprInnovativeActivityDetails(List<QprInnovativeActivityDetails> qprInnovativeActivityDetails) {
			this.qprInnovativeActivityDetails = qprInnovativeActivityDetails;
		}


		public Integer getCreatedBy() {
			return createdBy;
		}


		public void setCreatedBy(Integer createdBy) {
			this.createdBy = createdBy;
		}


		public Integer getMenuId() {
			return menuId;
		}


		public void setMenuId(Integer menuId) {
			this.menuId = menuId;
		}


		public Timestamp getCreatedOn() {
			return createdOn;
		}


		public void setCreatedOn(Timestamp createdOn) {
			this.createdOn = createdOn;
		}


		public Integer getLastUpdatedBy() {
			return lastUpdatedBy;
		}


		public void setLastUpdatedBy(Integer lastUpdatedBy) {
			this.lastUpdatedBy = lastUpdatedBy;
		}


		public Timestamp getLastUpdatedOn() {
			return lastUpdatedOn;
		}


		public void setLastUpdatedOn(Timestamp lastUpdatedOn) {
			this.lastUpdatedOn = lastUpdatedOn;
		}


		public Integer getQtrId() {
			return qtrId;
		}


		public void setQtrId(Integer qtrId) {
			this.qtrId = qtrId;
		}


		public Boolean getIsFreeze() {
			return isFreeze;
		}


		public void setIsFreeze(Boolean isFreeze) {
			this.isFreeze = isFreeze;
		}


		public Integer getAdditioinalRequirements() {
			return additioinalRequirements;
		}


		public void setAdditioinalRequirements(Integer additioinalRequirements) {
			this.additioinalRequirements = additioinalRequirements;
		}


		public String getOrigin() {
			return origin;
		}


		public void setOrigin(String origin) {
			this.origin = origin;
		}

		
}
