<%@include file="../taglib/taglib.jsp"%>
<script>
var quater_id = '${QTR_ID}';
var remaining_add_req = '${REMAINING_ADD_REQ}';
var qtr_1_2_filled='${QTR_ONE_TWO_FILLED}';
var fund_allocated_by_state='${FUND_ALLOCATED_BY_STATE}';
var fund_used='${FUND_USED_IN_OTHER_QUATOR}';
if(quater_id > 2){
	var fund_allocated_in_pre_qtr = '${FUND_ALLOCATED_BY_STATE_PREVIOUS}';
	var fund_used_in_qtr_1_and_2 = '${TOTAL_FUND_USED_IN_QTR_1_AND_2}';
}
$('document').ready(function(){
	if(qtr_1_2_filled == "false"){
		alert('Please fill the quater 1 and 2 progress report first.');
	}
	$('#quaterDropDownId').val(quater_id);
	showTablediv();
	calTotalExpenditure();
	$(".validate").keypress(function (e) {
	    //if the letter is not digit then display error and don't type anything
	    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	       //display error message
	       $("#errmsg").html("Digits Only").show().fadeOut("slow");
	              return false;
	   }
	  });
});

function showTablediv(){
	if($('#quaterDropDownId').val() > 0){
		$('#mainDivId').show();
	}else{
		$('#mainDivId').hide();
	}
}

function saveAndGetDataQtrRprt(msg){
	$('#quaterTransient').val($('#quaterDropDownId').val()); 
	 $('#origin').val(msg);
 	document.innovativeActivity.method = "post";
	document.innovativeActivity.action = "innovativeActivityQpr.html?<csrf:token uri='innovativeActivityQpr.html'/>";
	document.innovativeActivity.submit(); 
}

function validateFundByAllocatedFund(obj){
	var noOfRows=$("#tbodyId tr").length-1;
	var fund_allocated_by_state_local = +fund_allocated_by_state;
	var fund_used_local= +fund_used;
	var total=0;
	
	if(quater_id > 2){
		fund_allocated_by_state_local += +(fund_allocated_in_pre_qtr - fund_used_in_qtr_1_and_2);
	}
	if(fund_used !=0){
		fund_allocated_by_state_local -=  +fund_used_local;
	}
	for (var index = 0; index < noOfRows; index++) {
		total +=  +$('#expenditureIncurred_'+index).val();
	}
	if(total > fund_allocated_by_state_local){
		if(fund_used != 0){
			alert('Total expenditure should not exceed total remaining for this component which is Rs. '+ (fund_allocated_by_state_local - (total - $('#expenditureIncurred_'+obj).val())));
		}else{
			alert('Total expenditure should not exceed total fund allocted by state for this component which is Rs. '+ (fund_allocated_by_state_local - (total - $('#expenditureIncurred_'+obj).val())));
		}
		$('#expenditureIncurred_'+obj).val('');
	}
}

function validateAddReq(){
	if(+$('#additionalReqId').val() > +remaining_add_req){
		alert('Additional requirementshould not exceed : ' + remaining_add_req);
		$('#additionalReqId').val('');
		$('#additionalReqId').focus();
	}
}

function validateWithCorrespondingFund(index){
	var tota_fund_cec= +$('#fundCecId_'+index).text();	
	var total_corresponding_fund_remaining = tota_fund_cec - $('#totalExpenditureIncurred_'+index).val();
	if($('#expenditureIncurred_'+index).val() > total_corresponding_fund_remaining){
		alert('total expenditure should not exceed '+ total_corresponding_fund_remaining);
		$('#expenditureIncurred_'+index).val('');
		$('#expenditureIncurred_'+index).focus();
	}
}

function calTotalExpenditure(){
	var rowCount=$('#tbodyId tr').length -2;
	var total_expenditure=0;
	for( var i=0;i < rowCount; i++){
		if($('#expenditureIncurred_'+i).val() != null && $('#expenditureIncurred_'+i).val() != undefined){
			total_expenditure += +$('#expenditureIncurred_'+i).val();
		}
	}
	$('#totalExpenditureId').val(total_expenditure + +$('#additionalReqId').val());
}

