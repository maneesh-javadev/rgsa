package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import javax.persistence.Table;

@Entity
@Table(name = "iec_activity_dropdown", schema = "rgsa")

public class IecActivityDropedown implements Serializable {

private static final long serialVersionUID = 1L;

		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		@Basic(optional = false)
		@Column(name = "iec_id")
		private  Integer iecId;

		@Column(name = "nature_iec_Activity")
		private String natureIecActivity;
		
		
		public Integer getIecId() {
			return iecId;
		}

		public void setIecId(Integer iecId) {
			this.iecId = iecId;
		}

		public String getNatureIecActivity() {
			return natureIecActivity;
		}

		public void setNatureIecActivity(String natureIecActivity) {
			this.natureIecActivity = natureIecActivity;
		}

		public static long getSerialversionuid() {
			return serialVersionUID;
		}

		
		}

	

