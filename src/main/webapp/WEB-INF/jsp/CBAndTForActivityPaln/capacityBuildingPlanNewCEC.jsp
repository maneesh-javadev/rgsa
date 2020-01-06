<%@include file="../taglib/taglib.jsp"%>
<html ng-app="publicModule">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/dataTables/css/dataTables.bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/jquery.dataTables.js"></script>
	
<script
	src="<c:out value='${pageContext.request.contextPath}'/>/resources/plugins/bootstrap/js/bootstrap.min.js"></script>

	<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/plugins/angular/ui-bootstrap-tpls-0.11.0.js"></script>
	
	 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/trainingDetails/trainingDetailCECController.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/trainingDetails/trainingDetailService.js"></script>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
	
<script>
$('document').ready(function(){
	$('#trainingActivityTblId').dataTable({
		 "bInfo" : false,
		 "lengthChange": false,
		 bFilter: false,
		 "bSort": false,
		 "bPaginate":false
	});	
});



function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
</script>
<style>
.element_style{
border-color: black !important;
border: solid !important;
 border-width: thin !important;
}


.first-col {
    padding-left:50px;
}

.right-btn {
    padding-right:50px;
}

.element-width{
width: 90%;
}

.element_right{
text-align: right;
}
table.dataTable thead > tr > th, table.dataTable thead > tr > td {
     padding-right: 0px !important; 
}
</style>
<section class="content" ng-controller="trainingDetailMoprController">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Training Details(CEC)" htmlEscape="true" />
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
							<div role="tabpanel" class="container tab-pane active " id="MOPR"
								style="width: auto;">
								<div class="table-responsive">

									<table class="table table-hover dashboard-task-infos"
										id="mytable">

										<thead>
											<tr>
												<th width="3%"><spring:message code="Sr. No." htmlEscape="true" /></th>
												<th width="12%"> <spring:message code="Training Category"
														htmlEscape="true" /></th>
												<th width="12%"><spring:message code="Training Subjects"
														htmlEscape="true" /></th>
												<th width="12%"><spring:message code="Training Target Group"
														htmlEscape="true" /></th>
												<th width="8%"><spring:message code="Venue Level"
														htmlEscape="true" /></th>
												<th width="7%"><spring:message text="Mode Of Training"
														htmlEscape="true" /></th>
												<th width="8%" class="element_right"><spring:message code="No. of Participants"
														htmlEscape="true" /></th>
												<th width="8%" class="element_right"><spring:message code="No.of Days" htmlEscape="true" /></th>
												<th width="8%" class="element_right"><spring:message code="Unit Cost" htmlEscape="true" /></th>
												<th width="8%" class="element_right"><spring:message code="Funds Proposed" htmlEscape="true"/></th>
												
											<%-- <th width="4%" align="center"><spring:message text="Is Approved" htmlEscape="true" /></th> --%>
												<th width="10%" align="center"><spring:message text="Remarks" htmlEscape="true" /></th>
											</tr>
										</thead>
										<tbody>
										
										<tr data-ng-repeat="obj in fetchTrainingDetailsListMOPR">
										<td 
											data-ng-model="training.trainingDetailList[$index].preLevelTrainActivityId"
											data-ng-init="training.trainingDetailList[$index].preLevelTrainActivityId=fetchTrainingDetailsListState[$index].trainingId"
										>{{$index+1}}</td>
										<td >{{obj.trainingCategoryName}} </td>
										<td>{{obj.subjectName}} </td>
										<td>{{obj.targetGroupMasterName}} </td>
										<td>{{obj.trainingVenueLevelName}} </td>
										<td>{{obj.trainingModeName}} </td>
										
										<td align="right">
													
													<div align="center"
														data-ng-style="{'color':(fetchTrainingDetailsListMOPR[$index].noOfParticipants > training.trainingDetailList[$index].noOfParticipants) ? 'red' : '#00cc00'}">
														<strong> 
															{{fetchTrainingDetailsListMOPR[$index].noOfParticipants}}
														</strong>
													</div>
													<input type="text" class="form-control element_style"	data-ng-disabled="training.isFreeze" data-ng-change="calculateFund('P',$index);" 
													onkeypress="return isNumber(event)"	data-ng-model="training.trainingDetailList[$index].noOfParticipants"
													maxlength="7" style="text-align: right; border: none; border-color: transparent;" />
										</td>
										
										<td align="right">
													
													<div align="center"
														data-ng-style="{'color':(fetchTrainingDetailsListMOPR[$index].noOfDays > training.trainingDetailList[$index].noOfDays) ? 'red' : '#00cc00'}">
														<strong> 
															{{fetchTrainingDetailsListMOPR[$index].noOfDays}}
														</strong>
													</div>
													<input type="text" class="form-control element_style"	data-ng-disabled="training.isFreeze" data-ng-change="calculateFund('D',$index)" 
													onkeypress="return isNumber(event)"	data-ng-model="training.trainingDetailList[$index].noOfDays"
													maxlength="7" style="text-align: right; border: none; border-color: transparent;" />
										</td>
										
										<td align="right">
													
													<div align="center"
														data-ng-style="{'color':(fetchTrainingDetailsListMOPR[$index].unitCost > training.trainingDetailList[$index].unitCost) ? 'red' : '#00cc00'}">
														<strong> 
															{{fetchTrainingDetailsListMOPR[$index].unitCost}}
														</strong>
													</div>
													<input type="text" class="form-control element_style"	data-ng-disabled="training.isFreeze" data-ng-change="calculateFund('U',$index)" 
													onkeypress="return isNumber(event)"	data-ng-model="training.trainingDetailList[$index].unitCost"
													maxlength="7" style="text-align: right; border: none; border-color: transparent;" />
										</td>
										
										<td align="right">
													
													<div align="center"
														data-ng-style="{'color':(fetchTrainingDetailsListMOPR[$index].funds > training.trainingDetailList[$index].funds) ? 'red' : '#00cc00'}">
														<strong> 
															{{fetchTrainingDetailsListMOPR[$index].funds}}
														</strong>
													</div>
													<input type="text" class="form-control element_style"	data-ng-disabled="training.isFreeze" 
													data-ng-model="training.trainingDetailList[$index].funds" readonly="readonly" style="text-align: right; border: none; border-color: transparent;" />
										</td>
										
										
										<!-- <td align="center">
											  <input type="checkbox" data-ng-disabled="training.isFreeze" data-ng-model="training.trainingDetailList[$index].isApproved"  />
										</td>
										<td align="center">
											 <textarea cols="40" data-ng-disabled="training.isFreeze" data-ng-model="training.trainingDetailList[$index].remarks" rows="2" class="element-width">{{trainingDetails.remarks}}</textarea>
										</td> -->
									<!-- 	<td>
													<div align="center"
														data-ng-if="obj.isApproved">
														<i class="fa fa-check" aria-hidden="true"
															style="color: #00cc00"></i>
													</div>
													<div align="center"
														data-ng-if="!obj.isApproved">
														<i class="fa fa-times" aria-hidden="true"
															style="color: red"></i>
													</div>
												</td> -->
												<td><div align="center">
												       <!--  <strong> 
															
														</strong> -->
														<button class="addMore btn bg-green waves-effect" title="{{fetchTrainingDetailsListMOPR[$index].remarks}}">Remark By Mopr</button>
												<input type="text" class="form-control element_style"	data-ng-disabled="training.isFreeze"
													data-ng-model="training.trainingDetailList[$index].remarks" style="text-align: right; border: none; border-color: transparent;" /></div></td>
										</tr>
										

											
										</tbody>
										
									</table>
								</div>
								
									<br>
									
								<div class="row clearfix " >
									<div class="col-sm-6">
									</div>
									<div class="col-sm-2">
										<label>Total No. of Participants</label>
									</div>
									<div class="col-sm-4">
										<div align="center"
											data-ng-style="{'color':(allNoOfParticipantsMOPR> allNoOfParticipants) ? 'red' : '#00cc00'}">
											<strong> 
												{{allNoOfParticipantsMOPR}}
											</strong>
										</div>
										<input type="text" class="form-control" id="subTotal"
											value="{{allNoOfParticipants}}" readonly="readonly"
											style="text-align: right;">
									</div>
								</div>	
							
								<div class="row clearfix">
									<div class="col-sm-6">
									</div>
									<div class="col-sm-2">
										<label>Total Funds</label>
									</div>
									<div class="col-sm-4">
										<div align="center"
											data-ng-style="{'color':(allTrainingFundMOPR> allTrainingFund) ? 'red' : '#00cc00'}">
											<strong> 
												{{allTrainingFundMOPR}}
											</strong>
										</div>
										<input type="text" class="form-control" id="subTotal"
											value="{{allTrainingFund}}" readonly="readonly"
											style="text-align: right;">
									</div>
								</div>
								<div class="row clearfix">
									<div class="col-sm-6">
									</div>
									<div class="col-sm-2">
										<label>Additional Requirements</label>
									</div>
									<div class="col-sm-4">
										<div align="center"
														data-ng-style="{'color':(fetchTrainingMOPR.additionalRequirement > training.additionalRequirement) ? 'red' : '#00cc00'}">
														<strong> 
															{{fetchTrainingMOPR.additionalRequirement}}
														</strong>
										</div>
										  <input type="text" data-ng-disabled="training.isFreeze" data-ng-change="calculateMasterFund()" data-ng-model="training.additionalRequirement" onkeypress="return isNumber(event)" required="required"  class="form-control" maxlength="9" style="text-align:right;">
									
									</div>
								</div>
								<div class="row clearfix">
									<div class="col-sm-6">
									</div>
									<div class="col-sm-2">
										<label> Total Proposed Fund</label>
									</div>
									<div class="col-sm-4">
										<div align="center"
											data-ng-style="{'color':(masterFundsMOPR> masterFunds) ? 'red' : '#00cc00'}">
											<strong> 
												{{masterFundsMOPR}}
											</strong>
										</div>
										<input type="text" class="form-control" 
											value="{{masterFunds}}"
											readonly="readonly" style="text-align: right;">
									</div>
								</div>
								<br/>
								<br/>
								<div class="col-md-12 text-right">
								
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
									 
									<button type="button" ng-show="!training.isFreeze" ng-disabled="capacityBuilding.isFreeze||btn_disabled" ng-click="saveTrainingDetails('S')"
										class="btn bg-green waves-effect">SAVE</button>
										
									<button type="button" ng-show="!training.isFreeze" ng-disabled="capacityBuilding.isFreeze||btn_disabled" ng-click="saveTrainingDetails('F')"
										class="btn bg-green waves-effect">FREEZE</button>
										
										<button type="button" ng-show="training.isFreeze" ng-disabled="capacityBuilding.isFreeze||btn_disabled" ng-click="saveTrainingDetails('U')"
										class="btn bg-green waves-effect">UNFREEZE</button>
										
									<!-- <button type="button" id="clearButtn" onclick="onClear(this)"
										class="btn bg-light-blue waves-effect">CLEAR</button> -->
								
									<button type="button"
										onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-orange waves-effect">CLOSE</button><br />
								</div>
								
							</div>
							<div role="tabpanel" class="container tab-pane" id="state"
								style="width: auto;">
								<div class="table-responsive">
									<table class="table table-hover dashboard-task-infos"
										id="mytable">

										<thead>
											<tr>
												<th width="3%"><spring:message code="Sr. No." htmlEscape="true" /></th>
												<th width="12%"> <spring:message code="Training Category"
														htmlEscape="true" /></th>
												<th width="12%"><spring:message code="Training Subjects"
														htmlEscape="true" /></th>
												<th width="12%"><spring:message code="Training Target Group"
														htmlEscape="true" /></th>
												<th width="8%"><spring:message code="Venue Level"
														htmlEscape="true" /></th>
												<th width="7%"><spring:message text="Mode Of Training"
														htmlEscape="true" /></th>
												<th width="8%" class="element_right"><spring:message code="No. of Participants"
														htmlEscape="true" /></th>
												<th width="8%" class="element_right"><spring:message code="No.of Days" htmlEscape="true" /></th>
												<th width="8%" class="element_right"><spring:message code="Unit Cost" htmlEscape="true" /></th>
												<th width="8%" class="element_right"><spring:message code="Funds Proposed" htmlEscape="true"/></th>
												<th width="10%" align="center"><spring:message text="Remarks By state" htmlEscape="true" /></th>
											</tr>
										</thead>

										<tbody>
											<tr data-ng-repeat="obj in fetchTrainingDetailsListState">
													<td>{{$index+1}}</td>
													<td>{{obj.trainingCategoryName}} </td>
													<td>{{obj.subjectName}} </td>
													<td>{{obj.targetGroupMasterName}} </td>
													<td>{{obj.trainingVenueLevelName}} </td>
													<td>{{obj.trainingModeName}} </td>
													<td>{{obj.noOfParticipants}} </td>
													<td>{{obj.noOfDays}} </td>
													<td>{{obj.unitCost}} </td>
													<td>{{obj.funds}} </td>
													<td>{{obj.remarks}} </td>
												
											</tr>
											
										</tbody>
									</table>
									</div>	
									<br>
									
									<div class="row clearfix " >
									<div class="col-sm-6">
									</div>
									<div class="col-sm-2">
										<label>Total No. of Participants</label>
									</div>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="subTotal"
											value="{{allNoOfParticipantsState}}" readonly="readonly"
											style="text-align: right;">
									</div>
								</div>
							
								<div class="row clearfix">
									<div class="col-sm-6">
									</div>
									<div class="col-sm-2">
										<label>Total Funds</label>
									</div>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="subTotal"
											value=" {{allTrainingFundState}}" readonly="readonly"
											style="text-align: right;">
									</div>
								</div>
								<div class="row clearfix">
									<div class="col-sm-6">
									</div>
									<div class="col-sm-2">
										<label>Additional Requirements</label>
									</div>
									<div class="col-sm-4">
										
										  <input type="text" readonly="readonly" data-ng-model="fetchTrainingState.additionalRequirement"  class="form-control" style="text-align:right;">
									
									</div>
								</div>
									<div class="row clearfix">
									<div class="col-sm-6">
									</div>
									<div class="col-sm-2">
										<label> Total Proposed Fund</label>
									</div>
									<div class="col-sm-4">
										<input type="text" class="form-control" 
											value="{{masterFundsState}}"
											readonly="readonly" style="text-align: right;">
									</div>
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
						
						

							
							
							
						
						
						
						
					
						
					
					</form>
				</div>
			</div>
		</div>
	</div>
</section>

</html>