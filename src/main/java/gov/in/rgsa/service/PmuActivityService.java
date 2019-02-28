package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.District;
import gov.in.rgsa.entity.Domains;
import gov.in.rgsa.entity.InstitueInfraHrActivity;
import gov.in.rgsa.entity.InstitueInfraHrActivityDetails;
import gov.in.rgsa.entity.PmuActivity;
import gov.in.rgsa.entity.PmuActivityDetails;
import gov.in.rgsa.entity.PmuActivityType;
import gov.in.rgsa.entity.PmuDomain;
import gov.in.rgsa.entity.PmuWiseProposedDomainExperts;
import gov.in.rgsa.entity.TIWiseProposedDomainExperts;
/**
 * @author MOhammad Ayaz 04/10/2018
 *
 */
public interface PmuActivityService {
	
	public List<District> fetchDistrictName();
	
	public List<PmuActivityType> fetchPmuActvityType();
	
	public List<PmuActivity> fetchPmuActivity(final Character userType);
	
	public List<PmuWiseProposedDomainExperts> fetchPmuWiseDomainExpert();
	
	public List<PmuDomain> fetchPmuDomains();

	public void saveAndUpdate(PmuActivity pmuActivity);
	
	public void pmuFreezUnfreeze(PmuActivity pmuActivity);

	public List<PmuActivity> fetchApprovedPmu();

	public List<PmuActivityDetails> fetchPmuApprovedDetails(Integer pmuActivityId);
}