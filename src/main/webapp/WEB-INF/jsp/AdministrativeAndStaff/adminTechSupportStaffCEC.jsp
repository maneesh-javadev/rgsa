<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script>

$( document ).ready(function() {
	calculateTotalProposedFund();
	calculateTotalFund();
	onloadChangeColor();
});

function calculateFund(obj){
	if($("#fundId_"+obj).val()==""){var fund=0;}
	if($("#noOfMonthsId_"+obj).val() !=""  && $("#noOfUnitsId_"+obj).val() !="" && $("#unitCostId_"+obj).val() !=""){
		fund=parseInt($("#noOfMonthsId_"+obj).val())*parseInt($("#noOfUnitsId_"+obj).val())*parseInt($("#unitCostId_"+obj).val());
	}
	$("#fundId_"+obj).val(fund);
	calculateTotalFund();
	
	/* calculateSubTotal(obj); */
}





function calculateTotalFund(){
	var count = 9;
	var grand_total=0;
	for(var i=0;i<count; i++){
		grand_total += +document.getElementById("fundId_"+i).value;
	}
	var totalFund =document.getElementById("total_fund").value=grand_total;
	calculateTotalProposedFund();
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







function validateAdditionalRequirement(){
if($("#total_fund").val() != ""){
	if($("#additionalRequirementId").val() >0.25 * (parseInt($("#total_fund").val()))){
		alert("Additional Requirement should be less than 25% of Total Cost.");
		$("#additionalRequirementId").val('');
		calculateTotalProposedFund();
	}
	calculateTotalProposedFund();
	onloadChangeColor();
}
}

function calculateTotalProposedFund(){
if($("#additionalRequirementId").val() == "" || $("#total_fund").val() == ""){
	if($("#additionalRequirementId").val() == ""){
		$("#GrandTotalId").val(parseInt($("#total_fund").val()) + 0);
	}else{
		$("#GrandTotalId").val(parseInt($("#additionalRequirementId").val()) + 0);
	}
	
}else{
	document.getElementById("GrandTotalId").value =$("#GrandTotalId").val(parseInt($("#total_fund").val()) + parseInt($("#additionalRequirementId").val()));
$("#GrandTotalId").val(parseInt($("#total_fund").val()) + parseInt($("#additionalRequirementId").val()));
}
}

function freezeAndUnfreeze(obj){
	if(obj == "F"){
		$("#isFreeze").val("F");
	}else{
		$("#unfreezeId").val("U");
	}
	document.getElementById("dbFileName").value = obj;
	document.administrativeTechnicalSupport.method = "post";
	document.administrativeTechnicalSupport.action = "freezAndUnfreezForCec.html?<csrf:token uri='freezAndUnfreezForCec.html'/>";
	document.administrativeTechnicalSupport.submit();
}


function onloadChangeColor(){
	var noOfRowCount = $('#tbody tr').length-3;
	for(var i= 0; i<noOfRowCount ;i++){
	
+$("#noOfUnitsId_"+i).val() < +$("#noOfUnitsIdState_"+i).text() ? $("#noOfUnitsIdState_"+i).css("color","red") : $("#noOfUnitsIdState_"+i).css("color","#00cc00");
+$("#fundId_"+i).val() < +$("#fundIdState_"+i).text() ? $("#fundIdState_"+i).css("color","red") : $("#fundIdState_"+i).css("color","#00cc00");
+$("#unitCostId_"+i).val() < +$("#unitCostIdState_"+i).text() ? $("#unitCostIdState_"+i).css("color","red") : $("#unitCostIdState_"+i).css("color","#00cc00");

+$("#noOfMonthsId_"+i).val() < +$("#noOfMonthsIdState_"+i).text() ? $("#noOfMonthsIdState_"+i).css("color","red") : $("#noOfMonthsIdState_"+i).css("color","#00cc00");
}
	+$("#additionalRequirementIdState").text() > +$("#additionalRequirementId").val() ? $("#additionalRequirementIdState").css('color','red') : $("#additionalRequirementIdState").css('color','#00cc00');
	+$("#TotalCostIdState").text() > +$("#total_fund").val() ? $("#TotalCostIdState").css('color','red') : $("#TotalCostIdState").css('color','#00cc00');
	+$("#GrandTotalIdState").text() > +$("#GrandTotalId").val() ? $("#GrandTotalIdState").css('color','red') : $("#GrandTotalIdState").css('color','#00cc00');

}

function validateUnitCost(index){
	if($('#unitCostId_'+index).val() > 50000){
		alert("Unit cost should not exceed 50000 per month.");
		$('#unitCostId_'+index).focus();
		$('#unitCostId_'+index).val('')
	}
}

</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Administrative & Technical Support to Gram Panchayat(CEC)
						</h2>
					</div>
					<form:form method="post" name="administrativeTechnicalSupport"
						action="adminTechSupportStaffCEC.html"
						modelAttribute="ADMIN_TECH_SUPPORT_STAFFCEC"
						onsubmit="return validatingTotalProposedFund()">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="adminTechSupportStaffCEC.html" />" />

						<ul class="nav nav-tabs">
							<li class="nav-item"><a class="nav-link active"
								data-toggle="tab" href="#state"><spring:message
										code="Label.STATE" htmlEscape="true" /></a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#MOPR"><spring:message code="Label.MOPR"
										htmlEscape="true" /></a></li>
						</ul>

						<div class="tab-content">
							<div role="tabpanel" class="container tab-pane active" id="state"
								style="width: auto;">
								<div class="table-responsive">
									<table class="table table-bordered">
										<thead>
											<tr>
												<th>S.No.</th>
												<th>Post Type</th>
												<th>Post Name</th>
												<th>Level</th>
												<th><div align="center">
														no Of Units <br> (A)
													</div></th>
												<th><div align="center">
														No. of Months <br> (C)
													</div></th>
												<th><div align="center">
														Unit Cost <br> (B)
													</div></th>
												<th><div align="center">
														Funds(in Rs.) <br> D= (A*B*C)
													</div></th>

											</tr>
										</thead>
										<tbody id=tbody>
											<c:forEach items="${postType}" var="post" varStatus="index">
												<input type="hidden"
													name="supportDetails[${index.index}].id"
													value="${details[index.index].id}" />
												<%-- <form:hidden
															path="adminFinancialDataCellActivityDetails[${index.index}].pmuActivityTypeId"
															value="${activity.pmuType.pmuTypeId} " />
														<form:hidden
															path="adminFinancialDataCellActivityDetails[${index.index}].adminFinancialDataActivityDetailId" /> --%>
												<tr>
													<td><div align="center">
															<strong>${index.index+1}</strong>
														</div></td>
													<td><div align="center">
															<strong>${post.postName}
															<input type="hidden" name="supportDetails[${index.index}].postType.postId" value="${post.postId}">
															</strong>
														</div></td>
													<td><div align="center">
															<strong>${post.master.postTypeName}</strong>
														</div></td>
													<td><div align="center">
															<strong>${detailsForState[index.index].postLevel.postLevelName}</strong>
														</div></td>
													<c:choose>

														<c:when test="${ISFREEZE == 'F'}">
															<td>
																<div align="center" id="noOfUnitsIdState_${index.index}">${detailsForState[index.index].noOfUnits}</div>
																<input name="supportDetails[${index.index}].noOfUnits"
																type="text" maxlength="4"
																value="${details[index.index].noOfUnits}"
																class="form-control Align-Right"
																onkeypress="return isNumber(event)"
																onkeyup="calculateFund(${index.index}); onloadChangeColor()"
																style="text-align: right;"
																id="noOfUnitsId_${index.index}" readonly="readonly" <%-- readonly="${IS_FREEZE eq true}" --%> />
															</td>
															<td>
																<div align="center" style="margin-top: 20px;">${detailsForState[index.index].noOfMonths}</div>
																<input name="supportDetails[${index.index}].noOfMonths"
																type="hidden"
																value="${detailsForState[index.index].noOfMonths}"
																id="noOfMonthsId_${index.index}" />
															</td>
															<td><div align="center"
																	id="unitCostIdState_${index.index}">${detailsForState[index.index].unitCost}</div>
																<input name="supportDetails[${index.index}].unitCost"
																value="${details[index.index].unitCost}" type="text"
																max="50000"
																class="form-control Align-Right"
																onkeypress="return isNumber(event)"
																style="text-align: right;"
																onkeyup="validateMonth(${index.index}); calculateFund(${index.index}); onloadChangeColor()"
																id="unitCostId_${index.index}" readonly="readonly" /></td>
														</c:when>
														<c:otherwise>
															<td><div align="center"
																	id="noOfUnitsIdState_${index.index}">${detailsForState[index.index].noOfUnits}</div>
																<input name="supportDetails[${index.index}].noOfUnits"
																type="text" maxlength="4"
																value="${details[index.index].noOfUnits}"
																class="form-control Align-Right"
																onkeypress="return isNumber(event)"
																	style="text-align: right;"
																onkeyup="calculateFund(${index.index}); onloadChangeColor()"
																id="noOfUnitsId_${index.index}" <%-- readonly="${IS_FREEZE eq true}" --%> /></td>
															<td>
																<div align="center" style="margin-top: 20px;">${detailsForState[index.index].noOfMonths}</div>
																<input name="supportDetails[${index.index}].noOfMonths"
																type="hidden"
																value="${detailsForState[index.index].noOfMonths}"
																id="noOfMonthsId_${index.index}" />
															</td>

															<td><div align="center"
																	id="unitCostIdState_${index.index}">${detailsForState[index.index].unitCost}</div>
																<input name="supportDetails[${index.index}].unitCost"
																value="${details[index.index].unitCost}" type="text"
																class="form-control Align-Right"
																onkeypress="return isNumber(event)"
																style="text-align: right;"
																maxlength="5"
																onkeyup=" calculateFund(${index.index}); onloadChangeColor();validateUnitCost(${index.index})"
																id="unitCostId_${index.index}" /></td>


														</c:otherwise>


													</c:choose>




													<td><div align="center"
															id="fundIdState_${index.index}">${detailsForState[index.index].funds}</div>
														<input name="supportDetails[${index.index}].funds"
														value="${details[index.index].funds}" type="text"
														class="form-control Align-Right"
														onkeypress="return isNumber(event)"
															style="text-align: right;"
														onchange="calculateFund()" onkeyup="onloadChangeColor()"
														id="fundId_${index.index}" readonly="readonly" /></td>

												</tr>
												<c:set var="count" value="${count+1}"></c:set>

											</c:forEach>
											<tr>
												<td colspan="2"><div align="center">
														<strong><spring:message code="Label.TotalCost"
																htmlEscape="true" /></strong>
													</div></td>
												<td colspan="3"></td>
												<td><div align="center" id="TotalCostIdState">${TotalStateFund}</div>

													<input type="text" class="form-control Align-Right"
													readonly="readonly" id="total_fund" style="text-align: right;"/></td>
											</tr>

											<tr>
												<td colspan="2"><div align="center">
														<strong><spring:message
																code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
													</div></td>
												<td colspan="3"></td>
												<td><div align="center"
														id="additionalRequirementIdState">${technicalSupportForState.additionalRequirement}</div>
													
													<c:choose>
													<c:when test="${ISFREEZE == 'F'}">
													<input name="additionalRequirement"
													value="${technicalSupport.additionalRequirement}"
													type="text" class="form-control Align-Right"
													onkeypress="return isNumber(event)"
													id="additionalRequirementId"
													style="text-align: right;"
													readonly="readonly"
													onkeyup="validateAdditionalRequirement()"
													placeholder="25 % of Sub Total" />
													</c:when>
													<c:otherwise>
													<input name="additionalRequirement"
													value="${technicalSupport.additionalRequirement}"
													type="text" class="form-control Align-Right"
													onkeypress="return isNumber(event)"
													id="additionalRequirementId"
													onkeyup="validateAdditionalRequirement()"
													placeholder="25 % of Sub Total" style="text-align: right;"/>
													</c:otherwise>
													</c:choose>
													</td>
											</tr>
											<c:set var="count" value="${count + 1}" scope="page" />
											<tr>
												<td colspan="2"><div align="center">
														<strong><spring:message
																code="Label.TotalProposedFund" htmlEscape="true" /></strong>
													</div></td>
												<td colspan="3"></td>
												<td><div align="center" id="GrandTotalIdState">${technicalSupportForState.additionalRequirement+TotalStateFund}</div>
													<input type="text" class="form-control Align-Right"
													readonly="readonly" id="GrandTotalId" style="text-align: right;"/></td>
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

									<div class="col-md-8 text-right">
										<%-- <c:if test="${Plan_Status eq true}"> --%>
										<%-- <c:if test="${administrativeTechnicalSupport.status eq S || empty eGovActivity.status}"> --%>
										<c:if test="${ISFREEZE ne 'F'}">

											<button type="submit" class="btn bg-green waves-effect"
												id="saveId" onclick="validateMonth(${count});">SAVE</button>
											<c:choose>
												<c:when test="${initial_status}">
													<button type="button" onclick='freezeAndUnfreeze("F")'
														id="isFreeze" class="btn bg-green waves-effect"
														disabled="disabled">FREEZE</button>
												</c:when>
												<c:otherwise>
													<button type="button" onclick='freezeAndUnfreeze("F")'
														id="isFreeze" class="btn bg-green waves-effect">FREEZE</button>
												</c:otherwise>
											</c:choose>
											<button type="button"
												class="btn bg-light-blue waves-effect reset" id="clearId"
												onclick="onClear(this)">
												<spring:message code="Label.CLEAR" text="Clear"
													htmlEscape="true" />
											</button>

										</c:if>
										<c:if test="${ISFREEZE eq 'F'}">
											<button type="button" onclick='freezeAndUnfreeze("U")'
												id="unfreezeId" class="btn bg-green waves-effect">
												UNFREEZE</button>
										</c:if>

										<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">CLOSE</button>
										<input type="hidden" name="dbFileName" id="dbFileName">
										<input type="hidden" name="administrativeTechnicalSupportId"
											value="${technicalSupport.administrativeTechnicalSupportId}" />
										<input type="hidden" name="userType"
											value="${technicalSupport.userType}">
									</div>
								</div>
							</div>
							<%-- <form:hidden path="adminFinancialDataActivityId"
									value="${adminFinancialDataActivityId}" />
								<input type="hidden" id="count" value="${count}" /> --%>
							<%-- <form:hidden path="userType"
									value="${user_type}" />
 --%>

							<div class="container tab-pane fade" id="MOPR"
								style="width: auto;">
								<div class="table-responsive">
									<table class="table table-bordered">
										<thead>
											<tr>
												<th>S.No.</th>
												<th>Post Type</th>
												<th>Post Name</th>
												<th>Level</th>
												<th><div align="center">
														No. of Block(s) <br> (A)
													</div></th>
												<th><div align="center">
														 No. of Months<br> (B)
													</div></th>
												<th><div align="center">
														Unit Cost <br> (C)
													</div></th>
												<th><div align="center">
														Funds(in Rs.) <br> D= (A*B*C)
													</div></th>
												<th><div align="center">
														<spring:message code="Label.IsApproved" htmlEscape="true" />
													</div></th>
												<th scope="col">
													<div align="center">
														<strong><spring:message code="Label.Remarks"
																htmlEscape="true" /></strong>
													</div>
												</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${postType}" var="post" varStatus="index">

												<%-- <form:hidden
															path="adminFinancialDataCellActivityDetails[${index.index}].pmuActivityTypeId"
															value="${activity.pmuType.pmuTypeId} " />
														<form:hidden
															path="adminFinancialDataCellActivityDetails[${index.index}].adminFinancialDataActivityDetailId" /> --%>
												<tr>
													<td><div align="center">
															<strong>${index.index+1}</strong>
														</div></td>
													<td><div align="center">
															<strong>${post.postName}</strong>
														</div></td>
													<td><div align="center">
															<strong>${post.master.postTypeName}</strong>
														</div></td>
													<td><div align="center">
															<strong>${detailsForMOPR[index.index].postLevel.postLevelName}</strong>
														</div></td>
													<td><div align="center"><strong>${detailsForMOPR[index.index].noOfUnits}</strong></div>
													</td>
													<td><div align="center"><strong>${detailsForMOPR[index.index].noOfMonths}</strong></div>
													</td>
													<td><div align="center"><strong>${detailsForMOPR[index.index].unitCost}</strong></div>
													</td>

													<td><div align="center"><strong>${detailsForMOPR[index.index].funds}</strong></div>
													<td><div align="center">
															<c:choose>
																<c:when
																	test="${detailsForMOPR[index.index].isApproved eq true}">
																	<i class="fa fa-check" aria-hidden="true"
																		style="color: #00cc00"></i>
																</c:when>
																<c:otherwise>
																	<i class="fa fa-times" aria-hidden="true"
																		style="color: red"></i>
																</c:otherwise>
															</c:choose>
														</div></td>



													<td><strong>${detailsForMOPR[index.index].remarks}</strong></td>
												</tr>
												</td>
												<%-- <td><form:input path="adminFinancialDataCellActivityDetails[${index.index}].otherExpenses" type="text" class="form-control Align-Right" onkeypress="return isNumber(event)" onkeyup="calculateSubTotal(${index.index})" id="otherExpensesId_${index.index}" readonly="${IS_FREEZE eq true}"/></td>
													<td><form:input path="adminFinancialDataCellActivityDetails[${index.index}].subTotal" type="text" class="form-control Align-Right" readonly="true" id="subTotalId_${index.index}"/></td> --%>

												<%-- <td><form:textarea
																	path="supportDetails[${index.index}].remarks"
																	rows="2" cols="5" readonly="${IS_FREEZE eq true}" /></td> --%>
												</tr>
												<c:set var="count" value="${count+1}"></c:set>

											</c:forEach>
											<tr>
												<td colspan="2"><div align="center">
														<strong><spring:message code="Label.TotalCost"
																htmlEscape="true" /></strong>
													</div></td>
												<td colspan="3"></td>
												<td><div align="center">
														<strong>${TotalMoprFund}</strong>
													</div></td>
											</tr>

											<tr>
												<td colspan="2"><div align="center">
														<strong><spring:message
																code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
													</div></td>
												<td colspan="3"></td>
												<td><div align="center">
														<strong>${technicalSupportForMOPR.additionalRequirement}</</strong>
													</div></td>
											</tr>

											<tr>
												<td colspan="2"><div align="center">
														<strong><spring:message
																code="Label.TotalProposedFund" htmlEscape="true" /></strong>
													</div></td>
												<td colspan="3"></td>
												<td><div align="center">
														<strong>${technicalSupportForMOPR.additionalRequirement+TotalMoprFund}</strong>
													</div></td>
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
									<div class="col-md-8 text-right">
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
