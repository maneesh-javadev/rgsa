/*
 * package gov.in.rgsa.entity;
 * 
 * import java.io.Serializable;
 * 
 * import javax.persistence.Basic; import javax.persistence.Column; import
 * javax.persistence.Entity; import javax.persistence.GeneratedValue; import
 * javax.persistence.GenerationType; import javax.persistence.Id; import
 * javax.persistence.NamedQuery; import javax.persistence.Table;
 * 
 * @Entity
 * 
 * @Table(name = "webservice_users", schema = "rgsa_demo")
 * 
 * @NamedQuery(name="FETCH_WEBSERVICE_USERS",
 * query="select * from rgsa_demo.webservice_users where user_id =:userId")
 * public class WebserviceUsers implements Serializable {
 * 
 * private static final long serialVersionUID = 1L;
 * 
 * @Id
 * 
 * @GeneratedValue(strategy = GenerationType.IDENTITY)
 * 
 * @Basic(optional = false)
 * 
 * @Column(name = "user_id") private Integer userId;
 * 
 * @Column(name = "user_name") private String userName;
 * 
 * @Column(name = "user_password") private String userPassword;
 * 
 * public Integer getUserId() { return userId; }
 * 
 * public void setUserId(Integer userId) { this.userId = userId; }
 * 
 * public String getUserName() { return userName; }
 * 
 * public void setUserName(String userName) { this.userName = userName; }
 * 
 * public String getUserPassword() { return userPassword; }
 * 
 * public void setUserPassword(String userPassword) { this.userPassword =
 * userPassword; }
 * 
 * 
 * 
 * }
 */