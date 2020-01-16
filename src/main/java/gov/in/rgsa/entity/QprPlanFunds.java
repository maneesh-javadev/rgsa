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
    Double qtr1AddtionalFund ;

    @Column(name = "qtr2_expenditure")
    Double qtr2Expenditure ;

    @Column(name = "qtr2_addtional_fund")
    Double qtr2AddtionalFund ;

    @Column(name = "qtr3_expenditure")
    Double qtr3Expenditure ;

    @Column(name = "qtr3_addtional_fund")
    Double qtr3AddtionalFund ;

    @Column(name = "qtr4_expenditure")
    Double qtr4Expenditure ;

    @Column(name = "qtr4_addtional_fund")
    Double qtr4AddtionalFund ;

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

    public Double getQtr1AddtionalFund() {
        return qtr1AddtionalFund;
    }

    public Double getQtr2Expenditure() {
        return qtr2Expenditure;
    }

    public Double getQtr2AddtionalFund() {
        return qtr2AddtionalFund;
    }

    public Double getQtr3Expenditure() {
        return qtr3Expenditure;
    }

    public Double getQtr3AddtionalFund() {
        return qtr3AddtionalFund;
    }

    public Double getQtr4Expenditure() {
        return qtr4Expenditure;
    }

    public Double getQtr4AddtionalFund() {
        return qtr4AddtionalFund;
    }

    public PlanComponents getPlanComponents() {
        return planComponents;
    }

    public String getPlanComponentName() {
        return planComponentName;
    }
}
