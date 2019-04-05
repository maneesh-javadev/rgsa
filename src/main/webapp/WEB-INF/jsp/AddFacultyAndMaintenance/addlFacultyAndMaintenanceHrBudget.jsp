<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script>

$('document').ready(function(){
 	/*  calculateGrandTotal();  */
 	calculateTotal();
	
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
	
	/*  this function calculate fund on the basis of no of units ,months,unit cost*/
	/*  function calculateFund(obj){
		document.getElementById("fund_"+obj).value = document.getElementById("noOfMonths_"+obj).value * document.getElementById("noOfUnits_"+obj).value * document.getElementById("unitCost_"+obj).value ;
		calculateTotal(obj);
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
		if($('#noOfUnits_'+ obj).val()=="" || $('#noOfMonths_'+ obj).val()==""){
			alert("Fill no. of unit section and no. of months section first.");
			$('#noOfMonths_'+ obj).focus();
			$('#noOfUnits_'+ obj).focus();
			$("#fund_"+obj).val("");
		}else{
		for(var i=0;i<=rowCount;i++){
			if($("#fund_"+i).val() != '' && $("#fund_"+i).val() != undefined)
			total += +$("#fund_"+i).val();
		}
		document.getElementById("total").value =total;
		calculateGrandTotal();
		
		 
		
	}
	}
	
	function calculateGrandTotal(){
		var a= parseInt(document.getElementById("total").value) ;
		/* alert(a); */
		document.getElementById("grandTotal").value =a +parseInt(document.getElementById("additionalRequirement").value);
		 
	/* 	calculateTotal();  */
		
		
	}
	
	function validatingAdditionalRequirement(obj){
		var grand_total=0;
		for(var i=0;i<obj;i++){
			grand_total += +$("#fund_"+i).val();
		}
		if(($("#additionalRequirement").val()>(grand_total*0.25))){
			alert("Additional Requirement should be smaller than or equal to 25% of Fund="+ 0.25*grand_total+"");
			document.getElementById("additionalRequirement").value="";
		}
		calculateGrandTotal();
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
	}else{ if(obj == 'noOfUnits'){
		
		var result= confirm("If you change No. of units you have to fill domain details again.Do you still want to continue?");
		if(result){
		if($('#noOfUnits_0').val() < noOfDomainSprc){
			alert('No of units in SPRC should not exceed the sum of domain detail '+ noOfDomainSprc);
			emptyDomainDetails('sprc',rowCountSprc);
		}else if($('#noOfUnits_3').val() < noOfDomainDprc){
			alert('No of units in DPRC should not exceed the sum of domain detail '+ noOfDomainDprc);
			emptyDomainDetails('dprc',rowCountSprc);
		}
		}
	}
	}
}

