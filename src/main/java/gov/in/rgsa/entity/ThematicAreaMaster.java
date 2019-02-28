package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="thematic_area_master",schema="rgsa")
public class ThematicAreaMaster implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "thematic_area_id",updatable = false, nullable = false)
	private Integer thematicAreaId;
	
	@Column(name="thematic_area_name")
	private String thematicAreaName;

	public Integer getThematicAreaId() {
		return thematicAreaId;
	}

	public void setThematicAreaId(Integer thematicAreaId) {
		this.thematicAreaId = thematicAreaId;
	}

	public String getThematicAreaName() {
		return thematicAreaName;
	}

	public void setThematicAreaName(String thematicAreaName) {
		this.thematicAreaName = thematicAreaName;
	}
	
	

	
}
