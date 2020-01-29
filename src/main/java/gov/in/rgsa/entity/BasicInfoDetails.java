package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="basic_info_details",schema="rgsa")
@NamedQuery(name="DELETE_BASICINFO_DETAILS",query="delete from BasicInfoDetails where basicInfo.basicInfoId=:basicInfoId")
@NamedNativeQueries({
@NamedNativeQuery(query="SELECT * from rgsa.basic_info_details where basic_info_id in (select basic_info_id from rgsa.basic_info where state_code =:stateCode and year_id=:yearId) and defination_key = '27_bp'",name="PANCHAYAT_WITHOUT_BHAWAN",resultClass=BasicInfoDetails.class),
@NamedNativeQuery(query="SELECT defination_value from rgsa.basic_info_details where basic_info_id in (select basic_info_id from rgsa.basic_info where state_code =:stateCode and year_id=:yearId ) and defination_key = :defination_key",name="BASIC_INFO_KEY_VALUE")
})
public class BasicInfoDetails implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6687379864015096025L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "basic_info_details_id",updatable = false, nullable = false)
	private Integer basicInfoDetailsId;
	
	@ManyToOne
	@JoinColumn(name = "basic_info_id",referencedColumnName="basic_info_id")
	private BasicInfo basicInfo;
	
	@Column(name="defination_key")
	private String definationKey;
	
	@Column(name="defination_value")
	private String definationValue;
    
	public Integer getBasicInfoDetailsId() {
		return basicInfoDetailsId;
	}

	public void setBasicInfoDetailsId(Integer basicInfoDetailsId) {
		this.basicInfoDetailsId = basicInfoDetailsId;
	}

	public BasicInfo getBasicInfo() {
		return basicInfo;
	}

	public void setBasicInfo(BasicInfo basicInfo) {
		this.basicInfo = basicInfo;
	}

	public String getDefinationKey() {
		return definationKey;
	}

	public void setDefinationKey(String definationKey) {
		this.definationKey = definationKey;
	}

	public String getDefinationValue() {
		return definationValue;
	}

	public void setDefinationValue(String definationValue) {
		this.definationValue = definationValue;
	}
	
}
