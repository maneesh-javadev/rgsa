<%@include file="../taglib/taglib.jsp"%>
<script>
var quator_id='${QTR_ID}';
var remaining_add_req = '${REMAINING_ADD_REQ}';
var qtr_1_2_filled='${QTR_ONE_TWO_FILLED}';
var fund_allocated_by_state='${FUND_ALLOCATED_BY_STATE}';
var fund_used='${FUND_USED_IN_OTHER_QUATOR}';
if(quator_id > 2){
	var fund_allocated_in_pre_qtr = '${FUND_ALLOCATED_BY_STATE_PREVIOUS}';
	var fund_used_in_qtr_1_and_2 = '${TOTAL_FUND_USED_IN_QTR_1_AND_2}';
}
$('document').ready(function() {
	if(qtr_1_2_filled == "false"){
		alert('Please fill the quater 1 and 2 progress report first.');
	}
	$('#qtrId').val(quator_id);
	$('#qtrDropDownId').val(quator_id);
	showTable();
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

function saveAndGetDataQtrRprt(msg){
	$('#qtrId').val($('#qtrDropDownId').val());
 	$('#origin').val(msg);
	document.satcomActivityProgress.method = "post";
	document.satcomActivityProgress.action = "currentUsageSatcomQuaterlyPost.html?<csrf:token uri='currentUsageSatcomQuaterlyPost.html'/>";
	document.satcomActivityProgress.submit();
}

function showTable(){
	if($('#qtrDropDownId').val() != null && $('#qtrDropDownId').val() != undefined && $('#qtrDropDownId').val() != 0 && $('#qtrDropDownId').val() != ''){
		$('#tableDivId').show();
	}else{
		$('#tableDivId').hide();
	}
}

function validateFundByAllocatedFund(obj){
	var noOfRows=$("#tbodyId tr").length-1;
	var fund_allocated_by_state_local = +fund_allocated_by_state;
	var fund_used_local= +fund_used;
	var total=0;
	
	if(quator_id > 2){
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

function validateNoOfUnits(index){
	var no_of_unit_cec= +$('#noOfUnitCecId_'+index).text();	
	/* var total_no_of_unit_remaining = no_of_unit_cec - $('#totalNoOfUnit_'+index).val(); */
	if($('#noOfUnitCompleted_'+index).val() > no_of_unit_cec){
		alert('total number of units should not exceed '+no_of_unit_cec);
		$('#noOfUnitCompleted_'+index).val('');
		$('#noOfUnitCompleted_'+index).focus();
	}
}

function isNoOfUnitAndExpInurredFilled(index){
	if($('#noOfUnitCompleted_'+index).val() == 0 || $('#noOfUnitCompleted_'+index).val() == null || $('#noOfUnitCompleted_'+index).val() ==''){
		alert('Expenditure incurred cannot be filled if number of unit filled is zero or blank.');
		$('#expenditureIncurred_'+index).val('');
		$('#noOfUnitCompleted_'+index).focus();
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
	var componentId=7;
	var qprActivityId=$('#qprActivityId').val();
	var quaterId = $('#qtrDropDownId').val();
	document.satcomActivityProgress.method = "post";
	document.satcomActivityProgress.action = "freezeAndUnfreezeReport.html?<csrf:token uri='freezeAndUnfreezeReport.html'/>&componentId="+componentId+"&qprActivityId="+qprActivityId+"&quaterId="+quaterId+"&msg="+msg;
	document.satcomActivityProgress.submit();
}
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Distance learning Facility through SATCOM/IP based
							virtual Class room/similar technology</h2>
					</div>
					<form:form method="post" name="satcomActivityProgress" action="currentUsageSatcomQuaterlyPost.html" modelAttribute="SATCOM_QUATER">
					<input type="hidden" name="<csrf:token-name/>" value="<csrf:token-value uri="currentUsageSatcomQuaterlyPost.html" />" />
						<div class="body">
							<div class="row clearfix">
								<div class="form-group">
								<c:set var="count" value="0" scope="page" />
									<div class="col-lg-2">
										<label for="QuaterId1"><strong>Quarter Duration :</strong></label>
									</div>
									<div class="col-lg-4">
										<select class="form-control" name="satcomActivityProgressDetails[${count}].quarterDuration.qtrId" id="qtrDropDownId" onchange="saveAndGetDataQtrRprt('qtrChange');showTable()">
											<option value="0">Select Quator</option>
											<c:forEach items="${QUATER_DETAILS}" var="qtr">
											<option value="${qtr.qtrId}">${qtr.qtrDuration}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							<div id="tableDivId">
							<table class="table table-bordered">
								<thead>
									<tr>
									   <th><div align="center"><strong>Name of the Activity</strong></div></th>
									   <th><div align="center"><strong>Panchayat Level</strong></div></th>
									   <th><div align="center"><strong>No. of Units<br>A</strong></div></th>
									   <th><div align="center"><strong>Unit Cost (in Rs)<br>B</strong></div></th>
									   <th><div align="center"><strong>Fund Proposed (in Rs)<br>C = A * B</strong></div></th>
									   <th><div align="center">No. of Persons Trained</div></th>
									   <th><div align="center">Expenditure incurred</div></th>
									</tr>
								</thead>
								<tbody id="tbodyId">
								<c:choose>
								<c:when test="${not empty SATCOM_ACTIVITY_APPROVED}">
									<c:forEach items="${SATCOM_ACTIVITY_APPROVED.activityDetails}" var="detailObjCec" varStatus="index">
									<c:choose>
									<c:when test="${not empty DEATIL_FOR_TOTAL_NO_OF_UNIT}">
										<input type="hidden" id="totalNoOfUnit_${index.index}" value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[index.index].noOfUnitCompleted}" />
										<input type="hidden" id="totalExpenditureIncurred_${index.index}" value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[index.index].expenditureIncurred}" />
									</c:when>
									<c:otherwise>
										<input type="hidden" id="totalNoOfUnit_${index.index}" value="0" />
										<input type="hidden" id="totalExpenditureIncurred_${index.index}" value="0" />
									</c:otherwise>
									</c:choose>
									<input type="hidden" name="satcomActivityProgressDetails[${index.index}].satcomDetailsProgressId"
								 	value="${QPR_DATA_BASED_CEC_ACT_ID.satcomActivityProgressDetails[index.index].satcomDetailsProgressId}">
									
									<tr>
									<td><div align="center"><strong>${detailObjCec.satcomMaster.satcomMasterName}</strong></div></td>
									<td><div align="center"><strong>${detailObjCec.level.satcomLevelName}</strong></div></td>
									<td id="noOfUnitCecId_${index.index}"><div align="center"><strong>${detailObjCec.noOfUnits}</strong></div></td>
									<td><div align="center"><strong>${detailObjCec.unitCost}</strong></div></td>
									<td id="fundCecId_${index.index}"><div align="center"><strong>${detailObjCec.funds}</strong></div></td>
									<c:choose>
										<c:when test="${not empty QPR_DATA_BASED_CEC_ACT_ID.satcomActivityProgressDetails }">
											<td><form:input path="satcomActivityProgressDetails[${index.index}].noOfUnitCompleted" class="form-control validate" style="text-align: right;" id="noOfUnitCompleted_${index.index}" value="${QPR_DATA_BASED_CEC_ACT_ID.satcomActivityProgressDetails[index.index].noOfUnitCompleted }" onkeyup="validateNoOfUnits(${index.index});" required="required" readonly="${QPR_DATA_BASED_CEC_ACT_ID.isFreeze}"/></td>
											<td><form:input path="satcomActivityProgressDetails[${index.index}].expenditureIncurred" class="form-control validate" style="text-align: right;" value="${QPR_DATA_BASED_CEC_ACT_ID.satcomActivityProgressDetails[index.index].expenditureIncurred }" id="expenditureIncurred_${index.index}" onkeyup="validateFundByAllocatedFund(${index.index});isNoOfUnitAndExpInurredFilled(${index.index});validateWithCorrespondingFund(${index.index});calTotalExpenditure()" required="required" readonly="${QPR_DATA_BASED_CEC_ACT_ID.isFreeze}" /></td>
										</c:when>
										<c:otherwise>
											<td><input type="text" name="satcomActivityProgressDetails[${index.index}].noOfUnitCompleted" class="form-control validate" style="text-align: right;" id="noOfUnitCompleted_${index.index}" onkeyup="validateNoOfUnits(${index.index});" required="required"/></td>
											<td><input type="text" name="satcomActivityProgressDetails[${index.index}].expenditureIncurred" class="form-control validate" style="text-align: right;" id="expenditureIncurred_${index.index}" onkeyup="validateFundByAllocatedFund(${index.index});isNoOfUnitAndExpInurredFilled(${index.index}); validateWithCorrespondingFund(${index.index});calTotalExpenditure()" required="required"/></td>
										</c:otherwise>
									</c:choose>
									
									</tr>
									</c:forEach>
									<tr>
										<th colspan="2"><div align="center">Additional Requirement</div></th>
										<th colspan="3"><div align="center" id="additionalReqStateId">${SATCOM_ACTIVITY_APPROVED.additionalRequirement }</div></th>
										<td></td>
										<td><form:input path="additionalRequirement" id="additionalReqId" value="${QPR_DATA_BASED_CEC_ACT_ID.additionalRequirement}" class="form-control validate" style="text-align: right;" onkeyup="validateAddReq();calTotalExpenditure()" readonly="${QPR_DATA_BASED_CEC_ACT_ID.isFreeze}" /></td>
									</tr>
									
										<tr>
											<th colspan="2"><div align="center">Total Expenditure Incurred</div></th>
											<td colspan="4"></td>
											<td><input type="text" id="totalExpenditureId"  class="form-control validate Align-Right" disabled="disabled" style="text-align: right;" /></td>
										</tr>
								</c:when>
								<c:otherwise>
									<!-- no condition till now -->
								</c:otherwise>
								</c:choose>
								</tbody>
							</table>
								<div class="text-right">
									<form:button onclick="saveAndGetDataQtrRprt('save')" class="btn bg-green waves-effect" disabled="${QPR_DATA_BASED_CEC_ACT_ID.isFreeze}">
										SAVE</form:button>
									<c:choose>
										<c:when test="${QPR_DATA_BASED_CEC_ACT_ID.isFreeze}"><form:button class="btn bg-orange waves-effect" onclick="FreezeAndUnfreeze('unfreeze')">UNFREEZE</form:button></c:when>
										<c:otherwise><form:button class="btn bg-orange waves-effect" disabled="${DISABLE_FREEZE}" onclick="FreezeAndUnfreeze('freeze')">FREEZE</form:button></c:otherwise>
									</c:choose>
									<%-- <form:button onclick="onClear(this)"
										class="btn bg-light-blue waves-effect" disabled="${QPR_DATA_BASED_CEC_ACT_ID.isFreeze}">CLEAR</form:button> --%>
									<form:button
										onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-orange waves-effect">CLOSE</form:button>
								</div>
							</div>
						</div>
						
						<!--hidden fields  -->
						<input type="hidden" id="qtrId" name="qtrIdJsp1" />
						<input type="hidden" id="origin" name="origin" />
						<input type="hidden" name="satcomActivity.satcomActivityId"  value="${satcomActivityId}">
						<input type="hidden" name="satcomActivityProgressId"  value="${PROGRESS_REPORT_ACT_ID}" id="qprActivityId">
						
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
