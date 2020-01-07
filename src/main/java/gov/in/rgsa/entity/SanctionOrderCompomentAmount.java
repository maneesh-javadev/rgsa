package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Transient;

@Entity
@NamedNativeQueries({
/*@NamedNativeQuery(name="soComponentAmount",query="select * from rgsa.get_sanction_order_compoment_amount_new(:planCode,:installmentNo)",resultClass=SanctionOrderCompomentAmount.class),
@NamedNativeQuery(name="alreadySanctionComponentAmount",query="select * from rgsa.get_sanction_order_compoment_amount(:planCode,:installmentNo)",resultClass=SanctionOrderCompomentAmount.class) 
*/
	
	@NamedNativeQuery(name="soComponentAmount",query="select soc.so_component_id  component_id ,soc.so_component_name component_name ,0.0 component_amount , 0 installment_no , 0 file_Path from rgsa.sanction_order_component  soc order by  order by component_id",resultClass=SanctionOrderCompomentAmount.class),
	@NamedNativeQuery(name="alreadySanctionComponentAmount",query="select soc.so_component_id component_id,soc.so_component_name component_name,so.amount_under_component component_amount,so.installment_no ,so.file_Path  from rgsa.sanction_order so inner join rgsa.sanction_order_component soc on soc.so_component_id=so.sanction_order_component_id where so.plan_code=:planCode and so.installment_no =:installmentNo order by  order by component_id",resultClass=SanctionOrderCompomentAmount.class) 

})
public class SanctionOrderCompomentAmount {
	
	
	
	@Id
	@Column(name="component_id")
	private Integer componentId;
	
	@Column(name="component_name")
	private String componentName;
	
	@Column(name="component_amount")
	private Double componentAmount;
	
	@Column(name="file_Path")
	private String filePath;
	
	@Transient
	private Integer sanctionOrderSno;

	@Column(name="installment_no")  
	private Integer installmentNo;

	public Integer getComponentId() {
		return componentId;
	}

	public void setComponentId(Integer componentId) {
		this.componentId = componentId;
	}

	public String getComponentName() {
		return componentName;
	}

	public void setComponentName(String componentName) {
		this.componentName = componentName;
	}

	public Double getComponentAmount() {
		return componentAmount;
	}

	public void setComponentAmount(Double componentAmount) {
		this.componentAmount = componentAmount;
	}

	

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Integer getSanctionOrderSno() {
		return sanctionOrderSno;
	}

	public void setSanctionOrderSno(Integer sanctionOrderSno) {
		this.sanctionOrderSno = sanctionOrderSno;
	}

	public Integer getInstallmentNo() {
		return installmentNo;
	}

	public void setInstallmentNo(Integer installmentNo) {
		this.installmentNo = installmentNo;
	}

	

	

	
	

}
