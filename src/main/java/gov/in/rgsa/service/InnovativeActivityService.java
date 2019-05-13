package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.AttachmentMaster;
import gov.in.rgsa.entity.InnovativeActivity;
import gov.in.rgsa.entity.InnovativeActivityDetails;
import gov.in.rgsa.entity.QprInnovativeActivityDetails;

/**
 * @author Mohammad Ayaz 20/08/2018

 *
 */

public interface InnovativeActivityService {

	public void saveInnovativeActivityDetailsForState(InnovativeActivity activityDetails);
	
	public void saveInnovativeActivityDetailsForMinistry(InnovativeActivity innocvativeActivity);
	
	public void saveDetailsWithUsertype(InnovativeActivity activity);
	
	public void update(InnovativeActivityDetails activityDetails);
	
	public List<InnovativeActivityDetails> findActivityById(Integer id);
	
	public List<InnovativeActivity> findAllActivity(final Character userType);
	
	public List<InnovativeActivityDetails> findByAcitvityName(String activityName);
	
	public void delete(int id);

	public void freezeUnfreeze(InnovativeActivity innovativeActivity);
	
	public AttachmentMaster findfilePath();

	public AttachmentMaster findfilePath(Integer id);

	
	public List<InnovativeActivity> fetchApprovedInnovative();

	public List<QprInnovativeActivityDetails> getInnovativeQprActBasedOnActIdAndQtrId(Integer innovativeActivityId,
			int quarterId);
}