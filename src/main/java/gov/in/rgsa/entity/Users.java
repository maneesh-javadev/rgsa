package gov.in.rgsa.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "users", schema = "rgsa")
public class Users implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Basic(optional = false)
	@Column(name = "user_id")
	private Integer userId;

	@Column(name = "user_name")
	private String userName;

	@Column(name = "user_password")
	private String userPassword;

	@Column(name = "password")
	private String password;

	@Column(name = "user_type")
	private String userType;

	@Column(name = "mobile_no")
	private Integer mobileNo;

	@Column(name = "email_id")
	private String emailId;

	@Column(name = "state_id")
	private Integer stateId;

	@Column(name = "wrong_attempt")
	private Integer wrongAttempt;

	@Column(name = "last_attempt_on")
	private Date lastAttemptDate;

	@Column(name = "is_locked")
	private Boolean isLocked;

	@Column(name = "username_encrypt")
	private String usernameEncrypt;

	@Transient
	private boolean accountNonExpired = true;

	@Transient
	private boolean accountNonLocked = true;

	@Transient
	private boolean credentialsNonExpired = true;

	@Transient
	private String capchaAnswer;

	@Transient
	private String oldPassword;

	@Transient
	private String confirmPassword;

	@OneToMany(mappedBy = "userLogin")
	private List<UserRoleMap> userRoleMaps;

	public Users() {

	}

	public Users(String userName, String userPassword) {
		super();
		this.userName = userName;
		this.userPassword = userPassword;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public Integer getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(Integer mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public Integer getStateId() {
		return stateId;
	}

	public void setStateId(Integer stateId) {
		this.stateId = stateId;
	}

	@Column(name = "districtcode")
	private Integer districtcode;

	public Integer getDistrictcode() {
		return districtcode;
	}

	public void setDistrictcode(Integer districtcode) {
		this.districtcode = districtcode;
	}

	public String getCapchaAnswer() {
		return capchaAnswer;
	}

	public void setCapchaAnswer(String capchaAnswer) {
		this.capchaAnswer = capchaAnswer;
	}

	public Integer getWrongAttempt() {
		return wrongAttempt;
	}

	public void setWrongAttempt(Integer wrongAttempt) {
		this.wrongAttempt = wrongAttempt;
	}

	public Date getLastAttemptDate() {
		return lastAttemptDate;
	}

	public void setLastAttemptDate(Date lastAttemptDate) {
		this.lastAttemptDate = lastAttemptDate;
	}

	public Boolean getIsLocked() {
		return isLocked;
	}

	public void setIsLocked(Boolean isLocked) {
		this.isLocked = isLocked;
	}

	public List<UserRoleMap> getUserRoleMaps() {
		return this.userRoleMaps;
	}

	public void setUserRoleMaps(List<UserRoleMap> userRoleMaps) {
		this.userRoleMaps = userRoleMaps;
	}

	public boolean isAccountNonExpired() {
		return accountNonExpired;
	}

	public void setAccountNonExpired(boolean accountNonExpired) {
		this.accountNonExpired = accountNonExpired;
	}

	public boolean isAccountNonLocked() {
		return accountNonLocked;
	}

	public void setAccountNonLocked(boolean accountNonLocked) {
		this.accountNonLocked = accountNonLocked;
	}

	public boolean isCredentialsNonExpired() {
		return credentialsNonExpired;
	}

	public void setCredentialsNonExpired(boolean credentialsNonExpired) {
		this.credentialsNonExpired = credentialsNonExpired;
	}

	public String getUsernameEncrypt() {
		return usernameEncrypt;
	}

	public void setUsernameEncrypt(String usernameEncrypt) {
		this.usernameEncrypt = usernameEncrypt;
	}

	public String getOldPassword() {
		return oldPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public static String getTypeForState(){
		return "S";
	}

	public static String getTypeForMOPR(){
		return "M";
	}

	public static String getTypeForCEC(){
		return "C";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((stateId == null) ? 0 : stateId.hashCode());
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
		Users other = (Users) obj;
		if (stateId == null) {
			if (other.stateId != null)
				return false;
		} else if (!stateId.equals(other.stateId))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "User [" + (userId != null ? "userId=" + userId + ", " : "")
				+ (userName != null ? "userName=" + userName + ", " : "")
				+ (userType != null ? "userType=" + userType + ", " : "")
				+ (wrongAttempt != null ? "wrongAttempt=" + wrongAttempt + ", " : "")
				+ (lastAttemptDate != null ? "lastAttemptDate=" + lastAttemptDate + ", " : "")
				+ (isLocked != null ? "isLocked=" + isLocked + ", " : "")
				+ (userRoleMaps != null ? "userRoleMaps=" + userRoleMaps : "") + "]";
	}

}