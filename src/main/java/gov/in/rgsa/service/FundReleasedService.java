package gov.in.rgsa.service;

import gov.in.rgsa.entity.FileNode;
import gov.in.rgsa.entity.FundReleased;
import gov.in.rgsa.entity.FundReleasedDetails;
import gov.in.rgsa.entity.ReleaseIntallment;

public interface FundReleasedService {

	public ReleaseIntallment validateReleaseInstallment(Integer stateCode, Integer finYearId);
	
	public FileNode loadFileNode(Integer fileNodeId);

	public void save(FundReleased fundReleased);

	public FundReleased fetchData(Integer planCode);

	public FundReleasedDetails fetchFundReleasedDetailByInstallmentNo(Integer installmentNo);

}
