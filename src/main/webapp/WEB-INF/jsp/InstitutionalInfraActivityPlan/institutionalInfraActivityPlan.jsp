<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/institutionalInfraActivityPlan/institutionalInfraActivityPlanController.js"></script>
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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
	<html data-ng-app="publicModule">
		<section class="content" data-ng-controller="institutionalInfraActivityPlanController">
			<div class="container-fluid">
				<div class="row clearfix">
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						<div class="card">
							<div class="header">
								<h2>
									<spring:message code="Label.InstitutionalInfrastructure" htmlEscape="true" />
								</h2>
							</div>
							<form>
								<div class="records" id="sprcNewBlock">
									<div class="">
										<div  class="col-lg-12 sub_head" style="background-color: #b39ad8;color: #2f2b2bf2;">
											<spring:message code="Label.NewBuilding" htmlEscape="true" /> (SPRC)
                           
										</div>
										<div class="row">
											<div class="col-lg-12 padding_top"></div>
										</div>
										<div class="row">
											<div class="col-lg-1"></div>
											<div class="col-lg-2">
												<label>
													<spring:message code="Label.District" htmlEscape="true" />
												</label>
											</div>
											<div class="col-lg-4">
												<select class="form-control" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="sprcDistrictNB" data-ng-change="add_row_nb(2);hideSectionsInSprc('new')" required="required">
													<option data-ng-repeat="district in districtList" value="{{district.districtCode}}">
											{{district.districtNameEnglish}}
										</option>
												</select>
												<select class="form-control" data-ng-show="institutionalInfraActivityPlan.isFreeze"  data-ng-model="sprcDistrictNB" data-ng-disabled="true">
													<option data-ng-repeat="district in districtList" value="{{district.districtCode}}">
											{{district.districtNameEnglish}}
										</option>
												</select>
											</div>
											
											<div class="col-lg-3" align="right" style="color: #3b1576;display: none;" id="newBuildingCheck">
												<input type="checkbox" id="checkboxNew" class="form-check-input" data-ng-click="hideSectionsInSprc('carry')"/> : Want to fill Carry Forward Section instead ? &nbsp;&nbsp;
											</div>
											
										</div>
										<div class="row">
											<div class="col-lg-12 padding_top"></div>
										</div>
										<table id="trainingActivityTblId" class="table table-hover dashboard-task-infos">
											<thead>
												<tr>
													<th>
														<div align="center">
															<strong>
																<spring:message code="Label.BuildingType" htmlEscape="true" />
															</strong>
														</div>
													</th>
													<th>
														<div align="center">
															<strong>
																<spring:message code="Label.District" htmlEscape="true" />
															</strong>
														</div>
													</th>
													<th>
														<div align="center">
															<strong>
																<spring:message code="Label.Funds" htmlEscape="true" />
															</strong>
														</div>
													</th>
													<!-- <th><div align="center"><strong>Total Fund<br>(B = A + Funds required <br>in carry forward section)
														</strong></div></th> -->
													<th data-ng-if="userType == 'M'">
														<div align="center">
															<strong>
																<spring:message code="Label.IsApproved" htmlEscape="true" />
															</strong>
														</div>
													</th>
													<th>
														<div align="center">
															<strong>
																<spring:message code="Label.Remarks" htmlEscape="true" />
															</strong>
														</div>
													</th>
												</tr>
											</thead>
											<tbody>
												<tr data-ng-repeat="details in institutionalInfraActivityPlanDetailsNBState | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
													<td align="center">
														<strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong>
													</td>
													<td align="center">
														<strong>{{details.districtName}}</strong>
													</td>
													<td>
														<input type="text" onkeypress="return isNumber(event)" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBState[$index].fundProposed" class="form-control" id="fundProposedId" data-ng-keyup="calculate_total_fund(1,$index,null);hideSectionsInSprc('new')" maxlength="8" style="text-align:right;" required="required" autocomplete="off"/>
														<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBState[$index].fundProposed" class="form-control" readonly="readonly" style="text-align:right;"/>
													</td>
													<!-- <td><input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsNB[$index].totalFund" class="form-control" id="totalFundId" data-ng-keyup="calculationDependentField(trainingInstituteTypeId)" readonly="readonly" style="text-align:right;"/><input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBlInfraActivityPlanDetails[$index].totalFund" class="form-control" readonly="readonly" style="text-align:right;"/></td> -->
													<td data-ng-if="userType =='M'">
														<input type="checkbox" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBState[$index].isApproved">
															<input type="checkbox" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBState[$index].isApproved" disabled="disabled">
															</td>
															<td>
																<textarea rows="2" class="form-control" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBState[$index].remarks" cols="10" data-ng-keyup="hideSectionsInSprc('new')"></textarea>
																<textarea rows="2" class="form-control" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBState[$index].remarks" cols="10" readonly="readonly" autocomplete="off"></textarea>
															</td>
														</tr>
													</tbody>
													<tfoot>
														<tr>
															<td colspan="2" style="padding-left: 9%">
																<strong>
																	<spring:message code="Label.SubTotal" htmlEscape="true" />(SPRC)
																</strong>
															</td>
															<td>
																<input type="text" class="form-control" value="{{totalWithoutAddRequirementsNBS}}" disabled="disabled" style="text-align:right;"/>
															</td>
														</tr>
														<tr>
															<td colspan="2" style="padding-left: 9%">
																<strong>
																	<spring:message code="Label.AdditionalRequirement" htmlEscape="true" /> (SPRC)
																</strong>
															</td>
															<td>
																<input type="text" onkeypress="return isNumber(event)" class="form-control" data-ng-readonly="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlan.additionalRequirementNBS" placeholder=" 25% of Grand Total cost " data-ng-keyup="calculate_total_fund(1,null,null);hideSectionsInSprc('new')" maxlength="8" style="text-align:right;" autocomplete="off"/>
																<!-- <input type="text" restrict-input="{type: 'digitsOnly'}" class="form-control" data-ng-show="institutionalInfraActivityPlan.isFreeze || trainingInstituteTypeId == 4" data-ng-model="institutionalInfraActivityPlan.additionalRequirement" placeholder=" 25% of Grand Total cost " readonly="readonly" id="additionalRequirementId" style="text-align:right;"/> -->
															</td>
														</tr>
														<tr>
															<td colspan="2" style="padding-left: 9%">
																<strong>
																	<spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (SPRC)
																</strong>
															</td>
															<td>
																<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="grandTotalNBS" style="text-align:right;" readonly="readonly"/>
																<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="grandTotalNBS" readonly="readonly" style="text-align:right;"/>
															</td>
														</tr>
														<tr></tr>
														<tr></tr>
													</tfoot>
												</table>
												<br/>
												<br/>
											</div>
										</div>
										
										
										<div class="records">
											<div class="">
												<div  class="col-lg-12 sub_head" style="background-color: #b39ad8;color: #2f2b2bf2;">
													<spring:message code="Label.NewBuilding" htmlEscape="true" /> (DPRC)
												</div>
												<div class="row">
													<div class="col-lg-12 padding_top"></div>
												</div>
												<div class="row">
													<div class="col-lg-1"></div>
													<div class="col-lg-2">
														<label>
															<spring:message code="Label.District" htmlEscape="true" />
														</label>
													</div>
													<div class="col-lg-4">
														<select class="form-control" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="dprcDistrictNB" data-ng-change="add_row_nb(4);" required="required" multiple="multiple">
															<option data-ng-repeat="district in districtList" value="{{district.districtCode}}">
																{{district.districtNameEnglish}}
															</option>
														</select>
														<select  class="form-control" data-ng-show="institutionalInfraActivityPlan.isFreeze"  data-ng-model="dprcDistrictNB" disabled="disabled" multiple="multiple">
															<option data-ng-repeat="district in districtList" value="{{district.districtCode}}">
																{{district.districtNameEnglish}}
															</option>
														</select>
													</div>
												</div>
												<div class="row">
													<div class="col-lg-12 padding_top"></div>
												</div>
												<table id="trainingActivityTblId" class="table table-hover dashboard-task-infos">
													<thead>
														<tr>
															<th>
																<div align="center">
																	<strong>
																		<spring:message code="Label.BuildingType" htmlEscape="true" />
																	</strong>
																</div>
															</th>
															<th>
																<div align="center">
																	<strong>
																		<spring:message code="Label.District" htmlEscape="true" />
																	</strong>
																</div>
															</th>
															<th>
																<div align="center">
																	<strong>
																		<spring:message code="Label.Funds" htmlEscape="true" />
																	</strong>
																</div>
															</th>
															<!-- <th><div align="center"><strong>Total Fund<br>(B = A + Funds required <br>in carry forward section)
														</strong></div></th> -->
															<th data-ng-if="userType == 'M'">
																<div align="center">
																	<strong>
																		<spring:message code="Label.IsApproved" htmlEscape="true" />
																	</strong>
																</div>
															</th>
															<th>
																<div align="center">
																	<strong>
																		<spring:message code="Label.Remarks" htmlEscape="true" />
																	</strong>
																</div>
															</th>
														</tr>
													</thead>
													<tbody>
														<tr data-ng-repeat="details in institutionalInfraActivityPlanDetailsNBDistrict | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
															<td align="center">
																<strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong>
															</td>
															<td align="center">
																<strong>{{details.districtName}}</strong>
															</td>
															<td>
																<input type="text" onkeypress="return isNumber(event)" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBDistrict[$index].fundProposed" class="form-control" id="fundProposedId" data-ng-keyup="calculate_total_fund(2,$index,null)" maxlength="8" style="text-align:right;" required="required" autocomplete="off" max="20000000"/>
																<input type="number" onkeypress="return isNumber(event)" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBDistrict[$index].fundProposed" class="form-control" readonly="readonly" style="text-align:right;"/>
															</td>
															<!-- <td><input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsNB[$index].totalFund" class="form-control" id="totalFundId" data-ng-keyup="calculationDependentField(trainingInstituteTypeId)" readonly="readonly" style="text-align:right;"/><input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBlInfraActivityPlanDetails[$index].totalFund" class="form-control" readonly="readonly" style="text-align:right;"/></td> -->
															<td data-ng-if="userType =='M'">
																<input type="checkbox" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBDistrict[$index].isApproved">
																	<input type="checkbox" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBDistrict[$index].isApproved" disabled="disabled">
																	</td>
																	<td>
																		<textarea rows="2" class="form-control"  data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBDistrict[$index].remarks" cols="10" autocomplete="off"></textarea>
																		<textarea rows="2" class="form-control"  data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsNBDistrict[$index].remarks" cols="10" readonly="readonly"></textarea>
																	</td>
																</tr>
															</tbody>
															<tfoot>
																<tr>
																	<td colspan="2" style="padding-left: 9%">
																		<strong>
																			<spring:message code="Label.SubTotal" htmlEscape="true" />(DPRC)
																		</strong>
																	</td>
																	<td>
																		<input type="text" class="form-control" value="{{totalWithoutAddRequirementsNBD}}" disabled="disabled" style="text-align:right;"/>
																	</td>
																</tr>
																<tr>
																	<td colspan="2" style="padding-left: 9%">
																		<strong>
																			<spring:message code="Label.AdditionalRequirement" htmlEscape="true" /> (DPRC)
																		</strong>
																	</td>
																	<td>
																		<input type="text" onkeypress="return isNumber(event)" class="form-control" data-ng-readonly="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlan.additionalRequirementNBD" placeholder=" 25% of Grand Total cost " data-ng-keyup="calculate_total_fund(2,null,null)" maxlength="8" style="text-align:right;" autocomplete="off"/>
																		<!-- <input type="text" restrict-input="{type: 'digitsOnly'}" class="form-control" data-ng-show="institutionalInfraActivityPlan.isFreeze || trainingInstituteTypeId == 4" data-ng-model="institutionalInfraActivityPlan.additionalRequirement" placeholder=" 25% of Grand Total cost " readonly="readonly" id="additionalRequirementId" style="text-align:right;"/> -->
																	</td>
																</tr>
																<tr>
																	<td colspan="2" style="padding-left: 9%">
																		<strong>
																			<spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (DPRC)
																		</strong>
																	</td>
																	<td>
																		<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="grandTotalNBD" style="text-align:right;" readonly="readonly"/>
																		<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="grandTotalNBD" readonly="readonly" style="text-align:right;"/>
																	</td>
																</tr>
																<tr></tr>
																<tr></tr>
															</tfoot>
														</table>
													</div>
												</div>
												
												
												<div class="records" id="sprcCarryBlock">
													<div class="">
														<div  class="col-lg-12 sub_head" style="background-color: #b39ad8;color: #2f2b2bf2;">
															<spring:message code="Label.CarryForward" htmlEscape="true" /> (SPRC)
														</div>
														<div class="row">
															<div class="col-lg-12 padding_top"></div>
														</div>
														<div class="row">
															<div class="col-lg-1"></div>
															<div class="col-lg-2">
																<label>
																	<spring:message code="Label.District" htmlEscape="true" />
																</label>
															</div>
															<div class="col-lg-4">
																<select class="form-control" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="sprcDistrictCF" data-ng-change="add_row_cf(2);hideSectionsInSprc('carry')" required="required">
																	<option data-ng-repeat="district in districtList" value="{{district.districtCode}}">
																		{{district.districtNameEnglish}}
																	</option>
																</select>
																<select class="form-control" data-ng-show="institutionalInfraActivityPlan.isFreeze"  data-ng-model="sprcDistrictCF" data-ng-disabled="true">
																	<option data-ng-repeat="district in districtList" value="{{district.districtCode}}">
																		{{district.districtNameEnglish}}
																	</option>
																</select>
																</div>
							
																<div class="col-lg-3" align="right" style="color: #3b1576;display: none;" id="carryForwardCheck">
																	<input type="checkbox" id="checkboxCarry" class="form-check-input"
																		data-ng-click="hideSectionsInSprc('new')" /> : Want to fill Carry Forward Section instead ? &nbsp;&nbsp;
																</div>
															</div>
														<div class="row">
															<div class="col-lg-12 padding_top"></div>
														</div>
														<br/>
														<table id="trainingActivityTblId"  class="table table-hover dashboard-task-infos">
															<thead>
																<tr>
																	<th>
																		<div align="center">
																			<strong>
																				<spring:message code="Label.BuildingType" htmlEscape="true" />
																			</strong>
																		</div>
																	</th>
																	<th>
																		<div align="center">
																			<strong>
																				<spring:message code="Label.District" htmlEscape="true" />
																			</strong>
																		</div>
																	</th>
																	<th>
																		<div align="center">
																			<strong>
																				<spring:message code="Label.fund.sanction"  htmlEscape="true" />
																			</strong>
																			<br> A
																		</div>
																	</th>
																	<th>
																		<div align="center">
																			<strong>
																				<spring:message code="Label.fund.release"     htmlEscape="true" />
																			</strong>
																			<br> B
			                                    
																			</div>
																		</th>
																		<th>
																			<div align="center">
																				<strong>
																					<spring:message code="Label.fund.utilize"   htmlEscape="true" />
																				</strong>
																				<br> C
			                                    
																				</div>
																			</th>
																			<th>
																				<div align="center">
																					<strong>
																						<spring:message code="Label.fund.required"  htmlEscape="true" />
																					</strong>
																					<br>D=A-B
			                                    
																					</div>
																				</th>
																			</tr>
																		</thead>
																		<tbody>
																			<tr data-ng-repeat="details in institutionalInfraActivityPlanDetailsCFState | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
																				<td align="center">
																					<strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong>
																				</td>
																				<td align="center">
																					<strong>{{details.districtName}}</strong>
																				</td>
																				<td>
																					<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundSanctioned" class="form-control"  data-ng-keyup="calculate_total_fund(3,$index,'SAN')hideSectionsInSprc('carry')"  style="text-align:right;" autocomplete="off"/>
																					<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundSanctioned" class="form-control" readonly="readonly" style="text-align: right;"/>
																				</td>
																				<td>
																					<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundReleased" class="form-control"  data-ng-keyup="calculate_total_fund(3,$index,'REL');hideSectionsInSprc('carry')"  style="text-align:right;" autocomplete="off"/>
																					<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundReleased" class="form-control" readonly="readonly" style="text-align:right;"/>
																				</td>
																				<td>
																					<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundUtilized" class="form-control"  data-ng-keyup="calculate_total_fund(3,$index,'UTI');hideSectionsInSprc('carry')"  style="text-align:right;" autocomplete="off"/>
																					<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundUtilized" class="form-control" readonly="readonly" style="text-align:right;"/>
																				</td>
																				<td>
																					<input type="text"  data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundRequired" class="form-control" readonly="readonly" style="text-align:right;"/>
																					<input type="text"  data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlanDetailsCFState[$index].fundRequired" class="form-control" readonly="readonly" style="text-align:right;"/>
																				</td>
																			</tr>
																		</tbody>
																		<tfoot>
																			<tr>
																				<td colspan="5">
																					<strong>
																						<spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (SPRC)
																					</strong>
																				</td>
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
																					<spring:message code="Label.CarryForward" htmlEscape="true" /> (DPRC)
																				</div>
																				<div class="row">
																					<div class="col-lg-12 padding_top"></div>
																				</div>
																				<div class="row">
																					<div class="col-lg-1"></div>
																					<div class="col-lg-2">
																						<label>
																							<spring:message code="Label.District" htmlEscape="true" />
																						</label>
																					</div>
																					<div class="col-lg-4">
																						<select class="form-control" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="dprcDistrictCF" data-ng-change="add_row_cf(4);" required="required" multiple="multiple">
																							<option data-ng-repeat="district in districtList" value="{{district.districtCode}}">
																								{{district.districtNameEnglish}}
																							</option>
																						</select>
																						<select class="form-control" data-ng-show="institutionalInfraActivityPlan.isFreeze"  data-ng-model="dprcDistrictCF" disabled="disabled" multiple="multiple">
																							<option data-ng-repeat="district in districtList" value="{{district.districtCode}}">
																								{{district.districtNameEnglish}}
																							</option>
																						</select>
																					</div>
																				</div>
																				<div class="row">
																					<div class="col-lg-12 padding_top"></div>
																				</div>
																				<table id="trainingActivityTblId"   class="table table-hover dashboard-task-infos">
																		<thead>
																			<tr>
																				<th>
																					<div align="center">
																						<strong>
																							<spring:message code="Label.BuildingType" htmlEscape="true" />
																						</strong>
																					</div>
																				</th>
																				<th>
																					<div align="center">
																						<strong>
																							<spring:message code="Label.District" htmlEscape="true" />
																						</strong>
																					</div>
																				</th>
																				<th>
																					<div align="center">
																						<strong>
																							<spring:message code="Label.fund.sanction"     htmlEscape="true" />
																							<br>A
																						</strong>
																					</div>
																				</th>
																				<th>
																					<div align="center">
																						<strong>
																							<spring:message code="Label.fund.release" htmlEscape="true" />
																						</strong>
																						<br> B
			                                    
																						</div>
																					</th>
																					<th>
																						<div align="center">
																							<strong>
																								<spring:message code="Label.fund.utilize" htmlEscape="true" />
																							</strong>
																							<br> C
			                                    
																							</div>
																						</th>
																						<th>
																							<div align="center">
																								<strong>
																									<spring:message code="Label.fund.required"  htmlEscape="true" />
																								</strong>
																								<br>D=A-B
			                                    
																								</div>
																							</th>
																						</tr>
																					</thead>
																					<tbody>
																						<tr data-ng-repeat="details in institutionalInfraActivityPlanDetailsCFDistrict | orderBy : 'trainingInstitueType.trainingInstitueTypeId'">
																							<td align="center">
																								<strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong>
																							</td>
																							<td align="center">
																								<strong>{{details.districtName}}</strong>
																							</td>
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
																						</tr>
																					</tbody>
																					<tfoot>
																						<tr>
																							<td colspan="5">
																								<strong>
																									<spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (DPRC)
																								</strong>
																							</td>
																							<td>
																								<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="totalWithoutAddRequirementsCFD" style="text-align:right;" readonly="readonly"/>
																								<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="totalWithoutAddRequirementsCFD" readonly="readonly" style="text-align:right;"/>
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
																						<td colspan="2" width="60%">
																							<strong>
																								Grand Total ( New Building Total Fund (SPRC) + New Building Total Fund (DPRC) + Carry Forward Total Fund (SPRC) + Carry Forward Total Fund (DPRC))
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
																	<div class="col-md-4  text-left" data-ng-if="userType =='M'" style="margin-bottom: 5px">&nbsp;&nbsp;
																		<button type="button" onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')" class="btn bg-orange waves-effect">
																			<i class="fa fa-arrow-left" aria-hidden="true"></i>
																			<spring:message code="Label.BACK" htmlEscape="true" />
																		</button>
																		<br>
																		</div>
																		<div class="form-group text-right">
																			<c:if test="${Plan_Status eq true}">
																				<button data-ng-show="institutionalInfraActivityPlan.isFreeze" type="button" class="btn bg-green waves-effect" disabled="disabled">
																					<spring:message code="Label.SAVE" htmlEscape="true"/>
																				</button>
																				<button data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-click="save_data('S')" ng-disabled="btn_disabled" type="button" class="btn bg-green waves-effect">
																					<spring:message code="Label.SAVE" htmlEscape="true" />
																				</button>
																				<button data-ng-show="institutionalInfraActivityPlan.isFreeze" type="button" data-ng-click="save_data('U')" ng-disabled="btn_disabled" class="btn bg-green waves-effect">
																					<spring:message code="UNFREEZE" htmlEscape="true" />
																				</button>
																				<button data-ng-show="!institutionalInfraActivityPlan.isFreeze "    data-ng-click="save_data('F')"  ng-disabled="btn_disabled" class="btn bg-green waves-effect">
																					<spring:message code="FREEZE" htmlEscape="true" />
																				</button>
																				<button type="button" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-click="load_data()" class="btn bg-light-blue waves-effect" disabled="disabled">
																					<spring:message code="Label.CLEAR" htmlEscape="true"/>
																				</button>
																				<button type="button" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-click="load_data()" class="btn bg-light-blue waves-effect">
																					<spring:message code="Label.CLEAR" htmlEscape="true" />
																				</button>
																			</c:if>
																			<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect">
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