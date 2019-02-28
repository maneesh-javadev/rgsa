package gov.in.rgsa.entity;

import java.util.Date;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

@Entity
@Table(name = "loginattempt", schema = "rgsa")
public class LoginAttempt {

	@GenericGenerator(name = "sequence1", strategy = "sequence", parameters = {
			@Parameter(name = "sequence1", value = "rgsa.loginattempt_seq") })
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
	@Basic(optional = false)
	@Column(name = "login_attempt_id")
	private int loginAttemptId;

	@Column(name = "userid")
	private Integer userId;

	@Column(name = "wrongattempt")
	private Integer wrongAttempt;

	@Column(name = "firstattemptdate")
	private Date firstAttemptDate;

	public int getLoginAttemptId() {
		return loginAttemptId;
	}

	public void setLoginAttemptId(int loginAttemptId) {
		this.loginAttemptId = loginAttemptId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getWrongAttempt() {
		return wrongAttempt;
	}

	public void setWrongAttempt(Integer wrongAttempt) {
		this.wrongAttempt = wrongAttempt;
	}

	public Date getFirstAttemptDate() {
		return firstAttemptDate;
	}

	public void setFirstAttemptDate(Date firstAttemptDate) {
		this.firstAttemptDate = firstAttemptDate;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + loginAttemptId;
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
		LoginAttempt other = (LoginAttempt) obj;
		if (loginAttemptId != other.loginAttemptId)
			return false;
		return true;
	}

}