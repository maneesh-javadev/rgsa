<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript">
var quater_id = '${QTR_ID}';
var remaining_add_req = '${REMAINING_ADD_REQ}';
var qtr_1_2_filled='${QTR_ONE_TWO_FILLED}';
var fund_allocated_by_state='${FUND_ALLOCATED_BY_STATE}';
var fund_used='${FUND_USED_IN_OTHER_QUATOR}';
if(quater_id > 2){
	var fund_allocated_in_pre_qtr = '${FUND_ALLOCATED_BY_STATE_PREVIOUS}';
	var fund_used_in_qtr_1_and_2 = '${TOTAL_FUND_USED_IN_QTR_1_AND_2}';
}
$(document).ready(function() {
	if(qtr_1_2_filled == "false"){
		alert('Please fill the quater 1 and 2 progress report first.');
	}
	$('#quaterDropDownId').val(quater_id);
	showTablediv();
	calTotalExpenditure();
}); 

function saveAndGetDataQtrRprt(msg){
	$('#quaterTransient').val($('#quaterDropDownId').val()); 
	$('#origin').val(msg);
 	document.incomeEnhancement.method = "post";
	document.incomeEnhancement.action = "incomeEnhancementQuaterly.html?<csrf:token uri='incomeEnhancementQuaterly.html'/>";
	document.incomeEnhancement.submit(); 
}

function showTablediv(){
	if($('#quaterDropDownId').val() > 0){
		$('#mainDivId').show();
	}else{
		$('#mainDivId').hide();
	}
}

