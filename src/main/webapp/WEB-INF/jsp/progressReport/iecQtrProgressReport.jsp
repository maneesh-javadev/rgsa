<%@include file="../taglib/taglib.jsp"%>
<html>
<script>
var quator_id='${QTR_ID}';
var fund_allocated_by_state='${FUND_ALLOCATED_BY_STATE}';
var qtr_1_2_filled='${QTR_ONE_TWO_FILLED}';
var fund_used='${FUND_USED_IN_OTHER_QUATOR}';
if(quator_id > 2){
	var fund_allocated_in_pre_qtr = '${FUND_ALLOCATED_BY_STATE_PREVIOUS}';
	var fund_used_in_qtr_1_and_2 = '${TOTAL_FUND_USED_IN_QTR_1_AND_2}';
}
$( document ).ready(function() {
	if(qtr_1_2_filled == "false"){
		alert('Please fill the quater 1 and 2 progress report first.');
	}
	$('#quaterId').val(quator_id);
	$(".validate").keypress(function (e) {
	    //if the letter is not digit then display error and don't type anything
	    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	       //display error message
	       $("#errmsg").html("Digits Only").show().fadeOut("slow");
	              return false;
	   }
	  });
	showTable();
});

function saveAndGetDataQtrRprt(msg){
	 $('#qtrId').val($('#quaterId').val());
	 $('#origin').val(msg);
	 	document.iecQuater.method = "post";
		document.iecQuater.action = "iecQtrProgressReportPost.html?<csrf:token uri='iecQtrProgressReportPost.html'/>";
		document.iecQuater.submit();
}

function showTable(){
	if($('#quaterId').val() != null && $('#quaterId').val() != undefined && $('#quaterId').val() != 0 && $('#quaterId').val() != ''){
		$('#tableDivId').show();
	}else{
		$('#tableDivId').hide();
	}
}

function validateFundByAllocatedFund(){
	/* var noOfRows=$("#tbodyId tr").length; */
	var fund_allocated_by_state_local = +fund_allocated_by_state;
	var fund_used_local= +fund_used;
	/* var total=0; */
	
	if(quator_id > 2){
		fund_allocated_by_state_local += +(fund_allocated_in_pre_qtr - fund_used_in_qtr_1_and_2);
	}
	if(fund_used !=0){
		fund_allocated_by_state_local -=  +fund_used_local;
	}
	/* for (var index = 0; index < noOfRows; index++) {
		total +=  +$('#expenditureIncurred_'+index).val();
	} */
	if($('#expenditureIncurred').val() > fund_allocated_by_state_local){
		if(fund_used != 0){
			alert('Total expenditure should not exceed total remaining for this component which is Rs. '+ fund_allocated_by_state_local);
		}else{
			alert('Total expenditure should not exceed total fund allocted by state for this component which is Rs. '+ fund_allocated_by_state_local);
		}
		$('#expenditureIncurred').val('');
	}
}

function validateWithCorrespondingFund(){
	var tota_fund_cec= +$('#fundCecId').text();	
	var total_corresponding_fund_remaining = tota_fund_cec - $('#totalExpenditureIncurred').val();
	if($('#expenditureIncurred').val() > total_corresponding_fund_remaining){
		alert('total expenditure should not exceed '+ total_corresponding_fund_remaining);
		$('#expenditureIncurred').val('');
		$('#expenditureIncurred').focus();
	}
}

