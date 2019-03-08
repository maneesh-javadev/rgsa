<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script>

$('document').ready(function(){
	if(document.getElementById("ISFREEZE") != null){
		var myBoolean= document.getElementById("ISFREEZE").value;
	}
	 if(myBoolean == "true"){
		 $("input").prop('disabled', true);
	}
	if($('#userType').val() == 'M'){
		$('#file').attr('disabled',true);
	}
	
    if( '${readOnlyEnabled}' == 'true'){
        $('.active12').prop('readonly',true);
        $('#activedropdown').prop('disabled',true);
    }
    else
        {
        $('.active12').prop('readonly',false);
        $('#activedropdown').prop('disabled',false);
        }
    onLoadChangeColor();
});
/* $('document').ready(function(){
	 $('.active1').prop('readonly',true);
    
}); */

	function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
	}
	
	/* function calculateFund(obj)
	{
		document.getElementById("fund_"+obj).value = document.getElementById("noOfMonths_"+obj).value * document.getElementById("noOfUnits_"+obj).value * document.getElementById("unitCost_"+obj).value ;
		 document.getElementById("totalFund_"+obj).value = document.getElementById("fund_"+obj).value;
		calculateTotal(obj)
	} */

	function validateMonth(obj)
	{
		var noOfMonths = document.getElementById("noOfMonths_"+obj).value;
		if( +noOfMonths == 0 || +noOfMonths > 12)
		{
			alert("Months should be less than 12 !");
			document.getElementById("noOfMonths_"+obj).value = '';
			/* calculateFund(obj); */
		}
	}
	
	function calculateTotal(obj){
		var rowCount = $('#tab tr').length;
		var total=0;
		for(var i=0;i<=rowCount;i++){
			if($("#fund_"+i).val() != '' && $("#fund_"+i).val() != undefined)
			total += +$("#fund_"+i).val();
		}
		document.getElementById("total").value =total;
		calculateGrandTotal();
	}
	
	function calculateGrandTotal(){
		document.getElementById("grandTotal").value = +document.getElementById("total").value + +document.getElementById("additionalRequirement").value;
	}
	
	function validatingAdditionalRequirement(obj){
		var grand_total=0;
		for(var i=0;i<obj;i++){
			grand_total += +$("#fund_"+i).val();
		}
		if(($("#additionalRequirement").val()>(grand_total*0.25))){
			alert("Additional Requirement should be smaller than or equal to 25% of Fund="+ 0.25*grand_total+"");
			document.getElementById("additionalRequirement").value=0;
		}
	}
	
	function validateCeilingValue(count){
		var rowCount=$('#tbodyMainTableId tr').length -3;
			var total_unit_cost_sprc = 0;
			var total_unit_cost_dprc = 0;
			for(var i =0;i < rowCount;i++){
				if($("#trainingInstituteId_"+i).val() == 2){
					if($("#fund_"+i).val() != ""){
						total_unit_cost_sprc += parseInt($("#fund_"+i).val());
					}
				}else{
					if($("#fund_"+i).val() != ""){
						total_unit_cost_dprc += parseInt($("#fund_"+i).val());
					}
				}
			}
			if(total_unit_cost_sprc > 4000000){
				alert("Total unit cost for SPRC should be less than or equal to 40 lakhs per year");
				/* $("#unitCost_"+count).val(''); */
				/* $("#noOfMonths_"+count).val(''); */
				$("#fund_"+count).val('');
				/* calculateFund(count); */
			}
			 if($("#trainingInstituteId_"+count).val() == 4){
				 if($('#districtSupportedId').val() != ""){
					 if((total_unit_cost_dprc / $('#districtSupportedId').val()) > 1000000){
				alert("Total unit cost for DPRC should be less than or equal to 10 lakhs per year");
							/* $("#unitCost_"+count).val(''); */
				/* $("#noOfMonths_"+count).val(''); */
				$("#fund_"+count).val('');
				/* calculateFund(count); */
			}
				 }else{
					 alert("Enter The no. of District supported by DPRC First.");
					 $("#fund_"+count).val('');
					/*  calculateFund(count); */
				 }
			 }
			
		}

