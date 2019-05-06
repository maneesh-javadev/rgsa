<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"> 

var quater_id = '${QTR_ID}';
var remaining_add_req = '${REMAINING_ADD_REQ}';
var fund_allocated_by_state='${FUND_ALLOCATED_BY_STATE}';
var fund_used='${FUND_USED_IN_OTHER_QUATOR}';
if(quater_id > 2){
	var fund_allocated_in_pre_qtr = '${FUND_ALLOCATED_BY_STATE_PREVIOUS}';
	var fund_used_in_qtr_1_and_2 = '${TOTAL_FUND_USED_IN_QTR_1_AND_2}';
}
$( document ).ready(function() {
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
	 	document.administrativeTechnicalProgress.method = "post";
		document.administrativeTechnicalProgress.action = "adminTechQuaderly.html?<csrf:token uri='adminTechQuaderly.html'/>";
		document.administrativeTechnicalProgress.submit();
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

function validateAddReq(){
	if(+$('#additionalReqId').val() > +remaining_add_req){
		alert('Additional requirementshould not exceed : ' + remaining_add_req);
		$('#additionalReqId').val('');
		$('#additionalReqId').focus();
	}
			
}
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Administrative And Technical Support to Gram Panchayat</h2>
					</div>
					<form:form method="post" name="administrativeTechnicalProgress"
						action="adminTechQuaderly.html" modelAttribute="ADMIN_QUATER">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="adminTechQuaderly.html" />" />

						<div class="body">
							<div class="row clearfix">
								<div class="form-group">
									<div class="col-lg-2">
										<label for="QuaterId1"><strong>Quarter
												Duration :</strong></label>
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
							<div class="table-responsive">
								<table class="table table-bordered" id="mytable">
									<thead>
										<tr>
											<th>S.No.</th>
											<th>Post Type</th>
											<th>Post Name</th>
											<th>No. Of Unit Approved</th>
											<th>Fund Approved</th>
											<th>No. of Unit Filled</th>
											<th>Expenditure Incurred</th>
										</tr>

									</thead>
									<tbody id="tbodyId">
										<c:forEach
											items="${APPROVED_ADMIN_TECH_ACT.supportDetails}"
											var="obj" varStatus="count">
											
											<!-- total number of units filled in rest quaters -->
											<c:choose>
												<c:when test="${not empty DEATIL_FOR_TOTAL_NO_OF_UNIT}">
												<input type="hidden" id="totalExpenditureIncurred_${count.index}"
														value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[count.index].expenditureIncurred}" />
												
													<input type="hidden" id="totalNoOfUnit_${count.index}"
														value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[count.index].noOfUnitCompleted}" />
												</c:when>
												<c:otherwise>
													<input type="hidden" id="totalNoOfUnit_${count.index}"
														value="0" />
													<input type="hidden" id="totalExpenditureIncurred_${count.index}"
														value="0" />	
												</c:otherwise>
											</c:choose>
											<!-- ends here -->

											<input type="hidden" name="atsId" value="${ADMINISTRATIVE_TECHNICAL_PROGRESS.atsId}"><!-- progress report main table id -->
											<input type="hidden" name="administrativeTechnicalDetailProgress[${count.index}].atsDetailsProgressId"
												value="${ADMINISTRATIVE_TECHNICAL_PROGRESS.administrativeTechnicalDetailProgress[count.index].atsDetailsProgressId}">
											<input type="hidden" name="administrativeTechnicalDetailProgress[${count.index}].postType.postId"
												value="${obj.postType.postId}">
											<tr>
												<td><strong>${count.index+1}.</strong></td>
												<td><strong>${obj.postType.master.postTypeName}</strong></td>
												<td><strong>${obj.postType.postName}</strong></td>
												<td id="noOfUnitCecId_${count.index}"><strong>${obj.noOfUnits}</strong></td>
												<td id="fundCecId_${count.index}"><strong>${obj.funds}</strong></td>
												<td><input type="text"
													name="administrativeTechnicalDetailProgress[${count.index}].noOfUnitCompleted" id="noOfUnitCompleted_${count.index}"
													value="${ADMINISTRATIVE_TECHNICAL_PROGRESS.administrativeTechnicalDetailProgress[count.index].noOfUnitCompleted}"
													class="form-control validate" onkeyup="validateNoOfUnits(${count.index});"></td>
												<td><input type="text"
													name="administrativeTechnicalDetailProgress[${count.index}].expenditureIncurred" id="expenditureIncurred_${count.index}"
													value="${ADMINISTRATIVE_TECHNICAL_PROGRESS.administrativeTechnicalDetailProgress[count.index].expenditureIncurred}"
													class="form-control validate" onkeyup="validateFundByAllocatedFund(${count.index});validateWithCorrespondingFund(${count.index});isNoOfUnitAndExpInurredFilled(${count.index})"></td>
											</tr>
										</c:forEach>
										<tr>
											<th colspan="2"><div align="center">Additional Requirement</div></th>
											<th colspan="3"><div align="center" id="additionalReqStateId">${APPROVED_ADMIN_TECH_ACT.additionalRequirement }</div></th>
											<td></td>
											<td><input type="text" name="additionalRequirement" id="additionalReqId" value="${ADMINISTRATIVE_TECHNICAL_PROGRESS.additionalRequirement}" class="form-control validate Align-Right" onkeyup="validateAddReq()"></td>
										</tr>
									</tbody>
								</table>
								<div class="text-right">
									<button type="button" onclick="saveAndGetDataQtrRprt('save')" class="btn bg-green waves-effect">SAVE</button>
									<button type="button" onclick="onClear(this)"
										class="btn bg-light-blue waves-effect">CLEAR</button>
									<button type="button"
										onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-orange waves-effect">CLOSE</button>
								</div>
								</div>
							</div>
						</div>
						<!-- hidden fields -->
						<input type="hidden" id="quaterTransient" name="qtrIdJsp2" value='${QTR_ID}' />
						<input type="hidden" id="origin" name="origin" />
						<input type="hidden" name="administrativeTechnicalSupport.administrativeTechnicalSupportId" value="${APPROVED_ADMIN_TECH_ACT.administrativeTechnicalSupportId}">
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
