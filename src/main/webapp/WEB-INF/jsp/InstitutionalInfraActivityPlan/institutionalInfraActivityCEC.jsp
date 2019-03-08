<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/institutionalInfraActivityPlan/institutionalInfraActivityPlanController.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/institutionalInfraActivityPlan/institutionalInfraActivityPlanService.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">

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

								<div class="table-responsive">
									<table class="table table-bordered table-stripped table-hover">
										<thead>
											<tr>
												<th><div align="center">
														<strong><spring:message code="Label.BuildingType"
																htmlEscape="true" /> </strong>
													</div></th>

												<th>
													<div align="center">
														<strong><spring:message code="Label.District"
																htmlEscape="true" /> </strong>
													</div>
												</th>

												<th>
													<div align="center">
														<strong><spring:message code="Label.WorkType"
																htmlEscape="true" /> </strong>
													</div>
												</th>

												<th><div align="center">
														<strong><spring:message code="Label.Funds"
																htmlEscape="true" /> <br> A </strong>
													</div></th>
												<th><div align="center">
														<strong>Total Fund<br>(B = A + Funds
															required <br>in carry forward section)
														</strong>
													</div></th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.Remarks"
																htmlEscape="true" /> </strong>
													</div>
												</th>
											</tr>
										</thead>
										<tbody>
											<tr
												data-ng-repeat="detail in institutionalInfraActivityPlanState.institutionalInfraActivityPlanDetails">
												<td><div align="center">{{detail.trainingInstitueType.trainingInstitueTypeName}}</div></td>
												<td><div align="center">{{detail.districtName}}</div></td>
												<td><div align="center"
														data-ng-if="detail.workType == 'N'">
														<spring:message code="Label.NewBuilding" htmlEscape="true" />
													</div>
													<div align="center" data-ng-if="detail.workType == 'C'">
														<spring:message code="Label.CarryForward"
															htmlEscape="true" />
													</div></td>
												<td><div align="center" data-ng-style="{'color':(detail.fundProposed > institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[$index].fundProposed) ? 'red' : '#00cc00'}"><strong>{{detail.fundProposed}}</strong></div> <input
													type="text" data-restrict-input="{type: 'digitsOnly'}"
													data-ng-disabled="institutionalInfraActivityPlan.isFreeze"
													data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[$index].fundProposed"
													class="form-control"
													data-ng-keyup="calTotalsCec($index)"
													maxlength="8" min="1" style="text-align: right;"
													required="required" /></td>
												<td><div align="center" data-ng-style="{'color':(detail.totalFund > institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[$index].totalFund) ? 'red' : '#00cc00'}"><strong>{{detail.totalFund}}</strong></div> <input
													type="text" data-restrict-input="{type: 'digitsOnly'}"
													data-ng-disabled="institutionalInfraActivityPlan.isFreeze"
													data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[$index].totalFund"
													class="form-control"
													data-ng-keyup="calculationDependentField(trainingInstituteTypeId)"
													maxlength="8" style="text-align: right;"
													readonly="readonly"/></td>
												<td><div align="center">{{detail.remarks}}</div></td>
											</tr>
											<tr>
												<td colspan="4"><strong><spring:message
															code="Label.AdditionalRequirement" htmlEscape="true" />
														(SPRC + DPRC)</strong></td>
												<td>
													<div align="center" data-ng-style="{'color':(institutionalInfraActivityPlanState.additionalRequirement > institutionalInfraActivityPlan.additionalRequirement) ? 'red' : '#00cc00'}"><strong>{{institutionalInfraActivityPlanState.additionalRequirement}}</strong></div>
													<input type="text"
													data-restrict-input="{type: 'digitsOnly'}"
													class="form-control"
													data-ng-readonly="institutionalInfraActivityPlan.isFreeze"
													data-ng-model="institutionalInfraActivityPlan.additionalRequirement"
													placeholder=" 25% of Grand Total cost "
													id="additionalRequirementId"
													data-ng-keyup="validateAdditionalRequirement()"
													maxlength="8" style="text-align: right;" />
												</td>
											</tr>
											<tr>
												<td colspan="4"><strong><spring:message
															code="Label.TotalProposedFund" htmlEscape="true" />
														(SPRC + DPRC)</strong></td>
												<td><div align="center" data-ng-style="{'color': (grandTotalState > totalFundAdditional) ? 'red' : '#00cc00'}"><strong>{{grandTotalState}}</strong></div>
													<input type="text" data-ng-init="totalFundAdditional = 0"
													data-ng-disabled="institutionalInfraActivityPlan.isFreeze"
													class="form-control" data-ng-model="totalFundAdditional"
													id="grandTotalId" style="text-align: right;"
													readonly="readonly" /></td>
											</tr>
										</tbody>
									</table>
									<div class="col-md-4">
										<button type="button"
											onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
											class="btn bg-orange waves-effect">
											<i class="fa fa-arrow-left" aria-hidden="true"></i>
											<spring:message code="Label.BACK" htmlEscape="true" />
										</button>
									</div>

									<div class="col-md-8 text-right">
											<button
												data-ng-show="institutionalInfraActivityPlan.isFreeze"
												data-ng-click="saveInstitutionalInfraActivityPlanDetails(trainingInstituteTypeId,updateStatus)"
												type="button" class="btn bg-green waves-effect"
												disabled="disabled">
												<spring:message code="Label.SAVE" htmlEscape="true" />
											</button>
											<button
												data-ng-show="!institutionalInfraActivityPlan.isFreeze"
												data-ng-click="saveInstitutionalInfraActivityPlanDetails(trainingInstituteTypeId,updateStatus)"
												type="button" class="btn bg-green waves-effect">
												<spring:message code="Label.SAVE" htmlEscape="true" />
											</button>
											<button
												data-ng-show="institutionalInfraActivityPlan.isFreeze"
												type="button"
												data-ng-click="freezUnFreezInstitutionalInfraActivityPlan('unfreez')"
												class="btn bg-green waves-effect">
												<spring:message code="UNFREEZE" htmlEscape="true" />
											</button>
											<button
												data-ng-show="!institutionalInfraActivityPlan.isFreeze "
												data-ng-disabled="updateStatus == 'saving'" type="button"
												data-ng-click="freezUnFreezInstitutionalInfraActivityPlan('freez')"
												class="btn bg-green waves-effect">
												<spring:message code="FREEZE" htmlEscape="true" />
											</button>

											<button type="button"
												data-ng-show="institutionalInfraActivityPlan.isFreeze"
												data-ng-click="onClearField()"
												class="btn bg-light-blue waves-effect" disabled="disabled">
												<spring:message code="Label.CLEAR" htmlEscape="true" />
											</button>
											<button type="button"
												data-ng-show="!institutionalInfraActivityPlan.isFreeze"
												data-ng-click="onClearField()"
												class="btn bg-light-blue waves-effect">
												<spring:message code="Label.CLEAR" htmlEscape="true" />
											</button>
										<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">
											<spring:message code="Label.CLOSE" htmlEscape="true" />
										</button>
									</div>
									<%-- <div class="form-group text-right">
										<button data-ng-show="institutionalInfraActivityPlan.isFreeze"
											data-ng-click="saveCec()"
											type="button" class="btn bg-green waves-effect"
											disabled="disabled">
											<spring:message code="Label.SAVE" htmlEscape="true" />
										</button>
										<button
											data-ng-show="!institutionalInfraActivityPlan.isFreeze"
											data-ng-click="saveCec()"
											type="button" class="btn bg-green waves-effect">
											<spring:message code="Label.SAVE" htmlEscape="true" />
										</button>
										<button data-ng-show="institutionalInfraActivityPlan.isFreeze"
											type="button"
											data-ng-click="freezUnFreezInstitutionalInfraActivityPlan('unfreez')"
											class="btn bg-green waves-effect">
											<spring:message code="UNFREEZE" htmlEscape="true" />
										</button>
										<button
											data-ng-show="!institutionalInfraActivityPlan.isFreeze "
											data-ng-disabled="updateStatus == 'saving'" type="button"
											data-ng-click="freezUnFreezInstitutionalInfraActivityPlan('freez')"
											class="btn bg-green waves-effect">
											<spring:message code="FREEZE" htmlEscape="true" />
										</button>

										<button type="button"
											data-ng-show="institutionalInfraActivityPlan.isFreeze"
											data-ng-click="onClearField()"
											class="btn bg-light-blue waves-effect" disabled="disabled">
											<spring:message code="Label.CLEAR" htmlEscape="true" />
										</button>
										<button type="button"
											data-ng-show="!institutionalInfraActivityPlan.isFreeze"
											data-ng-click="onClearField()"
											class="btn bg-light-blue waves-effect">
											<spring:message code="Label.CLEAR" htmlEscape="true" />
										</button>
										<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">
											<spring:message code="Label.CLOSE" htmlEscape="true" />
										</button>
									</div> --%>
								</div>
							</div>
							<div role="tabpanel" class="container tab-pane" id="MOPR"
								style="width: auto;">

								<div class="table-responsive">
									<table class="table table-bordered table-stripped table-hover"
										id="supportStaff">
										<thead>
											<tr>
												<th><div align="center">
														<strong><spring:message code="Label.BuildingType"
																htmlEscape="true" /> </strong>
													</div></th>

												<th>
													<div align="center">
														<strong><spring:message code="Label.District"
																htmlEscape="true" /> </strong>
													</div>
												</th>

												<th>
													<div align="center">
														<strong><spring:message code="Label.WorkType"
																htmlEscape="true" /> </strong>
													</div>
												</th>

												<th><div align="center">
														<strong><spring:message code="Label.Funds"
																htmlEscape="true" /> <br> A </strong>
													</div></th>
												<th><div align="center">
														<strong>Total Fund<br>(B = A + Funds
															required <br>in carry forward section)
														</strong>
													</div></th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.IsApproved"
																htmlEscape="true" /> </strong>
													</div>
												</th>

												<th>
													<div align="center">
														<strong><spring:message code="Label.Remarks"
																htmlEscape="true" /> </strong>
													</div>
												</th>
											</tr>
										</thead>
										<tbody>
											<tr
												data-ng-repeat="detail in institutionalInfraActivityPlanMopr.institutionalInfraActivityPlanDetails">
												<td><div align="center">{{detail.trainingInstitueType.trainingInstitueTypeName}}</div></td>
												<td><div align="center">{{detail.districtName}}</div></td>
												<td>
													<div align="center" data-ng-if="detail.workType == 'N'">
														<spring:message code="Label.NewBuilding" htmlEscape="true" />
													</div>
													<div align="center" data-ng-if="detail.workType == 'C'">
														<spring:message code="Label.CarryForward"
															htmlEscape="true" />
													</div>
												</td>
												<td><div align="center">{{detail.fundProposed}}</div></td>
												<td><div align="center">{{detail.totalFund}}</div></td>
												<td>
													<div align="center" data-ng-if="detail.isApproved">
														<i class="fa fa-check" aria-hidden="true"
															style="color: #00cc00"></i>
													</div>
													<div align="center" data-ng-if="!detail.isApproved">
														<i class="fa fa-times" aria-hidden="true"
															style="color: red"></i>
													</div>
												</td>
												<td><div align="center">{{detail.remarks}}</div></td>
											</tr>
											<tr>
												<td colspan="4"><strong><spring:message
															code="Label.AdditionalRequirement" htmlEscape="true" />
														(SPRC + DPRC)</strong></td>
												<td>
													<div align="center">{{institutionalInfraActivityPlanMopr.additionalRequirement}}</div>
												</td>
											</tr>
											<tr>
												<td colspan="4"><strong><spring:message
															code="Label.TotalProposedFund" htmlEscape="true" />
														(SPRC + DPRC)</strong></td>
												<td><div align="center">{{grandTotalMopr +
														institutionalInfraActivityPlanMopr.additionalRequirement}}</div></td>
											</tr>
										</tbody>
									</table>
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