<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript">
var quater_id = '${QTR_ID}';
var fund_allocated_by_state='${FUND_ALLOCATED_BY_STATE}';
var fund_used='${FUND_USED_IN_OTHER_QUATOR}';
if(quater_id > 2){
	var fund_allocated_in_pre_qtr = '${FUND_ALLOCATED_BY_STATE_PREVIOUS}';
	var fund_used_in_qtr_1_and_2 = '${TOTAL_FUND_USED_IN_QTR_1_AND_2}';
}

$('document').ready(function(){
	$('#quaterDropDownId').val(quater_id);
	showTablediv();
	
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
	 $('#quaterTransient').val($('#quaterDropDownId').val());
	 $('#origin').val(msg);
	 	document.pmuProgress.method = "post";
		document.pmuProgress.action = "pmuProgresReport.html?<csrf:token uri='pmuProgresReport.html'/>";
		document.pmuProgress.submit();
}

function showTablediv(){
	if($('#quaterDropDownId').val() > 0){
		$('#mainDivId').show();
	}else{
		$('#mainDivId').hide();
	}
}

function validateNoOfUnits(index){
	var no_of_unit_cec= +$('#noOfUnitCecId_'+index).text();	
	var total_no_of_unit_remaining = no_of_unit_cec - $('#totalNoOfUnit_'+index).val();
	if($('#noOfUnitCompleted_'+index).val() > total_no_of_unit_remaining){
		alert('total number of units should not exceed '+total_no_of_unit_remaining);
		$('#noOfUnitCompleted_'+index).val('');
		$('#noOfUnitCompleted_'+index).focus();
	}
}

function validateFundByAllocatedFund(obj){
	var noOfRows=$("#tbodyId tr").length;
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

function validateWithCorrespondingFund(index){
	var tota_fund_cec= +$('#fundCecId_'+index).text();	
	var total_corresponding_fund_remaining = tota_fund_cec - $('#totalExpenditureIncurred_'+index).val();
	if($('#expenditureIncurred_'+index).val() > total_corresponding_fund_remaining){
		alert('total expenditure should not exceed '+ total_corresponding_fund_remaining);
		$('#expenditureIncurred_'+index).val('');
		$('#expenditureIncurred_'+index).focus();
	}
}

function isNoOfUnitAndExpInurredFilled(index){
	if($('#noOfUnitCompleted_'+index).val() == 0 || $('#noOfUnitCompleted_'+index).val() == null || $('#noOfUnitCompleted_'+index).val() ==''){
		alert('Expenditure incurred cannot be filled if number of unit filled is zero or blank.');
		$('#expenditureIncurred_'+index).val('');
		$('#noOfUnitCompleted_'+index).focus();
	}
}
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>PMU Progress Report</h2>
					</div>
					<div class="body">
						<form:form method="post" name="pmuProgress"
							action="pmuProgresReport.html"
							modelAttribute="PMU_ACTIVITY_QUATERLY">
							<input type="hidden" name="<csrf:token-name/>"
								value="<csrf:token-value uri="pmuProgresReport.html" />" />
									<div class="row clearfix">
										<div class="form-group">
											<div class="col-lg-2">
												<label for="QuaterId1"><strong>Quarter
														Duration :</strong></label>
											</div>
											<div align="center" class="col-lg-4">
												<select id="quaterDropDownId" name="quarterDuration.qtrId"
													class="form-control" onchange="saveAndGetDataQtrRprt('qtrChange');showTablediv()">
													<option value="0">Select quarter</option>
													<c:forEach items="${QUATER_DETAILS}" var="qtr">
														<option value="${qtr.qtrId}">${qtr.qtrDuration}</option>
													</c:forEach>
												</select>
											</div>
										</div>
									</div>
									<br>
									<div id="mainDivId">
									<table class="table table-bordered">
										<thead>
											<tr>
												<th><div align="center">Type of Center</div></th>
												<th><div align="center">Faculty and Staff</div></th>
												<th><div align="center">No. of Units Approved</div></th>
												<th><div align="center">Unit Cost Approved</div></th>
												<th><div align="center">Fund Sanctioned</div></th>
												<th><div align="center">No. of units
														completed/Persons involved</div></th>
												<th><div align="center">Expenditure incurred</div></th>
											</tr>
										</thead>
										<tbody id="tbodyId">
											<c:forEach
												items="${CEC_APPROVED_ACTIVITY.pmuActivityDetails}"
												var="obj" varStatus="count">
											<!-- total number of units filled in rest quaters -->
											<c:choose>
												<c:when test="${not empty DEATIL_FOR_TOTAL_NO_OF_UNIT}">
												<input type="hidden" id="totalExpenditureIncurred_${count.index}"
														value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[count.index].expenditureIncurred}" />
												
													<input type="hidden" id="totalNoOfUnit_${count.index}"
														value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[count.index].noOfUnitsFilled}" />
												</c:when>
												<c:otherwise>
													<input type="hidden" id="totalNoOfUnit_${count.index}"
														value="0" />
													<input type="hidden" id="totalExpenditureIncurred_${count.index}"
														value="0" />	
												</c:otherwise>
											</c:choose>
											<!-- ends here -->
											<tr>
													<td align="center"><strong>${obj.pmuActivityType.pmuType.pmuTypeName}</strong></td>
													<td align="center"><strong>${obj.pmuActivityType.pmuActivityName}</strong></td>
													<td><div id="noOfUnitCecId_${count.index}" align="center"><strong>${obj.noOfUnits}</strong></div></td>
													<td><div align="center"><strong>${obj.unitCost}</strong></div></td>
													<td><div id="fundCecId_${count.index}" align="center"><strong>${obj.fund}</strong></div></td>
													<c:choose>
														<c:when test="${not empty PMU_PROGRESS}">
															<td><input
																name="pmuProgressDetails[${count.index}].noOfUnitsFilled"
																type="text" style="text-align: right;"
																class="form-control validate" id="noOfUnitCompleted_${count.index}"
																onkeyup="validateNoOfUnits(${count.index});isNoOfUnitAndExpInurredFilled(${count.index})"
																value="${PMU_PROGRESS.pmuProgressDetails[count.index].noOfUnitsFilled}" required="required"/></td>
															<td><input
																name="pmuProgressDetails[${count.index}].expenditureIncurred"
																type="text" style="text-align: right;"
																class="form-control validate" id="expenditureIncurred_${count.index}"
																onkeyup="validateFundByAllocatedFund(${count.index});validateWithCorrespondingFund(${count.index});isNoOfUnitAndExpInurredFilled(${count.index})"
																value="${PMU_PROGRESS.pmuProgressDetails[count.index].expenditureIncurred}" required="required"></td>

															<input type="hidden"
																name="pmuProgressDetails[${count.index}].qprPmuDetailsId"
																value="${PMU_PROGRESS.pmuProgressDetails[count.index].qprPmuDetailsId}">
														</c:when>
														<c:otherwise>
															<td><input
																name="pmuProgressDetails[${count.index}].noOfUnitsFilled"
																type="text" style="text-align: right;"
																id="noOfUnitCompleted_${count.index}"
																onkeyup="validateNoOfUnits(${count.index});isNoOfUnitAndExpInurredFilled(${count.index})"
																class="form-control validate" required="required"/></td>
															<td><input
																name="pmuProgressDetails[${count.index}].expenditureIncurred"
																type="text" style="text-align: right;"
																id="expenditureIncurred_${count.index}"
																onkeyup="validateFundByAllocatedFund(${count.index});validateWithCorrespondingFund(${count.index});isNoOfUnitAndExpInurredFilled(${count.index})"
																class="form-control validate" required="required" /></td>
														</c:otherwise>
													</c:choose>


												</tr>
											</c:forEach>

										</tbody>
									</table>
									<div class="text-right">
											<button type="button" onclick="saveAndGetDataQtrRprt('save')" id="saveButtn"
												class="btn bg-green waves-effect">SAVE</button>
											<button type="button" onclick="onClear(this)"
												class="btn bg-light-blue waves-effect">CLEAR</button>
											<button type="button"
												onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
												class="btn bg-orange waves-effect">CLOSE</button>
										</div>
									</div>
							<!-- hidden field -->
							<input type="hidden" name="pmuActivity.pmuActivityId" value="${CEC_APPROVED_ACTIVITY.pmuActivityId}" />
							<input type="hidden" name="qprPmuId" value="${PMU_PROGRESS.qprPmuId}" />
							<input type="hidden" id="origin" name="origin" />
							<input type="hidden" id="quaterTransient" name="qtrIdJsp6" value='${qtrIdJsp6}' />
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>