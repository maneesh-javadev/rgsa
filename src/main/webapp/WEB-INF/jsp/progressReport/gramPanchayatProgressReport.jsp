<%@include file="../taglib/taglib.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/quarterlyProgressReport/gramPanchayatProgressReportController.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/quarterlyProgressReport/gramPanchayatProgressReportService.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<html data-ng-app="publicModule">
	<section class="content" data-ng-controller="gramPanchayatProgressReportController" >
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<form action="trainingProgressReport.html" method="POST" modelAttribute="TRAINING_DETAILS" >
					<div class="card">
						<h3><spring:message code="Label.GramPanchayatProgressReport" htmlEscape="true" /></h3>
						<br/>
						<div class="row" >
							<div class="form-group">
							<div class="col-lg-2"></div>
								<label for="QuaterDuration" class="col-sm-3"><spring:message code="Label.QuaterDuration" htmlEscape="true" /></label>
								<div class="col-lg-4">
									<select class="form-control" data-ng-init="qprPanchayatBhawan.qtrId = '0'" data-ng-change="resetDetails()" convert-to-number data-ng-model="qprPanchayatBhawan.qtrId">
										<option value="0">Select Quarter Duration</option>
										<option data-ng-repeat="quatorDuration in quatorDuration" value="{{quatorDuration.qtrId}}">{{quatorDuration.qtrDuration}}</option>
									</select>
								</div>
							</div>
						</div>
						<div class="row" data-ng-show="qprPanchayatBhawan.qtrId != 0">
							<div class="form-group">
							<div class="col-lg-2"></div>
								<label for="selectLevel" class="col-sm-3"><spring:message code="Label.ActivityType" htmlEscape="true" /></label>
								<div class="col-lg-4">
									<select class="form-control" data-ng-init="qprPanchayatBhawan.activityId = '0'" convert-to-number data-ng-model="qprPanchayatBhawan.activityId" data-ng-change="fetchGPBhawanStatus(qprPanchayatBhawan.activityId);resetDistrictList()">
										<option value="0">Select Activity</option>
										<option data-ng-repeat="panchayatActivity in panchayatActivity" value="{{panchayatActivity.activityId}}">{{panchayatActivity.activityName}}</option>
									</select>
								</div>
							</div>
						</div>
						<div class="row" data-ng-show="qprPanchayatBhawan.activityId != 0">
							<div class="form-group">
							<div class="col-lg-2"></div>
								<label for="District" class="col-sm-3"><spring:message code="Label.District" htmlEscape="true" /></label>
								<div class="col-lg-4">
									<select class="form-control" data-ng-init="qprPanchayatBhawan.districtCode = '0'" convert-to-number data-ng-model="qprPanchayatBhawan.districtCode" data-ng-change="FetchDataOfGps(qprPanchayatBhawan.activityId,qprPanchayatBhawan.districtCode);fetchDataAccordingToQuator(qprPanchayatBhawan.qtrId,qprPanchayatBhawan.activityId,qprPanchayatBhawan.districtCode)">
										<option value="0">Select District</option>
										<option data-ng-repeat="districtList in districtList" value="{{districtList.districtCode}}">{{districtList.districtNameEnglish}}</option>
									</select>
								</div>
							</div>
						</div>
						<div class="body" data-ng-show="qprPanchayatBhawan.districtCode != 0">
							<table class="table table-bordered table-striped table-hover" >
								<thead>
									<tr>
										<th>
											<div align="center">
												<strong><spring:message code="Label.SerialNumber" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.G.P." htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.GPBhawanStatus" htmlEscape="true" /></strong>
											</div>
										</th>
										<%-- <th>
											<div align="center">
												<strong><spring:message code="Label.UploadFile" htmlEscape="true" /></strong>
											</div>
										</th> --%>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ExpenditureIncurred" htmlEscape="true" /></strong>
											</div>
										</th>
										<%-- <th>
											<div align="center">
												<strong><spring:message code="Label.Remarks" htmlEscape="true" /></strong>
											</div>
										</th> --%>
									</tr>
								</thead>
								<tbody>
									<tr data-ng-repeat="GPBhawanData in GPBhawanData">
										<td>{{$index + 1}}
										<input type="hidden" data-ng-model="GPBhawanData" value="{{GPBhawanData}}" /> 
										</td>
										<td><strong>{{GPBhawanData.localBodyNameEnglish}}</strong></td>
										<td>
											<select class="form-control" data-ng-init="qprPanchayatBhawan.qprPanhcayatBhawanDetails[$index].gpBhawanStatusId = '0'" convert-to-number data-ng-model="qprPanchayatBhawan.qprPanhcayatBhawanDetails[$index].gpBhawanStatusId" required="required">
												<option value="0">Select G.P Bhawan Status</option>
												<option data-ng-repeat="GPBhawanStatus in GPBhawanStatus" value="{{GPBhawanStatus.gpBhawanStatusId}}">{{GPBhawanStatus.gpBhawanStatusName}}</option>
											</select>
										</td>
										<!-- <td align="center"><input type="file" class="form-control" fileModel="qprPanchayatBhawan.qprPanhcayatBhawanDetails[$index].file" /></td> -->
										<td align="center"><input type="text" class="form-control"  restrict-input="{type: 'digitsOnly'}"  data-ng-model="qprPanchayatBhawan.qprPanhcayatBhawanDetails[$index].expenditureIncurred" required="required" style="text-align: right;"></td>
										<!-- <td><textarea class="form-control" rows="2" cols="5"></textarea></td> -->
									</tr>
								</tbody>
							</table>
							<div class="form-group text-right">
								<button data-ng-show="qprPanchayatBhawan.isFreeze" data-ng-click="saveQprPanchayatBhawanData()" type="button" class="btn bg-green waves-effect" disabled="disabled"><spring:message code="Label.SAVE" htmlEscape="true"/></button>
								<button data-ng-show="!qprPanchayatBhawan.isFreeze" data-ng-click="saveQprPanchayatBhawanData()" type="button" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
								<%-- <button type="button" data-ng-show="qprPanchayatBhawan.isFreeze"  class="btn bg-light-blue waves-effect" disabled="disabled"><spring:message code="Label.CLEAR" htmlEscape="true"/></button> --%>
								<%-- <button type="button" data-ng-show="!qprPanchayatBhawan.isFreeze" class="btn bg-light-blue waves-effect"><spring:message code="Label.CLEAR" htmlEscape="true" /></button> --%>
								<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-orange waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
							</div>
						</div>
					</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</html>