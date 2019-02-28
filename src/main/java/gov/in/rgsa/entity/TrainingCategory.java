package gov.in.rgsa.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/*import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
*/


@Entity
@Table(name="training_categories",schema="rgsa")
public class TrainingCategory implements Serializable{
	
		private static final long serialVersionUID = 1L;
		/*@GenericGenerator(name = "sequence", strategy = "sequence", parameters = { @Parameter(name = "sequence", value = "rgsa.training_categories_training_category_id_seq") })*/
		/*
		@GeneratedValue(generator = "sequence")*/
		@Id
		@Column(name="training_category_id")
		private Integer trainingCtgId;
		
		@Column(name ="training_category_name")
		private String trainingCatName;
		
		@Column(name ="created_by")
		private Integer createdBy;
		
		@Column(name ="state_code")
		private Integer stateCode;
		
		@Column(name ="fin_year")
		private Integer finYear;
		
		@Column(name ="is_active")
		private Boolean isActive;
		
		@Column(name ="created_on")
		private Date createdOn;
		
		@Column(name ="user_type")
		private String userType;

		public Integer getTrainingCtgId() {
			return trainingCtgId;
		}

		public void setTrainingCtgId(Integer trainingCtgId) {
			this.trainingCtgId = trainingCtgId;
		}

		public String getTrainingCatName() {
			return trainingCatName;
		}

		public void setTrainingCatName(String trainingCatName) {
			this.trainingCatName = trainingCatName;
		}

		public Integer getCreatedBy() {
			return createdBy;
		}

		public void setCreatedBy(Integer createdBy) {
			this.createdBy = createdBy;
		}

		public Integer getStateCode() {
			return stateCode;
		}

		public void setStateCode(Integer stateCode) {
			this.stateCode = stateCode;
		}

		public Integer getFinYear() {
			return finYear;
		}

		public void setFinYear(Integer finYear) {
			this.finYear = finYear;
		}

		public Boolean getIsActive() {
			return isActive;
		}

		public void setIsActive(Boolean isActive) {
			this.isActive = isActive;
		}

		public Date getCreatedOn() {
			return createdOn;
		}

		public void setCreatedOn(Date createdOn) {
			this.createdOn = createdOn;
		}

		public String getUserType() {
			return userType;
		}

		public void setUserType(String userType) {
			this.userType = userType;
		}

}
