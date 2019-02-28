<%@include file="../taglib/taglib.jsp"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/currentUsageSatcom/currenStatusSatcomController.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/currentUsageSatcom/currenStatusSatcomService.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">

<html data-ng-app="publicModule">
	<section data-ng-controller="currenStatusSatcomController" class="content">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Current Status Of Distance Learning Infrastructure In States</h2>
						</div>
						<div class="body">
						<div class="table-responsive">
						<table class="table table-bordered">
						<thead><tr>
						<th><div align="center">Name Of Activity</div></th>
						<th><div align="center">Dedicated Studio?</div></th>
						<th><div align="center">Name of Host Studio</div></th>
						<th colspan="3"><div align="center">Level of Usage</div></th>
						<th colspan="3"><div align="center">No. of PRI with recieving Terminals</div></th>
						<th><div align="center">Source of Fund</div></th>
						<th><div align="center">No. Of Trainings Conducted Last Year</div></th>
						<th><div align="center">No. Of Participants Trained</div></th>
						</tr>
						<tr>
						<th></th>
						<th></th>
						<th></th>
						<th>ZP</th>
						<th>BP</th>
						<th>GP</th>
						<th>ZP</th>
						<th>BP</th>
						<th>GP</th>
						<th></th>
						</tr>
						</thead>
						<tbody>
							<tr data-ng-repeat="activity in satcomActivity">
								<td style="text-align: center;" data-ng-init="satcomCurrentStatus.activityDetails[$index].satcomMasterId= activity.satcomMasterId">
									{{activity.satcomMasterName}}
								</td>
								<td>
									<input type="checkbox" data-ng-model="satcomCurrentStatus.activityDetails[$index].isDedicated">
								</td>
								<td>
									<input style="width: 100px;" type="text" restrict-input="{type: 'lettersOnly',index: $index}" class="form-control" data-ng-model="satcomCurrentStatus.activityDetails[$index].hostInstitute">
								</td>
								<td>
									<input type="checkbox" id="zpCheckBox_{{$index}}"
										data-ng-checked="satcomCurrentStatus.activityDetails[$index].usageLevelzp" data-ng-model="satcomCurrentStatus.activityDetails[$index].usageLevelzp">
								</td>
								<td>
									<input type="checkbox" id="bpCheckBox_{{$index}}"
										data-ng-model="satcomCurrentStatus.activityDetails[$index].usageLevelbp">
								</td>
								<td>
									<input type="checkbox" id="gpCheckBox_{{$index}}"
										data-ng-model="satcomCurrentStatus.activityDetails[$index].usageLevelgp">
								</td>
								<td>
									<input id="zpInput_{{$index}}" maxlength="6" restrict-input="{type: 'digitsOnly',index: $index}" data-ng-disabled="!satcomCurrentStatus.activityDetails[$index].usageLevelzp" style="width: 65px;" type="text" class="form-control" data-ng-model="satcomCurrentStatus.activityDetails[$index].noOfZps">
								</td>
								<td>
									<input id="bpInput_{{$index}}" maxlength="6" restrict-input="{type: 'digitsOnly',index: $index}" data-ng-disabled="!satcomCurrentStatus.activityDetails[$index].usageLevelbp" style="width: 65px;" type="text" class="form-control" data-ng-model="satcomCurrentStatus.activityDetails[$index].noOfBps">
								</td>
								<td>
									<input id="gpInput_{{$index}}" maxlength="6" restrict-input="{type: 'digitsOnly',index: $index}" data-ng-disabled="!satcomCurrentStatus.activityDetails[$index].usageLevelgp" style="width: 65px;" type="text" class="form-control" data-ng-model="satcomCurrentStatus.activityDetails[$index].noOfGps">
								</td>
								<td>
									<select multiple="multiple" data-ng-model="satcomCurrentStatus.activityDetails[$index].scheme" 
										data-ng-init="innerIndex = $index">
										<option data-ng-repeat="scheme in schemeMaster" value="{{scheme.schemeId}}">
											{{scheme.schemeName}}
										</option>
									</select>
								</td>
								<td>
									<input type="text" maxlength="6" class="form-control" restrict-input="{type: 'digitsOnly',index: $index}" data-ng-model="satcomCurrentStatus.activityDetails[$index].noOfTrainings">
								</td>
								<td>
									<input type="text" maxlength="6" class="form-control" restrict-input="{type: 'digitsOnly',index: $index}" data-ng-model="satcomCurrentStatus.activityDetails[$index].noOfparticipants">
								</td>
							</tr>
						</tbody>
						</table>
						</div>
	
							<div class="form-group text-right">
								<button data-ng-show="satcomCurrentStatus.isFreeze" type="button" data-ng-click="freezUnFreezCapacityBuilding('unfreeze')" class="btn bg-green waves-effect">
									<spring:message code="UNFREEZE" htmlEscape="true" />
								</button>
								<button data-ng-show="!satcomCurrentStatus.isFreeze" type="button" data-ng-click="freezUnFreezCapacityBuilding('freeze')" class="btn bg-green waves-effect">
									<spring:message code="FREEZE" htmlEscape="true" />
								</button>
								<button data-ng-click="saveSatcomCurrentStatus()" type="button" class="btn bg-green waves-effect">
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
	</section>
</html>