function emptyDomainDetails(level,count){
	if(level == 'sprc'){
		for(var i=0;i<count;i++){
			$('#noOfFaculty_'+i).val('');
		}
	}else{
		for(var i=3;i<count;i++){
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
}


 function myFunctionName(obj) {
	var rowCountSprc=$('#tbodySprcId tr').length;
	var noOfDomainSprc=0;
	var noOfDomainDprc=0;
	for(var i=0;i<rowCountSprc;i++){
		noOfDomainSprc += Number($('#noOfFaculty_'+i).val()) ;
		noOfDomainDprc += Number($('#noOfExpert_'+(i+3)).val());
	}
	
	if($('#noOfUnits_0').val() < noOfDomainSprc){
		alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_0').val());
		$('#noOfUnits_0').val('');
		
	}else if($('#noOfUnits_3').val() < noOfDomainDprc){
		alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_3').val());
		$('#noOfUnits_3').val('');
		
	}
}

function validationOnSubmit(){
		var rowCountSprc=$('#tbodySprcId tr').length;
		var flag= true;
		
		if($('#noOfUnits_0').val() == "" || $('#noOfUnits_0').val() == null){
			for(var i=0;i<rowCountSprc;i++){
				if($('#noOfFaculty_'+i).val() != "" || $('#noOfFaculty_'+i).val() != ""){
					flag=false;
				}else{
					break;
				}
			}
			}else{
				for(var i=0;i<rowCountSprc;i++){
				if($('#noOfFaculty_'+i).val() == "" || $('#noOfFaculty_'+i).val() == ""){
					flag=false;
				}else{
					break;
				}
				}
			}
		if($('#noOfUnits_3').val() == "" || $('#noOfUnits_3').val() == null){
			for(var i=0;i<rowCountSprc;i++){
			if($('#noOfExpert_'+(i+3)).val() != "" || $('#noOfExpert_'+(i+3)).val() != ""){
				flag=false;
			}else{
				break;
			}
			}
		}else{
			for(var i=0;i<rowCountSprc;i++){
			if($('#noOfExpert_'+(i+3)).val() == "" || $('#noOfExpert_'+(i+3)).val() == ""){
				flag=false;
			}else{
				break;
			}
			}
		}
		
		if(+$('#activedropdown').val() == 0 && $('#noOfUnits_3').val() != ""){
			alert("please select district in domain detail of DPRC.");
			return flag=false;
		}  
		
		if(($('#noOfUnits_3').val() == "" || $('#noOfUnits_0').val() == "") && flag == false){
			alert("Fill the number of units first.");
		}else if(!flag){
			alert("Fill the domain details first.");
		}
		return flag;
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
						modelAttribute="ADDITIONAL_FACULTY_MAINT_MODEL" onsubmit="return validationOnSubmit()">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="addFacultyAndMaintenanceHrBudget.html" />" />
						<div class="body">
							<div class="row clearfix">
								<div class="form-group">
									<div class="col-sm-4">
										<label for="District"><spring:message
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
											<th><div align="center"><spring:message code="Label.TypeOfCenter" htmlEscape="true" /></div></th>
											<th><div align="center"><spring:message code="Label.Faculty&Staff" htmlEscape="true" /></div></th>
											<th><div align="center"><spring:message code="Label.NoofUnits" htmlEscape="true" /></div></th>
											<%-- <th><div align="center"><spring:message code="Label.UnitCost" htmlEscape="true" /></div></th> --%>
											<th><div align="center"><spring:message code="Label.NoOfMonths" htmlEscape="true" /></div></th>
											<th><div align="center"><spring:message code="Label.Funds" htmlEscape="true" /></div></th>
											<!-- <th><div align="center">Others Expenses</div></th> -->
											<!-- <th><div align="center">Total Cost</div></th> -->
											<th><div align="center"><spring:message code="Label.DomainDetails" htmlEscape="true" /></div></th>
											<c:if test="${USER_TYPE eq 'M' or USER_TYPE eq 'C'}"><th><div align="center"><spring:message code="Label.IsApproved" htmlEscape="true" /></div></th></c:if>
											<th><div align="center"><spring:message code="Label.Remarks" htmlEscape="true" /></div></th>
										</tr>
									</thead>
									<tbody id="tbodyMainTableId">
									<c:set var="count" value="0" scope="page" />
									<c:forEach items="${LIST_OF_ACTIVITY_HR_TYPE}" var="ACTIVITY">
										<input type="hidden" id="ISFREEZE"  value="${ISFREEZE}"/>
										<input type="hidden" id="trainingInstituteId_${count}"  value="${ACTIVITY.trainingInstitueType.trainingInstitueTypeId}"/>
										<form:hidden path="institueInfraHrActivityDetails[${count}].instituteInfraHrActivityType.instituteInfraHrActivityTypeId" value="${ACTIVITY.instituteInfraHrActivityTypeId}"/>
										<form:hidden path="institueInfraHrActivityDetails[${count}].instituteInfrsaHrActivityDetailsId" />
										<tr>
											<td><div align="center"><strong>${ACTIVITY.trainingInstitueType.trainingInstitueTypeName}</strong></div></td>
											
											<td><div align="center"><strong>${ACTIVITY.instituteInfraHrActivityName}</strong></div></td>
											
											<c:choose>
											<c:when test="${count ne 2 and count ne 5}">
											<td><form:input path="institueInfraHrActivityDetails[${count}].noOfUnits" type="text" onkeypress="return isNumber(event)" maxlength="5" class="active12 form-control Align-Right" id="noOfUnits_${count}" onkeyup="validateCeilingValue(${count})" onchange="domainValidation('noOfUnits')" /></td>
											
											<%-- <td><form:input path="institueInfraHrActivityDetails[${count}].unitCost" type="text" maxlength="7" onkeypress="return isNumber(event)" class="active12 form-control Align-Right" id="unitCost_${count}" onkeyup="calculateFund(${count});validateCeilingValue(${count})"/></td> --%>
											
											<td><form:input path="institueInfraHrActivityDetails[${count}].noOfMonths" type="text" onkeypress="return isNumber(event)" class="active12 form-control Align-Right" id="noOfMonths_${count}" onchange="validateMonth(${count})" onkeyup="validateCeilingValue(${count})" /></td>
											</c:when>
											<c:otherwise>
											<td></td>
											<td></td>
											</c:otherwise>
											</c:choose>

											<td><form:input path="institueInfraHrActivityDetails[${count}].fund" type="text" onkeypress="return isNumber(event)" class="active12 form-control Align-Right active1" id="fund_${count}" onkeyup="calculateTotal(${count});validateCeilingValue(${count})"/></td>
											
											<%-- <td><form:input path="institueInfraHrActivityDetails[${count}].otherExpenses" type="number" class="active12 form-control" id="otherExpenses_${count}" onchange="validate(${count}),calculate(${count})"  /></td> --%>
													
											<%-- <td><form:input path="institueInfraHrActivityDetails[${count}].totalFund" onkeypress="return isNumber(event)" id="totalFund_${count}" class="active12 form-control Align-Right active1" type="text" /></td> --%>

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
											<c:if test="${USER_TYPE eq 'M'}"><td><form:checkbox path="institueInfraHrActivityDetails[${count}].isApproved" class="active12 form-control-check" /></td></c:if>
											<td><form:textarea path="institueInfraHrActivityDetails[${count}].remarks" rows="3" cols="5" class="active12 form-control" /></td>
										</tr>
										<c:set var="count" value="${count +1}" scope="page" />
									</c:forEach>
									<tr>
										<td><div align="center">
												<strong><spring:message code="Label.TotalCost" htmlEscape="true" /></strong>
											</div></td>
										<td colspan="3"></td>
										<td><form:input path="total" type="text" class="active12 form-control Align-Right" id="total" onkeypress="return isNumber(event)" onkeyup="validatingAdditionalRequirement(${count});calculateGrandTotal(${ACTIVITY.trainingInstitueType.trainingInstitueTypeId},${count})" disabled="true"/></td>
									</tr>
									<tr>
										<td><div align="center">
												<strong><spring:message code="Label.AdditionalRequirement" htmlEscape="true" /></strong>
											</div></td>
										<td colspan="3"></td>
										<td><form:input path="additionalRequirement" type="text" onkeypress="return isNumber(event)" class="active12 form-control Align-Right" id="additionalRequirement" onkeyup="validatingAdditionalRequirement(${count});calculateGrandTotal()"/></td>
									</tr>
									<tr>
										<td><div align="center">
												<strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /></strong>
											</div></td>
										<td colspan="3"></td>
										<td><form:input path="grand_total" type="text" class="active12 form-control Align-Right" id="grandTotal" onchange="validatingAdditionalRequirement(${count})" disabled="true"/></td>
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
												<!-- <button type="button" class="btn btn-success">Save</button> -->
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
														<label for="sprc" class="col-sm-3">Institute Type
															:</label>
														<div class="col-sm-5">
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
												</div>
												<div class="row clearfix">
													<div class="body">
														<div class="table-responsive">
															<table class="table table-bordered">
																<thead>
																	<tr>
																		<th><div align="center">Domain</div></th>
																		<th><div align="center">No.of Experts</div></th>
																	</tr>
																</thead>
																<tbody >
																	<c:set var="temp" value="0" scope="page" />
																	<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS">
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
							<c:choose>
							 <c:when test="${USER_TYPE eq 'S' }">
							 <div class="col-lg-12 text-right">
							<c:if test="${ISFREEZE eq false}">
							<c:if test="${Plan_Status eq true}">
								<button type="submit" class="btn bg-green waves-effect" id="save">
									<spring:message code="Label.SAVE" htmlEscape="true" />
								</button>
                              
								<button type="button" class="freeze btn bg-green waves-effect"
									 onclick='freezeAndUnfreeze("freeze")' >
									<spring:message code="Label.FREEZE" htmlEscape="true" />
								</button>
								
									<button type="button" onclick="onClear(this)"
									class="btn bg-light-blue waves-effect" id="clear">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</button>
								</c:if>
								</c:if>
								
								<c:if test="${ISFREEZE eq true}">
								<c:if test="${Plan_Status eq true}">
								<button type="button" class="unfreeze btn bg-green waves-effect"
									onclick='freezeAndUnfreeze("unfreeze")'>
									<spring:message code="Label.UNFREEZE" htmlEscape="true" />
								</button>
							</c:if>
							</c:if>
								<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect">
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
								<button type="submit" class="btn bg-green waves-effect" id="save">
									<spring:message code="Label.SAVE" htmlEscape="true" />
								</button>

								<button type="button" class="freeze btn bg-green waves-effect"
									 onclick='freezeAndUnfreeze("freeze")' >
									<spring:message code="Label.FREEZE" htmlEscape="true" />
								</button>
									<button type="button" onclick="onClear(this)"
									class="btn bg-light-blue waves-effect" id="clear">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</button>
								</c:if>
								</c:if>
								
								<c:if test="${ISFREEZE eq true}">
								<c:if test="${Plan_Status eq true}">
								<button type="button" class="unfreeze btn bg-green waves-effect"
									onclick='freezeAndUnfreeze("unfreeze")'>
									<spring:message code="Label.UNFREEZE" htmlEscape="true" />
								</button>
							</c:if>
							</c:if>
								<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>

							</div>
							 </c:otherwise>
							 </c:choose>
							</div>
							
							<input type="hidden" name="dbFileName" id="dbFileName">
							 <input type="hidden" name="instituteInfraHrActivityId"
								value="${institueInfraHrActivity.instituteInfraHrActivityId}">
						</div>
						<form:hidden path="userType" value="${PREVIOUS_RECORD_USER_TYPE}"/>
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
