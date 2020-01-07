<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script>
var  quator_id='${quarterId}';
var remaining_add_req = '${REMAINING_ADD_REQ}';
var qtr_1_2_filled='${QTR_ONE_TWO_FILLED}';
var fund_allocated_by_state='${FUND_ALLOCATED_BY_STATE}';
if(quator_id > 2){
	var fund_allocated_in_pre_qtr = '${FUND_ALLOCATED_BY_STATE_PREVIOUS}';
	var fund_used_in_qtr_1_and_2 = '${TOTAL_FUND_USED_IN_QTR_1_AND_2}';
}
var fund_used='${FUND_USED_IN_OTHER_QUATOR}';
$( document ).ready(function() {
	
	
	var rowCount=$('#tbodyId tr').length -2;
	
	for( var i=0;i < rowCount; i++){
		
			$("#enablement_"+i).val($("#enablementStatus_"+i).val());
		
	}
	
	
	if(qtr_1_2_filled == "false"){
		alert('Please fill the quater 1 and 2 progress report first.');
	}
	$('#quaterId').val(quator_id);
	calTotalExpenditure();
	$(".validate").keypress(function (e) {
	    //if the letter is not digit then display error and don't type anything
	    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	       //display error message
	       $("#errmsg").html("Digits Only").show().fadeOut("slow");
	              return false;
	   }
	  });
	
	if(quator_id != null && quator_id != '' && quator_id != 0){
		showDistrictDropDown();
	}else{
		$('#mainDivId').css({"display":"none"});
	}
});

function saveAndGetDataQtrRprt(msg){
	 var districtId = $('#districtId').val();
	 var quaterId = $('#quaterId').val();
	 var flag=true;
	 $('#districtId').val(districtId);
	 $('#qrtId').val(quaterId);
	 $('#origin').val(msg);
	 	document.qprEnablement.method = "post";
		document.qprEnablement.action = "enablementQuaterlySave.html?<csrf:token uri='enablementQuaterlySave.html'/>";
		if(msg == 'save'){
			for (var index = 0; index < (+$("#tbodyId tr").length -2); index++) {
				if($('#expenditureIncurred_'+index).val() == "" || $('#expenditureIncurred_'+index).val() == null){
					flag=false;
					break;
				}
			}
		}
		flag ? document.qprEnablement.submit() : alert("Expenditure Incurred should not be blank."); 
}

function showDistrictDropDown(){
	$('#mainDivId').css({"display":"block"});
}

