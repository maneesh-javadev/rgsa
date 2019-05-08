<html data-ng-app="panchayatBhawanApp">
<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/angular/ui-bootstrap-tpls-0.11.0.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/panchayatBhawan/panchayatBhawanActivityController.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/panchayatBhawan/panchayatBhawanActivityService.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/panchayatBhawan/panchayatController.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<link rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
  <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<script>

function calculateGrandTotal(){
	var grand_total=0;
	if(document.getElementById("additionalRequirementId").value > 0.25 *document.getElementById("fund").value){
		alert("Additional Requirement should be less than or equal to 25% of Total Fund");
		document.getElementById("additionalRequirementId").value = '';
		document.getElementById("grandTotalId").value = '';
	}else{
		document.getElementById("grandTotalId").value = +document.getElementById("additionalRequirementId").value + +document.getElementById("fund").value;
	}
} 

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

function calculate(obj)
{
	document.getElementById("funds_"+obj).value = 2000 * document.getElementById("unitCost_"+obj).value;
	/* document.getElementById("totalFund_"+obj).value = document.getElementById("fund_"+obj).value; */
	/* calculateTotal(obj) */
}

function calculateTotal(obj){
	var total=0;
	for(var i=0;i<=obj;i++){
		total += +$("#totalFund_"+i).val();
	}
	document.getElementById("total").value =total;
	calculateGrandTotal();
}
</script>
<section class="content"
	data-ng-controller="panchayatBhawanActivityCntrl">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Label.PanchayatBhawanHeader"
								htmlEscape="true" />
							(CEC)
						</h2>
					</div>
					
					<form>
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
					<div role="tabpanel" class="container tab-pane active" id="state" style="width: auto;">
					
					<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.NewBuilding" htmlEscape="true" />
                           </div>
                           <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                              <thead>
                                 <%-- <tr><th colspn="4" ><spring:message code="Label.NewBuilding" htmlEscape="true" /></th></tr> --%>
                                 <tr>
                                    <%-- <th>
                                       <div align="center">
                                       	<strong><spring:message code="Label.WorkType"
                                       	htmlEscape="true" /></strong>
                                       </div>
                                       </th> --%>
                                    <th>
                                       <div align="center">
                                          <strong>
                                             <spring:message code="Label.Activities"
                                                htmlEscape="true" />
                                          </strong>
                                       </div>
                                    </th>
                                    <!-- <th>
                                       <div align="center">
                                       	<strong>District</strong><br>
                                       </div>
                                       </th> -->
                                    <th>
                                       <div align="center">
                                          <strong>
                                             <spring:message code="Label.NoOfGPs"
                                                htmlEscape="true" />
                                          </strong>
                                          <br> A
                                       </div>
                                    </th>
                                    <th>
                                       <div align="center">
                                          <strong>
                                             <spring:message
                                                code="Label.AspirationalGpsSelected" htmlEscape="true" />
                                             selected
                                          </strong>
                                       </div>
                                    </th>
                                    <th>
                                       <div align="center">
                                          <strong>
                                             <spring:message code="Label.UnitCost"
                                                htmlEscape="true" />
                                             (in Rs) 
                                          </strong>
                                          <br> B
                                       </div>
                                    </th>
                                    <th>
                                       <div align="center">
                                          <strong>
                                             <spring:message code="Label.Funds"
                                                htmlEscape="true" />
                                          </strong>
                                          <br> C = A * B
                                       </div>
                                    </th>
                                    
                                 </tr>
                              </thead>
                              <tbody>
                                 <tr ng-repeat="activity in activityList" ng-if="[1, 2,3].indexOf(activity.activityId) > -1">
                                   
                                    		<td><strong>{{activity.activityName}}</strong> <input
													type="hidden"
													data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].activity.activityId"
													data-ng-init="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].activity.activityId=activity.activityId" />
												</td>
												<td>
												<div align="center"
														data-ng-style="{'color':(panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].noOfGPs > panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].noOfGPs) ? 'red' : '#00cc00'}">
														<strong>{{panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].noOfGPs}}</strong>
												</div> 
														 <input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status == 'F'" data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].noOfGPs"  style="text-align:right;" disabled="disabled">
														<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status != 'F'" data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].noOfGPs"  onkeypress="return isNumber(event)" data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index);calculateAspirationalGps($index)" maxlength="7" style="text-align:right;"> 
												</td>
												<td>
												<div align="center"
														data-ng-style="{'color':(panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].aspirationalGps > panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].aspirationalGps) ? 'red' : '#00cc00'}">
														<strong>{{panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].aspirationalGps}}</strong>
												</div> 
												<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status == 'F'" data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].aspirationalGps" style="text-align:right;" disabled="disabled"/>
														<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status != 'F'" onkeypress="return isNumber(event)" data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].aspirationalGps" data-ng-keyup="calculateAspirationalGps($index)" maxlength="7" style="text-align:right;"/>	
												</td>

												<td>
													<div align="center"
														data-ng-style="{'color':(panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].unitCost > panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].unitCost) ? 'red' : '#00cc00'}">
														<strong>{{panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].unitCost}}</strong>
													</div> <input type="text" class="form-control"
													data-ng-show="panchayatBhawanActivity.status != 'F'"
													onkeypress="return isNumber(event)"
													data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].unitCost"
													data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)"
													maxlength="7" style="text-align: right;" /> <input
													type="text" class="form-control"
													data-ng-show="panchayatBhawanActivity.status == 'F'"
													data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].unitCost"
													style="text-align: right;" disabled="disabled" />
												</td>
												<td>
													<div align="center"
														data-ng-style="{'color':(panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].funds > panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].funds) ? 'red' : '#00cc00'}">
														<strong>{{panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].funds}}</strong>
													</div> <input type="text" class="form-control" data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].funds"
													style="text-align: right;" disabled="disabled"/> 
												</td>
                                 </tr>
                              </tbody>
                              <tfoot>
                                 <tr>
                                    <th colspan="4">
                                       <spring:message code="Label.TotalCost"
                                          htmlEscape="true" />
                                    </th>
                                    <td>
                                    <div align="center" data-ng-style="{'color':(totalState > totalWithoutAddRequirements) ? 'red' : '#00cc00'}">
										<strong>{{totalState}}</strong>
									</div>
                                    <input type="text"  id = "totalFonds" data-ng-model="totalWithoutAddRequirements" class="form-control col-sm-1"  style="text-align:right;" data-ng-disabled = "true"/>														
                                 </tr>
                                 <tr>
                                    <th colspan="4">
                                       <spring:message
                                          code="Label.AdditionalRequirement" htmlEscape="true" />
                                    </th>
                                    <td>
                                    <div align="center"
														data-ng-style="{'color':(panchayatBhawanActivityState.additionalRequirement > panchayatBhawanActivity.additionalRequirement) ? 'red' : '#00cc00'}">
														<strong>{{panchayatBhawanActivityState.additionalRequirement}}</strong>
													</div> 
                                       <input type="text" ng-model="panchayatBhawanActivity.additionalRequirement" onkeypress="return isNumber(event)" data-ng-show="panchayatBhawanActivity.status != 'F'" data-ng-keyUp="calculateGrandTotal()" class="form-control col-sm-1" placeholder="25% of total" style="text-align:right;"/>
                                       <input type="text" ng-model="panchayatBhawanActivity.additionalRequirement" data-ng-show="panchayatBhawanActivity.status == 'F'" class="form-control col-sm-1" placeholder="25% of total" style="text-align:right;" disabled="disabled"/>
                                    </td>
                                 </tr>
                              </tfoot>
                           </table>
                        </div>
                     </div>
                     <div class="records">
                        <div  class="col-lg-12 sub_head">
                           <spring:message code="Label.CarryForward" htmlEscape="true" />
                        </div>
                        <div class="">
                           <table id="trainingActivityTblId" class="table table-hover dashboard-task-infos">
                              <thead>
                                 <%-- 	<tr><th colspn="4"  class="xyz"><spring:message code="Label.CarryForward" htmlEscape="true" /></th>	<tr> --%>
                                 <th>
                                    <div align="center">
                                       <strong>
                                          <spring:message code="Label.Activities"
                                             htmlEscape="true" />
                                       </strong>
                                    </div>
                                 </th>
                                 <th>
                                    <div align="center">
                                       <strong>
                                          <spring:message code="Label.fund.sanction"
                                             htmlEscape="true" />
                                       </strong>
                                    </div>
                                 </th>
                                 <th>
                                    <div align="center">
                                       <strong>
                                          <spring:message code="Label.fund.release"
                                             htmlEscape="true" />
                                       </strong>
                                       <br> A
                                    </div>
                                 </th>
                                 <th>
                                    <div align="center">
                                       <strong>
                                          <spring:message code="Label.fund.utilize"
                                             htmlEscape="true" />
                                       </strong>
                                       <br> B
                                    </div>
                                 </th>
                                 <th>
                                    <div align="center">
                                       <strong>
                                          <spring:message code="Label.fund.required"
                                             htmlEscape="true" />
                                       </strong>
                                       <br>C=A-B
                                    </div>
                                 </th>
                                 </tr>
                              </thead>
                              <tbody>
                                 <tr ng-repeat="activity in activityList" ng-if="[4,5,6].indexOf(activity.activityId) > -1">
                                    <td><strong>{{activity.activityName}}</strong> <input
													type="hidden"
													data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].activity.activityId"
													data-ng-init="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].activity.activityId=activity.activityId" />
												</td>
												<td>
												<div align="center"
														data-ng-style="{'color':(panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].noOfGPs > panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].noOfGPs) ? 'red' : '#00cc00'}">
														<strong>{{panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].noOfGPs}}</strong>
												</div> 
														 <input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status == 'F'" data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].noOfGPs"  style="text-align:right;" disabled="disabled">
														<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status != 'F'" data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].noOfGPs"  onkeypress="return isNumber(event)" data-ng-change="calculateFundRequired($index,'SAN')"" maxlength="7" style="text-align:right;"> 
												</td>
												<td>
												<div align="center"
														data-ng-style="{'color':(panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].aspirationalGps > panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].aspirationalGps) ? 'red' : '#00cc00'}">
														<strong>{{panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].aspirationalGps}}</strong>
												</div> 
												<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status == 'F'" data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].aspirationalGps" style="text-align:right;" disabled="disabled"/>
														<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status != 'F'" onkeypress="return isNumber(event)" data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].aspirationalGps" data-ng-change="calculateFundRequired($index,'REL')" maxlength="7" style="text-align:right;"/>	
												</td>

												<td>
													<div align="center"
														data-ng-style="{'color':(panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].unitCost > panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].unitCost) ? 'red' : '#00cc00'}">
														<strong>{{panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].unitCost}}</strong>
													</div> <input type="text" class="form-control"
													data-ng-show="panchayatBhawanActivity.status != 'F'"
													onkeypress="return isNumber(event)"
													data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].unitCost"
													data-ng-change="calculateFundRequired($index,'UTI')"
													maxlength="7" style="text-align: right;" /> <input
													type="text" class="form-control"
													data-ng-show="panchayatBhawanActivity.status == 'F'"
													data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].unitCost"
													style="text-align: right;" disabled="disabled" />
												</td>
												<td>
													<div align="center"
														data-ng-style="{'color':(panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].funds > panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].funds) ? 'red' : '#00cc00'}">
														<strong>{{panchayatBhawanActivityState.panchatayBhawanActivityDetails[$index].funds}}</strong>
													</div>
													 <input type="text" class="form-control" data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].funds"
														style="text-align: right;" disabled="disabled"/>
												</td>
                                 </tr>
                              </tbody>
                              <tfoot>
                                 <tr>
                                    <th colspan="4">
                                       <spring:message code="Label.TotalCost"
                                          htmlEscape="true" />
                                    </th>
                                    <td>
                                     <div align="center" data-ng-style="{'color':(totalState > totalWithoutAddRequirements) ? 'red' : '#00cc00'}">
										<strong>{{totalOfFundsReqState}}</strong>
									</div>
                                    <input type="text"  id = "totalFonds" data-ng-model="totalFundReq" class="form-control col-sm-1"  style="text-align:right;" data-ng-disabled = "true"/>														
                                 </tr>
                              </tfoot>
                           </table>
                        </div>
                     </div>
                     <div class="records">
                        <div class="">
                           <table id="trainingActivityTblId"	class="table table-hover dashboard-task-infos">
                              <tr>
                              
                                 <th colspan="4" width="81%">Total Proposed Fund  =(Total Cost of New Building+Additional Requirement of New Building+Total Cost of Carry Forward)</th>
                                 <th>
                                 <div align="center" data-ng-style="{'color':((totalState + panchayatBhawanActivityState.additionalRequirement) > totalproposedFonds) ? 'red' : '#00cc00'}">
														<strong>{{totalState +
															panchayatBhawanActivityState.additionalRequirement+totalOfFundsReqState}}</strong>
								</div> 
                                 <input type="text"  id = "totalproposedFonds" data-ng-model="grandTotal" class="form-control col-sm-1"  style="text-align:right;" data-ng-disabled = "true"/></th>														
                              </tr>
                           </table>
                        </div>
                     </div>
             
                     
					<div class="row clearfix">
								<div class="col-md-4 text-left">
											&nbsp;<button type="button"
												onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
												class="btn bg-orange waves-effect">
												<i class="fa fa-arrow-left" aria-hidden="true"></i>
												<spring:message code="Label.BACK" htmlEscape="true" />
											</button>
										</div>
										
									   	<div class="col-md-8 text-right ex1">
 									   	    <button data-ng-show="panchayatBhawanActivity.status == 'F'" data-ng-click="saveData('S')" type="button" class="btn bg-green waves-effect" disabled="disabled"><spring:message code="Label.SAVE" htmlEscape="true"/></button> 
									   		<button type="button" data-ng-show="panchayatBhawanActivity.status != 'F'"  ng-disabled="btn_disabled" ng-click="saveData('S')" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
									   		<button data-ng-show="panchayatBhawanActivity.status != 'F' " data-ng-click="saveData('F')" type="button" class="btn bg-green waves-effect" data-ng-disabled="initial_status == true"><spring:message code="Label.FREEZE" htmlEscape="true" /></button>
								       <button data-ng-show="panchayatBhawanActivity.status == 'F'" type="button" data-ng-click="saveData('UF')"  ng-disabled="btn_disabled"  class="btn bg-green waves-effect">
									      <spring:message code="Label.UNFREEZE" htmlEscape="true" />
								       </button>
			 						   		<button type="button" data-ng-show="panchayatBhawanActivity.status == 'F'"  class="btn bg-light-blue waves-effect" disabled="disabled">
									   			<spring:message code="Label.CLEAR" htmlEscape="true" />
									   		</button>
									   		<button type="button" data-ng-show="panchayatBhawanActivity.status != 'F'"  class="btn bg-light-blue waves-effect" data-ng-click="claerAll()">
									   			<spring:message code="Label.CLEAR" htmlEscape="true" />
									   		</button>
											<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect">
												<spring:message code="Label.CLOSE" htmlEscape="true" />
											</button>
										</div>
								</div>
					
					</div>
					
					<div class="container tab-pane fade" id="MOPR" style="width: auto;">
					
							<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.NewBuilding" htmlEscape="true" />
                           </div>
                           <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                              <thead>
                                 <%-- <tr><th colspn="4" ><spring:message code="Label.NewBuilding" htmlEscape="true" /></th></tr> --%>
                                 <tr>
                                    <%-- <th>
                                       <div align="center">
                                       	<strong><spring:message code="Label.WorkType"
                                       	htmlEscape="true" /></strong>
                                       </div>
                                       </th> --%>
                                    <th>
                                       <div align="center">
                                          <strong>
                                             <spring:message code="Label.Activities"
                                                htmlEscape="true" />
                                          </strong>
                                       </div>
                                    </th>
                                    <!-- <th>
                                       <div align="center">
                                       	<strong>District</strong><br>
                                       </div>
                                       </th> -->
                                    <th>
                                       <div align="center">
                                          <strong>
                                             <spring:message code="Label.NoOfGPs"
                                                htmlEscape="true" />
                                          </strong>
                                          <br> A
                                       </div>
                                    </th>
                                    <th>
                                       <div align="center">
                                          <strong>
                                             <spring:message
                                                code="Label.AspirationalGpsSelected" htmlEscape="true" />
                                             selected
                                          </strong>
                                       </div>
                                    </th>
                                    <th>
                                       <div align="center">
                                          <strong>
                                             <spring:message code="Label.UnitCost"
                                                htmlEscape="true" />
                                             (in Rs) 
                                          </strong>
                                          <br> B
                                       </div>
                                    </th>
                                    <th>
                                       <div align="center">
                                          <strong>
                                             <spring:message code="Label.Funds"
                                                htmlEscape="true" />
                                          </strong>
                                          <br> C = A * B
                                       </div>
                                    </th>
                                    
                                 </tr>
                              </thead>
                              <tbody>
                                 <tr ng-repeat="activity in activityList" ng-if="[1, 2,3].indexOf(activity.activityId) > -1">
                                   
                                    		<td><div align="center">{{activity.activityName}}</div></td>
												<td><div align="center">{{panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].noOfGPs}}</div></td>
												<td><div align="center">{{panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].aspirationalGps}}</div></td>
												<td><div align="center">{{panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].unitCost}}</div></td>
												<td><div align="center">{{panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].funds}}</div></td>
                                 </tr>
                              </tbody>
                              <tfoot>
                                 <tr>
                                    <th colspan="4">
                                       <spring:message code="Label.TotalCost"
                                          htmlEscape="true" />
                                    </th>
                                    <td align="center">
                                    <div>
										<strong>{{totalMOPR}}</strong>
									</div>
                                    </tr>
                                 <tr>
                                    <th colspan="4">
                                       <spring:message
                                          code="Label.AdditionalRequirement" htmlEscape="true" />
                                    </th>
                                    <td>
                                    <div align="center">
														<strong>{{panchayatBhawanActivityMOPR.additionalRequirement}}</strong>
									</div> 
                                      
                                    </td>
                                 </tr>
                              </tfoot>
                           </table>
                        </div>
                     </div>
                     <div class="records">
                        <div  class="col-lg-12 sub_head">
                           <spring:message code="Label.CarryForward" htmlEscape="true" />
                        </div>
                        <div class="">
                           <table id="trainingActivityTblId" class="table table-hover dashboard-task-infos">
                              <thead>
                                 <%-- 	<tr><th colspn="4"  class="xyz"><spring:message code="Label.CarryForward" htmlEscape="true" /></th>	<tr> --%>
                                 <th>
                                    <div align="center">
                                       <strong>
                                          <spring:message code="Label.Activities"
                                             htmlEscape="true" />
                                       </strong>
                                    </div>
                                 </th>
                                 <th>
                                    <div align="center">
                                       <strong>
                                          <spring:message code="Label.fund.sanction"
                                             htmlEscape="true" />
                                       </strong>
                                    </div>
                                 </th>
                                 <th>
                                    <div align="center">
                                       <strong>
                                          <spring:message code="Label.fund.release"
                                             htmlEscape="true" />
                                       </strong>
                                       <br> A
                                    </div>
                                 </th>
                                 <th>
                                    <div align="center">
                                       <strong>
                                          <spring:message code="Label.fund.utilize"
                                             htmlEscape="true" />
                                       </strong>
                                       <br> B
                                    </div>
                                 </th>
                                 <th>
                                    <div align="center">
                                       <strong>
                                          <spring:message code="Label.fund.required"
                                             htmlEscape="true" />
                                       </strong>
                                       <br>C=A-B
                                    </div>
                                 </th>
                                 </tr>
                              </thead>
                              <tbody>
                                 <tr ng-repeat="activity in activityList" ng-if="[4,5,6].indexOf(activity.activityId) > -1">
                                  
                                   
                                    		<td><div align="center">{{activity.activityName}}</div></td>
												<td><div align="center">{{panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].noOfGPs}}</div></td>
												<td><div align="center">{{panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].aspirationalGps}}</div></td>
												<td><div align="center">{{panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].unitCost}}</div></td>
												<td><div align="center">{{panchayatBhawanActivityMOPR.panchatayBhawanActivityDetails[$index].funds}}</div></td>
                                
                                 </tr>
                              </tbody>
                              <tfoot>
                                 <tr>
                                    <th colspan="4" align="center">
                                       <spring:message code="Label.TotalCost"
                                          htmlEscape="true" />
                                    </th>
                                    <td align="center">
                                     <div >
										<strong>{{totalOfFundsReqMOPR}}</strong>
									</div>
                                     </tr>
                              </tfoot>
                           </table>
                        </div>
                     </div>
                     <div class="records">
                        <div class="">
                           <table id="trainingActivityTblId"	class="table table-hover dashboard-task-infos">
                              <tr>
                                 <th colspan="4" width="81%" align="center">Total Proposed Fund  =(Total Cost of New Building+Additional Requirement of New Building+Total Cost of Carry Forward)</th>
                                 <th style="text-align: right;padding-right:80px">{{totalMOPR+totalOfFundsReqMOPR+panchayatBhawanActivityMOPR.additionalRequirement}}</th>														
                              </tr>
                           </table>
                        </div>
                     </div>
                    
                     
					</div>
					
					
					</div>
				 </div>
				
					
					
					</form>
					
					
					
					
					
					
				</div>
			</div>
		</div>
	</div>
</section>
</html>
