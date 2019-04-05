<%@include file="../taglib/taglib.jsp"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pesaPlan/pesaPlanCECController.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pesaPlan/pesa-plan-model.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pesaPlan/pesaPlanService.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<script type="text/javascript">
$('document').ready(function(){
	
	 $('.active1').prop('readonly',true);
   
});

</script>

<html data-ng-app="publicModule">

<section data-ng-controller="pesaPlanCECController" class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>PESA Plan (CEC)</h2>
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
							<div role="tabpanel" class="container tab-pane active" id="state"
								style="width: auto;">
								<div class="table-responsive">

									<table class="table table-hover dashboard-task-infos"
										id="mytable">

										<thead>
										<tr>
											<th><div align="center">
													<strong>Designation</strong>
												</div></th>
											<th><div align="center">
													<strong>No. of Units<br> A
													</strong>
												</div></th>
											<th><div align="center">
													<strong>Unit Cost per month (in Rs) <br> B
													</strong>
												</div></th>
											<th><div align="center">
													<strong>No. of Months<br> C
													</strong>
												</div></th>
											<th><div align="center">
													<strong>Funds (in Rs) <br>D = A * B * C
													</strong>
												</div></th>
											<!-- <th data-ng-if="userType != 'S'">Is Approved</th>
											<th data-ng-if="userType != 'S'"><div align="center"><strong>Remarks</strong></div></th> -->
										</tr>
									</thead>
										<tbody>
										<tr data-ng-repeat="designation in designationArray" >

											<td>
												<div>
													<div>
														<label style="text-align: center;" data-ng-model="pesaPlan.pesaPlanDetails[$index].pesaPostId">{{designation.pesaPostName}}</label>
													</div>
												</div>
											</td>

											<td>
											
											
												<div align="center"
														data-ng-style="{'color':(pesaPlanForState.pesaPlanDetails[$index].noOfUnits > pesaPlanForCEC.pesaPlanDetails[$index].noOfUnits) ? 'red' : '#00cc00'}">
														<strong> 
															{{pesaPlanForState.pesaPlanDetails[$index].noOfUnits}}
														</strong>
													</div> 
													
													<input type="text" class="form-control"
													data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)" 
													data-ng-disabled="isFreezeOrUnfreeze"
													onkeypress="return isNumber(event)"
													data-ng-model="pesaPlanForCEC.pesaPlanDetails[$index].noOfUnits"
													maxlength="7"
													style="text-align: right; border: none; border-color: transparent;" />
											
												
											</td>
											<td>
											
													<div align="center"
														data-ng-style="{'color':(pesaPlanForState.pesaPlanDetails[$index].unitCostPerMonth > pesaPlanForCEC.pesaPlanDetails[$index].unitCostPerMonth) ? 'red' : '#00cc00'}">
														<strong> <i style="font-size: 15px" class="fa">&#xf156;</i>
															{{pesaPlanForState.pesaPlanDetails[$index].unitCostPerMonth}}
														</strong>
													</div> 
													
													<input type="text" class="form-control"
													data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)" 
													data-ng-disabled="isFreezeOrUnfreeze"
													onkeypress="return isNumber(event)"
													data-ng-model="pesaPlanForCEC.pesaPlanDetails[$index].unitCostPerMonth"
													maxlength="7"
													style="text-align: right; border: none; border-color: transparent;" />
												
											</td>
											<td>
											<div align="center"
														data-ng-style="{'color':(pesaPlanForState.pesaPlanDetails[$index].noOfMonths > pesaPlanForCEC.pesaPlanDetails[$index].noOfMonths) ? 'red' : '#00cc00'}">
														<strong>
															{{pesaPlanForState.pesaPlanDetails[$index].noOfMonths}}
														</strong>
													</div> <input type="text" class="form-control"
													data-ng-disabled="isFreezeOrUnfreeze"
													data-ng-if="designation.pesaPostId != 4"
													data-ng-model="pesaPlanForCEC.pesaPlanDetails[$index].noOfMonths"\
													data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)" 
													style="text-align: right; border: none; border-color: transparent;" />
											
												
												<input type="text"  data-ng-if="designation.pesaPostId == 4" data-ng-disabled="true"  data-ng-disabled="true"
													    style="background: #dddddd; text-align:right;margin-top: 15px;" class="form-control" placeholder="1" />	
												
											</td>
											<td>
											
													<div align="center"
														data-ng-style="{'color':(pesaPlanForState.pesaPlanDetails[$index].funds > pesaPlanForCEC.pesaPlanDetails[$index].funds) ? 'red' : '#00cc00'}" >
														<strong> <i style="font-size: 15px;" class="fa">&#xf156;</i>
															{{pesaPlanForState.pesaPlanDetails[$index].funds}}
														</strong>
													</div> 
													
													<input type="text" class="form-control"
													
													data-ng-disabled="true"
													onkeypress="return isNumber(event)"
													data-ng-model="pesaPlanForCEC.pesaPlanDetails[$index].funds"
													maxlength="7"
													style="text-align: right; border: none; border-color: transparent;" />
											
												
											</td>
											<!-- <td data-ng-if="userType != 'S'">
												<input type="checkbox" data-ng-disabled="pesaPlan.isFreez"  data-ng-model="pesaPlan.pesaPlanDetails[$index].isApproved"/>
											</td>
											<td data-ng-if="userType != 'S'">
												<input type="text" data-ng-disabled="pesaPlan.isFreez"  data-ng-model="pesaPlan.pesaPlanDetails[$index].remarks" class="form-control" placeholder="Enter Remarks" style="text-align:right;"/>
											</td> -->
										</tr>


										<tr>
											<td><div class="col-sm-2"><label>Total Fund</label></div></td>
											<td></td>
											<td></td>
											<td></td>
											<td>
												<div align="center"
														data-ng-style="{'color':(totalWithoutAddRequirementsForState > totalWithoutAddRequirementsForCEC) ? 'red' : '#00cc00'}">
														<strong> <i style="font-size: 15px" class="fa">&#xf156;</i>
															{{totalWithoutAddRequirementsForState}}
														</strong>
													</div>
												<div>
													<input type="text" data-ng-disabled="true" data-ng-model="totalWithoutAddRequirementsForCEC" class="form-control" style="background: #dddddd; text-align:right;"/>
												</div>
											</td>
											<td>
												
											 </td>
										</tr>

										<tr>
											<td colspan="2">
											
													
												<div class="col-sm-7"><label>Additional Requirement</label></div></td>
											<td></td>
											<td></td>
											<td>
												<div align="center"
														data-ng-style="{'color':(pesaPlanForState.additionalRequirement > pesaPlanForCEC.additionalRequirement) ? 'red' : '#00cc00'}">
														<strong> <i style="font-size: 15px" class="fa">&#xf156;</i>
															{{pesaPlanForState.additionalRequirement}}
														</strong>
													</div>
												<div>
													<input type="text" data-ng-disabled="isFreezeOrUnfreeze" restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" data-ng-keyUp="calculateGrandTotal()"  class="form-control" data-ng-model="pesaPlanForCEC.additionalRequirement" placeholder="25% of Total Cost " style="text-align:right;"/>
												</div>
											</td>
											<td>
											</td>
										</tr>
										
										<tr>
											<td  colspan="2">
												<div class="col-sm-8">
													<label>Total Proposed Fund</label>
												</div>
											</td>
											<td></td>
											<td></td>
											<td>
											
												<div align="center"
														data-ng-style="{'color':(grandTotalForState > grandTotalForCEC) ? 'red' : '#00cc00'}">
														<strong> <i style="font-size: 15px" class="fa">&#xf156;</i>
															{{grandTotalForState}}
														</strong>
													</div>
												<div>
													<input data-ng-disabled="true" style="background: #dddddd; text-align:right;" type="text" data-ng-model="grandTotalForCEC" class="form-control" placeholder="Grand Total "  />
												</div>
											</td>
											<td>
												
											 </td>
										</tr>
										
									</tbody>
									</table>
								</div>
								<div class="row clearfix">
									<div class="col-md-4  text-left" style="margin-bottom: 5px">
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
										<button ng-click="savePesaPlan()"
											ng-disabled="isFreezeOrUnfreeze" type="button"
											class="btn bg-green waves-effect">
											<spring:message code="Label.SAVE" htmlEscape="true" />
										</button>
										<button data-ng-show=" pesaPlanForCEC.isFreez" type="button"
											data-ng-click="freezUnFreezPesaPlan('unfreez')"
											class="btn bg-green waves-effect">
											<spring:message code="UNFREEZE" htmlEscape="true" />
										</button>
										<button
											data-ng-show="(typeof(pesaPlanForCEC.isFreez) !== 'undefined') && !pesaPlanForCEC.isFreez"
											type="button" data-ng-click="freezUnFreezPesaPlan('freez')"
											class="btn bg-green waves-effect">
											<spring:message code="FREEZE" htmlEscape="true" />
										</button>
										<button type="button" data-ng-click="onClear()"
											class="btn bg-light-blue waves-effect" data-ng-disabled="isFreezeOrUnfreeze">
											<spring:message code="Label.CLEAR" htmlEscape="true" />
										</button>
										<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">
											<spring:message code="Label.CLOSE" htmlEscape="true" />
										</button>
									</div>
								</div>
							</div>
							<div role="tabpanel" class="container tab-pane" id="MOPR"
								style="width: auto;">
								<div class="table-responsive">
									<table class="table table-hover dashboard-task-infos"
										id="mytable">

										<thead>
										<tr>
											<th><div align="center">
													<strong>Designation</strong>
												</div></th>
											<th><div align="center">
													<strong>No. of Units<br> A
													</strong>
												</div></th>
											<th><div align="center">
													<strong>Unit Cost per month (in Rs) <br> B
													</strong>
												</div></th>
											<th><div align="center">
													<strong>No. of Months<br> C
													</strong>
												</div></th>
											<th><div align="center">
													<strong>Funds (in Rs) <br>D = A * B * C
													</strong>
												</div></th>
												<th data-ng-if="userType != 'S'">Is Approved</th>
												<th data-ng-if="userType != 'S'"><div align="center"><strong>Remarks</strong></div></th>
										<!-- 	<th data-ng-if="userType != 'S'">Is Approved</th>
											<th data-ng-if="userType != 'S'"><div align="center"><strong>Remarks</strong></div></th> -->
										</tr>
									</thead>

										<tbody>
											<tr data-ng-repeat="designation in designationArray">
												
												<td><div align="center">{{designation.pesaPostName}}</div></td>
												<td><div align="center">{{pesaPlanForMOPR.pesaPlanDetails[$index].noOfUnits}}</div></td>
												<td><div align="center">{{pesaPlanForMOPR.pesaPlanDetails[$index].unitCostPerMonth}}</div></td>
												<td>
												<div align="center" data-ng-if="designation.pesaPostId != 4">{{pesaPlanForMOPR.pesaPlanDetails[$index].noOfMonths}}</div>
												<div align="center" data-ng-if="designation.pesaPostId == 4">1</div>
												</td>
												 <td><div align="center">{{pesaPlanForMOPR.pesaPlanDetails[$index].funds}}</div></td>
												
												<td>
													<div align="center"
														data-ng-if="pesaPlanForMOPR.pesaPlanDetails[$index].isApproved">
														<i class="fa fa-check" aria-hidden="true"
															style="color: #00cc00"></i>
													</div>
													<div align="center"
														data-ng-if="!pesaPlanForMOPR.pesaPlanDetails[$index].isApproved">
														<i class="fa fa-times" aria-hidden="true"
															style="color: red"></i>
													</div>
												</td>
												<td><div align="center">{{pesaPlanForMOPR.pesaPlanDetails[$index].remarks}}</div></td>
											</tr>
											<tr>
												<th colspan="4" align="center">Total Funds</th>
												<th><div align="center">{{totalWithoutAddRequirementsForMOPR}}</div></th>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<th colspan="4" align="center">Additional Requirement</th>
												<th><div align="center">{{pesaPlanForMOPR.additionalRequirement}}</div></th>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<th colspan="4" align="center">Total Proposed Fund</th>
												<th><div align="center">{{grandTotalForMOPR}}</div></th>
												<td></td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="row clearfix">
									<div class="col-md-4  text-left" style="margin-bottom: 5px">
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