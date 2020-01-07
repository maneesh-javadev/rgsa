package gov.in.rgsa.entity;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.GeneratorType;

@Entity
@Table(name="error_logs",schema="rgsa")
@NamedQuery(name="FETCH_ERROR_LOG",query="from ErrorLog where stateCode=:stateCode and ipAddress=:ipAddress and requestUri=:requestURI order by errorLogTime desc")
public class ErrorLog implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1358293319394183844L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="error_log_id")
	private Long errorLogId;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="user_id")
	private Integer userId;
	
	@Column(name="error_log_time",updatable=false)
	@CreationTimestamp
	private Timestamp errorLogTime;
	
	@Column(name="ip_address")
	private String ipAddress;
	
	@Column(name="request_uri")
	private String requestUri;
	
	@Column(name="request_url")
	private String requestUrl;
	
	@Column(name="method_type")
	private String methodType;
	
	@Column(name="error_description")
	private String errorDescription;

	public Long getErrorLogId() {
		return errorLogId;
	}

	public void setErrorLogId(Long errorLogId) {
		this.errorLogId = errorLogId;
	}

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Timestamp getErrorLogTime() {
		return errorLogTime;
	}

	public void setErrorLogTime(Timestamp errorLogTime) {
		this.errorLogTime = errorLogTime;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	public String getRequestUri() {
		return requestUri;
	}

	public void setRequestUri(String requestUri) {
		this.requestUri = requestUri;
	}

	public String getRequestUrl() {
		return requestUrl;
	}

	public void setRequestUrl(String requestUrl) {
		this.requestUrl = requestUrl;
	}

	public String getMethodType() {
		return methodType;
	}

	public void setMethodType(String methodType) {
		this.methodType = methodType;
	}

	public String getErrorDescription() {
		return errorDescription;
	}

	public void setErrorDescription(String errorDescription) {
		this.errorDescription = errorDescription;
	}

}