function freezeAndUnfreeze(obj){
	$("input").prop('disabled', false);
	$('#textarea').attr('disabled',false);
	document.getElementById("dbFileName").value = obj;
	document.additionalFacultyAndMain.method = "post";
	document.additionalFacultyAndMain.action = "addFacultyAndMaintenanceHrBudget.html?<csrf:token uri='addFacultyAndMaintenanceHrBudget.html'/>";
	document.additionalFacultyAndMain.submit();
}

function onLoadChangeColor(){
	var rowCount = $('#tbody tr').length - 3; /* minus 3 is done because length is counting additional requirement, total fund and grand total and we dont need it*/
	var rowModal1 =  $('#modal1Tbody tr').length;
	var rowModal2 = $('#modal2Tbody tr').length;
 	for(var i=0;i<rowCount;i++){
		/* +$("#noOfUnitsState_"+i).text() > +$("#noOfUnits_"+i).val() ? $("#noOfUnitsState_"+i).css('color','red') : $("#noOfUnitsState_"+i).css('color','#00cc00');
		+$("#unitCostState_"+i).text() > +$("#unitCost_"+i).val() ? $("#unitCostState_"+i).css('color','red') : $("#unitCostState_"+i).css('color','#00cc00');
		+$("#noOfMonthsState_"+i).text() > +$("#noOfMonths_"+i).val() ? $("#noOfMonthsState_"+i).css('color','red') : $("#noOfMonthsState_"+i).css('color','#00cc00'); */
		+$("#noOfUnitsState_"+i).text() > +$("#noOfUnits_"+i).val() ? $("#noOfUnitsState_"+i).css('color','red') : $("#noOfUnitsState_"+i).css('color','#00cc00');
		if($("#fund"+i).val() == undefined){
			$("#fund"+i).val(0);
		}
		+$("#fundState_"+i).text() > +$("#fund_"+i).val() ? $("#fundState_"+i).css('color','red') : $("#fundState_"+i).css('color','#00cc00');
	}
	+$("#totalState").text() > +$("#total").val() ? $("#totalState").css('color','red') : $("#totalState").css('color','#00cc00');
	+$("#additionalRequirementState").text() > +$("#additionalRequirement").val() ? $("#additionalRequirementState").css('color','red') : $("#additionalRequirementState").css('color','#00cc00');
	+$("#grandTotalState").text() > +$("#grandTotal").val() ? $("#grandTotalState").css('color','red') : $("#grandTotalState").css('color','#00cc00');
	
	/* for(var j=0;j < rowModal1 ;j++){
		+$("#noOfFacultyState_"+j).text() > +$("#noOfFaculty_"+j).val() ? $("#noOfFacultyState_"+j).css('color','red') : $("#noOfFacultyState_"+j).css('color','#00cc00');
	}
	for(var j=3 ; j < rowModal2 + 3 ; j++){
		+$("#noOfExpertState_"+j).text() > +$("#noOfExpert_"+j).val() ? $("#noOfExpertState_"+j).css('color','red') : $("#noOfExpertState_"+j).css('color','#00cc00');
	} */
}

function domainValidation(obj){
	var rowCountSprc=$('#tbodySprcId tr').length;
	var noOfDomainSprc=0;
	var noOfDomainDprc=0;
	for(var i=0;i<rowCountSprc;i++){
		noOfDomainSprc += Number($('#noOfFaculty_'+i).val()) ;
		noOfDomainDprc += Number($('#noOfExperts_'+(i+3)).val());
	}
	if($('#noOfUnits_0').val() < noOfDomainSprc){
		alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_0').val());
		$('#noOfFaculty_'+obj).val('');
	}else if($('#noOfUnits_3').val() < noOfDomainDprc){
		alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_3').val());
		$('#noOfExperts_'+obj).val('');
	}
}

