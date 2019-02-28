package gov.in.rgsa.service;

import java.util.List;



import gov.in.rgsa.entity.IecActivity;
import gov.in.rgsa.entity.IecActivityDropedown;
import gov.in.rgsa.model.IecModel;




public interface IecService {
	public List<IecActivityDropedown>  findAllActivityById();

	public void save(IecActivity iecActivity);

	public IecActivity fetchIecDetail(final String userType);

	public void update(IecActivity iecActivity);

	public void delete(int idMain);
	
	public void freezeAndUnfreeze( IecActivity iecActivity);

	public List<IecActivity> fetchApprovedIec();






	

	

	
}

