package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="post_type_master",schema="rgsa")
/*@NamedQuery(name="POST_TYPE_LIST",query="select p from PostTypeMaster p left outer join fetch p.postType pt where p.postTypeId=pt.master.postTypeId")*/
public class PostTypeMaster implements Serializable{

	/**
	 * Monty Garg
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "post_type_id",updatable = false, nullable = false)
	private Integer postTypeId;
	
	@Column(name="post_type_name")
	private String postTypeName;
	
	public Integer getPostTypeId() {
		return postTypeId;
	}

	public void setPostTypeId(Integer postTypeId) {
		this.postTypeId = postTypeId;
	}

	public String getPostTypeName() {
		return postTypeName;
	}

	public void setPostTypeName(String postTypeName) {
		this.postTypeName = postTypeName;
	}

	@Transient
	public PostType type;




	public PostType getType() {
		return type;
	}

	public void setType(PostType type) {
		this.type = type;
	}
	
	
	
	

}
