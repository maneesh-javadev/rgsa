<%@include file="../taglib/taglib.jsp"%>
<head>
<script>

function validate() {
	var noOfGps=document.getElementById("noOfGpID").value;
	var unitCost=document.getElementById("unitCostId").value;
	document.getElementById("fund").value = noOfGps * unitCost ;
	var aspirational =document.getElementById("aspirational").value;
	if(parseInt(aspirational) > parseInt(noOfGps))
		{
			alert("Aspirational should be less than or equal to No Of Gps! ");
			document.getElementById("aspirational").value ='';
			return false;
		}
	validateCeiling();
	calculateGrandTotal();
}

function setStatus(status){
	if(status == "s"){
		$('#myForm input').prop('disabled',false);
	}
	if(status == "u"){
		$('#myForm input').prop('disabled',false);
	}
	document.getElementById("status").value = status;
}

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

$('document').ready(function(){
	$(".reset").bind("click", function() {
	  $("input[type=text]").val('');
	});
	calculateGrandTotal();
});

function validateCeiling(){
	var unitCost=$("#unitCostId").val();
	if(unitCost > 40000){
		document.getElementById("unitCostId").value=0;
		alert("Unit Cost should be less than or equal to 40,000");
	}
}

function calculateGrandTotal(){
	var grand_total=0;
	if(document.getElementById("additionalRequirementId").value > 0.25 *document.getElementById("fund").value){
		alert("Additional Requirement should be less than or equal to 25% of Total Fund");
		document.getElementById("additionalRequirementId").value = '';
		document.getElementById("grandTotalId").value = '';
	}else{
		document.getElementById("grandTotalId").value = +document.getElementById("additionalRequirementId").value + +document.getElementById("fund").value;
	}
} 
</script>
</head>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<c:choose>
							<c:when test="${fn:containsIgnoreCase(user_type, 'M')}"><h2><spring:message code="Label.e-EnablementofPanchayats" htmlEscape="true" />(MOPR)</h2></c:when>
							<c:otherwise><h2><spring:message code="Label.e-EnablementofPanchayats" htmlEscape="true" /></h2></c:otherwise>
						</c:choose>
					</div>
					<form:form method="post" action="enablepanchayat.html" modelAttribute="ENABLEMENT_OF_PANCHAYAT_MODEL" id="myForm" onsubmit="disablingSave()">
								<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="enablepanchayat.html" />" />
					<div class="body">
					
						<div class="table-responsive">
						
							<table class="table table-bordered">
								<thead>
									<tr>
										<th rowspan="2"><div align="center">
												<strong><spring:message code="Label.E-infrastructureResource" htmlEscape="true" /></strong>
											</div></th>
										
										<th rowspan="2"><div align="center">
												<strong><spring:message code="Label.NoOfGPs" htmlEscape="true" /> <br>A
												</strong>
											</div></th>
										
										<th rowspan="2"><div align="center">
												<strong><spring:message code="Label.NoOfAspirationalGps" htmlEscape="true" /></strong>
											</div></th>
										
										<th rowspan="2"><div align="center">
												<strong><spring:message code="Label.UnitCost" htmlEscape="true" />(in Rs.) <br>B
												</strong>
											</div></th>
										<th rowspan="2"><div align="center">
												<strong><spring:message code="Label.Funds" htmlEscape="true" /> <br> C = A*B
												</strong>
											</div></th>
										<c:if test="${fn:containsIgnoreCase(user_type, 'M')}">
											<th rowspan="2"><div align="center">
												<strong><spring:message code="Label.isApproved" htmlEscape="true" /></strong>
											</div></th>
										</c:if>
										<th rowspan="2"><div align="center">
												<strong><spring:message code="Label.Remarks" htmlEscape="true" /></strong>
										</div></th>
										
										<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
											<th colspan="2" rowspan="1">
												<div align="center">
													<strong>Previous comment history</strong>
												</div>
											</th>
											</c:if>
										</tr>
										<tr>
											<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
												<th >
													<div align="center">
														<strong>State Previous Comments <span style="color: #396721;">&nbsp;<i class="fa fa-circle"></i></span></strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>MOPR's Feedback <span style="color: #bc6317;">&nbsp;<i class="fa fa-circle"></i></span></strong>
													</div>
												</th>
											</c:if>
										</tr>
								</thead>
								<tbody>
									<c:forEach items="${INFRA_RESOURCE_LIST}" var="INFRA_RESOURCE" varStatus="index">
										<form:hidden path="eEnablementDetails[${index.index }].eEnablementDetailId" />
											<tr>
												<td><div align="center"><strong>${INFRA_RESOURCE.eaName}</strong></div></td>
												<td><form:input maxlength="6" disabled="${enablement.status == 'f'}" onkeypress="return isNumber(event)" path="eEnablementDetails[${index.index }].noOfUnit" class="form-control" id="noOfGpID" onchange="return validate()" style="text-align:right;"/></td>
												<td><form:input maxlength="6" disabled="${enablement.status == 'f'}" onkeypress="return isNumber(event)" path="eEnablementDetails[${index.index }].aspirationalGps" class="form-control" id="aspirational" onchange="return validate()" style="text-align:right;"/></td>
												<td><form:input maxlength="6" disabled="${enablement.status == 'f'}" onkeypress="return isNumber(event)" path="eEnablementDetails[${index.index }].unitCost" type="text" class="form-control" id="unitCostId" onchange="return validate()" style="text-align:right;"/></td>
												<td><form:input disabled="true" path="eEnablementDetails[${index.index }].fund" type="text" class="form-control" id="fund" style="text-align:right;"/></td>
												<c:if test="${fn:containsIgnoreCase(user_type, 'M')}">
												<td><form:checkbox path="eEnablementDetails[${index.index }].isApproved" disabled="${enablement.status == 'f'}" /></td>
												</c:if>
												<td><form:textarea path="eEnablementDetails[${index.index }].remarks" readonly="${enablement.status == 'f'}" rows="2" cols="10" /></td>
												<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
														<td>
															<ol>
															<c:forEach items="${STATE_PRE_COMMENTS[index.index]}" varStatus="indexInner" var="stateComments">
															<li style="color: #396721;font-weight: bold;">
																<c:choose>
																	<c:when test="${not empty stateComments}">${stateComments}</c:when>
																	<c:otherwise>No comments by state</c:otherwise>
																</c:choose>
															</li><br>
															</c:forEach>
														</ol>
														</td>
													
													<td>
														<ol>
															<c:forEach items="${MOPR_PRE_COMMENTS[index.index]}" varStatus="indexMopr" var="moprComments">
															<li style="color: #bc6317;font-weight: bold;">
																<c:choose>
																	<c:when test="${not empty moprComments}">${moprComments}</c:when>
																	<c:otherwise>No comments by MOPR</c:otherwise>
																</c:choose>
															</li><br>
															</c:forEach>
														</ol>
													</td>
													</c:if>	
											</tr>
											<form:hidden path="eEnablementDetails[${index.index }].eeMasterId" value="${INFRA_RESOURCE.eMasterId}" />
									</c:forEach>
									<tr>
												<td><div align="center"><strong><spring:message code="Label.AdditionalRequirement" htmlEscape="true" /></strong></div></td>
												<td colspan="3"></td>
												<td>
												<form:input  path="additionalRequirement" disabled="${enablement.status == 'f'}" type="text" onkeypress="return isNumber(event)" class="active123 form-control" id="additionalRequirementId" onchange="" onkeyup="calculateGrandTotal()" placeholder="25% of Total Cost " style="text-align:right;"/>
												</td>
											</tr>
											<tr>
												<td><div align="center"><strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /></strong></div></td>
												<td colspan="3"></td>
												<td>
												<input type="text" onkeypress="return isNumber(event)" class="active123 form-control" id="grandTotalId" readonly="readonly" style="text-align:right;"/>
												</td>
											</tr>
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
							<input type="hidden" id="status" name="status">
							<c:if test="${enablement.status eq 's' || enablement.status eq 'u' || enablement.status == undefined || enablement.status eq 'U'}">
								<button type="submit" onclick="setStatus('s')" class="btn bg-green waves-effect save-button"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
							</c:if>
							<c:if test="${enablement.status != undefined}">
							<c:if test="${enablement.status eq 's' || enablement.status eq 'u' || enablement.status == undefined || enablement.status eq 'U'}">
								<button type="submit" onclick="setStatus('f')" class="btn bg-orange waves-effect"><spring:message code="Label.FREEZE" htmlEscape="true" /></button>
							</c:if>
							<c:if test="${enablement.status eq 'f'}">
								<button type="submit" onclick="setStatus('u')" class="btn bg-green waves-effect"><spring:message code="Label.UNFREEZE" htmlEscape="true" /></button>
							</c:if>
							</c:if>
							<c:if test="${enablement.status eq 's' || enablement.status eq 'u' || enablement.status == undefined || enablement.status eq 'U'}">
								<button type="button" class="btn bg-light-blue waves-effect reset"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
							</c:if>
							</c:if>
							<button type="button"onclick="onClose('home.html?<csrf:token uri='home.html'/>')"class="btn bg-red waves-effect"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
						</div>
					</div>
						<input type="hidden" name="eEnablementId" value="${enablement.eEnablementId }">
						<input type="hidden" name="userType" value="${enablement.userType}" >
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>

