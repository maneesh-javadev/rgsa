<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script>
$( document ).ready(function() {
	calculateTotalCost();
	calculateTotalProposedFund();
	calculateTotalProposedFundForState();
	onloadChangeColor();
});


function calculateTotalProposedFundForState(){
		$("#stateGrandTotalId").text(parseInt($("#stateTotalCost").text()) + parseInt($("#stateAdditionalRequirementId").text()));
	}



function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

function validateMonth(obj){
	if($("#noOfMonthsId_"+obj).val() < 1 || $("#noOfMonthsId_"+obj).val() > 12){
		alert("Month should not be less than 1 or greater than 12.");
		$("#noOfMonthsId_"+obj).val('');
	}
}

function calculateFund(obj){
	if($("#fundId_"+obj).val()==""){var fund=0;}
	if($("#noOfMonthsId_"+obj).val() !=""  && $("#noOfStaffId_"+obj).val() !="" && $("#unitCostId_"+obj).val() !=""){
		fund=parseInt($("#noOfMonthsId_"+obj).val())*parseInt($("#noOfStaffId_"+obj).val())*parseInt($("#unitCostId_"+obj).val());
	}
	$("#fundId_"+obj).val(fund);
	calculateTotalCost();
	/* calculateSubTotal(obj); */
}

function calculateSubTotal(obj){
	$("#subTotalId_"+obj).val(parseInt($("#fundId_"+obj).val()));
	 /* calculateTotalCost(); */
}

function calculateTotalCost(){
	var count = $("#count").val();
	var total_cost=0;
	 for(var i=0;i<count; i++){
		total_cost += +document.getElementById("fundId_"+i).value;
	} 
	document.getElementById("TotalCostId").value=total_cost;
	calculateTotalProposedFund();
	validateAdditionalRequirement()
	onloadChangeColor();
}

function validateAdditionalRequirement(){
	if($("#TotalCostId").val() != ""){
		if($("#additionalRequirementId").val() >0.25 * (parseInt($("#TotalCostId").val()))){
			alert("Additional Requirement should be less than 25% of Total Cost. : "+ 0.25 * (parseInt($("#TotalCostId").val())));
			$("#additionalRequirementId").val('');
			calculateTotalProposedFund();
		}
		calculateTotalProposedFund();
		onloadChangeColor();
	}
}

function calculateTotalProposedFund(){
	if($("#additionalRequirementId").val() == "" || $("#TotalCostId").val() == ""){
		if($("#additionalRequirementId").val() == ""){
			$("#GrandTotalId").val(parseInt($("#TotalCostId").val()) + 0);
		}else{
			$("#GrandTotalId").val(parseInt($("#additionalRequirementId").val()) + 0);
		}
		
	}else{
		$("#GrandTotalId").val(parseInt($("#TotalCostId").val()) + parseInt($("#additionalRequirementId").val()));
	}
}

function isFreezeFunction(obj){
	if(obj == "freeze"){
		$("#isFreeze").val(true);
	}else{
		$("#isFreeze").val(false);
	}
}



function validatingTotalProposedFund(){
	if($("#GrandTotalId").val() > 600000 ){
		alert("Total Proposed amount should not be more than 6 lakhs");
		return false;
	}else{
		return true;
	}
}


	function onloadChangeColor(){
		var noOfRowCount = $('#tbody tr').length-3;
		for(var i= 0; i<noOfRowCount ;i++){
		
	+$("#noOfStaffId_"+i).val() < +$("#noOfStaffIdMopr_"+i).text() ? $("#noOfStaffIdMopr_"+i).css("color","red") : $("#noOfStaffIdMopr_"+i).css("color","#00cc00");
	+$("#fundId_"+i).val() < +$("#fundIdMopr_"+i).text() ? $("#fundIdMopr_"+i).css("color","red") : $("#fundIdMopr_"+i).css("color","#00cc00");
	+$("#noOfMonthsId_"+i).val() < +$("#noOfMonthsIdMopr_"+i).text() ? $("#noOfMonthsIdMopr_"+i).css("color","red") : $("#noOfMonthsIdMopr_"+i).css("color","#00cc00");
	+$("#unitCostId_"+i).val() < +$("#unitCostIdMopr_"+i).text() ? $("#unitCostIdMopr_"+i).css("color","red") : $("#unitCostIdMopr_"+i).css("color","#00cc00");
}
		+$("#additionalRequirementIdMopr").text() > +$("#additionalRequirementId").val() ? $("#additionalRequirementIdMopr").css('color','red') : $("#additionalRequirementIdMopr").css('color','#00cc00');
		+$("#TotalCostIdMopr").text() > +$("#TotalCostId").val() ? $("#TotalCostIdMopr").css('color','red') : $("#TotalCostIdMopr").css('color','#00cc00');
		+$("#GrandTotalIdMopr").text() > +$("#GrandTotalId").val() ? $("#GrandTotalIdMopr").css('color','red') : $("#GrandTotalIdMopr").css('color','#00cc00');

	}
	

