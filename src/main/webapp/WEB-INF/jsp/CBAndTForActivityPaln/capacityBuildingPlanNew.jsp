<%@include file="../taglib/taglib.jsp"%>
<html ng-app="publicModule">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/dataTables/css/dataTables.bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/jquery.dataTables.js"></script>
	
<script
	src="<c:out value='${pageContext.request.contextPath}'/>/resources/plugins/bootstrap/js/bootstrap.min.js"></script>

	<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/plugins/angular/ui-bootstrap-tpls-0.11.0.js"></script>
	
	 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/trainingDetails/trainingDetailController.js"></script>
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
		 "bPaginate":false,
		 ,"oLanguage": {"sZeroRecords": "", "sEmptyTable": ""}
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

.ex {
	margin-right: 0px;
    margin-bottom: 10px;
}
</style>
<section class="content" ng-controller="trainingDetailController">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Training Details" htmlEscape="true" />
						</h2>
					</div>
					<form>
							
								
								<div ng-show="isbtnAddTraining" class="form-group text-right" >
									<button ng-click="toAddNew()" ng-disabled="training.isFreeze" class="btn bg-green waves-effect"  style="margin-right: 10px; margin-top: 5px;">ADD TRAININGS</button>
									
									
								</div>
							
						<div ng-show="isShowRecodVisible">
							
							<div class="records">
								<div class="table-responsive">
									<table id="trainingActivityTblId"
										class="table table-hover dashboard-task-infos">
										<thead>
											<tr>
												<th width="5%" rowspan="2"><spring:message code="Sr. No." htmlEscape="true" /></th>
												<th width="15%" rowspan="2"> <spring:message code="Training Category"
														htmlEscape="true" /></th>
												<th width="15%" rowspan="2"><spring:message code="Training Subjects"
														htmlEscape="true" /></th>
												<th width="15%" rowspan="2"><spring:message code="Training Target Group"
														htmlEscape="true" /></th>
												<th width="10%" rowspan="2"><spring:message code="Venue Level"
														htmlEscape="true" /></th>
												<th width="10%" rowspan="2"><spring:message text="Mode Of Training"
														htmlEscape="true" /></th>
												<th width="5%" class="element_right" rowspan="2"><spring:message code="No. of Participants"
														htmlEscape="true" /></th>
												<th width="5%" class="element_right" rowspan="2"><spring:message code="No.of Days" htmlEscape="true" /></th>
												<th width="5%" class="element_right" rowspan="2"><spring:message code="Unit Cost" htmlEscape="true" /></th>
												<th width="5%" class="element_right" rowspan="2"><spring:message code="Funds Proposed" htmlEscape="true"/></th>
												<th width="5%" class="element_right" rowspan="2"><spring:message code="Remarks" htmlEscape="true"/></th>
												<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
													<th colspan="2" rowspan="1">
														<div align="center">
														<strong>Previous comment history</strong>
													</div>
													</th>
												</c:if>
												<th width="5%" align="center" rowspan="2"><spring:message code="Modify" htmlEscape="true" /></th>
												<th width="5%" align="center" rowspan="2"><spring:message code="Delete" htmlEscape="true" /></th>
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
										<tr data-ng-repeat="obj in training.trainingDetailList" data-ng-init="outerIndex = $index">
										<td>{{$index+1}}</td>
										<td>{{obj.trainingCategoryName}} </td>
										<td>{{obj.subjectName}} </td>
										<td>{{obj.targetGroupMasterName}} </td>
										<td>{{obj.trainingVenueLevelName}} </td>
										<td>{{obj.trainingModeName}} </td>
										<td align="right">{{obj.noOfParticipants}} </td>
										<td align="right">{{obj.noOfDays}} </td>
										<td align="right">{{obj.unitCost}} </td>
										<td align="right">{{obj.funds}} </td>
										<td align="right">{{obj.remarks}} </td>
										<c:if
											test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
											<td>
												<ol>
														<li data-ng-repeat="stateComments in statePreComments[outerIndex] track by $index" style="color: #396721; font-weight: bold;">
															{{stateComments}}
															</li><br>
												</ol>
											</td>

											<td>
												<ol>
													<li data-ng-repeat="moprComments in moprPreComments[outerIndex] track by $index" style="color: #bc6317; font-weight: bold;">
													{{moprComments}}</li><br>
												</ol>
											</td>
										</c:if>
										<td align="center">
											<a ng-click="toModify(obj.trainingId);" data-ng-show="training.isFreeze==false" >
												<span class="glyphicon glyphicon-edit"></span>
											</a> 
											<span class="glyphicon glyphicon-edit" ng-show="training.isFreeze" ></span>
										</td>
										<td align="center">
											<a ng-click="setDeleteTrainingIds(obj.trainingId);"  ng-show="training.isFreeze==false">
												<span  id="delete{{obj.trainingId}}" class="glyphicon glyphicon-trash"></span>
											</a> 
											<span class="glyphicon glyphicon-trash" ng-show="training.isFreeze"></span>
										</td>
										</tr>
										</tbody>
									</table>
								</div>
							</div>
							<br>
							
								<div class="row clearfix ex">
									<div class="col-sm-6">
									</div>
									<div class="col-sm-2">
										<label>Total No. of Participants</label>
									</div>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="subTotal"
											value="{{allNoOfParticipants}}" readonly="readonly"
											style="text-align: right;">
									</div>
								</div>
								<div class="row clearfix ex">
									<div class="col-sm-6">
									</div>
									<div class="col-sm-2">
										<label>Total Funds</label>
									</div>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="subTotal"
											value="{{allTrainingFund}}" readonly="readonly"
											style="text-align: right;">
									</div>
								</div>
								<div class="row clearfix ex">
									<div class="col-sm-6">
									</div>
									<div class="col-sm-2">
										<label>Additional Requirements</label>
									</div>
									<div class="col-sm-4">
										
										  <input type="text" ng-disabled="training.isFreeze" data-ng-change="calculateMasterFund()" data-ng-model="training.additionalRequirement" onkeypress="return isNumber(event)"   class="form-control" maxlength="9" style="text-align:right;">
									
									</div>
								</div>
								<div class="row clearfix ex">
									<div class="col-sm-6">
									</div>
									<div class="col-sm-2">
										<label> Total Proposed Fund</label>
									</div>
									<div class="col-sm-4">
										<input type="text" class="form-control" 
											value="{{masterFunds}}"
											readonly="readonly" style="text-align: right;">
									</div>
								</div>
								
								<br/>
								<br/>
								<div class="col-md-12 text-right">
								
								<span ng-show="planStateStatus">
								
								<button type="button" ng-show="training.isFreeze==false" ng-disabled="btn_disabled" ng-click="saveTrainingDetails('S')"
										class="btn bg-green waves-effect">SAVE</button>
										
									<button type="button" ng-show="training.isFreeze==false" ng-disabled="btn_disabled" ng-click="saveTrainingDetails('F')"
										class="btn bg-orange waves-effect">FREEZE</button>
										
										<button type="button" ng-show="training.isFreeze==true" ng-disabled="btn_disabled" ng-click="saveTrainingDetails('U')"
										class="btn bg-orange waves-effect">UNFREEZE</button>
								
								</span>
										
									<%-- <button ng-click="resetLoading()" type="button" ng-show="!training.isFreeze" class="btn bg-light-blue waves-effect"  >
									   			<spring:message code="Label.CLEAR" htmlEscape="true" />
									   		</button> --%>
								
									<button type="button"
										onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-red waves-effect">CLOSE</button><br />
								</div>

							
							</div>
							
						
						
						
						
					<br/><br/>
						<div ng-show="isModifyRecodVisible">
					
								<div class="row clearfix">
								 			
		                                    <div class="col-sm-2 first-col" data-ng-model="trainingDetails.trainingActivityId">
		                                        <label >Training Category</label>
		                                    </div>
		                                    
		                                    <div class="col-sm-4">
		                                        <div class="form-group" >
		                                        
		                                        		<select  multiple="multiple" class="element-width"  data-ng-model="trainingDetails.trgCategoryArr" ng-change="fetchSubjectListbyCategory(trainingDetails.trgCategoryArr)">
																<option ng-repeat="obj in trainingCatgryList" value={{obj.trainingCategoryId}}>
																	{{obj.trainingCategoryName}}
																</option>
														</select>
		                                        		
		                                               
		                                        </div>
		                                    </div>
		                                    <div class="col-sm-2">
		                                       <label >Target Group</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                        <div class="form-group">
				                    				<select   multiple="multiple" data-ng-model="trainingDetails.targetGrptArr" class="element-width" >
																<option ng-repeat="obj in targetGrpMstrList" value={{obj.targetGroupMasterId}}>
																	{{obj.targetGroupMasterName}}
																</option>
													</select>
													
		                                        </div>
		                                    </div>
		                                    <div class="col-sm-1">
								 			</div>
		                                </div>
		                                
		                                 <div class="row clearfix">
		                                    <div class="col-sm-2 first-col" >
		                                        <label >Training Subjects</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                        <div class="form-group">
		                                        	<select   multiple="multiple" data-ng-model="trainingDetails.trainingSubjectArr" class="element-width" >
																<option ng-repeat="obj in subjectsList" value={{obj.subjectId}}>
																	{{obj.subjectName}}
																</option>
													</select>
		                                        </div>
		                                    </div>
		                                    <div class="col-sm-2">
		                                         <label >Training Venue Level</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                        <div class="form-group">
		                                        	<select  data-ng-model="trainingDetails.trainingVenueLevelId" data-ng-change="calculateFund('V')" class="element-width"  style=" height:30px;" >
																<option ng-repeat="obj in trngVenueList" value={{obj.trainingVenueLevelId}}>
																	{{obj.trainingVenueLevelName}}
																</option>
													</select>
		                                        </div>
		                                    </div>
		                                </div>
		                                
		                                    <div class="row clearfix">
		                                    <div class="col-sm-2 first-col">
		                                        <label >No. of Participants</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                        <input type="text" data-ng-change="calculateFund('P')" data-ng-model="trainingDetails.noOfParticipants" onkeypress="return isNumber(event)"   class="form-control element-width" maxlength="5" style="text-align:right;">
		                                    </div>
		                                    <div class="col-sm-2">
		                                        <label >No. of Days Proposed</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                                 <input type="text" data-ng-change="calculateFund('D')" data-ng-model="trainingDetails.noOfDays" onkeypress="return isNumber(event)"   class="form-control element-width" maxlength="5" style="text-align:right;">
		                                    </div>
		                                </div>
		                                <br/>
		                                <div class="row clearfix">
		                                    <div class="col-sm-2 first-col">
		                                        <label >Unit Cost(In Rs.)</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                         <input type="text" data-ng-change="calculateFund('U')" data-ng-model="trainingDetails.unitCost" onkeypress="return isNumber(event)"   class="form-control element-width" maxlength="5" style="text-align:right;">
		                                    </div>
		                                    <div class="col-sm-2">
		                                        <label >Funds Proposed(In Rs.)</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                                <input type="text" readonly="readonly" data-ng-model="trainingDetails.funds" onkeypress="return isNumber(event)"   class="form-control element-width" maxlength="5" style="text-align:right;">
		                                    </div>
		                                </div>
		                                 <br/>
		                                
		                                <div class="row clearfix">
		                                    <div class="col-sm-2 first-col">
		                                        <label >Mode of Training </label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                        <div class="form-group">
		                                        	<select  data-ng-model="trainingDetails.trainingMode" class="element-width" style=" height:30px;">
																<option ng-repeat="obj in modeOfTraining" value={{obj.trainingModeId}}>
																	{{obj.trainingModeName}}
																</option>
													</select>
		                                        </div>
		                                    </div>
		                                    <div class="col-sm-2">
		                                        <label >Remarks</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                                <textarea cols="40" data-ng-model="trainingDetails.remarks" rows="2" class="element-width">{{trainingDetails.remarks}}</textarea>
		                                    </div>
		                                </div>
		                                <br/>
		                               <div class="row clearfix">
		                                <div class="col-md-12 text-right right-btn" >
		                                <button ng-click="updateTrainingDetails()" ng-disabled="btn_disabled" class="btn bg-green waves-effect">SAVE</button>
		                                <button ng-click="toShowRecord()" class="btn bg-red waves-effect">CLOSE</button>
		                                </div>
		                               </div>
		                               
		                               <br/>
		                    </div>
					
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
</html>