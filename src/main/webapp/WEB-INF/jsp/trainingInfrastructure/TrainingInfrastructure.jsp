<%@include file="../taglib/taglib.jsp"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/ui-bootstrap-tpls-0.11.0.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/trainingInfrastructure/trainingInfrastructureController.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/trainingInfrastructure/addTrainingInstitute.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/trainingInfrastructure/trainingInfrastructureService.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/trainingInfrastructure/deleteTrainingDetailsController.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/bootstrap.min.css">

<script type="text/javascript">
	function addRow() {
		$("#infraAvailId").each(
				function() {
					var tds = '<tr>';
					jQuery.each($('tr:last td', this), function(index) {
						if (index == 1) {
							tds += '<td style="display: none" class="blocks">'
									+ $(this).html() + '</td>';
						} else {
							tds += '<td>' + $(this).html() + '</td>';
						}
					});
					tds += '</tr>';
					if ($('tbody', this).length > 0) {
						$('tbody', this).append(tds);
					} else {
						$(this).append(tds);
					}
				});
	}
 
	function active() {
		if ($("#check1").is(':checked')) {
			$('.active').removeAttr("disabled");

		} else {

			$(".active").attr("disabled", true);
		}

	}

	function shownRelatedPost(val) {
		if (val == 1) {
			$("#administrative").css('display', 'block');
			$("#thematic").css('display', 'none');
			$("#resource").css('display', 'none');
		}
		if (val == 2) {
			$("#thematic").css('display', 'block');
			$("#administrative").css('display', 'none');
			$("#resource").css('display', 'none');
		}
		if (val == 3) {
			$("#resource").css('display', 'block');
			$("#thematic").css('display', 'none');
			$("#administrative").css('display', 'none');
		}

	}
</script>

<html data-ng-app="publicModule">
	<section class="content" data-ng-controller="trainingInfrastructureController">
		<div class="container-fluid">
			<!-- Tabs With Icon Title -->
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Training Infrastructure</h2>
						</div>
						<div class="body">
							<div class="tab-content">
								<div role="tabpanel" class="tab-pane fade in active" id="home_with_icon_title">
									<div class="row">
										<div align="right">
											<button data-ng-click="OpenModal(false)" type="button" class="btn btn-info btn-lg"><strong>+ Add</strong></button>
										</div>
									</div>
									
									<div class="table-responsive" data-ng-if="trainingInstitute.trainingInstituteCurrentStatusDetails.length > 0">
										<table class="table table-bordered">
											<thead>
												<tr>
													<th rowspan="3"><div align="center">Training Institute Type</div></th>
													<th rowspan="3"><div align="center">Location</div></th>
													<th rowspan="3"><div align="center">Training Institute Functional?</div></th>
													<th rowspan="3"><div align="center">No Of Training Conducted Last Year</div></th>
													<th rowspan="3"><div align="center">Training Institute Functional From</div></th>
													<th><div align="center">Source Of Funding</div></th>
													<th colspan="7"><div align="center">Infrastructure Available?</div></th>
													<th colspan="4"><div align="center">Human Resource Available?</div></th>
													<th rowspan="3" colspan="2"><div align="center">Action</div></th>
												</tr>
												<tr>
													<th rowspan="2"><div align="center">Name of Scheme/Program</div></th>
													<th rowspan="2"><div align="center">No of Training hall/Room</div></th>
													<th rowspan="2"><div align="center">Capacity of Training halls for conducting Training </div></th>
													<th rowspan="2"><div align="center">Conference hall Available?</div></th>
													<th rowspan="2"><div align="center">Computer, Projectors, Internet etc.?</div></th>
													<th rowspan="2"><div align="center">Library Available?</div></th>
													<th rowspan="2"><div align="center">Dinning Hall Available?</div></th>
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
												<tr data-ng-repeat="details in trainingInstitute.trainingInstituteCurrentStatusDetails" >
													<td>
														<label>{{details.trainingInstitueType.trainingInstitueTypeName}}</label>
													</td>
													<td>
														<label>{{details.locationName}}</label>
													</td>
													<td><input data-ng-checked="details.isTiFunctional" type="checkbox" disabled="disabled" />Yes</td>
													<td><label>{{details.noOfTrainingsConductedLastyear}}</label></td>
													<td><label>{{details.tiFunctionalFromYear}}</label></td>
													<td>
														<select disabled="disabled" multiple="multiple">
															<option data-ng-repeat="scheme in details.trainingInstituteFundSource" data-ng-value="scheme.scheme.schemeId">
																{{scheme.scheme.schemeName}}
															</option>
														</select>
													</td>
													<td><label>{{details.noOfTrainingHalls}}</label></td>
													<td><label>{{details.capacityTrainingHall}}</label></td>
													<td><input data-ng-checked="details.conferenceHallAvailable" type="checkbox" disabled="disabled" /> Yes</td>
													<td><input data-ng-checked="details.compProjectorInternetAvailable" type="checkbox" disabled="disabled" /> Yes</td>
													<td><input data-ng-checked="details.libraryAvailable" type="checkbox" disabled="disabled" /> Yes</td>
													<td><input data-ng-checked="details.diningHallAvailable" type="checkbox" disabled="disabled" /> Yes</td>
													<td><input data-ng-checked="details.sepertateToiletForWomenAndDisabled" type="checkbox" disabled="disabled" /> Yes</td>
													
													<td><label>{{details.noOfAdministrativeStaff}}</label></td>
													<td><label>{{details.noOfThematicExpertsRegular}}</label></td>
													<td><label>{{details.noOfThematicExpertsContractual}}</label></td>
													<td><label>{{details.noOfThematicExpertsResourceperson}}</label></td>
													<td><input type="button" data-ng-click="modifyDetails(this)" class="btn bg-light-red waves-effect" value="Modify"/></td>
													<td><input type="button" data-ng-click="OpenDeleteModal(this)" class="btn bg-light-red waves-effect" value="Delete"/></td>
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
			<!-- #END# Tabs With Icon Title -->
	
		</div>
	</section>
</html>