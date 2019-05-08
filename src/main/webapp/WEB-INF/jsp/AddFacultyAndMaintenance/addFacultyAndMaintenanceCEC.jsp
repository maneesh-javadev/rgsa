<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script>

$('document').ready(function(){
	calculateTotalFundSprc();
 	calculateTotalFundDprc();
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

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

function validateMonth(obj)
{
	if( +$('#noOfMonths_'+obj).val() == 0 || +$('#noOfMonths_'+obj).val() > 12){
		alert("Months should be less than 12 or greater than 0 !");
		$('#noOfMonths_'+obj).val('');
	}
}
	
function calculateGrandTotal() {
	var grand_total = 0;
	if($('#additionalRequirementSprcId').val() != '' && $('#total_fund_sprc').val() !=""){
		if($('#additionalRequirementSprcId').val() > 0.25 * $('#total_fund_sprc').val()){
			alert("SPMU additional Requirement should be less than or equal to 25% of SPRC total Fund :" +  0.25 * $('#total_fund_sprc').val());
			$('#additionalRequirementSprcId').val('');
			$('#grandTotalId').val('');
		}else{
			$('#grandTotalId').val(+$('#additionalRequirementDprcId').val() + +$("#total_fund_dprc").val() + +$('#additionalRequirementSprcId').val() + +$("#total_fund_sprc").val());
		}
	}
	
	if($('#additionalRequirementDprcId').val() != '' && $('#total_fund_dprc').val() !=""){
		if($('#additionalRequirementDprcId').val() > 0.25 * $('#total_fund_dprc').val()){
			alert("DPMU additional Requirement should be less than or equal to 25% of DPRC total Fund :" + +  0.25 * $('#total_fund_dprc').val());
			$('#additionalRequirementDprcId').val('');
			$('#grandTotalId').val('');
		}else{							
			$('#grandTotalId').val(+$('#additionalRequirementDprcId').val() + +$("#total_fund_dprc").val() + +$('#additionalRequirementSprcId').val() + +$("#total_fund_sprc").val());
		}
	}
};
	
function validateCeilingValue(count){
	calculateTotalFundSprc();
	calculateTotalFundDprc();
	
		if($('#trainingInstituteId_'+count).val() == 2){
			if($('#total_fund_sprc').val() > 4000000){
		 		alert("Total unit cost for SPRC should be less than or equal to 40 lakhs per year");
				$("#fund_"+count).val('');
		 	}
		}else{
			if($('#total_fund_dprc').val() > 1000000){
		 		 if($('#districtSupportedId').val() != ""){
					 if(($('#total_fund_dprc').val() / $('#districtSupportedId').val()) > 1000000){
						alert("Total unit cost for DPRC should be less than or equal to 10 lakhs per year");
						$("#fund_"+count).val('');
						}
				 }else{
					 alert("Enter The no. of District supported by DPRC First.");
					 $("#fund_"+count).val('');
				 }
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
	var rowCount = $('#tbodyMainTableId tr').length - 3; /* minus 3 is done because length is counting additional requirement, total fund and grand total and we dont need it*/
	var rowModal1 =  $('#tbodySprcId tr').length;
	var rowModal2 = $('#modal2Tbody tr').length;
 	for(var i=0;i<rowCount;i++){
		+$("#noOfMonthsState_"+i).text() > +$("#noOfMonths_"+i).val() ? $("#noOfMonthsState_"+i).css('color','red') : $("#noOfMonthsState_"+i).css('color','#00cc00');
		+$("#noOfUnitsState_"+i).text() > +$("#noOfUnits_"+i).val() ? $("#noOfUnitsState_"+i).css('color','red') : $("#noOfUnitsState_"+i).css('color','#00cc00');
		if($("#fund"+i).val() == undefined){
			$("#fund"+i).val(0);
		}
		+$("#fundState_"+i).text() > +$("#fund_"+i).val() ? $("#fundState_"+i).css('color','red') : $("#fundState_"+i).css('color','#00cc00');
	}
	+$("#total_fund_sprc_state").text() > +$("#total_fund_sprc").val() ? $("#total_fund_sprc_state").css('color','red') : $("#total_fund_sprc_state").css('color','#00cc00');
	+$("#total_fund_dprc_state").text() > +$("#total_fund_dprc").val() ? $("#total_fund_dprc_state").css('color','red') : $("#total_fund_dprc_state").css('color','#00cc00');
	+$("#additionalRequirementSprcStateId").text() > +$("#additionalRequirementSprcId").val() ? $("#additionalRequirementSprcStateId").css('color','red') : $("#additionalRequirementSprcStateId").css('color','#00cc00');
	+$("#additionalRequirementDprcStateId").text() > +$("#additionalRequirementDprcId").val() ? $("#additionalRequirementDprcStateId").css('color','red') : $("#additionalRequirementDprcStateId").css('color','#00cc00');
	+$("#grandTotalState").text() > +$("#grandTotalId").val() ? $("#grandTotalState").css('color','red') : $("#grandTotalState").css('color','#00cc00');
	
	for(var j=0;j < rowModal1 ;j++){
		+$("#noOfFacultyState_"+j).text() > +$("#noOfFaculty_"+j).val() ? $("#noOfFacultyState_"+j).css('color','red') : $("#noOfFacultyState_"+j).css('color','#00cc00');
	}
	for(var j=3 ; j < rowModal2 + 3 ; j++){
		+$("#noOfExpertState_"+j).text() > +$("#noOfExpert_"+j).val() ? $("#noOfExpertState_"+j).css('color','red') : $("#noOfExpertState_"+j).css('color','#00cc00');
	} 
}

/* this function validates the value in fill domain detail with the outer number of unit field. */
function domainValidation(obj){
	var rowCountSprc=$('#tbodySprcId tr').length;
	var noOfDomainSprc=0;
	var noOfDomainDprc=0;
	for(var i=0;i<rowCountSprc;i++){
		noOfDomainSprc += Number($('#noOfFaculty_'+i).val()) ;
		noOfDomainDprc += Number($('#noOfExpert_'+(i+3)).val());
	}
	if(!isNaN(obj)){
	if($('#noOfUnits_0').val() < noOfDomainSprc){
		alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_0').val());
		$('#noOfFaculty_'+obj).val('');
	}else if($('#noOfUnits_3').val() < noOfDomainDprc){
		alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_3').val());
		$('#noOfExpert_'+obj).val('');
	}
	}else{ if(obj == 'noOfUnitsSprc_0' && noOfDomainSprc != 0){
			var result= confirm("If you change Number of units you have to fill domain details.");
			if(result){
			if($('#noOfUnits_0').val() < noOfDomainSprc){
				alert('No of units in SPRC should not exceed the sum of domain detail '+ noOfDomainSprc + 'please fill the domain details again.');
				emptyDomainDetails('sprc',rowCountSprc);
			}
			}else{
				if($('#noOfUnits_0').val() < noOfDomainSprc){
					alert('No of units in SPRC should not exceed the sum of domain detail '+ noOfDomainSprc );
					$('#noOfUnits_0').val('');
				}
			}
	}else if(obj == 'noOfUnitsDprc_3' && noOfDomainDprc != 0){
		var result= confirm("If you change Number of units you have to fill domain details.");
		if(result){
		if($('#noOfUnits_3').val() < noOfDomainDprc){
			alert('No of units in DPRC should not exceed the sum of domain detail '+ noOfDomainSprc + 'please fill the domain details again.');
			emptyDomainDetails('dprc',rowCountSprc);
		}
		}else{
			if($('#noOfUnits_3').val() < noOfDomainSprc){
				alert('No of units in DPRC should not exceed the sum of domain detail '+ noOfDomainDprc );
				$('#noOfUnits_3').val('');
			}
		}
	}
	}
}

/* this function used in domainValidation function */
function emptyDomainDetails(level,count){
	if(level == 'sprc'){
		for(var i=0;i<count;i++){
			$('#noOfFaculty_'+i).val('');
		}
	}else{
		for(var i=3;i<count + 3;i++){
			$('#noOfExpert_'+i).val('');
		}
	}
}

function validationOnSubmit(){
	var rowCountSprc=$('#tbodySprcId tr').length;
	var flag= true;
	
	if($('#noOfUnits_0').val() == "" || $('#noOfUnits_0').val() == null){
		for(var i=0;i<rowCountSprc;i++){
			if($('#noOfFaculty_'+i).val() != "" || $('#noOfFaculty_'+i).val() != 0){
				flag=false;
				break;
			}
		}
		}else{
			for(var i=0;i<rowCountSprc;i++){
			if($('#noOfFaculty_'+i).val() == "" || $('#noOfFaculty_'+i).val() == 0){
				flag=false;
			}else{
				flag=true;
				break;
			}
			}
		}
	if($('#noOfUnits_3').val() == "" || $('#noOfUnits_3').val() == null){
		for(var i=0;i<rowCountSprc;i++){
		if($('#noOfExpert_'+(i+3)).val() != "" || $('#noOfExpert_'+(i+3)).val() != 0){
			flag=false;
			break;
		}
		}
	}else{
		for(var i=0;i<rowCountSprc;i++){
		if($('#noOfExpert_'+(i+3)).val() == "" || $('#noOfExpert_'+(i+3)).val() == 0){
			flag=false;
		}else{
			flag=true;
			break;
		}
		}
	}
	
	if(+$('#activedropdown').val() == 0 && $('#total_fund_dprc').val() != ""){
		alert("please select district in domain detail of DPRC.");
		return flag=false;
	}  
	
	if(($('#noOfUnits_3').val() == "" || $('#noOfUnits_0').val() == "") && flag == false){
		alert("Fill the number of units first.");
		return flag;
	}else if(!flag){
		alert("Fill the domain details first.");
		return flag;
	}
	
	/* this is to validate if full form */
	var count = $("#countSprcId").val();
	for (var i = 0; i < count; i++) {
		if($("#fund_" + i).val() == "" &&  $("#fund_" + (i + +count)).val() == ""){
			flag=false;
		}else{
			flag=true;
		}
	}
	if(!flag){
		alert("Empty form cannot save.");
	}
	return flag;
}

function calculateTotalFundSprc() {
	var count = $("#countSprcId").val();
	var total_sprc_fund = 0;
	for (var i = 0; i < count; i++) {
		if($("#fund_" + i).val() != null && $("#fund_" + i).val() != ""){
			total_sprc_fund += +$("#fund_" + i).val();
		}
	}
	$("#total_fund_sprc").val(+total_sprc_fund); 
	calculateGrandTotal();
};

function calculateTotalFundDprc() {
	var count = $("#countDprcId").val();
	var total_dprc_fund = 0;
	for (var i = 0; i < count; i++) {
		if($("#fund_"+(i + +$("#countSprcId").val())).val() != null && $("#fund_"+(i + +$("#countSprcId").val())).val() != ""){
			total_dprc_fund += +$("#fund_"+(i + +$("#countSprcId").val())).val();
		}
	}
	$("#total_fund_dprc").val(total_dprc_fund); 
	calculateGrandTotal();
};
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
						modelAttribute="ADDITIONAL_FACULTY_MAINT_MODEL" onsubmit="return validationOnSubmit()">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="addFacultyAndMaintenanceHrBudget.html" />" />
							
							<c:set var="countSprc" value="0" scope="page" />
							<c:set var="countDprc" value="0" scope="page" />
							
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
											<tbody id="tbodyMainTableId">
												<!-- SPRC LOOP BEGINS -->
												<c:forEach items="${LIST_OF_ACTIVITY_HR_TYPE}" var="ACTIVITY"  begin="0" end="2" varStatus="index">
													<input type="hidden" id="ISFREEZE" value="${ISFREEZE}" />
													<input type="hidden" id="trainingInstituteId_${index.index}"
														value="${ACTIVITY.trainingInstitueType.trainingInstitueTypeId}" />
													<form:hidden
														path="institueInfraHrActivityDetails[${index.index}].instituteInfraHrActivityType.instituteInfraHrActivityTypeId"
														value="${ACTIVITY.instituteInfraHrActivityTypeId}" />
													<form:hidden
														path="institueInfraHrActivityDetails[${index.index}].instituteInfrsaHrActivityDetailsId" />
													<tr>
														<td><div align="center">
																<strong>${ACTIVITY.trainingInstitueType.trainingInstitueTypeName}</strong>
															</div></td>

														<td><div align="center">
																<strong>${ACTIVITY.instituteInfraHrActivityName}</strong>
															</div></td>

														<td>
															<div align="center" id="noOfUnitsState_${index.index}">${institueInfraHrActivityDetailsState[index.index].noOfUnits}</div>
															<c:if test="${index.index ne 2 and index.index ne 5}">
															<form:input
																path="institueInfraHrActivityDetails[${index.index}].noOfUnits"
																onkeypress="return isNumber(event)"
																class="active12 form-control Align-Right"
																onkeyup="onLoadChangeColor();"
																onchange="domainValidation('noOfUnitsSprc_${index.index}')"
																id="noOfUnits_${index.index}" />
																</c:if>
														</td>

														<td>
														<c:if test="${index.index ne 2 and index.index ne 5}">
																<div align="center" id="noOfMonthsState_${index.index}">${institueInfraHrActivityDetailsState[index.index].noOfMonths}</div>
																<form:input
																	path="institueInfraHrActivityDetails[${index.index}].noOfMonths"
																	onkeypress="return isNumber(event)"
																	class="active12 form-control Align-Right"
																	onkeyup="onLoadChangeColor() ;validateMonth(${index.index})" id="noOfMonths_${index.index}" />
															</c:if>
														</td>

														<td>
															<div align="center" id="fundState_${index.index}">${institueInfraHrActivityDetailsState[index.index].fund}</div>
															<form:input
																path="institueInfraHrActivityDetails[${index.index}].fund"
																readonly="" type="text"
																onkeypress="return isNumber(event)"
																class="active12 form-control Align-Right"
																onkeyup="calculateTotalFundSprc();onLoadChangeColor();validateCeilingValue(${index.index})" id="fund_${index.index}" />
														</td>

														<c:choose>
															<c:when test="${index.index eq 0 }">
																<td><button type="button"
																		class="btn btn-primary btn-lg" data-toggle="modal"
																		data-target="#myModal">Fill Domain Details</button></td>
															</c:when>

															<c:when test="${index.index eq 3}">
																<td><button type="button"
																		class="btn btn-primary btn-lg" data-toggle="modal"
																		data-target="#myModal2">Fill Domain Details</button></td>
															</c:when>
															<c:otherwise>
																<td></td>
															</c:otherwise>
														</c:choose>
														<td><form:textarea
																path="institueInfraHrActivityDetails[${index.index}].remarks"
																rows="3" cols="5" class="active12 form-control" /></td>
													</tr>
													<c:set var="countSprc" value="${countSprc + 1}" scope="page" />
												</c:forEach>
												
												<tr>
													<td><div align="center">
															<strong>Total SPRC Fund</strong>
														</div></td>
													<td colspan="3"></td>
													<td>
													<div align="center" id="total_fund_sprc_state">${SPRC_TOTAL_STATE}</div>
													<input type="text"
														class="form-control Align-Right" id="total_fund_sprc"
														disabled="disabled" /></td>
												</tr>
												<tr>
													<td><div align="center">
															<strong>SPRC <spring:message
																	code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td>
													<div align="center" id="additionalRequirementSprcStateId">${institueInfraHrActivityState.additionalRequirementSprc}</div>
													<form:input path="additionalRequirementSprc"
															type="text" onkeypress="return isNumber(event)"
															class="active12 form-control Align-Right"
															id="additionalRequirementSprcId"
															onkeyup="calculateGrandTotal()" /></td>
												</tr>
												<!-- SPRC LOOP ENDS HERE -->
												
												<!-- DPRC LOOP BEGINS -->
												<c:forEach items="${LIST_OF_ACTIVITY_HR_TYPE}" var="ACTIVITY"  begin="3" end="5" varStatus="index">
													<input type="hidden" id="ISFREEZE" value="${ISFREEZE}" />
													<input type="hidden" id="trainingInstituteId_${index.index}"
														value="${ACTIVITY.trainingInstitueType.trainingInstitueTypeId}" />
													<form:hidden
														path="institueInfraHrActivityDetails[${index.index}].instituteInfraHrActivityType.instituteInfraHrActivityTypeId"
														value="${ACTIVITY.instituteInfraHrActivityTypeId}" />
													<form:hidden
														path="institueInfraHrActivityDetails[${index.index}].instituteInfrsaHrActivityDetailsId" />
													<tr>
														<td><div align="center">
																<strong>${ACTIVITY.trainingInstitueType.trainingInstitueTypeName}</strong>
															</div></td>

														<td><div align="center">
																<strong>${ACTIVITY.instituteInfraHrActivityName}</strong>
															</div></td>

														<td>
															<div align="center" id="noOfUnitsState_${index.index}">${institueInfraHrActivityDetailsState[index.index].noOfUnits}</div>
															<c:if test="${index.index ne 2 and index.index ne 5}">
															<form:input
																path="institueInfraHrActivityDetails[${index.index}].noOfUnits"
																onkeypress="return isNumber(event)"
																class="active12 form-control Align-Right"
																onkeyup="onLoadChangeColor();"
																onchange="domainValidation('noOfUnitsDprc_${index.index}')"
																id="noOfUnits_${index.index}" />
																</c:if>
														</td>

														<td>
														<c:if test="${index.index ne 2 and index.index ne 5}">
																<div align="center" id="noOfMonthsState_${index.index}">${institueInfraHrActivityDetailsState[index.index].noOfMonths}</div>
																<form:input
																	path="institueInfraHrActivityDetails[${index.index}].noOfMonths"
																	onkeypress="return isNumber(event)"
																	class="active12 form-control Align-Right"
																	onkeyup="onLoadChangeColor();validateMonth(${index.index})" id="noOfMonths_${index.index}" />
															</c:if>
														</td>

														<td>
															<div align="center" id="fundState_${index.index}">${institueInfraHrActivityDetailsState[index.index].fund}</div>
															<form:input
																path="institueInfraHrActivityDetails[${index.index}].fund"
																readonly="" type="text"
																onkeypress="return isNumber(event)"
																class="active12 form-control Align-Right"
																onkeyup="calculateTotalFundDprc();onLoadChangeColor();validateCeilingValue(${index.index})" id="fund_${index.index}" />
														</td>

														<c:choose>
															<c:when test="${index.index eq 0 }">
																<td><button type="button"
																		class="btn btn-primary btn-lg" data-toggle="modal"
																		data-target="#myModal">Fill Domain Details</button></td>
															</c:when>

															<c:when test="${index.index eq 3}">
																<td><button type="button"
																		class="btn btn-primary btn-lg" data-toggle="modal"
																		data-target="#myModal2">Fill Domain Details</button></td>
															</c:when>
															<c:otherwise>
																<td></td>
															</c:otherwise>
														</c:choose>
														<td><form:textarea
																path="institueInfraHrActivityDetails[${index.index}].remarks"
																rows="3" cols="5" class="active12 form-control" /></td>
													</tr>
													<c:set var="countDprc" value="${countDprc + 1}" scope="page" />
												</c:forEach>
												
												<tr>
													<td><div align="center">
															<strong>Total DPRC Fund</strong>
														</div></td>
													<td colspan="3"></td>
													<td>
													<div align="center" id="total_fund_dprc_state">${DPRC_TOTAL_STATE}</div>
													<input type="text"
														class="form-control Align-Right" id="total_fund_dprc"
														disabled="disabled" /></td>
												</tr>
												<tr>
													<td><div align="center">
															<strong>DPRC <spring:message
																	code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td>
													<div align="center" id="additionalRequirementDprcStateId">${institueInfraHrActivityState.additionalRequirementDprc}</div>
													<form:input path="additionalRequirementDprc"
															type="text" onkeypress="return isNumber(event)"
															class="active12 form-control Align-Right"
															id="additionalRequirementDprcId"
															onkeyup="calculateGrandTotal()" /></td>
												</tr>
												<!-- DPRC LOOP ENDS -->
												<tr>
													<td><div align="center">
															<strong><spring:message
																	code="Label.TotalProposedFund" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td>
														<div align="center" id="grandTotalState">${institueInfraHrActivityState.additionalRequirementDprc + DPRC_TOTAL_STATE+ institueInfraHrActivityState.additionalRequirementSprc + SPRC_TOTAL_STATE}</div>
														<form:input path="grand_total" type="text"
															class="active12 form-control Align-Right" id="grandTotalId"
															onchange="validatingAdditionalRequirement(${index.index});onLoadChangeColor()"
															disabled="true" />
													</td>
												</tr>
											</tbody>
										</table>
										
										<!-- HIDDEN FIELDS -->
										<input type="hidden" name="dbFileName" id="dbFileName">
										<input type="hidden" id="countSprcId" value="${countSprc}" />
										<input type="hidden" id="countDprcId" value="${countDprc}" />
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
																		<tbody id="tbodySprcId">
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
																						<form:input
																							path="tIWiseProposedDomainExperts[${temp}].noOfExperts"
																							onkeyup="onLoadChangeColor();domainValidation(${temp})"
																							class="active12 form-control Align-Right"
																							id="noOfFaculty_${temp}" /></td>	
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
																<div class="col-sm-3">
																	<form:hidden path="districtCode"
																		value="${SELECTED_DISTRICT_IN_STATE.districtCode }"
																		id="activedropdownState" />
																	<div id="districtStateId"
																		style="font-weight: bold; margin-left: -12px;">${SELECTED_DISTRICT_IN_STATE.districtNameEnglish}</div>
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
																						<form:input
																							path="tIWiseProposedDomainExperts[${index}].noOfExperts"
																							onkeyup="onLoadChangeColor();domainValidation(${index})"
																							id="noOfExpert_${index}" 
																							class="active12 form-control Align-Right" /></td>
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
												<!-- SPRC LOOP BEGINS -->
													<c:forEach items="${LIST_OF_ACTIVITY_HR_TYPE}" var="ACTIVITY" varStatus="index" begin="0" end="2">
														<tr>
															<td><div align="center">
																	<strong>${ACTIVITY.trainingInstitueType.trainingInstitueTypeName}</strong>
																</div></td>

															<td><div align="center">
																	<strong>${ACTIVITY.instituteInfraHrActivityName}</strong>
																</div></td>

															<td><div align="center">${institueInfraHrActivityDetailsMopr[index.index].noOfUnits}</div></td>

															<td><div align="center">${institueInfraHrActivityDetailsMopr[index.index].noOfMonths}</div></td>

															<td><div align="center">${institueInfraHrActivityDetailsMopr[index.index].fund}</div></td>

															<c:choose>
																<c:when test="${index.index eq 0 }">
																	<td><button type="button"
																			class="btn btn-primary btn-lg" data-toggle="modal"
																			data-target="#myModal3">See Domain Details</button></td>
																</c:when>

																<c:when test="${index.index eq 3}">
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
																		test="${institueInfraHrActivityDetailsMopr[index.index].isApproved eq true}">
																		<i class="fa fa-check" aria-hidden="true"
																			style="color: #00cc00"></i>
																	</c:when>
																	<c:otherwise>
																		<i class="fa fa-times" aria-hidden="true"
																			style="color: red"></i>
																	</c:otherwise>
																</c:choose></td>
															<td>
																<div align="center">${institueInfraHrActivityDetailsMopr[index.index].remarks }</div>
															</td>
														</tr>
													</c:forEach>
												</tr>
												<tr>
													<td><div align="center">
															<strong>Total SPRC Fund</strong>
														</div></td>
													<td colspan="3"></td>
													<td><div align="center">${SPRC_TOTAL_MOPR}</div></td>
												</tr>
												<tr>
													<td><div align="center">
															<strong>SPRC <spring:message
																	code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td><div align="center">${institueInfraHrActivityMopr.additionalRequirementSprc}</div></td>
												</tr>
												<!-- SPRC LOOP ENDS -->
												
												<!-- DPRC LOOP BEGINS -->
												<c:forEach items="${LIST_OF_ACTIVITY_HR_TYPE}" var="ACTIVITY" varStatus="index" begin="0" end="2">
														<tr>
															<td><div align="center">
																	<strong>${ACTIVITY.trainingInstitueType.trainingInstitueTypeName}</strong>
																</div></td>

															<td><div align="center">
																	<strong>${ACTIVITY.instituteInfraHrActivityName}</strong>
																</div></td>

															<td><div align="center">${institueInfraHrActivityDetailsMopr[index.index].noOfUnits}</div></td>

															<td><div align="center">${institueInfraHrActivityDetailsMopr[index.index].noOfMonths}</div></td>

															<td><div align="center">${institueInfraHrActivityDetailsMopr[index.index].fund}</div></td>

															<c:choose>
																<c:when test="${index.index eq 0 }">
																	<td><button type="button"
																			class="btn btn-primary btn-lg" data-toggle="modal"
																			data-target="#myModal3">See Domain Details</button></td>
																</c:when>

																<c:when test="${index.index eq 3}">
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
																		test="${institueInfraHrActivityDetailsMopr[index.index].isApproved eq true}">
																		<i class="fa fa-check" aria-hidden="true"
																			style="color: #00cc00"></i>
																	</c:when>
																	<c:otherwise>
																		<i class="fa fa-times" aria-hidden="true"
																			style="color: red"></i>
																	</c:otherwise>
																</c:choose></td>
															<td>
																<div align="center">${institueInfraHrActivityDetailsMopr[index.index].remarks }</div>
															</td>
														</tr>
													</c:forEach>
												<tr>
													<td><div align="center">
															<strong>Total DPRC Fund</strong>
														</div></td>
													<td colspan="3"></td>
													<td><div align="center">${DPRC_TOTAL_MOPR}</div></td>
												</tr>
												<tr>
													<td><div align="center">
															<strong>DPRC <spring:message
																	code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td><div align="center">${institueInfraHrActivityMopr.additionalRequirementDprc}</div></td>
												</tr>
												<!-- DPRC LOOP ENDS -->
												<tr>
													<td><div align="center">
															<strong><spring:message
																	code="Label.TotalProposedFund" htmlEscape="true" /></strong>
														</div></td>
													<td colspan="3"></td>
													<td><div align="center">${institueInfraHrActivityMopr.additionalRequirementSprc + SPRC_TOTAL_MOPR + institueInfraHrActivityMopr.additionalRequirementDprc + DPRC_TOTAL_MOPR}</div></td>
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
