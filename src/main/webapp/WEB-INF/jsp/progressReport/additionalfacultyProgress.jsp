<%@include file="../taglib/taglib.jsp"%>
<script>
var quater_id = '${QTR_ID}';
var fund_allocted_sprc = '${FUND_ALLOCATED_SPRC}';
var fund_allocted_dprc = '${FUND_ALLOCATED_DPRC}';
var fund_used_other_qtr_sprc = '${FUND_USED_IN_OTHER_QTR_SPRC}';
var fund_used_other_qtr_dprc = '${FUND_USED_IN_OTHER_QTR_DPRC}';
var pre_install_fund_sprc = '${PRE_INSTALLMENT_FUND_SPRC}';
var pre_install_fund_dprc = '${PRE_INSTALLMENT_FUND_DPRC}';
var total_fund_used_qtr_1_2_sprc = '${TOTAL_SPRC_FUND_USED_IN_QTR_1_AND_2}';
var total_fund_used_qtr_1_2_dprc = '${TOTAL_DPRC_FUND_USED_IN_QTR_1_AND_2}';
var total_add_req_sprc_filled = '${TOTAL_ADD_REQ_SPRC}';
var total_add_req_dprc_filled = '${TOTAL_ADD_REQ_DPRC}';

$(document).ready(function() {
	$('#quaterDropDownId').val(quater_id);
	showTablediv();
	calTotalExpenditure();
});

function saveAndGetDataQtrRprt(msg){
	 	$('#qtrIdJsp3').val($('#quaterDropDownId').val());
	 	$('#origin').val(msg);
	 	document.additionalFacultyProgress.method = "post";
		document.additionalFacultyProgress.action = "additionalfacultyProgress.html?<csrf:token uri='additionalfacultyProgress.html'/>";
		document.additionalFacultyProgress.submit();
}


