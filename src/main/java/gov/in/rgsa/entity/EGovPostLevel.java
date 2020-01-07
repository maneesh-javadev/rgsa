package gov.in.rgsa.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="egov_post_level",schema="rgsa")
public class EGovPostLevel implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5188261575209086738L;

	@Id
	@Column(name="egov_post_level_id")
	private Integer postLevelId;
	
	@Column(name="egov_post_level_name")
	private String postLevelName;
	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="EGovPostLevel",fetch=FetchType.EAGER)
	List<EGovPost> eGovPosts;

	public List<EGovPost> geteGovPosts() {
		return eGovPosts;
	}

	public void seteGovPosts(List<EGovPost> eGovPosts) {
		this.eGovPosts = eGovPosts;
	}

	public Integer getPostLevelId() {
		return postLevelId;
	}

	public void setPostLevelId(Integer postLevelId) {
		this.postLevelId = postLevelId;
	}

	public String getPostLevelName() {
		return postLevelName;
	}

	public void setPostLevelName(String postLevelName) {
		this.postLevelName = postLevelName;
	}

	
	
}