</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Label.AdminAndFinancialDataCell"
								htmlEscape="true" />
							(CEC)
						</h2>
					</div>
					<form:form method="post" name="adminFinancialDataCell"
						action="adminAndFinancialDataCell.html"
						modelAttribute="ADMIN_FIN_DATA_CELL"
						onsubmit="return validatingTotalProposedFund();disablingSave()">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="adminAndFinancialDataCell.html" />" />
						
							<ul class="nav nav-tabs">
								<li class="nav-item"><a class="nav-link active"
									data-toggle="tab" href="#state"><spring:message
											code="Label.STATE" htmlEscape="true" /></a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab"
									href="#MOPR"><spring:message code="Label.MOPR"
											htmlEscape="true" /></a></li>
							</ul>

							<div class="tab-content">
								<div role="tabpanel" class="container tab-pane active"
									id="MOPR" style="width: auto;">
									<div class="table-responsive">
										<table class="table table-bordered">
											<thead>

												<tr>
													<th>
														<div align="center">
															<strong><spring:message
																	code="Label.TypeOfCenter" htmlEscape="true" /></strong>
														</div>
													</th>

													<th>
														<div align="center">
															<strong><spring:message
																	code="Label.DomainExperts" htmlEscape="true" /></strong>
														</div>
													</th>
													<th>
														<div align="center">
															<strong><spring:message
																	code="Label.NoOfStaffProposed" htmlEscape="true" /><br>(A)</strong>
														</div>
													</th>
													<th>
														<div align="center">
															<strong><spring:message code="Label.UnitCost"
																	htmlEscape="true" /><br>(B)</strong>
														</div>
													</th>
													<th>
														<div align="center">
															<strong><spring:message code="Label.NoOfMonths"
																	htmlEscape="true" /><br>(C)</strong>
														</div>
													</th>
													<th>
														<div align="center">
															<strong><spring:message code="Label.Funds"
																	htmlEscape="true" /><br>D= (A*B*C)</strong>
														</div>
													</th>


													<th>
														<div align="center">
															<strong><spring:message code="Label.Remarks"
																	htmlEscape="true" /></strong>
														</div>
													</th>
												</tr>
											</thead>
											<tbody id=tbody>

												<c:forEach items="${ACTIVITY_TYPE}" var="activity"
													varStatus="index">
													<c:if test="${activity.pmuType.pmuTypeId eq 1}">
														<form:hidden
															path="adminFinancialDataCellActivityDetails[${index.index}].pmuActivityType.pmuActivityTypeId"
															value="${activity.pmuActivityTypeId} " />
														<form:hidden
															path="adminFinancialDataCellActivityDetails[${index.index}].adminFinancialDataActivityDetailId" />
														<tr>
															<td><div align="center">
																	<strong>${activity.pmuType.pmuTypeName}</strong>
																</div></td>
															<td><div align="center">
																	<strong>${activity.pmuActivityName}</strong>
																</div></td>
															<td><div align="center" id="noOfStaffIdMopr_${index.index}">${activityDetailsForMopr[index.index].noOfStaffProposed}</div>
															<form:input
																	path="adminFinancialDataCellActivityDetails[${index.index}].noOfStaffProposed"
																	type="text" maxlength="4"
																	class="form-control Align-Right"
																	onkeypress="return isNumber(event)"
																	onkeyup="calculateFund(${index.index}); onloadChangeColor()"
																	id="noOfStaffId_${index.index}"
																	readonly="${IS_FREEZE eq true}" /></td>
															<td><div align="center" id="unitCostIdMopr_${index.index}">${activityDetailsForMopr[index.index].unitCost}</div>
															<form:input
																	path="adminFinancialDataCellActivityDetails[${index.index}].unitCost"
																	type="text" maxlength="7"
																	class="form-control Align-Right"
																	onkeypress="return isNumber(event)"
																	onkeyup="calculateFund(${index.index}); onloadChangeColor()"
																	id="unitCostId_${index.index}"
																	readonly="${IS_FREEZE eq true}" /></td>
															<td><div align="center" id="noOfMonthsIdMopr_${index.index}">${activityDetailsForMopr[index.index].noOfMonths}</div>
															<form:input
																	path="adminFinancialDataCellActivityDetails[${index.index}].noOfMonths"
																	onkeyup="calculateFund(${index.index}); onloadChangeColor() ; validateMonth(${index.index})"
																	class="form-control Align-Right"
																	id="noOfMonthsId_${index.index}" readonly="${IS_FREEZE eq true}" /></td>
															<td><div align="center" id="fundIdMopr_${index.index}">${activityDetailsForMopr[index.index].funds}</div>
															<form:input
																	path="adminFinancialDataCellActivityDetails[${index.index}].funds"
																	type="text" class="form-control Align-Right"
																	onkeypress="return isNumber(event)"
																	onkeyup="onloadChangeColor()"
																	id="fundId_${index.index}" readonly="true" /></td>
															<%-- <td><form:input path="adminFinancialDataCellActivityDetails[${index.index}].otherExpenses" type="text" class="form-control Align-Right" onkeypress="return isNumber(event)" onkeyup="calculateSubTotal(${index.index})" id="otherExpensesId_${index.index}" readonly="${IS_FREEZE eq true}"/></td>
													<td><form:input path="adminFinancialDataCellActivityDetails[${index.index}].subTotal" type="text" class="form-control Align-Right" readonly="true" id="subTotalId_${index.index}"/></td> --%>
															<c:if test="${USER_TYPE eq 'M' or USER_TYPE eq 'C'}">
																<td><form:checkbox
																		path="adminFinancialDataCellActivityDetails[${index.index}].isApproved"
																		class="form-check-input"
																		disabled="${IS_FREEZE eq true}" /></td>
															</c:if>
															<td>
															<div align="center">
													           <button class="addMore btn bg-green waves-effect" title="${activityDetailsForMopr[index.index].remarks}">Remark by MoPR</button>
															</div><form:textarea
																	path="adminFinancialDataCellActivityDetails[${index.index}].remarks"
																	 readonly="${IS_FREEZE eq true}" />
																	
																	</td>
														</tr>
														<c:set var="count" value="${count+1}"></c:set>
													</c:if>
												</c:forEach>
												<tr>
													<td colspan="2"><div align="center">
															<strong><spring:message code="Label.TotalCost"
																	htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td><div align="center" id="TotalCostIdMopr">${totalUnitCostForMopr}</div>
													
													<input type="text"
														class="form-control Align-Right" readonly="readonly"
														id="TotalCostId" /></td>
												</tr>

												<tr>
													<td colspan="2"><div align="center">
															<strong><spring:message
																	code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td><div align="center" id="additionalRequirementIdMopr">${activityForMopr.additionalRequirement}</div>

													<form:input path="additionalRequirement"
															type="text" class="form-control Align-Right"
															onkeypress="return isNumber(event)"
															id="additionalRequirementId"
															onkeyup="validateAdditionalRequirement()"
															placeholder="25 % of Sub Total"
															readonly="${IS_FREEZE eq true}" /></td>
												</tr>

												<tr>
													<td colspan="2"><div align="center">
															<strong><spring:message
																	code="Label.TotalProposedFund" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td><div align="center" id="GrandTotalIdMopr">${TOTAL_WITH_ADDITIONAL}</div>
													<input type="text"
														class="form-control Align-Right" readonly="readonly"
														id="GrandTotalId" /></td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="row clearfix">
									<div class="col-md-4">
										<button type="button"
											onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
											class="btn bg-orange waves-effect">
											<i class="fa fa-arrow-left" aria-hidden="true"></i>
											<spring:message code="Label.BACK" htmlEscape="true" />
										</button>
									</div>
									<div class=" col-md-8 text-right">
										<input type="hidden" id="isFreeze" name="isFreeze">
										<c:if test="${IS_FREEZE eq false or empty IS_FREEZE}">
											<button type="submit" class="btn bg-green waves-effect save-button"
												id="saveId">
												<spring:message code="Label.SAVE" text="Save"
													htmlEscape="true" />
											</button>
										</c:if>
										<c:if test="${IS_FREEZE eq true}">
											<button type="submit" class="btn bg-green waves-effect"
												id="unfreezeId" onclick="isFreezeFunction('unfreeze')">
												<spring:message code="Label.UNFREEZE" text="Unfreeze"
													htmlEscape="true" />
											</button>
										</c:if>
										<c:if test="${IS_FREEZE eq false or empty IS_FREEZE}">
											<c:if test="${DISABLE_FREEZE_INTIALLY eq true}">
												<button type="submit" class="btn bg-green waves-effect"
													id="freezeId" onclick="isFreezeFunction('freeze')"
													disabled="disabled">
													<spring:message code="Label.FREEZE" text="Freeze"
														htmlEscape="true" />
												</button>
											</c:if>
											<c:if test="${DISABLE_FREEZE_INTIALLY eq false}">
												<button type="submit" class="btn bg-green waves-effect"
													id="freezeId" onclick="isFreezeFunction('freeze')"
													onsubmit="return validatingTotalProposedFund()">
													<spring:message code="Label.FREEZE" text="Freeze"
														htmlEscape="true" />
												</button>
											</c:if>
											<%-- <button type="button" onclick="onClear(this)"
												class="btn bg-light-blue waves-effect" id="clearId">
												<spring:message code="Label.CLEAR" text="Clear"
													htmlEscape="true" />
											</button> --%>
										</c:if>
										<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">
											<spring:message code="Label.CLOSE" text="Close"
												htmlEscape="true" />
										</button>
									</div>
									</div>
									<form:hidden path="adminFinancialDataActivityId"
									value="${adminFinancialDataActivityId}" />
								<input type="hidden" id="count" value="${count}" />
								<form:hidden path="userType"
									value="${USER_TYPE_OF_PREVIOUS_ACTIVITY}" />
								</div>
								


								<div class="container tab-pane fade" id="state"
									style="width: auto;">
									<div class="table-responsive">
										<table class="table table-bordered">
											<thead>
												<tr>
													<th>
														<div align="center">
															<strong><spring:message
																	code="Label.TypeOfCenter" htmlEscape="true" /></strong>
														</div>
													</th>

													<th>
														<div align="center">
															<strong><spring:message
																	code="Label.DomainExperts" htmlEscape="true" /></strong>
														</div>
													</th>
													<th>
														<div align="center">
															<strong><spring:message
																	code="Label.NoOfStaffProposed" htmlEscape="true" /><br>(A)</strong>
														</div>
													</th>
													<th>
														<div align="center">
															<strong><spring:message code="Label.UnitCost"
																	htmlEscape="true" /><br>(B)</strong>
														</div>
													</th>
													<th>
														<div align="center">
															<strong><spring:message code="Label.NoOfMonths"
																	htmlEscape="true" /><br>(C)</strong>
														</div>
													</th>
													<th>
														<div align="center">
															<strong><spring:message code="Label.Funds"
																	htmlEscape="true" /><br>D= (A*B*C)</strong>
														</div>
													</th>
													<%-- <th>
												<div align="center">
													<strong><spring:message code="Label.OtherExpenses" htmlEscape="true" /></strong>
												</div>
											</th>
											<th>
												<div align="center">
													<strong><spring:message code="Label.SubTotal" htmlEscape="true" /></strong>
												</div>
											</th> --%>

													<%-- <th>
														<div align="center">
															<strong><spring:message code="Label.IsApproved"
																	htmlEscape="true" /></strong>
														</div>
													</th> --%>

													<th>
														<div align="center">
															<strong><spring:message code="Label.Remarks"
																	htmlEscape="true" /></strong>
														</div>
													</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${ACTIVITY_TYPE}" var="activity"
													varStatus="index">
													<c:if test="${activity.pmuType.pmuTypeId eq 1}">
														<%-- <form:hidden
															path="adminFinancialDataCellActivityDetails[${index.index}].pmuActivityTypeId"
															value="${activity.pmuType.pmuTypeId} " />
														<form:hidden
															path="adminFinancialDataCellActivityDetails[${index.index}].adminFinancialDataActivityDetailId" /> --%>
														<tr>
															<td><div align="center">
																	<strong>${activity.pmuType.pmuTypeName}</strong>
																</div></td>
															<td><div align="center">
																	<strong>${activity.pmuActivityName}</strong>
																</div></td>
															<td><div align="center">${activityDetailsForState[index.index].noOfStaffProposed}</div></td>
															<td><div align="center">${activityDetailsForState[index.index].unitCost}</div></td>
															<td><div align="center">${activityDetailsForState[index.index].noOfMonths}</div></td>
															<td><div align="center">${activityDetailsForState[index.index].funds}</div></td>
															<%-- <td><div align="center">
																	<c:choose>
																		<c:when
																			test="${activityDetailsForState[index.index].isApproved eq true}">
																			<i class="fa fa-check" aria-hidden="true"
																				style="color: #00cc00"></i>
																		</c:when>
																		<c:otherwise>
																			<i class="fa fa-times" aria-hidden="true"
																				style="color: red"></i>
																		</c:otherwise>
																	</c:choose>
																</div></td> --%>
															<td><div align="center">${activityDetailsForState[index.index].remarks}</div></td>
														</tr>
														<c:set var="count" value="${count+1}"></c:set>
													</c:if>
												</c:forEach>
												<tr>
													<td colspan="2"><div align="center">
															<strong><spring:message code="Label.TotalCost"
																	htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td><div align="center"  id ="stateTotalCost"> ${totalUnitCostForState}
															<%-- <input type = "text" class="form-control Align-Right" disabled="disabled" value="${totalUnitCostForMopr}"  id ="stateTotalCost"/> --%>
														</div></td>
												</tr>

												<tr>
													<td colspan="2"><div align="center">
															<strong><spring:message
																	code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td><div align="center" id="stateAdditionalRequirementId">${activityForState.additionalRequirement }</div><%-- <form:input path="additionalRequirement"
															type="text" class="form-control Align-Right"
															onkeypress="return isNumber(event)"
															id="stateAdditionalRequirementId"
															onkeyup="validateAdditionalRequirement()"
															placeholder="25 % of Sub Total"
															 disabled="true"/> --%></td>
												</tr>

												<tr>
													<td colspan="2"><div align="center">
															<strong><spring:message
																	code="Label.TotalProposedFund" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td ><div align="center" id="stateGrandTotalId"></div><!-- <input type="text"
														class="form-control Align-Right" id="GrandTotalId1" disabled="disabled"/> --></td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="row clearfix">
									<div class="col-md-4">
										<button type="button"
											onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
											class="btn bg-orange waves-effect">
											<i class="fa fa-arrow-left" aria-hidden="true"></i>
											<spring:message code="Label.BACK" htmlEscape="true" />
										</button>
									</div>
									<div class=" col-md-8 text-right">
										<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">
											<spring:message code="Label.CLOSE" htmlEscape="true" />
										</button>
									</div>
									</div>
								</div>
							</div>
					</form:form>

				</div>
			</div>
		</div>

	</div>

</section>
<style>
.Align-Right{
			text-align: right;
}</style>