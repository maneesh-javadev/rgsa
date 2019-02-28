package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * The persistent class for the user_role_map database table.
 * 
 */
@Entity
@Table(name = "user_role_map", schema = "rgsa")
public class UserRoleMap implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private UserRoleMapPK id;

	private Boolean isactive;

	@ManyToOne
	@JoinColumn(name = "role_id", insertable = false, updatable = false)
	private RoleMaster roleMaster;

	@ManyToOne
	@JoinColumn(name = "user_id", insertable = false, updatable = false)
	private Users userLogin;

	public UserRoleMap() {
	}

	public UserRoleMapPK getId() {
		return this.id;
	}

	public void setId(UserRoleMapPK id) {
		this.id = id;
	}

	public Boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(Boolean isactive) {
		this.isactive = isactive;
	}

	public RoleMaster getRoleMaster() {
		return this.roleMaster;
	}

	public void setRoleMaster(RoleMaster roleMaster) {
		this.roleMaster = roleMaster;
	}

	public Users getUserLogin() {
		return this.userLogin;
	}

	public void setUserLogin(Users userLogin) {
		this.userLogin = userLogin;
	}

}