package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="at_post_levels",schema="rgsa") 
@NamedQuery(name="ADINISTRATIVE_LEVELS",query="select p from PostLevel p where postLevelId !=1 order by p.postLevelId desc")
public class PostLevel implements Serializable{

	/**
	 * Monty Garg
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "post_level_id")
	private Integer postLevelId;
	
	@Column(name="post_level_name")
	private String postLevelName;

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
