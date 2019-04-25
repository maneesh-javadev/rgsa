<%@include file="../taglib/taglib.jsp"%>
<script>
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
});

function showTablediv(){
	if($('#quaterDropDownId').val() > 0){
		$('#mainDivId').show();
	}else{
		$('#mainDivId').hide();
	}
}

function getSelelctedQtrRprt(){
	$('#quaterTransient').val($('#quaterDropDownId').val()); 
 	document.innovativeActivity.method = "get";
	document.innovativeActivity.action = "innovativeActivityQpr.html?<csrf:token uri='innovativeActivityQpr.html'/>";
	document.innovativeActivity.submit(); 
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
												onchange="getSelelctedQtrRprt();showTablediv()">
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
												<tr>
													<td><div align="center"><strong>${index.index + 1}. </strong></div></td>
													<td><div align="center"><strong>${cecDetailsData.activityName}</strong></div></td>
													<td><div align="center"><strong>${cecDetailsData.fundsName}</strong></div></td>
													<td><div align="center">
													<c:choose>
														<c:when test="${not empty QPR_INNOVATIVE_ACTIVITY}">
															<input type="text" class="form-control" name="qprInnovativeActivityDetails[${index.index}].expenditureIncurred" id="expenditureIncurred_${index.index}" value="${QPR_INNOVATIVE_ACTIVITY.qprInnovativeActivityDetails[index.index].expenditureIncurred}" onkeyup="validateFundByAllocatedFund(${index.index})" />
														</c:when>
														<c:otherwise>
															<input type="text" class="form-control" name="qprInnovativeActivityDetails[${index.index}].expenditureIncurred" id="expenditureIncurred_${index.index}" onkeyup="validateFundByAllocatedFund(${index.index})"/>
														</c:otherwise>
													</c:choose>
													</div></td>
												</tr>
												<!-- HIDDEN FIELDS -->
													<input type="hidden" name="qprInnovativeActivityDetails[${index.index}].qprIaDetailsId" value="${QPR_INNOVATIVE_ACTIVITY.qprInnovativeActivityDetails[index.index].qprIaDetailsId}" />
											</c:forEach>
											</tbody>
										</table>
									</div>
									<div class="form-group text-right" style="padding-right: 10px;">
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
							<input type="hidden" id="quaterTransient" name="qtrId" />
							<input type="hidden" name="qprIaId" value="${QPR_INNOVATIVE_ACTIVITY.qprIaId}" />
							<input type="hidden" name="innovativeActivity.innovativeActivityId" value="${CEC_APPROVED_ACTIVITY.innovativeActivityId}" />
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>