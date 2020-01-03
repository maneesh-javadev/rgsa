<%@include file="../taglib/taglib.jsp"%>
<%@include file="../progressReport/trainingDetailsProgressReportJs.jsp"%>
 
<style>
.padding_left_local {
   padding-left: 85px !important;
 }
.Align-Right{
			text-align: right;
}
.Alert{
	color: red;
}
</style>
<input type="hidden"  id="listData" value="${test}" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
	<section class="content">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Training Details Progress Report</h2>
						</div>
						
						<form:form method="POST" name="quarterTrainings" action="savetrainingProgressReport.html"
						modelAttribute="QPR_TRAINING_DETAILS" enctype="multipart/form-data" >
						<input type="hidden" name="<csrf:token-name/>"value="<csrf:token-value uri="savetrainingProgressReport.html" />" />
						<spring:bind path="QPR_TRAINING_DETAILS.qprTrainingsId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" id="qprActivityId" /> 
						</spring:bind>
						<spring:bind path="QPR_TRAINING_DETAILS.trainingActivityId" >
										<input type="hidden" name="${status.expression}" value="${fetchTrainingCEC.trainingActivityId}" /> 
						</spring:bind>
						
						<%-- <span class="errormsg show" ><c:out value='${isError}' /></span> --%>
						
						
						<div class="row" >
							<div class="form-group">
							<!-- <div class="col-lg-2" align="left"></div> -->
								<label for="QuaterDuration" class="col-sm-2" style="margin-left: 15px;"><spring:message code="Label.QuaterDuration" htmlEscape="true" />  :</label>
								<div class="col-lg-3">
									
									<select id="qtrId" class="form-control" name="qtrId" onchange="get_quater_wise_data()" required="required">
										<option value="0">Select Quarter Duration</option>
										
										<c:forEach items="${quarterDuration}" var="duration">
											<option value="${duration.qtrId}" >${duration.qtrDuration}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>	 
									
					 
						<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head Alert">
                             (Balance Amount:${subcomponentwiseQuaterBalanceList[0].balanceAmount})
                           </div>
                           
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                           
                           
                           <table id="trainingActivityTblId" class="table table-hover dashboard-task-infos">
                             <thead>
								<tr>
									
									<th  align="left">
											<strong>Training Category</strong>
									</th>
									<th align="left" >
											<strong>Training Subjects</strong>
									</th>
									
								<!-- 	<th align="left" colspan="4">
											<strong>Training Target Group</strong>
									</th> -->
									
									<th align="left">
											<strong>Venue Level</strong>
									</th>
									
									<th align="left" >
											<strong>Total Participants</strong>
									</th>
									
									<th align="left">
											<strong>Approved Amount</strong>
									</th>
									
									<th align="left" >
											<strong>Total Participants trained</strong>
									</th>
									
									<th align="left">
											<strong>Expenditure Incurred</strong>
									</th>
									<th>
										<strong>file</strong>
										
									</th>
								</tr>
							 </thead>
							 
							 
                              <c:forEach items="${fetchTrainingDetailsListCEC}" var="obj" varStatus="count">
                       			<tr>
								<td align="left">
										<strong>${obj.trainingCategoryName}</strong>
										<spring:bind path="QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[${count.index}].qprTrainingsDetailsId">
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[${count.index}].trainingActivityDetailsId">
										<input type="hidden" name="${status.expression}" value="${fetchTrainingDetailsListCEC[count.index].trainingId}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[${count.index}].fileNode.fileNodeId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
								
 							 				
								</td>
								<td align="left"><strong>${obj.subjectName}</strong></td>
								<%-- <td colspan="4"><form:select class="form-control" path="">
									<form:option value="">Please Select</form:option>
									<c:forEach items="${TARGET_GROUP_MASTER}" var="master">
										<form:option value="${master.targetGroupMasterId}">${master.targetGroupMasterName}</form:option>
									</c:forEach>
								</form:select></td> --%>
								<td align="left"><strong>${obj.trainingVenueLevelName}</strong></td>
								<td align="left" id="noOfParticipants_${count.index}"><strong>${obj.noOfParticipants}</strong></td>
								<td align="left"><strong>${obj.funds}</strong></td>
								<td><input type="text" class="form-control Align-Right" id="totalParticipantsId_${count.index}" disabled="disabled" value="${QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[count.index].totalParticipantsEnter}">
									<button type="button" class="btn btn-lg btn-success" style="margin-top: 5px;" onclick="openModel(${count.index},${QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[count.index].qprTrainingsDetailsId});" data-toggle="modal">Fill Details</button>	
								</td>
								<td align="left">
								
										 <spring:bind path="QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[${count.index}].expenditureIncurred" >
										 
										 <c:choose>
										 <c:when test="${status.value== null}">
										 <form:input id="expenditureIncurred_${count.index}" onkeypress="return isNumber(event)"  path="${status.expression}"  class="form-control"  value="0" 
											maxlength="8" style="text-align:right;" required="required" autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[0].balanceAmount}',this)" readonly="${QPR_TRAINING_DETAILS.isFreeze}"/>
										 </c:when>
										 <c:otherwise>
										 <form:input id="expenditureIncurred_${count.index}" onkeypress="return isNumber(event)"  path="${status.expression}"  class="form-control"  value="${status.value}" 
											maxlength="8" style="text-align:right;" required="required" autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[0].balanceAmount}',this)" readonly="${QPR_TRAINING_DETAILS.isFreeze}"/>
										
										 
										 </c:otherwise>
										 </c:choose>
											</spring:bind>	
										<span class="errormsg" id="error_expenditureIncurred_${count.index}"></span>
								
										
									</td>
									<td align="left">
									<spring:bind path="QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[${count.index}].file" >
									 <c:choose>
									 	<c:when test="${QPR_TRAINING_DETAILS.isFreeze}"><input type="file" id="file"  name="${status.expression}" disabled="disabled"/></c:when>
									 	<c:otherwise><input type="file" id="file"  name="${status.expression}"/></c:otherwise>
									 </c:choose>
									 <br/>
									 	<c:if test="${QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[count.index].fileNode.fileNodeId!=null }">
											<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[count.index].fileNode.fileNodeId}" target="_blank">
												<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
											</a>
										</c:if>
									</spring:bind>
									
									
									
									</td>
								</tr>
								 
								</c:forEach>
                           		<tr>
                          
									<td colspan="6">
										<strong>
											<spring:message code="Label.SubTotal" htmlEscape="true" />
										</strong>
									</td>
									<td>
										<input type="text" class="form-control" id="subtotal" disabled="disabled" style="text-align:right;"/>
										
									</td>
								</tr>
								<tr>
									<td colspan="6">
										<strong>
											<spring:message code="Label.AdditionalRequirement" htmlEscape="true" /> <span class="Alert"> (Balance Additional Requirement:${balAddiReq})</span>
											
										</strong>
									</td>
									<td>
										<spring:bind path="QPR_TRAINING_DETAILS.additionalRequirement" >
										<form:input onkeypress="return isNumber(event)" id="addReq" class="form-control" path="${status.expression}"  value="${status.value}" onblur="calculcate_total(null,'expenditureIncurred')"  maxlength="8" style="text-align:right;" autocomplete="off" readonly="${QPR_TRAINING_DETAILS.isFreeze}"/>
										</spring:bind>
										<span class="errormsg" id="error_addReq"></span>
									</td>
								</tr>
								<tr>
									<td colspan="6">
										<strong>
											<spring:message code="Label.TotalProposedFund" htmlEscape="true" /> 
										</strong>
									</td>
									<td>
										<input type="text" id="total" class="form-control"  style="text-align:right;" readonly="readonly"/>
									</td>
								</tr>
                              </tbody>
                           </table>
                           <input type="hidden" name="msg" value="" id="msgId" />
                           <input type="hidden" name="detailsListsIndex" value="" id="detailsListsIndexId" />
                           <div id="BifurcationModal" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
									<div class="modal-dialog modal-lg">

										<!-- Modal content-->
										<div class="modal-content">
											<div class="modal-header" style="background-color: #481890; color: white;">
												<div class="row">
												<h4 class="col-md-6">Participants Details</h4>
												<div id="parentId" style="display: none;"></div>
												<button type="button" class="close col-md-6" onclick="confirmClose()" style="opacity: 1; color: white; text-align: right;margin-top: 12px;">&times;</button></div>
											</div>
											<div class="modal-body">
												<div class="table-responsive">
													<table class="table table-hover table-bordered table-striped">
														<thead style="background-color: #b39ad8;color: #2f2b2bf2;display: table;width: 100%;">
															<tr>
																<th rowspan="2" style="width: 2%"><div align="center">S.No</div></th>
																<th rowspan="2" style="width: 16%"><div align="center">Target Group</div></th>
																<th colspan="2"><div align="center">SC</div></th>
																<th colspan="2"><div align="center">ST</div></th>
																<th colspan="2"><div align="center">Other</div></th>
															</tr>
															<tr>
																<th><div align="center">Male</div></th>
																<th><div align="center">Female</div></th>
																<th><div align="center">Male</div></th>
																<th><div align="center">Female</div></th>
																<th><div align="center">Male</div></th>
																<th><div align="center">Female</div></th>
															</tr>
														</thead>
														<tbody style="display: block;overflow-x: auto;height: 500px;" id="tbodyId">
															
														</tbody>
													</table>
												</div>												
											</div>
											<div class="modal-footer">
												<button type="button" onclick="save_data('modalSave')" class="btn btn-success">Save</button>
												<button type="button" onclick="confirmClose()" class="btn btn-danger">Close</button>
											</div>
										</div>

									</div>
								</div>
                           <br/>
                           <br/>
                           
                           
                        </div>
                     </div>
                     <div class="form-group text-right">
						<c:if test="${installementExist}">
							<button onclick="save_data('mainSsave')" type="button"
								class="btn bg-green waves-effect">
								<spring:message code="Label.SAVE" htmlEscape="true" />
							</button>
							<c:choose>
								<c:when test="${QPR_TRAINING_DETAILS.isFreeze}">
									<form:button class="btn bg-orange waves-effect"
										onclick="FreezeAndUnfreeze('unfreeze')">UNFREEZE</form:button>
								</c:when>
								<c:otherwise>
									<form:button class="btn bg-orange waves-effect"
										disabled="${DISABLE_FREEZE}"
										onclick="FreezeAndUnfreeze('freeze')">FREEZE</form:button>
								</c:otherwise>
							</c:choose>
							<button type="button"
								data-ng-show="!institutionalInfraActivityPlan.isFreeze"
								data-ng-click="load_data()"
								class="btn bg-light-blue waves-effect">
								<spring:message code="Label.CLEAR" htmlEscape="true" />
							</button>
						</c:if>
						<button type="button"
							onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
							class="btn bg-red waves-effect">
							<spring:message code="Label.CLOSE" htmlEscape="true" />
						</button>
						<br /> <br />
					</div>
					</form:form>
				</div>
						</div>
					</div>
				</div>
	</section>
	
	<script type="text/javascript">
