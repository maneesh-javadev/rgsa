package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "fin_year", schema = "rgsa")
@NamedQuery(name="FETCH_ALL_FIN_YEAR", query="FROM FinYear ORDER BY yearId DESC")
public class FinYear implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -80487056594075403L;

	@Id
	@Column(name = "year_id")
	private Integer yearId;

	@Column(name = "finyear")
	private String finYear;

	@Column(name = "isactive")
	private boolean isactive;

	public Integer getYearId() {
		return yearId;
	}

	public void setYearId(Integer yearId) {
		this.yearId = yearId;
	}

	public String getFinYear() {
		return finYear;
	}

	public void setFinYear(String finYear) {
		this.finYear = finYear;
	}

	public boolean isIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((yearId == null) ? 0 : yearId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		FinYear other = (FinYear) obj;
		if (yearId == null) {
			if (other.yearId != null)
				return false;
		} else if (!yearId.equals(other.yearId))
			return false;
		return true;
	}

}
