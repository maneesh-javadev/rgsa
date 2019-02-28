<%@include file="../taglib/taglib.jsp"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/capacityBuilding/capacityBuildingController.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/capacityBuilding/capacityBuildingService.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">


<html data-ng-app="publicModule">
	<section class="content" data-ng-controller="capacityBuildingController">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Capacity Building Activity Plan</h2>
						</div>
						
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane fade in active"
								id="home_with_icon_title">
								<div align="center" class="row" >
									<br/>
									<div align="center" class="form-group">
										<label for="selectLevel" class="col-sm-3">Select Quarter Duration</label>
										<div class="col-sm-3">
											<select class="form-control">
												<option value="">Select</option>
												<option value="0">APRIL-JUNE</option>
												<option selected="selected" value="1">JULY-SEPT</option>
												<option value="2">OCT_DEC</option>
												<option value="3">JAN-MAR</option>
											</select>
										</div>
									</div>
								</div>
						<br/>
								<div class="table-responsive">
								
									<table class="table table-hover dashboard-task-infos" id="mytable" >
								
										<thead>
											<tr>
												<th>
													<div align="center">
														<strong>S.No.</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Activity
														</strong>
													</div>
												</th>
												
												<th>
													<div align="center">
														<strong>No of Days
														</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>No of Units
														</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Unit Cost(In Rs) </strong>
													</div>
												</th>
												
												<th>
													<div align="center">
														<strong>Funds Proposed(In Rs) </strong>
													</div>
												</th>
												
												<th>
													<div align="center">
														<strong>No of Units Completed/Persons Involved
														</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong> Expenditure incurred
														</strong>
													</div>
												</th>
											</tr>
										</thead>
										
										<tbody>
											<tr data-ng-repeat="cbMaster in cbmasters" >
	
												<td>
													{{$index+1}}
												</td>
												<td>
													{{cbMaster.cbName}}
												</td>
												<input type="hidden" id="cbMaster_{{$index}}" class="form-control" data-ng-value="cbMaster.cbMasterId"  disabled="disabled" 
																ng-model="capacityBuilding.capacityBuildingActivityDetails[index].cbMaster" />
												<td>
													<input style="background: #dddddd;" ng-show="!{{$index+1 == 5 || $index+1 == 6 }}" ng-disabled="!{{$index+1 == 5 || $index+1 == 6 }}" type="text" 
														data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].noOfDays" disabled="disabled" class="form-control" placeholder="1"/>
													
													<input data-ng-keyup="calculateFunds($index)" maxlength="5" disabled="disabled"  restrict-input="{type: 'numberGreaterThanZero',index: $index}" ng-show="{{$index+1 == 5 || $index+1 == 6 }}" data-ng-change="insertCBMasterInScope($index)" type="text" 
														data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].noOfDays" class="form-control" placeholder=""/>
													
												</td>
												<td>
													<input data-ng-change="insertCBMasterInScope($index)" maxlength="5" disabled="disabled"  restrict-input="{type: 'numberGreaterThanZero',index: $index}" data-ng-keyup="calculateFunds($index)" type="text" data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].noOfUnits" class="form-control" placeholder=" " />
												</td>
												<td>
													<input data-ng-change="insertCBMasterInScope($index)" maxlength="5" disabled="disabled"  restrict-input="{type: 'numberGreaterThanZero',index: $index}" min="1" data-ng-keyup="calculateFunds($index);checkForCellingValue($index)" type="text" data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].unitCost" class="form-control" placeholder="Upper Ceiling Limit  Rs. 5 Lakh" />
												</td>
												<td>
													<input data-ng-disabled="true" style="background: #dddddd;" disabled="disabled"  data-ng-change="insertCBMasterInScope($index)" type="text" data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].funds" class="form-control" placeholder=" " />
												</td>
												
												<td>
													<input type="text" class="form-control" value="5" disabled="disabled"  placeholder=" " />
												</td>
												<td>
													<input type="text" class="form-control" value="25000" disabled="disabled"  placeholder=" " />
												</td>
											</tr>
										</tbody>
									</table>
									</div>
									<!-- <div class="table-responsive">
										<table class="table table-hover dashboard-task-infos"  >
											<tr>
												<td></td>
												<td><div class="col-sm-8">Sub Total</div></td>
												
												<td>
													<div class="col-sm-5" style="margin-left: 203px;">
														<input type="text" maxlength="5" data-ng-disabled="true" data-ng-model="subTotal" class="form-control"  />
													</div>
												</td>
											</tr>
										</table>
								</div>
									<div class="table-responsive">
										<table class="table table-hover dashboard-task-infos"  >
											<tr>
												<td></td>
												<td><div class="col-sm-8">Additional Requirement</div></td>
												
												<td>
													<div class="col-sm-5" style="margin-left: 203px;">
														<input type="text" maxlength="5" restrict-input="{type: 'digitsOnly',index: $index}" data-ng-change="validateAmount()"
														data-ng-model="capacityBuilding.additionalRequirement" class="form-control" placeholder="25% of Total Cost " />
													</div>
												</td>
											</tr>
										</table>
								</div>
								<div class="table-responsive">
										<table class="table table-hover dashboard-task-infos"  >
											<tr>
												<td></td>
												<td><div class="col-sm-8">Grand Total</div></td>
												
												<td>
													<div class="col-sm-5" style="margin-left: 203px;">
														<input type="text" data-ng-disabled="true" data-ng-model="grandTotal" maxlength="5"  class="form-control"  />
													</div>
												</td>
											</tr>
										</table>
								</div> -->
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</html>