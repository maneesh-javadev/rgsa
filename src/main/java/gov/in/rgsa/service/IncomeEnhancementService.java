package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.AttachmentMaster;
import gov.in.rgsa.entity.IncomeEnhancementActivity;
import gov.in.rgsa.entity.QprIncomeEnhancementDetails;
import gov.in.rgsa.entity.SchemeMaster;

/**
 * @author Mohammad Ayaz
 *
 */
public interface IncomeEnhancementService {
	
	public List<SchemeMaster> schemeMasterList();
	
	public void update(IncomeEnhancementActivity enhancementActivity);
	
	public AttachmentMaster findDetailsofAttachmentMaster();
	
	public List<IncomeEnhancementActivity> fetchAllIncmEnhncmntActvty(final Character userType);
	
	public void FrzUnfrz(IncomeEnhancementActivity incomeEnhancementActivity);
	
	public void deleteIncmEnhncmntDtls(int id);
	
	public void saveDetailsWithUsertype(IncomeEnhancementActivity enhancementActivity);

	public List<QprIncomeEnhancementDetails> getIncomeEnhanceQprActBasedOnActIdAndQtrId(Integer incomeEnhancementId,
			int quarterId);

}
