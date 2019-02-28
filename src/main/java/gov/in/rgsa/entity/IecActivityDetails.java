package gov.in.rgsa.entity;

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
import javax.persistence.Table;


	@Entity
	@Table(name="iec_activity_details", schema = "rgsa")
	@NamedQueries({
		@NamedQuery(name = "FIND_IEC_ID", query = "SELECT C FROM IecActivityDropedown C  "),
		@NamedQuery(name="FETCH_Iec_Activity_BY_ID",query="Delete FROM IecActivityDetails where idMain=:idMain")
		/*@NamedQuery(name="FETCH_Iec_DETAILS",query="SELECT IAD FROM IecActivityDetails IAD where idMain=:idMain")*/
})
                   
	public class IecActivityDetails {
		
		@Id
		@GeneratedValue(strategy=GenerationType.IDENTITY)
		@Column(name="id_main")
		private Integer idMain;
		
		@JoinColumn(name="id",referencedColumnName="id")
		@ManyToOne
		private IecActivity iecActivity;
		
		@Column(name="Total_Amount_Proposed")
		private Integer TotalAmountProposed;
		
		@ManyToOne(fetch=FetchType.LAZY)
		@JoinColumn(name="iec_id")
		private IecActivityDropedown iecActivityDropedown;
		
		@Column(name="remarks")
		private String remarks;
		
		@Column(name="is_approved")
		private Boolean isApproved;

		@Column(name="is_active")
		private Boolean isActive;
		
		public Integer getIdMain() {
			return idMain;
		}

		public void setIdMain(Integer idMain) {
			this.idMain = idMain;
		}

		public Integer getTotalAmountProposed() {
			return TotalAmountProposed;
		}

		public void setTotalAmountProposed(Integer totalAmountProposed) {
			TotalAmountProposed = totalAmountProposed;
		}

		public IecActivity getIecActivity() {
			return iecActivity;
		}

		public void setIecActivity(IecActivity iecActivity) {
			this.iecActivity = iecActivity;
		}

		public IecActivityDropedown getIecActivityDropedown() {
			return iecActivityDropedown;
		}

		public void setIecActivityDropedown(IecActivityDropedown iecActivityDropedown) {
			this.iecActivityDropedown = iecActivityDropedown;
		}

		public String getRemarks() {
			return remarks;
		}

		public void setRemarks(String remarks) {
			this.remarks = remarks;
		}

		public Boolean getIsApproved() {
			return isApproved;
		}

		public void setIsApproved(Boolean isApproved) {
			this.isApproved = isApproved;
		}

		public Boolean getIsActive() {
			return isActive;
		}

		public void setIsActive(Boolean isActive) {
			this.isActive = isActive;
		}
		
		
		
	}

	

