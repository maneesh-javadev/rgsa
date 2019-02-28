package gov.in.rgsa.model;

import java.util.List;

import gov.in.rgsa.entity.PesaPlan;
import gov.in.rgsa.entity.PesaPost;

public class PesaPlanResponse {
	
	private PesaPlan pesaPlan;
	
	private List<PesaPost> pesaPosts;
	
	
	public PesaPlan getPesaPlan() {
		return pesaPlan;
	}
	public void setPesaPlan(PesaPlan pesaPlan) {
		this.pesaPlan = pesaPlan;
	}
	public List<PesaPost> getPesaPosts() {
		return pesaPosts;
	}
	public void setPesaPosts(List<PesaPost> pesaPosts) {
		this.pesaPosts = pesaPosts;
	}

	

}
