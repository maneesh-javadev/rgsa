package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "month", schema = "rgsa")
public class Month implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "month_id")
	private Integer monthId;

	@Column(name = "month_name")
	private String monthName;

	@Column(name = "month_order")
	private Integer monthOrder;

	@Column(name = "language_id")
	private Integer languageId;

	public Integer getMonthId() {
		return monthId;
	}

	public void setMonthId(Integer monthId) {
		this.monthId = monthId;
	}

	public String getMonthName() {
		return monthName;
	}

	public void setMonthName(String monthName) {
		this.monthName = monthName;
	}

	public Integer getMonthOrder() {
		return monthOrder;
	}

	public void setMonthOrder(Integer monthOrder) {
		this.monthOrder = monthOrder;
	}

	public Integer getLanguageId() {
		return languageId;
	}

	public void setLanguageId(Integer languageId) {
		this.languageId = languageId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((monthId == null) ? 0 : monthId.hashCode());
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
		Month other = (Month) obj;
		if (monthId == null) {
			if (other.monthId != null)
				return false;
		} else if (!monthId.equals(other.monthId))
			return false;
		return true;
	}

}
