package gov.in.rgsa.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

/**
 * @author Aashish Barua
 *
 */

@Entity
@Table(name="fund_released_details" , schema="rgsa")
public class FundReleasedDetails {

	@Id
	@Column(name="fund_released_details_id" , updatable = false , nullable = false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer fundReleasedDetailsId;
	
	@ManyToOne()
	@JoinColumn(name="fund_released_id" , nullable = false)
	private FundReleased fundReleased;
	
	@Column(name="installment_id" , nullable = false)
	private Integer installmentId;
	
	@Column(name="unspent_balance")
	private Integer unspentBalance;
	
	@Column(name="central_share")
	private Integer centralShare;
	
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.ALL)
	@JoinColumn(name="file_node_id")
	private FileNode fileNode;
	
	@Transient
	private MultipartFile file;
	
	@Column(name="is_freeze")
	private Boolean isFreeze;

	public Integer getFundReleasedDetailsId() {
		return fundReleasedDetailsId;
	}

	public void setFundReleasedDetailsId(Integer fundReleasedDetailsId) {
		this.fundReleasedDetailsId = fundReleasedDetailsId;
	}

	public FundReleased getFundReleased() {
		return fundReleased;
	}

	public void setFundReleased(FundReleased fundReleased) {
		this.fundReleased = fundReleased;
	}

	public Integer getInstallmentId() {
		return installmentId;
	}

	public void setInstallmentId(Integer installmentId) {
		this.installmentId = installmentId;
	}

	public Integer getUnspentBalance() {
		return unspentBalance;
	}

	public void setUnspentBalance(Integer unspentBalance) {
		this.unspentBalance = unspentBalance;
	}

	public Integer getCentralShare() {
		return centralShare;
	}

	public void setCentralShare(Integer centralShare) {
		this.centralShare = centralShare;
	}

	public FileNode getFileNode() {
		return fileNode;
	}

	public void setFileNode(FileNode fileNode) {
		this.fileNode = fileNode;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}
	
}
