<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script>
var domain_list = '${LIST_OF_DOMAINS}';
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

/* this function validates the value in fill domain detail with the outer number of unit field. */
function domainValidation(obj){
	var rowCountSprc=$('#tbodySprcId tr').length;
	var rowCountDprc=$('#tbodyDprcId tr').length * domain_list.split(',').length / 2;
	var noOfDomainSprc=0;
	var noOfDomainDprc=0;
	for(var i=0;i<rowCountSprc;i++){
		noOfDomainSprc += Number($('#noOfFaculty_'+i).val()) ;
	}
	for(var i=0;i<rowCountDprc;i++){
		noOfDomainDprc += Number($('#noOfExpert_'+(i)).val());
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
				alert('No of units in SPRC should not exceed the sum of domain detail :'+ noOfDomainSprc + ' please fill the domain details again.');
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
			alert('No of units in DPRC should not exceed the sum of domain detail :'+ noOfDomainDprc + ' please fill the domain details again.');
			emptyDomainDetails('dprc',rowCountDprc);
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
		for(var i=0;i<count;i++){
			$('#noOfExpert_'+i).val('');
		}
	}
}
	
function validateDistricts(){
	if(+$('#districtSupportedId').val() > +$('#districtsInState').val()){
		alert('District supported should be less than or equal to total districts in state : ' + $('#districtsInState').val());
		$('#districtSupportedId').val('');
		$('#districtSupportedId').focus();
	}
	
	 if($('#districtSupportedId').val() != ""){
		 if(($('#total_fund_dprc').val() / $('#districtSupportedId').val()) > 1000000){
			alert("Total unit cost for DPRC per district should be less than 1000000.Either change number of district or data in DPRC section.");
			$('#districtSupportedId').val('');
			}
	 }
}	
	
