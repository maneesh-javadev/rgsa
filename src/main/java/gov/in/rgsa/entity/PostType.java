package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * @author acer
 *
 */
@Entity
@Table(name="post_type",schema="rgsa")
@NamedQuery(name="POST_TYPE_LIST",query="select p from PostType p")
public class PostType implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "post_id",updatable = false, nullable = false)
	private Integer postId;
	
	@Column(name="post_name")
	private String postName;
	
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="post_type_id",referencedColumnName="post_type_id")
	private PostTypeMaster master;
	
	public Integer getPostId() {
		return postId;
	}

	public void setPostId(Integer postId) {
		this.postId = postId;
	}

	public String getPostName() {
		return postName;
	}

	public void setPostName(String postName) {
		this.postName = postName;
	}

	public PostTypeMaster getMaster() {
		return master;
	}

	public void setMaster(PostTypeMaster master) {
		this.master = master;
	}
	
	

}