function FreezeAndUnfreeze(msg){
	var componentId=9;
	var qprActivityId=$('#qprActivityId').val();
	var quaterId = $('#quaterDropDownId').val();
	document.innovativeActivity.method = "post";
	document.innovativeActivity.action = "freezeAndUnfreezeReport.html?<csrf:token uri='freezeAndUnfreezeReport.html'/>&componentId="+componentId+"&qprActivityId="+qprActivityId+"&quaterId="+quaterId+"&msg="+msg;
	document.innovativeActivity.submit();
}
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<!-- Task Info -->
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="card">
					<div class="header">
						<h2>Innovative Activity Quaterly Report</h2>
						<form:form method="POST" id="innovativeActFormId"
							name="innovativeActivity" class="form-inline"
							action="innovativeActivityQpr.html"
							modelAttribute="INNOVATIVE_ACTIVITY_QUATERLY_REPORT">
							<input type="hidden" name="<csrf:token-name/>"
								value="<csrf:token-value uri="innovativeActivityQpr"/>" />
							<div class="body">
								<div class="row clearfix">
									<div class="form-group">
										<div class="col-lg-2">
											<label for="QuaterId1"><strong>Quarter
													Duration :</strong></label>
										</div>
										<div align="center" class="col-lg-4">
											<select id="quaterDropDownId" name="quarterDuration.qtrId"
												class="form-control"
												onchange="saveAndGetDataQtrRprt('qtrChange');showTablediv()">
												<option value="0">Select quarter</option>
												<c:forEach items="${QUATER_DETAILS}" var="qtr">
													<option value="${qtr.qtrId}">${qtr.qtrDuration}</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>
								<div id="mainDivId">
									<div class="table-responsive">
										<table class="table table-bordered table-hover">
											<thead>
												<tr>
													<th><div align="center">S.No.</div></th>
													<th><div align="center">Name of Activity</div></th>
													<th><div align="center">Fund Proposed</div></th>
													<th><div align="center">Expenditure Incurred</div></th>
												</tr>
											</thead>
											<tbody id="tbodyId">
											<c:forEach items="${CEC_APPROVED_ACTIVITY.innovativeActivityDetails}" var="cecDetailsData" varStatus="index">
													<!-- total number of units filled in rest quaters -->
													<c:choose>
														<c:when test="${not empty DEATIL_FOR_TOTAL_NO_OF_UNIT}">
															<input type="hidden"
																id="totalExpenditureIncurred_${index.index}"
																value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[index.index].expenditureIncurred}" />
														</c:when>
														<c:otherwise>
															<input type="hidden"
																id="totalExpenditureIncurred_${index.index}" value="0" />
														</c:otherwise>
													</c:choose>
													<!-- ends here -->

													<tr>
													<td><div align="center"><strong>${index.index + 1}. </strong></div></td>
													<td><div align="center"><strong>${cecDetailsData.activityName}</strong></div></td>
													<td><div align="center" id="fundCecId_${index.index}"><strong>${cecDetailsData.fundsName}</strong></div></td>
													<td><div align="center">
													<c:choose>
														<c:when test="${not empty QPR_INNOVATIVE_ACTIVITY}">
															<form:input class="form-control validate Align-Right" path="qprInnovativeActivityDetails[${index.index}].expenditureIncurred" id="expenditureIncurred_${index.index}" value="${QPR_INNOVATIVE_ACTIVITY.qprInnovativeActivityDetails[index.index].expenditureIncurred}" onkeyup="validateFundByAllocatedFund(${index.index});validateWithCorrespondingFund(${index.index });calTotalExpenditure()" readonly="${QPR_INNOVATIVE_ACTIVITY.isFreeze}"/>
														</c:when>
														<c:otherwise>
															<input type="text" class="form-control validate Align-Right" name="qprInnovativeActivityDetails[${index.index}].expenditureIncurred" id="expenditureIncurred_${index.index}" onkeyup="validateFundByAllocatedFund(${index.index});validateWithCorrespondingFund(${index.index});calTotalExpenditure()"/>
														</c:otherwise>
													</c:choose>
													</div></td>
												</tr>
												<!-- HIDDEN FIELDS -->
													<input type="hidden" name="qprInnovativeActivityDetails[${index.index}].qprIaDetailsId" value="${QPR_INNOVATIVE_ACTIVITY.qprInnovativeActivityDetails[index.index].qprIaDetailsId}" />
											</c:forEach>
											<tr>
												<th><div align="center">Additional Requirement</div></th>
												<th><div align="center" id="additionalReqStateId">${CEC_APPROVED_ACTIVITY.additioinalRequirements}</div></th>
												<td></td>
												<td><div align="center"><form:input path="additioinalRequirements" id="additionalReqId" value="${QPR_INNOVATIVE_ACTIVITY.additioinalRequirements}" class="form-control validate Align-Right" onkeyup="validateAddReq();calTotalExpenditure()" readonly="${QPR_INNOVATIVE_ACTIVITY.isFreeze}"/></div></td>
											</tr>
											<tr>
											<th colspan="2"><div align="center">Total Expenditure Incurred</div></th>
											<td></td>
											<td><div align="center"><input type="text" id="totalExpenditureId"  class="form-control validate Align-Right" disabled="disabled" /></div></td>
											</tr>
											</tbody>
										</table>
									</div>
									<div class="form-group text-right" style="padding-right: 10px;">
										<form:button onclick="saveAndGetDataQtrRprt('save')" id="saveButtn"
											class="btn bg-green waves-effect" disabled="${QPR_INNOVATIVE_ACTIVITY.isFreeze}">SAVE</form:button>
										<c:choose>
											<c:when test="${QPR_INNOVATIVE_ACTIVITY.isFreeze}">
												<form:button class="btn bg-orange waves-effect"
													onclick="FreezeAndUnfreeze('unfreeze')">UNFREEZE</form:button>
											</c:when>
											<c:otherwise>
												<form:button class="btn bg-orange waves-effect"
													disabled="${DISABLE_FREEZE}"
													onclick="FreezeAndUnfreeze('freeze')">FREEZE</form:button>
											</c:otherwise>
										</c:choose>	
										<%-- <form:button id="clearButtn" onclick="onClear(this)"
											class="btn bg-light-blue waves-effect" disabled="${QPR_INNOVATIVE_ACTIVITY.isFreeze}">CLEAR</form:button> --%>
										<form:button
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-red waves-effect">CLOSE</form:button>
									</div>
								</div>
							</div>
							<!-- HIDDEN FIELDS -->
							<input type="hidden" id="quaterTransient" name="qtrId" />
							<input type="hidden" id="origin" name="origin" />
							<input type="hidden" name="qprIaId" value="${QPR_INNOVATIVE_ACTIVITY.qprIaId}" id="qprActivityId"/>
							<input type="hidden" name="innovativeActivity.innovativeActivityId" value="${CEC_APPROVED_ACTIVITY.innovativeActivityId}" />
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<style>
.Align-Right{
				text-align: right;}
</style>