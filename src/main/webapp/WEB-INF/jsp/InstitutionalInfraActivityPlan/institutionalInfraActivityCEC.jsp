<%@include file="../taglib/taglib.jsp"%>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/institutionalInfraActivityPlan/institutionalInfraActivityPlanControllerCEC.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/institutionalInfraActivityPlan/institutionalInfraActivityPlanService.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<script>
	
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
</script>
<html data-ng-app="publicModule">
<section class="content"
	data-ng-controller="institutionalInfraActivityPlanController">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Label.InstitutionalInfrastructure"
								htmlEscape="true" />
							(CEC)
						</h2>
					</div>
					<div class="body">
						<ul class="nav nav-tabs">
							<li class="nav-item"><a class="nav-link active"
								data-toggle="tab" href="#state"><spring:message
										code="Label.STATE" htmlEscape="true" /></a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#MOPR"><spring:message code="Label.MOPR"
										htmlEscape="true" /></a></li>
						</ul>
						<div class="tab-content">
						
						
							<div role="tabpanel" class="container tab-pane active" id="state"
								style="width: auto;">

								
					<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.NewBuilding" htmlEscape="true" />(SPRC)
                           </div>
                           
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                           
                           
                           <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
													<th class="padding_left_local"><div >
														<strong><spring:message code="Label.BuildingType" htmlEscape="true" />
														</strong>
													</div></th>
													
													<th>
														<div align="center">
															<strong><spring:message code="Label.District" htmlEscape="true" /> 
															</strong>
														</div>
													</th>
													
														
											
												<th><div align="center">
														<strong><spring:message code="Label.Funds" htmlEscape="true" />
														</strong>
													</div></th>
												<!-- <th><div align="center">
														<strong>Total Fund<br>(B = A + Funds required <br>in carry forward section)
														</strong>
													</div></th> -->
												<th > 
													<div align="center">
														<strong><spring:message code="Label.IsApproved" htmlEscape="true" />
														</strong>
													</div>
												</th>	
													
												<th> 
													<div align="center">
														<strong><spring:message code="Label.Remarks" htmlEscape="true" />
														</strong>
													</div>
												</th>
											</tr>
							  </thead>
                              <tbody>
                                 <tr data-ng-repeat="details in institutionalPlanDetailsNBState | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
												<td class="padding_left_local"><strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong></td>
												<td ><strong>{{details.districtName}}</strong></td>
											
												<td>
												<div align="center" data-ng-style="{'color':(institutionalPlanDetailsNBState[$index].fundProposed > details.fundProposed) ? 'red' : '#00cc00'}">
												<strong>{{institutionalPlanDetailsNBState[$index].fundProposed}}</strong></div>
												<input type="text" onkeypress="return isNumber(event)" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsNBStateCEC[$index].fundProposed" class="form-control" id="fundProposedId" data-ng-keyup="calculate_total_fund(1,$index,null)" maxlength="8" style="text-align:right;" required="required" autocomplete="off"/>
												<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsNBStateCEC[$index].fundProposed" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<!-- <td>
													<input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsNB[$index].totalFund" class="form-control" id="totalFundId" data-ng-keyup="calculationDependentField(trainingInstituteTypeId)" readonly="readonly" style="text-align:right;"/>
													<input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBlInfraActivityPlanDetails[$index].totalFund" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td> -->
												
												<td align="center">
													<input type="checkbox" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsNBStateCEC[$index].isApproved">
													<input type="checkbox" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsNBStateCEC[$index].isApproved" disabled="disabled">
												</td>
												<td align="center">
													<div align="center" data-ng-style="{'color':(institutionalPlanDetailsNBState[$index].remarks > details.remarks) ? 'red' : '#00cc00'}">
													<strong>{{institutionalPlanDetailsNBState[$index].remarks}}</strong></div>
													<textarea rows="2" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsNBStateCEC[$index].remarks" cols="10"></textarea>
													<textarea rows="2" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsNBStateCEC[$index].remarks" cols="10" readonly="readonly" autocomplete="off"></textarea>
												</td>
											</tr>
											
											
											
                              </tbody>
                              <tfoot>
                                 			<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.SubTotal" htmlEscape="true" />(SPRC)</strong></td>
												<td>
													<div align="center" data-ng-style="{'color':(subTotalFundStateNBS >subTotalFundCECNBS) ? 'red' : '#00cc00'}">
													<strong>{{subTotalFundStateNBS}}</strong></div>
													<input type="text" class="form-control" value="{{subTotalFundCECNBS}}" disabled="disabled" style="text-align:right;"/>
												</td>
												<td colspan="2" ></td>
											</tr>
											
											<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.AdditionalRequirement" htmlEscape="true" /> (SPRC)</strong></td>
												<td>
													<div align="center" data-ng-style="{'color':(planstateAdditionalRequirementState >planstateAdditionalRequirementCEC) ? 'red' : '#00cc00'}">
													<strong>{{planstateAdditionalRequirementState}}</strong></div>
													<input type="text" onkeypress="return isNumber(event)" class="form-control" data-ng-readonly="institutionalInfraActivityPlan.isFreeze" data-ng-model="planstateAdditionalRequirementCEC" placeholder=" 25% of Grand Total cost " data-ng-keyup="calculate_total_fund(1,null,null)" maxlength="8" style="text-align:right;" autocomplete="off"/>
													<!-- <input type="text" restrict-input="{type: 'digitsOnly'}" class="form-control" data-ng-show="institutionalInfraActivityPlan.isFreeze || trainingInstituteTypeId == 4" data-ng-model="institutionalInfraActivityPlan.additionalRequirement" placeholder=" 25% of Grand Total cost " readonly="readonly" id="additionalRequirementId" style="text-align:right;"/> -->
												</td>
												<td colspan="2" ></td>
											</tr>
											<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (SPRC)</strong></td>
												<td>
												<div align="center" data-ng-style="{'color':(totalFundStateNBS >totalFundCECNBS) ? 'red' : '#00cc00'}">
												<strong>{{totalFundStateNBS}}</strong></div>
												<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="totalFundCECNBS" style="text-align:right;" readonly="readonly"/>
												<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="totalFundCECNBS" readonly="readonly" style="text-align:right;"/>
												</td>
												<td colspan="2" ></td>
											</tr>
											<tr>
											</tr>
											<tr>
											</tr>
                              </tfoot>
                              
                             
                           </table>
                          
                           </div>
                         </div> 
                           
                         <div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.NewBuilding" htmlEscape="true" />(DPRC)
                           </div>
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                            <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
													<th><div  class="padding_left_local">
														<strong><spring:message code="Label.BuildingType" htmlEscape="true" />
														</strong>
													</div></th>
													
													<th>
														<div align="center">
															<strong><spring:message code="Label.District" htmlEscape="true" /> 
															</strong>
														</div>
													</th>
													
														
											
												<th><div align="center">
														<strong><spring:message code="Label.Funds" htmlEscape="true" />  
														</strong>
													</div></th>
												<!-- <th><div align="center">
														<strong>Total Fund<br>(B = A + Funds required <br>in carry forward section)
														</strong>
													</div></th> -->
												<th > 
													<div align="center">
														<strong><spring:message code="Label.IsApproved" htmlEscape="true" />
														</strong>
													</div>
												</th>	
													
												<th> 
													<div align="center">
														<strong><spring:message code="Label.Remarks" htmlEscape="true" />
														</strong>
													</div>
												</th>
											</tr>
							  </thead>
                              <tbody>
                                 <tr data-ng-repeat="details in institutionalPlanDetailsNBDistrict | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
												<td  class="padding_left_local"><strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong></td>
												<td align="center"><strong>{{details.districtName}}</strong></td>
											
												<td>
												<div align="center" data-ng-style="{'color':(institutionalPlanDetailsNBStateCEC[$index].fundProposed < details.fundProposed) ? 'red' : '#00cc00'}">
												<strong>{{institutionalPlanDetailsNBDistrict[$index].fundProposed}}</strong></div>
												<input type="text" onkeypress="return isNumber(event)" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsNBDistrictCEC[$index].fundProposed" class="form-control" id="fundProposedId" data-ng-keyup="calculate_total_fund(2,$index,null)" maxlength="8" style="text-align:right;" required="required" autocomplete="off"/>
													<input type="number" onkeypress="return isNumber(event)" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsNBDistrictCEC[$index].fundProposed" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<!-- <td>
													<input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsNB[$index].totalFund" class="form-control" id="totalFundId" data-ng-keyup="calculationDependentField(trainingInstituteTypeId)" readonly="readonly" style="text-align:right;"/>
													<input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBlInfraActivityPlanDetails[$index].totalFund" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td> -->
												
												<td align="center">
													<input type="checkbox" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsNBDistrictCEC[$index].isApproved">
													<input type="checkbox" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsNBDistrictCEC[$index].isApproved" disabled="disabled">
												</td>
												<td align="center">
													<div align="center" data-ng-style="{'color':(institutionalPlanDetailsNBStateCEC[$index].remarks < details.remarks) ? 'red' : '#00cc00'}">
													<strong>{{institutionalPlanDetailsNBDistrict[$index].remarks}}</strong></div>
													<textarea rows="2" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsNBDistrictCEC[$index].remarks" cols="10" autocomplete="off"></textarea>
													<textarea rows="2" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsNBDistrictCEC[$index].remarks" cols="10" readonly="readonly"></textarea>
												</td>
											</tr>
											
											
											
                              </tbody>
                              <tfoot>
                                 			<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.SubTotal" htmlEscape="true" />(DPRC)</strong></td>
												<td>
													<div align="center" data-ng-style="{'color':(subTotalFundStateNBD >subTotalFundCECNBD) ? 'red' : '#00cc00'}">
													<strong>{{subTotalFundStateNBD}}</strong></div>
													<input type="text" class="form-control" value="{{subTotalFundCECNBD}}" disabled="disabled" style="text-align:right;"/>
												</td>
												<td colspan="2" ></td>
											</tr>
											
											<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.AdditionalRequirement" htmlEscape="true" /> (DPRC)</strong></td>
												<td>
													<div align="center" data-ng-style="{'color':(plandistrictAdditionalRequirementState >plandistrictAdditionalRequirementCEC) ? 'red' : '#00cc00'}">
													<strong>{{plandistrictAdditionalRequirementState}}</strong></div>
													<input type="text" onkeypress="return isNumber(event)" class="form-control" data-ng-readonly="institutionalInfraActivityPlan.isFreeze" data-ng-model="plandistrictAdditionalRequirementCEC" placeholder=" 25% of Grand Total cost " data-ng-keyup="calculate_total_fund(2,null,null)" maxlength="8" style="text-align:right;" autocomplete="off"/>
													<!-- <input type="text" restrict-input="{type: 'digitsOnly'}" class="form-control" data-ng-show="institutionalInfraActivityPlan.isFreeze || trainingInstituteTypeId == 4" data-ng-model="institutionalInfraActivityPlan.additionalRequirement" placeholder=" 25% of Grand Total cost " readonly="readonly" id="additionalRequirementId" style="text-align:right;"/> -->
												</td>
												<td colspan="2" ></td>
											</tr>
											<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (DPRC)</strong></td>
												<td>
												<div align="center" data-ng-style="{'color':(totalFundStateNBD >totalFundCECNBD) ? 'red' : '#00cc00'}">
												<strong>{{totalFundStateNBD}}</strong></div>
												<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="grandTotalNBD" style="text-align:right;" readonly="readonly"/>
												<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="grandTotalNBD" readonly="readonly" style="text-align:right;"/>
												</td>
												<td colspan="2" ></td>
											</tr>
											<tr>
											</tr>
											<tr>
											</tr>
                              </tfoot>
                              
                             
                           </table>
                        </div>
                     </div>
						
						
						
					<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.CarryForward" htmlEscape="true" />(SPRC)
                           </div>
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                          
					  
							
                           <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
													<th><div  class="padding_left_local">
														<strong><spring:message code="Label.BuildingType" htmlEscape="true" />
														</strong>
													</div></th>
													
													<th>
														<div align="center">
															<strong><spring:message code="Label.District" htmlEscape="true" /> 
															</strong>
														</div>
													</th>
													
														
											
												<th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.sanction"
			                                             htmlEscape="true" />
			                                       </strong>
			                                    </div>
			                                 </th>
			                                 <th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.release"
			                                             htmlEscape="true" />
			                                       </strong>
			                                       <br> A
			                                    </div>
			                                 </th>
			                                 <th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.utilize"
			                                             htmlEscape="true" />
			                                       </strong>
			                                       <br> B
			                                    </div>
			                                 </th>
			                                 <th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.required"
			                                             htmlEscape="true" />
			                                       </strong>
			                                       <br>C=A-B
			                                    </div>
			                                 </th>
			                                 <th > 
													<div align="center">
														<strong><spring:message code="Label.IsApproved" htmlEscape="true" />
														</strong>
													</div>
												</th>	
													
												<th> 
													<div align="center">
														<strong><spring:message code="Label.Remarks" htmlEscape="true" />
														</strong>
													</div>
												</th>
											</tr>
										</thead>
                              <tbody>
                                 <tr data-ng-repeat="details in institutionalPlanDetailsCFState | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
												<td class="padding_left_local"><strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong></td>
												<td align="center"><strong>{{details.districtName}}</strong></td>
												
												
												
												
												<td>
												<div align="center" data-ng-style="{'color':(institutionalPlanDetailsCFStateCEC[$index].fundSanctioned < details.fundSanctioned) ? 'red' : '#00cc00'}">
												<strong>{{details.fundSanctioned}}</strong></div>
													<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalPlanDetailsCFStateCEC[$index].fundSanctioned" class="form-control"  data-ng-keyup="calculate_total_fund(3,$index,'SAN')"  style="text-align:right;" autocomplete="off"/>
													<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFStateCEC[$index].fundSanctioned" class="form-control" readonly="readonly" style="text-align: right;"/>
												</td>
												<td>
												<div align="center" data-ng-style="{'color':(institutionalPlanDetailsCFStateCEC[$index].fundReleased < details.fundReleased) ? 'red' : '#00cc00'}">
												<strong>{{details.fundReleased}}</strong></div>
													<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalPlanDetailsCFStateCEC[$index].fundReleased" class="form-control"  data-ng-keyup="calculate_total_fund(3,$index,'REL')"  style="text-align:right;" autocomplete="off"/>
													<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFStateCEC[$index].fundReleased" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<td>
													<div align="center" data-ng-style="{'color':(institutionalPlanDetailsCFStateCEC[$index].fundUtilized < details.fundUtilized) ? 'red' : '#00cc00'}">
													<strong>{{details.fundUtilized}}</strong></div>
													<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalPlanDetailsCFStateCEC[$index].fundUtilized" class="form-control"  data-ng-keyup="calculate_total_fund(3,$index,'UTI')"  style="text-align:right;" autocomplete="off"/>
													<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFStateCEC[$index].fundUtilized" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<td>
													<div align="center" data-ng-style="{'color':(institutionalPlanDetailsCFStateCEC[$index].fundRequired < details.fundRequired) ? 'red' : '#00cc00'}">
													<strong>{{details.fundRequired}}</strong></div>
													<input type="text"  data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFStateCEC[$index].fundRequired" class="form-control" readonly="readonly" style="text-align:right;"/>
													<input type="text"  data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFStateCEC[$index].fundRequired" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<td align="center">
													<input type="checkbox" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFStateCEC[$index].isApproved">
													<input type="checkbox" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFStateCEC[$index].isApproved" disabled="disabled">
												</td>
												<td>
													<div align="center" data-ng-style="{'color':(institutionalPlanDetailsCFStateCEC[$index].remarks < details.remarks) ? 'red' : '#00cc00'}">
													<strong>{{details.remarks}}</strong></div>
													<textarea rows="2" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFStateCEC[$index].remarks" cols="10" autocomplete="off"></textarea>
													<textarea rows="2" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFStateCEC[$index].remarks" cols="10" readonly="readonly"></textarea>
												</td>
												
											</tr>
											
											
											
                              </tbody>
                              <tfoot>
                                 			
											<tr >
												<td colspan="5" class="padding_left_local"><strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (SPRC)</strong></td>
												<td>
												<div align="center" data-ng-style="{'color':(subTotalFundStateCFS < subTotalFundCECCFS) ? 'red' : '#00cc00'}">
													<strong>{{subTotalFundStateCFS}}</strong></div>
												
												<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="subTotalFundCECCFS" style="text-align:right;" readonly="readonly"/>
												<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="subTotalFundCECCFS" readonly="readonly" style="text-align:right;"/>
												</td>
											</tr>
                              </tfoot>
                           </table>
                          
                          </div>
                       </div> 
                           
					  <div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.CarryForward" htmlEscape="true" />(DPRC)
                           </div>
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
					  
					  
                           <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
													<th class="padding_left_local"><div >
														<strong><spring:message code="Label.BuildingType" htmlEscape="true" />
														</strong>
													</div></th>
													
													<th>
														<div align="center">
															<strong><spring:message code="Label.District" htmlEscape="true" /> 
															</strong>
														</div>
													</th>
													
														
											
												<th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.sanction"
			                                             htmlEscape="true" />
			                                       </strong>
			                                    </div>
			                                 </th>
			                                 <th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.release"
			                                             htmlEscape="true" />
			                                       </strong>
			                                       <br> A
			                                    </div>
			                                 </th>
			                                 <th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.utilize"
			                                             htmlEscape="true" />
			                                       </strong>
			                                       <br> B
			                                    </div>
			                                 </th>
			                                 <th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.required"
			                                             htmlEscape="true" />
			                                       </strong>
			                                       <br>C=A-B
			                                    </div>
			                                 </th>
			                                 <th > 
													<div align="center">
														<strong><spring:message code="Label.IsApproved" htmlEscape="true" />
														</strong>
													</div>
												</th>	
													
												<th> 
													<div align="center">
														<strong><spring:message code="Label.Remarks" htmlEscape="true" />
														</strong>
													</div>
												</th>
											</tr>
										</thead>
                              <tbody>
                                 <tr data-ng-repeat="details in institutionalPlanDetailsCFDistrict | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
												<td class="padding_left_local"><strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong></td>
												<td align="center"><strong>{{details.districtName}}</strong></td>
												
												
												
												
												<td>
												<div align="center" data-ng-style="{'color':(institutionalPlanDetailsCFDistrictCEC[$index].fundSanctioned < details.fundSanctioned) ? 'red' : '#00cc00'}">
												<strong>{{details.fundSanctioned}}</strong></div>
													<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalPlanDetailsCFDistrictCEC[$index].fundSanctioned" class="form-control"  data-ng-keyup="calculate_total_fund(4,$index,'SAN')"  style="text-align:right;" autocomplete="off"/>
													<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFDistrictCEC[$index].fundSanctioned" class="form-control" readonly="readonly" style="text-align: right;"/>
												</td>
												<td>
													<div align="center" data-ng-style="{'color':(institutionalPlanDetailsCFDistrictCEC[$index].fundReleased < details.fundReleased) ? 'red' : '#00cc00'}">
													<strong>{{details.fundReleased}}</strong></div>
													<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalPlanDetailsCFDistrictCEC[$index].fundReleased" class="form-control"  data-ng-keyup="calculate_total_fund(4,$index,'REL')"  style="text-align:right;" autocomplete="off"/>
													<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFDistrictCEC[$index].fundReleased" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<td>
													<div align="center" data-ng-style="{'color':(institutionalPlanDetailsCFDistrictCEC[$index].fundUtilized < details.fundUtilized) ? 'red' : '#00cc00'}">
													<strong>{{details.fundUtilized}}</strong></div>
													<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalPlanDetailsCFDistrictCEC[$index].fundUtilized" class="form-control"  data-ng-keyup="calculate_total_fund(4,$index,'UTI')"  style="text-align:right;" autocomplete="off"/>
													<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFDistrictCEC[$index].fundUtilized" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<td>
													<div align="center" data-ng-style="{'color':(institutionalPlanDetailsCFDistrictCEC[$index].fundRequired < details.fundRequired) ? 'red' : '#00cc00'}">
													<strong>{{details.fundRequired}}</strong></div>
													<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalPlanDetailsCFDistrictCEC[$index].fundRequired" class="form-control"  readonly="readonly" style="text-align:right;"/>
													<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFDistrictCEC[$index].fundRequired" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<td align="center">
													<input type="checkbox" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFDistrictCEC[$index].isApproved">
													<input type="checkbox" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFDistrictCEC[$index].isApproved" disabled="disabled">
												</td>
												<td align="center">
													<div align="center" data-ng-style="{'color':(institutionalPlanDetailsCFDistrictCEC[$index].remarks < details.remarks) ? 'red' : '#00cc00'}">
													<strong>{{details.remarks}}</strong></div>
													<textarea rows="2" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFDistrictCEC[$index].remarks" cols="10" autocomplete="off"></textarea>
													<textarea rows="2" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalPlanDetailsCFDistrictCEC[$index].remarks" cols="10" readonly="readonly"></textarea>
												</td>
											</tr>
											
											
											
                              </tbody>
                              <tfoot>
                                 			
											<tr >
												<td colspan="5" class="padding_left_local"><strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (DPRC)</strong></td>
												<td>
												<div align="center" data-ng-style="{'color':(subTotalFundStateCFD < subTotalFundCECCFD) ? 'red' : '#00cc00'}">
												<strong>{{subTotalFundStateCFD}}</strong></div>
												<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="subTotalFundCECCFD" style="text-align:right;" readonly="readonly"/>
												<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="subTotalFundCECCFD" readonly="readonly" style="text-align:right;"/>
												</td>
											</tr>
                              </tfoot>
                           </table>
                        </div>
                     </div>
								
								
								
						<div class="col-md-4">
							<button type="button"
								onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
								class="btn bg-orange waves-effect">
								<i class="fa fa-arrow-left" aria-hidden="true"></i>
								<spring:message code="Label.BACK" htmlEscape="true" />
							</button>
					    </div>
									
						<div class="form-group text-right">
									 
								<button data-ng-show="institutionalInfraActivityPlan.isFreeze" type="button" class="btn bg-green waves-effect" disabled="disabled"><spring:message code="Label.SAVE" htmlEscape="true"/></button>
								<button data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-click="save_data('S')" type="button" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
								<button data-ng-show="institutionalInfraActivityPlan.isFreeze" type="button" data-ng-click="save_data('U')" class="btn bg-green waves-effect">
									<spring:message code="UNFREEZE" htmlEscape="true" />
								</button>
								<button data-ng-show="!institutionalInfraActivityPlan.isFreeze "    data-ng-click="save_data('F')" class="btn bg-green waves-effect">
									<spring:message code="FREEZE" htmlEscape="true" />
								</button>
							
								<button type="button" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-click="load_data()" class="btn bg-light-blue waves-effect" disabled="disabled"><spring:message code="Label.CLEAR" htmlEscape="true"/></button>
								<button type="button" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-click="load_data()" class="btn bg-light-blue waves-effect"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
								
								<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-orange waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
								<br/>
								<br/>
						</div>

									
									
								
							</div>
							
							
							
							
							<div role="tabpanel" class="container tab-pane" id="MOPR"
								style="width: auto;">
								
								
					<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.NewBuilding" htmlEscape="true" />(SPRC)
                           </div>
                           
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                           
                           
                           <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
													<th class="padding_left_local"><div >
														<strong><spring:message code="Label.BuildingType" htmlEscape="true" />
														</strong>
													</div></th>
													
													<th>
														<div align="center">
															<strong><spring:message code="Label.District" htmlEscape="true" /> 
															</strong>
														</div>
													</th>
													
														
											
												<th><div align="center">
														<strong><spring:message code="Label.Funds" htmlEscape="true" />
														</strong>
													</div></th>
												<!-- <th><div align="center">
														<strong>Total Fund<br>(B = A + Funds required <br>in carry forward section)
														</strong>
													</div></th> -->
												<th > 
													<div align="center">
														<strong><spring:message code="Label.IsApproved" htmlEscape="true" />
														</strong>
													</div>
												</th>	
													
												<th> 
													<div align="center">
														<strong><spring:message code="Label.Remarks" htmlEscape="true" />
														</strong>
													</div>
												</th>
											</tr>
							  </thead>
                              <tbody>
                                 <tr data-ng-repeat="details in institutionalPlanDetailsNBStateMOPR | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
												<td class="padding_left_local"><strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong></td>
												<td ><strong>{{details.districtName}}</strong></td>
											
												<td align="center">
												<strong>{{details.fundProposed}}</strong>
												</td>
												<!-- <td>
													<input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsNB[$index].totalFund" class="form-control" id="totalFundId" data-ng-keyup="calculationDependentField(trainingInstituteTypeId)" readonly="readonly" style="text-align:right;"/>
													<input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBlInfraActivityPlanDetails[$index].totalFund" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td> -->
												
												<td align="center">
													
													<input type="checkbox"  data-ng-model="details.isApproved" disabled="disabled">
												</td>
												<td align="center">
													<strong>{{details.remarks}}</strong>
													
												</td>
											</tr>
											
											
											
                              </tbody>
                              <tfoot>
                                 			<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.SubTotal" htmlEscape="true" />(SPRC)</strong></td>
												<td align="center">
												
													<strong>{{subTotalFundMOPRNBS}}</strong>	
												</td>
												<td colspan="2" ></td>
											</tr>
											
											<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.AdditionalRequirement" htmlEscape="true" /> (SPRC)</strong></td>
												<td align="center">
													<strong>{{planstateAdditionalRequirementMOPR}}</strong>	
												</td>
												<td colspan="2" ></td>
											</tr>
											<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (SPRC)</strong></td>
												<td align="center">
													<strong>{{totalFundMOPRNBS}}</strong>	
												</td>
												<td colspan="2" ></td>
											</tr>
											<tr>
											</tr>
											<tr>
											</tr>
                              </tfoot>
                              
                             
                           </table>
                           
                           
                           </div>
                       </div>
                           
                           <div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.NewBuilding" htmlEscape="true" />(DPRC)
                           </div>
                           
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                           
                            <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
													<th><div  class="padding_left_local">
														<strong><spring:message code="Label.BuildingType" htmlEscape="true" />
														</strong>
													</div></th>
													
													<th>
														<div align="center">
															<strong><spring:message code="Label.District" htmlEscape="true" /> 
															</strong>
														</div>
													</th>
													
														
											
												<th><div align="center">
														<strong><spring:message code="Label.Funds" htmlEscape="true" />  
														</strong>
													</div></th>
												<!-- <th><div align="center">
														<strong>Total Fund<br>(B = A + Funds required <br>in carry forward section)
														</strong>
													</div></th> -->
												<th > 
													<div align="center">
														<strong><spring:message code="Label.IsApproved" htmlEscape="true" />
														</strong>
													</div>
												</th>	
													
												<th> 
													<div align="center">
														<strong><spring:message code="Label.Remarks" htmlEscape="true" />
														</strong>
													</div>
												</th>
											</tr>
							  </thead>
                               <tbody>
                                 <tr data-ng-repeat="details in institutionalPlanDetailsNBDistrictMOPR | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
												<td class="padding_left_local"><strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong></td>
												<td ><strong>{{details.districtName}}</strong></td>
											
												<td align="center">
												<strong>{{details.fundProposed}}</strong>
												</td>
												<!-- <td>
													<input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsNB[$index].totalFund" class="form-control" id="totalFundId" data-ng-keyup="calculationDependentField(trainingInstituteTypeId)" readonly="readonly" style="text-align:right;"/>
													<input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBlInfraActivityPlanDetails[$index].totalFund" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td> -->
												
												<td align="center">
													
													<input type="checkbox"  data-ng-model="details.isApproved" disabled="disabled">
												</td>
												<td align="center">
													<strong>{{details.remarks}}</strong>
													
												</td>
											</tr>
											
											
											
                              </tbody>
                              <tfoot>
                                 			<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.SubTotal" htmlEscape="true" />(DPRC)</strong></td>
												<td align="center">
													<strong>{{subTotalFundMOPRNBD}}</strong>	
												</td>
												<td colspan="2" ></td>
											</tr>
											
											<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.AdditionalRequirement" htmlEscape="true" /> (DPRC)</strong></td>
												<td align="center">
													<strong>{{plandistrictAdditionalRequirementMOPR}}</strong>
												</td>
												<td colspan="2" ></td>
											</tr>
											<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (DPRC)</strong></td>
												<td align="center">
													<strong>{{totalFundMOPRNBD}}</strong>
												</td>
												<td colspan="2" ></td>
											</tr>
											<tr>
											</tr>
											<tr>
											</tr>
                              </tfoot>
                              
                             
                           </table>
                        </div>
                     </div>
						
						
						
					<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.CarryForward" htmlEscape="true" />(SPRC)
                           </div>
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                          
					  
							<br/>
                           <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
													<th><div  class="padding_left_local">
														<strong><spring:message code="Label.BuildingType" htmlEscape="true" />
														</strong>
													</div></th>
													
													<th>
														<div align="center">
															<strong><spring:message code="Label.District" htmlEscape="true" /> 
															</strong>
														</div>
													</th>
													
														
											
												<th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.sanction"
			                                             htmlEscape="true" />
			                                       </strong>
			                                    </div>
			                                 </th>
			                                 <th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.release"
			                                             htmlEscape="true" />
			                                       </strong>
			                                       <br> A
			                                    </div>
			                                 </th>
			                                 <th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.utilize"
			                                             htmlEscape="true" />
			                                       </strong>
			                                       <br> B
			                                    </div>
			                                 </th>
			                                 <th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.required"
			                                             htmlEscape="true" />
			                                       </strong>
			                                       <br>C=A-B
			                                    </div>
			                                 </th>
			                                 <th > 
													<div align="center">
														<strong><spring:message code="Label.IsApproved" htmlEscape="true" />
														</strong>
													</div>
												</th>	
													
												<th> 
													<div align="center">
														<strong><spring:message code="Label.Remarks" htmlEscape="true" />
														</strong>
													</div>
												</th>
											</tr>
										</thead>
                              <tbody>
                                 <tr data-ng-repeat="details in institutionalPlanDetailsCFStateMOPR | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
												<td class="padding_left_local"><strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong></td>
												<td align="center"><strong>{{details.districtName}}</strong></td>
												
												
												
												
												<td align="center">
												<strong>{{details.fundSanctioned}}</strong>
												</td>
												<td align="center">
												<strong>{{details.fundReleased}}</strong>
												</td>
												<td align="center">
													<strong>{{details.fundUtilized}}</strong>
													</td>
												<td align="center">
													<strong>{{details.fundRequired}}</strong>
													</td>
												<td align="center">
													<input type="checkbox"  data-ng-model="details.isApproved" disabled="disabled">
												<td align="center">
													<strong>{{details.remarks}}</strong>
												</td>
												
											</tr>
											
											
											
                              </tbody>
                              <tfoot>
                                 			
											<tr >
												<td colspan="5" class="padding_left_local"><strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (SPRC)</strong></td>
												<td align="center">
												<strong>{{subTotalFundMOPRCFS}}</strong>
												</td>
											</tr>
                              </tfoot>
                           </table>
                           
                           </div>
                         </div>
					  
					 <div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.CarryForward" htmlEscape="true" />(DPRC)
                           </div>
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                           <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
													<th class="padding_left_local"><div >
														<strong><spring:message code="Label.BuildingType" htmlEscape="true" />
														</strong>
													</div></th>
													
													<th>
														<div align="center">
															<strong><spring:message code="Label.District" htmlEscape="true" /> 
															</strong>
														</div>
													</th>
													
														
											
												<th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.sanction"
			                                             htmlEscape="true" />
			                                       </strong>
			                                    </div>
			                                 </th>
			                                 <th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.release"
			                                             htmlEscape="true" />
			                                       </strong>
			                                       <br> A
			                                    </div>
			                                 </th>
			                                 <th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.utilize"
			                                             htmlEscape="true" />
			                                       </strong>
			                                       <br> B
			                                    </div>
			                                 </th>
			                                 <th>
			                                    <div align="center">
			                                       <strong>
			                                          <spring:message code="Label.fund.required"
			                                             htmlEscape="true" />
			                                       </strong>
			                                       <br>C=A-B
			                                    </div>
			                                 </th>
			                                 <th > 
													<div align="center">
														<strong><spring:message code="Label.IsApproved" htmlEscape="true" />
														</strong>
													</div>
												</th>	
													
												<th> 
													<div align="center">
														<strong><spring:message code="Label.Remarks" htmlEscape="true" />
														</strong>
													</div>
												</th>
											</tr>
										</thead>
                              <tbody>
                                 <tr data-ng-repeat="details in institutionalPlanDetailsCFDistrictMOPR | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
												<td class="padding_left_local"><strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong></td>
												<td align="center"><strong>{{details.districtName}}</strong></td>
												
												
												
												
												<td align="center">
												<strong>{{details.fundSanctioned}}</strong>
												</td>
												<td align="center">
												<strong>{{details.fundReleased}}</strong>
												</td>
												<td align="center">
													<strong>{{details.fundUtilized}}</strong>
													</td>
												<td align="center">
													<strong>{{details.fundRequired}}</strong>
													</td>
												<td align="center">
													<input type="checkbox"  data-ng-model="details.isApproved" disabled="disabled">
												<td align="center">
													<strong>{{details.remarks}}</strong>
												</td>
												
											</tr>
											
											
											
                              </tbody>
                              <tfoot>
                                 			
											<tr >
												<td colspan="5" class="padding_left_local"><strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (DPRC)</strong></td>
												<td align="center">
												<strong>{{subTotalFundMOPRCFD}}</strong>
												</td>
											</tr>
                              </tfoot>
                           </table>
                        </div>
                     </div>

								<div class="table-responsive">
								
									<div class="col-md-4">
										<button type="button"
											onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
											class="btn bg-orange waves-effect">
											<i class="fa fa-arrow-left" aria-hidden="true"></i>
											<spring:message code="Label.BACK" htmlEscape="true" />
										</button>
									</div>

									<div class=" col-md-8 text-right">
										<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">
											<spring:message code="Label.CLOSE" htmlEscape="true" />
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
</html>