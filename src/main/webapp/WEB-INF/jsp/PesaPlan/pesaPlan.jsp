<%@include file="../taglib/taglib.jsp"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pesaPlan/pesaPlanController.js"></script>
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

<section data-ng-controller="pesaPlanController" class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>PESA Plan</h2>
					</div>

					<div class="tab-content">
						<div role="tabpanel" class="tab-pane fade in active" id="home_with_icon_title">
							<div class="table-responsive">

								<table class="table table-hover dashboard-task-infos"
									id="mytable">
									<thead>
										<tr>
											<th rowspan="2"><div align="center">
													<strong>Designation</strong>
												</div></th>
											<th rowspan="2"><div align="center">
													<strong>No. of Units<br> A
													</strong>
												</div></th>
											<th rowspan="2"><div align="center">
													<strong>Unit Cost per month (in Rs) <br> B
													</strong>
												</div></th>
											<th rowspan="2"><div align="center">
													<strong>No. of Months<br> C
													</strong>
												</div></th>
											<th rowspan="2"><div align="center">
													<strong>Funds (in Rs) <br>D = A * B * C
													</strong>
												</div></th>
											<th rowspan="2" data-ng-if="userType != 'S'">Is Approved</th>
											<th rowspan="2"><div align="center"><strong>Remarks</strong></div></th>
											
											<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
											<th colspan="2" rowspan="1">
												<div align="center">
													<strong>Previous comment history</strong>
												</div>
											</th>
											</c:if>
										</tr>
										<tr>
											<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
												<th >
													<div align="center">
														<strong>State Previous Comments <span style="color: #396721;">&nbsp;<i class="fa fa-circle"></i></span></strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>MOPR's Feedback <span style="color: #bc6317;">&nbsp;<i class="fa fa-circle"></i></span></strong>
													</div>
												</th>
											</c:if>
										</tr>
									</thead>
									<tbody>
										<tr data-ng-repeat="designation in designationArray" data-ng-init="outerIndex = $index">

											<td>
												<div>
													<div>
														<label style="text-align: center;" data-ng-model="pesaPlan.pesaPlanDetails[$index].pesaPostId">{{designation.pesaPostName}}</label>
													</div>
												</div>
											</td>

											<td>
												<input id="noOfUnits" maxlength="5" type="text" restrict-input="{type: 'digitsOnly',index: $index}"  
													 data-ng-disabled="pesaPlan.isFreez" data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)" 
													data-ng-model="pesaPlan.pesaPlanDetails[$index].noOfUnits" class="form-control" placeholder="No. of Units" required style="text-align:right;"/>
											</td>
											<td>
												<input type="text" maxlength="5" restrict-input="{type: 'digitsOnly'}" data-ng-disabled="pesaPlan.isFreez"  
												data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)" data-ng-model="pesaPlan.pesaPlanDetails[$index].unitCostPerMonth" 
												class="form-control" placeholder="unit cost per month" style="text-align:right;"/>
											</td>
											<td>
												<input type="text" restrict-input="{type: 'monthOnly'}" data-ng-disabled="pesaPlan.isFreez" data-ng-if="designation.pesaPostId != 4"
												data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)" 
												data-ng-model="pesaPlan.pesaPlanDetails[$index].noOfMonths" class="form-control" placeholder="No. of months"  style="text-align:right;"/>
												
												<input type="text"  data-ng-if="designation.pesaPostId == 4" data-ng-disabled="true" 
													    style="background: #dddddd; text-align:right;" class="form-control" placeholder="1" />
											</td>
											<td>
												<input type="text" data-ng-readOnly = "true" restrict-input="{type: 'digitsOnly'}" 
												data-ng-model="pesaPlan.pesaPlanDetails[$index].funds" class="form-control active1" 
												placeholder=" <= {{designationArray[$index].ceilingValue}} " style="text-align:right;" />
											</td>
											<td data-ng-if="userType != 'S'">
												<input type="checkbox" data-ng-disabled="pesaPlan.isFreez" data-ng-model="pesaPlan.pesaPlanDetails[$index].isApproved"/>
											</td>
											<td>
												<input type="text" data-ng-disabled="pesaPlan.isFreez" data-ng-model="pesaPlan.pesaPlanDetails[$index].remarks" class="form-control" placeholder="Enter Remarks" style="text-align:right;"/>
											</td>
											
											<c:if
											test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
											<td>
												<ol>
														<li data-ng-repeat="stateComments in statePreComments[outerIndex] track by $index" style="color: #396721; font-weight: bold;">
															{{stateComments}}
															</li>
												</ol>
											</td>

											<td>
												<ol>
													<li data-ng-repeat="moprComments in moprPreComments[outerIndex] track by $index" style="color: #bc6317; font-weight: bold;">
													{{moprComments}}</li>
												</ol>
											</td>
										</c:if>
										</tr>


										<tr>
											<td><div class="col-sm-2"><label>Total Fund</label></div></td>
											<td></td>
											<td></td>
											<td></td>
											<td>
												<div>
													<input type="text" data-ng-disabled="true" data-ng-model="totalWithoutAddRequirements" class="form-control" style="background: #dddddd; text-align:right;"/>
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
												<div>
													<input type="text" data-ng-disabled="pesaPlan.isFreez" restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" data-ng-keyUp="calculateGrandTotal()" class="form-control" data-ng-model="pesaPlan.additionalRequirement" placeholder="25% of Total Cost " style="text-align:right;"/>
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
												<div>
													<input data-ng-disabled="true" style="background: #dddddd; text-align:right;" type="text" data-ng-model="grandTotal" class="form-control" placeholder="Grand Total "  />
												</div>
											</td>
											<td>
												
											 </td>
										</tr>
										
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="col-md-4  text-left" data-ng-show="userType !='S'" style="margin-bottom: 5px">
								&nbsp;&nbsp;<button type="button"
									onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
									class="btn bg-orange waves-effect">
									<i class="fa fa-arrow-left" aria-hidden="true"></i>
									<spring:message code="Label.BACK" htmlEscape="true" />
								</button><br>
							</div>
					<div class="form-group text-right" style="padding-bottom: 10px;padding-right: 10px;">
					 <c:if test="${Plan_Status eq true}"> 
				     	<button type="button" data-ng-click="savePesaPlan()" data-ng-disabled="pesaPlan.isFreez" class="btn bg-green waves-effect">
							<spring:message code="Label.SAVE" htmlEscape="true" />
						</button>
						<button data-ng-show=" pesaPlan.isFreez" type="button" data-ng-click="freezUnFreezPesaPlan('unfreez')" class="btn bg-orange waves-effect">
							<spring:message code="UNFREEZE" htmlEscape="true" />
						</button>
						<button data-ng-show="(typeof(pesaPlan.isFreez) !== 'undefined') && !pesaPlan.isFreez" type="button" data-ng-click="freezUnFreezPesaPlan('freez')" class="btn bg-orange waves-effect">
							<spring:message code="FREEZE" htmlEscape="true" />
						</button>
						
						<button type="button" data-ng-click="onClear()" data-ng-disabled="pesaPlan.isFreez" class="btn bg-light-blue waves-effect">
							<spring:message code="Label.CLEAR" htmlEscape="true" />
						</button>
						</c:if>
						<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-red waves-effect">
							<spring:message code="Label.CLOSE" htmlEscape="true" />
						</button>
					</div>
				</div>
			</div>
		</div>
		</div>
</section>

</html>