package gov.in.rgsa.service;

import java.util.List;
import java.util.Map;

import gov.in.rgsa.entity.AdditionalFacultyProgressDetail;
import gov.in.rgsa.entity.District;
import gov.in.rgsa.entity.Domains;
import gov.in.rgsa.entity.InstitueInfraHrActivity;
import gov.in.rgsa.entity.InstitueInfraHrActivityDetails;
import gov.in.rgsa.entity.InstituteInfraHrActivityType;
import gov.in.rgsa.entity.TIWiseProposedDomainExperts;
import gov.in.rgsa.entity.TrainingInstituteCurrentStatusDetails;
import gov.in.rgsa.model.AdditionalFactultyAndMaintModel;

public interface AdditionalFacultyAndMainService {

	public List<InstituteInfraHrActivityType> fetchHrActvityType();

	public void saveAddFacAndMain(AdditionalFactultyAndMaintModel additionalFactultyAndMaintModel);

	public List<InstitueInfraHrActivity> fetchInstituteHrActivity(String userType);

	public List<InstitueInfraHrActivityDetails> fetchInstituteHrActivityDetails(Integer instituteInfraHrActivityId);

	public List<Domains> fetchDomains();

	public List<TrainingInstituteCurrentStatusDetails> fetchTiLocation(Integer trainingInstitueTypeId);

	public List<District> fetchDistrictName();

	public List<TIWiseProposedDomainExperts> fetchTiWiseDomainExpert();

	public List<InstitueInfraHrActivity> fetchApprovedInstituteHrActivity();

	public List<InstitueInfraHrActivityDetails> fetchInstituteHrActivityApprovedDetails(Integer instituteInfraHrActivityId);

	public List<TIWiseProposedDomainExperts> fetchTiWiseDomainExpertById(Integer instituteInfraHrActivityId);

	public List<AdditionalFacultyProgressDetail> getAdditionalFacultyProgressBasedOnActIdAndQtrId(
			Integer instituteInfraHrActivityId, int quarterId);

	public Map<? extends String, ? extends Object> getTotalAddReqBesidesCurrentQtr(Integer instituteInfraHrActivityId,
			int quarterId);


}