function calculateGrandTotal() {
	var grand_total = 0;
	if($('#additionalRequirementSprcId').val() > 0.25 * $('#total_fund_sprc').val()){
			alert("SPMU additional Requirement should be less than or equal to 25% of SPRC total Fund :" +  0.25 * $('#total_fund_sprc').val());
			$('#additionalRequirementSprcId').val('');
			$('#grandTotalId').val('');
		}else{
			$('#grandTotalId').val(+$('#additionalRequirementDprcId').val() + +$("#total_fund_dprc").val() + +$('#additionalRequirementSprcId').val() + +$("#total_fund_sprc").val());
		}
	
		if($('#additionalRequirementDprcId').val() > 0.25 * $('#total_fund_dprc').val()){
			alert("DPMU additional Requirement should be less than or equal to 25% of DPRC total Fund :" + +  0.25 * $('#total_fund_dprc').val());
			$('#additionalRequirementDprcId').val('');
			$('#grandTotalId').val('');
		}else{							
			$('#grandTotalId').val(+$('#additionalRequirementDprcId').val() + +$("#total_fund_dprc").val() + +$('#additionalRequirementSprcId').val() + +$("#total_fund_sprc").val());
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


function validationOnSubmit(){
	var rowCountSprc=$('#tbodySprcId tr').length;
	var rowCountDprc=$('#tbodyDprcId tr').length * domain_list.split(',').length / 2;
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
		for(var i=0;i<rowCountDprc;i++){
			if($('#noOfExpert_'+(i)).val() != ""|| $('#noOfExpert_'+(i)).val() != 0){
				flag=false;
				break;
			}
			}
	}else{
		for(var i=0;i<rowCountDprc;i++){
			if($('#noOfExpert_'+(i)).val() == "" || $('#noOfExpert_'+(i)).val() == 0){
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
	
	if($('#districtSupportedId').val() == "" && $('#total_fund_dprc').val() != '' && $('#total_fund_dprc').val() != 0){
		alert('No. of districts supported For DPRC should not be ')
		return false;
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
		alert("Empty form cannot save or freezed.");
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

function freezeAndUnfreeze(obj){
	disableButton(true);
	$('#textarea').attr('disabled',false);
	if($('#districtSupportedId').val()!=null && $('#districtSupportedId').val()!='' && $('#districtSupportedId').val()!='undefined')
	{
	if($('#total_fund_dprc').val()!=0 && $('#total_fund_dprc').val()!='undefined' && $('#total_fund_dprc').val()!='')
	{
	document.getElementById("dbFileName").value = obj;
	document.additionalFacultyAndMain.method = "post";
	document.additionalFacultyAndMain.action = "addFacultyAndMaintenanceHrBudget.html?<csrf:token uri='addFacultyAndMaintenanceHrBudget.html'/>";
	document.additionalFacultyAndMain.submit();
	}
	else
		{
		alert("Fund can not be 0 or blank");
		disableButton(false);
		}
	}
	else
		{
		if($('#total_fund_sprc').val()!=0 && $('#total_fund_sprc').val()!='undefined' && $('#total_fund_sprc').val()!='undefined')
		{
		document.getElementById("dbFileName").value = obj;
		document.additionalFacultyAndMain.method = "post";
		document.additionalFacultyAndMain.action = "addFacultyAndMaintenanceHrBudget.html?<csrf:token uri='addFacultyAndMaintenanceHrBudget.html'/>";
		document.additionalFacultyAndMain.submit();
		}
		else
			{
			alert("Fund can not be 0 or blank");
			disableButton(false);
			}
		}
}






function save_data(){
	disableButton(true);
	
	if($('#districtSupportedId').val()!=null && $('#districtSupportedId').val()!='' && $('#districtSupportedId').val()!='undefined')
	{
		if($('#total_fund_dprc').val()!=0 && $('#total_fund_dprc').val()!='undefined' && $('#total_fund_dprc').val()!='')
			{
			document.additionalFacultyAndMain.method = "post";
			document.additionalFacultyAndMain.action = "addFacultyAndMaintenanceHrBudget.html?<csrf:token uri='addFacultyAndMaintenanceHrBudget.html'/>";
			document.additionalFacultyAndMain.submit();
			}
		else
			{
			disableButton(false);
			alert('Fund can not be 0 or blank');
			}
	}
	else
		{
		if($('#total_fund_sprc').val()!=0 && $('#total_fund_sprc').val()!='undefined' && $('#total_fund_sprc').val()!='')
			{
			document.additionalFacultyAndMain.method = "post";
			document.additionalFacultyAndMain.action = "addFacultyAndMaintenanceHrBudget.html?<csrf:token uri='addFacultyAndMaintenanceHrBudget.html'/>";
			document.additionalFacultyAndMain.submit();
			}
		else
			{
			disableButton(false);
			alert('Fund can not be 0 or blank');
			}
		}
}

function disableButton(isDisabled){
	if(isDisabled){
		$('#save').prop('disabled',true);
		$('#freezebtn').prop('disabled',true);
		$('#unfreezebtn').prop('disabled',true);
	}else{
		$('#save').prop('disabled',false);
		$('#freezebtn').prop('disabled',false);
		$('#unfreezebtn').prop('disabled',false);
	}
	
}
</script>

<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2><spring:message code="Label.HrBudgetHeader" htmlEscape="true" /></h2>
					</div>
					<form:form method="post" name="additionalFacultyAndMain"
						action="addFacultyAndMaintenanceHrBudget.html"
						modelAttribute="ADDITIONAL_FACULTY_MAINT_MODEL" onsubmit="return validationOnSubmit();disablingSave()">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="addFacultyAndMaintenanceHrBudget.html" />" />
						<div class="body">
							<div class="row clearfix">
								<div class="form-group">
									<div class="col-sm-4">
										<label for="districtSupportedId"><spring:message
												code="Label.DistrictsupportedDprc" htmlEscape="true" /><span><sup style="color: red;">*</sup></span>
										</label>
									</div>

										<div class="col-sm-4">
									<div class="form-line">
										<form:input id="districtSupportedId" path="districtsSupported" class="form-control Align-Right"
											onkeypress="return isNumber(event)" onkeyup="validateDistricts()" maxlength="7"/></div>
									</div>
									<input type="hidden" id="districtsInState" value="${DISTRICTS_IN_STATE}">
								</div>
							</div>

							<div class="table-responsive">
								<table class="table table-bordered" id="tab">
									<thead>
										<tr>
											<th rowspan="2"><div align="center"><spring:message code="Label.TypeOfCenter" htmlEscape="true" /></div></th>
											<th rowspan="2"><div align="center"><spring:message code="Label.Faculty&Staff" htmlEscape="true" /></div></th>
											<th rowspan="2"><div align="center"><spring:message code="Label.NoofUnits" htmlEscape="true" /></div></th>
											<th rowspan="2"><div align="center"><spring:message code="Label.NoOfMonths" htmlEscape="true" /></div></th>
											<th rowspan="2"><div align="center"><spring:message code="Label.Funds" htmlEscape="true" /></div></th>
											<th rowspan="2"><div align="center"><spring:message code="Label.DomainDetails" htmlEscape="true" /></div></th>
											<c:if test="${USER_TYPE eq 'M' or USER_TYPE eq 'C'}"><th rowspan="2"><div align="center"><spring:message code="Label.IsApproved" htmlEscape="true" /></div></th></c:if>
											<th rowspan="2"><div align="center"><spring:message code="Label.Remarks" htmlEscape="true" /></div></th>
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
									<tbody id="tbodyMainTableId">
									<c:set var="countSprc" value="0" scope="page" />
									<c:set var="countDprc" value="0" scope="page" />
									<!-- SPRC LOOP STARTS -->
									<c:forEach items="${LIST_OF_ACTIVITY_HR_TYPE}" var="ACTIVITY" varStatus="index" begin="0" end="2">
										<input type="hidden" id="trainingInstituteId_${index.index}"  value="${ACTIVITY.trainingInstitueType.trainingInstitueTypeId}"/>
										<form:hidden path="institueInfraHrActivityDetails[${index.index}].instituteInfraHrActivityType.instituteInfraHrActivityTypeId" value="${ACTIVITY.instituteInfraHrActivityTypeId}"/>
										<form:hidden path="institueInfraHrActivityDetails[${index.index}].instituteInfrsaHrActivityDetailsId" />
										<tr>
											<td><div align="center"><strong>${ACTIVITY.trainingInstitueType.trainingInstitueTypeName}</strong></div></td>
											<td><div align="center"><strong>${ACTIVITY.instituteInfraHrActivityName}</strong></div></td>
												<c:choose>
													<c:when test="${index.index ne 2 and index.index ne 5}">
														<td><form:input
																path="institueInfraHrActivityDetails[${index.index}].noOfUnits"
																type="text" onkeypress="return isNumber(event)"
																maxlength="5" class="active12 form-control Align-Right"
																id="noOfUnits_${index.index}"
																onkeyup="validateCeilingValue(${index.index})"
																onchange="domainValidation('noOfUnitsSprc_${index.index}')" /></td>
														<td><form:input
																path="institueInfraHrActivityDetails[${index.index}].noOfMonths"
																type="text" onkeypress="return isNumber(event)"
																class="active12 form-control Align-Right"
																id="noOfMonths_${index.index}"
																onkeyup="validateCeilingValue(${index.index});validateMonth(${index.index})" /></td>
													</c:when>
													<c:otherwise>
														<td></td>
														<td></td>
													</c:otherwise>
												</c:choose>
												<td><form:input path="institueInfraHrActivityDetails[${index.index}].fund" type="text" onkeypress="return isNumber(event)" class="active12 form-control Align-Right active1" id="fund_${index.index}" onkeyup="validateCeilingValue(${index.index})" onchange="calculateTotalFundSprc();" /></td>
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
											<c:if test="${USER_TYPE eq 'M'}"><td><form:checkbox path="institueInfraHrActivityDetails[${index.index}].isApproved" class="active12 form-control-check" /></td></c:if>
											<td><form:textarea path="institueInfraHrActivityDetails[${index.index}].remarks" rows="3" cols="5" class="active12 form-control" /></td>
											
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
										<c:set var="countSprc" value="${countSprc + 1}" scope="page" />
									</c:forEach>
									<tr>
										<td><div align="center">
												<strong>Total SPRC Fund</strong>
											</div></td>
										<td colspan="3"></td>
										<td><input  type="text" class="form-control Align-Right" id="total_fund_sprc" disabled="disabled"/></td>
									</tr>
									<tr>
										<td><div align="center">
												<strong>SPRC <spring:message code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
											</div></td>
										<td colspan="3"></td>
										<td><form:input path="additionalRequirementSprc" type="text" onkeypress="return isNumber(event)" class="active12 form-control Align-Right" id="additionalRequirementSprcId" onkeyup="calculateGrandTotal()"/></td>
									</tr>
									
									<!-- SPRC LOOP ENDS -->
									
									<!-- DPRC LOOP STARTS -->
									<c:forEach items="${LIST_OF_ACTIVITY_HR_TYPE}" var="ACTIVITY" varStatus="index" begin="3" end="5">
										<input type="hidden" id="trainingInstituteId_${index.index}"  value="${ACTIVITY.trainingInstitueType.trainingInstitueTypeId}"/>
										<form:hidden path="institueInfraHrActivityDetails[${index.index}].instituteInfraHrActivityType.instituteInfraHrActivityTypeId" value="${ACTIVITY.instituteInfraHrActivityTypeId}"/>
										<form:hidden path="institueInfraHrActivityDetails[${index.index}].instituteInfrsaHrActivityDetailsId" />
										<tr>
											<td><div align="center"><strong>${ACTIVITY.trainingInstitueType.trainingInstitueTypeName}</strong></div></td>
											<td><div align="center"><strong>${ACTIVITY.instituteInfraHrActivityName}</strong></div></td>
												<c:choose>
													<c:when test="${index.index ne 2 and index.index ne 5}">
														<td><form:input
																path="institueInfraHrActivityDetails[${index.index}].noOfUnits"
																type="text" onkeypress="return isNumber(event)"
																maxlength="5" class="active12 form-control Align-Right"
																id="noOfUnits_${index.index}"
																onkeyup="validateCeilingValue(${index.index})"
																onchange="domainValidation('noOfUnitsDprc_${index.index}')" /></td>
														<td><form:input
																path="institueInfraHrActivityDetails[${index.index}].noOfMonths"
																type="text" onkeypress="return isNumber(event)"
																class="active12 form-control Align-Right"
																id="noOfMonths_${index.index}"
																onkeyup="validateMonth(${index.index});validateCeilingValue(${index.index})" /></td>
													</c:when>
													<c:otherwise>
														<td></td>
														<td></td>
													</c:otherwise>
												</c:choose>
												<td><form:input path="institueInfraHrActivityDetails[${index.index}].fund" type="text" onkeypress="return isNumber(event)" class="active12 form-control Align-Right active1" id="fund_${index.index}" onkeyup="validateCeilingValue(${index.index})" onchange="calculateTotalFundDprc();"/></td>
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
											<c:if test="${USER_TYPE eq 'M'}"><td><form:checkbox path="institueInfraHrActivityDetails[${index.index}].isApproved" class="active12 form-control-check" /></td></c:if>
											<td><form:textarea path="institueInfraHrActivityDetails[${index.index}].remarks" rows="3" cols="5" class="active12 form-control" /></td>
											
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
										<c:set var="countDprc" value="${countDprc + 1}" scope="page" />
									</c:forEach>
									<tr>
										<td><div align="center">
												<strong>Total DPRC Fund</strong>
											</div></td>
										<td colspan="3"></td>
										<td><input  type="text" class="form-control Align-Right" id="total_fund_dprc" disabled="disabled"/></td>
									</tr>
									<tr>
										<td><div align="center">
												<strong>DPRC <spring:message code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
											</div></td>
										<td colspan="3"></td>
										<td><form:input path="additionalRequirementDprc" type="text" onkeypress="return isNumber(event)" class="active12 form-control Align-Right" id="additionalRequirementDprcId" onkeyup="calculateGrandTotal()"/></td>
									</tr>
									<!-- DPMU LOOP ENDS -->
									<tr>
										<td><div align="center">
												<strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /></strong>
											</div></td>
										<td colspan="3"></td>
										<td><form:input path="grand_total" type="text" class="active12 form-control Align-Right" id="grandTotalId"  disabled="true"/></td>
									</tr>
									</tbody>
								</table>
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
														<label for="sprc" class="col-sm-3">Institute Type
															:</label>
														<div class="col-sm-5">
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
																<thead style="background-color: #b39ad8;color: #2f2b2bf2;">
																	<tr>
																		<th><div align="center">Domain</div></th>
																		<th><div align="center">No.of Experts</div></th>
																	</tr>
																</thead>
																<tbody id="tbodySprcId">
																	<c:set var="temp" value="0" scope="page" />
																	<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS">
																		<c:if
																			test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 2 }">
																			<form:hidden path="tIWiseProposedDomainExperts[${temp}].tiWiseProposedDomainExpertsId"/>
																			<tr>
																				<th><div align="center">${DOMAINS.domainName}</div>
																					<input type="hidden"
																					name="tIWiseProposedDomainExperts[${temp}].domainId"
																					value="${DOMAINS.domainId}"></th>
																				<td><form:input
																						path="tIWiseProposedDomainExperts[${temp}].noOfExperts"
																						type="text" class="active12 form-control Align-Right"
																						 onkeypress="return isNumber(event)"
																						 onkeyup="domainValidation(${temp})"
																						id="noOfFaculty_${temp}" /></td>
																			</tr>
																			<c:set var="temp" value="${temp+1}" scope="page" />
																		</c:if>
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

								<div id="myModal2" class="modal fade" role="dialog">
									<div class="modal-dialog modal-lg">

										<!-- Modal content-->
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">&times;</button>
											</div>
											<div class="modal-body">
												<div class="row">
													<div class="form-group">
														<label for="sprc" class="col-sm-3">Institute Type
															:</label>
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
												<%-- <div class="row">
													<div class="form-group">
														<label for="Dprc" class="col-sm-3">Select District
															:</label>
														<div class="col-sm-5">
															<form:select path="districtCode" id="activedropdown">
																<option value="0">---select---</option>
																<c:forEach items="${LIST_OF_DISTRICT}" var="DISTRICT">
																	<form:option value="${DISTRICT.districtCode}">${DISTRICT.districtNameEnglish}</form:option>
																</c:forEach>
															</form:select>
														</div>
													</div>
												</div> --%>
												<div class="row clearfix">
													<div class="body">
														<div class="table-responsive">
															<table class="table table-hover">
																<thead style="background-color: #b39ad8;color: #2f2b2bf2;display: table;width: 100%;">
																	<tr>
																		<th><div align="center">District Name</div></th>
																		<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS">
																			<c:if test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 4}">
																				<th><div align="center">${DOMAINS.domainName}</div></th>
																			</c:if>
																		</c:forEach>
																	</tr>
																</thead>
																<tbody style="display: block;overflow-x: auto;height: 500px;" id="tbodyDprcId">
																	<c:set var="dprcIndex" value="0" scope="page" />
																		<c:forEach items="${LIST_OF_DISTRICT}" var="DISTRICT" varStatus="index">
																			<tr>
																				<td style="width: 234px;"><div align="center"><strong>${DISTRICT.districtNameEnglish}</strong></div></td>
																				<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS">
																					<c:if test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 4}">
																						<td><form:input path="tIWiseProposedDomainExperts[${dprcIndex + 3}].noOfExperts" class="active12 form-control Align-Right" id="noOfExpert_${dprcIndex}" onkeypress="return isNumber(event)"  onkeyup="domainValidation(${dprcIndex})"/></td>
																						<!-- hidden fields  -->
																							<input type="hidden" name="tIWiseProposedDomainExperts[${dprcIndex + 3}].domainId" value="${DOMAINS.domainId}">
																							<input type="hidden" name="tIWiseProposedDomainExperts[${dprcIndex + 3}].districtCode" value="${DISTRICT.districtCode}">
																							<form:hidden path="tIWiseProposedDomainExperts[${dprcIndex + 3}].tiWiseProposedDomainExpertsId"/>
																							<%-- <input type="hidden" name="tIWiseProposedDomainExperts[${dprcIndex + 3}].tiWiseProposedDomainExpertsId" value="${tIWiseProposedDomainExperts[dprcIndex + 3].tiWiseProposedDomainExpertsId}"> --%>
																						<!-- hidden fields ends here  -->
																						<c:set var="dprcIndex" value="${dprcIndex + 1}" scope="page"></c:set>
																					</c:if>
																				</c:forEach>
																			</tr>
																		</c:forEach>
																	<%-- <c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS">
																		<c:if
																			test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 4}">
																			<form:hidden path="tIWiseProposedDomainExperts[${temp}].tiWiseProposedDomainExpertsId"/>
																			<tr>
																				<th><div align="center">${DOMAINS.domainName}</div>
																					<input type="hidden"
																					name="tIWiseProposedDomainExperts[${temp}].domainId"
																					value="${DOMAINS.domainId}"></th>
																				<td><form:input
																						path="tIWiseProposedDomainExperts[${temp}].noOfExperts"
																						 onkeypress="return isNumber(event)"
																						 onkeyup="domainValidation(${temp})"
																						type="text" class="active12 form-control Align-Right" id="noOfExpert_${temp}"/></td>
																			</tr>
																		</c:if>
																		<c:set var="temp" value="${temp+1}" scope="page" />
																	</c:forEach> --%>
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
							<c:choose>
							 <c:when test="${USER_TYPE eq 'S' }">
							 <div class="col-lg-12 text-right">
							<c:if test="${ISFREEZE eq false}">
							<c:if test="${Plan_Status eq true}">
								<button type="button" class="btn bg-green waves-effect" id="save" onclick="save_data()">
									<spring:message code="Label.SAVE" htmlEscape="true" />
								</button>
                              
								<c:choose>
									<c:when test="${initial_status eq true}">
										<button type="button" id="freezebtn"
											class="freeze btn bg-orange waves-effect"
											onclick='freezeAndUnfreeze("freeze")'
											disabled="disabled">
											<spring:message code="Label.FREEZE" htmlEscape="true" />
										</button>
									</c:when>
									<c:otherwise>
										<button type="button" id="freezebtn"
											class="freeze btn bg-orange waves-effect"
											onclick='freezeAndUnfreeze("freeze")'>
											<spring:message code="Label.FREEZE" htmlEscape="true" />
										</button>
									</c:otherwise>
								</c:choose>
								
								<%-- 	<button type="button" onclick="onClear(this)"
									class="btn bg-light-blue waves-effect" id="clear">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</button> --%>
								</c:if>
								</c:if>
								
								<c:if test="${ISFREEZE eq true}">
								<c:if test="${Plan_Status eq true}">
								<button type="button" class="unfreeze btn bg-orange waves-effect" id="unfreezebtn"
									onclick='freezeAndUnfreeze("unfreeze")'>
									<spring:message code="Label.UNFREEZE" htmlEscape="true" />
								</button>
							</c:if>
							</c:if>
								<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-red waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>

							</div>
							 </c:when>
							 <c:otherwise>
							  <div class="col-lg-4">
									<button type="button"
										onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${institueInfraHrActivity.stateCode}')"
										class="btn bg-orange waves-effect">
										<i class="fa fa-arrow-left" aria-hidden="true"></i>
										<spring:message code="Label.BACK" htmlEscape="true" />
									</button>
								</div>
							 
							 <div class="col-lg-8 text-right">
							<c:if test="${ISFREEZE eq false}">
							<c:if test="${Plan_Status eq true}">
								<button type="button" class="btn bg-green waves-effect save-button" id="save" onclick="save_data()">
									<spring:message code="Label.SAVE" htmlEscape="true" />
								</button>
								<c:choose>
									<c:when test="${initial_status eq true}">
										<button type="button"
											class="freeze btn bg-orange waves-effect"
											onclick='freezeAndUnfreeze("freeze")'
											disabled="disabled">
											<spring:message code="Label.FREEZE" htmlEscape="true" />
										</button>
									</c:when>
									<c:otherwise>
										<button type="button"
											class="freeze btn bg-orange waves-effect"
											onclick='freezeAndUnfreeze("freeze")'>
											<spring:message code="Label.FREEZE" htmlEscape="true" />
										</button>
									</c:otherwise>
								</c:choose>
									<%-- <button type="button" onclick="onClear(this)"
									class="btn bg-light-blue waves-effect" id="clear">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</button> --%>
								</c:if>
								</c:if>
								
								<c:if test="${ISFREEZE eq true}">
								<c:if test="${Plan_Status eq true}">
								<button type="button" class="unfreeze btn bg-orange waves-effect"
									onclick='freezeAndUnfreeze("unfreeze")'>
									<spring:message code="Label.UNFREEZE" htmlEscape="true" />
								</button>
							</c:if>
							</c:if>
								<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-red waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>

							</div>
							 </c:otherwise>
							 </c:choose>
							</div>
						</div>
						<!-- HIDDEN FIELDS -->
						<input type="hidden" id="ISFREEZE"  value="${ISFREEZE}" />
						<input type="hidden" id="countSprcId" value="${countSprc}" />
						<input type="hidden" id="countDprcId" value="${countDprc}" />
						<input type="hidden" name="dbFileName" id="dbFileName" />
						<form:hidden path="userType" value="${PREVIOUS_RECORD_USER_TYPE}"/>
						<input type="hidden" name="instituteInfraHrActivityId" value="${institueInfraHrActivity.instituteInfraHrActivityId}" />
					</form:form>
				</div>
			</div>
		</div>
	</div>
	
</section>
<style>
.Align-Right{
text-align: right;}
</style>
