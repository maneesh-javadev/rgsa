<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/eGovernance/e-Governance.js"></script>
<script type="text/javascript">
function save_data(){
	disableButton(true);
	if($('#districtSupportedId').val()!='' && $('#districtSupportedId').val()!=null && $('#districtSupportedId').val()!='undefined' && $('#districtSupportedId').val()>0)
		{
		if($('#total_fund_dpmu').val()!=0 && $('#total_fund_dpmu').val()!='undefined' && $('#total_fund_dpmu').val()!='')
			{
			document.egovernance.method = "post";
			document.egovernance.action = "egovernancesupportgroup.html?<csrf:token uri='egovernancesupportgroup.html'/>";
			document.egovernance.submit();
			}
		else
		{
		disableButton(false);
		alert("Fund can not be 0 or blank");
		}
		}
	else{
	if($('#total_fund_spmu').val()!=0 && $('#total_fund_spmu').val()!='undefined' && $('#total_fund_spmu').val()!='')
	{
	 	document.egovernance.method = "post";
		document.egovernance.action = "egovernancesupportgroup.html?<csrf:token uri='egovernancesupportgroup.html'/>";
		document.egovernance.submit();
	}
	else
	{
	disableButton(false);
	alert("Fund can not be 0 or blank");
	}
	}
	
}

function disableButton(isDisabled){
	if(isDisabled){
		$('#saveId').prop('disabled',true);
		$('#freezeId').prop('disabled',true);
		$('#unfreezeId').prop('disabled',true);
	}else{
		$('#saveId').prop('disabled',false);
		$('#freezeId').prop('disabled',false);
		$('#unfreezeId').prop('disabled',false);
	}
	
}




$('documnet').ready(function(){
	changeColor();
});

