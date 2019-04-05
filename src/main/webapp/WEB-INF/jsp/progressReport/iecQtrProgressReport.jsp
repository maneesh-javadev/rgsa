<%@include file="../taglib/taglib.jsp"%>
<html>
<script>
var quator_id='${QTR_ID}';
var fund_allocated_by_state='${FUND_ALLOCATED_BY_STATE}';
var fund_used='${FUND_USED_IN_OTHER_QUATOR}';
if(quator_id > 2){
	var fund_allocated_in_pre_qtr = '${FUND_ALLOCATED_BY_STATE_PREVIOUS}';
	var fund_used_in_qtr_1_and_2 = '${TOTAL_FUND_USED_IN_QTR_1_AND_2}';
}
$( document ).ready(function() {
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

function getSelelctedQtrRprt(){
	 var qtId = $('#quaterId').val();
	 $('#qtrId').val(qtId);
	 	document.iecQuater.method = "get";
		document.iecQuater.action = "iecQtrProgressReport.html?<csrf:token uri='iecQtrProgressReport.html'/>";
		document.iecQuater.submit();
}

function showTable(){
	if($('#quaterId').val() != null && $('#quaterId').val() != undefined && $('#quaterId').val() != 0 && $('#quaterId').val() != ''){
		$('#tableDivId').show();
	}else{
		$('#tableDivId').hide();
	}
}

function validateFundByAllocatedFund(obj){
	var noOfRows=$("#tbodyId tr").length;
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
						<div class="row clearfix">
							<div class="form-group">
								<div class="col-lg-3" style="margin-left: 5%;">
									<label for="QuaterId1"><strong> Quarter Duration :</strong></label>
								</div>
								<div align="center" class="col-lg-4">
									<select id="quaterId" name="quarterDuration.qtrId"
										class="form-control" onchange="showTable();getSelelctedQtrRprt();">
										<option value="0">Select quarter</option>
										<c:forEach items="${QUATER_DETAILS}" var="qtr">
											<option value="${qtr.qtrId}">${qtr.qtrDuration}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>

						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="iec.html"/>" />
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
										<c:forEach items="${CEC_APPROVED_ACTIVITY.iecActivityDetails}" var="obj" varStatus="count">
											<input type="hidden" name="qprIecId" value="${IEC_ACTIVITY_PROGRESS.qprIecId}">
											<input type="hidden" name="iecQuaterDetails[${count.index}].qprIecDetailsId" value="${IEC_ACTIVITY_PROGRESS.iecQuaterDetails[count.index].qprIecDetailsId}">
											<tr>
												<td><strong>${obj.iecActivityDropedown.natureIecActivity}</strong></td>
												<td><strong>${obj.totalAmountProposed}</strong></td>
											<c:choose>
												<c:when test="${not empty IEC_ACTIVITY_PROGRESS}">
														<td><input type="text"
															name="iecQuaterDetails[${count.index}].expenditureIncurred"
															id="expenditureIncurred_${count.index}"
															value="${IEC_ACTIVITY_PROGRESS.iecQuaterDetails[count.index].expenditureIncurred}"
															onkeyup="validateFundByAllocatedFund(${count.index})"
															class="form-control validate" required="required"></td>
													</c:when>
												<c:otherwise>
														<td><input type="text"
															name="iecQuaterDetails[${count.index}].expenditureIncurred"
															id="expenditureIncurred_${count.index}"
															onkeyup="validateFundByAllocatedFund(${count.index})"
															class="form-control validate" required="required"></td>
													</c:otherwise>
											</c:choose>
											</tr>
										</c:forEach>
									</tbody>
									<c:set var="count" value="0" scope="page" />
								</table>
								<div class="text-right">
									<button type="submit" class="btn bg-green waves-effect">
										SAVE</button>
									<button type="button" onclick="onClear(this)"
										class="btn bg-light-blue waves-effect">CLEAR</button>
									<button type="button"
										onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-orange waves-effect">CLOSE</button>
								</div>
							</div>

						</div>
							<!--hidden fields  -->
							<input type="hidden" id="qtrId" name="qtrId" value='' />
							<input type="hidden" name="iecActivity.id" value="${CEC_APPROVED_ACT_ID}">
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
</html>
