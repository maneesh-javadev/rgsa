package gov.in.rgsa.dto;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;

import org.hibernate.annotations.CreationTimestamp;



@Entity
@NamedNativeQueries({ 
	@NamedNativeQuery(name = "FETCH_KPI_RECORD_YEARWISE", query = "select row_number() OVER () as id,s.state_name_english, td.* "
	+ "from rgsa.darpantable td inner join lgd.state s on td.state_code=s.state_code and s.isactive where yr=:yr and mnth between 4 and 9 "
	+ "order by s.state_name_english", resultClass = KpiWebServiceDTO.class),
	@NamedNativeQuery(name = "FETCH_KPI_RECORD_INSTALLMENTWISE", query = "select row_number() OVER () as id,s.state_name_english,td.* from "
	+ "rgsa.darpantable td inner join lgd.state s on td.state_code=s.state_code and s.isactive where yr=:yr and mnth>9 or yr=:yr+1 and mnth <=3"
	+ " order by s.state_name_english", resultClass = KpiWebServiceDTO.class)

})

public class KpiWebServiceDTO {
   @Id
   @Column(name="id")
   private Integer id;
	
	@Column(name="mcode")
	private Integer mCode;
	
	@Column(name="state_name_english")
	private String stateNameEnglish;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="district_code")
	private Integer districtCode;
	
	@Column(name="teh_code")
	private Integer tehCode;
	
	@Column(name="blk_code")
	private Integer blkCode;
	
	@Column(name="sector_code")
	private Integer sectorCode;
	
	@Column(name="gp_code")
	private Integer gpCode;
	
	@Column(name="vill_code")
	private Integer villCode;
	
	@Column(name="dept_code")
	private Integer deptCode;
	
	@Column(name="project_code")
	private Integer projectCode;
	
	@Column(name="cnt1")
	private Long cnt1;
	
	@Column(name="cnt2")
	private Long cnt2;
	
	@Column(name="cnt3")
	private Long cnt3;
	
	@Column(name="cnt4")
	private Long cnt4;
	
	@Column(name="cnt5")
	private Long cnt5;
	
	@Column(name="dataportmode")
	private Integer dataportMode;
	
	@Column(name="modedesc")
	private Integer modeDesc;
	
	@Column(name="data_lvl_code")
	private Integer dataLvlCode;
	
	@Column(name="yr")
	private Integer yr;
	
	@Column(name="mnth")
	private Integer mnth;
	
	@CreationTimestamp
	@Column(name="datadt",updatable=false)
	private Timestamp dataDt;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getmCode() {
		return mCode;
	}

	public void setmCode(Integer mCode) {
		this.mCode = mCode;
	}

	
	public String getStateNameEnglish() {
		return stateNameEnglish;
	}

	public void setStateNameEnglish(String stateNameEnglish) {
		this.stateNameEnglish = stateNameEnglish;
	}

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public Integer getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(Integer districtCode) {
		this.districtCode = districtCode;
	}

	public Integer getTehCode() {
		return tehCode;
	}

	public void setTehCode(Integer tehCode) {
		this.tehCode = tehCode;
	}

	public Integer getBlkCode() {
		return blkCode;
	}

	public void setBlkCode(Integer blkCode) {
		this.blkCode = blkCode;
	}

	public Integer getSectorCode() {
		return sectorCode;
	}

	public void setSectorCode(Integer sectorCode) {
		this.sectorCode = sectorCode;
	}

	public Integer getGpCode() {
		return gpCode;
	}

	public void setGpCode(Integer gpCode) {
		this.gpCode = gpCode;
	}

	public Integer getVillCode() {
		return villCode;
	}

	public void setVillCode(Integer villCode) {
		this.villCode = villCode;
	}

	public Integer getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(Integer deptCode) {
		this.deptCode = deptCode;
	}

	public Integer getProjectCode() {
		return projectCode;
	}

	public void setProjectCode(Integer projectCode) {
		this.projectCode = projectCode;
	}

	public Long getCnt1() {
		return cnt1;
	}

	public void setCnt1(Long cnt1) {
		this.cnt1 = cnt1;
	}

	public Long getCnt2() {
		return cnt2;
	}

	public void setCnt2(Long cnt2) {
		this.cnt2 = cnt2;
	}

	public Long getCnt3() {
		return cnt3;
	}

	public void setCnt3(Long cnt3) {
		this.cnt3 = cnt3;
	}

	public Long getCnt4() {
		return cnt4;
	}

	public void setCnt4(Long cnt4) {
		this.cnt4 = cnt4;
	}

	public Long getCnt5() {
		return cnt5;
	}

	public void setCnt5(Long cnt5) {
		this.cnt5 = cnt5;
	}

	public Integer getDataportMode() {
		return dataportMode;
	}

	public void setDataportMode(Integer dataportMode) {
		this.dataportMode = dataportMode;
	}

	public Integer getModeDesc() {
		return modeDesc;
	}

	public void setModeDesc(Integer modeDesc) {
		this.modeDesc = modeDesc;
	}

	public Integer getDataLvlCode() {
		return dataLvlCode;
	}

	public void setDataLvlCode(Integer dataLvlCode) {
		this.dataLvlCode = dataLvlCode;
	}

	
	public Integer getYr() {
		return yr;
	}

	public void setYr(Integer yr) {
		this.yr = yr;
	}

	

	public Integer getMnth() {
		return mnth;
	}

	public void setMnth(Integer mnth) {
		this.mnth = mnth;
	}

	public Timestamp getDataDt() {
		return dataDt;
	}

	public void setDataDt(Timestamp dataDt) {
		this.dataDt = dataDt;
	}
	
	
	
}
