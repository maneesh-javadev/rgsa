
<html ng-app="publicModule">
	<head>
		<%@include file="../taglib/taglib.jsp"%>
		<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/trainingInstitutionCF/trainingInstitutionCFController.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/trainingInstitutionCF/trgInstitutionCFService.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>
	</head>
	<section class="content" ng-controller="trainingInstitutionCFController"> 
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					
					
					<div class="body">
						<div class="card">
							<div class="header">
								<h2>Institutional Infrastructure - Carry Forward</h2>
							</div>
							<div class="tab-content">
								<div role="tabpanel" class="tab-pane fade in active" id="home_with_icon_title">
									<div class="table-responsive">
										<table class="table table-bordered">
											<thead>
												<tr>
													<th>Building Level</th>
													<th>Building Type</th>
													<th>Funds released</th>
													<th>Fund Utilised</th>
													<th>Unit Approved</th>
													<th>Unit Under Progress</th>
													<th>Funds required (in Rs)</th>
													<th>Remarks</th>
												</tr>
											</thead>
											<tbody>
												<tr ng-repeat="trainingLevel in trainingInstitutionLevel">
													<td>{{trainingLevel.trainingInstitueType.trainingInstitueTypeName}}</td>
													<input type="hidden" ng-model="trainingInstitutionCFObject.cfDetails[$index].trainingInstitueType.trainingInstitueActivityTypeId"  ng-init="trainingInstitutionCFObject.cfDetails[$index].trainingInstitueType.trainingInstitueActivityTypeId=trainingLevel.trainingInstitueActivityTypeId"/>
													<td>{{trainingLevel.trainingInstitueActivityTypeName}}</td>
													<td><input type="text" ng-disabled="unFreeze" ng-model="trainingInstitutionCFObject.cfDetails[$index].fundsReleased" class="form-control"></td>
													<td><input type="text" ng-disabled="unFreeze" ng-model="trainingInstitutionCFObject.cfDetails[$index].unitsCompleted" class="form-control"></td>
													<td><input type="text" ng-disabled="unFreeze" ng-model="trainingInstitutionCFObject.cfDetails[$index].unitsApproved" class="form-control"></td>
													<td><input type="text" ng-disabled="unFreeze" ng-model="trainingInstitutionCFObject.cfDetails[$index].unitsUnderProgress" class="form-control"></td>
													<td><input type="text" ng-disabled="unFreeze" ng-model="trainingInstitutionCFObject.cfDetails[$index].fundsRequired" class="form-control"></td>
													<td><input type="text" ng-disabled="unFreeze" ng-model="trainingInstitutionCFObject.cfDetails[$index].remarks" class="form-control"></td>
												</tr>
											
											</tbody>
										</table>
									
									</div>
								</div>
							</div>
							<div class="text-right">
							<button ng-if="save" type="button" ng-click="saveData('S')" class="btn bg-green waves-effect">SAVE</button>
							<button ng-if="freeze" type="button" ng-click="saveData('F')" class="btn bg-green waves-effect">Freeze</button>
							<button ng-if="unFreeze" type="button" ng-click="saveData('S')" class="btn bg-green waves-effect">UnFreeze</button>
							
							<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"class="btn bg-orange waves-effect">CLOSE</button>
						</div>
						</div>
						
						
						
					</div>
				</div>
			</div>
		</div>
	</section>
</html>
