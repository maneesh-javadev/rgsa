<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script>
$('document').ready(function(){
	onloadChangeColor();
	});

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

function submitValidation(){
	if($('#noOfGpID').val() == '' || $('#noOfGpID').val() == null){
		alert('some fields are blank.');
		$('#noOfGpID').focus();
		return false;
	}else if($('#aspirational').val() == '' || $('#aspirational').val() == null){
		return false;
	}else if($('#unitCostId').val() == '' || $('#unitCostId').val() == null){
		return false;
	}else{
		return true;
	}
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
		alert("Additional Requirement should be less than or equal to 25% of Total Fund : "+ (0.25 *document.getElementById("fund").value));
		document.getElementById("additionalRequirementId").value = '';
		document.getElementById("grandTotalId").value = '';
	}else{
		document.getElementById("grandTotalId").value = +document.getElementById("additionalRequirementId").value + +document.getElementById("fund").value;
	}
	onloadChangeColor();
}

function onloadChangeColor(){
	+$("#noOfGpID").val() < +$("#noOfGpIDMopr").text() ? $("#noOfGpIDMopr").css("color","red") : $("#noOfGpIDMopr").css("color","#00cc00");
	+$("#aspirational").val() < +$("#aspirationalMopr").text() ? $("#aspirationalMopr").css("color","red") : $("#aspirationalMopr").css("color","#00cc00");
	+$("#unitCostId").val() < +$("#unitCostIdMopr").text() ? $("#unitCostIdMopr").css("color","red") : $("#unitCostIdMopr").css("color","#00cc00");
	+$("#additionalRequirementId").val() < +$("#additionalRequirementIdMopr").text() ? $("#additionalRequirementIdMopr").css("color","red") : $("#additionalRequirementIdMopr").css("color","#00cc00");
	+$("#fund").val() < + $("#fundMopr").text() ? $("#fundMopr").css("color","red") : $("#fundMopr").css("color","#00cc00");
	+$("#grandTotalId").val() < +$("#grandTotalIdMopr").text() ? $("#grandTotalIdMopr").css("color","red") : $("#grandTotalIdMopr").css("color","#00cc00");
}

