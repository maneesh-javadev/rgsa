<html data-ng-app="trainingActivityModuleCEC">
<head>
<%@include file="../taglib/taglib.jsp"%>

<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/trainingActivityCEC/trainingActivityCecController.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/trainingActivityCEC/trainingActivityCecService.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/customValidationDirective.js"></script>
	<script type="text/javascript">
	function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
	}
	</script>
</head>
<section class="content" data-ng-controller="trainingActivityCEC">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<div data-ng-show="userType == 'C'">
							<h2>
								<%-- <spring:message code="Label.DistanceLearningHeader"
									htmlEscape="true" /> --%>
								Training Activity (CEC)
							</h2>
						</div>

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
							<div role="tabpanel" class="container tab-pane active" id="MOPR"
								style="width: auto;">
								<div class="table-responsive">

									<table class="table table-hover dashboard-task-infos"
										id="mytable">

										<thead>
											<tr>
												<th>
													<div align="center">
														<strong>S.No.</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Activity </strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>No. of Days </strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>No. of Units </strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Unit Cost<br>(In <i
															style="font-size: 15px" class="fa">&#xf156;</i>)
														</strong>
													</div>
												</th>

												<th>
													<div align="center">
														<strong>Funds Proposed<br>(In <i
															style="font-size: 15px" class="fa">&#xf156;</i>)
														</strong>
													</div>
												</th>
												<th><div align="center">
														<strong>Collaboration with Institute</strong>
													</div></th>
												<!-- <th>
													<div align="center">
														<strong>Is Approved</strong>
													</div>
												</th> -->
												<th>
													<div align="center">
														<strong>Remarks by State</strong>
													</div>
												</th>
											</tr>
										</thead>
										<tbody>
											<tr data-ng-repeat="cbMaster in cbmasters">
												<td>{{$index+1}}</td>
												<td align="center"
														data-ng-model="cecData.capacityBuildingActivityDetails[$index].cbMaster" 
														data-ng-init="cecData.capacityBuildingActivityDetails[$index].cbMaster=moprData.capacityBuildingActivityDetails[$index].cbMaster">
														<strong>	{{cbMaster.cbName}}</strong>
													
												</td>
												<td>
													<div align="center"
														data-ng-model="cecData.capacityBuildingActivityDetails[$index].noOfDays"
														data-ng-init="cecData.capacityBuildingActivityDetails[$index].noOfDays=moprData.capacityBuildingActivityDetails[$index].noOfDays"
														data-ng-show="$index+1==5 || $index+1==6" >
														<strong>{{moprData.capacityBuildingActivityDetails[$index].noOfDays}} </strong>
													</div>
													<div align="center"
														data-ng-model="cecData.capacityBuildingActivityDetails[$index].noOfDays"
														data-ng-init="cecData.capacityBuildingActivityDetails[$index].noOfDays=moprData.capacityBuildingActivityDetails[$index].noOfDays"
														data-ng-show="$index+1==1 || $index+1==2 || $index+1==3 || $index+1==4 || $index+1==7 || $index+1==8 ">
														<strong>1</strong>
													</div>
													
												</td>
												<td>
													
													<div align="center"
														data-ng-style="{'color':(moprData.capacityBuildingActivityDetails[$index].noOfUnits > cecData.capacityBuildingActivityDetails[$index].noOfUnits) ? 'red' : '#00cc00'}">
														<strong> 
															{{moprData.capacityBuildingActivityDetails[$index].noOfUnits}}
														</strong>
													</div>
													<input type="text" class="form-control"
													data-ng-change="calculateNewFund($index)" 
													data-ng-disabled="isFreezeOrUnfreeze"
													onkeypress="return isNumber(event)"
													data-ng-model="cecData.capacityBuildingActivityDetails[$index].noOfUnits"
													maxlength="7"
													style="text-align: right; border: none; border-color: transparent;" />
												</td>
												<td>
													<div align="center"
														data-ng-style="{'color':(moprData.capacityBuildingActivityDetails[$index].unitCost > cecData.capacityBuildingActivityDetails[$index].unitCost) ? 'red' : '#00cc00'}">
														<strong> <i style="font-size: 15px" class="fa">&#xf156;</i>
															{{moprData.capacityBuildingActivityDetails[$index].unitCost}}
														</strong>
													</div> <input type="text" class="form-control"
													data-ng-change="calculateNewFund($index)" 
													data-ng-disabled="isFreezeOrUnfreeze"
													onkeypress="return isNumber(event)"
													data-ng-model="cecData.capacityBuildingActivityDetails[$index].unitCost"
													maxlength="7"
													style="text-align: right; border: none; border-color: transparent;" />
													
												
												</td>
												<td>
													<div align="center"
														data-ng-style="{'color':(moprData.capacityBuildingActivityDetails[$index].funds > cecData.capacityBuildingActivityDetails[$index].funds) ? 'red' : '#00cc00'}">
														<strong> <i style="font-size: 15px" class="fa">&#xf156;</i>
															{{moprData.capacityBuildingActivityDetails[$index].funds}}
														</strong>
													</div>
													<input type="text" class="form-control"
													data-ng-disabled="true"
													data-ng-model="cecData.capacityBuildingActivityDetails[$index].funds"
													style="text-align: right; border: none; border-color: transparent;" />
													
														
																
													
													</td>
													<td>
													<div align="center"
														data-ng-model="cecData.capacityBuildingActivityDetails[$index].collabInstitute"
														data-ng-init="cecData.capacityBuildingActivityDetails[$index].collabInstitute=moprData.capacityBuildingActivityDetails[$index].collabInstitute">
														<strong>{{moprData.capacityBuildingActivityDetails[$index].collabInstitute}}</strong>
													</div>
													</td>
												<td>
													<div align="center"
														data-ng-model="cecData.capacityBuildingActivityDetails[$index].remarks"
														data-ng-init="cecData.capacityBuildingActivityDetails[$index].remarks=moprData.capacityBuildingActivityDetails[$index].remarks">
														<strong>{{moprData.capacityBuildingActivityDetails[$index].remarks}}</strong>
													</div>
													
												</td>
											</tr>
											<tr>
												<th colspan="5" align="center">Total Funds</th>
												<td><div align="center" data-ng-style="{'color':(totalFund > stateTotalFund) ? 'red' : '#00cc00'}"><i style="font-size: 15px" class="fa">&#xf156;</i>{{totalFund}}</div>
												<input type="text" class="form-control"
													data-ng-model="stateTotalFund" 
													readonly="readonly"
													style="text-align: right; border: none; border-color: transparent;" />
												</td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<th colspan="5" align="center">Additional Requirement</th>
												<td>
													<!-- <div align="center"><i style="font-size: 15px" class="fa">&#xf156;</i>  {{stateAdditionalReq}}</div> -->
													<div align="center"
														data-ng-style="{'color':(additionalReq > cecData.additionalRequirement) ? 'red' : '#00cc00'}">
														<strong> <i style="font-size: 15px" class="fa">&#xf156;</i>
															{{additionalReq}}
														</strong>
													</div>
													<input type="text" class="form-control"
													data-ng-model="cecData.additionalRequirement" data-ng-change="calculateAdditionalRequirment()"
													placeholder=""
													data-ng-disabled="isFreezeOrUnfreeze"
													style="text-align: right; border: none; border-color: transparent;" />
												</td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<th colspan="5" align="center">Total Proposed Fund</th>
												<td><div align="center" data-ng-style="{'color':(stateGrandTotalInCEC > stateGrandTotal) ? 'red' : '#00cc00'}"><i style="font-size: 15px" class="fa">&#xf156;</i> {{grandTotal}}</div>
												<input type="text" class="form-control"
													data-ng-model="stateGrandTotal" 
													readonly="readonly"
													style="text-align: right; border: none; border-color: transparent;" />
												</td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="row clearfix">
								<div class="col-md-4  text-left">
										&nbsp;&nbsp;
										<button type="button"
											onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
											class="btn bg-orange waves-effect">
											<i class="fa fa-arrow-left" aria-hidden="true"></i>
											<spring:message code="Label.BACK" htmlEscape="true" />
										</button>
										<br>
									</div>
								<div class="col-md-8 text-right ex1">
									<button data-ng-click="saveTrainingActivityCecDetails()" data-ng-disabled="isFreezeOrUnfreeze || btn_disabled" 
										type="button" class="btn bg-green waves-effect">
										<spring:message code="Label.SAVE" htmlEscape="true" />
									</button>
									<button
										data-ng-click="freezeUnfreezeTrainingActivityCecDetails($event)"
										data-legend="{{status}}"
										type="button"
										 class="btn bg-green waves-effect" 
										 id="btnfreezeUnfreeze"
										 value="">
										<spring:message code="Freeze" htmlEscape="true" />
									</button>
									<%-- <button type="button" data-ng-click="onClear()"
										class="btn bg-light-blue waves-effect" data-ng-disabled="isFreezeOrUnfreeze" > 
										<spring:message code="Label.CLEAR" htmlEscape="true" />
									</button> --%>
									<button type="button"
										onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-orange waves-effect">
										<spring:message code="Label.CLOSE" htmlEscape="true" />
									</button>
								</div>
								</div>
							</div>
							<div role="tabpanel" class="container tab-pane" id="state"
								style="width: auto;">
								<div class="table-responsive">
									<table class="table table-hover dashboard-task-infos"
										id="mytable">

										<thead>
											<tr>
												<th>
													<div align="center">
														<strong>S.No.</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Activity </strong>
													</div>
												</th>

												<th>
													<div align="center">
														<strong>No. of Days </strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>No. of Units </strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Unit Cost<br>(In <i
															style="font-size: 15px" class="fa">&#xf156;</i>)
														</strong>
													</div>
												</th>

												<th>
													<div align="center">
														<strong>Funds Proposed<br>(In <i
															style="font-size: 15px" class="fa">&#xf156;</i>)
														</strong>
													</div>
												</th>
												<th><div align="center">
														<strong>Collaboration with Institute</strong>
													</div></th>
												<!-- <th>
													<div align="center">
														<strong>Is Approved</strong>
													</div>
												</th> -->
												<th>
													<div align="center">
														<strong>Remarks by State</strong>
													</div>
												</th>
											</tr>
										</thead>

										<tbody>
											<tr data-ng-repeat="cbMaster in cbmasters">
												<td><div align="center">{{$index+1}}</div></td>
												<td><div align="center">{{cbMaster.cbName}}</div></td>
												<td><div align="center" data-ng-show="$index+1==5 || $index+1==6">{{stateData.capacityBuildingActivityDetails[$index].noOfDays}}</div>
													<div align="center" data-ng-show="$index+1==1 || $index+1==2 || $index+1==3 || $index+1==4 || $index+1==7 || $index+1==8 ">1</div>
												</td>
												<td><div align="center">{{stateData.capacityBuildingActivityDetails[$index].noOfUnits}}</div></td>
												<td><div align="center">{{stateData.capacityBuildingActivityDetails[$index].unitCost}}</div></td>
												<td><div align="center">{{stateData.capacityBuildingActivityDetails[$index].funds}}</div></td>
												<td><div align="center">{{stateData.capacityBuildingActivityDetails[$index].collabInstitute}}</div></td>
												<td><div align="center">{{stateData.capacityBuildingActivityDetails[$index].remarks}}</div></td>
											</tr>
											<tr>
												<th colspan="5" align="center">Total Funds</th>
												<td><div align="center">{{stateFundTotalInCEC}}</div></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<th colspan="5" align="center">Additional Requirement</th>
												<td><div align="center">{{stateAdditionalReq}}</div></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<th colspan="5" align="center">Total Proposed Fund</th>
												<td><div align="center">{{stateGrandTotalInCEC}}</div></td> 
												<td></td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
									</table>
								</div>	
								<div class="row clearfix">
								<div class="col-md-4  text-left">
										&nbsp;&nbsp;
										<button type="button"
											onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
											class="btn bg-orange waves-effect">
											<i class="fa fa-arrow-left" aria-hidden="true"></i>
											<spring:message code="Label.BACK" htmlEscape="true" />
										</button>
										<br>
									</div>
									<div class="col-md-8 text-right ex1">
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