function validateAddReq(){
	if(+$('#additionalReqId').val() > +remaining_add_req){
		alert('Additional requirementshould not exceed : ' + remaining_add_req);
		$('#additionalReqId').val('');
		$('#additionalReqId').focus();
	}
}
function validateFundByAllocatedFund(obj){
	var noOfRows=$("#tbodyId tr").length -1;
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
	var componentId=10;
	var qprActivityId=$('#qprActivityId').val();
	var quaterId = $('#quaterDropDownId').val();
	document.incomeEnhancement.method = "post";
	document.incomeEnhancement.action = "freezeAndUnfreezeReport.html?<csrf:token uri='freezeAndUnfreezeReport.html'/>&componentId="+componentId+"&qprActivityId="+qprActivityId+"&quaterId="+quaterId+"&msg="+msg;
	document.incomeEnhancement.submit();
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
						<h2>Income Enhancement Quaterly Report</h2>
					</div>
					<form:form method="POST" id="incomeEnhancementId"
						name="incomeEnhancement" class="form-inline"
						action="incomeEnhancementQuaterly.html"
						modelAttribute="QPR_INCOME_ENHANCEMENT">
						<input type="hidden" name="<csrf:token-name/>"
								value="<csrf:token-value uri="incomeEnhancementQuaterly.html"/>" />
						<div class="body">
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
							<div class="table-responsive">
								<table class="table table-bordered table-hover" id="mytable">
									<thead>
										<tr>
											<th rowspan="2"><div align="center">S.No.</div></th>
											<th rowspan="2"><div align="center">Name of Activity</div></th>
											<th rowspan="2"><div align="center">District Name</div></th>
											<th rowspan="2"><div align="center">Fund Sanctioned</div></th>
											<th rowspan="2"><div align="center">Expenditure incurred</div></th>
										</tr>
									</thead>
									<tbody id="tbodyId">
										<c:forEach items="${CEC_APPROVED_ACTIVITY.incomeEnhancementDetails}" var="obj" varStatus="index">
										<input type="hidden" name="qprIncomeEnhancementDetails[${index.index}].incomeEnhancementDetails.incomeEnhancementDetailsId"
												value="${obj.incomeEnhancementDetailsId}" />
										<input type="hidden" name="qprIncomeEnhancementDetails[${index.index}].qprIncomeEnhancementDetailsId"
												value="${QPR_ENHANCEMENT.qprIncomeEnhancementDetails[index.index].qprIncomeEnhancementDetailsId}" />		
										<!-- total number of units filled in rest quaters -->
											<c:choose>
												<c:when test="${not empty DEATIL_FOR_TOTAL_NO_OF_UNIT}">
												<input type="hidden" id="totalExpenditureIncurred_${index.index}"
														value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[index.index].expenditureIncurred}" />
													
												</c:when>
												<c:otherwise>
													<input type="hidden" id="totalExpenditureIncurred_${index.index}"
														value="0" />	
												</c:otherwise>
											</c:choose>
											<!-- ends here -->
										<tr>
										<td><div align="center"><strong>${index.count}. </strong></div></td>
										<td><div align="center"><strong>${obj.activtyName}</strong></div></td>
										<td>
											<c:forEach items="${DISTRICT_LIST}" var="district">
												<c:if test="${obj.districtCode eq district.districtCode}">
													<div align="center"><strong>${district.districtNameEnglish }</strong></div>
												</c:if>
											</c:forEach>
										</td>
										<td><div align="center" id="fundCecId_${index.index}"><strong>${obj.fundsRequired}</strong></div></td>
										<td> <div align="center">
											<c:choose>
												<c:when test="${not empty QPR_ENHANCEMENT}">
													<form:input maxlength="8"
														class="form-control expnditureId"
														id="expenditureIncurred_${index.index}"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,'');validateFundByAllocatedFund(${index.index});validateWithCorrespondingFund(${index.index});calTotalExpenditure()"
														path="qprIncomeEnhancementDetails[${index.index}].expenditureIncurred"
														value="${QPR_ENHANCEMENT.qprIncomeEnhancementDetails[index.index].expenditureIncurred}" style="text-align: right;" readonly="${QPR_ENHANCEMENT.isFreeze}"/>
												</c:when>
												<c:otherwise>
													<input type="text" maxlength="8"
														class="form-control expnditureId"
														id="expenditureIncurred_${index.index}"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,'');validateFundByAllocatedFund(${index.index});validateWithCorrespondingFund(${index.index});calTotalExpenditure()"
														name="qprIncomeEnhancementDetails[${index.index}].expenditureIncurred" style="text-align: right;"/>
												</c:otherwise>
											</c:choose></div>
										</td>
										</tr>
										</c:forEach>
										<tr>
											<th colspan="2"><div align="center">Additional Requirement</div></th>
											<th colspan="2"><div align="center" id="additionalReqStateId">${CEC_APPROVED_ACTIVITY.additionalRequirement }</div></th>
											<td><div align="center"><form:input path="additionalRequirement" id="additionalReqId" style="text-align: right;" value="${QPR_ENHANCEMENT.additionalRequirement}" class="form-control validate Align-Right" onkeyup="validateAddReq();calTotalExpenditure()" readonly="${QPR_ENHANCEMENT.isFreeze}" /></div></td>
										</tr>
										<tr>
											<th colspan="2"><div align="center">Total Expenditure Incurred</div></th>
											<td colspan="2"></td>
											<td><div align="center"><input type="text" id="totalExpenditureId" style="text-align: right;" class="form-control validate Align-Right" disabled="disabled" /></div></td>
										</tr>
									</tbody>
								</table>
							</div>
								<div class="form-group text-right">
									<form:button id="saveButtn"
										class="btn bg-green waves-effect" onclick="saveAndGetDataQtrRprt('save')" disabled="${QPR_ENHANCEMENT.isFreeze}">SAVE</form:button>
									<c:choose>
										<c:when test="${QPR_ENHANCEMENT.isFreeze}"><form:button class="btn bg-orange waves-effect" onclick="FreezeAndUnfreeze('unfreeze')">UNFREEZE</form:button></c:when>
										<c:otherwise><form:button class="btn bg-orange waves-effect" disabled="${DISABLE_FREEZE}" onclick="FreezeAndUnfreeze('freeze')">FREEZE</form:button></c:otherwise>
									</c:choose>	
									<form:button id="clearButtn" onclick="onClear(this)"
										class="btn bg-light-blue waves-effect" disabled="${QPR_ENHANCEMENT.isFreeze}">CLEAR</form:button>
									<button type="button"
										onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-red waves-effect">CLOSE</button>
								</div>
							</div>
						</div>
						
						<!-- HIDDEN FIELDS -->
						<input type="hidden" name="incomeEnhancementActivity.incomeEnhancementId" value="${CEC_APPROVED_ACTIVITY.incomeEnhancementId}" />
						<input type="hidden" name="qprIncomeEnhancementId" id="qprActivityId" value="${QPR_ENHANCEMENT.qprIncomeEnhancementId}" />
						<input type="hidden" name="qprPmuId" value="${QPR_ENHANCEMENT.qprIncomeEnhancementId}" />
						<input type="hidden" id="quaterTransient" name="showQqrtrId" />
						<input type="hidden" id="origin" name="origin" />
					</form:form>
				</div>
			</div>
		</div>
		<!-- #END# Task Info -->
	</div>
</section>
