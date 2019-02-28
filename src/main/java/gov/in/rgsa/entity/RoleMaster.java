package gov.in.rgsa.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the role_master database table.
 * 
 */
@Entity
@Table(name = "role_master",schema="rgsa")
@NamedQuery(name = "RoleMaster.findAll", query = "SELECT r FROM RoleMaster r")
public class RoleMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "role_id")
	private Integer roleId;

	@Column(name = "\"createdBy\"")
	private Integer createdBy;

	@Temporal(TemporalType.DATE)
	@Column(name = "\"createdOn\"")
	private Date createdOn;

	private Boolean isactive;

	@Column(name = "role_name")
	private String roleName;

	@OneToMany(mappedBy = "roleMaster")
	private List<UserRoleMap> userRoleMaps;

	public RoleMaster() {
	}

	public Integer getRoleId() {
		return this.roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getCreatedBy() {
		return this.createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreatedOn() {
		return this.createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public Boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(Boolean isactive) {
		this.isactive = isactive;
	}

	public String getRoleName() {
		return this.roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public List<UserRoleMap> getUserRoleMaps() {
		return this.userRoleMaps;
	}

	public void setUserRoleMaps(List<UserRoleMap> userRoleMaps) {
		this.userRoleMaps = userRoleMaps;
	}

	public UserRoleMap addUserRoleMap(UserRoleMap userRoleMap) {
		getUserRoleMaps().add(userRoleMap);
		userRoleMap.setRoleMaster(this);

		return userRoleMap;
	}

	public UserRoleMap removeUserRoleMap(UserRoleMap userRoleMap) {
		getUserRoleMaps().remove(userRoleMap);
		userRoleMap.setRoleMaster(null);

		return userRoleMap;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((roleId == null) ? 0 : roleId.hashCode());
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
		RoleMaster other = (RoleMaster) obj;
		if (roleId == null) {
			if (other.roleId != null)
				return false;
		} else if (!roleId.equals(other.roleId))
			return false;
		return true;
	}

}