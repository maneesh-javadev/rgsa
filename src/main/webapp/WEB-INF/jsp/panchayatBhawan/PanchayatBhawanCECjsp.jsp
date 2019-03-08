<html data-ng-app="panchayatBhawanApp">
<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script
	src="http://angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/panchayatBhawan/panchayatBhawanActivityController.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/panchayatBhawan/panchayatBhawanActivityService.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/panchayatBhawan/panchayatController.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"
	rel="stylesheet">

<section class="content"
	data-ng-controller="panchayatBhawanActivityCntrl">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Label.PanchayatBhawanHeader"
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
									<table id="table1id" class="table table-bordered">
										<thead>
											<tr>
												<th>
													<div align="center">
														<strong><spring:message code="Label.WorkType"
																htmlEscape="true" /></strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.Activities"
																htmlEscape="true" /></strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.NoOfGPs"
																htmlEscape="true" /></strong><br> A
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message
																code="Label.AspirationalGpsSelected" htmlEscape="true" /></strong>
													</div>
												</th>

												<th>
													<div align="center">
														<strong><spring:message code="Label.UnitCost"
																htmlEscape="true" /> (in Rs) </strong><br> B
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.Funds"
																htmlEscape="true" /></strong><br> C = A * B
													</div>
												</th>
											</tr>
										</thead>
										<tbody>
											<tr data-ng-repeat="activity in activityList">

												<td data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].workType"><div align="center"
														data-ng-if="panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].workType == 'N'"
														data-ng-init="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].workType='N'">
														<strong><spring:message code="Label.NewBuilding"
																htmlEscape="true" /></strong>
													</div>
													<div align="center"
														data-ng-if="panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].workType == 'C'"
														data-ng-init="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].workType='C'">
														<strong><spring:message code="Label.CarryForward"
																htmlEscape="true" /></strong>
													</div></td>
												<td><strong>{{activity.activityName}}</strong> <input
													type="hidden"
													data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].activity.activityId"
													data-ng-init="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].activity.activityId=activity.activityId" />
												</td>
												<td><div align="center"
														data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].noOfGPs"
														data-ng-init="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].noOfGPs=panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].noOfGPs">
														<strong>{{panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].noOfGPs}}</strong>
													</div> <!-- <input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status == 'F'" data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].noOfGPs"  style="text-align:right;" disabled="disabled">
														<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status != 'F'" data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].noOfGPs"  onkeypress="return isNumber(event)" data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index);calculateAspirationalGps($index)" maxlength="7" style="text-align:right;"> -->
												</td>
												<td><div align="center"
														data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].aspirationalGps"
														data-ng-init="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].aspirationalGps=panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].aspirationalGps">
														<strong>{{panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].aspirationalGps}}</strong>
													</div> <!-- <input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status == 'F'" data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].aspirationalGps" style="text-align:right;" disabled="disabled"/>
														<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status != 'F'" onkeypress="return isNumber(event)" data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].aspirationalGps" data-ng-keyup="calculateAspirationalGps($index)" maxlength="7" style="text-align:right;"/>	 -->
												</td>

												<td>
													<div align="center"
														data-ng-style="{'color':(panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].unitCost > panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].unitCost) ? 'red' : '#00cc00'}">
														<strong>{{panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].unitCost}}</strong>
													</div> <input type="text" class="form-control"
													data-ng-show="panchayatBhawanActivity.status != 'F'"
													onkeypress="return isNumber(event)"
													data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].unitCost"
													data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)"
													maxlength="7" style="text-align: right;" /> <input
													type="text" class="form-control"
													data-ng-show="panchayatBhawanActivity.status == 'F'"
													data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].unitCost"
													style="text-align: right;" disabled="disabled" />
												</td>
												<td>
													<div align="center"
														data-ng-style="{'color':(panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].funds > panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].funds) ? 'red' : '#00cc00'}">
														<strong>{{panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].funds}}</strong>
													</div> <input type="text" class="form-control"
													data-ng-show="panchayatBhawanActivity.status != 'F'"
													onkeypress="return isNumber(event)"
													data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].funds"
													style="text-align: right;" /> <input type="text"
													class="form-control"
													data-ng-show="panchayatBhawanActivity.status == 'F'"
													data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].funds"
													style="text-align: right;" disabled="disabled" />
											</tr>

											<tr>
												<th colspan="5"><spring:message code="Label.TotalCost"
														htmlEscape="true" /></th>
												<td>
													<div align="center"
														data-ng-style="{'color':(totalState > totalWithoutAddRequirements) ? 'red' : '#00cc00'}">
														<strong>{{totalState}}</strong>
													</div> <input type="text" id="totalFonds"
													data-ng-model="totalWithoutAddRequirements"
													class="form-control col-sm-1" style="text-align: right;"
													data-ng-disabled="true" />
											</tr>
											<tr>
												<th colspan="5"><spring:message
														code="Label.AdditionalRequirement" htmlEscape="true" /></th>
												<td>
													<div align="center"
														data-ng-style="{'color':(panchayatBhawanActivityState.additionalRequirement > panchayatBhawanActivity.additionalRequirement) ? 'red' : '#00cc00'}">
														<strong>{{panchayatBhawanActivityState.additionalRequirement}}</strong>
													</div> <input type="text"
													data-ng-model="panchayatBhawanActivity.additionalRequirement"
													onkeypress="return isNumber(event)"
													data-ng-show="panchayatBhawanActivity.status != 'F'"
													data-ng-keyUp="calculateGrandTotal()"
													class="form-control col-sm-1" placeholder="25% of total"
													style="text-align: right;" /> <input type="text"
													data-ng-model="panchayatBhawanActivity.additionalRequirement"
													data-ng-show="panchayatBhawanActivity.status == 'F'"
													class="form-control col-sm-1" placeholder="25% of total"
													style="text-align: right;" disabled="disabled" />
												</td>
											</tr>
											<tr>
												<th colspan="5"><spring:message
														code="Label.TotalProposedFund" htmlEscape="true" /></th>
												<td>
													<div align="center"
														data-ng-style="{'color':((totalState + panchayatBhawanActivityState.additionalRequirement) > totalproposedFonds) ? 'red' : '#00cc00'}">
														<strong>{{totalState +
															panchayatBhawanActivityState.additionalRequirement}}</strong>
													</div> <input type="text" id="totalproposedFonds"
													data-ng-model="grandTotal" class="form-control col-sm-1"
													style="text-align: right;" data-ng-disabled="true" />
											</tr>
										</tbody>
									</table>
								</div>
								<div class="row clearfix">
								<div class="col-md-4 text-left">
											&nbsp;<button type="button"
												onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
												class="btn bg-orange waves-effect">
												<i class="fa fa-arrow-left" aria-hidden="true"></i>
												<spring:message code="Label.BACK" htmlEscape="true" />
											</button>
										</div>
										
									   	<div class="col-md-8 text-right ex1">
 									   	    <button data-ng-show="panchayatBhawanActivity.status == 'F'" data-ng-click="saveData('S')" type="button" class="btn bg-green waves-effect" disabled="disabled"><spring:message code="Label.SAVE" htmlEscape="true"/></button> 
									   		<button type="button" data-ng-show="panchayatBhawanActivity.status != 'F'" ng-click="saveData('S')" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
									   		<button data-ng-show="panchayatBhawanActivity.status != 'F' " data-ng-click="saveData('F')" type="button" class="btn bg-green waves-effect"><spring:message code="Label.FREEZE" htmlEscape="true" /></button>
								       <button data-ng-show="panchayatBhawanActivity.status == 'F'" type="button" data-ng-click="saveData('UF')" class="btn bg-green waves-effect">
									      <spring:message code="Label.UNFREEZE" htmlEscape="true" />
								       </button>
			 						   		<button type="button" data-ng-show="panchayatBhawanActivity.status == 'F'"  class="btn bg-light-blue waves-effect" disabled="disabled">
									   			<spring:message code="Label.CLEAR" htmlEscape="true" />
									   		</button>
									   		<button type="button" data-ng-show="panchayatBhawanActivity.status != 'F'"  class="btn bg-light-blue waves-effect" data-ng-click="claerAll()">
									   			<spring:message code="Label.CLEAR" htmlEscape="true" />
									   		</button>
											<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect">
												<spring:message code="Label.CLOSE" htmlEscape="true" />
											</button>
										</div>
								</div>
								<%-- <div class="form-group text-right ex1">
									<button data-ng-show="panchayatBhawanActivity.status == 'F'"
										data-ng-click="saveData('S')" type="button"
										class="btn bg-green waves-effect" disabled="disabled">
										<spring:message code="Label.SAVE" htmlEscape="true" />
									</button>
									<button type="button"
										data-ng-show="panchayatBhawanActivity.status != 'F'"
										ng-click="saveData('S')" class="btn bg-green waves-effect">
										<spring:message code="Label.SAVE" htmlEscape="true" />
									</button>
									<button data-ng-show="panchayatBhawanActivity.status != 'F' "
										data-ng-click="saveData('F')" type="button"
										class="btn bg-green waves-effect">
										<spring:message code="Label.FREEZE" htmlEscape="true" />
									</button>
									<button data-ng-show="panchayatBhawanActivity.status == 'F'"
										type="button" data-ng-click="saveData('UF')"
										class="btn bg-green waves-effect">
										<spring:message code="Label.UNFREEZE" htmlEscape="true" />
									</button>
									<button type="button"
										data-ng-show="panchayatBhawanActivity.status == 'F'"
										class="btn bg-light-blue waves-effect" disabled="disabled">
										<spring:message code="Label.CLEAR" htmlEscape="true" />
									</button>
									<button type="button"
										data-ng-show="panchayatBhawanActivity.status != 'F'"
										class="btn bg-light-blue waves-effect"
										data-ng-click="claerAll()">
										<spring:message code="Label.CLEAR" htmlEscape="true" />
									</button>
									<button type="button"
										onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-orange waves-effect">
										<spring:message code="Label.CLOSE" htmlEscape="true" />
									</button>
								</div> --%>
							</div>
							<div class="container tab-pane fade" id="MOPR"
								style="width: auto;">
								<div class="table-responsive">
									<table id="table1id" class="table table-bordered">
										<thead>
											<tr>
												<th>
													<div align="center">
														<strong><spring:message code="Label.WorkType"
																htmlEscape="true" /></strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.Activities"
																htmlEscape="true" /></strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.NoOfGPs"
																htmlEscape="true" /></strong><br> A
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message
																code="Label.AspirationalGpsSelected" htmlEscape="true" /></strong>
													</div>
												</th>

												<th>
													<div align="center">
														<strong><spring:message code="Label.UnitCost"
																htmlEscape="true" /> (in Rs) </strong><br> B
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.Funds"
																htmlEscape="true" /></strong><br> C = A * B
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.IsApproved"
																htmlEscape="true" /></strong>
													</div>
												</th>
											</tr>
										</thead>
										<tbody>
											<tr data-ng-repeat="activity in activityList">
												<td><div align="center"
														data-ng-if="panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].workType == 'N'">
														<spring:message code="Label.NewBuilding" htmlEscape="true" />
													</div>
													<div align="center"
														data-ng-if="panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].workType == 'C'">
														<spring:message code="Label.CarryForward"
															htmlEscape="true" />
													</div></td>
												<td><div align="center">{{activity.activityName}}</div></td>
												<td><div align="center">{{panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].noOfGPs}}</div></td>
												<td><div align="center">{{panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].aspirationalGps}}</div></td>
												<td><div align="center">{{panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].unitCost}}</div></td>
												<td><div align="center">{{panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].funds}}</div></td>
												<td>
													<div
														data-ng-show="panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].isApproved"
														align="center">
														<i class="fa fa-check" aria-hidden="true"
															style="color: #00cc00"></i>
													</div>
													<div
														data-ng-show="!panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].isApproved"
														align="center">
														<i class="fa fa-times" aria-hidden="true"
															style="color: red"></i>
													</div>
												</td>
											</tr>
											<tr>
												<th colspan="5"><spring:message code="Label.TotalCost"
														htmlEscape="true" /></th>
												<td><div align="center">{{totalMOPR}}</div></td>
											</tr>
											<tr>
												<th colspan="5"><spring:message
														code="Label.AdditionalRequirement" htmlEscape="true" /></th>
												<td><div align="center">{{panchayatBhawanActivityMOPR.additionalRequirement}}</div></td>
											</tr>
											<tr>
												<th colspan="5"><spring:message
														code="Label.AdditionalRequirement" htmlEscape="true" /></th>
												<td><div align="center">{{totalMOPR +
														panchayatBhawanActivityMOPR.additionalRequirement}}</div></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="row clearfix">
								<div class="col-md-4 text-left">
											&nbsp;<button type="button"
												onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
												class="btn bg-orange waves-effect">
												<i class="fa fa-arrow-left" aria-hidden="true"></i>
												<spring:message code="Label.BACK" htmlEscape="true" />
											</button>
										</div>
										
									   	<div class="col-md-8 text-right ex1">
											<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect">
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
