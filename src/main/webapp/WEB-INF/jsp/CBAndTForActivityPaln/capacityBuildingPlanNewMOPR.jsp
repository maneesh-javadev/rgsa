<%@include file="../taglib/taglib.jsp"%>
<html ng-app="publicModule">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/dataTables/css/dataTables.bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/jquery.dataTables.js"></script>
	
<script
	src="<c:out value='${pageContext.request.contextPath}'/>/resources/plugins/bootstrap/js/bootstrap.min.js"></script>

	<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/plugins/angular/ui-bootstrap-tpls-0.11.0.js"></script>
	
	 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/trainingDetails/trainingDetailMoprController.js"></script>
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
		 ,"bPaginate":false
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
</style>
<section class="content" ng-controller="trainingDetailMoprController">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Training Details(MOPR)" htmlEscape="true" />
						</h2>
					</div>
					<form>
							
								
								
							
						
							
							<div class="records">
								<div class="">
									<table id="trainingActivityTblId"
										class="table table-hover dashboard-task-infos">
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
												<th width="4%" align="center"><spring:message text="Is Approved" htmlEscape="true" /></th>
												<th width="10%" align="center"><spring:message text="Remarks" htmlEscape="true" /></th>
											</tr>
										</thead>
										<tbody>
										<tr data-ng-repeat="obj in training.trainingDetailList">
										<td>{{$index+1}}</td>
										<td>{{obj.trainingCategoryName}} </td>
										<td>{{obj.subjectName}} </td>
										<td>{{obj.targetGroupMasterName}} </td>
										<td>{{obj.trainingVenueLevelName}} </td>
										<td>{{obj.trainingModeName}} </td>
										<td align="right"><input type="text" data-ng-disabled="fetchTrainingMOPR.isFreeze" data-ng-change="calculateFund('P',$index)" data-ng-model="training.trainingDetailList[$index].noOfParticipants" onkeypress="return isNumber(event)" required="required"  class="form-control element-width" maxlength="5" style="text-align:right;"> </td>
										<td align="right"><input type="text" data-ng-disabled="fetchTrainingMOPR.isFreeze" data-ng-change="calculateFund('D',$index)" data-ng-model="training.trainingDetailList[$index].noOfDays" onkeypress="return isNumber(event)" required="required"  class="form-control element-width" maxlength="5" style="text-align:right;"> </td>
										<td align="right"><input type="text" data-ng-disabled="fetchTrainingMOPR.isFreeze" data-ng-change="calculateFund('U',$index)" data-ng-model="training.trainingDetailList[$index].unitCost" onkeypress="return isNumber(event)" required="required"  class="form-control element-width" maxlength="5" style="text-align:right;"> </td>
										<td align="right"><input type="text" data-ng-disabled="fetchTrainingMOPR.isFreeze"readonly="readonly" data-ng-model="training.trainingDetailList[$index].funds" required="required"  class="form-control element-width" style="text-align:right;"> </td>
										<td align="center">
											  <input type="checkbox" data-ng-disabled="fetchTrainingMOPR.isFreeze" data-ng-model="training.trainingDetailList[$index].isApproved"  />
										</td>
										<td align="center">
											 <textarea cols="40" data-ng-disabled="fetchTrainingMOPR.isFreeze" data-ng-model="training.trainingDetailList[$index].remarks" rows="2" class="element-width">{{trainingDetails.remarks}}</textarea>
										</td>
										</tr>
										</tbody>
									</table>
								</div>
							</div>
							<br>
								<div class="row clearfix padding_right" >
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
								<div class="row clearfix padding_right">
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
								<div class="row clearfix padding_right">
									<div class="col-sm-6">
									</div>
									<div class="col-sm-2">
										<label>Additional Requirements</label>
									</div>
									<div class="col-sm-4">
										
										  <input type="text" data-ng-disabled="fetchTrainingMOPR.isFreeze" data-ng-change="calculateMasterFund()" data-ng-model="training.additionalRequirement" onkeypress="return isNumber(event)" required="required"  class="form-control" maxlength="5" style="text-align:right;">
									
									</div>
								</div>
								<div class="row clearfix padding_right">
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
								<div class="text-right padding_right">
									 
									<button type="button" ng-show="!fetchTrainingMOPR.isFreeze" ng-click="saveTrainingDetails('S')"
										class="btn bg-green waves-effect">SAVE</button>
										
									<button type="button" ng-show="!fetchTrainingMOPR.isFreeze" ng-click="saveTrainingDetails('F')"
										class="btn bg-green waves-effect">FREEZE</button>
										
										<button type="button" ng-show="fetchTrainingMOPR.isFreeze"  ng-click="saveTrainingDetails('U')"
										class="btn bg-green waves-effect">UNFREEZE</button>
										
									<button ng-click="resetLoading()" type="button"   class="btn bg-light-blue waves-effect"  >
									   			<spring:message code="Label.CLEAR" htmlEscape="true" />
									   		</button>
								
									<button type="button"
										onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-orange waves-effect">CLOSE</button><br />
								</div>
								<br/>

							
							
							
						
						
						
						
					
						
					
					</form>
				</div>
			</div>
		</div>
	</div>
</section>

</html>