function changeColor(txt){
	if(+$("#"+txt).val() < +$("#"+txt+"Mopr").text() ){
		$("#"+txt+"Mopr").css("color","red");
	}else{
		$("#"+txt+"Mopr").css("color","#00cc00");
	}
	+$("#grandTotalId").val() < +$("#grandTotalIdMopr").text() ? $("#grandTotalIdMopr").css("color","red") : $("#grandTotalIdMopr").css("color","#00cc00");
	+$("#fund").val() < + $("#fundMopr").text() ? $("#fundMopr").css("color","red") : $("#fundMopr").css("color","#00cc00");
}
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2><spring:message code="Label.e-EnablementofPanchayats" htmlEscape="true" />(CEC)</h2>
					</div>
					<form:form method="post" action="enablepanchayat.html"
						modelAttribute="ENABLEMENT_OF_PANCHAYAT_MODEL" id="myForm" onsubmit="return submitValidation()">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="enablepanchayat.html" />" />
						<div class="body">
							<ul class="nav nav-tabs">
								<li class="nav-item"><a class="nav-link active"
									data-toggle="tab" href="#state"><spring:message code="Label.STATE" htmlEscape="true" /></a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab"
									href="#MOPR"><spring:message code="Label.MOPR" htmlEscape="true" /></a></li>
							</ul>

							<div class="tab-content">
							<div class="container tab-pane " id="state" 
									style="width: auto;">
									<div class="table-responsive">
										<table class="table table-bordered"">
											<thead>
												<tr>
													<th rowspan="2"><div align="center">
															<strong><spring:message code="Label.E-infrastructureResource" htmlEscape="true" /></strong>
														</div></th>

													<th rowspan="2"><div align="center">
															<strong><spring:message code="Label.NoOfGPs" htmlEscape="true" /><br>A
															</strong>
														</div></th>

													<th rowspan="2"><div align="center">
															<strong><spring:message code="Label.NoOfAspirationalGps" htmlEscape="true" /></strong>
														</div></th>

													<th rowspan="2"><div align="center">
															<strong><spring:message code="Label.UnitCost" htmlEscape="true" />(in Rs.) <br></>B
															</strong>
														</div></th>
													<th rowspan="2"><div align="center">
															<strong><spring:message code="Label.Funds" htmlEscape="true" />(in Rs.) <br> C = A*B
															</strong>
														</div></th>
													
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${INFRA_RESOURCE_LIST}"
													var="INFRA_RESOURCE" varStatus="index">
													<tr>
														<td><div align="center">
																<strong>${INFRA_RESOURCE.eaName}</strong>
															</div></td>
														<td><div align="center">${enablementDetailsForState[index.index].noOfUnit}</div></td>
														<td><div align="center">${enablementDetailsForState[index.index].aspirationalGps}</div></td>
														<td><div align="center">${enablementDetailsForState[index.index].unitCost}</div></td>
														<td><div align="center">${enablementDetailsForState[index.index].fund}</div></td>
														
													</tr>
												</c:forEach>
												<tr>
													<td><div align="center">
															<strong><spring:message code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td><div align="center">${ENABLEMENT_OF_PANCHAYAT_MODEL.additionalRequirementForState}</div></td>
												</tr>
												<tr>
													<td><div align="center">
															<strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td><div align="center">${ENABLEMENT_OF_PANCHAYAT_MODEL.additionalRequirementForState + enablementDetailsForState[0].fund}</div></td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="col-md-4">
										<button type="button"
											onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
											class="btn bg-orange waves-effect">
											<i class="fa fa-arrow-left" aria-hidden="true"></i>
											<spring:message code="Label.BACK" htmlEscape="true" />
										</button>
									</div>
									<div class="text-right">
										<button type="button"onclick="onClose('home.html?<csrf:token uri='home.html'/>')"class="btn bg-orange waves-effect"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
									</div>
								</div>
								<div role="tabpanel" class="container tab-pane active" id="MOPR" style="width: auto;">
									<div class="table-responsive">
										<table class="table table-bordered"">
											<thead>
												<tr>
													<th rowspan="2"><div align="center">
															<strong><spring:message code="Label.E-infrastructureResource" htmlEscape="true" /></strong>
														</div></th>

													<th rowspan="2"><div align="center">
															<strong><spring:message code="Label.NoOfGPs" htmlEscape="true" /><br>A
															</strong>
														</div></th>

													<th rowspan="2"><div align="center">
															<strong><spring:message code="Label.NoOfAspirationalGps" htmlEscape="true" /></strong>
														</div></th>

													<th rowspan="2"><div align="center">
															<strong><spring:message code="Label.UnitCost" htmlEscape="true" />(in Rs.) <br></>B
															</strong>
														</div></th>
													<th rowspan="2"><div align="center">
															<strong><spring:message code="Label.Funds" htmlEscape="true" />(in Rs.) <br> C = A*B
															</strong>
														</div></th>
														<%-- <th rowspan="2"><div align="center">
															<strong><spring:message code="Label.isApproved" htmlEscape="true" /></strong>
														</div></th> --%>
													<th rowspan="2"><div align="center">
															<strong><spring:message code="Label.Remarks" htmlEscape="true" /></strong>
														</div></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${INFRA_RESOURCE_LIST}"
													var="INFRA_RESOURCE" varStatus="index">
													<form:hidden
														path="eEnablementDetails[${index.index }].eEnablementDetailId" />
													<tr>
														<td><div align="center">
																<strong>${INFRA_RESOURCE.eaName}</strong>
															</div></td>
														<td>
																<div align="center" id="noOfGpIDMopr">${enablementDetailsForMOPR[index.index].noOfUnit}</div>
																<form:input maxlength="6"
																disabled="${enablement.status == 'f'}"
																onkeypress="return isNumber(event)"
																onkeyup="changeColor('noOfGpID')"
																path="eEnablementDetails[${index.index }].noOfUnit"
																class="form-control" id="noOfGpID"
																onchange="return validate()" style="text-align:right;" /></td>
														<td>
																<div align="center" id="aspirationalMopr">${enablementDetailsForMOPR[index.index].aspirationalGps}</div>
																<form:input maxlength="6"
																disabled="${enablement.status == 'f'}"
																onkeypress="return isNumber(event)"
																onkeyup="changeColor('aspirational')"
																path="eEnablementDetails[${index.index }].aspirationalGps"
																class="form-control" id="aspirational"
																onchange="return validate()" style="text-align:right;" /></td>
														<td>
																<div align="center" id="unitCostIdMopr">${enablementDetailsForMOPR[index.index].unitCost}</div>
																<form:input maxlength="6"
																disabled="${enablement.status == 'f'}"
																onkeypress="return isNumber(event)"
																onkeyup="changeColor('unitCostId')"
																path="eEnablementDetails[${index.index }].unitCost"
																type="text" class="form-control" id="unitCostId"
																onchange="return validate()" style="text-align:right;" /></td>
														<td>
																<div align="center" id="fundMopr">${enablementDetailsForMOPR[index.index].fund}</div>
																<form:input disabled="true"
																path="eEnablementDetails[${index.index }].fund"
																onchange="changeColor('fund')"
																type="text" class="form-control" id="fund"
																style="text-align:right;" /></td>
																<%-- <td><div align="center">
																<c:choose>
																	<c:when
																		test="${enablementDetailsForMOPR[index.index].isApproved eq true}">
																		<i class="fa fa-check" aria-hidden="true" style="color: #00cc00 "></i>
																	</c:when>
																	<c:otherwise>
																		<i class="fa fa-times" aria-hidden="true" style="color: red"></i>
																	</c:otherwise>
																</c:choose>
															</div></td> --%>
														<td>
												<div align="center">
													          <label class="addMore btn bg-green waves-effect" title="${enablementDetailsForMOPR[index.index].remarks}">Remark by MoPR</label>
                                                      
                                                                 <form:textarea
																	path="eEnablementDetails[${index.index }].remarks"
																	type="text" 
																	class="form-control" 
																	readonly="${enablement.status == 'f'}"
																	style="text-align:right;"
																	/></div>		
														
														
														<div align="center">${enablementDetailsForMOPR[index.index].remarks}</div></td>
													</tr>
													<form:hidden path="eEnablementDetails[${index.index }].eeMasterId" value="${INFRA_RESOURCE.eMasterId}" />
												</c:forEach>
												<tr>
													<td><div align="center">
															<strong><spring:message code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td>
															<div align="center" id="additionalRequirementIdMopr">${ENABLEMENT_OF_PANCHAYAT_MODEL.additionalRequirementForMopr}</div>
															<form:input path="additionalRequirement"
															disabled="${enablement.status == 'f'}" type="text"
															onkeypress="return isNumber(event)"
															class="active123 form-control"
															id="additionalRequirementId"
															onkeyup="calculateGrandTotal();changeColor('additionalRequirementId')"
															placeholder="25% of Total Cost "
															style="text-align:right;" /></td>
												</tr>
												<tr>
													<td><div align="center">
															<strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td>
														<div align="center" id="grandTotalIdMopr">${ENABLEMENT_OF_PANCHAYAT_MODEL.additionalRequirementForMopr + enablementDetailsForMOPR[0].fund}</div>
														<input type="text"
														onkeypress="return isNumber(event)"
														onchange="changeColor('grandTotalId')"
														class="active123 form-control" id="grandTotalId"
														readonly="readonly" style="text-align: right;" /></td>
														
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
									<div class="col-sm-8 text-right">
											<input type="hidden" id="status" name="status">
											<c:if test="${enablement.status eq 's' || enablement.status eq 'u' || enablement.status == undefined}">
												<button type="submit" onclick="setStatus('s')" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
											</c:if>
											<c:if test="${enablement.status eq 's' || enablement.status eq 'u' || enablement.status == undefined}">
											<c:choose>
											<c:when test="${INITIAL_FLAG}"><button type="submit" onclick="setStatus('f')" class="btn bg-green waves-effect" disabled="disabled"><spring:message code="Label.FREEZE" htmlEscape="true" /></button></c:when>
											<c:otherwise><button type="submit" onclick="setStatus('f')" class="btn bg-green waves-effect"><spring:message code="Label.FREEZE" htmlEscape="true" /></button></c:otherwise>
											</c:choose>
												
											</c:if>
											<c:if test="${enablement.status eq 'f'}">
												<button type="submit" onclick="setStatus('u')" class="btn bg-green waves-effect" ><spring:message code="Label.UNFREEZE" htmlEscape="true" /></button>
											</c:if>
										<c:if test="${enablement.status eq 's' || enablement.status eq 'u' || enablement.status == undefined}">
											<%-- <button type="button" class="btn bg-light-blue waves-effect reset"><spring:message code="Label.CLEAR" htmlEscape="true" /></button> --%>
										</c:if>
										<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
									</div>
								</div>
								</div>
								
							</div>
						</div>
						<input type="hidden" name="eEnablementId" value="${enablement.eEnablementId }">
						<input type="hidden" name="userType" value="${enablement.userType}">
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