</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Label.HrBudgetHeader" htmlEscape="true" />
							(CEC)
						</h2>
					</div>
					<form:form method="post" name="additionalFacultyAndMain"
						action="addFacultyAndMaintenanceHrBudget.html"
						modelAttribute="ADDITIONAL_FACULTY_MAINT_MODEL">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="addFacultyAndMaintenanceHrBudget.html" />" />
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
								<div role="tabpanel" class="container tab-pane active"
									id="state" style="width: auto;">
									<div class="row clearfix">
										<div class="form-group">
											<div class="col-sm-4">
												<label for="District"><spring:message
														code="Label.DistrictsupportedDprc" htmlEscape="true" /><span><sup
														style="color: red;">*</sup></span> </label>
											</div>

											<div class="col-sm-2">
												<div align="center">
													<strong>${institueInfraHrActivityState.districtsSupported}</strong>
												</div>
												<form:hidden id="districtSupportedId"
													path="districtsSupported"
													value="${institueInfraHrActivityState.districtsSupported}" />
											</div>
										</div>
									</div>
									<div class="table-responsive">
										<table class="table table-bordered">
											<thead>
												<tr>
													<th><div align="center">
															<spring:message code="Label.TypeOfCenter"
																htmlEscape="true" />
														</div></th>
													<th><div align="center">
															<spring:message code="Label.Faculty&Staff"
																htmlEscape="true" />
														</div></th>
													<th><div align="center">
															<spring:message code="Label.NoofUnits" htmlEscape="true" />
														</div></th>
													<%-- <th><div align="center">
															<spring:message code="Label.UnitCost" htmlEscape="true" />
														</div></th> --%>
													<th><div align="center">
															<spring:message code="Label.NoOfMonths" htmlEscape="true" />
														</div></th>
													<th><div align="center">
															<spring:message code="Label.Funds" htmlEscape="true" />
														</div></th>
													<th><div align="center">
															<spring:message code="Label.DomainDetails"
																htmlEscape="true" />
														</div></th>
													<th><div align="center">
															<spring:message code="Label.Remarks" htmlEscape="true" />
														</div></th>
												</tr>
											</thead>
											<tbody id="tbody">
												<c:set var="count" value="0" scope="page" />
												<c:forEach items="${LIST_OF_ACTIVITY_HR_TYPE}"
													var="ACTIVITY">
													<input type="hidden" id="ISFREEZE" value="${ISFREEZE}" />
													<input type="hidden" id="trainingInstituteId_${count}"
														value="${ACTIVITY.trainingInstitueType.trainingInstitueTypeId}" />
													<form:hidden
														path="institueInfraHrActivityDetails[${count}].instituteInfraHrActivityType.instituteInfraHrActivityTypeId"
														value="${ACTIVITY.instituteInfraHrActivityTypeId}" />
													<form:hidden
														path="institueInfraHrActivityDetails[${count}].instituteInfrsaHrActivityDetailsId" />
													<tr>
														<td><div align="center">
																<strong>${ACTIVITY.trainingInstitueType.trainingInstitueTypeName}</strong>
															</div></td>

														<td><div align="center">
																<strong>${ACTIVITY.instituteInfraHrActivityName}</strong>
															</div></td>

														<td>
															<div align="center" id="noOfUnitsState_${count}">${institueInfraHrActivityDetailsState[count].noOfUnits}</div>
															<c:if test="${count ne 2 and count ne 5}">
															<form:input
																path="institueInfraHrActivityDetails[${count}].noOfUnits"
																onkeypress="return isNumber(event)"
																class="active12 form-control Align-Right"
																onkeyup="onLoadChangeColor()"
																id="noOfUnits_${count}" />
																</c:if>
														</td>

														<%-- <td>
														<div align="center" id="unitCostState_${count}">${institueInfraHrActivityDetailsState[count].unitCost}</div>
														<form:input
																path="institueInfraHrActivityDetails[${count}].unitCost"
																type="text" maxlength="7"
																onkeypress="return isNumber(event)"
																class="active12 form-control Align-Right"
																id="unitCost_${count}"
																onkeyup="calculateFund(${count});validateCeilingValue(${count});onLoadChangeColor()" /></td> --%>

														<td>
															<div align="center" id="noOfMonthsState_${count}">${institueInfraHrActivityDetailsState[count].noOfMonths}</div>
															<form:hidden
																path="institueInfraHrActivityDetails[${count}].noOfMonths"
																value="${institueInfraHrActivityDetailsState[count].noOfMonths}"
																id="noOfMonths_${count}" />
														</td>

														<td>
															<div align="center" id="fundState_${count}">${institueInfraHrActivityDetailsState[count].fund}</div>
															<form:input
																path="institueInfraHrActivityDetails[${count}].fund"
																readonly="" type="text"
																onkeypress="return isNumber(event)"
																class="active12 form-control Align-Right"
																onkeyup="calculateTotal(${count});onLoadChangeColor()" id="fund_${count}" />
														</td>

														<c:choose>
															<c:when test="${count eq 0 }">
																<td><button type="button"
																		class="btn btn-primary btn-lg" data-toggle="modal"
																		data-target="#myModal">Fill Domain Details</button></td>
															</c:when>

															<c:when test="${count eq 3}">
																<td><button type="button"
																		class="btn btn-primary btn-lg" data-toggle="modal"
																		data-target="#myModal2">Fill Domain Details</button></td>
															</c:when>
															<c:otherwise>
																<td></td>
															</c:otherwise>
														</c:choose>
														<td><form:textarea
																path="institueInfraHrActivityDetails[${count}].remarks"
																rows="3" cols="5" class="active12 form-control" /></td>
													</tr>
													<c:set var="count" value="${count +1}" scope="page" />
												</c:forEach>
												<tr>
													<td><div align="center">
															<strong><spring:message code="Label.TotalCost"
																	htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td>
														<div align="center" id="totalState">${totalState}</div> <form:input
															path="total" type="text"
															class="active12 form-control Align-Right" id="total"
															onkeypress="return isNumber(event)"
															onkeyup="validatingAdditionalRequirement(${count});calculateGrandTotal(${ACTIVITY.trainingInstitueType.trainingInstitueTypeId},${count});onLoadChangeColor()"
															disabled="true" />
													</td>
												</tr>
												<tr>
													<td><div align="center">
															<strong><spring:message
																	code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td>
														<div align="center" id="additionalRequirementState">${additionalRequirementState}</div>
														<form:input path="additionalRequirement" type="text"
															onkeypress="return isNumber(event)"
															class="active12 form-control Align-Right"
															id="additionalRequirement"
															onkeyup="validatingAdditionalRequirement(${count});calculateGrandTotal();onLoadChangeColor()" />
													</td>
												</tr>
												<tr>
													<td><div align="center">
															<strong><spring:message
																	code="Label.TotalProposedFund" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td>
														<div align="center" id="grandTotalState">${additionalRequirementState + totalState}</div>
														<form:input path="grand_total" type="text"
															class="active12 form-control Align-Right" id="grandTotal"
															onchange="validatingAdditionalRequirement(${count});onLoadChangeColor()"
															disabled="true" />
													</td>
												</tr>
											</tbody>
										</table>
										<input type="hidden" name="dbFileName" id="dbFileName">
										<input type="hidden" name="instituteInfraHrActivityId"
											value="${institueInfraHrActivity.instituteInfraHrActivityId}">
										<form:hidden path="userType"
											value="${PREVIOUS_RECORD_USER_TYPE}" />

										<div id="myModal" class="modal fade" role="dialog">
											<div class="modal-dialog">

												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">&times;</button>
													</div>
													<div class="modal-body">
														<div class="row">
															<div class="form-group">
																<label for="sprc" class="col-sm-3"><spring:message
																		code="Label.InstituteType" htmlEscape="true" /></label>
																<div class="col-sm-5" style="display: contents;">
																	<!-- <select> -->
																	<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS"
																		begin="1" end="1">
																		<c:if
																			test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 2}">
																			<p class="text-justify">
																				<strong>
																					${DOMAINS.trainingInstitueType.trainingInstitueTypeName}</strong>
																			</p>
																			<%-- <option value="${DOMAINS.trainingInstitueType.trainingInstitueTypeId}">${DOMAINS.trainingInstitueType.trainingInstitueTypeName }</option> --%>
																		</c:if>
																	</c:forEach>
																	<!-- </select> -->
																</div>
															</div>
														</div>
														<div class="row clearfix">

															<div class="body">
																<div class="table-responsive">
																	<table class="table table-bordered">
																		<thead>
																			<tr>
																				<th><div align="center">
																						<spring:message code="Label.Domain"
																							htmlEscape="true" />
																					</div></th>
																				<th><div align="center">
																						<spring:message code="Label.NoOfExperts"
																							htmlEscape="true" />
																					</div></th>
																			</tr>
																		</thead>
																		<tbody id="modal1Tbody">
																			<c:set var="temp" value="0" scope="page" />
																			<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS">
																				<c:if
																					test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 2 }">
																					<form:hidden
																						path="tIWiseProposedDomainExperts[${temp}].tiWiseProposedDomainExpertsId" />
																					<tr>
																						<th><div align="center">${DOMAINS.domainName}</div>
																							<input type="hidden"
																							name="tIWiseProposedDomainExperts[${temp}].domainId"
																							value="${DOMAINS.domainId}"></th>
																						<td>
																							<div align="center" id="noOfFacultyState_${temp}">${tIWiseProposedDomainExpertsState[temp].noOfExperts}</div>
																							<form:hidden
																								path="tIWiseProposedDomainExperts[${temp}].noOfExperts"
																								value="${tIWiseProposedDomainExpertsState[temp].noOfExperts}"
																								id="noOfFaculty_${temp}" />
																						</td>
																					</tr>
																				</c:if>
																				<c:set var="temp" value="${temp+1}" scope="page" />
																			</c:forEach>
																		</tbody>
																	</table>
																</div>
															</div>
														</div>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-danger"
															data-dismiss="modal">Close</button>
													</div>
												</div>

											</div>
										</div>

										<div id="myModal2" class="modal fade" role="dialog">
											<div class="modal-dialog">

												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">&times;</button>
													</div>
													<div class="modal-body">
														<div class="row">
															<div class="form-group">
																<label for="sprc" class="col-sm-3"><spring:message
																		code="Label.InstituteType" htmlEscape="true" /></label>
																<div class="col-sm-6" style="display: contents;">
																	<!-- <select> -->
																	<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS"
																		begin="1" end="3">
																		<c:if
																			test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 4}">
																			<p class="text-justify">
																				<strong>${DOMAINS.trainingInstitueType.trainingInstitueTypeName}</strong>
																			</p>
																			<%-- <option value="${DOMAINS.trainingInstitueType.trainingInstitueTypeId}">${DOMAINS.trainingInstitueType.trainingInstitueTypeName}</option> --%>
																		</c:if>
																	</c:forEach>
																	<!-- </select> -->
																</div>
															</div>
														</div>
														<div class="row">
															<div class="form-group">
																<label for="Dprc" class="col-sm-3"><spring:message
																		code="Label.District" htmlEscape="true" /></label>
																<div class="col-sm-3">
																	<form:hidden path="districtCode"
																		value="${SELECTED_DISTRICT_IN_STATE.districtCode }"
																		id="activedropdownState" />
																	<div id="districtStateId"
																		style="font-weight: bold; margin-left: -12px;">${SELECTED_DISTRICT_IN_STATE.districtNameEnglish}</div>
																	<%-- <form:select path="districtCode" id="activedropdown">
																		<option value="0">---select---</option>
																		<c:forEach items="${LIST_OF_DISTRICT}" var="DISTRICT" >
																			<form:option value="${DISTRICT.districtCode}">${DISTRICT.districtNameEnglish}</form:option>
																		</c:forEach>
																	</form:select> --%>
																</div>
															</div>
														</div>
														<div class="row clearfix">
															<div class="body">
																<div class="table-responsive">
																	<table class="table table-bordered">
																		<thead>
																			<tr>
																				<th><div align="center">
																						<spring:message code="Label.Domain"
																							htmlEscape="true" />
																					</div></th>
																				<th><div align="center">
																						<spring:message code="Label.NoOfExperts"
																							htmlEscape="true" />
																					</div></th>
																			</tr>
																		</thead>
																		<tbody id="modal2Tbody">
																			<c:set var="index" value="0" scope="page" />
																			<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS">
																				<c:if
																					test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 4}">
																					<form:hidden
																						path="tIWiseProposedDomainExperts[${index}].tiWiseProposedDomainExpertsId" />
																					<tr>
																						<th><div align="center">${DOMAINS.domainName}</div>
																							<input type="hidden"
																							name="tIWiseProposedDomainExperts[${index}].domainId"
																							value="${DOMAINS.domainId}"></th>
																						<td>
																							<div align="center" id="noOfExpertState_${index}">${tIWiseProposedDomainExpertsState[index].noOfExperts}</div>
																							<form:hidden
																								path="tIWiseProposedDomainExperts[${index}].noOfExperts"
																								value="${tIWiseProposedDomainExpertsState[index].noOfExperts}"
																								id="noOfExpert_${index}" />
																						</td>
																					</tr>
																				</c:if>
																				<c:set var="index" value="${index+1}" scope="page" />
																			</c:forEach>
																		</tbody>
																	</table>
																</div>
															</div>
														</div>
													</div>
													<div class="modal-footer">
														<!-- <button type="button" class="btn btn-success">Save</button> -->
														<button type="button" class="btn btn-danger"
															data-dismiss="modal">Close</button>
													</div>
												</div>

											</div>
										</div>
									</div>
									<div class="row clearfix">
									<div class="col-md-4 text-left">
											<button type="button"
												onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
												class="btn bg-orange waves-effect">
												<i class="fa fa-arrow-left" aria-hidden="true"></i>
												<spring:message code="Label.BACK" htmlEscape="true" />
											</button>
										</div>
									<div class="col-md-8 text-right">
										<c:if test="${ISFREEZE eq false}">
											<button type="submit" class="btn bg-green waves-effect"
												id="save">
												<spring:message code="Label.SAVE" htmlEscape="true" />
											</button>
											<c:choose>
										<c:when test="${initial_status}">
										<button type="button"
												class="freeze btn bg-green waves-effect"
												onclick='freezeAndUnfreeze("freeze")' disabled="disabled">
												<spring:message code="Label.FREEZE" htmlEscape="true" />
											</button>
										</c:when>
										<c:otherwise>
										<button type="button"
												class="freeze btn bg-green waves-effect"
												onclick='freezeAndUnfreeze("freeze")'>
												<spring:message code="Label.FREEZE" htmlEscape="true" />
											</button>
										</c:otherwise>
										</c:choose>
											<button type="button" onclick="onClear(this)"
												class="btn bg-light-blue waves-effect" id="clear">
												<spring:message code="Label.CLEAR" htmlEscape="true" />
											</button>
										</c:if>

										<c:if test="${ISFREEZE eq true}">
											<button type="button"
												class="unfreeze btn bg-green waves-effect"
												onclick='freezeAndUnfreeze("unfreeze")'>
												<spring:message code="Label.UNFREEZE" htmlEscape="true" />
											</button>
										</c:if>
										<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">
											<spring:message code="Label.CLOSE" htmlEscape="true" />
										</button>

									</div>
									</div>
								</div>


								<div class="container tab-pane fade" id="MOPR"
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
													<strong>${institueInfraHrActivityMopr.districtsSupported}</strong>
												</div>
											</div>
										</div>
									</div>
									<div class="table-responsive">
										<table class="table table-bordered" id="tab">
											<thead>
												<tr>
													<th><div align="center">
															<spring:message code="Label.TypeOfCenter"
																htmlEscape="true" />
														</div></th>
													<th><div align="center">
															<spring:message code="Label.Faculty&Staff"
																htmlEscape="true" />
														</div></th>
													<th><div align="center">
															<spring:message code="Label.NoofUnits" htmlEscape="true" />
														</div></th>
													<%-- <th><div align="center">
														<spring:message code="Label.UnitCost" htmlEscape="true" />
													</div></th> --%>
													<th><div align="center">
															<spring:message code="Label.NoOfMonths" htmlEscape="true" />
														</div></th>
													<th><div align="center">
															<spring:message code="Label.Funds" htmlEscape="true" />
														</div></th>
													<th><div align="center">
															<spring:message code="Label.DomainDetails"
																htmlEscape="true" />
														</div></th>
													<th><div align="center">
															<spring:message code="Label.IsApproved" htmlEscape="true" />
														</div></th>
													<th><div align="center">
															<spring:message code="Label.Remarks" htmlEscape="true" />
														</div></th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<c:set var="count" value="0" scope="page" />
													<c:forEach items="${LIST_OF_ACTIVITY_HR_TYPE}"
														var="ACTIVITY" varStatus="index">
														<tr>
															<td><div align="center">
																	<strong>${ACTIVITY.trainingInstitueType.trainingInstitueTypeName}</strong>
																</div></td>

															<td><div align="center">
																	<strong>${ACTIVITY.instituteInfraHrActivityName}</strong>
																</div></td>

															<td><div align="center">${institueInfraHrActivityDetailsMopr[count].noOfUnits}</div></td>

															<%-- <td><div align="center">${institueInfraHrActivityDetailsMopr[count].unitCost}</div></td> --%>

															<td><div align="center">${institueInfraHrActivityDetailsMopr[count].noOfMonths}</div></td>

															<td><div align="center">${institueInfraHrActivityDetailsMopr[count].fund}</div></td>

															<c:choose>
																<c:when test="${count eq 0 }">
																	<td><button type="button"
																			class="btn btn-primary btn-lg" data-toggle="modal"
																			data-target="#myModal3">See Domain Details</button></td>
																</c:when>

																<c:when test="${count eq 3}">
																	<td><button type="button"
																			class="btn btn-primary btn-lg" data-toggle="modal"
																			data-target="#myModal4">See Domain Details</button></td>
																</c:when>
																<c:otherwise>
																	<td></td>
																</c:otherwise>
															</c:choose>
															<td><c:choose>
																	<c:when
																		test="${institueInfraHrActivityDetailsMopr[count].isApproved eq true}">
																		<i class="fa fa-check" aria-hidden="true"
																			style="color: #00cc00"></i>
																	</c:when>
																	<c:otherwise>
																		<i class="fa fa-times" aria-hidden="true"
																			style="color: red"></i>
																	</c:otherwise>
																</c:choose></td>
															<td>
																<div align="center">${institueInfraHrActivityDetailsMopr[count].remarks }</div>
															</td>
														</tr>
														<c:set var="count" value="${count +1}" scope="page" />
													</c:forEach>
												</tr>
												<tr>
													<td><div align="center">
															<strong><spring:message code="Label.TotalCost"
																	htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td><div align="center">${totalMopr}</div></td>
												</tr>
												<tr>
													<td><div align="center">
															<strong><spring:message
																	code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td><div align="center">${additionalRequirementMopr}</div></td>
												</tr>
												<tr>
													<td><div align="center">
															<strong><spring:message
																	code="Label.TotalProposedFund" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td><div align="center">${additionalRequirementMopr + totalMopr}</div></td>
												</tr>
											</tbody>
										</table>
										<div id="myModal3" class="modal fade" role="dialog">
											<div class="modal-dialog">

												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">&times;</button>
													</div>
													<div class="modal-body">
														<div class="row">
															<div class="form-group">
																<label for="sprc" class="col-sm-3"><spring:message
																		code="Label.InstituteType" htmlEscape="true" /></label>
																<div class="col-sm-5">
																	<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS"
																		begin="1" end="1">
																		<c:if
																			test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 2}">
																			<p class="text-justify">
																				<strong>
																					${DOMAINS.trainingInstitueType.trainingInstitueTypeName}</strong>
																			</p>
																		</c:if>
																	</c:forEach>
																</div>
															</div>
														</div>
														<div class="row clearfix">

															<div class="body">
																<div class="table-responsive">
																	<table class="table table-bordered">
																		<thead>
																			<tr>
																				<th><div align="center">
																						<spring:message code="Label.Domain"
																							htmlEscape="true" />
																					</div></th>
																				<th><div align="center">
																						<spring:message code="Label.NoOfExperts"
																							htmlEscape="true" />
																					</div></th>
																			</tr>
																		</thead>
																		<tbody>
																			<c:set var="temp" value="0" scope="page" />
																			<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS">
																				<c:if
																					test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 2 }">
																					<tr>
																						<th><div align="center">${DOMAINS.domainName}</div></th>
																						<td><div align="center">${tIWiseProposedDomainExpertsMopr[temp].noOfExperts }</div></td>
																					</tr>
																				</c:if>
																				<c:set var="temp" value="${temp+1}" scope="page" />
																			</c:forEach>
																		</tbody>
																	</table>
																</div>
															</div>
														</div>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-danger"
															data-dismiss="modal">Close</button>
													</div>
												</div>
											</div>
										</div>

										<div id="myModal4" class="modal fade" role="dialog">
											<div class="modal-dialog">

												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">&times;</button>
													</div>
													<div class="modal-body">
														<div class="row">
															<div class="form-group">
																<label for="sprc" class="col-sm-3"><spring:message
																		code="Label.InstituteType" htmlEscape="true" /></label>
																<div class="col-sm-5">
																	<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS"
																		begin="1" end="3">
																		<c:if
																			test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 4}">
																			<p class="text-justify">
																				<strong>${DOMAINS.trainingInstitueType.trainingInstitueTypeName}</strong>
																			</p>
																		</c:if>
																	</c:forEach>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="form-group">
																<label for="Dprc" class="col-sm-3"><spring:message
																		code="Label.District" htmlEscape="true" /></label>
																<div class="col-sm-5" align="center">
																	<strong>
																		${SELECTED_DISTRICT_IN_MOPR.districtNameEnglish}</strong>
																</div>
															</div>
														</div>
														<div class="row clearfix">
															<div class="body">
																<div class="table-responsive">
																	<table class="table table-bordered">
																		<thead>
																			<tr>
																				<th><div align="center">
																						<spring:message code="Label.Domain"
																							htmlEscape="true" />
																					</div></th>
																				<th><div align="center">
																						<spring:message code="Label.NoOfExperts"
																							htmlEscape="true" />
																					</div></th>
																			</tr>
																		</thead>
																		<tbody>
																			<c:set var="temp" value="0" scope="page" />
																			<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS">
																				<c:if
																					test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 4}">
																					<tr>
																						<th><div align="center">${DOMAINS.domainName}</div></th>
																						<td><div align="center">${tIWiseProposedDomainExpertsMopr[temp].noOfExperts }</div></td>
																					</tr>
																				</c:if>
																				<c:set var="temp" value="${temp+1}" scope="page" />
																			</c:forEach>
																		</tbody>
																	</table>
																</div>
															</div>
														</div>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-danger"
															data-dismiss="modal">Close</button>
													</div>
												</div>
											</div>
										</div>
										<div class="row clearfix">
										<div class="col-md-4 text-left">
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
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
<style>
.Align-Right {
	text-align: right;
}
</style>
