package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="sanction_order",schema="rgsa")
@NamedQueries({
	@NamedQuery(name="FETCH_SanctionOrder_LIST",query="from SanctionOrder where releaseIntallmentSno=:releaseIntallmentSno"),
})
public class SanctionOrder {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="sanction_order_sr_no")
	private Integer sanctionOrderSno;
	
	@Column(name="release_installment_sr_no")
	private Integer releaseIntallmentSno;
	
	
	@Column(name="sanction_order_component_id")
	private Integer soComponentId;
	
	@Column(name="amount_under_component")
	private Double amountUnderComponent;
	
	@Column(name="file_path")
	private String filePath;

	@Column(name="plan_code")
	private Integer planCode;


	public Integer getSanctionOrderSno() {
		return sanctionOrderSno;
	}

	public void setSanctionOrderSno(Integer sanctionOrderSno) {
		this.sanctionOrderSno = sanctionOrderSno;
	}

	public Integer getReleaseIntallmentSno() {
		return releaseIntallmentSno;
	}

	public void setReleaseIntallmentSno(Integer releaseIntallmentSno) {
		this.releaseIntallmentSno = releaseIntallmentSno;
	}

	
	public Integer getSoComponentId() {
		return soComponentId;
	}

	public void setSoComponentId(Integer soComponentId) {
		this.soComponentId = soComponentId;
	}

	public Double getAmountUnderComponent() {
		return amountUnderComponent;
	}

	public void setAmountUnderComponent(Double amountUnderComponent) {
		this.amountUnderComponent = amountUnderComponent;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Integer getPlanCode() {
		return planCode;
	}

	public void setPlanCode(Integer planCode) {
		this.planCode = planCode;
	}
	 

}
