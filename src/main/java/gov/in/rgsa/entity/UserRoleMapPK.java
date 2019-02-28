package gov.in.rgsa.entity;



import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the user_role_map database table.
 * 
 */
@Embeddable
public class UserRoleMapPK implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(name="role_id")
	private Integer roleId;

	@Column(name="user_id")
	private Integer userId;

	public UserRoleMapPK() {
	}
	public Integer getRoleId() {
		return this.roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	public Integer getUserId() {
		return this.userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof UserRoleMapPK)) {
			return false;
		}
		UserRoleMapPK castOther = (UserRoleMapPK)other;
		return 
			this.roleId.equals(castOther.roleId)
			&& this.userId.equals(castOther.userId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.roleId.hashCode();
		hash = hash * prime + this.userId.hashCode();
		
		return hash;
	}
}