package gov.in.rgsa.entity;
import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Table;

@Entity
@Table(schema = "lgd")
@NamedNativeQueries(value = {
@NamedNativeQuery(query="select local_body_code,local_body_version,local_body_name_english,local_body_name_local,state_code,local_body_type_code,local_body_type_name,category,level from lgd.get_lb_details(:lbCode)",name="localbodydetailscode",resultClass=LocalBodyDetails.class),
@NamedNativeQuery(query="select local_body_code,local_body_version,local_body_name_english,local_body_name_local,state_code,local_body_type_code,local_body_type_name,category,level from lgd.get_lb_details(:lbCode) where category like :category",name="localbodydetailscodecategory",resultClass=LocalBodyDetails.class),
@NamedNativeQuery(query="select local_body_code,local_body_version,local_body_name_english,local_body_name_local,state_code,local_body_type_code,local_body_type_name,category,level from lgd.view_all_lb_details where local_body_code in(:localBodyCodeList)",name="getLocalBodyDetailsList",resultClass=LocalBodyDetails.class),
@NamedNativeQuery(query="select local_body_code,local_body_version,local_body_name_english,local_body_name_local,state_code,local_body_type_code,local_body_type_name,category,level from lgd.view_all_lb_details where local_body_code in(:localBodyCodeList) and category ilike :category and local_body_name_english ilike :name order by local_body_name_english ",name="searchLocalBody",resultClass=LocalBodyDetails.class)
})


public class LocalBodyDetails implements Serializable{

	private static final long serialVersionUID = 1L;

	public LocalBodyDetails() {	super();}

	public LocalBodyDetails(int localBodyCode, int localBodyVersion,
			String localBodyNameEnglish, String localBodyNameLocal,
			int parentLocalBodyCode, int stateCode, int localBodyCodeTypeCode,
			String localBodyTypeName, String localBodyTypeNameCategory) {
		super();
		this.localBodyCode = localBodyCode;
		this.localBodyVersion = localBodyVersion;
		this.localBodyNameEnglish = localBodyNameEnglish;
		this.localBodyNameLocal = localBodyNameLocal;
		this.stateCode = stateCode;
		this.localBodyCodeTypeCode = localBodyCodeTypeCode;
		this.localBodyTypeName = localBodyTypeName;
		this.localBodyTypeNameCategory = localBodyTypeNameCategory;
	}

	@Id
	@Column(name = "local_body_code")
	int localBodyCode;
	
	@Column(name = "local_body_version")
	int localBodyVersion;

	@Column(name = "local_body_name_english")
	String localBodyNameEnglish;
	
	@Column(name = "local_body_name_local",nullable=true)
	String localBodyNameLocal ;
	
	@Column(name = "state_code")
	int stateCode;
	
	@Column(name = "local_body_type_code")
	int localBodyCodeTypeCode;
	
	@Column(name = "local_body_type_name")
	String localBodyTypeName;
	
	
	@Column(name = "category")
	String localBodyTypeNameCategory;
	
	@Column(name = "level")
	private String level;
	
	public int getLocalBodyCode() {
		return localBodyCode;
	}

	public void setLocalBodyCode(int localBodyCode) {
		this.localBodyCode = localBodyCode;
	}

	public int getLocalBodyVersion() {
		return localBodyVersion;
	}

	public void setLocalBodyVersion(int localBodyVersion) {
		this.localBodyVersion = localBodyVersion;
	}

	public String getLocalBodyNameEnglish() {
		return localBodyNameEnglish;
	}

	public void setLocalBodyNameEnglish(String localBodyNameEnglish) {
		this.localBodyNameEnglish = localBodyNameEnglish;
	}

	public String getLocalBodyNameLocal() {
		return localBodyNameLocal;
	}

	public void setLocalBodyNameLocal(String localBodyNameLocal) {
		this.localBodyNameLocal = localBodyNameLocal;
	}
	public int getStateCode() {
		return stateCode;
	}

	public void setStateCode(int stateCode) {
		this.stateCode = stateCode;
	}

	public int getLocalBodyCodeTypeCode() {
		return localBodyCodeTypeCode;
	}

	public void setLocalBodyCodeTypeCode(int localBodyCodeTypeCode) {
		this.localBodyCodeTypeCode = localBodyCodeTypeCode;
	}

	public String getLocalBodyTypeName() {
		return localBodyTypeName;
	}

	public void setLocalBodyTypeName(String localBodyTypeName) {
		this.localBodyTypeName = localBodyTypeName;
	}

	public String getLocalBodyTypeNameCategory() {
		return localBodyTypeNameCategory;
	}

	public void setLocalBodyTypeNameCategory(String localBodyTypeNameCategory) {
		this.localBodyTypeNameCategory = localBodyTypeNameCategory;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}
	
}

