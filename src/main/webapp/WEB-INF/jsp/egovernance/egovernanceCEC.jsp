<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/eGovernance/e-Governance.js"></script>
<script type="text/javascript">
$('documnet').ready(function(){
	changeColor();
});

function changeColor() {
	var rowCount = $('#tbodyId tr').length - 3;
	for (var i = 0; i < rowCount; i++) {
		
		+$('#noOfPostId_' + i).val() < +$('#noOfPostStateId_' + i).text() ? $(
				'#noOfPostStateId_' + i).css('color', 'red') : $(
				'#noOfPostStateId_' + i).css('color', '#00cc00');
		+$('#unitCostId_' + i).val() < +$('#unitCostStateId_' + i).text() ? $(
				'#unitCostStateId_' + i).css('color', 'red') : $(
				'#unitCostStateId_' + i).css('color', '#00cc00');
		+$('#fundId_' + i).val() < +$('#fundStateId_' + i).text() ? $(
				'#fundStateId_' + i).css('color', 'red') : $(
				'#fundStateId_' + i).css('color', '#00cc00');
	}
	$('#total_fund').val() < +$('#total_fund_State').text() ? $(
			'#total_fund_State').css('color', 'red') : $('#total_fund_State')
			.css('color', '#00cc00');
	$('#additionalRequirementId').val() < +$(
			'#additionalRequirementStateId').text() ? $(
			'#additionalRequirementStateId').css('color', 'red') : $(
			'#additionalRequirementStateId').css('color', '#00cc00');
	$('#grandTotalId').val() < +$('#grandTotalStateId').text() ? $(
			'#grandTotalStateId').css('color', 'red') : $('#grandTotalStateId')
			.css('color', '#00cc00');

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
							<div role="tabpanel" class="container tab-pane active" id="state"
								style="width: auto;">

								<form:form method="post" name="egovernance"
									action="egovernancesupportgroup.html" modelAttribute="EGOVERN_MODEL">
									<input type="hidden" name="<csrf:token-name/>"
										value="<csrf:token-value uri="egovernancesupportgroup.html" />" />
										<c:set var="count" value="0" scope="page" /> 
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
													</tr>
												</thead>
											<tbody id="tbodyId">
												<c:forEach items="${LIST_OF_POST_LEVEL}" var="POST_LEVEL"
													varStatus="index">
													<input type="hidden"
														name="eGovSupportActivityDetails[${index.index}].eGovPostId"
														value="${POST_LEVEL.eGovPostId}">
													<input type="hidden" id="postId_${count}"
														value="${POST_LEVEL.EGovPostLevel.postLevelId}">
													<form:hidden
														path="eGovSupportActivityDetails[${count}].eGovDetailsId" />
													<tr id="newRowHtml">
														<td><div align="center">
																<strong>${POST_LEVEL.EGovPostLevel.postLevelName}
																</strong>
															</div></td>
														<td><div align="center">
																<strong>${POST_LEVEL.EGovPostName}</strong>
															</div></td>
														<td>
														<div align="center" id="noOfPostStateId_${count}"><strong>${eGovActivityForState.eGovSupportActivityDetails[index.index].noOfPosts }</strong></div>
														<form:input
																path="eGovSupportActivityDetails[${index.index}].noOfPosts"
																type="text" onkeypress="return isNumber(event)"
																maxlength="5" class="active123 form-control"
																id="noOfPostId_${count}"
																onchange="calculateProposedFund(${count})"
																style="text-align:right;"
																disabled="${eGovActivity.status eq true}" /></td>
														<td>
														<div align="center" style="margin-top: 20px;"><strong>${eGovActivityForState.eGovSupportActivityDetails[index.index].months}</strong></div>
														<form:hidden path="eGovSupportActivityDetails[${index.index}].months"
																value="${eGovActivityForState.eGovSupportActivityDetails[index.index].months}" 
																id="monthId_${count}" /></td>
														<td>
														<div align="center" id="unitCostStateId_${count}"><strong>${eGovActivityForState.eGovSupportActivityDetails[index.index].unitCost}</strong></div>
														<form:input
																path="eGovSupportActivityDetails[${index.index}].unitCost"
																type="text" onkeypress="return isNumber(event)"
																class="active123 form-control" id="unitCostId_${count}"
																onkeyup="calculateProposedFund(${count});validateCielingValue(${count});changeColor()"
																style="text-align:right;"
																disabled="${eGovActivity.status eq true}" /></td>
														<td>
														<div align="center" id="fundStateId_${count}"><strong>${eGovActivityForState.eGovSupportActivityDetails[index.index].funds}</strong></div>
														<form:input
																path="eGovSupportActivityDetails[${index.index}].funds"
																type="text" onkeypress="return isNumber(event)"
																class="active123 form-control" id="fundId_${count}"
																onchange="calculateProposedFund(${count});changeColor()"
																style="text-align:right;"
																disabled="${eGovActivity.status eq true}" /></td>
													</tr>
													<c:set var="count" value="${count + 1}" scope="page" />
												</c:forEach>
												<tr>
													<td><div align="center">
															<strong><spring:message code="Label.TotalFund"
																	htmlEscape="true" /></strong>
														</div></td>
													<td colspan="4"></td>
													<td>
													<div align="center" id="total_fund_State"><strong>${TOTAL_FUND_STATE}</strong></div>
													<input type="text" class="active12 form-control"
														id="total_fund" value="${TOTAL_FUND}"
														onkeypress="return isNumber(event)"
														onchange="changeColor()"
														style="text-align: right;" readonly="readonly" /></td>
												</tr>
												<tr>
													<td><div align="center">
															<strong><spring:message
																	code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="4"></td>
													<td>
													<div align="center" id="additionalRequirementStateId"><strong>${eGovActivityForState.additionalRequirement}</strong></div>
													<form:input path="additionalRequirement"
															type="text" onkeypress="return isNumber(event)"
															class="form-control"
															id="additionalRequirementId"
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
													<div align="center" id="grandTotalStateId"><strong>${eGovActivityForState.additionalRequirement + TOTAL_FUND_STATE}</strong></div>
													
													<input type="text"
														onkeypress="return isNumber(event)"
														class="form-control" id="grandTotalId"
														readonly="readonly"
														onchange="changeColor()"
														style="text-align: right;" /></td>
												</tr>
												<%-- </c:forEach> --%>
											</tbody>
										</table>
										</div>

										<div class="text-right">
								 <%-- <c:if test="${Plan_Status eq true}"> --%>
										<c:if test="${eGovActivity.status eq false || empty eGovActivity.status}">
									  
										<button type="submit" class="btn bg-green waves-effect" id="saveId" onclick="validateMonth(${count});">
										<spring:message code="Label.SAVE" htmlEscape="true" /></button>
										<button type="button" onclick='freezeAndUnfreeze("freeze")' id="freezeId" class="btn bg-green waves-effect"><spring:message code="Label.FREEZE" htmlEscape="true" /></button>
										
										</c:if>
										<c:if test="${eGovActivity.status eq true}">
										<button type="button" onclick='freezeAndUnfreeze("unfreeze")' id="unfreezeId" class="btn bg-green waves-effect" >
										<spring:message code="Label.UNFREEZE" htmlEscape="true" /></button>
										</c:if>
										<%-- </c:if> --%>
										<c:if test="${eGovActivity.status eq false}">
											<button type="button" class="btn bg-light-blue waves-effect reset" id="clearId"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
										</c:if>
										<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
										<input type="hidden" name="dbFileName" id="dbFileName">
										<input type="hidden" name="eGovSupportActivityId" value="${eGovActivity.eGovSupportActivityId}" />
										<input type="hidden" name="userType" value="${eGovActivity.userType}" >
								</div>
								<input type="hidden" id="count" value="${count}">
								</form:form>
							</div>

							<div class="container tab-pane fade" id="MOPR"
								style="width: auto;">

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
																<strong><spring:message code="Label.IsApproved" htmlEscape="true" /></strong>
															</div></th>
														<th rowspan="2"><div align="center">
																<strong><spring:message code="Label.Remarks" htmlEscape="true" /></strong>
															</div></th>

													</tr>
												</thead>
												<tbody>

													<%-- <c:forEach items="eGovActivityDetailsForMOPR" var="EGovt_MOPR"> --%>
													<c:forEach items="${LIST_OF_POST_LEVEL}" var="POST_LEVEL"
														varStatus="index">

														<%-- 	<c:forEach items="${POST_LEVEL.eGovPosts}" var="POST"> --%>

														<tr id="newRowHtml">
															<td><div align="center">
																	<strong>${POST_LEVEL.EGovPostLevel.postLevelName}
																	</strong>
																</div></td>
															<td><div align="center">
																	<strong>${POST_LEVEL.EGovPostName}</strong>
																</div></td>
															<td><div align="center">${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].noOfPosts }</div></td>
															<td><div align="center">${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].unitCost }</div></td>
															<td><div align="center">${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].months }</div></td>
															<td><div align="center">${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].funds }</div></td>
															<td>
															<c:choose>
															<c:when test="${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].isApproved}"><i class="fa fa-check" aria-hidden="true" style="color: #00cc00 "></i></c:when>
															<c:otherwise><i class="fa fa-times" aria-hidden="true" style="color: red"></i></c:otherwise>
															</c:choose>
															</td>
															<td><div align="center">${eGovActivityForMOPR.eGovSupportActivityDetails[index.index].noOfPosts }</div></td>
														</tr>
													</c:forEach>

											<tr>
												<td><div align="center">
														<strong><spring:message code="Label.TotalFund"
																htmlEscape="true" /></strong>
													</div></td>
												<td colspan="4"></td>
												<td><div align="center">${TOTAL_FUND_MOPR}</div></td>
											</tr>
											<tr>
												<td><div align="center">
														<strong><spring:message
																code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
													</div></td>
												<td colspan="4"></td>
												<td><div align="center">${eGovActivityForMOPR.additionalRequirement}</div></td>
											</tr>
											<tr>
												<td><div align="center">
														<strong><spring:message
																code="Label.TotalProposedFund" htmlEscape="true" /></strong>
													</div></td>
												<td colspan="4"></td>
												<td><div align="center">${eGovActivityForMOPR.additionalRequirement + TOTAL_FUND_MOPR}</div></td>
											</tr>
										</tbody>
											</table>
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