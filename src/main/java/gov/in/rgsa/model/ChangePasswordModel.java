package gov.in.rgsa.model;

public class ChangePasswordModel {
	private Integer userId;
	private String oldPassword;
	private String newPassword;
	private String confirmPassword; /* in form it is re_password */

	public String getOldPassword() {
		return oldPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public Integer getUserId() {
		return userId;
	} 

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

}