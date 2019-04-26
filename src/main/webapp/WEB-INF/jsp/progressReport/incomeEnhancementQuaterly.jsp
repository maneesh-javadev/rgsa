<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript">
var quater_id = '${QTR_ID}';
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

function getSelelctedQtrRprt(){
	$('#quaterTransient').val($('#quaterDropDownId').val()); 
 	document.incomeEnhancement.method = "get";
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
													class="form-control" onchange="getSelelctedQtrRprt();showTablediv()">
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
											<th rowspan="2"><div align="center">Fund Approved (in Rs.)</div></th>
											<th rowspan="2"><div align="center">Expenditure incurred</div></th>
										</tr>
									</thead>
									<tbody id="tbodyId">
										<c:forEach items="${CEC_APPROVED_ACTIVITY.incomeEnhancementDetails}" var="obj" varStatus="index">
										<input type="hidden" name="qprIncomeEnhancementDetails[${index.index}].incomeEnhancementDetails.incomeEnhancementDetailsId"
												value="${obj.incomeEnhancementDetailsId}" />
										<input type="hidden" name="qprIncomeEnhancementDetails[${index.index}].qprIncomeEnhancementDetailsId"
												value="${QPR_ENHANCEMENT.qprIncomeEnhancementDetails[index.index].qprIncomeEnhancementDetailsId}" />		
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
										<td><div align="center"><strong>${obj.fundsRequired}</strong></div></td>
										<td> <div align="center">
											<c:choose>
												<c:when test="${not empty QPR_ENHANCEMENT}">
													<input type="text" maxlength="8"
														class="form-control expnditureId"
														id="expenditureIncurred_${index.index}"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,'');validateFundByAllocatedFund(${index.index})"
														name="qprIncomeEnhancementDetails[${index.index}].expenditureIncurred"
														value="${QPR_ENHANCEMENT.qprIncomeEnhancementDetails[index.index].expenditureIncurred}" required="required"/>
												</c:when>
												<c:otherwise>
													<input type="text" maxlength="8"
														class="form-control expnditureId"
														id="expenditureIncurred_${index.index}"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,'');validateFundByAllocatedFund(${index.index})"
														name="qprIncomeEnhancementDetails[${index.index}].expenditureIncurred" required="required"/>
												</c:otherwise>
											</c:choose></div>
										</td>
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
								<div class="form-group text-right">
									<button type="submit" id="saveButtn"
										class="btn bg-green waves-effect">SAVE</button>
									<button type="button" id="clearButtn" onclick="onClear(this)"
										class="btn bg-light-blue waves-effect">CLEAR</button>
									<button type="button"
										onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-orange waves-effect">CLOSE</button>
								</div>
							</div>
						</div>
						
						<!-- HIDDEN FIELDS -->
						<input type="hidden" name="incomeEnhancementActivity.incomeEnhancementId" value="${CEC_APPROVED_ACTIVITY.incomeEnhancementId}" />
						<input type="hidden" name="qprIncomeEnhancementId" value="${QPR_ENHANCEMENT.qprIncomeEnhancementId}" />
						<input type="hidden" name="qprPmuId" value="${QPR_ENHANCEMENT.qprIncomeEnhancementId}" />
						<input type="hidden" id="quaterTransient" name="showQqrtrId" />
					</form:form>
				</div>
			</div>
		</div>
		<!-- #END# Task Info -->
	</div>
</section>
