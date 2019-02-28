<html>
<head>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>

<style type="text/css">
	.modal-content{
		width: 176%;
		margin-left: -20%;"
		height: 700px;
	}
</style>


</head>





<div class="modal-header">
	 	<h2>Add Training Infrastructure</h2>
	</div>
	<div class="modal-body" >
		<div class="row" data-ng-if="selectLevel">
			<div class="form-group">
				<label for="selectLevel" class="col-sm-3">Select Level</label>
				<div class="col-sm-5">
					<select data-ng-change="show(this)" data-ng-model="level">
						<option value="1">State</option>
						<option value="2">District</option>
						<option value="5">Block</option>
					</select>
				</div>
			</div>
		</div>
		
		<div class="row" data-ng-if="showLevelLabel">
			<div class="form-group">
				<label for="selectLevel" class="col-sm-3">Select Level</label>
				<div class="col-sm-5">
					<label>{{trainingInstitute.trainingInstituteCurrentStatusDetails[0].trainingInstitueType.instituteLevel.trainingInstituteLevelName}}</label>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="form-group" id="district" data-ng-if="showDistrict">
				<label for="selectLevel" class="col-sm-3">Select District</label>
				<div class="col-sm-5">
					<select data-ng-change="fetchBlockListBasedOnDistrict(trainingInstitute.trainingInstituteCurrentStatusDetails[0].tiLocation);fetchTrainingInstituteDetails(trainingInstitute.trainingInstituteCurrentStatusDetails[0].tiLocation)" data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].tiLocation" >
						<option data-ng-repeat="district in districtList" value="{{district.districtCode}}">
							{{district.districtNameEnglish}}
						</option>
					</select>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="form-group"  id="block" data-ng-if="showBlock">
				<label for="selectLevel" class="col-sm-3">Select block</label>
				<div class="col-sm-5" data-ng-model="selectedBlock">
					<select data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].tiLocation" data-ng-change="fetchTrainingInstituteDetails(trainingInstitute.trainingInstituteCurrentStatusDetails[0].tiLocation)">
						<option data-ng-repeat="block in blockList" data-ng-value="{{block.blockCode}}">
							{{block.blockNameEnglish}}
						</option>
					</select>
				</div>
			</div>
		</div>
		
		<div class="table-responsive" id="table" data-ng-if="showTable">
			<table class="table table-bordered">
				<thead>
				<tr>
					<th rowspan="3"><div align="center">Training Institute Type</div></th>
					<th rowspan="3"><div align="center">Training Institute Functional?</div></th>
					<th rowspan="3"><div align="center">No Of Training Conducted last year</div></th>
					<th rowspan="3"><div align="center">Training Institute functional from</div></th>
					<th><div align="center">Source Of Funding</div></th>
					<th colspan="7"><div align="center">Infrastructure Available</div></th>
					<th colspan="4"><div align="center">Human Resource Available</div></th>
				</tr>
				<tr>
					<th rowspan="2"><div align="center">Name of Scheme/Program</div></th>
					<th rowspan="2"><div align="center">No of Training hall/Room</div></th>
					<th rowspan="2"><div align="center">Capacity of Training halls for conducting Training </div></th>
					<th rowspan="2"><div align="center">Conference hall Available?</div></th>
					<th rowspan="2"><div align="center">Computer, Projectors, Internet etc.?</div></th>
					<th rowspan="2"><div align="center">Library?</div></th>
					<th rowspan="2"><div align="center">Dinning Hall?</div></th>
					<th rowspan="2"><div align="center">Separate Toilet For Women And Disabled?</div></th>
					<th rowspan="2"><div align="center">Administrative Staff</div></th>
					<th colspan="3"><div align="center">Thematic Experts</div></th>
				</tr>
				<tr>
					<th><div align="center">Regular</div></th>
					<th><div align="center">Contractual</div></th>
					<th><div align="center">Resource Persons</div></th>
				</tr>
				</thead>
				<tbody>
					<tr >
						<td>
							<select data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].trainingInstitueType.trainingInstitueTypeId" convert-to-number>
								<option data-ng-repeat="institute in instituteTypes" value="{{institute.trainingInstitueTypeId}}">
									{{institute.trainingInstitueTypeName}}
								</option>
							</select>
						</td>
						<td><input data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].isTiFunctional" type="checkbox" /> Yes</td>
						<td><input data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].noOfTrainingsConductedLastyear" restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" type="text" class="form-control"></td>
						<td><input data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].tiFunctionalFromYear" maxlength="4" restrict-input="{type: 'digitsOnly',index: $index}" type="text" class="form-control"></td>
						<td>
							<select multiple="multiple" data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].scheme" >
								<option data-ng-repeat="scheme in schemes" value="{{scheme.schemeId}}">
									{{scheme.schemeName}}
								</option>
							</select>
						</td>
						<td><input data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].noOfTrainingHalls" restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" type="text" class="form-control"></td>
						<td><input data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].capacityTrainingHall" restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" type="text" class="form-control"></td>
						<td><input data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].conferenceHallAvailable" type="checkbox" /> Yes</td>
						<td><input data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].compProjectorInternetAvailable" type="checkbox" /> Yes</td>
						<td><input data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].libraryAvailable" type="checkbox" /> Yes</td>
						<td><input data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].diningHallAvailable" type="checkbox" /> Yes</td>
						<td><input data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].sepertateToiletForWomenAndDisabled" type="checkbox" /> Yes</td>
						<td><input data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].noOfAdministrativeStaff" restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" type="text" class="form-control"></td>
						<td><input data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].noOfThematicExpertsRegular" restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" type="text" class="form-control"></td>
						<td><input data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].noOfThematicExpertsContractual" restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" type="text" class="form-control"></td>
						<td><input data-ng-model="trainingInstitute.trainingInstituteCurrentStatusDetails[0].noOfThematicExpertsResourceperson" restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" type="text" class="form-control"></td>
					</tr>
				</tbody>
			</table>
		</div>
		
	</div>

<div class="modal-footer">
	<button data-ng-click="saveInfrastructureDetails()" class="btn btn-primary">Save</button>
	<button data-ng-click="cancel()" class="btn" >close</button>
</div>
</html>