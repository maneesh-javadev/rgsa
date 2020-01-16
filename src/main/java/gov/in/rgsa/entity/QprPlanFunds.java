package gov.in.rgsa.entity;

import javax.persistence.*;

@Entity
@Table(name = "qpr_plan_funds", schema = "rgsa")
public class QprPlanFunds {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name = "qpr_id", nullable=false)
    Integer qprId ;

    @Column(name = "plan_code", nullable=false)
    Integer planCode ;

    @Column(name = "state_code", nullable=false)
    Integer stateCode ;

    @Column(name = "year_id", nullable=false)
    Integer yearId ;

    @Column(name = "qtr1_expenditure")
    Double qtr1Expenditure ;

    @Column(name = "qtr1_addtional_fund")
    Double qtr1AdditionalFund ;

    @Column(name = "qtr2_expenditure")
    Double qtr2Expenditure ;

    @Column(name = "qtr2_addtional_fund")
    Double qtr2AdditionalFund ;

    @Column(name = "qtr3_expenditure")
    Double qtr3Expenditure ;

    @Column(name = "qtr3_addtional_fund")
    Double qtr3AdditionalFund ;

    @Column(name = "qtr4_expenditure")
    Double qtr4Expenditure ;

    @Column(name = "qtr4_addtional_fund")
    Double qtr4AdditionalFund ;

    @ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name = "plan_component_id", nullable=false)
    PlanComponents planComponents ;

    @Column(name = "plan_component_name")
    String planComponentName ;

    public Integer getQprId() {
        return qprId;
    }

    public Integer getPlanCode() {
        return planCode;
    }

    public Integer getStateCode() {
        return stateCode;
    }

    public Integer getYearId() {
        return yearId;
    }

    public Double getQtr1Expenditure() {
        return qtr1Expenditure;
    }

    public Double getQtr1AdditionalFund() {
        return qtr1AdditionalFund;
    }

    public Double getQtr2Expenditure() {
        return qtr2Expenditure;
    }

    public Double getQtr2AdditionalFund() {
        return qtr2AdditionalFund;
    }

    public Double getQtr3Expenditure() {
        return qtr3Expenditure;
    }

    public Double getQtr3AdditionalFund() {
        return qtr3AdditionalFund;
    }

    public Double getQtr4Expenditure() {
        return qtr4Expenditure;
    }

    public Double getQtr4AdditionalFund() {
        return qtr4AdditionalFund;
    }

    public PlanComponents getPlanComponents() {
        return planComponents;
    }

    public String getPlanComponentName() {
        return planComponents == null ? planComponentName: getPlanComponents().getComponentName();
    }

    public void setQprId(Integer qprId) {
        this.qprId = qprId;
    }

    public void setPlanCode(Integer planCode) {
        this.planCode = planCode;
    }

    public void setStateCode(Integer stateCode) {
        this.stateCode = stateCode;
    }

    public void setYearId(Integer yearId) {
        this.yearId = yearId;
    }

    public void setQtr1Expenditure(Double qtr1Expenditure) {
        this.qtr1Expenditure = qtr1Expenditure;
    }

    public void setQtr1AdditionalFund(Double qtr1AdditionalFund) {
        this.qtr1AdditionalFund = qtr1AdditionalFund;
    }

    public void setQtr2Expenditure(Double qtr2Expenditure) {
        this.qtr2Expenditure = qtr2Expenditure;
    }

    public void setQtr2AdditionalFund(Double qtr2AdditionalFund) {
        this.qtr2AdditionalFund = qtr2AdditionalFund;
    }

    public void setQtr3Expenditure(Double qtr3Expenditure) {
        this.qtr3Expenditure = qtr3Expenditure;
    }

    public void setQtr3AdditionalFund(Double qtr3AdditionalFund) {
        this.qtr3AdditionalFund = qtr3AdditionalFund;
    }

    public void setQtr4Expenditure(Double qtr4Expenditure) {
        this.qtr4Expenditure = qtr4Expenditure;
    }

    public void setQtr4AdditionalFund(Double qtr4AdditionalFund) {
        this.qtr4AdditionalFund = qtr4AdditionalFund;
    }

    public void setPlanComponents(PlanComponents planComponents) {
        this.planComponents = planComponents;
    }

    public void setPlanComponentName(String planComponentName) {
        this.planComponentName = planComponentName;
    }
}
