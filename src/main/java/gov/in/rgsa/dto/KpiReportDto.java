package gov.in.rgsa.dto;

import javax.persistence.Id;

public class KpiReportDto implements Comparable<KpiReportDto>{

	
	
	private String noOfUnitFilled;
	@Id
	private String quater ;
	private String finId;
	private String gp;
	private String gpName;
	public String getNoOfUnitFilled() {
		return noOfUnitFilled;
	}

	public void setNoOfUnitFilled(String noOfUnitFilled) {
		this.noOfUnitFilled = noOfUnitFilled;
	}

	public String getQuater()
	{
		return quater;
	}

	public void setQuater(String quater)
	{
		this.quater = quater;
	}

	public String getGp()
	{
		return gp;
	}

	public void setGp(String gp)
	{
		this.gp = gp;
	}

	public String getGpName()
	{
		return gpName;
	}

	public void setGpName(String gpName)
	{
		this.gpName = gpName;
	}

	public String getFinId()
	{
		return finId;
	}

	public void setFinId(String finId)
	{
		this.finId = finId;
	}

	@Override
	public int compareTo(KpiReportDto arg0)
	{
		// TODO Auto-generated method stub
		return quater.compareTo(arg0.getQuater());
	}

	

	
}