function FreezeAndUnfreeze(msg){
		var componentid=11;
		var qprActivityId=$('#qprActivityId').val();
		var quaterId = $('#quaterId').val();
		document.iecQuater.method = "post";
		document.iecQuater.action = "freezeAndUnfreezeReport.html?<csrf:token uri='freezeAndUnfreezeReport.html'/>&componentid="+componentid+"&qprActivityId="+qprActivityId+"&quaterId="+quaterId+"&msg="+msg;
		document.iecQuater.submit();
}
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Proposal for Information, Education, Communication (IEC)
							Progress Report</h2>
					</div>
					<form:form method="POST" name="iecQuater" action="iecQtrProgressReportPost.html" id="iecId" modelAttribute="IEC_ACTIVITY_QUATER" path="iecQtrProgressReport">
					<input type="hidden" name="<csrf:token-name/>" value="<csrf:token-value uri="iecQtrProgressReportPost.html" />" />
					<!--hidden fields  -->
							<input type="hidden" id="qtrId" name="qtrId" value='' />
							<input type="hidden" name="iecActivity.id" value="${CEC_APPROVED_ACT_ID}">
							<input type="hidden" id="origin" name="origin" />
						<div class="row clearfix">
							<div class="form-group">
								<div class="col-lg-3" style="margin-left: 5%;">
									<label for="QuaterId1"><strong> Quarter Duration :</strong></label>
								</div>
								<div align="center" class="col-lg-4">
									<select id="quaterId" name="quarterDuration.qtrId"
										class="form-control" onchange="saveAndGetDataQtrRprt('qtrChange');showTable();">
										<option value="0">Select quarter</option>
										<c:forEach items="${QUATER_DETAILS}" var="qtr">
											<option value="${qtr.qtrId}">${qtr.qtrDuration}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="body">
							<div class="table-responsive" id="tableDivId">
								<table class="table table-bordered" id="mytable">
									<thead>
										<tr>
											<th scope="col"><div align="center">
													<strong>Nature of the IEC Activity</strong>
												</div></th>
											<th scope="col"><div align="center">
													<strong>Total Amount Proposed</strong>
												</div></th>
											<th scope="col"><div align="center">
													<strong>Expenditure Incurred</strong>
												</div></th>
										</tr>
									</thead>
									<tbody id="tbodyId">
									
											<!-- total number of units filled in rest quaters -->
													<c:choose>
														<c:when test="${not empty DEATIL_FOR_TOTAL_NO_OF_UNIT}">
															<input type="hidden"
																id="totalExpenditureIncurred"
																value="${DEATIL_FOR_TOTAL_NO_OF_UNIT.expenditureIncurred}" />
														</c:when>
														<c:otherwise>
															<input type="hidden"
																id="totalExpenditureIncurred" value="0" />
														</c:otherwise>
													</c:choose>
													<!-- ends here -->
											<tr>
												<td><div align="center"><ul type="circle">
												<c:forEach items="${CEC_APPROVED_ACTIVITY.iecActivityDetails.iecDetailsDropdownSet}" var="activitySet" varStatus="index">
												<li><strong>${activitySet.iecActivityDropdown.natureIecActivity}</strong></li>
												</c:forEach>
												</ul></div></td>
												<td><div align="center" id="fundCecId"><strong>${CEC_APPROVED_ACTIVITY.iecActivityDetails.totalAmountProposed}</strong></div></td>
											<c:choose>
												<c:when test="${not empty IEC_ACTIVITY_PROGRESS}">
														<td><input type="text"
															name="iecQuaterDetails.expenditureIncurred"
															id="expenditureIncurred"
															value="${IEC_ACTIVITY_PROGRESS.iecQuaterDetails.expenditureIncurred}"
															onkeyup="validateFundByAllocatedFund();validateWithCorrespondingFund()"
															class="form-control validate" required="required"></td>
													</c:when>
												<c:otherwise>
														<td><input type="text"
															name="iecQuaterDetails.expenditureIncurred"
															id="expenditureIncurred"
															onkeyup="validateFundByAllocatedFund();validateWithCorrespondingFund()"
															class="form-control validate" required="required"></td>
													</c:otherwise>
											</c:choose>
											</tr>
									</tbody>
								</table>
								<!-- HIDDEN FIELDS -->
								<input type="hidden" name="qprIecId" value="${IEC_ACTIVITY_PROGRESS.qprIecId}" id="qprActivityId"/>
								<input type="hidden" name="iecQuaterDetails.qprIecDetailsId" value="${IEC_ACTIVITY_PROGRESS.iecQuaterDetails.qprIecDetailsId}" />
								
								<div class="text-right">
									<button type="button" onclick="saveAndGetDataQtrRprt('save')" id="saveButtn"
										class="btn bg-green waves-effect">SAVE</button>
									<button type="button" onclick="FreezeAndUnfreeze('freeze')"
										class="btn bg-green waves-effect">FREEZE</button>	
									<button type="button" onclick="onClear(this)"
										class="btn bg-light-blue waves-effect">CLEAR</button>
									<button type="button"
										onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-orange waves-effect">CLOSE</button>
								</div>
							</div>

						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
</html>