var masterList = '${test}';
 

function openModel(index , detailId){
	 $('#BifurcationModal').modal('show');
	 $('#detailsListsIndexId').val(index);
	 
	 (detailId == undefined || detailId == '') ? detailId = 0 : detailId = detailId;
	 voteViaAjax(detailId,index);
}

function voteViaAjax(detailId,index) {
	 var flag = ('${QPR_TRAINING_DETAILS.isFreeze}' === 'true') ? true : false;
	 
	$.ajax({
    type : "POST",
    contentType : "application/json",
    url : "trainingBreakUpData.html?<csrf:token uri='trainingBreakUpData.html'/>&detailId="+detailId,
   // url : "fetchTrainingBreakUpData.html?<csrf:token uri='fetchTrainingBreakUpData.html'/>&detailId="+detailId, 
    dataType : 'json',
    cache : false,
    timeout : 100000,
    success : function(data) {

        var listItems = JSON.parse(masterList);
    	 var count=0;
//alert(data.breakUpData.length);
        if(data.breakUpData.length>0){
    	 var tableBuilder;
    	 for(let key in listItems){
    		 tableBuilder += "<tr>";
    		 tableBuilder +="<th align='center' style='width: 6%'>"+(count + 1)+"</th>"; 
    		 tableBuilder += "<th align='center' style='width: 139px;'>"+listItems[key]+"</th>";
    		 if(data.breakUpData[count].scMales != null){
    			tableBuilder +=" <td style='width: 97px;'><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].scMales' onkeypress='return isNumber(event)' class='form-control Align-Right' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' value='"+data.breakUpData[count].scMales+"' id='scMale_"+count+"' /></td>"; 
    		 }else{
    			tableBuilder +=" <td style='width: 97px;'><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].scMales' onkeypress='return isNumber(event)' class='form-control Align-Right' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' id='scMale_"+count+"' /></td>";
    		 }
    		 if(data.breakUpData[count].scFemales != null){
    			tableBuilder +="<td style='width: 123px;' ><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].scFemales' onkeypress='return isNumber(event)' class='form-control Align-Right' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' value='"+data.breakUpData[count].scFemales+"' id='scFemale_"+count+"' /></td>"; 
     		 }else{
     			tableBuilder +=" <td style='width: 97px;' ><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].scFemales' onkeypress='return isNumber(event)' class='form-control Align-Right' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' id='scFemale_"+count+"' /></td>";
     		 }
    		if(data.breakUpData[count].stMales != null){
    			tableBuilder +="<td style='width: 97px;'><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].stMales' onkeypress='return isNumber(event)' class='form-control Align-Right' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' value='"+data.breakUpData[count].stMales+"' id='stMale_"+count+"' /></td>"; 
     		 }else{
     			tableBuilder +=" <td style='width: 97px;'><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].stMales' onkeypress='return isNumber(event)' class='form-control Align-Right' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' id='stMale_"+count+"' /></td>";
     		 }
    		if(data.breakUpData[count].stFemales != null){
    			 tableBuilder +="<td style='width: 123px;'><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].stFemales' onkeypress='return isNumber(event)' class='form-control Align-Right' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' value='"+data.breakUpData[count].stFemales+"' id='stFemale_"+count+"' /></td>"; 
     		 }else{
     			tableBuilder +=" <td style='width: 97px;'><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].stFemales' onkeypress='return isNumber(event)' class='form-control Align-Right' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' id='stFemale_"+count+"' /></td>";
     		 }
    		if(data.breakUpData[count].othersMales != null){
    			tableBuilder +="<td style='width: 97px;'><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].othersMales' onkeypress='return isNumber(event)' class='form-control Align-Right' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' value='"+data.breakUpData[count].othersMales+"' id='othersMale_"+count+"' /></td>"; 
    		 }else{
    			tableBuilder +=" <td style='width: 97px;'><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].othersMales' onkeypress='return isNumber(event)' class='form-control Align-Right' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' id='othersMale_"+count+"' /></td>";
    		 }
    		if(data.breakUpData[count].othersFemales != null){
    			tableBuilder +="<td><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].othersFemales' class='form-control Align-Right' onkeypress='return isNumber(event)' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' value='"+data.breakUpData[count].othersFemales+"' id='othersFemale_"+count+"' /></td>"; 
    		 }else{
    			tableBuilder +=" <td><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].othersFemales' class='form-control Align-Right' onkeypress='return isNumber(event)' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' id='othersFemale_"+count+"' /></td>";
    		 }
    		 tableBuilder +="<input type='hidden' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].targetGroupMasterId' value='"+key+"' />";
   			 tableBuilder +="<input type='hidden' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].quarterTrainingsDetails.qprTrainingsDetailsId' value='"+detailId+"' />";
   		 	 tableBuilder +="<input type='hidden' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].qprTrainingBreakupId' value='"+data.breakUpData[count].qprTrainingBreakupId+"' />";
    		 tableBuilder +="</tr>";
    		 
    		 count++;
    	 }
    	 
        }else{
          	  var tableBuilder;
          	  for(let key in listItems){
          		 tableBuilder += "<tr>";
          		 tableBuilder +="<th align='center' style='width: 6%'>"+(count + 1)+"</th>"; 
          		 tableBuilder += "<th align='center' style='width: 139px;'>"+listItems[key]+"</th>";
          		 tableBuilder +=" <td style='width: 97px;'><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].scMales' class='form-control Align-Right' onkeypress='return isNumber(event)' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' id='scMale_"+count+"' /></td>";
          		 tableBuilder +="<td style='width: 123px;'><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].scFemales' class='form-control Align-Right' onkeypress='return isNumber(event)' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' id='scFemale_"+count+"' /></td>";
          		 tableBuilder +="<td style='width: 97px;'><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].stMales' class='form-control Align-Right' onkeypress='return isNumber(event)' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' id='stMale_"+count+"' /></td>";
          		 tableBuilder +="<td style='width: 123px;'><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].stFemales' class='form-control Align-Right' onkeypress='return isNumber(event)' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' id='stFemale_"+count+"' /></td>";
          		 tableBuilder +="<td style='width: 97px;'><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].othersMales' class='form-control Align-Right' onkeypress='return isNumber(event)' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' id='othersMale_"+count+"' /></td>";
          		 tableBuilder +="<td><input type='text' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].othersFemales' class='form-control Align-Right' onkeypress='return isNumber(event)' onkeyup='getTotalNoOfParticipants("+index+","+count+",this.id)' id='othersFemale_"+count+"' /></td>";
          		 tableBuilder +="<input type='hidden' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].targetGroupMasterId' value='"+key+"' />";
       			 tableBuilder +="<input type='hidden' name='quarterTrainingsDetailsList["+index+"].qprTrainingBreakup["+count+"].quarterTrainingsDetails.qprTrainingsDetailsId' value='"+detailId+"' />";
          		 tableBuilder +="</tr>";
          		 count++;
          	 }
        }
        $('#tbodyId').html(tableBuilder); 
    },
    error : function(e) {
     console.log(e);
    }
   });
}

 
 
