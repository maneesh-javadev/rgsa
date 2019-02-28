<%@include file="../taglib/taglib.jsp"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/capacityBuilding/capacityBuildingController.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/capacityBuilding/capacityBuildingService.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<<script type="text/javascript">

</script>

<html data-ng-app="publicModule">
	<section class="content" data-ng-controller="capacityBuildingController">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Training Activities</h2>
						</div>
						
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane fade in active"
								id="home_with_icon_title">
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
														<strong>No. of Days
														</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>No. of Units
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
													
												<!-- <th>
													<div align="center">
														<strong>State </strong>
													</div>
												</th>
													
												<th>
													<div align="center">
														<strong>GP </strong>
													</div>
												</th> -->
													
												<th><div align="center">
														<strong>Collaboration with Institute</strong>
													</div></th>
												<th data-ng-if="userType == 'M'">
													<div align="center">
														<strong>Is Approved</strong>
													</div>
												</th>
												<th data-ng-if="userType == 'C'">
													<div align="center">
														<strong>Is Approved</strong>
													</div>
												</th>
												<th data-ng-if="userType == 'S'" style="display: none">
													<div align="center" >
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
											<tr data-ng-repeat="cbMaster in cbmasters" >
	
												<td>
													{{$index+1}}
												</td>
												<td>
													{{cbMaster.cbName}}
												</td>
												<input type="hidden" id="cbMaster_{{$index}}" class="form-control" data-ng-value="cbMaster.cbMasterId" 
																ng-model="capacityBuilding.capacityBuildingActivityDetails[index].cbMaster" style="text-align:right;" />
												<td>
													<input style="background: #dddddd; text-align:right;" ng-show="!{{$index+1 == 5 || $index+1 == 6 }}" ng-disabled="!{{$index+1 == 5 || $index+1 == 6 }}" data-ng-disabled="capacityBuilding.isFreeze" type="text" 
														data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].noOfDays" class="form-control" placeholder="1" />
													
													<input data-ng-keyup="calculateFunds($index)" maxlength="5" restrict-input="{type: 'numberGreaterThanZero',index: $index}" ng-show="{{$index+1 == 5 || $index+1 == 6 }}" data-ng-change="insertCBMasterInScope($index)" data-ng-disabled="capacityBuilding.isFreeze" type="text" 
														data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].noOfDays" class="form-control" placeholder="" style="text-align:right;"/>
													
												</td>
												<td>
													<input data-ng-disabled="capacityBuilding.isFreeze" data-ng-change="insertCBMasterInScope($index)" maxlength="5" restrict-input="{type: 'numberGreaterThanZero',index: $index}" data-ng-keyup="calculateFunds($index)" type="text" data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].noOfUnits" class="form-control" placeholder=" " style="text-align:right;"/>
												</td>
												<td>
													<input data-ng-disabled="capacityBuilding.isFreeze" data-ng-change="insertCBMasterInScope($index)" maxlength="10" restrict-input="{type: 'numberGreaterThanZero',index: $index}" min="1" data-ng-keyup="calculateFunds($index);checkForCellingValue($index)" type="text" data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].unitCost" class="form-control" style="text-align:right;" placeholder="Upper Ceiling Limit  Rs. 5 Lakh" />
												</td>
												<td>
													<input data-ng-disabled="true" style="background: #dddddd; text-align:right;" data-ng-change="insertCBMasterInScope($index)" type="text" data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].funds" class="form-control" placeholder=" " />
												</td>
												<!-- <td>
													<input type="text" data-ng-disabled="capacityBuilding.isFreeze" class="form-control" placeholder=" " />
												</td>
												<td>
													<input type="text" data-ng-disabled="capacityBuilding.isFreeze" class="form-control" placeholder=" " />
												</td> -->
												<td>
													<input type="text" data-ng-if="cbMaster.cbMasterId!=5 && cbMaster.cbMasterId!=6" data-ng-disabled="capacityBuilding.isFreeze" class="form-control" data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].collabInstitute" placeholder=" " style="text-align:right;"/>
													<input type="text" data-ng-if="cbMaster.cbMasterId==5 || cbMaster.cbMasterId==6" data-ng-disabled="true" class="form-control" style="background: #dddddd;"/>
												</td>
												<td  ng-if="userType == 'M' || userType == 'C'" align="center">
													<input type="checkbox" data-ng-disabled="capacityBuilding.isFreeze"  data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].isApproved"  />
												</td>
												<td ng-if="userType == 'M' || userType == 'C'" style="display: none">
													<input type="checkbox" data-ng-disabled="capacityBuilding.isFreeze" class="form-control" data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].isApproved" class="form-control" />
												</td>
												<td>
													<input data-ng-disabled="capacityBuilding.isFreeze" data-ng-change="insertCBMasterInScope($index)" type="text" data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].remarks" class="form-control" placeholder="Remarks" style="text-align:right;" />
												</td>
											</tr>
											<tr>
											<th colspan="5" align="center" >Total Funds</th>
											<td><input type="text" maxlength="5" data-ng-disabled="true" data-ng-model="subTotal" class="form-control" style="text-align:right;" /></td>											
											<td></td>
											<td></td>
											</tr>
											<tr>
											<th colspan="5">Additional Requirement</th>
											<td ><input type="text" restrict-input="{type: 'digitsOnly',index: $index}" data-ng-keyUp="validateAmount()"
														data-ng-model="capacityBuilding.additionalRequirement" data-ng-disabled="capacityBuilding.isFreeze" class="form-control" placeholder="25% of Total Cost " style="text-align:right;" /></td>
											<td></td>
											<td></td>
											</tr>
											<tr>
											<th colspan="5">
											Total Proposed Fund
											</th>
											<td ><input type="text" data-ng-disabled="true" data-ng-model="grandTotal" maxlength="5"  class="form-control" style="text-align:right;" /></td>
											<td></td>
											<td></td>
											</tr>
										</tbody>
									</table>
									</div>
									
									<!-- <div class="table-responsive">
										<table class="table table-hover dashboard-task-infos"  >
											<tr>
											
												<td colspan="1"><div>Sub Total</div></td>
												
												<td>
												<div class="col-sm-3" style="margin-left: 300px;">
													<input type="text" maxlength="5" data-ng-disabled="true" data-ng-model="subTotal" class="form-control" style="text-align:right;" />
												</div>
												</td>
											</tr>
										</table>
									</div> -->
									
									<!-- <div class="table-responsive">
										<table class="table table-hover dashboard-task-infos"  >
											<tr>
												
												<td><div class="col-sm-9">Additional Requirement</div></td>
												
												<td>
													<div class="col-sm-3" style="margin-left: 203px;">
														<input type="text" maxlength="5" restrict-input="{type: 'numberGreaterThanZero',index: $index}" data-ng-change="validateAmount()"
														data-ng-model="capacityBuilding.additionalRequirement" class="form-control" placeholder="25% of Total Cost " style="text-align:right;" />
													</div>
												</td>
											</tr>
										</table>
									</div> -->
									
									<!-- <div class="table-responsive">
										<table class="table table-hover dashboard-task-infos"  >
											<tr>
												
												<td><div class="col-sm-9">Grand Total</div></td>
												
												<td>
												<div class="col-sm-3" style="margin-left: 300px;">
													<input type="text" data-ng-disabled="true" data-ng-model="grandTotal" maxlength="5"  class="form-control" style="text-align:right;" />
												</div>
												</td>
											</tr>
										</table>
									</div> -->
									
							</div>
							
							
							<div class="form-group text-right ex1">
							<button ng-click="saveCapacityBuildingActivityAndDetails()" ng-disabled="capacityBuilding.isFreeze"  type="button" class="btn bg-green waves-effect">
									<spring:message code="Label.SAVE" htmlEscape="true" />
								</button>
								<button ng-show="capacityBuilding.isFreeze" type="button" data-ng-click="freezUnFreezCapacityBuilding('unfreeze')" class="btn bg-green waves-effect">
									<spring:message code="UNFREEZE" htmlEscape="true" />
								</button>
								<button ng-show="!capacityBuilding.isFreeze" type="button" data-ng-click="freezUnFreezCapacityBuilding('freeze')" class="btn bg-green waves-effect">
									<spring:message code="FREEZE" htmlEscape="true" />
								</button>
								
								<button type="button" data-ng-click="onClear()" ng-disabled="capacityBuilding.isFreeze"  class="btn bg-light-blue waves-effect">
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
<style>
.ex1 {
  margin-left: -26px;
}
</style>