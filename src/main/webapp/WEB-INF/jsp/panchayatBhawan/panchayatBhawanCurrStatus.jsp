<%@include file="../taglib/taglib.jsp"%>


<html data-ng-app="publicModule">
<head>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/ui-bootstrap-tpls-0.11.0.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/panchayatBhawanCurrentStatus/panchayatBhawanCurrentStatusController.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/panchayatBhawanCurrentStatus/panchayatBhawanCurrentStatusService.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/panchayatBhawanCurrentStatus/selectGramPanchayatController.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/bootstrap.min.css">

</head>

	<section data-ng-controller="panchyatBhawanCurrentStatusController" class="content">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Status of Panchayat Bhawan</h2>
						</div>
						<div class="body">
						<a href="#" data-ng-click="fetchDistrictsBasedOnStateCode()">Please Select Gram Panchayats</a>
							<div class="card" data-ng-if="selectedGpsArray.length>0">
								<div class="tab-content">
										
									<div class="table-responsive">
										<table id="table1id" class="table table-bordered">
										
											<thead>
												<tr>
													<th rowspan="3">Gram Panchyat Name </th>
													<th rowspan="3">Functional From Where</th>
													<th colspan="4" style="text-align: center;">Number Of Staff Positioned</th>
													<th rowspan="3">Computer Available?</th>
													<th rowspan="3">Internet Available?</th>
													<th rowspan="3">Electricity Available?</th>
													<th rowspan="3">List of the services provided by Panchayat</th>
													<th rowspan="3">No of GS held during last year</th>
													<th rowspan="3">Gram Panchayat prepared annual plan of gram panchayat?</th>
													<th rowspan="3">Standing Committee Functional?</th>
													<th rowspan="3">No of Standing Committee meeting held</th>
												</tr>
												<tr>
													<th colspan="2">Regular</th>
													<th colspan="2">Contractual</th>
												</tr>
												<tr>
													<th>Administrative</th>
													<th>Technical</th>
													<th>Administrative</th>
													<th>Technical</th>
												</tr>
											</thead>
										
											<tbody>
												<tr data-ng-repeat="gramPanchyat in selectedGpsArray">

													<td> <label data-ng-init="panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[$index].localBodyCode = gramPanchyat[0]">{{gramPanchyat[1]}}</label> </td>
													<td><input type="text" restrict-input="{type: 'lettersOnly',index: $index}" data-ng-model="panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[$index].panchyatBhawanFunctionalFromWhere" class="form-control small"></td>
													<td><input type="text" restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" data-ng-model="panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[$index].noOfStaffRegularAdmin" class="form-control small"></td>
													<td><input type="text" restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" data-ng-model="panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[$index].noOfStaffRegularTech" class="form-control small"></td>
													<td><input type="text" restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" data-ng-model="panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[$index].noOfStaffContractAdmin" class="form-control small"></td>
													<td><input type="text" restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" data-ng-model="panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[$index].noOfStaffContractTech" class="form-control small"></td>
													<td><input type="checkbox" data-ng-model="panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[$index].computerAvailable"></td>
													<td><input type="checkbox" data-ng-model="panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[$index].internetAvailable"></td>
													<td><input type="checkbox" data-ng-model="panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[$index].electricityAvailable"></td>
													<td>
														<select data-ng-model="panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[$index].services" multiple="multiple">
															<option data-ng-repeat="service in servicesProvided" data-ng-value="{{service.serviceMasterId}}">
																{{service.serviceMasterName}}
															</option>
														</select>
													</td>

													<td><input type="text" maxlength="6" restrict-input="{type: 'digitsOnly',index: $index}"
														data-ng-model="panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[$index].noOfGsHeldDuringLastYear" class="form-control small"></td>
													<td><input type="checkbox" data-ng-model="panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[$index].gramPanchayatPreparedAnnualPlan"></td>
													<td><input type="checkbox" data-ng-model="panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[$index].standingCommitteeFunctional"></td>

													<td><input restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" type="text" data-ng-model="panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[$index].noOfStandingCommitteeMeetingHeld" class="form-control small"></td>

												</tr>
											</tbody>
										
										</table>
									</div>
										
									<div class="form-group text-right">
										<button data-ng-click="savePanchayatBhawanCsDetails()" type="button" class="btn bg-green waves-effect">
											<spring:message code="Label.SAVE" htmlEscape="true" />
										</button>
										<button type="button" onclick="onClear(this)" class="btn bg-light-blue waves-effect">
											<spring:message code="Label.CLEAR" htmlEscape="true" />
										</button>
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
	</section>

</html>