function changeColor() {
	var rowCount = $('#tbodyId tr').length - 3;
	for (var i = 0; i < rowCount; i++) {
		
		+$('#noOfPostId_' + i).val() < +$('#noOfPostMoprId_' + i).text() ? $(
				'#noOfPostMoprId_' + i).css('color', 'red') : $(
				'#noOfPostMoprId_' + i).css('color', '#00cc00');
		+$('#unitCostId_' + i).val() < +$('#unitCostMoprId_' + i).text() ? $(
				'#unitCostMoprId_' + i).css('color', 'red') : $(
				'#unitCostMoprId_' + i).css('color', '#00cc00');
		+$('#fundId_' + i).val() < +$('#fundMoprId_' + i).text() ? $(
				'#fundMoprId_' + i).css('color', 'red') : $(
				'#fundMoprId_' + i).css('color', '#00cc00');
	}
	$('#total_fund_spmu').val() < +$('#total_fund_Mopr_spmu').text() ? $('#total_fund_Mopr_spmu').css('color', 'red') : $('#total_fund_Mopr_spmu').css('color', '#00cc00');
	$('#total_fund_dpmu').val() < +$('#total_fund_Mopr_dpmu').text() ? $('#total_fund_Mopr_dpmu').css('color', 'red') : $('#total_fund_Mopr_dpmu').css('color', '#00cc00');
	$('#additionalRequirementSpmuId').val() < +$('#additionalRequirementMoprSpmuId').text() ? $('#additionalRequirementMoprSpmuId').css('color', 'red') : $('#additionalRequirementMoprSpmuId').css('color', '#00cc00');
	$('#additionalRequirementDpmuId').val() < +$('#additionalRequirementMoprDpmuId').text() ? $('#additionalRequirementMoprDpmuId').css('color', 'red') : $('#additionalRequirementMoprDpmuId').css('color', '#00cc00');
	$('#grandTotalId').val() < +$('#grandTotalMoprId').text() ? $('#grandTotalMoprId').css('color', 'red') : $('#grandTotalMoprId').css('color', '#00cc00');

};
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Label.EGoveHeader" htmlEscape="true" />
							(CEC)
						</h2>
					</div>
					<div class="body">
						<ul class="nav nav-tabs">
							<li class="nav-item"><a class="nav-link active"
								data-toggle="tab" href="#state"><spring:message
										code="Label.STATE" htmlEscape="true" /></a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#MOPR"><spring:message code="Label.MOPR"
										htmlEscape="true" /></a></li>
						</ul>
						<div class="tab-content">
							<div role="tabpanel" class="container tab-pane active" id="MOPR"
								style="width: auto;">

								<form:form method="post" name="egovernance"
									action="egovernancesupportgroup.html" modelAttribute="EGOVERN_MODEL">
									<input type="hidden" name="<csrf:token-name/>"
										value="<csrf:token-value uri="egovernancesupportgroup.html" />" />
								<div class="row clearfix">
									<div class="form-group">
										<div class="col-sm-4">
											<label for="District"><spring:message
													code="Label.DistrictsupportedDprc" htmlEscape="true" /><span><sup
													style="color: red;">*</sup></span> </label>
										</div>

										<div class="col-sm-2">
											<div align="center">
												<strong>${eGovActivityForState.noOfDistrictSupported}</strong>
											</div>
											<form:hidden id="districtSupportedId"
												path="noOfDistrictSupported"
												value="${eGovActivityForState.noOfDistrictSupported}" />
										</div>
									</div>
								</div>
									<c:set var="countSpmuCec" value="0" scope="page" />
									<c:set var="countDpmuCec" value="0" scope="page" />
									<div class="table-responsive">
											<table id="tableId" class="table table-bordered">
												<thead>
													<tr>
														<th><div align="center">
																<strong><spring:message code="Label.Level" htmlEscape="true" /></strong>
															</div></th>
														<th><div align="center">
																<strong><spring:message code="Label.Designation" htmlEscape="true" /></strong>
															</div></th>
														<th><div align="center">
																<strong><spring:message code="Label.PostProposed" htmlEscape="true" /><br> A
																</strong>
															</div></th>
														<th><div align="center">
																<strong><spring:message code="Label.NoOfMonths" htmlEscape="true" /><br> B
																</strong>
															</div></th>
														<th><div align="center">
																<strong><spring:message code="Label.UnitCost" htmlEscape="true" /> (in Rs)<br>C
																</strong>
															</div></th>
														<th><div align="center">
																<strong><spring:message code="Label.FundProposed" htmlEscape="true" /> (in Rs)<br>D = A * B
																	* C
																</strong>
															</div></th>
															<%-- <th rowspan="2"><div align="center">
																<strong><spring:message code="Label.IsApproved" htmlEscape="true" /></strong>
															</div></th> --%>
														<th rowspan="2"><div align="center">
																<strong><spring:message code="Label.Remarks" htmlEscape="true" /></strong>
															</div></th>
													</tr>
												</thead>
											<tbody id="tbodyId">
												<c:forEach items="${LIST_OF_POST_LEVEL}" var="POST_LEVEL"
													varStatus="index" begin="0" end="3">
													<input type="hidden"
														name="eGovSupportActivityDetails[${index.index}].eGovPostId"
														value="${POST_LEVEL.eGovPostId}">
													<input type="hidden" id="postId_${index.index}"
														value="${POST_LEVEL.EGovPostLevel.postLevelId}">
													<form:hidden
														path="eGovSupportActivityDetails[${index.index}].eGovDetailsId" />
													<tr id="newRowHtml">
														<td><div align="center">
																<strong>${POST_LEVEL.EGovPostLevel.postLevelName}
																</strong>
															</div></td>
														<td><div align="center">
																<strong>${POST_LEVEL.EGovPostName}</strong>
															</div></td>
														<c:choose>
													<c:when
														test="${POST_LEVEL.eGovPostId ne 4 and POST_LEVEL.eGovPostId ne 7}">
														<td>
														<div align="center" id="noOfPostMoprId_${index.index}"><strong>${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].noOfPosts }</strong></div>
														<form:input
																path="eGovSupportActivityDetails[${index.index}].noOfPosts"
																type="text" onkeypress="return isNumber(event)"
																maxlength="5" class="active123 form-control"
																id="noOfPostId_${index.index}"
																onchange="calculateProposedFund(${index.index})"
																onkeyup="changeColor()"
																style="text-align:right;"
																disabled="${eGovActivity.status eq true}" /></td>
														<td>
														<div align="center" style="margin-top: 20px;"><strong>${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].months}</strong></div>
														<form:hidden path="eGovSupportActivityDetails[${index.index}].months"
																value="${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].months}" 
																id="monthId_${index.index}" /></td>
														<td>
														<div align="center" id="unitCostMoprId_${index.index}"><strong>${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].unitCost}</strong></div>
														<form:input
																path="eGovSupportActivityDetails[${index.index}].unitCost"
																type="text" onkeypress="return isNumber(event)"
																class="active123 form-control" id="unitCostId_${index.index}"
																onkeyup="calculateProposedFund(${index.index});validateCielingValue(${index.index});changeColor()"
																style="text-align:right;"
																disabled="${eGovActivity.status eq true}" /></td>
														</c:when>
														<c:otherwise>
														<td></td>
														<td></td>
														<td></td>
														</c:otherwise>	
														</c:choose>	
														<td>
														<div align="center" id="fundMoprId_${index.index}"><strong>${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].funds}</strong></div>
														<c:choose>
															<c:when test="${POST_LEVEL.eGovPostId eq 4}">
																<form:input
																path="eGovSupportActivityDetails[${index.index}].funds"
																type="text" onkeypress="return isNumber(event)"
																class="form-control" id="fundId_${index.index}"
																onkeyup="calculateTotalFundSpmu()" onchange="changeColor();" maxlength="6"
																style="text-align:right;" disabled="${eGovActivity.status eq true}" />
															</c:when>
															<c:otherwise>
																<form:input
																	path="eGovSupportActivityDetails[${index.index}].funds"
																	type="text" onkeypress="return isNumber(event)"
																	class="form-control" id="fundId_${index.index}"
																	onchange="changeColor()"
																	style="text-align:right;"
																	readonly="true" />
															</c:otherwise>
														</c:choose>
														</td>
														<%-- <td><c:choose>
																<c:when
																	test="${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].isApproved}">
																	<i class="fa fa-check" aria-hidden="true"
																		style="color: #00cc00"></i>
																</c:when>
																<c:otherwise>
																	<i class="fa fa-times" aria-hidden="true"
																		style="color: red"></i>
																</c:otherwise>
															</c:choose></td> --%>