function confirmClose(){
	var detailIndex = $('#detailsListsIndexId').val();
	var flag = confirm('If you close the window without saving then the data get lost.Still you want to continue?')
	flag ? $('#BifurcationModal').modal('hide') : $('#BifurcationModal').modal('show');
	$('#totalParticipantsId_'+detailIndex).val(+calTotalParticipantsFilled());
}

function getTotalNoOfParticipants(detailIndex,modalIndex,idMsg){
	var totalParticipantsFilled = calTotalParticipantsFilled();
	var mainNoOfParticipants = +$('#noOfParticipants_'+detailIndex).text();
	if(totalParticipantsFilled > mainNoOfParticipants){
		totalParticipantsFilled -= +$('#'+idMsg).val();
		$('#'+idMsg).val('');
		alert('Total participants should not exceed : '+ mainNoOfParticipants);
		$('#'+idMsg).focus();
	}
	$('#totalParticipantsId_'+detailIndex).val(totalParticipantsFilled);
}

function calTotalParticipantsFilled(){
	var rowCount = $('#tbodyId tr').length;
	var totalParticipantsFilled=0;
	for(var i=0;i<rowCount;i++){
		totalParticipantsFilled += +$('#scMale_'+i).val() + +$('#scFemale_'+i).val() + +$('#stMale_'+i).val() + +$('#stFemale_'+i).val() + +$('#othersMale_'+i).val() + +$('#othersFemale_'+i).val();
	}
	
	return totalParticipantsFilled;
}

function FreezeAndUnfreeze(msg){
	var componentId=1;
	var qprActivityId=$('#qprActivityId').val();
	var quaterId = $('#qtrId').val();
	document.quarterTrainings.method = "post";
	document.quarterTrainings.action = "freezeAndUnfreezeReport.html?<csrf:token uri='freezeAndUnfreezeReport.html'/>&componentId="+componentId+"&qprActivityId="+qprActivityId+"&quaterId="+quaterId+"&msg="+msg;
	document.quarterTrainings.submit();
}

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}


</script>