package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * 
 * @author sourabh
 *
 */

@Entity
@Table(name="pesa_post", schema = "rgsa")
@NamedQuery(name="FETCH_PESA_POST",query="SELECT PP FROM PesaPost PP")
public class PesaPost implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7421410479952659682L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="pesa_post_id")
	private Integer pesaPostId;
	
	@Column(name="pesa_post_name")
	private String pesaPostName;
	
	@Column(name="ceiling_value")
	private Integer ceilingValue;

	public Integer getPesaPostId() {
		return pesaPostId;
	}

	public void setPesaPostId(Integer pesaPostId) {
		this.pesaPostId = pesaPostId;
	}

	public String getPesaPostName() {
		return pesaPostName;
	}

	public void setPesaPostName(String pesaPostName) {
		this.pesaPostName = pesaPostName;
	}

	public Integer getCeilingValue() {
		return ceilingValue;
	}

	public void setCeilingValue(Integer ceilingValue) {
		this.ceilingValue = ceilingValue;
	}
	
}