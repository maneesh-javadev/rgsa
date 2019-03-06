<html data-ng-app="trainingActivityModuleCEC">
<head>
<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/trainingActivityCEC/trainingActivityCecController.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/trainingActivityCEC/trainingActivityCecService.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/customValidationDirective.js"></script>
</head>
<section class="content" data-ng-controller="trainingActivityCEC">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<div data-ng-show="userType == 'C'">
							<h2>
								<%-- <spring:message code="Label.DistanceLearningHeader"
									htmlEscape="true" /> --%>
								Training Activity (CEC)
							</h2>
						</div>

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

									<table class="table table-hover dashboard-task-infos"
										id="mytable">
										<thead>
											<tr>
												<th>
													<div align="center">
														<strong>S.No.</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Activity </strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>No. of Days </strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>No. of Units </strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Unit Cost<br>(In <i
															style="font-size: 15px" class="fa">&#xf156;</i>)
														</strong>
													</div>
												</th>

												<th>
													<div align="center">
														<strong>Funds Proposed<br>(In <i
															style="font-size: 15px" class="fa">&#xf156;</i>)
														</strong>
													</div>
												</th>
												<th><div align="center">
														<strong>Collaboration with Institute</strong>
													</div></th>
												<!-- <th>
													<div align="center">
														<strong>Is Approved</strong>
													</div>
												</th> -->
												<th>
													<div align="center">
														<strong>Remarks by State</strong>
													</div>
												</th>
											</tr>
										</thead>
										<tbody>
											<tr data-ng-repeat="cbMaster in cbmasters">
												<td>{{$index+1}}</td>
												<td>{{cbMaster.cbName}}</td>
												<td>
													<div align="center">{{stateData.capacityBuildingActivityDetails[$index].noOfDays}}</div>
												</td>
												<td>
													<div align="center">{{stateData.capacityBuildingActivityDetails[$index].noOfUnits}}</div>
												</td>
												<td>
													<div align="center"
														data-ng-style="{'color':(stateData.capacityBuildingActivityDetails[$index].unitCost > cecData.capacityBuildingActivityDetails[$index].unitCost) ? 'red' : '#00cc00'}">
														<strong> <i style="font-size: 15px" class="fa">&#xf156;</i>
															{{stateData.capacityBuildingActivityDetails[$index].unitCost}}
														</strong>
													</div> <input type="text" class="form-control"
													data-ng-change="calculateNewFund($index)" number-only="" data-ng-disabled="isFreezeOrUnfreeze"
													data-ng-model="cecData.capacityBuildingActivityDetails[$index].unitCost"
													placeholder=""
													style="text-align: right; border: none; border-color: transparent;" />
												</td>
												<td>
													<div align="center"
														data-ng-style="{'color':(stateData.capacityBuildingActivityDetails[$index].funds > cecData.capacityBuildingActivityDetails[$index].funds) ? 'red' : '#00cc00'}">
														<strong> <i style="font-size: 15px" class="fa">&#xf156;</i>
															{{stateData.capacityBuildingActivityDetails[$index].funds}}
														</strong>
													</div>
													<input type="text" class="form-control"
													data-ng-disabled="true"
													data-ng-model="cecData.capacityBuildingActivityDetails[$index].funds"
													placeholder="Upper Ceiling Limit  Rs. 5 Lakh"
													style="text-align: right; border: none; border-color: transparent;" />
												</td>
												<td>
													<div align="center">{{stateData.capacityBuildingActivityDetails[$index].collabInstitute}}</div>
												</td>
												<td>
													<div align="center">{{stateData.capacityBuildingActivityDetails[$index].remarks}}</div>
												</td>
											</tr>
											<tr>
												<th colspan="5" align="center">Total Funds</th>
												<td><div align="center"><i style="font-size: 15px" class="fa">&#xf156;</i>  {{stateTotalFund}}</div></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<th colspan="5" align="center">Additional Requirement</th>
												<td>
													<!-- <div align="center"><i style="font-size: 15px" class="fa">&#xf156;</i>  {{stateAdditionalReq}}</div> -->
													<div align="center"
														data-ng-style="{'color':(stateData.capacityBuildingActivityDetails[$index].funds > cecData.capacityBuildingActivityDetails[$index].funds) ? 'red' : '#00cc00'}">
														<strong> <i style="font-size: 15px" class="fa">&#xf156;</i>
															{{stateAdditionalReq}}
														</strong>
													</div>
													<input type="text" class="form-control"
													data-ng-model="cecData.additionalRequirement"
													placeholder=""
													style="text-align: right; border: none; border-color: transparent;" />
												</td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<th colspan="5" align="center">Total Proposed Fund</th>
												<td><div align="center"><i style="font-size: 15px" class="fa">&#xf156;</i>  {{stateGrandTotal}}</div></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="form-group text-right ex1">
									<button ng-click="saveTrainingActivityCecDetails()"
										type="button" class="btn bg-green waves-effect">
										<spring:message code="Label.SAVE" htmlEscape="true" />
									</button>
									<button
										data-ng-click="freezeUnfreezeTrainingActivityCecDetails($event)"
										data-legend="{{status}}"
										type="button" class="btn bg-green waves-effect" value="">
										<spring:message code="Freeze" htmlEscape="true" />
									</button>
									<button type="button" data-ng-click="onClear()"
										class="btn bg-light-blue waves-effect">
										<spring:message code="Label.CLEAR" htmlEscape="true" />
									</button>
									<button type="button"
										onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-orange waves-effect">
										<spring:message code="Label.CLOSE" htmlEscape="true" />
									</button>
								</div>
							</div>
							<div role="tabpanel" class="container tab-pane" id="MOPR"
								style="width: auto;">
								<div class="table-responsive">
									<table class="table table-hover dashboard-task-infos"
										id="mytable">

										<thead>
											<tr>
												<th>
													<div align="center">
														<strong>S.No.</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Activity </strong>
													</div>
												</th>

												<th>
													<div align="center">
														<strong>No. of Days </strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>No. of Units </strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Unit Cost<br>(In <i
															style="font-size: 15px" class="fa">&#xf156;</i>)
														</strong>
													</div>
												</th>

												<th>
													<div align="center">
														<strong>Funds Proposed<br>(In <i
															style="font-size: 15px" class="fa">&#xf156;</i>)
														</strong>
													</div>
												</th>
												<th><div align="center">
														<strong>Collaboration with Institute</strong>
													</div></th>
												<th>
													<div align="center">
														<strong>Is Approved</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Remarks by State</strong>
													</div>
												</th>
											</tr>
										</thead>

										<tbody>
											<tr data-ng-repeat="cbMaster in cbmasters">
												<td><div align="center">{{$index+1}}</div></td>
												<td><div align="center">{{cbMaster.cbName}}</div></td>
												<td><div align="center">{{moprData.capacityBuildingActivityDetails[$index].noOfDays}}</div></td>
												<td><div align="center">{{moprData.capacityBuildingActivityDetails[$index].noOfUnits}}</div></td>
												<td><div align="center">{{moprData.capacityBuildingActivityDetails[$index].unitCost}}</div></td>
												<td><div align="center">{{moprData.capacityBuildingActivityDetails[$index].funds}}</div></td>
												<td><div align="center">{{moprData.capacityBuildingActivityDetails[$index].collabInstitute}}</div></td>
												<td>
													<div align="center"
														data-ng-if="moprData.capacityBuildingActivityDetails[$index].isApproved">
														<i class="fa fa-check" aria-hidden="true"
															style="color: #00cc00"></i>
													</div>
													<div align="center"
														data-ng-if="!moprData.capacityBuildingActivityDetails[$index].isApproved">
														<i class="fa fa-times" aria-hidden="true"
															style="color: red"></i>
													</div>
												</td>
												<td><div align="center">{{moprData.capacityBuildingActivityDetails[$index].remarks}}</div></td>
											</tr>
											<tr>
												<th colspan="5" align="center">Total Funds</th>
												<td><div align="center">{{totalFund}}</div></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<th colspan="5" align="center">Additional Requirement</th>
												<td><div align="center">{{additionalReq}}</div></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<th colspan="5" align="center">Total Proposed Fund</th>
												<td><div align="center">{{grandTotal}}</div></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
									</table>
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
