<%@include file="../taglib/taglib.jsp"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/institutionalInfraActivityPlan/institutionalInfraActivityPlanControllerMOPR.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/institutionalInfraActivityPlan/institutionalInfraActivityPlanService.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>
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
<style>
.padding_left_local {
   padding-left: 85px !important;
 }

</style>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<html data-ng-app="publicModule">
	<section class="content" data-ng-controller="institutionalInfraActivityPlanController">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2><spring:message code="Label.InstitutionalInfrastructure" htmlEscape="true" /></h2>
						</div>
						
						<form>
					
							 
									
					   
						<div class="records" id="sprcNewBlock">
                        <div class="">
                           <div  class="col-lg-12 sub_head" style="background-color: #b39ad8;color: #2f2b2bf2;">
                              <spring:message code="Label.NewBuilding" htmlEscape="true" />(SPRC)
                           </div>
                           
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                           
                           
                           <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
													<th class="padding_left_local" rowspan="2"><div >
														<strong><spring:message code="Label.BuildingType" htmlEscape="true" />
														</strong>
													</div></th>
													
													<th rowspan="2">
														<div align="center">
															<strong><spring:message code="Label.District" htmlEscape="true" /> 
															</strong>
														</div>
													</th>
													
														
											
												<th rowspan="2"><div align="center">
														<strong><spring:message code="Label.Funds" htmlEscape="true" />
														</strong>
													</div></th>
												<!-- <th><div align="center">
														<strong>Total Fund<br>(B = A + Funds required <br>in carry forward section)
														</strong>
													</div></th> -->
												<th rowspan="2"> 
													<div align="center">
														<strong><spring:message code="Label.IsApproved"  htmlEscape="true" />
														</strong>
													</div>
												</th>	
													
												<th rowspan="2"> 
													<div align="center">
														<strong><spring:message code="Label.Remarks" htmlEscape="true" />
														</strong>
													</div>
												</th>
												<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
														<th colspan="2">
															<div align="center">
																<strong>
																	Previous comment history
																</strong>
															</div>
														</th> 
													</c:if>
											</tr>
											<tr>
													<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
														<th>
															<div align="center">
																<strong>State Previous Comments <span
																	style="color: #396721;">&nbsp;<i
																		class="fa fa-circle"></i></span></strong>
															</div>
														</th>
														<th>
															<div align="center">
																<strong>MOPR's Feedback <span
																	style="color: #bc6317;">&nbsp;<i
																		class="fa fa-circle"></i></span></strong>
															</div>
														</th>
													</c:if>
											</tr>
							  </thead>
                              <tbody>
                                 <tr data-ng-repeat="details in institutionalInfraActivityPlanDetailsNBState | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
												<td class="padding_left_local"><strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong></td>
												<td ><strong>{{details.districtName}}</strong></td>
											
												<td>
												<input type="text" onkeypress="return isNumber(event)" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBState[$index].fundProposed" class="form-control" id="fundProposedId" data-ng-keyup="calculate_total_fund(1,$index,null)" maxlength="8" style="text-align:right;" required="required" autocomplete="off"/>
												<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBState[$index].fundProposed" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<!-- <td>
													<input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsNB[$index].totalFund" class="form-control" id="totalFundId" data-ng-keyup="calculationDependentField(trainingInstituteTypeId)" readonly="readonly" style="text-align:right;"/>
													<input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBlInfraActivityPlanDetails[$index].totalFund" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td> -->
												
												<td align="center">
													<input type="checkbox" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBState[$index].isApproved">
													<input type="checkbox" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBState[$index].isApproved" disabled="disabled">
												</td>
												<td align="center">
													<textarea rows="2" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBState[$index].remarks" cols="10" class="form-control"></textarea>
													<textarea rows="2" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBState[$index].remarks" cols="10" readonly="readonly" autocomplete="off" class="form-control"></textarea>
												</td>
												<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
															<td>
																<ol>
																	<li data-ng-repeat="details in stateSprcComments track by $index">
																			{{details}}
																	</li>
																</ol>
															</td>
															<td>
																<ol>
																	<li data-ng-repeat="details in moprSprcComments track by $index" >
																			{{details}}
																	</li>
																</ol>
															</td>
															</c:if>
											</tr>
											
											
											
                              </tbody>
                              <tfoot>
                                 			<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.SubTotal" htmlEscape="true" />(SPRC)</strong></td>
												<td>
													<input type="text" class="form-control" value="{{totalWithoutAddRequirementsNBS}}" disabled="disabled" style="text-align:right;"/>
												</td>
												<td colspan="2" ></td>
											</tr>
											
											<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.AdditionalRequirement" htmlEscape="true" /> (SPRC)</strong></td>
												<td>
													<input type="text" onkeypress="return isNumber(event)" class="form-control" data-ng-readonly="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlan.additionalRequirementNBS" placeholder=" 25% of Grand Total cost " data-ng-keyup="calculate_total_fund(1,null,null)" maxlength="8" style="text-align:right;" autocomplete="off"/>
													<!-- <input type="text" restrict-input="{type: 'digitsOnly'}" class="form-control" data-ng-show="institutionalInfraActivityPlan.isFreeze || trainingInstituteTypeId == 4" data-ng-model="institutionalInfraActivityPlan.additionalRequirement" placeholder=" 25% of Grand Total cost " readonly="readonly" id="additionalRequirementId" style="text-align:right;"/> -->
												</td>
												<td colspan="2" ></td>
											</tr>
											<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (SPRC)</strong></td>
												<td>
												<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="grandTotalNBS" style="text-align:right;" readonly="readonly"/>
												<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="grandTotalNBS" readonly="readonly" style="text-align:right;"/>
												</td>
												<td colspan="2" ></td>
											</tr>
											<tr>
											</tr>
											<tr>
											</tr>
                              </tfoot>
                              
                             
                           </table>
                           <br/>
                           <br/>
                           
                           
                        </div>
                     </div>
						
					<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head" style="background-color: #b39ad8;color: #2f2b2bf2;">
                              <spring:message code="Label.NewBuilding" htmlEscape="true" />(DPRC)
                           </div>
                           
                            <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
													<th rowspan="2"><div  class="padding_left_local">
														<strong><spring:message code="Label.BuildingType" htmlEscape="true" />
														</strong>
													</div></th>
													
													<th rowspan="2">
														<div align="center">
															<strong><spring:message code="Label.District" htmlEscape="true" /> 
															</strong>
														</div>
													</th>
													
														
											
												<th rowspan="2"><div align="center">
														<strong><spring:message code="Label.Funds" htmlEscape="true" />  
														</strong>
													</div></th>
												<!-- <th><div align="center">
														<strong>Total Fund<br>(B = A + Funds required <br>in carry forward section)
														</strong>
													</div></th> -->
												<th rowspan="2"> 
													<div align="center">
														<strong><spring:message code="Label.IsApproved" htmlEscape="true" />
														</strong>
													</div>
												</th>	
													
												<th rowspan="2"> 
													<div align="center">
														<strong><spring:message code="Label.Remarks" htmlEscape="true" />
														</strong>
													</div>
												</th>
												
												<c:if
																test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
																<th colspan="2">
																	<div align="center">
																		<strong> Previous comment history </strong>
																	</div>
																</th>
															</c:if>
											</tr>
											<tr>
														<c:if
															test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
															<th>
																<div align="center">
																	<strong>State Previous Comments <span
																		style="color: #396721;">&nbsp;<i
																			class="fa fa-circle"></i></span></strong>
																</div>
															</th>
															<th>
																<div align="center">
																	<strong>MOPR's Feedback <span
																		style="color: #bc6317;">&nbsp;<i
																			class="fa fa-circle"></i></span></strong>
																</div>
															</th>
														</c:if>
													</tr>
							  </thead>
                              <tbody>
                                 <tr data-ng-repeat="details in institutionalInfraActivityPlanDetailsNBDistrict | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
												<td  class="padding_left_local"><strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong></td>
												<td align="center"><strong>{{details.districtName}}</strong></td>
											
												<td>
												<input type="text" onkeypress="return isNumber(event)" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBDistrict[$index].fundProposed" class="form-control" id="fundProposedId" data-ng-keyup="calculate_total_fund(2,$index,null)" maxlength="8" style="text-align:right;" required="required" autocomplete="off"/>
													<input type="number" onkeypress="return isNumber(event)" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBDistrict[$index].fundProposed" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<!-- <td>
													<input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsNB[$index].totalFund" class="form-control" id="totalFundId" data-ng-keyup="calculationDependentField(trainingInstituteTypeId)" readonly="readonly" style="text-align:right;"/>
													<input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBlInfraActivityPlanDetails[$index].totalFund" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td> -->
												
												<td align="center">
													<input type="checkbox" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBDistrict[$index].isApproved">
													<input type="checkbox" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBDistrict[$index].isApproved" disabled="disabled">
												</td>
												<td align="center">
													<textarea rows="2" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBDistrict[$index].remarks" cols="10" autocomplete="off" class="form-control"></textarea>
													<textarea rows="2" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBDistrict[$index].remarks" cols="10" readonly="readonly" class="form-control"></textarea>
												</td>
												<c:if
																		test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
																		<td>
																			<ol>
																				<li data-ng-repeat="details in stateDprcComments[outerIndex] track by $index">
																						{{details}}
																				</li>
																			</ol>
																		</td>
																		<td>
																			<ol>
																				<li data-ng-repeat="details in moprDprcComments[outerIndex] track by $index">
																						{{details}}
																				</li>
																			</ol>
																		</td>
																	</c:if>
											</tr>
											
											
											
                              </tbody>
                              <tfoot>
                                 			<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.SubTotal" htmlEscape="true" />(DPRC)</strong></td>
												<td>
													<input type="text" class="form-control" value="{{totalWithoutAddRequirementsNBD}}" disabled="disabled" style="text-align:right;"/>
												</td>
												<td colspan="2" ></td>
											</tr>
											
											<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.AdditionalRequirement" htmlEscape="true" /> (DPRC)</strong></td>
												<td>
													<input type="text" onkeypress="return isNumber(event)" class="form-control" data-ng-readonly="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlan.additionalRequirementNBD" placeholder=" 25% of Grand Total cost " data-ng-keyup="calculate_total_fund(2,null,null)" maxlength="8" style="text-align:right;" autocomplete="off"/>
													<!-- <input type="text" restrict-input="{type: 'digitsOnly'}" class="form-control" data-ng-show="institutionalInfraActivityPlan.isFreeze || trainingInstituteTypeId == 4" data-ng-model="institutionalInfraActivityPlan.additionalRequirement" placeholder=" 25% of Grand Total cost " readonly="readonly" id="additionalRequirementId" style="text-align:right;"/> -->
												</td>
												<td colspan="2" ></td>
											</tr>
											<tr>
												<td colspan="2" class="padding_left_local"><strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (DPRC)</strong></td>
												<td>
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
						
					<div class="records" id="sprcCarryBlock">
                        <div class="">
                           <div  class="col-lg-12 sub_head" style="background-color: #b39ad8;color: #2f2b2bf2;">
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
											</tr>
										</thead>
                              <tbody>
                                 <tr data-ng-repeat="details in institutionalInfraActivityPlanDetailsCFState | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
												<td class="padding_left_local"><strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong></td>
												<td align="center"><strong>{{details.districtName}}</strong></td>
												
												
												
												
												<td>
													<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundSanctioned" class="form-control"  data-ng-keyup="calculate_total_fund(3,$index,'SAN')"  style="text-align:right;" autocomplete="off"/>
													<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundSanctioned" class="form-control" readonly="readonly" style="text-align: right;"/>
												</td>
												<td>
													<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundReleased" class="form-control"  data-ng-keyup="calculate_total_fund(3,$index,'REL')"  style="text-align:right;" autocomplete="off"/>
													<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundReleased" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<td>
													<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundUtilized" class="form-control"  data-ng-keyup="calculate_total_fund(3,$index,'UTI')"  style="text-align:right;" autocomplete="off"/>
													<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundUtilized" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<td>
													
													<input type="text"  data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundRequired" class="form-control" readonly="readonly" style="text-align:right;"/>
													<input type="text"  data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundRequired" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<td align="center">
													<input type="checkbox" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].isApproved">
													<input type="checkbox" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].isApproved" disabled="disabled">
												</td>
												
											</tr>
											
											
											
                              </tbody>
                              <tfoot>
                                 			
											<tr >
												<td colspan="5" class="padding_left_local"><strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (SPRC)</strong></td>
												<td>
												<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="totalWithoutAddRequirementsCFS" style="text-align:right;" readonly="readonly"/>
												<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="totalWithoutAddRequirementsCFS" readonly="readonly" style="text-align:right;"/>
												</td>
											</tr>
                              </tfoot>
                           </table>
                           
					  
							<br/>
                           
                        </div>
                     </div>
						
						
						<div class="records">
                        	<div class="">
	                           <div  class="col-lg-12 sub_head" style="background-color: #b39ad8;color: #2f2b2bf2;">
	                              <spring:message code="Label.CarryForward" htmlEscape="true" />(DPRC)
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
											</tr>
										</thead>
                              <tbody>
                                 <tr data-ng-repeat="details in institutionalInfraActivityPlanDetailsCFDistrict | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
												<td class="padding_left_local"><strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong></td>
												<td align="center"><strong>{{details.districtName}}</strong></td>
												
												
												
												
												<td>
													<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsCFDistrict[$index].fundSanctioned" class="form-control"  data-ng-keyup="calculate_total_fund(4,$index,'SAN')"  style="text-align:right;" autocomplete="off"/>
													<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFDistrict[$index].fundSanctioned" class="form-control" readonly="readonly" style="text-align: right;"/>
												</td>
												<td>
													<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsCFDistrict[$index].fundReleased" class="form-control"  data-ng-keyup="calculate_total_fund(4,$index,'REL')"  style="text-align:right;" autocomplete="off"/>
													<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFDistrict[$index].fundReleased" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<td>
													<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsCFDistrict[$index].fundUtilized" class="form-control"  data-ng-keyup="calculate_total_fund(4,$index,'UTI')"  style="text-align:right;" autocomplete="off"/>
													<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFDistrict[$index].fundUtilized" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<td>
													<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsCFDistrict[$index].fundRequired" class="form-control"  readonly="readonly" style="text-align:right;"/>
													<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFDistrict[$index].fundRequired" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<td align="center">
													<input type="checkbox" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFDistrict[$index].isApproved">
													<input type="checkbox" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFDistrict[$index].isApproved" disabled="disabled">
												</td>
											</tr>
											
											
											
                              </tbody>
                              <tfoot>
                                 			
											<tr >
												<td colspan="5" class="padding_left_local"><strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (DPRC)</strong></td>
												<td>
												<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="totalWithoutAddRequirementsCFD" style="text-align:right;" readonly="readonly"/>
												<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="totalWithoutAddRequirementsCFD"  style="text-align:right;" readonly="readonly"/>
												</td>
											</tr>
                              </tfoot>
                           </table>
                           </div>
                         </div>	
                         
                         <div class="records">
																			<div class="">
																				<div  class="col-lg-12 sub_head">
																					<!-- Grand Total -->
																					
																				</div>
																				<div class="row">
																					<div class="col-lg-12 padding_top"></div>
																				</div>
																				<table width="100%">
																				<tfoot>
																					<tr>
																						<td colspan="4" width="60%">
																							<strong>
																								Grand Total(New Building Total Fund(SPRC)+New Building Total Fund(DPRC)+Carry Forward Total Fund(SPRC)+Carry Forward Total Fund(DPRC))
																							</strong>
																						</td>
																						<td align="right" width="40%">
																							<input type="text"  class="form-control" data-ng-model="grandTotal" readonly="readonly" style="text-align:right;"/>
																						</td>
																					</tr>
																				</tfoot>
																				
																				</table>
																				<br/><br/>
																					
																			</div>
																		</div>
						
						</form>
						<br/><br/>
						
									<div class="col-md-4  text-left"  style="margin-bottom: 5px">
								&nbsp;&nbsp;<button type="button"
									onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
									class="btn bg-orange waves-effect">
									<i class="fa fa-arrow-left" aria-hidden="true"></i>
									<spring:message code="Label.BACK" htmlEscape="true" />
								</button><br>
							</div>
									<div class="form-group text-right">
									 
								<button data-ng-show="institutionalInfraActivityPlan.isFreeze" type="button" class="btn bg-green waves-effect" disabled="disabled"><spring:message code="Label.SAVE" htmlEscape="true"/></button>
								<button data-ng-show="!institutionalInfraActivityPlan.isFreeze" ng-disabled="btn_disabled" data-ng-click="save_data('S')" type="button" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
								<button data-ng-show="institutionalInfraActivityPlan.isFreeze" ng-disabled="btn_disabled" type="button" data-ng-click="save_data('U')" class="btn bg-orange waves-effect">
									<spring:message code="UNFREEZE" htmlEscape="true" />
								</button>
								<button data-ng-show="!institutionalInfraActivityPlan.isFreeze "  ng-disabled="btn_disabled"  data-ng-click="save_data('F')" class="btn bg-orange waves-effect">
									<spring:message code="FREEZE" htmlEscape="true" />
								</button>
							
								<%-- <button type="button" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-click="load_data()" class="btn bg-light-blue waves-effect" disabled="disabled"><spring:message code="Label.CLEAR" htmlEscape="true"/></button>
								<button type="button" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-click="load_data()" class="btn bg-light-blue waves-effect"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
								 --%>
								<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-red waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
								<br/>
								<br/>
							</div>
								</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</html>