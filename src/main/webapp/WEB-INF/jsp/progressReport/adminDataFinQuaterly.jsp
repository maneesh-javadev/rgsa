<%@include file="../taglib/taglib.jsp"%>
<script>
var quater_id = '${QTR_ID}';
var remaining_add_req = '${REMAINING_ADD_REQ}';
var fund_allocated_by_state='${FUND_ALLOCATED_BY_STATE}';
var fund_used='${FUND_USED_IN_OTHER_QUATOR}';
if(quater_id > 2){
	var fund_allocated_in_pre_qtr = '${FUND_ALLOCATED_BY_STATE_PREVIOUS}';
	var fund_used_in_qtr_1_and_2 = '${TOTAL_FUND_USED_IN_QTR_1_AND_2}';
}

$(document).ready(function() {
	$('#quaterDropDownId').val(quater_id);
	showTablediv();
}); 

function compareFunds(indx){
	if(parseInt($('#expnditureId_'+indx).val()) > parseInt($('#fundsName_'+indx).val())){
		alert('Expenditure Incurred should be less than fund approved.');
		$('#expnditureId_'+indx).val('');
	}
} 

function saveAndGetDataQtrRprt(msg){
	  $('#showQqrtrId').val($('#quaterDropDownId').val()); 
	  $('#origin').val(msg);
	 	 document.qprAdminAndFinancialDataActivity.method = "post";
		document.qprAdminAndFinancialDataActivity.action = "adminDataFinQuaterlyGet.html?<csrf:token uri='adminDataFinQuaterlyGet.html'/>";
		document.qprAdminAndFinancialDataActivity.submit(); 
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
		<div class="block-header"></div>
		<div class="row clearfix">
			<!-- Task Info -->
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Label.AdminAndFinancialDataCell"
								htmlEscape="true" />
							Quaterly Report
						</h2>
					</div>
					<form:form method="POST" id="qprAdminAndFinancialDataActivityId"
						name="qprAdminAndFinancialDataActivity" class="form-inline"
						action="adminDataFinQuaterlyGet.html"
						modelAttribute="QPR_ADMIN_DATA_FIN">
						<input type="hidden" name="<csrf:token-name/>"
								value="<csrf:token-value uri="adminDataFinQuaterlyGet.html" />" />
						<div class="body">
							<div class="row clearfix">
								<div class="form-group">
									<div class="col-lg-2">
										<label for="QuaterId1"><strong>Quarter
												Duration :</strong></label>
									</div>
									<div align="center" class="col-lg-4">
										<select name="quarterDuration.qtrId" id="quaterDropDownId"
											onchange="saveAndGetDataQtrRprt('qtrChange');showTablediv()"
											class="form-control">
											<option value="0">Select quarter</option>
											<c:forEach items="${quarter_duration}" var="qtr">
												<option value="${qtr.qtrId}">${qtr.qtrDuration}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div id="mainDivId">
							<div class="table-responsive">
								<table class="table table-bordered" id="mytable">
									<thead>
										<tr>
											<th rowspan="2">Type of Center</th>
											<th rowspan="2">Domain Experts</th>
											<th rowspan="2">Approved No. of Staff</th>
											<th rowspan="2">Approved fund</th>
											<th rowspan="2"><div align="center">no. Of Units
													Filled</div></th>
											<th rowspan="2"><div align="center">Expenditure
													incurred</div></th>
										</tr>
									</thead>
									<tbody id="tbodyId">
										<c:forEach
											items="${CEC_APPROVED_ACTIVITY.adminFinancialDataCellActivityDetails}"
											var="obj" varStatus="index">
											<tr>
												<!-- total number of units filled in rest quaters -->
											<c:choose>
												<c:when test="${not empty DEATIL_FOR_TOTAL_NO_OF_UNIT}">
												<input type="hidden" id="totalExpenditureIncurred_${index.index}"
														value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[index.index].expenditureIncurred}" />
												
													<input type="hidden" id="totalNoOfUnit_${index.index}"
														value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[index.index].noOfUnitsFilled}" />
												</c:when>
												<c:otherwise>
													<input type="hidden" id="totalNoOfUnit_${index.index}"
														value="0" />
													<input type="hidden" id="totalExpenditureIncurred_${index.index}"
														value="0" />	
												</c:otherwise>
											</c:choose>
											<!-- ends here -->
											<td><div align="center">
													<strong>${obj.pmuActivityType.pmuType.pmuTypeName}</strong>
												</div></td>
											<td><div align="center">
													<strong>${obj.pmuActivityType.pmuActivityName}</strong>
													<input type="hidden" name="qprAdminAndFinancialDataActivityDetails[${index.index}].pmuActivityType.pmuActivityTypeId" value="${obj.pmuActivityType.pmuActivityTypeId}"/>
												</div></td>
											<td><div align="center" id="noOfUnitCecId_${index.index}">
													<strong>${obj.noOfStaffProposed}</strong>
												</div></td>
											<td><div align="center" id="fundCecId_${index.index}">
													<strong>${obj.funds}</strong>
												</div></td>
											<c:choose>
												<c:when test="${not empty ADMIN_FIN_CELL_QPR_ACT}">
												<!-- hidden field on condition  -->
													<input type="hidden" name="qprAfpId" value="${ADMIN_FIN_CELL_QPR_ACT.qprAfpId}" />
													<input type="hidden" name="qprAdminAndFinancialDataActivityDetails[${index.index}].qprAfpDetailsId" value="${ADMIN_FIN_CELL_QPR_ACT.qprAdminAndFinancialDataActivityDetails[index.index].qprAfpDetailsId}" />
												<!-- hidden field ends here -->
													<td><input type="text" maxlength="7"
														class="form-control expnditureId"
														id="noOfUnitCompleted_${index.index}"
														name="qprAdminAndFinancialDataActivityDetails[${index.index}].noOfUnitsFilled"
														value="${ADMIN_FIN_CELL_QPR_ACT.qprAdminAndFinancialDataActivityDetails[index.index].noOfUnitsFilled}"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,'');validateNoOfUnits(${index.index});" required="required" /></td>

													<td><input type="text" maxlength="7"
														class="form-control expnditureId"
														name="qprAdminAndFinancialDataActivityDetails[${index.index}].expenditureIncurred"
														id="expenditureIncurred_${index.index}" required="required"
														value="${ADMIN_FIN_CELL_QPR_ACT.qprAdminAndFinancialDataActivityDetails[index.index].expenditureIncurred}"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,'');validateFundByAllocatedFund(${index.index});validateWithCorrespondingFund(${index.index});isNoOfUnitAndExpInurredFilled(${index.index})" /></td>
												</c:when>
												<c:otherwise>
													<td><input type="text" maxlength="7"
														class="form-control expnditureId"
														id="noOfUnitCompleted_${index.index}" required="required"
														name="qprAdminAndFinancialDataActivityDetails[${index.index}].noOfUnitsFilled"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,'');validateNoOfUnits(${index.index});" /></td>

													<td><input type="text" maxlength="7"
														class="form-control expnditureId"
														name="qprAdminAndFinancialDataActivityDetails[${index.index}].expenditureIncurred"
														id="expenditureIncurred_${index.index}" required="required"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,'');validateFundByAllocatedFund(${index.index});validateWithCorrespondingFund(${index.index});isNoOfUnitAndExpInurredFilled(${index.index})" /></td>
												</c:otherwise>
											</c:choose>
											</tr>
										</c:forEach>
										<tr>
											<th colspan="2"><div align="center">Additional Requirement</div></th>
											<th colspan="3"><div align="center" id="additionalReqStateId">${CEC_APPROVED_ACTIVITY.additionalRequirement }</div></th>
											<td><input type="text" name="additionalRequirement" id="additionalReqId" value="${ADMIN_FIN_CELL_QPR_ACT.additionalRequirement}" class="form-control validate Align-Right" onkeyup="validateAddReq()"></td>
										</tr>
									</tbody>
								</table>
								<br>
							</div>
							<div class="form-group text-right" style="padding-right: 10px;">
								<button type="button" onclick="saveAndGetDataQtrRprt('save')" id="saveButtn"
									class="btn bg-green waves-effect">SAVE</button>
								<button type="button" id="clearButtn" onclick="onClear(this)"
									class="btn bg-light-blue waves-effect">CLEAR</button>
								<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-orange waves-effect">CLOSE</button>
							</div>
						</div>
						<br />
						<!-- hidden fields -->
						<input type="hidden" name="showQqrtrId" id="showQqrtrId">
						<input type="hidden" id="origin" name="origin" />
						<input type="hidden" name="adminAndFinancialDataActivity.adminFinancialDataActivityId" value="${CEC_APPROVED_ACTIVITY.adminFinancialDataActivityId}">
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>

