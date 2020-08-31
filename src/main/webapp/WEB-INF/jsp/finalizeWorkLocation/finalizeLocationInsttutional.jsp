<html ng-app="publicModule">

<head>
<%@include file="../taglib/taglib.jsp"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/plugins/dataTables/css/dataTables.bootstrap.min.css">

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/jquery.dataTables.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/dataTables.bootstrap.min.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/plugins/angular/ui-bootstrap-tpls-0.11.0.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/institutionalInfraActivityPlan/workLocation/finalizeInstInfraController.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/institutionalInfraActivityPlan/workLocation/finalizeInstInfraService.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">

</head>


<section class="content" ng-controller="finalizeInstInfraController">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Finalize Work Location of Institutional Infrastructure</h2>
					</div>
					<div class="body">


						<div class="card">

							<div class="tab-content">
								<div role="tabpanel" class="tab-pane fade in active"
									id="home_with_icon_title">

									<div class="form-group">
										<span class="errormessage" id="errorMessage"></span><br />
									</div>


									<div class="table-responsive">

										<table id="table1id" class="table table-bordered">
											<thead>
												<tr>
													<th>
														<div align="center">
															<strong>Activities</strong>
														</div>
													</th>
													<th>
														<div align="center">
															<strong>Existing Work Location</strong><br>
														</div>
													</th>

													<th>
														<div align="center">
															<strong>New Work Location</strong><br>
														</div>
													</th>
												</tr>
											</thead>
											<tbody>
												<input type="hidden" ng-model="instInfra"
													ng-value="instInfra" />
												<tr
													ng-repeat="obj in institutionalInfraActivity | orderBy : 'workLocation'">
													<td>
														<div ng-if="obj.activityId == 2 && obj.workType=='N'">
															New Building (SPRC)</div>
														<div ng-if="obj.activityId == 2 && obj.workType=='C'">
															Carry Forward (SPRC)</div>
														<div ng-if="obj.activityId == 4 && obj.workType=='N'">
															New Building (DPRC)</div>
														<div ng-if="obj.activityId == 4 && obj.workType=='C'">
															Carry Forward (DPRC)</div>
													</td>
													<td>
														<div ng-repeat="item in districtCodes">
															<label ng-if="item.districtCode == obj.workLocation"
																class="form-control col-sm-1" style="border: 0px;">
																<input type="hidden" id="label_{{obj.count}}" value="{{item.districtCode}}">
																{{item.districtNameEnglish}}</label>
														</div>
													</td>
													<td><select id="combo{{$index}}"
														class="form-control col-sm-1"
														data-ng-model="districtModel"
														ng-change="remove(districtModel,'combo{{$index}}');getValue(districtModel,$index,obj.instDtlsId)">
															<option value="" selected>Select District</option>
															<option ng-repeat="item in districtCodes"
																ng-if="item.districtCode != obj.workLocation"
																value="{{item.districtCode}}">{{item.districtNameEnglish}}</option>
													</select></td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="form-group text-right">
										<button ng-click="saveInstitutionalInfraData()"
											ng-show="isSaveVisible" type="button"
											class="btn bg-green waves-effect">
											<spring:message code="Label.SAVE" htmlEscape="true" />
										</button>
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