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
@NamedNativeQueries(
	{
		@NamedNativeQuery(query="select * from lgd.get_block_list_fn('D', :districtCode)",name="BLOCK_LIST_BY_DISTRICT_CODE",resultClass=Block.class),
		@NamedNativeQuery(query="select dlc as district_code,block_code, dlc as state_code,block_version,block_version as state_version,block_version as district_version,block_name_english, block_name_local from lgd.block where block_code=:blockCode and isactive",name="BLOCK_LIST_BY_BLOCK_CODE",resultClass=Block.class)
	}
)


public class Block implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6628927593760180317L;

	@Id
	@Column(name="block_code")
	int blockCode;
	
	@Column(name = "state_code")
	int stateCode;
	
	@Column(name = "state_version")
	int stateVersion;
	
	@Column(name = "district_code")
	int districtCode; 
	
	@Column(name = "district_version")
	int districtVersion;
	
	@Column(name = "block_version")
	int blockVersion;
	
	@Column(name = "block_name_english")
	String blockNameEnglish;
	
	@Column(name = "block_name_local")
	String blockNamelocal ;

	public int getBlockCode() {
		return blockCode;
	}

	public void setBlockCode(int blockCode) {
		this.blockCode = blockCode;
	}

	public int getStateCode() {
		return stateCode;
	}

	public void setStateCode(int stateCode) {
		this.stateCode = stateCode;
	}

	public int getStateVersion() {
		return stateVersion;
	}

	public void setStateVersion(int stateVersion) {
		this.stateVersion = stateVersion;
	}

	public int getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(int districtCode) {
		this.districtCode = districtCode;
	}

	public int getDistrictVersion() {
		return districtVersion;
	}

	public void setDistrictVersion(int districtVersion) {
		this.districtVersion = districtVersion;
	}

	public int getBlockVersion() {
		return blockVersion;
	}

	public void setBlockVersion(int blockVersion) {
		this.blockVersion = blockVersion;
	}

	public String getBlockNameEnglish() {
		return blockNameEnglish;
	}

	public void setBlockNameEnglish(String blockNameEnglish) {
		this.blockNameEnglish = blockNameEnglish;
	}

	public String getBlockNamelocal() {
		return blockNamelocal;
	}

	public void setBlockNamelocal(String blockNamelocal) {
		this.blockNamelocal = blockNamelocal;
	}

	
}

