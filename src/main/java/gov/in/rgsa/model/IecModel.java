package gov.in.rgsa.model;

import gov.in.rgsa.entity.IecActivity;

public class IecModel {
	
	private String dbFileName;
	private IecActivity iecActivity;
	private String idToDeleteStr;
	

	public IecActivity getIecActivity() {
		return iecActivity;
	}

	public void setIecActivity(IecActivity iecActivity) {
		this.iecActivity = iecActivity;
	}

	public String getDbFileName() {
		return dbFileName;
	}

	public void setDbFileName(String dbFileName) {
		this.dbFileName = dbFileName;
	}

	public void put(String string, Integer iecId) {
		// TODO Auto-generated method stub
		
	}

	public String getIdToDeleteStr() {
		return idToDeleteStr;
	}

	public void setIdToDeleteStr(String idToDeleteStr) {
		this.idToDeleteStr = idToDeleteStr;
	}
	
	
}
