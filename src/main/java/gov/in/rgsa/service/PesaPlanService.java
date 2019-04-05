package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.PesaPlan;
import gov.in.rgsa.entity.PesaPlanDetails;
import gov.in.rgsa.entity.PesaPost;

/**
 *
 * @author ANJIT
 */

public interface PesaPlanService {

	public List<PesaPlan> fetchPesaPlan(final Character userType);
	
	public List<PesaPost> fetchPesaPost();
	
	public void savePesaPlan(final PesaPlan pesaPlan);

	public void savePesaPlanForCEC(final PesaPlan pesaPlan);
	
	
	public List<PesaPlanDetails> fetchPesaDetails(Integer pesaPlanId);
	
	public PesaPlan feezUnFreezPesaPlan(final PesaPlan pesaPlan);
}
