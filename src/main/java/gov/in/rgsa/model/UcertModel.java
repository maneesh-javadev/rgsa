package gov.in.rgsa.model;

import java.util.Map;

public class UcertModel {
	Map <Integer, String> yearMap;
	Map <Integer, String> installmentMap;
	Integer selectedYear = 0;
	Integer selectedInstallment = 0;
	Boolean hasDownload = false;
	Boolean hasUpload = false;
	boolean processed = false;
	
	public Map<Integer, String> getYearMap() {
		return yearMap;
	}
	public void setYearMap(Map<Integer, String> yearMap) {
		this.yearMap = yearMap;
	}
	public Map<Integer, String> getInstallmentMap() {
		return installmentMap;
	}
	public void setInstallmentMap(Map<Integer, String> installmentMap) {
		this.installmentMap = installmentMap;
	}
	public Integer getSelectedYear() {
		return selectedYear;
	}
	public void setSelectedYear(Integer selectedYear) {
		this.selectedYear = selectedYear;
	}
	public Integer getSelectedInstallment() {
		return selectedInstallment;
	}
	public void setSelectedInstallment(Integer selectedInstallment) {
		this.selectedInstallment = selectedInstallment;
	}
	
	public Boolean getHasDownload() {
		return hasDownload;
	}
	public void setHasDownload(Boolean hasDownload) {
		this.hasDownload = hasDownload;
	}
	public Boolean getHasUpload() {
		return hasUpload;
	}
	public void setHasUpload(Boolean hasUpload) {
		this.hasUpload = hasUpload;
	}
	public boolean isProcessed() {
		return processed;
	}
	public void setProcessed(boolean processed) {
		this.processed = processed;
	}
}
