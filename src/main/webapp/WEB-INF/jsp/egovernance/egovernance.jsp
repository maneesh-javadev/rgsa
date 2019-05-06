<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/eGovernance/e-Governance.js"></script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<c:choose>
							<c:when test="${fn:containsIgnoreCase(USER_TYPE, 'M')}">
								<h2>
									<spring:message code="Label.EGoveHeader" htmlEscape="true" />
									(MoPR)
								</h2>
							</c:when>
							<c:otherwise>
								<h2>
									<spring:message code="Label.EGoveHeader" htmlEscape="true" />
								</h2>
							</c:otherwise>
						</c:choose>

					</div>
					<form:form method="post" name="egovernance"
						action="egovernancesupportgroup.html"
						modelAttribute="EGOVERN_MODEL">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="egovernancesupportgroup.html" />" />
						<c:set var="count" value="0" scope="page" />
						<c:set var="countSpmu" value="0" scope="page" />
						<c:set var="countDpmu" value="0" scope="page" />
						<div class="body">
							<div class="row clearfix">
									<div class="form-group">
										<div class="col-sm-4">
											<label for="District">District supported for DPMU <span><sup style="color: red;">*</sup></span>
											</label>
										</div>
	
											<div class="col-sm-4">
										<div class="form-line">
											<form:input id="districtSupportedId" path="noOfDistrictSupported" class="form-control Align-Right"
												onkeypress="return isNumber(event)" style="text-align:right;" onkeyup="validateDistricts()" readonly="${eGovActivity.status eq true}" maxlength="7"/></div>
										</div>
										<input type="hidden" id="districtsInState" value="${DISTRICTS_IN_STATE}">
									</div>
								</div>
							<div class="table-responsive">
								<table id="tableId" class="table table-bordered">
									<thead>
										<tr>
											<th><div align="center">
													<strong><spring:message code="Label.Level"
															htmlEscape="true" /></strong>
												</div></th>
											<th><div align="center">
													<strong><spring:message code="Label.Designation"
															htmlEscape="true" /></strong>
												</div></th>
											<th><div align="center">
													<strong><spring:message code="Label.PostProposed"
															htmlEscape="true" /><br> A </strong>
												</div></th>
											<th><div align="center">
													<strong><spring:message code="Label.NoOfMonths"
															htmlEscape="true" /><br> B </strong>
												</div></th>
											<th><div align="center">
													<strong><spring:message code="Label.UnitCost"
															htmlEscape="true" />(in Rs)<br>C </strong>
												</div></th>
											<th><div align="center">
													<strong><spring:message code="Label.FundProposed"
															htmlEscape="true" />(in Rs)<br>D = A * B * C </strong>
												</div></th>
											<c:if test="${fn:containsIgnoreCase(USER_TYPE, 'M')}">
												<th rowspan="2"><div align="center">
														<strong><spring:message code="Label.IsApproved"
																htmlEscape="true" /></strong>
													</div></th>
												<th rowspan="2"><div align="center">
														<strong><spring:message code="Label.Remarks"
																htmlEscape="true" /></strong>
													</div></th>
											</c:if>
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
											<tr>
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
														<td><form:input
																path="eGovSupportActivityDetails[${index.index}].noOfPosts"
																type="text" onkeypress="return isNumber(event)"
																maxlength="5" class="active123 form-control"
																id="noOfPostId_${index.index}"
																onchange="calculateProposedFund(${index.index})"
																style="text-align:right;"
																disabled="${eGovActivity.status eq true}" /></td>
														<td><form:input
																path="eGovSupportActivityDetails[${index.index}].months"
																type="text" onkeypress="return isNumber(event)"
																class="active123 form-control" id="monthId_${index.index}"
																onchange="validateMonth(${count});calculateProposedFund(${index.index})"
																style="text-align:right;"
																disabled="${eGovActivity.status eq true}" /></td>
														<td><form:input
																path="eGovSupportActivityDetails[${index.index}].unitCost"
																type="text" onkeypress="return isNumber(event)"
																class="active123 form-control" id="unitCostId_${index.index}"
																onchange="calculateProposedFund(${index.index});validateCielingValue(${index.index})"
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
												<c:choose>
													<c:when test="${POST_LEVEL.eGovPostId eq 4}">
														<form:input
														path="eGovSupportActivityDetails[${index.index}].funds"
														type="text" onkeypress="return isNumber(event)"
														class="active123 form-control" id="fundId_${index.index}"
														onchange="calculateProposedFund(${index.index})"
														onkeyup="calculateTotalFundSpmu()"
														maxlength="6"
														style="text-align:right;" disabled="${eGovActivity.status eq true}"/>
													</c:when>
													<c:otherwise>
														<form:input
														path="eGovSupportActivityDetails[${index.index}].funds"
														type="text" onkeypress="return isNumber(event)"
														class="active123 form-control" id="fundId_${index.index}"
														onchange="calculateProposedFund(${index.index})"
														style="text-align:right;" readonly="true" />
													</c:otherwise>
												</c:choose>
												</td>
												<c:if test="${fn:containsIgnoreCase(USER_TYPE, 'M')}">
													<td><form:checkbox
															path="eGovSupportActivityDetails[${index.index }].isApproved"
															disabled="${eGovActivity.status eq true}" /></td>
													<td><form:textarea
															path="eGovSupportActivityDetails[${index.index }].remarks"
															rows="2" cols="10"
															disabled="${eGovActivity.status eq true}" /></td>
												</c:if>
											</tr>
											<c:set var="countSpmu" value="${countSpmu + 1}" scope="page" />
										</c:forEach>
										<tr>
											<td><div align="center">
													<strong>Total SPMU Fund</strong>
												</div></td>
											<td colspan="4"></td>
											<td><input type="text" class="active12 form-control"
												id="total_fund_spmu" 
												onkeypress="return isNumber(event)"
												style="text-align: right;" readonly="readonly" /></td>
										</tr>
										<tr>
											<td><div align="center">
													<strong>SPMU <spring:message code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
												</div></td>
											<td colspan="4"></td>
											<td><form:input path="additionalRequirementSpmu"
													type="text" onkeypress="return isNumber(event)"
													class="active123 form-control" id="additionalRequirementSpmuId"
													onchange="" onkeyup="calculateGrandTotal()"
													placeholder="25% of SPMU Cost" style="text-align:right;"
													readonly="${eGovActivity.status eq true}" /></td>
										</tr>
										
										<!-- second loop for Dpmu -->
										<c:set var="countDpmu" value="0" scope="page" /><tr>
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
														<td><form:input
																path="eGovSupportActivityDetails[${index.index}].noOfPosts"
																type="text" onkeypress="return isNumber(event)"
																maxlength="5" class="active123 form-control"
																id="noOfPostId_${index.index}"
																onchange="calculateProposedFund(${index.index})"
																style="text-align:right;"
																disabled="${eGovActivity.status eq true}" /></td>
														<td><form:input
																path="eGovSupportActivityDetails[${index.index}].months"
																type="text" onkeypress="return isNumber(event)"
																class="active123 form-control" id="monthId_${index.index}"
																onchange="validateMonth(${index.index});calculateProposedFund(${index.index})"
																style="text-align:right;"
																disabled="${eGovActivity.status eq true}" /></td>
														<td><form:input
																path="eGovSupportActivityDetails[${index.index}].unitCost"
																type="text" onkeypress="return isNumber(event)"
																class="active123 form-control" id="unitCostId_${index.index}"
																onchange="calculateProposedFund(${index.index});validateCielingValue(${index.index})"
																style="text-align:right;"
																disabled="${eGovActivity.status eq true}" /></td>
													</c:when>
													<c:otherwise>
														<td></td>
														<td></td>
														<td></td>
													</c:otherwise>
												</c:choose>
												<td><c:choose>
													<c:when test="${POST_LEVEL.eGovPostId eq 7}">
														<form:input
														path="eGovSupportActivityDetails[${index.index}].funds"
														type="text" onkeypress="return isNumber(event)"
														class="active123 form-control" id="fundId_${index.index}"
														onchange="calculateProposedFund(${index.index})"
														onkeyup="calculateTotalFundDpmu()" maxlength="6"
														style="text-align:right;" disabled="${eGovActivity.status eq true}" />
													</c:when>
													<c:otherwise>
														<form:input
														path="eGovSupportActivityDetails[${index.index}].funds"
														type="text" onkeypress="return isNumber(event)"
														class="active123 form-control" id="fundId_${index.index}"
														onchange="calculateProposedFund(${index.index})"
														style="text-align:right;" readonly="true" />
													</c:otherwise>
												</c:choose></td>
												<c:if test="${fn:containsIgnoreCase(USER_TYPE, 'M')}">
													<td><form:checkbox
															path="eGovSupportActivityDetails[${index.index}].isApproved"
															disabled="${eGovActivity.status eq true}" /></td>
													<td><form:textarea
															path="eGovSupportActivityDetails[${index.index}].remarks"
															rows="2" cols="10"
															disabled="${eGovActivity.status eq true}" /></td>
												</c:if>
											</tr>
											<c:set var="countDpmu" value="${countDpmu + 1}" scope="page" />
										</c:forEach>
										<tr>
											<td><div align="center">
													<strong>Total DPMU Fund</strong>
												</div></td>
											<td colspan="4"></td>
											<td><input type="text" class="active12 form-control"
												id="total_fund_dpmu"
												onkeypress="return isNumber(event)"
												style="text-align: right;" readonly="readonly" /></td>
										</tr>
										<tr>
											<td><div align="center">
													<strong>DPMU <spring:message code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
												</div></td>
											<td colspan="4"></td>
											<td><form:input path="additionalRequirementDpmu"
													type="text" onkeypress="return isNumber(event)"
													class="active123 form-control" id="additionalRequirementDpmuId"
													onchange="" onkeyup="calculateGrandTotal()"
													placeholder="25% of DPMU Cost" style="text-align:right;"
													readonly="${eGovActivity.status eq true}" /></td>
										</tr>
										<!-- Dpmu ends here -->
										<tr>
											<td><div align="center">
													<strong><spring:message
															code="Label.TotalProposedFund" htmlEscape="true" /></strong>
												</div></td>
											<td colspan="4"></td>
											<td><input type="text"
												onkeypress="return isNumber(event)"
												class="active123 form-control" id="grandTotalId"
												readonly="readonly" style="text-align: right;" /></td>
										</tr>
										<%-- </c:forEach> --%>
									</tbody>
								</table>
							</div>
							<c:if
								test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
								<div class="col-md-4  text-left" style="margin-bottom: 5px">
									&nbsp;&nbsp;
									<button type="button"
										onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
										class="btn bg-orange waves-effect">
										<i class="fa fa-arrow-left" aria-hidden="true"></i>
										<spring:message code="Label.BACK" htmlEscape="true" />
									</button>
									<br>
								</div>
							</c:if>
							<div class="text-right">
								<c:if test="${Plan_Status eq true}">
									<c:if
										test="${eGovActivity.status eq false || empty eGovActivity.status}">

										<button type="submit" class="btn bg-green waves-effect"
											id="saveId" onclick="validateMonth(${count});">
											<spring:message code="Label.SAVE" htmlEscape="true" />
										</button>
										<c:if test="${eGovActivity.status  != undefined}">
											<button type="button" onclick='freezeAndUnfreeze("freeze")'
												id="freezeId" class="btn bg-green waves-effect">
												<spring:message code="Label.FREEZE" htmlEscape="true" />
											</button>
										</c:if>
									</c:if>
									<c:if test="${eGovActivity.status eq true}">
										<button type="button" onclick='freezeAndUnfreeze("unfreeze")'
											id="unfreezeId" class="btn bg-green waves-effect">
											<spring:message code="Label.UNFREEZE" htmlEscape="true" />
										</button>
									</c:if>

									<c:if test="${eGovActivity.status eq false}">
										<button type="button"
											class="btn bg-light-blue waves-effect reset" id="clearId">
											<spring:message code="Label.CLEAR" htmlEscape="true" />
										</button>
									</c:if>
								</c:if>
								<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-orange waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
								<input type="hidden" name="dbFileName" id="dbFileName">
								<input type="hidden" name="eGovSupportActivityId"
									value="${eGovActivity.eGovSupportActivityId}" /> <input
									type="hidden" name="userType" value="${eGovActivity.userType}">
							</div>
							<input type="hidden" id="countSpmuId" value="${countSpmu}">
							<input type="hidden" id="countDpmuId" value="${countDpmu}">
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
<script>
/* 	$('document').ready(function(){
		if( '${readOnlyEnabled}' == 'true'){
			$('.active123').prop('readonly',true);
			$('#unfreezeId').show();
			$('#freezeId').hide();
			$('#saveId').hide();
			$('#clearId').hide();
		}
		else
			{
			$('.active123').prop('readonly' ,false);
			$('#unfreezeId').hide();
			$('#freezeId').show();
			$('#saveId').show();
			$('#clearId').show();
		}
			
	}); */
</script>