<%-- 														<td><div align="center">${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].remarks }</div></td>
 --%>								                        <td>
 	<div align="center">
													          <button class="addMore btn bg-green waves-effect" title="${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].remarks}">Remark by MoPR</button>
                                                      
    <form:textarea
																	path="eGovSupportActivityDetails[${index.index}].remarks"
																	type="text" 
																	class="form-control" 
																	disabled="${eGovActivity.status eq true}"
																	style="text-align:right;"
																	/></div>
																	</td>
													</tr>
													<c:set var="countSpmuCec" value="${countSpmuCec + 1}" scope="page" />
												</c:forEach>
												<tr>
													<td><div align="center">
															<strong>Total SPMU Fund</strong>
														</div></td>
													<td colspan="4"></td>
													<td>
													<div align="center" id="total_fund_Mopr_spmu"><strong>${SPMU_TOTAL_MOPR}</strong></div>
													<input type="text" class="active12 form-control"
														id="total_fund_spmu"
														onkeypress="return isNumber(event)"
														onchange="changeColor()"
														style="text-align: right;" readonly="readonly" /></td>
												</tr>
												<tr>
													<td><div align="center">
															<strong>SPMU <spring:message
																	code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="4"></td>
													<td>
													<div align="center" id="additionalRequirementMoprSpmuId"><strong>${eGovActivityForMOPR.additionalRequirementSpmu}</strong></div>
													<form:input path="additionalRequirementSpmu"
															type="text" onkeypress="return isNumber(event)"
															class="form-control"
															id="additionalRequirementSpmuId"
															onkeyup="calculateGrandTotal();changeColor()"
															placeholder="25% of Total Cost" style="text-align:right;"
															readonly="${eGovActivity.status}" /></td>
												</tr>
												
												<!-- second loop for Dpmu -->
												<c:forEach items="${LIST_OF_POST_LEVEL}" var="POST_LEVEL"
													varStatus="index" begin="4" end="6">
													<input type="hidden"
														name="eGovSupportActivityDetails[${index.index}].eGovPostId"
														value="${POST_LEVEL.eGovPostId}">
													<input type="hidden" id="postId_${index.index}"
														value="${POST_LEVEL.EGovPostLevel.postLevelId}">
													<form:hidden
														path="eGovSupportActivityDetails[${index.index}].eGovDetailsId" />
													<tr id="newRowHtml">
														<td><div align="center">
																<strong>${POST_LEVEL.EGovPostLevel.postLevelName}
																</strong>
															</div></td>
														<td><div align="center">
																<strong>${POST_LEVEL.EGovPostName}</strong>
															</div></td>
														<c:choose>
													<c:when
														test="${POST_LEVEL.eGovPostId ne 4 and POST_LEVEL.eGovPostId ne 7}">
														<td>
														<div align="center" id="noOfPostMoprId_${index.index}"><strong>${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].noOfPosts }</strong></div>
														<form:input
																path="eGovSupportActivityDetails[${index.index}].noOfPosts"
																type="text" onkeypress="return isNumber(event)"
																maxlength="5" class="active123 form-control"
																id="noOfPostId_${index.index}"
																onchange="calculateProposedFund(${index.index})"
																onkeyup="changeColor()"
																style="text-align:right;"
																disabled="${eGovActivity.status eq true}" /></td>
														<td>
														<div align="center" style="margin-top: 20px;"><strong>${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].months}</strong></div>
														<form:hidden path="eGovSupportActivityDetails[${index.index}].months"
																value="${eGovActivityForState.eGovSupportActivityDetails[index.index].months}" 
																id="monthId_${index.index}" /></td>
														<td>
														<div align="center" id="unitCostMoprId_${index.index}"><strong>${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].unitCost}</strong></div>
														<form:input
																path="eGovSupportActivityDetails[${index.index}].unitCost"
																type="text" onkeypress="return isNumber(event)"
																class="active123 form-control" id="unitCostId_${index.index}"
																onkeyup="calculateProposedFund(${index.index});validateCielingValue(${index.index});changeColor()"
																style="text-align:right;"
																disabled="${eGovActivity.status eq true}" /></td>
														</c:when>
														<c:otherwise>
														<td></td>
														<td></td>
														<td></td>
														</c:otherwise>	
														</c:choose>	
														<td>
														<div align="center" id="fundMoprId_${index.index}"><strong>${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].funds}</strong></div>
														<c:choose>
															<c:when test="${POST_LEVEL.eGovPostId eq 7}">
																<form:input
																path="eGovSupportActivityDetails[${index.index}].funds"
																type="text" onkeypress="return isNumber(event)"
																class="form-control" id="fundId_${index.index}"
																onchange="changeColor()" maxlength="6"
																onkeyup="calculateTotalFundDpmu()"
																style="text-align:right;" disabled="${eGovActivity.status eq true}" />
															</c:when>
															<c:otherwise>
																<form:input
																	path="eGovSupportActivityDetails[${index.index}].funds"
																	type="text" onkeypress="return isNumber(event)"
																	class="form-control" id="fundId_${index.index}"
																	onchange="changeColor()"
																	style="text-align:right;"
																	readonly="true"/>
															</c:otherwise>
														</c:choose>
														</td>
														<%-- <td><c:choose>
																<c:when
																	test="${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].isApproved}">
																	<i class="fa fa-check" aria-hidden="true"
																		style="color: #00cc00"></i>
																</c:when>
																<c:otherwise>
																	<i class="fa fa-times" aria-hidden="true"
																		style="color: red"></i>
																</c:otherwise>
															</c:choose></td> --%>
														 <td>  
														 <div align="center">
													          <button class="addMore btn bg-green waves-effect" title="${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].remarks}">Remark by MoPR</button>
                                                      
														  <form:textarea
																	path="eGovSupportActivityDetails[${index.index}].remarks"
																	type="text" 
																	class="form-control" 
																	disabled="${eGovActivity.status eq true}"
																	style="text-align:right;"
																	 /></div>
																	</td>		
													</tr>
													<c:set var="countDpmuCec" value="${countDpmuCec + 1}" scope="page" />
												</c:forEach>
												
												<!-- second loop for Dpmu ends here -->
												
												<tr>
													<td><div align="center">
															<strong>Total DPMU Fund</strong>
														</div></td>
													<td colspan="4"></td>
													<td>
													<div align="center" id="total_fund_Mopr_dpmu"><strong>${DPMU_TOTAL_MOPR}</strong></div>
													<input type="text" class="active12 form-control"
														id="total_fund_dpmu"
														onkeypress="return isNumber(event)"
														onchange="changeColor()"
														style="text-align: right;" readonly="readonly" /></td>
												</tr>
												<tr>
													<td><div align="center">
															<strong>DPMU <spring:message
																	code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="4"></td>
													<td>
													<div align="center" id="additionalRequirementMoprDpmuId"><strong>${eGovActivityForMOPR.additionalRequirementDpmu}</strong></div>
													<form:input path="additionalRequirementDpmu"
															type="text" onkeypress="return isNumber(event)"
															class="form-control"
															id="additionalRequirementDpmuId"
															onkeyup="calculateGrandTotal();changeColor()"
															placeholder="25% of Total Cost" style="text-align:right;"
															readonly="${eGovActivity.status}" /></td>
												</tr>
												
												<tr>
													<td><div align="center">
															<strong><spring:message
																	code="Label.TotalProposedFund" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="4"></td>
													<td>
													<div align="center" id="grandTotalMoprId"><strong>${eGovActivityForMOPR.additionalRequirementDpmu + DPMU_TOTAL_MOPR + SPMU_TOTAL_MOPR + eGovActivityForMOPR.additionalRequirementSpmu}</strong></div>
													
													<input type="text" onkeypress="return isNumber(event)" class="form-control" id="grandTotalId"
														readonly="readonly" onchange="changeColor();" style="text-align: right;" /></td>
												</tr>
											</tbody>
										</table>
										</div>
									<div class="col-md-4 text-left">
										<button type="button"
											onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
											class="btn bg-orange waves-effect">
											<i class="fa fa-arrow-left" aria-hidden="true"></i>
											<spring:message code="Label.BACK" htmlEscape="true" />
										</button>
									</div>
									<div class="text-right">
										<c:if test="${eGovActivity.status eq false || empty eGovActivity.status}">
									  
											<button type="button" class="btn bg-green waves-effect" id="saveId" onclick="save_data()" onclick="validateMonth(${index.index});">
											<spring:message code="Label.SAVE" htmlEscape="true" /></button>
											<c:choose>
											<c:when test="${initial_status}"><button type="button" onclick='freezeAndUnfreeze("freeze")' id="freezeId" class="btn bg-green waves-effect" disabled="disabled"><spring:message code="Label.FREEZE" htmlEscape="true" /></button></c:when>
											<c:otherwise><button type="button" onclick='freezeAndUnfreeze("freeze")' id="freezeId" class="btn bg-green waves-effect"><spring:message code="Label.FREEZE" htmlEscape="true" /></button></c:otherwise>
											</c:choose>
											</c:if>
											<c:if test="${eGovActivity.status eq true}">
											<button type="button" onclick='freezeAndUnfreeze("unfreeze")' id="unfreezeId" class="btn bg-green waves-effect" >
											<spring:message code="Label.UNFREEZE" htmlEscape="true" /></button>
										</c:if>
										
										<c:if test="${eGovActivity.status eq false || empty eGovActivity.status}">
