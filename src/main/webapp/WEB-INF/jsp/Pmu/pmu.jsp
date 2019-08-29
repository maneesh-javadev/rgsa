<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript">
var domain_list = '${LIST_OF_PMU_DOMAINS}';
$(document).ready(function() {
	
	 calculateTotalFundSpmu();
	 //calculateTotalFundDpmu();
	
	var myBoolean = document.getElementById("isFreeze").value;
	if(myBoolean == "true"){
		 $("input").prop('disabled', true);
		 $("#saveButtn").prop('disabled', true);
		 $("select").prop('disabled', true);
		 $("#frzButtn").hide();
		 $("textarea").prop('disabled', true);
		 $("#unFrzButtn").show();
		 $("#clearButtn").prop('disabled', true);
	 }
	if(myBoolean == "false" || myBoolean==""){
		 $("input").prop('disabled', false);
		 $("#saveButtn").prop('disabled', false);
		 $("select").prop('disabled', false);
		 $("#frzButtn").show();
		 $("#unFrzButtn").hide();
		 $("#clearButtn").prop('disabled', false);
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

function calculate(obj){
	var noOfMonths = $("#noOfMonths_"+obj).val();
	if(noOfMonths > 12){
		alert("Months should be less than 12 !");
		$("#noOfMonths_"+obj).val('');
	}else if(noOfMonths == 0 && noOfMonths !="") {
		alert("Months should be greater than 0!");
		$("#noOfMonths_"+obj).val('');
	}
	$("#fund_"+obj).val(+$("#noOfUnits_"+obj).val() * +$("#unitCost_"+obj).val() * +$("#noOfMonths_"+obj).val()); 
	calculateTotalFundSpmu();
	calculateTotalFundDpmu();
}

function validateMonth(index){
	var noOfMonths = $("#noOfMonths_"+index).val();
		if(noOfMonths < 1 || noOfMonths > 12){
			alert('Number of month should not be greater than 12 and less than 1.');
			$("#noOfMonths_"+index).val('');
			$("#noOfMonths_"+index).focus();
		}
				
}

function validateFund(index){
	if($("#fund_"+index).val() != ''){
		if($("#noOfUnits_"+index).val() == '' || $("#noOfMonths_"+index).val() == ''){
			alert('Please fill number of units and number of months first.');
			$("#fund_"+index).val('');
		}  
	}
}

/* function totalfunds(){
	if($("#total_fund_spmu").val() == "" && $("#total_fund_dpmu").val() != ""){
		$("#grandtotal").val( +$("#total_fund_spmu").val() + + $("#total_fund_dpmu").val());
	}else if($("#total_fund_dpmu").val() == "" && $("#total_fund_spmu").val() != ""){
		$("#grandtotal").val( +$("#total_fund_spmu").val() + + $("#total_fund_dpmu").val());
	}else if($("#total_fund_dpmu").val() == "" && $("#total_fund_spmu").val() == ""){
		$("#grandtotal").val('');
	}else{
		$("#grandtotal").val( +$("#total_fund_spmu").val() + + $("#total_fund_dpmu").val());
	}
} */

function toFreeze(){
	 $("input").prop('disabled', false);
	document.pmuController.method = "post";
	document.pmuController.action = "pmuFreezUnfreez.html?<csrf:token uri='pmuFreezUnfreez.html'/>";
	document.pmuController.submit();
}


function calculateValue(obj)
{
	var rowCountSprc=$('#tbodySprcId tr').length;
	var noOfDomainSprc=0;
	var noOfDomainDprc=0;
	for(var i=0;i<rowCountSprc;i++){
		noOfDomainSprc += Number($('#noOfFaculty_'+i).val()) ;
		noOfDomainDprc += Number($('#noOfExperts_'+(i+3)).val());
	}
	
	if($('#noOfUnits_0').val() < noOfDomainSprc){
		alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_0').val());
		$('#noOfUnits_0').val('');
		
	} if($('#noOfUnits_3').val() < noOfDomainDprc){
		alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_3').val());
		$('#noOfUnits_3').val('');
	}
}

function calculateValueAcDomain(index){
	var rowCountSprc=$('#tbodySprcId tr').length;
	var rowCountDprc=$('#tbodyDprcId tr').length * domain_list.split(',').length / 2;
	var noOfDomainSprc=0;
	var noOfDomainDprc=0;
	for(var i=0;i<rowCountSprc;i++){
		noOfDomainSprc += Number($('#noOfFaculty_'+i).val()) ;
	}
	for(var i=0;i<rowCountDprc;i++){
		noOfDomainDprc += Number($('#noOfExperts_'+(i)).val());
	}
	
	/* if($('#noOfUnits_0').val() < noOfDomainSprc){
		alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_0').val());
		$('#noOfFaculty_'+obj).val('');
		
	}
	 if($('#noOfUnits_3').val() < noOfDomainDprc){
		alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_3').val());
		$('#noOfExperts_'+obj).val('');
		
	} */
	 
	 if(!isNaN(index)){
			if($('#noOfUnits_0').val() < noOfDomainSprc){
				alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_0').val());
				$('#noOfFaculty_'+index).val('');
			}else if($('#noOfUnits_3').val() < noOfDomainDprc){
				alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_3').val());
				$('#noOfExperts_'+index).val('');
			}
			}else{ if(index == 'noOfUnits_0' && noOfDomainSprc != 0){
					var result= confirm("If you change Number of units you have to fill domain details.");
					if(result){
					if($('#noOfUnits_0').val() < noOfDomainSprc){
						alert('No of units in SPRC should not exceed the sum of domain detail :'+ noOfDomainSprc + ' please fill the domain details again.');
						emptyDomainDetails('spmu',rowCountSprc);
					}
					}else{
						if($('#noOfUnits_0').val() < noOfDomainSprc){
							alert('No of units in SPRC should not exceed the sum of domain detail '+ noOfDomainSprc );
							$('#noOfUnits_0').val('');
						}
					}
			}else if(index == 'noOfUnits_3' && noOfDomainDprc != 0){
				var result= confirm("If you change Number of units you have to fill domain details.");
				if(result){
				if($('#noOfUnits_3').val() < noOfDomainDprc){
					alert('No of units in DPRC should not exceed the sum of domain detail :'+ noOfDomainDprc + ' please fill the domain details again.');
					emptyDomainDetails('dpmu',rowCountDprc);
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
	if(level == 'spmu'){
		for(var i=0;i<count;i++){
			$('#noOfFaculty_'+i).val('');
		}
	}else{
		for(var i=0;i<count;i++){
			$('#noOfExperts_'+i).val('');
		}
	}
}

function validationOnSubmit(){
	var rowCountSprc=$('#tbodySprcId tr').length;
	//var rowCountDprc=$('#tbodyDprcId tr').length * domain_list.split(',').length / 2;
	var flag= true;
	
	/* if(($('#total_fund_spmu').val() == 0 || $('#total_fund_spmu').val() == null) && ($('#total_fund_dpmu').val() == 0 || $('#total_fund_dpmu').val() == null)){
		alert('Blank form cannot be save or freeze.');
		flag=false;
	} */
	
	if($('#total_fund_spmu').val() == 0 || $('#total_fund_spmu').val() == ''){
		alert('Blank form cannot be save or freeze.');
		return false;
	}
	
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
				flag=true;
				break;
			}
			}
		}
	
	  /* if($('#noOfUnits_3').val() == "" || $('#noOfUnits_3').val() == null){
		for(var i=0;i<rowCountDprc;i++){
		if($('#noOfExperts_'+(i)).val() != "" || $('#noOfExperts_'+(i)).val() != ""){
			flag=false;
		}else{
			break;
		}
		}
	}else{
		for(var i=0;i<rowCountDprc;i++){
		if($('#noOfExperts_'+(i)).val() == "" || $('#noOfExperts_'+(i)).val() == ""){
			flag=false;
		}else{
			flag=true;
			break;
		}
		}
	} */
	
	if(+$('#activedropdown').val() == 0 && $('#noOfUnits_3').val() != ""){
		alert("please select district in domain detail of DPRC.");
		return flag=false;
	}  
	  
	/* if(($('#noOfUnits_3').val() == "" || $('#noOfUnits_0').val() == "") && flag == false){
		alert("Fill the number of units first.");
	}else if(!flag){
		alert("Fill the domain details first.");
	} */
	
	if($('#noOfUnits_0').val() == "" && flag == false){
		alert("Fill the number of units first.");
	}else if(!flag){
		alert("Fill the domain details first.");
	}
	
	return flag;
}

function calculateTotalFundSpmu() {
	var count = $("#countSpmuId").val();
	var total_spmu_fund = 0;
	for (var i = 0; i < count; i++) {
		if($("#fund_" + i).val() != null && $("#fund_" + i).val() != ""){
			total_spmu_fund += +$("#fund_" + i).val();
		}
	}
	$("#total_fund_spmu").val(+total_spmu_fund); 
	//totalfunds();
};

/* function calculateTotalFundDpmu() {
	var count = $("#countDpmuId").val();
	var total_dpmu_fund = 0;
	for (var i = 0; i < count; i++) {
		if($("#fund_"+(i + +$("#countSpmuId").val())).val() != null && $("#fund_"+(i + +$("#countSpmuId").val())).val() != ""){
			total_dpmu_fund += +$("#fund_"+(i + +$("#countSpmuId").val())).val();
		}
	}
	$("#total_fund_dpmu").val(total_dpmu_fund); 
	totalfunds();
}; */
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
					<c:choose>
						<c:when test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}"><h2><spring:message code="Label.PMUheader" htmlEscape="true" /> MoPR</h2></c:when>
						<c:otherwise><h2><spring:message code="Label.PMUheader" htmlEscape="true" /></h2></c:otherwise>
					</c:choose>
					</div>
					<div class="body">
						<form:form method="post" name="pmuController" action="addUpdatePmu.html"	modelAttribute="PMU_ACTIVITY" onsubmit="return validationOnSubmit()">
							<input type="hidden" name="<csrf:token-name/>"	value="<csrf:token-value uri="addPmuActivity.html" />" />
									<div class="table-responsive">
										<table class="table table-bordered" id="supportStaff">
											<thead>
												<tr>
													<th><div align="center"><spring:message code="Label.TypeOfCenter" htmlEscape="true" /></div></th>
													<th><div align="center"><spring:message code="Label.Faculty&Staff" htmlEscape="true" /></div></th>
													<th><div align="center"><spring:message code="Label.NoOfUnits" htmlEscape="true" /><br>(A)</div></th>
													<%-- <th><div align="center"><spring:message code="Label.UnitCost" htmlEscape="true" /><br>(B)</div></th> --%>
													<th><div align="center"><spring:message code="Label.NoOfMonths" htmlEscape="true" /><br>(C)</div></th>
													<th><div align="center"><spring:message code="Label.Funds" htmlEscape="true" /><br>D= (A*B*C)</div></th>
													<!-- <th><div align="center">Others Expenses</div></th>
													<th><div align="center">Total Cost</div></th> -->
													<th><div align="center"><spring:message code="Label.DomainDetails" htmlEscape="true" /></div></th>
													<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
													<th><div align="center"><spring:message code="Label.IsApproved" htmlEscape="true" /></div></th>
													</c:if>
													<th><div align="center"><spring:message code="Label.Remarks" htmlEscape="true" /></div></th>
												</tr>
											</thead>
											<tbody id="mainTbodyId">
											<c:set var="countSpmu" value="0" scope="page" />
											<c:set var="countDpmu" value="0" scope="page" />
											<c:forEach items="${LIST_OF_ACTIVITY_PMU_TYPE}" var="ACTIVITY" varStatus="srl" begin="0" end="2">
											<input	type="hidden" name="pmuActivityDetails[${srl.index}].pmuActivityTypeId"	value="${ACTIVITY.pmuActivityTypeId}">
											<input	type="hidden" name="pmuActivityDetails[${srl.index}].pmuDetailsId"	value="${pmuActivity.pmuActivityDetails[srl.index].pmuDetailsId}">
											<input	type="hidden" name="pmuActivityDetails[${srl.index}].pmuActivityType.pmuActivityTypeId"	value="${ACTIVITY.pmuActivityTypeId}" />
											<tr>
												<td><div align="center"><strong>${ACTIVITY.pmuType.pmuTypeName}</strong></div></td>
												<td><div align="center"><strong>${ACTIVITY.pmuActivityName}</strong></div></td>
												<td><input value="${pmuActivity.pmuActivityDetails[srl.index].noOfUnits}"	name="pmuActivityDetails[${srl.index}].noOfUnits" min="1" maxlength="3"  onkeypress="return isNumber(event)" oninput="validity.valid||(value='');"	type="text" class="active12 form-control" id="noOfUnits_${srl.index}" onkeyup="" style="text-align:right;" onchange="calculateValueAcDomain('noOfUnits_${srl.index}')"/></td>
												<%-- <td><input value="${pmuActivity.pmuActivityDetails[srl.index].unitCost}"	name="pmuActivityDetails[${srl.index}].unitCost" min="1" maxlength="7"  onkeypress="return isNumber(event)" oninput="validity.valid||(value='');" type="text" class="active12 form-control"	id="unitCost_${srl.index}" onkeyup="calculate(${srl.index});" style="text-align:right;"/></td> --%>
												<td><input value="${pmuActivity.pmuActivityDetails[srl.index].noOfMonths}" 	name="pmuActivityDetails[${srl.index}].noOfMonths" onkeypress="return isNumber(event)" oninput="validity.valid||(value='');" type="text" class="active12 form-control" id="noOfMonths_${srl.index}" style="text-align:right;" onkeyup="validateMonth(${srl.index})"/></td>
												<c:set var="totalFundToCalc" value="${pmuActivity.pmuActivityDetails[srl.index].fund}"></c:set>
												<td><input value="${pmuActivity.pmuActivityDetails[srl.index].fund}" name="pmuActivityDetails[${srl.index}].fund" onkeypress="return isNumber(event);" oninput="validity.valid||(value='');" type="text" min="1" class="active12 form-control txtCal" id="fund_${srl.index}" style="text-align:right;" onkeyup="calculateTotalFundSpmu();validateFund(${srl.index});"/></td>
													<c:choose>
														<c:when test="${srl.index eq 0}">
															<td><div align="center"><button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">Fill Domain Details</button></div></td>
														</c:when>
														<c:when test="${srl.index eq 3}">
															<td><div align="center"><button type="button"	class="btn btn-primary btn-lg" data-toggle="modal"	data-target="#myModal2">Fill Domain Details</button></div></td>
														</c:when>
														<c:otherwise>
															<td></td>
														</c:otherwise>
													</c:choose>
											<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
	                                             <td><c:choose>
	                                             			<c:when test="${pmuActivity.pmuActivityDetails[srl.index].isApproved}">	
														  		 <input type="checkbox" name="pmuActivityDetails[${srl.index}].isApproved" checked="checked"  />
														   </c:when>
														   <c:otherwise>
														   		<input type="checkbox" name="pmuActivityDetails[${srl.index}].isApproved" />
														   </c:otherwise>
													</c:choose>
												</td>
										   </c:if>
										   <td><textarea name="pmuActivityDetails[${srl.index}].remarks" rows="3" class="form-control" cols="5"><c:out value="${pmuActivity.pmuActivityDetails[srl.index].remarks}"></c:out></textarea></td>
												</tr>
												<c:set var="countSpmu" value="${countSpmu + 1}" scope="page" />
											</c:forEach>
										<tr>
											<th colspan="5"><label>Total SPMU Fund</label></th>
											<td><input type="text" style="background: #dddddd;"
												class="form-control Align-Right" id="total_fund_spmu"
												value="" disabled="disabled"></td>
											<td></td>
											<td></td>

										</tr>
										<!-- SPMU LOOP ENDS HERE  -->
										
										<!-- DPMU LOOP STARTS FROM HERE -->
										<%-- <c:forEach items="${LIST_OF_ACTIVITY_PMU_TYPE}" var="ACTIVITY" varStatus="srl" begin="3" end="5">
											<input	type="hidden" name="pmuActivityDetails[${srl.index}].pmuActivityTypeId"	value="${ACTIVITY.pmuActivityTypeId}">
											<input	type="hidden" name="pmuActivityDetails[${srl.index}].pmuDetailsId"	value="${pmuActivity.pmuActivityDetails[srl.index].pmuDetailsId}">
											<input	type="hidden" name="pmuActivityDetails[${srl.index}].pmuActivityType.pmuActivityTypeId"	value="${ACTIVITY.pmuActivityTypeId}" />
											<tr>
												<td><div align="center"><strong>${ACTIVITY.pmuType.pmuTypeName}</strong></div></td>
												<td><div align="center"><strong>${ACTIVITY.pmuActivityName}</strong></div></td>
												<td><input value="${pmuActivity.pmuActivityDetails[srl.index].noOfUnits}"	name="pmuActivityDetails[${srl.index}].noOfUnits" min="1" maxlength="3"  onkeypress="return isNumber(event)" oninput="validity.valid||(value='');"	type="text" class="active12 form-control" id="noOfUnits_${srl.index}" onkeyup="calculate(${srl.index}); calculateValue(${srl.index})" style="text-align:right;" /></td>
												<td><input value="${pmuActivity.pmuActivityDetails[srl.index].unitCost}"	name="pmuActivityDetails[${srl.index}].unitCost" min="1" maxlength="7"  onkeypress="return isNumber(event)" oninput="validity.valid||(value='');" type="text" class="active12 form-control"	id="unitCost_${srl.index}" onkeyup="calculate(${srl.index});" style="text-align:right;" /></td>
												<td><input value="${pmuActivity.pmuActivityDetails[srl.index].noOfMonths}" 	name="pmuActivityDetails[${srl.index}].noOfMonths" min="1"  onkeypress="return isNumber(event)" oninput="validity.valid||(value='');"	type="text" class="active12 form-control" id="noOfMonths_${srl.index}" onkeyup="calculate(${srl.index});" style="text-align:right;" /></td>
												<c:set var="totalFundToCalc" value="${pmuActivity.pmuActivityDetails[srl.index].fund}"></c:set>
												<td><input value="${pmuActivity.pmuActivityDetails[srl.index].fund}" readonly="readonly" name="pmuActivityDetails[${srl.index}].fund"  onkeypress="return isNumber(event)" oninput="validity.valid||(value='');" type="text" min="1" class="active12 form-control txtCal" id="fund_${srl.index}" style="text-align:right;" onchange="calculateTotalFundDpmu()"/></td>
													<c:choose>
														<c:when test="${srl.index eq 0 }">
															<td><button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">Fill Domain Details</button></td>
														</c:when>
														<c:when test="${srl.index eq 3}">
															<td><button type="button"	class="btn btn-primary btn-lg" data-toggle="modal"	data-target="#myModal2">Fill Domain Details</button></td>
														</c:when>
														<c:otherwise>
															<td></td>
														</c:otherwise>
													</c:choose>
											<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
	                                             <td><c:choose>
	                                             			<c:when test="${pmuActivity.pmuActivityDetails[srl.index].isApproved}">	
														  		 <input type="checkbox" name="pmuActivityDetails[${srl.index}].isApproved" checked="checked"  />
														   </c:when>
														   <c:otherwise>
														   		<input type="checkbox" name="pmuActivityDetails[${srl.index}].isApproved" />
														   </c:otherwise>
													</c:choose>
												</td>
										   </c:if>
										   <td><textarea name="pmuActivityDetails[${srl.index}].remarks" rows="3" class="form-control" cols="5"><c:out value="${pmuActivity.pmuActivityDetails[srl.index].remarks}"></c:out></textarea></td>
												</tr>
												<c:set var="countDpmu" value="${countDpmu + 1}" scope="page" />
											</c:forEach>
										<tr>
											<th colspan="5"><label>Total DPMU Fund</label></th>
											<td><input type="text" style="background: #dddddd;"
												class="form-control Align-Right" id="total_fund_dpmu"
												value="" disabled="disabled"></td>
											<td></td>
											<td></td>

										</tr> --%>
										<!-- DPMU LOOP ENDS HERE -->
										<%-- <tr>
											<th colspan="5"><label><spring:message code="Label.TotalAmountProposed" htmlEscape="true" /></label></th>
													<td>											
															<input type="text" style="background: #dddddd;"
																class="form-control Align-Right" id="grandtotal"
																value="${totalFundToCalc}" disabled="disabled">
														</td>
														<td></td>
														<td></td>
														
												</tr> --%>
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
																<label for="sprc" class="col-sm-3"><spring:message code="Label.InstituteType" htmlEscape="true" /></label>
																<div class="col-sm-5">
																	<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS"	begin="1" end="1">
																		<c:if	test="${DOMAINS.pmuType.pmuTypeId eq 1}">
																			<p class="text-justify"><strong>${DOMAINS.pmuType.pmuTypeName}</strong></p>
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
																				<th><div align="center"><spring:message code="Label.Domain" htmlEscape="true" /></div></th>
																				<th><div align="center"><spring:message code="Label.NoOfExperts" htmlEscape="true" /></div></th>
																			</tr>
																		</thead>
																		<tbody id="tbodySprcId">
																			<c:set var="temp" value="0" scope="page" />
																			<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS">
																				<c:if	test="${DOMAINS.pmuType.pmuTypeId eq 1 }">
																					<input type="hidden" name="pmuWiseProposedDomainExperts[${temp}].pmuWiseProposedDomainExpertsId" value="${pmuWiseDomainList[temp].pmuWiseProposedDomainExpertsId}"/>
																					<tr>
																						<th><div align="center">${DOMAINS.pmuDomainName}</div>
																							<input type="hidden" name="pmuWiseProposedDomainExperts[${temp}].domainId"	value="${DOMAINS.pmuDomainId}"></th>
																						<td><input	name="pmuWiseProposedDomainExperts[${temp}].noOfExperts" value="${pmuWiseDomainList[temp].noOfExperts}"	type="text" class="active12 form-control Align-Right"	id="noOfFaculty_${temp}"  onkeyup="calculateValueAcDomain(${temp})" /></td>
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
															data-dismiss="modal"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
													</div>
												</div>
		
											</div>
										</div>
										<%-- <div id="myModal2" class="modal fade" role="dialog">
											<div class="modal-dialog modal-lg">
												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">&times;</button>
													</div>
													<div class="modal-body">
														<div class="row">
															<div class="form-group">
																<label for="sprc" class="col-sm-3"><spring:message code="Label.InstituteType" htmlEscape="true" /></label>
																<div class="col-sm-5">
																	<!-- <select> -->
																	<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS"	begin="1" end="3">
																		<c:if test="${DOMAINS.pmuType.pmuTypeId eq 2}">
																			<p class="text-justify"><strong>${DOMAINS.pmuType.pmuTypeName}</strong></p>
																		</c:if>
																	</c:forEach>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="form-group">
																<label for="Dprc" class="col-sm-3"><spring:message code="Label.District" htmlEscape="true" /></label>
																<div class="col-sm-5">
																	<select name="setDistrictIdPmuWise" id="activedropdown" required="required">
																		<option value="0">---select---</option>
																		<c:forEach items="${LIST_OF_DISTRICT}" var="DISTRICT">
																		<c:choose>
																			<c:when test="${pmuWiseDomainList[3].districtId == DISTRICT[0]}">
																			<option value="${DISTRICT[0]}" selected="selected">${DISTRICT[1]}</option>
																			</c:when>
																			<c:otherwise>
																				<option value="${DISTRICT[0]}" >${DISTRICT[1]}</option>
																			</c:otherwise>
																		</c:choose>
																		</c:forEach>
																	</select>
																</div>
															</div>
														</div>
														<div class="row clearfix">
															<div class="body">
																<div class="table-responsive">
																	<table class="table table-hover">
																		<thead style="background-color: #b39ad8;color: #2f2b2bf2;display: table;width: 100%;">
																			<tr>
																				<th><div align="center">District Name</div></th>
																				<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS">
																					<c:if test="${DOMAINS.pmuType.pmuTypeId eq 2}">
																						<th><div align="center">${DOMAINS.pmuDomainName}</div></th>
																					</c:if>
																				</c:forEach>
																			</tr>
																		</thead>
																		<tbody style="display: block;overflow-x: auto;height: 500px;" id="tbodyDprcId">
																			<c:set var="dprcIndex" value="0" scope="page" />
																			<c:forEach items="${LIST_OF_DISTRICT}" var="DISTRICT" varStatus="index">
																			<tr>
																				<td style="width: 234px;"><div align="center"><strong>${DISTRICT[1]}</strong></div></td>
																				<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS">
																					<c:if test="${DOMAINS.pmuType.pmuTypeId eq 2}">
																						<td><form:input path="pmuWiseProposedDomainExperts[${dprcIndex + 3}].noOfExperts" class="active12 form-control Align-Right" id="noOfExperts_${dprcIndex}" onkeypress="return isNumber(event)"  onkeyup="calculateValueAcDomain(${dprcIndex})"/></td>
																						<!-- hidden fields  -->
																							<input type="hidden" name="pmuWiseProposedDomainExperts[${dprcIndex + 3}].domainId" value="${DOMAINS.pmuDomainId}">
																							<input type="hidden" name="pmuWiseProposedDomainExperts[${dprcIndex + 3}].districtId" value="${DISTRICT[0]}">
																							<input type="hidden" name="pmuWiseProposedDomainExperts[${dprcIndex + 3}].pmuWiseProposedDomainExpertsId" value="${pmuActivity.pmuWiseProposedDomainExperts[dprcIndex + 3].pmuWiseProposedDomainExpertsId}">
																						<!-- hidden fields ends here  -->
																						<c:set var="dprcIndex" value="${dprcIndex + 1}" scope="page"></c:set>
																					</c:if>
																				</c:forEach>
																			</tr>
																		</c:forEach>
																		</tbody>
																	
																		<thead>
																			<tr>
																				<th><div align="center"><spring:message code="Label.Domain" htmlEscape="true" /></div></th>
																				<th><div align="center"><spring:message code="Label.NoOfExperts" htmlEscape="true" /></div></th>
																			</tr>
																		</thead>
																		<tbody id="tbodyDprcId">
																			<c:set var="temp" value="0" scope="page" />
																			<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS">
																				<c:if test="${DOMAINS.pmuType.pmuTypeId eq 2}">
																					<input type="hidden" name="pmuWiseProposedDomainExperts[${temp}].pmuWiseProposedDomainExpertsId" value="${pmuWiseDomainList[temp].pmuWiseProposedDomainExpertsId}"/>
																					<tr>
																						<th><div align="center">${DOMAINS.pmuDomainName}</div>
																							<input type="hidden" name="pmuWiseProposedDomainExperts[${temp}].domainId" value="${DOMAINS.pmuDomainId}"></th>
																						<td><input	name="pmuWiseProposedDomainExperts[${temp}].noOfExperts" value="${pmuWiseDomainList[temp].noOfExperts}"	type="text" id="noOfExperts_${temp}" onkeyup="calculateValueAcDomain(${temp})" class="active12 form-control Align-Right"/></td>
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
														<button type="button" class="btn btn-danger" data-dismiss="modal"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
													</div>
												</div>
											</div>
										</div> --%>
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
									<div class="form-group text-right">
									 <c:if test="${Plan_Status eq true}"> 
										<button type="submit" id="saveButtn" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
										<c:if test="${pmuActivity.isFreeze != undefined}">
										
										<button type="button" class="freeze btn bg-green waves-effect"	id="frzButtn" onclick="toFreeze();"><spring:message code="Label.FREEZE" htmlEscape="true" /></button>
										<button type="button" class="unfreeze btn bg-green waves-effect" id="unFrzButtn" onclick="toFreeze();"><spring:message code="Label.UNFREEZE" htmlEscape="true" /></button>
										</c:if>
										<button type="button" id="clearButtn" onclick="onClear(this)"	class="btn bg-light-blue waves-effect"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
										</c:if>
										<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"	class="btn bg-orange waves-effect"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
										
									</div>
									
									<!-- hidden fields -->
							<input type="hidden" name="pmuActivityId" value="${pmuActivity.pmuActivityId}">
							<input type="hidden" id="isFreeze" name="isFreeze" value="${pmuActivity.isFreeze}">
							<input type="hidden" name="userType" value="${pmuActivity.userType}" />
							<input type="hidden" id="countSpmuId" value="${countSpmu}">
							<input type="hidden" id="countDpmuId" value="${countDpmu}">
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<style>
.Align-Right{
			text-align: right;
}</style>