<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/eGovernance/e-Governance.js"></script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
					<c:choose>
					<c:when test="${fn:containsIgnoreCase(USER_TYPE, 'M')}"><h2><spring:message code="Label.EGoveHeader" htmlEscape="true" /> (MoPR)</h2></c:when>
					<c:otherwise><h2><spring:message code="Label.EGoveHeader" htmlEscape="true" /></h2></c:otherwise>
					</c:choose>
						
					</div>
					<form:form method="post" name="egovernance" action="egovernancesupportgroup.html"
						modelAttribute="EGOVERN_MODEL">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="egovernancesupportgroup.html" />" />
							<c:set var="count" value="0" scope="page" />
							<div class="body">
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
														<strong><spring:message code="Label.UnitCost" htmlEscape="true" />(in Rs)<br>C
														</strong>
													</div></th>
												<th><div align="center">
														<strong><spring:message code="Label.FundProposed" htmlEscape="true" />(in Rs)<br>D = A * B *
															C
														</strong>
													</div></th>
												<c:if test="${fn:containsIgnoreCase(USER_TYPE, 'M')}">
													<th rowspan="2"><div align="center">
														<strong><spring:message code="Label.IsApproved" htmlEscape="true" /></strong>
													</div></th>
													<th rowspan="2"><div align="center">
														<strong><spring:message code="Label.Remarks" htmlEscape="true" /></strong>
													</div></th>
												</c:if>
											</tr>
										</thead>
										<tbody id="tbodyId">
	 										<c:forEach items="${LIST_OF_POST_LEVEL}" var="POST_LEVEL"
												varStatus="index">
												<input type="hidden" name="eGovSupportActivityDetails[${index.index}].eGovPostId" value="${POST_LEVEL.eGovPostId}">
												<input type="hidden" id="postId_${count}" value="${POST_LEVEL.EGovPostLevel.postLevelId}">
												<form:hidden path="eGovSupportActivityDetails[${count}].eGovDetailsId" />
													<tr id="newRowHtml">
														<td><div align="center">
																<strong>${POST_LEVEL.EGovPostLevel.postLevelName} </strong>
															</div></td>
														<td><div align="center">
																<strong>${POST_LEVEL.EGovPostName}</strong>
															</div></td>
														<td><form:input  path="eGovSupportActivityDetails[${index.index}].noOfPosts" type="text" onkeypress="return isNumber(event)" maxlength="5" class="active123 form-control" id="noOfPostId_${count}" onchange="calculateProposedFund(${count})" style="text-align:right;" disabled="${eGovActivity.status eq true}"/></td>
														<td><form:input  path="eGovSupportActivityDetails[${index.index}].months" type="text" onkeypress="return isNumber(event)" class="active123 form-control" id="monthId_${count}" onchange="validateMonth(${count});calculateProposedFund(${count})" style="text-align:right;" disabled="${eGovActivity.status eq true}"/></td>
														<td><form:input  path="eGovSupportActivityDetails[${index.index}].unitCost" type="text" onkeypress="return isNumber(event)" class="active123 form-control" id="unitCostId_${count}" onchange="calculateProposedFund(${count});validateCielingValue(${count})" style="text-align:right;" disabled="${eGovActivity.status eq true}"/></td>
														<td><form:input  path="eGovSupportActivityDetails[${index.index}].funds" type="text" onkeypress="return isNumber(event)" class="active123 form-control" id="fundId_${count}" onchange="calculateProposedFund(${count})" style="text-align:right;" readonly="true"/></td>
														<c:if test="${fn:containsIgnoreCase(USER_TYPE, 'M')}">
													<td><form:checkbox path="eGovSupportActivityDetails[${index.index }].isApproved"  disabled="${eGovActivity.status eq true}"/></td>
													<td><form:textarea path="eGovSupportActivityDetails[${index.index }].remarks" rows="2" cols="10"  disabled="${eGovActivity.status eq true}"/></td>
													</c:if>	</tr>
													<c:set var="count" value="${count + 1}" scope="page"/>
												</c:forEach>
												<tr>
															<td><div align="center"><strong><spring:message code="Label.TotalFund" htmlEscape="true" /></strong></div></td>
															<td colspan="4"></td>
															<td><input type="text" class="active12 form-control" id="total_fund" value="${TOTAL_FUND}" onkeypress="return isNumber(event)" style="text-align:right;" readonly="readonly"/></td>
												</tr>
												<tr>
													<td><div align="center"><strong><spring:message code="Label.AdditionalRequirement" htmlEscape="true" /></strong></div></td>
													<td colspan="4"></td>
													<td>
													<form:input  path="additionalRequirement" type="text" onkeypress="return isNumber(event)" class="active123 form-control" id="additionalRequirementId" onchange="" onkeyup="calculateGrandTotal()" placeholder="25% of Total Cost"  style="text-align:right;" readonly="${eGovActivity.status eq true}"/>
													</td>
												</tr>
												<tr>
													<td><div align="center"><strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /></strong></div></td>
													<td colspan="4"></td>
													<td>
													<input type="text" onkeypress="return isNumber(event)" class="active123 form-control" id="grandTotalId" readonly="readonly" style="text-align:right;"/>
													</td>
												</tr>
											<%-- </c:forEach> --%>
										</tbody>
									</table>
								</div>
									<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
                        <div class="col-md-4  text-left"  style="margin-bottom: 5px">
								&nbsp;&nbsp;<button type="button"
									onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
									class="btn bg-orange waves-effect">
									<i class="fa fa-arrow-left" aria-hidden="true"></i>
									<spring:message code="Label.BACK" htmlEscape="true" />
								</button><br>
							</div>
							</c:if>
								<div class="text-right">
								  <c:if test="${Plan_Status eq true}"> 
										<c:if test="${eGovActivity.status eq false || empty eGovActivity.status}">
									  
										<button type="submit" class="btn bg-green waves-effect" id="saveId" onclick="validateMonth(${count});">
										<spring:message code="Label.SAVE" htmlEscape="true" /></button>
									<c:if test="${eGovActivity.status  != undefined}">
										<button type="button" onclick='freezeAndUnfreeze("freeze")' id="freezeId" class="btn bg-green waves-effect"><spring:message code="Label.FREEZE" htmlEscape="true" /></button>
										</c:if>
										</c:if>
										<c:if test="${eGovActivity.status eq true}">
										<button type="button" onclick='freezeAndUnfreeze("unfreeze")' id="unfreezeId" class="btn bg-green waves-effect" >
										<spring:message code="Label.UNFREEZE" htmlEscape="true" /></button>
										</c:if>
									
										<c:if test="${eGovActivity.status eq false}">
											<button type="button" class="btn bg-light-blue waves-effect reset" id="clearId"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
										</c:if>
										 </c:if> 
										<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
										<input type="hidden" name="dbFileName" id="dbFileName">
										<input type="hidden" name="eGovSupportActivityId" value="${eGovActivity.eGovSupportActivityId}" />
										<input type="hidden" name="userType" value="${eGovActivity.userType}" >
								</div>
								<input type="hidden" id="count" value="${count}">
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