<%-- 											<button type="button" class="btn bg-light-blue waves-effect reset" id="clearId"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
 --%>										</c:if>
										<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
										<input type="hidden" name="dbFileName" id="dbFileName">
										<input type="hidden" name="eGovSupportActivityId" value="${eGovActivity.eGovSupportActivityId}" />
										<input type="hidden" name="userType" value="${eGovActivity.userType}" >
										<input type="hidden" id="countSpmuId" value="${countSpmuCec}">
										<input type="hidden" id="countDpmuId" value="${countDpmuCec}">
								</div>
								</form:form>
							</div>

							<div class="container tab-pane " id="state"
								style="width: auto;"> 
									<div class="row clearfix">
										<div class="form-group">
											<div class="col-sm-4">
												<label for="District"><spring:message
														code="Label.DistrictsupportedDprc" htmlEscape="true" /><span><sup
														style="color: red;">*</sup></span> </label>
											</div>
	
											<div class="col-sm-2">
												<div align="center">
													<strong>${eGovActivityForMOPR.noOfDistrictSupported}</strong>
												</div>
											</div>
										</div>
									</div>
								<div class="table-responsive">
											<table id="tableId" class="table table-bordered">
												<thead>
													<tr>
														<th><div align="center">
																<strong><spring:message code="Label.Level" htmlEscape="true" /></strong>
															</div></th>
														<th><div align="center">
																<strong><spring:message code="Label.Designation" htmlEscape="true" /></strong>
															</div></th>
														<th><div align="center">
																<strong><spring:message code="Label.PostProposed" htmlEscape="true" /><br> A
																</strong>
															</div></th>
														<th><div align="center">
																<strong><spring:message code="Label.NoOfMonths" htmlEscape="true" /><br> B
																</strong>
															</div></th>
														<th><div align="center">
																<strong><spring:message code="Label.UnitCost" htmlEscape="true" /> (in Rs)<br>C
																</strong>
															</div></th>
														<th><div align="center">
																<strong><spring:message code="Label.FundProposed" htmlEscape="true" /> (in Rs)<br>D = A * B
																	* C
																</strong>
															</div></th>

														<th rowspan="2"><div align="center">
																<strong><spring:message code="Label.Remarks" htmlEscape="true" /></strong>
															</div></th>

													</tr>
												</thead>
												<tbody>
												<!-- spmu loop -->
													<c:forEach items="${LIST_OF_POST_LEVEL}" var="POST_LEVEL"
														varStatus="index" begin="0" end="3">
														<tr id="newRowHtml">
															<td><div align="center">
																	<strong>${POST_LEVEL.EGovPostLevel.postLevelName}
																	</strong>
																</div></td>
															<td><div align="center">
																	<strong>${POST_LEVEL.EGovPostName}</strong>
																</div></td>
															<td><div align="center">${eGovActivityForState.eGovSupportActivityDetails[index.index].noOfPosts }</div></td>
															<td><div align="center">${eGovActivityForState.eGovSupportActivityDetails[index.index].unitCost }</div></td>
															<td><div align="center">${eGovActivityForState.eGovSupportActivityDetails[index.index].months }</div></td>
															<td><div align="center">${eGovActivityForState.eGovSupportActivityDetails[index.index].funds }</div></td>
															<td><div align="center">${eGovActivityForState.eGovSupportActivityDetails[index.index].remarks }</div></td>
														</tr>  
													</c:forEach>

											<tr>
												<td><div align="center">
														<strong>SPMU <spring:message code="Label.TotalFund"
																htmlEscape="true" /></strong>
													</div></td>
												<td colspan="4"></td>
												<td><div align="center">${SPMU_TOTAL_STATE}</div></td>
											</tr>
											<tr>
												<td><div align="center">
														<strong>SPMU <spring:message
																code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
													</div></td>
												<td colspan="4"></td>
												<td><div align="center">${eGovActivityForState.additionalRequirementSpmu}</div></td>
											</tr>
											<tr>
											<!-- spmu loop end here -->

											<!-- dpmu loop starts from here -->
												<c:forEach items="${LIST_OF_POST_LEVEL}" var="POST_LEVEL"
													varStatus="index" begin="4" end="6">
													<tr id="newRowHtml">
														<td><div align="center">
																<strong>${POST_LEVEL.EGovPostLevel.postLevelName}
																</strong>
															</div></td>
														<td><div align="center">
																<strong>${POST_LEVEL.EGovPostName}</strong>
															</div></td>
														<td><div align="center">${eGovActivityForState.eGovSupportActivityDetails[index.index].noOfPosts }</div></td>
														<td><div align="center">${eGovActivityForState.eGovSupportActivityDetails[index.index].unitCost }</div></td>
														<td><div align="center">${eGovActivityForState.eGovSupportActivityDetails[index.index].months }</div></td>
														<td><div align="center">${eGovActivityForState.eGovSupportActivityDetails[index.index].funds }</div></td>
														<td><div align="center">${eGovActivityForState.eGovSupportActivityDetails[index.index].remarks }</div></td>
													</tr>
												</c:forEach>
												
												<tr>
												<td><div align="center">
														<strong>DPMU <spring:message code="Label.TotalFund"
																htmlEscape="true" /></strong>
													</div></td>
												<td colspan="4"></td>
												<td><div align="center">${DPMU_TOTAL_STATE}</div></td>
											</tr>
											<tr>
												<td><div align="center">
														<strong>DPMU <spring:message
																code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
													</div></td>
												<td colspan="4"></td>
												<td><div align="center">${eGovActivityForState.additionalRequirementDpmu}</div></td>
											</tr>
											<!-- dpmu loop ends here -->
											
											<tr>
												<td><div align="center">
														<strong><spring:message
																code="Label.TotalProposedFund" htmlEscape="true" /></strong>
													</div></td>
												<td colspan="4"></td>
												<td><div align="center">${eGovActivityForState.additionalRequirementSpmu + SPMU_TOTAL_STATE + eGovActivityForState.additionalRequirementDpmu + DPMU_TOTAL_STATE}</div></td>
											</tr>
										</tbody>
											</table>
										</div>
								<div class="col-md-4 text-left">
									<button type="button"
										onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
										class="btn bg-orange waves-effect">
										<i class="fa fa-arrow-left" aria-hidden="true"></i>
										<spring:message code="Label.BACK" htmlEscape="true" />
									</button>
								</div>
								<div class="text-right">
									<button type="button"
										onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-orange waves-effect">
										<spring:message code="Label.CLOSE" htmlEscape="true" />
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script>
	$('document').ready(function(){
		if( '${readOnlyEnabled}' == 'true'){
			$('.active123').prop('readonly',true);
		}
		else
			{
			$('.active123').prop('readonly' ,false)
			}
	});
</script>