$( document ).ready(function() {
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

function validateFundByAllocatedFund(index){
	var noOfRows=$("#tbodyId tr").length;
	var fund_allocted_sprc_local = +fund_allocted_sprc;
	var fund_allocted_dprc_local = +fund_allocted_dprc;
	var total_fund_filled_sprc=0;
	var total_fund_filled_dprc=0;
	
	if(fund_used_other_qtr_sprc != '' && fund_used_other_qtr_sprc != null){
		fund_allocted_sprc_local -= +fund_used_other_qtr_sprc;
	}
	
	if(fund_used_other_qtr_dprc != '' && fund_used_other_qtr_dprc != null){
		fund_allocted_dprc_local -= +fund_used_other_qtr_dprc;
	}
	
	if(pre_install_fund_sprc != null && total_fund_used_qtr_1_2_sprc != null){
		fund_allocted_sprc_local += +(pre_install_fund_sprc - total_fund_used_qtr_1_2_sprc);
	}
	
	if(pre_install_fund_dprc != null && total_fund_used_qtr_1_2_dprc != null){
		fund_allocted_dprc_local += +(pre_install_fund_dprc - total_fund_used_qtr_1_2_dprc);
	}
	
	for(var i = 0; i < noOfRows;i++){
		if($('#expenditureIncurred_'+i).val() != null && $('#expenditureIncurred_'+i).val() != ''){
			if(i< 3){
				total_fund_filled_sprc += +$('#expenditureIncurred_'+i).val();
			}else{
				total_fund_filled_dprc += +$('#expenditureIncurred_'+i).val();
			}
		}
	}
	if(total_fund_filled_sprc > fund_allocted_sprc_local){
		alert('Total expenditure should not exceed total remaining for this component which is Rs. '+ (fund_allocted_sprc_local - (total_fund_filled_sprc - $('#expenditureIncurred_'+index).val())));
		$('#expenditureIncurred_'+index).val('');
		$('#expenditureIncurred_'+index).focus();
	}
	if(total_fund_filled_dprc > fund_allocted_dprc_local){
		alert('Total expenditure should not exceed total remaining for this component which is Rs. '+ (fund_allocted_dprc_local - (total_fund_filled_dprc - $('#expenditureIncurred_'+index).val())));
		$('#expenditureIncurred_'+index).val('');
		$('#expenditureIncurred_'+index).focus();
	}
}

function isNoOfUnitAndExpInurredFilled(index){
	if(($('#noOfUnitCompleted_'+index).val() == null || $('#noOfUnitCompleted_'+index).val() =='') && (index != 2 && index != 5)){
		alert('Expenditure incurred cannot be filled if number of unit filled is zero or blank.');
		$('#expenditureIncurred_'+index).val('');
		$('#noOfUnitCompleted_'+index).focus();
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

function validateNoOfUnits(index){
	var no_of_unit_cec= +$('#noOfUnitCecId_'+index).text();	
	/* var total_no_of_unit_remaining = no_of_unit_cec - $('#totalNoOfUnit_'+index).val(); */
	if($('#noOfUnitCompleted_'+index).val() > no_of_unit_cec){
		alert('total number of units should not exceed '+no_of_unit_cec);
		$('#noOfUnitCompleted_'+index).val('');
		$('#noOfUnitCompleted_'+index).focus();
	}
}

function validateAddReq(msg){
	var main_add_req_sprc = $('#additionalReqSprcStateId').text();
	var main_add_req_dprc = $('#additionalReqDprcStateId').text();
	
	if(msg == 'sprc'){
		if($('#additionalReqSprcId').val() > (main_add_req_sprc - total_add_req_sprc_filled)){
			alert('Additional requirement for SPRC should not exceed : ' + (main_add_req_sprc - total_add_req_sprc_filled));
			$('#additionalReqSprcId').val('');
			$('#additionalReqSprcId').focus();
			
		}		
	}else{
		if($('#additionalReqDprcId').val() > (main_add_req_dprc - total_add_req_dprc_filled)){
			alert('Additional requirement for DPRC should not exceed : ' + (main_add_req_dprc - total_add_req_dprc_filled));
			$('#additionalReqDprcId').val('');
			$('#additionalReqDprcId').focus();		
		}
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
	$('#totalExpenditureId').val(total_expenditure + +$('#additionalReqSprcId').val() + +$('#additionalReqDprcId').val());
}
</script>
<section class="content" > 
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Additional Faculty and Maintenance at SPRC and DPRC</h2>
					</div>
					<form:form method="post" name="additionalFacultyProgress" action="additionalfacultyProgress.html" modelAttribute="HR_SUPPORT_SPRC_DPRC_QUATER">
					<input type="hidden" name="<csrf:token-name/>" value="<csrf:token-value uri="additionalfacultyProgress.html" />" />
					<div class="body">
					<c:set var="count" value="0" scope="page" />
					<div class="row clearfix">
					 <div class="form-group">
						<div class="col-lg-2">
						  	<label for="QuaterId1"><strong>Quarter Duration :</strong></label>
					    </div>
							<div align="center" class="col-lg-4">
								<select id="quaterDropDownId" name="quarterDuration.qtrId"
									class="form-control" onchange="saveAndGetDataQtrRprt('qtrChange');">
									<option value="0">Select quarter</option>
									<c:forEach items="${QUATER_DETAILS}" var="qtr">
										<option value="${qtr.qtrId}">${qtr.qtrDuration}</option>
									</c:forEach>
								</select>
							</div>
                           </div>
                        </div>
                        <div id="mainDivId">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th><div align="center">Type of Center</div></th>
									<th><div align="center">Faculty and Staff</div></th>
									<th><div align="center">No of Units Approved</div></th>
									<th><div align="center">Fund Sanctioned</div></th>
									<th><div align="center">No. of Unit Filled</div></th>
								   <th><div align="center">Expenditure Incurred </div></th>
								</tr>
							</thead>
							<tbody id="tbodyId">
								<c:forEach items="${CEC_APPROVED_ACTIVITY_DETAILS}"  var="approvedActDetail" varStatus="count" >
									
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
										
									<input type="hidden" name="institueInfraHrActivity.instituteInfraHrActivityId" value="${CEC_APPROVED_ACTIVITY.instituteInfraHrActivityId}" /> 
						 	 		<input type="hidden" name="qprInstInfraHrId"  value="${QPR_ACTIVITY.qprInstInfraHrId}" />
						 	 		<input type="hidden" name="additionalFacultyProgressDetail[${count.index}].instituteInfraHrActivityType.instituteInfraHrActivityTypeId" value="${approvedActDetail.instituteInfraHrActivityType.instituteInfraHrActivityTypeId}" />
							 		<input type="hidden" name="additionalFacultyProgressDetail[${count.index}].qprInstInfraHrDetailsId" value="${QPR_ACTIVITY.additionalFacultyProgressDetail[count.index].qprInstInfraHrDetailsId}" />
									<tr>
										<td><div align="center"><strong>${approvedActDetail.instituteInfraHrActivityType.trainingInstitueType.trainingInstitueTypeName}</strong></div></td>
										<td><div align="center"><strong>${approvedActDetail.instituteInfraHrActivityType.instituteInfraHrActivityName}</strong></div></td>
										<td><div align="center" id="noOfUnitCecId_${count.index}"><strong>${approvedActDetail.noOfUnits}</strong></div></td>
										<td><div align="center" id="fundCecId_${count.index}"><strong>${approvedActDetail.fund}</strong></div></td>
										<c:choose>
											<c:when test="${not empty QPR_ACTIVITY}">
												<td><c:if test="${count.index ne 2 and count.index ne 5}">
													<input name="additionalFacultyProgressDetail[${count.index}].noOfUnitsFilled" id="noOfUnitCompleted_${count.index}" type="text" style="text-align: right;" class="form-control validate"  value="${QPR_ACTIVITY.additionalFacultyProgressDetail[count.index].noOfUnitsFilled}" onkeyup="validateNoOfUnits(${count.index})"/>
								 				</c:if></td>
									 				<td><input name="additionalFacultyProgressDetail[${count.index}].expenditureIncurred" id="expenditureIncurred_${count.index}" type="text" style="text-align: right;" class="form-control validate" value="${QPR_ACTIVITY.additionalFacultyProgressDetail[count.index].expenditureIncurred }" onkeyup="validateFundByAllocatedFund(${count.index});validateWithCorrespondingFund(${count.index});isNoOfUnitAndExpInurredFilled(${count.index});calTotalExpenditure()"/></td>
											</c:when>
											<c:otherwise>
												<td><c:if test="${count.index ne 2 and count.index ne 5}">
													<input name="additionalFacultyProgressDetail[${count.index}].noOfUnitsFilled" id="noOfUnitCompleted_${count.index}" type="text" style="text-align: right;" class="form-control validate" onkeyup="validateNoOfUnits(${count.index})" />
								 				</c:if></td>
									 				<td><input name="additionalFacultyProgressDetail[${count.index}].expenditureIncurred" id="expenditureIncurred_${count.index}" type="text" style="text-align: right;" class="form-control validate" onkeyup="validateFundByAllocatedFund(${count.index});validateWithCorrespondingFund(${count.index});isNoOfUnitAndExpInurredFilled(${count.index});calTotalExpenditure()"></td>
											</c:otherwise>
										</c:choose>
										
									</tr>
								</c:forEach>
									<tr>
										<th colspan="2"><div align="center">Additional Requirement SPRC</div></th>
										<th colspan="2"><div align="center" id="additionalReqSprcStateId">${CEC_APPROVED_ACTIVITY.additionalRequirementSprc }</div></th>
										<td></td>
										<td><input type="text" name="additionalReqSprc" id="additionalReqSprcId" style="text-align: right;" value="${QPR_ACTIVITY.additionalReqSprc}" class="form-control validate" onkeyup="validateAddReq('sprc');calTotalExpenditure()"></td>
									</tr>
									
									<tr>
										<th colspan="2"><div align="center">Additional Requirement DPRC</div></th>
										<th colspan="2"><div align="center" id="additionalReqDprcStateId">${CEC_APPROVED_ACTIVITY.additionalRequirementDprc }</div></th>
										<td></td>
										<td><input type="text" name="additionalReqDprc" id="additionalReqDprcId" style="text-align: right;" value="${QPR_ACTIVITY.additionalReqDprc}" class="form-control validate" onkeyup="validateAddReq('dprc');calTotalExpenditure()"></td>
									</tr>

									<tr>
										<th colspan="2"><div align="center">Total
												Expenditure Incurred</div></th>
										<td colspan="3"></td>
										<td><input type="text" id="totalExpenditureId"
											class="form-control validate Align-Right"
											disabled="disabled"  style="text-align: right;"/></td>
									</tr>
									</tbody>
						</table>
							<div class="text-right">
								<button type="submit" onclick="saveAndGetDataQtrRprt('save')" class="btn bg-green waves-effect">SAVE</button>
								<button type="button" onclick="onClear(this)" class="btn bg-light-blue waves-effect">CLEAR</button>
								<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect">CLOSE</button>
							</div>
						</div>
						</div>
							<input type="hidden" id="qtrIdJsp3" name="qtrIdJsp3" value=""/>
							<input type="hidden" id="origin" name="origin" />
							
					</form:form>
				</div>
				
			</div>
		</div>
	</div>
</section>
 <script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>                          