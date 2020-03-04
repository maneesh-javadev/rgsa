package gov.in.rgsa.dto;

import java.util.List;

public class KpiReportDtoContainer {

    private String StateName;
    private Integer slc;
	private String noOfPostApproved;
	private String finYear;
	private Integer QdurCount;
	private List<KpiReportDto> kpiReportDto;
	
	public Integer getQdurCount() {
		return QdurCount;
	}
	public void setQdurCount(Integer qdurCount) {
		QdurCount = qdurCount;
	}
	public String getStateName() {
		return StateName;
	}
	public void setStateName(String stateName) {
		StateName = stateName;
	}
	public String getNoOfPostApproved() {
		return noOfPostApproved;
	}
	public void setNoOfPostApproved(String noOfPostApproved) {
		this.noOfPostApproved = noOfPostApproved;
	}
	public String getFinYear() {
		return finYear;
	}
	public void setFinYear(String finYear) {
		this.finYear = finYear;
	}
	public List<KpiReportDto> getKpiReportDto() {
		return kpiReportDto;
	}
	public void setKpiReportDto(List<KpiReportDto> kpiReportDto) {
		this.kpiReportDto = kpiReportDto;
	}
	public Integer getSlc() {
		return slc;
	}
	public void setSlc(Integer slc) {
		this.slc = slc;
	}
	

}
