package gov.in.rgsa.service;

import java.util.List;



import gov.in.rgsa.entity.IecActivity;
import gov.in.rgsa.entity.IecActivityDropdown;
import gov.in.rgsa.entity.IecQuaterDetails;
import gov.in.rgsa.model.IecFormModel;


public interface IecService {
//	public List<IecActivityDropdown>  findAllActivityById();
//
//	public void save(IecActivity iecActivity);
//
//	public IecActivity fetchIecDetail(final String userType);
//
//	public void update(IecActivity iecActivity);
//
//	public void delete(int idMain);
//
//	public void freezeAndUnfreeze( IecActivity iecActivity);
//
//	public List<IecActivity> fetchApprovedIec();


	List<IecActivityDropdown> findAllActivityById();

	IecActivity fetchIecDetail(String userType);

	List<IecActivity> fetchApprovedIec();

	void save(IecFormModel iecFormModel);

	void freeze(IecFormModel iecFormModel);

	void unfreeze(IecFormModel iecFormModel);

	List<IecQuaterDetails> getIecQprActBasedOnActIdAndQtrId(Integer id, int quarterId);
	
}