function validateFundByAllocatedFund(obj){
	var noOfRows=$("#tbodyId tr").length -2;
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
			alert('Total expenditure should not exceed total fund allocted by state for this component which is Rs. '+ fund_allocated_by_state_local);
		}
		$('#expenditureIncurred_'+obj).val('');
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
	var componentId=5;
	var qprActivityId=$('#qprActivityId').val();
	var quaterId = $('#quaterId').val();
	document.qprEnablement.method = "post";
	document.qprEnablement.action = "freezeAndUnfreezeReport.html?<csrf:token uri='freezeAndUnfreezeReport.html'/>&componentId="+componentId+"&qprActivityId="+qprActivityId+"&quaterId="+quaterId+"&msg="+msg;
	document.qprEnablement.submit();
}
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>e-Enablement Quarter Progress Report</h2>
					</div>
					<form:form method="post" name="qprEnablement"
						action="enablementQuaterly.html" modelAttribute="Enablement">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="enablementQuaterly.html" />" />
						<div class="body">

							<c:set var="count" value="0" scope="page" />
							<div class="row clearfix">
								<div class="form-group">
									<div class="col-lg-2">
										<label for="QuaterId1"><strong>Quarter
												Duration :</strong></label>
									</div>
									<div align="center" class="col-lg-4">
										<select id="quaterId" name="quarterDuration.qtrId"
											class="form-control" onchange="showDistrictDropDown()" >
											<option value="0">Select</option>
											<c:choose>
												<c:when test="${not empty Qpr_Enablement}">
													<c:forEach items="${QUATER_DETAILS}" var="duration">
														<c:choose>
															<c:when
																test="${duration.qtrId == Qpr_Enablement.quarterDuration.qtrId}">
																<option value="${duration.qtrId}" selected="selected">${duration.qtrDuration}
																</option>
															</c:when>
															<c:otherwise>
																<option value="${duration.qtrId}">${duration.qtrDuration}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</c:when>
												<c:when test="${not empty SetNewQtrId1}">
											
													<c:forEach items="${QUATER_DETAILS}" var="duration">
														<c:choose>
															<c:when test="${duration.qtrId == SetNewQtrId1}">
																<option value="${duration.qtrId}" selected="selected">${duration.qtrDuration}
																</option>
															</c:when>
															<c:otherwise>
																<option value="${duration.qtrId}">${duration.qtrDuration}
																</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<c:forEach items="${QUATER_DETAILS}" var="duration">
														<option value="${duration.qtrId}">${duration.qtrDuration}
														</option>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</select>
									</div>
								</div>
							</div>
							
							<div class="row clearfix">
								<div class="form-group" id="districtDropDownId">
									<div class="col-lg-2">
										<label for="QuaterId1"><strong>District :</strong></label>
									</div>
									<div align="center" class="col-lg-4">
										<select class="form-control" name="districtId"
											onchange="saveAndGetDataQtrRprt();" id="districtId"
											>
											<option value="">Select</option>
											
												<c:forEach items="${LGD_DISTRICT}" var="district">
													<c:choose>
														<c:when
															test="${district.districtCode == eEnablementReportDto[0].districtCode}">
															<option value="${district.districtCode}"
																selected="selected">${district.districtNameEnglish}</option>
														</c:when>

														<c:otherwise>
															<option value="${district.districtCode}">${district.districtNameEnglish}</option>
														</c:otherwise>
													</c:choose>
												</c:forEach>
										</select>
									</div>
								</div>
							</div>
							<br>
							<div id="mainDivId" style="display: none">
							<c:choose>
							<c:when test="${not empty eEnablementReportDto}">
							
							<br>
							<c:choose>
								<c:when test="${approved}">
									<table class="table table-bordered">
										<thead>
											<tr>
												<th>
													<div align="center">
														<strong>GP Name</strong>
													</div>
												</th>
												
												<!-- <th>
													<div align="center">
														<strong>No. of units Sanctioned</strong>
													</div>
												</th> -->
				
												<th>
													<div align="center">
														<strong>Amount Sanctioned</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Expenditure Incurred(in Rs.)</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Status</strong>
													</div>
												</th>
											</tr>
										</thead>
										<tbody id="tbodyId">
											<c:set var="count" value="0" scope="page" />
											<c:choose>
												<c:when test="${not empty Qpr_Enablement}">
													<c:forEach items="${EnablementDtlsList}" var="obj"
														varStatus="count">

																	<!-- total number of units filled in rest quaters -->
																	<c:choose>
																		<c:when
																			test="${not empty DEATIL_FOR_TOTAL_NO_OF_UNIT}">
																			<input type="hidden"
																				id="totalExpenditureIncurred_${count.index}"
																				value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[count.index].expenditureIncurred}" />

																			<%-- <input type="hidden"
																				id="totalNoOfUnit_${count.index}"
																				value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[count.index].noOfUnitCompleted}" /> --%>
																		</c:when>
																		<c:otherwise>
																		<%-- 	<input type="hidden"
																				id="totalNoOfUnit_${count.index}" value="0" /> --%>
																			<input type="hidden"
																				id="totalExpenditureIncurred_${count.index}"
																				value="0" />
																		</c:otherwise>
																	</c:choose>
																	<!-- ends here -->

																	<input type="hidden" name="eEnablement.eEnablementId"
															value="${Qpr_Enablement.eEnablement.eEnablementId}">
														 <input type="hidden" name="qprEEnablementId"
															value="${Qpr_Enablement.qprEEnablementId}" id="qprActivityId"> 
														<input type="hidden"
															name="qprEnablementDetails[${count.index}].qprEEenablementDetailsId"
															value="${EnablementDtlsList[count.index].qprEEenablementDetailsId}">
														<input type="hidden"
															name="qprEnablementDetails[${count.index}].localBodyCode"
															value="${EnablementDtlsList[count.index].localBodyCode}">
															<input type="hidden" id="enablementStatus_${count.index}"
															
															value="${EnablementDtlsList[count.index].enablementStatus}">
															
														<tr>
															<td><div align="center"><strong>${eEnablementReportDto[count.index].localBodyNameEnglish}</strong></div></td>
															<%-- <td><div align="center" id="noOfUnitCecId_${count.index}"><strong>${eEnablementReportDto[count.index].noOfUnit}</strong></div></td> --%>
															<td><div align="center" id="fundCecId_${count.index}"><strong>${eEnablementReportDto[count.index].unitCost}</strong></div></td>

															<td><form:input class="form-control Align-Right"
																path="qprEnablementDetails[${count.index}].expenditureIncurred"
																value="${obj.expenditureIncurred}"
																onkeyup="validateFundByAllocatedFund(${count.index});validateWithCorrespondingFund(${count.index});calTotalExpenditure()"
																id="expenditureIncurred_${count.index}" required="required" readonly="${Qpr_Enablement.isFreeze}" /></td>
																
																<td><form:select id="enablement_${count.index}"  path ="qprEnablementDetails[${count.index}].enablementStatus" readonly="${Qpr_Enablement.isFreeze}"  class="form-control">
																<option value="-1">select</option>
															
                                                                   <option value="1">Tendering process</option>
                                                                     <option value="2">Computer procured</option>
                                                                    <option value="3">GP Computerized</option>
                                                                     
                                                                        </form:select></td>
														</tr>
													</c:forEach>
													<tr>
														<th><div align="center">Additional Requirement</div></th>
														<th><div align="center" id="additionalReqStateId">${eEnablementsApproved.additionalRequirement }</div></th>
														<td><form:input path="additionalRequirement" id="additionalReqId" value="${Qpr_Enablement.additionalRequirement}" class="form-control validate Align-Right" onkeyup="validateAddReq();calTotalExpenditure()" readonly="${Qpr_Enablement.isFreeze}" /></td>
													</tr>

																<tr>
																	<th><div align="center">Total
																			Expenditure Incurred</div></th>
																	<td></td>
																	<td><input type="text" id="totalExpenditureId"
																		class="form-control validate Align-Right"
																		disabled="disabled" /></td>
																</tr>
															</c:when>
												<c:when test="${not empty eEnablementReportDto}">
													<c:forEach items="${eEnablementReportDto}" var="localbody"
														varStatus="count">
														<!-- total number of units filled in rest quaters -->
																	<c:choose>
																		<c:when
																			test="${not empty DEATIL_FOR_TOTAL_NO_OF_UNIT}">
																			<input type="hidden"
																				id="totalExpenditureIncurred_${count.index}"
																				value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[count.index].expenditureIncurred}" />

																		<%-- 	<input type="hidden"
																				id="totalNoOfUnit_${count.index}"
																				value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[count.index].noOfUnitCompleted}" /> --%>
																		</c:when>
																		<c:otherwise>
																			<%-- <input type="hidden"
																				id="totalNoOfUnit_${count.index}" value="0" /> --%>
																			<input type="hidden"
																				id="totalExpenditureIncurred_${count.index}"
																				value="0" />
																		</c:otherwise>
																	</c:choose>
																	<!-- ends here -->
														<input type="hidden" name="eEnablement.eEnablementId"
															value="${idEEnablement}">
														<input type="hidden" name="qprEEnablementId"
															value="${fetchQprEnablementId.qprEEnablementId}" id="qprActivityId">	
														<input type="hidden"
															name="qprEnablementDetails[${count.index}].localBodyCode"
															value="${localbody.localBodyCode}">
														<input type="hidden"
															name="qprEnablementDetails[${count.index}].qprEEenablementDetailsId"
															value="${Qpr_Enablement.qprEnablementDetails[count.index].qprEEenablementDetailsId}">

														<tr>
															<td><div align="center"><strong>${localbody.localBodyNameEnglish}</strong></div>
															</td>
															<%-- <td><div align="center" id="noOfUnitCecId_${count.index}"><strong>${localbody.noOfUnit}</strong></div></td> --%>
															<td><div align="center" id="fundCecId_${count.index}"><strong>${localbody.unitCost}</strong></div></td>
															<td><input
																class="form-control Align-Right"
																name="qprEnablementDetails[${count.index}].expenditureIncurred"
																onkeyup="validateFundByAllocatedFund(${count.index});validateWithCorrespondingFund(${count.index});calTotalExpenditure()"
																id="expenditureIncurred_${count.index}"
																required="required"  /></td>
																<td><select name ="qprEnablementDetails[${count.index}].enablementStatus" class="form-control">
																<option value="-1">select</option>
                                                                   <option value="1">Tendering process</option>
                                                                     <option value="2">Computer procured</option>
                                                                    <option value="3">GP Computerized</option>
                                                                      
                                                                        </select></td>
														</tr>
													</c:forEach>
													<tr>
														<th>Additional Requirement</th>
														<th id="additionalReqStateId"><div align="center">${eEnablementsApproved.additionalRequirement }</div></th>
														<td><form:input path="additionalRequirement" id="additionalReqId" value="${Qpr_Enablement.additionalRequirement}" class="form-control validate Align-Right" onkeyup="validateAddReq();calTotalExpenditure()" readonly="${Qpr_Enablement.isFreeze}"/></td>
													</tr>

																<tr>
																	<th><div align="center">Total
																			Expenditure Incurred</div></th>
																			<td></td>
																	<td><input type="text" id="totalExpenditureId"
																		class="form-control validate Align-Right"
																		disabled="disabled" /></td>
																</tr>
															</c:when>
											<%-- 	<c:otherwise>
													<div class="form-group">
														<div align="center" class="Alert">
															<i class="fa fa-meh-o fa-lg" aria-hidden="true"></i><span>
																Oops! Fund is not allocated for this component.</span><br />
														</div>
													</div>
												</c:otherwise> --%>
											</c:choose>
										</tbody>
									</table>
								</c:when>
								<c:otherwise>
									<div class="alert alert-danger">
										<strong>Danger!</strong> No Gps. Record Avaliable of that
										district"
									</div>
								</c:otherwise>
							</c:choose>
							</c:when>
							<c:otherwise><%-- <c:when test="${not empty eEnablementReportDto}">
									<div class="form-group">
										<div align="center" class="Alert">
											<i class="fa fa-meh-o fa-lg" aria-hidden="true"></i><span>
												Oops! No record is available for this district.</span><br />
										</div>
									</div>
									</c:when> --%>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${not empty eEnablementReportDto}">
									<div class="text-right">
										<form:button onclick="saveAndGetDataQtrRprt('save')" class="btn bg-green waves-effect" disabled="${Qpr_Enablement.isFreeze}">
											SAVE</form:button>
										<c:choose>
											<c:when test="${Qpr_Enablement.isFreeze}"><form:button class="btn bg-orange waves-effect" onclick="FreezeAndUnfreeze('unfreeze')">UNFREEZE</form:button></c:when>
											<c:otherwise><form:button class="btn bg-orange waves-effect" disabled="${DISABLE_FREEZE}" onclick="FreezeAndUnfreeze('freeze')">FREEZE</form:button></c:otherwise>
										</c:choose>	
										<form:button onclick="onClear(this)"
											class="btn bg-light-blue waves-effect" disabled="${Qpr_Enablement.isFreeze}">CLEAR</form:button>
										<form:button
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">CLOSE</form:button>
									</div>
								</c:when>
								<c:otherwise>
									<div class="text-right">
										<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">CLOSE</button>
									</div>
								</c:otherwise>
							</c:choose>
							</div>
						</div>
						<input type="hidden" id="districtId" name="districtId" value='' />
						<input type="hidden" id="qrtId" name="qrtId" value='' />
						<input type="hidden" id="origin" name="origin" />
					</form:form>
				</div>

			</div>
		</div>
	</div>
</section>
<style>
.Align-Right{
			text-align: right;
}

.Alert {
	font-size: x-large;
	color: red;
	background-color: #fbeeed;
	border-color: #f7d8dd;
	padding-top: 5%;
	padding-bottom: 5%;
}
</style>
