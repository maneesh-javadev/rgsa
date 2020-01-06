<html data-ng-app="publicModule">
<head>
<%@include file="../taglib/taglib.jsp"%>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/satcomeIpBasedTech/satcomController.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/satcomeIpBasedTech/satcomService.js"></script>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>



</head>
<section class="content" data-ng-controller="satcomController"> 
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
							<div data-ng-show="userType == 'S'"><h2><spring:message code="Label.DistanceLearningHeader" htmlEscape="true" /></h2></div>
							<div data-ng-show="userType == 'M'"><h2><spring:message code="Label.DistanceLearningHeader" htmlEscape="true" />(MoPR)</h2></div>
							<div data-ng-show="userType == 'C'"><h2><spring:message code="Label.DistanceLearningHeader" htmlEscape="true" />(CEC)</h2></div>
						
					</div>
					<div class="body">
						
						<!-- CEC section starts from here  -->
							<div data-ng-show="userType == 'C'">
								<ul class="nav nav-tabs">
									<li class="nav-item"><a class="nav-link active"
										data-toggle="tab" href="#state"><spring:message code="Label.STATE" htmlEscape="true" /></a></li>
									<li class="nav-item"><a class="nav-link" data-toggle="tab"
										href="#MOPR"><spring:message code="Label.MOPR" htmlEscape="true" /></a></li>
								</ul>
								
								<div class="tab-content">
									<div role="tabpanel" class="container tab-pane active" id="MOPR" style="width: auto;">
									<table class="table table-bordered">
										<thead>
											<tr>
												<th>
													<div align="center">
														<strong><spring:message code="Label.NameOfActivity" htmlEscape="true" /></strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.PanchayatLevel" htmlEscape="true" /></strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.NoOfUnits" htmlEscape="true" /><br>A
														</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.UnitCost" htmlEscape="true" /> (in Rs)<br>B
														</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.FundProposed" htmlEscape="true" />  (in Rs)<br>C = A * B
														</strong>
													</div>
												</th>
											</tr>
										</thead>
										<tbody>
											<tr data-ng-repeat="activity in activityList"
												data-ng-init="outerIndex=$index">
												<td>
													<div align="center">
														{{activity.satcomMasterName}} <input type="hidden"
															data-ng-model="satcomActivityObject.activityDetails[$index].satcomMaster.satcomMasterId"
															data-ng-init="satcomActivityObject.activityDetails[$index].satcomMaster.satcomMasterId=activity.satcomMasterId" />
													</div>
												</td>
												<td>
													<div align="center">
														<input type="hidden"
															data-ng-model="satcomActivityObject.activityDetails[$index].level.satcomLevelId" />
															<input type="hidden"
															data-ng-model="satcomActivityObject.activityDetails[outerIndex].level.satcomLevelId" value="{{satcomActivityObjectMOPR.activityDetails[outerIndex].level.satcomLevelName}}"/>
															<div align="center" ><strong>{{satcomActivityObjectMOPR.activityDetails[outerIndex].level.satcomLevelName}}</strong></div>
													<!-- 	<select
															data-ng-disabled="satcomActivityObject.status == 'F'"
															data-ng-model="satcomActivityObject.activityDetails[outerIndex].level.satcomLevelId"
															data-convert-to-number class="form-control col-sm-1">
															<option value="0"> Please Select </option>
															<option data-ng-repeat="level in satComLevel"
																value="{{level.satcomLevelId}}">{{level.satcomLevelName}}</option>
														</select> -->
													</div>
												</td>
												<td>
												<div align="center" data-ng-style="{'color':(satcomActivityObjectMOPR.activityDetails[$index].noOfUnits > satcomActivityObject.activityDetails[$index].noOfUnits) ? 'red' : '#00cc00'}"><strong>{{satcomActivityObjectMOPR.activityDetails[$index].noOfUnits}}</strong></div>
												<input type="text" maxlength="6"
													data-ng-show="satcomActivityObject.status != 'F'"
													data-restrict-input="{type: 'digitsOnly',index: $index}"
													data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)"
													data-ng-model="satcomActivityObject.activityDetails[$index].noOfUnits"
													class="form-control" style="text-align: right;" /> <input
													type="text" maxlength="6"
													data-ng-show="satcomActivityObject.status == 'F'"
													disabled="disabled"
													data-restrict-input="{type: 'digitsOnly',index: $index}"
													data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)"
													data-ng-model="satcomActivityObject.activityDetails[$index].noOfUnits"
													class="form-control" style="text-align: right;" /></td>
													
													
												<td>
												<div align="center" data-ng-style="{'color':(satcomActivityObjectMOPR.activityDetails[$index].unitCost > satcomActivityObject.activityDetails[$index].unitCost ) ? 'red' : '#00cc00'}"><strong>{{satcomActivityObjectMOPR.activityDetails[$index].unitCost}}</strong></div>
												<input type="text" maxlength="5"
													data-ng-show="satcomActivityObject.status != 'F'"
													data-restrict-input="{type: 'digitsOnly',index: $index}"
													data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)"
													data-ng-model="satcomActivityObject.activityDetails[$index].unitCost"
													class="form-control validate" style="text-align: right;" />
													<input type="text" maxlength="5"
													data-ng-show="satcomActivityObject.status == 'F'"
													disabled="disabled"
													data-restrict-input="{type: 'digitsOnly',index: $index}"
													data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)"
													data-ng-model="satcomActivityObject.activityDetails[$index].unitCost"
													class="form-control validate" style="text-align: right;" />
												</td>
												<td>
												<div align="center" data-ng-style="{'color':(satcomActivityObjectMOPR.activityDetails[$index].funds > satcomActivityObject.activityDetails[$index].funds ) ? 'red' : '#00cc00'}"><strong>{{satcomActivityObjectMOPR.activityDetails[$index].funds}}</strong></div>
												<input type="text"
													data-ng-disabled="satcomActivityObject.status == 'F'"
													data-ng-model="satcomActivityObject.activityDetails[$index].funds"
													class="form-control" style="text-align: right;" /> </td>
											</tr>

											<tr>
												<th colspan="4"><label><spring:message code="Label.TotalFund" htmlEscape="true" /></label></th>

												<td>
												<div align="center" data-ng-style="{'color':(totalWithoutAddRequirementsForMOPR > totalWithoutAddRequirements) ? 'red' : '#00cc00'}"><strong>{{totalWithoutAddRequirementsForMOPR}}</strong></div>
												<input type="text" data-ng-disabled="true"
													data-ng-model="totalWithoutAddRequirements"
													class="form-control"
													style="background: #dddddd; text-align: right;" /></td>
											</tr>

											<tr>
												<th colspan="4"><label><spring:message code="Label.AdditionalRequirement" htmlEscape="true" /></label></th>

												<td>
												<div align="center" data-ng-style="{'color':(satcomActivityObjectMOPR.additionalRequirement > satcomActivityObject.additionalRequirement ) ? 'red' : '#00cc00'}"><strong>{{satcomActivityObjectMOPR.additionalRequirement}}</strong></div>
												<input type="text"
													data-ng-show="satcomActivityObject.status == 'F'"
													data-restrict-input="{type: 'digitsOnly',index: $index}"
													maxlength="6" data-ng-keyUp="calculateGrandTotal()"
													class="form-control"
													data-ng-model="satcomActivityObject.additionalRequirement"
													placeholder="25% of Total Cost " style="text-align: right;"
													disabled="disabled" /> <input type="text"
													data-ng-show="satcomActivityObject.status != 'F'"
													data-restrict-input="{type: 'digitsOnly',index: $index}"
													maxlength="6" data-ng-keyUp="calculateGrandTotal()"
													class="form-control"
													data-ng-model="satcomActivityObject.additionalRequirement"
													placeholder="25% of Total Cost " style="text-align: right;" />
												</td>

											</tr>

											<tr>
												<th colspan="4"><label><spring:message code="Label.TotalProposedFund" htmlEscape="true" /></label></th>

												<td>
												<div align="center" data-ng-style="{'color':(grandTotalForMOPR > grandTotal) ? 'red' : '#00cc00'}"><strong>{{grandTotalForMOPR}}</strong></div>
												<input data-ng-disabled="true"
													style="background: #dddddd; text-align: right;" type="text"
													data-ng-model="grandTotal" class="form-control"
													placeholder="Total proposed fund" /></td>

											</tr>

										</tbody>
									</table>
									<div class="col-md-4">
										<button type="button"
											onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
											class="btn bg-orange waves-effect">
											<i class="fa fa-arrow-left" aria-hidden="true"></i>
											<spring:message code="Label.BACK" htmlEscape="true" />
										</button>
									</div>
									<div class=" col-md-8 text-right">
								<button data-ng-show="satcomActivityObject.status == 'F'"
									data-ng-click="saveData('S')" type="button"
									class="btn bg-green waves-effect" disabled="disabled">
									<spring:message code="Label.SAVE" htmlEscape="true" />
								</button>
								<button type="button"
									data-ng-show="satcomActivityObject.status != 'F'" data-ng-disabled="disable_save"
									data-ng-click="saveData('S')" class="btn bg-green waves-effect">
									<spring:message code="Label.SAVE" htmlEscape="true" />
								</button>
								<button data-ng-show="satcomActivityObject.status != 'F' "
									data-ng-click="saveData('F')" type="button" data-ng-disabled="initialFlag"
									class="btn bg-green waves-effect">
									<spring:message code="Label.FREEZE" htmlEscape="true" />
								</button>
								<button data-ng-show="satcomActivityObject.status == 'F'"
									type="button" data-ng-click="saveData('UF')"
									class="btn bg-green waves-effect">
									<spring:message code="Label.UNFREEZE" htmlEscape="true" />
								</button>
								<button type="button"
									data-ng-show="satcomActivityObject.status == 'F'"
									class="btn bg-light-blue waves-effect" disabled="disabled">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</button>
								<button type="button" data-ng-click="claerAll()"
									data-ng-show="satcomActivityObject.status != 'F'"
									class="btn bg-light-blue waves-effect">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</button>
								<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-orange waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
							</div>
								</div>
									
									<div class="container tab-pane fade" id="state" style="width: auto;">
									<table class="table table-bordered">
										<thead>
											<tr>
											<th>
													<div align="center">
														<strong><spring:message code="Label.NameOfActivity" htmlEscape="true" /></strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.PanchayatLevel" htmlEscape="true" /></strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.NoOfUnits" htmlEscape="true" /><br>A
														</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.UnitCost" htmlEscape="true" /> (in Rs)<br>B
														</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong><spring:message code="Label.FundProposed" htmlEscape="true" />  (in Rs)<br>C = A * B
														</strong>
													</div>
												</th>
												<%-- <th data-ng-if="userType != 'S'"><div align="center"><strong><spring:message code="Label.isApproved" htmlEscape="true" /></strong></div></th> --%>
												<th data-ng-if="userType != 'S'"><div align="center"><strong><spring:message code="Label.Remarks" htmlEscape="true" /></strong></div></th>
											</tr>
										</thead>
										<tbody>
											<tr data-ng-repeat="activity in activityList"
												data-ng-init="outerIndex=$index">
												<td>
													<div align="center">{{activity.satcomMasterName}}</div>
												</td>
												<td>
													<div align="center">
														<div align="center">
															<span>{{satcomActivityObjectState.activityDetails[outerIndex].level.satcomLevelId}}</span>
														</div>
													</div>
												</td>
												<td>
													<div align="center">
														<span>{{satcomActivityObjectState.activityDetails[$index].noOfUnits}}</span>
													</div>
												<td>
													<div align="center">
														<span>{{satcomActivityObjectState.activityDetails[$index].unitCost}}</span>
													</div>
												</td>
												<td>
													<div align="center">
														<span>{{satcomActivityObjectState.activityDetails[$index].funds}}</span>
													</div>
												<!-- <td data-ng-if="userType != 'S'">
													<div
														data-ng-show="satcomActivityObjectMOPR.activityDetails[$index].isApproved"
														align="center">
														<i class="fa fa-check" aria-hidden="true"
															style="color: #00cc00"></i>
													</div>
													<div
														data-ng-show="!satcomActivityObjectMOPR.activityDetails[$index].isApproved"
														align="center">
														<i class="fa fa-times" aria-hidden="true"
															style="color: red"></i>
													</div>
												</td> -->
												<td data-ng-if="userType != 'S'">
													<div align="center">
														<span>{{satcomActivityObjectState.activityDetails[$index].remarks}}</span>
													</div>
											</tr>

											<tr>
												<th colspan="4"><label><spring:message code="Label.TotalFund" htmlEscape="true" /></label></th>

												<td>
													<div align="center">
														<span>{{totalWithoutAddRequirementsForState}}</span>
													</div>
											</tr>

											<tr>
												<th colspan="4"><label><spring:message code="Label.AdditionalRequirement" htmlEscape="true" /></label></th>

												<td>
													<div align="center">
														<span>{{satcomActivityObjectState.additionalRequirement}}</span>
													</div>
												</td>

											</tr>

											<tr>
												<th colspan="4"><label><spring:message code="Label.TotalProposedFund" htmlEscape="true" /></label></th>

												<td>
													<div align="center">
														<span>{{grandTotalForState}}</span>
													</div>
											</tr>

										</tbody>

									</table>
									<div class="col-md-4">
										<button type="button"
											onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
											class="btn bg-orange waves-effect">
											<i class="fa fa-arrow-left" aria-hidden="true"></i>
											<spring:message code="Label.BACK" htmlEscape="true" />
										</button>
									</div>
									
									<div class="col-md-8 text-right">
										<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">
											<spring:message code="Label.CLOSE" htmlEscape="true" /></button>
									</div>
								</div>
								</div>
							</div>
							
						<!-- CEC section ends here -->	
							<div data-ng-if="userType == 'S' || userType == 'M'">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th rowspan="2">
													<div align="center">
														<strong><spring:message code="Label.NameOfActivity" htmlEscape="true" /></strong>
													</div>
												</th>
											<th rowspan="2">
													<div align="center">
														<strong><spring:message code="Label.PanchayatLevel" htmlEscape="true" /></strong>
													</div>
												</th>
											<th rowspan="2">
													<div align="center">
														<strong><spring:message code="Label.NoOfUnits" htmlEscape="true" /><br>A
														</strong>
													</div>
												</th>
											<th rowspan="2">
													<div align="center">
														<strong><spring:message code="Label.UnitCost" htmlEscape="true" /> (in Rs)<br>B
														</strong>
													</div>
												</th>
											<th rowspan="2">
													<div align="center">
														<strong><spring:message code="Label.FundProposed" htmlEscape="true" />  (in Rs)<br>C = A * B
														</strong>
													</div>
												</th>
											<th data-ng-if="userType != 'S'" rowspan="2"><div align="center"><strong><spring:message code="Label.isApproved" htmlEscape="true" /></strong></div></th>
											<th rowspan="2"><div align="center"><strong><spring:message code="Label.Remarks" htmlEscape="true" /></strong>
													</div></th>
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
										<tr data-ng-repeat="activity in activityList"
											data-ng-init="outerIndex=$index">
											<td>
												<div align="center">
													{{activity.satcomMasterName}} <input type="hidden"
														data-ng-model="satcomActivityObject.activityDetails[$index].satcomMaster.satcomMasterId"
														data-ng-init="satcomActivityObject.activityDetails[$index].satcomMaster.satcomMasterId=activity.satcomMasterId" />
												</div>
											</td>
											<td>
												<div align="center">
													<input type="hidden"
														data-ng-model="satcomActivityObject.activityDetails[$index].level.satcomLevelId" />

													<select data-ng-disabled="satcomActivityObject.status == 'F'"
														data-ng-model="satcomActivityObject.activityDetails[outerIndex].level.satcomLevelId"
														data-convert-to-number class="form-control col-sm-1">
														<!-- <option value="0"> Please Select </option> -->
														<option data-ng-repeat="level in satComLevel"
															value="{{level.satcomLevelId}}">{{level.satcomLevelName}}</option>
													</select>
												</div>
											</td>
											<td><input type="text" maxlength="6"
												data-ng-show="satcomActivityObject.status != 'F'"
												data-restrict-input="{type: 'digitsOnly',index: $index}"
												data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)"
												data-ng-model="satcomActivityObject.activityDetails[$index].noOfUnits"
												class="form-control" style="text-align: right;" /> <input
												type="text" maxlength="6"
												data-ng-show="satcomActivityObject.status == 'F'"
												disabled="disabled"
												data-restrict-input="{type: 'digitsOnly',index: $index}"
												data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)"
												data-ng-model="satcomActivityObject.activityDetails[$index].noOfUnits"
												class="form-control" style="text-align: right;" /></td>
											<td><input type="text" maxlength="5"
												data-ng-show="satcomActivityObject.status != 'F'"
												data-restrict-input="{type: 'digitsOnly',index: $index}"
												data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)"
												data-ng-model="satcomActivityObject.activityDetails[$index].unitCost"
												class="form-control validate" style="text-align: right;" />
												<input type="text" maxlength="5"
												data-ng-show="satcomActivityObject.status == 'F'"
												disabled="disabled"
												data-restrict-input="{type: 'digitsOnly',index: $index}"
												data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)"
												data-ng-model="satcomActivityObject.activityDetails[$index].unitCost"
												class="form-control validate" style="text-align: right;" />
											</td>
											<td><input type="text"
												
												data-ng-model="satcomActivityObject.activityDetails[$index].funds"
												class="form-control" style="text-align: right;" disabled="disabled"/> </td>
											<!-- <td><textarea rows="2" ng-disabled="unFreeze" cols="10" ng-model="satcomActivityObject.activityDetails[$index].remarks"></textarea></td> -->

											<td data-ng-if="userType != 'S'"><input type="checkbox"
												data-ng-disabled="satcomActivityObject.status == 'F'"
												data-ng-model="satcomActivityObject.activityDetails[$index].isApproved" />
											</td>
											<td><input type="text"
												data-ng-disabled="satcomActivityObject.status == 'F'"
												data-ng-model="satcomActivityObject.activityDetails[$index].remarks"
												class="form-control" placeholder="Enter Remarks"
												style="text-align: right;" /></td>

										<c:if
											test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
											<td>
												<ol>
													<%-- <c:forEach items="${STATE_PRE_COMMENTS[index.index]}"
														varStatus="indexInner" var="stateComments"> --%>
														<li data-ng-repeat="stateComments in statePreComments[outerIndex] track by $index" style="color: #396721; font-weight: bold;">
																<div data-ng-if = "stateComments != '' && stateComments != null && stateComments != undefined">{{stateComments}}</div>
																<div data-ng-if = "stateComments === '' && stateComments === null && stateComments === undefined">{{stateComments}}</div>
																<%-- <c:choose>
																	<c:when test="${not empty stateComments}">${stateComments}</c:when>
																	<c:otherwise>No comments by state</c:otherwise>
																</c:choose> --%>
															</li>
														<br>
													<%-- </c:forEach> --%>
												</ol>
											</td>

											<td>
												<ol>
													<%-- <c:forEach items="${MOPR_PRE_COMMENTS[index.index]}"
														varStatus="indexMopr" var="moprComments"> --%>
														<li data-ng-repeat="moprComments in moprPreComments[outerIndex] track by $index" style="color: #bc6317; font-weight: bold;">
														<div data-ng-if = "moprComments != '' && moprComments != null && moprComments != undefined">{{moprComments}}</div>
																<div data-ng-if = "moprComments === '' && moprComments === null && moprComments === undefined">{{moprComments}}</div>
																
														
														<%-- <c:choose>
																<c:when test="${not empty moprComments}">${moprComments}</c:when>
																<c:otherwise>No comments by MOPR</c:otherwise>
															</c:choose> --%></li>
														<br>
													<%-- </c:forEach> --%>
												</ol>
											</td>
										</c:if>
									</tr>
										<tr>
											<th colspan="4"><label><spring:message code="Label.TotalFund" htmlEscape="true" /></label></th>

											<td><input type="text" data-ng-disabled="true"
												data-ng-model="totalWithoutAddRequirements"
												class="form-control"
												style="background: #dddddd; text-align: right;" /></td>
										</tr>

										<tr>
											<th colspan="4"><label><spring:message code="Label.AdditionalRequirement" htmlEscape="true" /></label></th>

											<td><input type="text"
												data-ng-show="satcomActivityObject.status == 'F'"
												data-restrict-input="{type: 'digitsOnly',index: $index}"
												maxlength="6" data-ng-keyUp="calculateGrandTotal()"
												class="form-control"
												data-ng-model="satcomActivityObject.additionalRequirement"
												placeholder="25% of Total Cost " style="text-align: right;"
												disabled="disabled" /> <input type="text"
												data-ng-show="satcomActivityObject.status != 'F'"
												data-restrict-input="{type: 'digitsOnly',index: $index}"
												maxlength="6" data-ng-keyUp="calculateGrandTotal()"
												class="form-control"
												data-ng-model="satcomActivityObject.additionalRequirement"
												placeholder="25% of Total Cost " style="text-align: right;" />
											</td>

										</tr>

										<tr>
											<th colspan="4"><label><spring:message code="Label.TotalProposedFund" htmlEscape="true" /></label></th>

											<td><input data-ng-disabled="true"
												style="background: #dddddd; text-align: right;" type="text"
												data-ng-model="grandTotal" class="form-control"
												placeholder="Total proposed fund" /></td>

										</tr>
									</tbody>

								</table>
								<div class="col-md-4  text-left" data-ng-show="userType !='S'" style="margin-bottom: 5px">
								&nbsp;&nbsp;<button type="button"
									onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
									class="btn bg-orange waves-effect">
									<i class="fa fa-arrow-left" aria-hidden="true"></i>
									<spring:message code="Label.BACK" htmlEscape="true" />
								</button><br>
							</div>
							<div class="text-right">
							 <c:if test="${Plan_Status eq true}"> 
								<%-- <button ng-if="save" type="button" ng-click="saveData('S')" class="btn bg-green waves-effect">SAVE</button>
							<button ng-if="freeze" type="button" ng-click="saveData('F')" class="btn bg-green waves-effect"><spring:message code="Label.FREEZE" htmlEscape="true" /></button>
							<button ng-if="unFreeze" type="button" ng-click="saveData('S')" class="btn bg-green waves-effect"><spring:message code="Label.UNFREEZE" htmlEscape="true" /></button>
							<button type="button" ng-if="clear" ng-click="claerAll()" class="btn bg-light-blue waves-effect">CLEAR</button>
							<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"class="btn bg-orange waves-effect">CLOSE</button> --%>
								<button data-ng-show="satcomActivityObject.status == 'F'"
									data-ng-click="saveData('S')" type="button"
									class="btn bg-green waves-effect" disabled="disabled">
									<spring:message code="Label.SAVE" htmlEscape="true" />
								</button>
								<button type="button"
									data-ng-show="satcomActivityObject.status != 'F'"
									data-ng-click="saveData('S')" data-ng-disabled="disable_save" class="btn bg-green waves-effect">
									<spring:message code="Label.SAVE" htmlEscape="true" />
								</button>
								<button data-ng-show=" satcomActivityObject.status != undefined && satcomActivityObject.status != 'F' "
									data-ng-click="saveData('F')" type="button"
									class="btn bg-orange waves-effect">
									<spring:message code="Label.FREEZE" htmlEscape="true" />
								</button>
								<button data-ng-show="satcomActivityObject.status == 'F'"
									type="button" data-ng-click="saveData('UF')"
									class="btn bg-orange waves-effect">
									<spring:message code="Label.UNFREEZE" htmlEscape="true" />
								</button>
							<%-- 	<button type="button"
									data-ng-show="satcomActivityObject.status == 'F'"
									class="btn bg-light-blue waves-effect" disabled="disabled">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</button>
								<button type="button" data-ng-click="claerAll()"
									data-ng-show="satcomActivityObject.status != 'F'"
									class="btn bg-light-blue waves-effect">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</button> --%>
								</c:if>
								<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-red waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
</html>