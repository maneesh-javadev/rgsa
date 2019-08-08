<%@include file="../taglib/taglib.jsp"%>
<script>
var domain_list = '${LIST_OF_PMU_DOMAINS}';
$('document').ready(function(){
	/* calTotalFundMOPR();
	calTotalFundState(); */
	calculateTotalFundSpmu();
	calculateTotalFundDpmu();
	onLoadChangeColor();
		
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

/* function calTotalFundMOPR(){
	var total=0;
	for(var i=0;i < $('#myTableId tr').length -1;i++){
		if($('#fundMOPR_'+i).text() == undefined){
			total += 0;
		}else{
			total += +$('#fundMOPR_'+i).text();
		}
	}
	$('#totalFundIdMOPR').text(total);
} */

/* function calTotalFundState(){
	var total=0;
	for(var i=0;i < $('#myTableId tr').length -1;i++){
		if($('#fundState_'+i).text() == undefined){
			total += 0;
		}else{
			total += +$('#fundState_'+i).text();
		}
	}
	$('#totalFundIdState').text(total);
} */

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

function totalfunds(){
	
	if($("#total_fund_spmu").val() == "" && $("#total_fund_dpmu").val() != ""){
		$("#grandtotal").val( +$("#total_fund_spmu").val() + + $("#total_fund_dpmu").val());
	}else if($("#total_fund_dpmu").val() == "" && $("#total_fund_spmu").val() != ""){
		$("#grandtotal").val( +$("#total_fund_spmu").val() + + $("#total_fund_dpmu").val());
	}else if($("#total_fund_dpmu").val() == "" && $("#total_fund_spmu").val() == ""){
		$("#grandtotal").val('');
	}else{
		$("#grandtotal").val( +$("#total_fund_spmu").val() + + $("#total_fund_dpmu").val());
	}
    
}
function toFreeze(){
	 $("input").prop('disabled', false);
	document.pmuController.method = "post";
	document.pmuController.action = "pmuFreezUnfreez.html?<csrf:token uri='pmuFreezUnfreez.html'/>";
	document.pmuController.submit();
}

function onLoadChangeColor(){
	var rowCount = $('#tbody tr').length - 1; /* minus 1 is done because length is counting total fund  and we dont need it*/
	var rowModal1 =  $('#tbodySprcId tr').length;
	var rowModal2 = $('#modal2Tbody tr').length;
 	for(var i=0;i<rowCount;i++){
		+$("#noOfUnitsState_"+i).text() > +$("#noOfUnits_"+i).val() ? $("#noOfUnitsState_"+i).css('color','red') : $("#noOfUnitsState_"+i).css('color','#00cc00');
		+$("#unitCostState_"+i).text() > +$("#unitCost_"+i).val() ? $("#unitCostState_"+i).css('color','red') : $("#unitCostState_"+i).css('color','#00cc00');
		+$("#fundState_"+i).text() > +$("#fund_"+i).val() ? $("#fundState_"+i).css('color','red') : $("#fundState_"+i).css('color','#00cc00');
		+$("#noOfMonthsState_"+i).text() > +$("#noOfMonths_"+i).val() ? $("#noOfMonthsState_"+i).css('color','red') : $("#noOfMonthsState_"+i).css('color','#00cc00');
	}
	+$("#total_fund_spmu_state").text() > +$("#total_fund_spmu").val() ? $("#total_fund_spmu_state").css('color','red') : $("#total_fund_spmu_state").css('color','#00cc00');
	+$("#total_fund_dpmu_state").text() > +$("#total_fund_dpmu").val() ? $("#total_fund_dpmu_state").css('color','red') : $("#total_fund_dpmu_state").css('color','#00cc00');
	+$("#totalFundIdState").text() > +$("#grandtotal").val() ? $("#totalFundIdState").css('color','red') : $("#totalFundIdState").css('color','#00cc00');
	
	for(var j=0;j < rowModal1 ;j++){
		+$("#noOfFacultyState_"+j).text() > +$("#noOfFaculty_"+j).val() ? $("#noOfFacultyState_"+j).css('color','red') : $("#noOfFacultyState_"+j).css('color','#00cc00');
	}
	for(var j=0 ; j < rowModal2; j++){
		+$("#noOfFacultyDpmuState_"+j).text() > +$("#noOfFacultyDpmu_"+j).val() ? $("#noOfFacultyDpmuState_"+j).css('color','red') : $("#noOfFacultyDpmuState_"+j).css('color','#00cc00');
	}
}

function calculateValueAcDomain(index){
	var rowCountSprc=$('#tbodySprcId tr').length;
	var rowCountDprc=$('#modal2Tbody tr').length * domain_list.split(',').length / 2;
	var noOfDomainSprc=0;
	var noOfDomainDprc=0;
	for(var i=0;i<rowCountSprc;i++){
		noOfDomainSprc += Number($('#noOfFaculty_'+i).val()) ;
	}
	for(var i=0;i<rowCountDprc;i++){
		noOfDomainDprc += Number($('#noOfFacultyDpmu_'+(i)).val());
	}
	
	/* if($('#noOfUnits_0').val() < noOfDomainSprc){
		alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_0').val());
		$('#noOfFaculty_'+obj).val('');
		
	}
	 if($('#noOfUnits_3').val() < noOfDomainDprc){
		alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_3').val());
		$('#noOfFacultyDpmu_'+obj).val('');
		
	} */
	
	 
	 if(!isNaN(index)){
			if($('#noOfUnits_0').val() < noOfDomainSprc){
				alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_0').val());
				$('#noOfFaculty_'+index).val('');
			}else if($('#noOfUnits_3').val() < noOfDomainDprc){
				alert('Total domains experts should be equal to or less than '+ $('#noOfUnits_3').val());
				$('#noOfFacultyDpmu_'+index).val('');
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
			$('#noOfFacultyDpmu_'+i).val('');
		}
	}
}

function validationOnSubmit(){
	var rowCountSprc=$('#tbodySprcId tr').length;
	var rowCountDprc=$('#tbodyDprcId tr').length * domain_list.split(',').length / 2;
	var flag= true;
	
	if(($('#total_fund_spmu').val() == 0 || $('#total_fund_spmu').val() == null) && ($('#total_fund_dpmu').val() == 0 || $('#total_fund_dpmu').val() == null)){
		alert('Blank form cannot be save or freeze.');
		flag=false;
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
				break;
			}
			}
		}
	
	  if($('#noOfUnits_3').val() == "" || $('#noOfUnits_3').val() == null){
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

function calculateTotalFundSpmu() {
	var count = $("#countSpmuId").val();
	var total_spmu_fund = 0;
	for (var i = 0; i < count; i++) {
		if($("#fund_" + i).val() != null && $("#fund_" + i).val() != ""){
			total_spmu_fund += +$("#fund_" + i).val();
		}
	}
	$("#total_fund_spmu").val(+total_spmu_fund); 
	totalfunds();
};

function calculateTotalFundDpmu() {
	var count = $("#countDpmuId").val();
	var total_dpmu_fund = 0;
	for (var i = 0; i < count; i++) {
		if($("#fund_"+(i + +$("#countSpmuId").val())).val() != null && $("#fund_"+(i + +$("#countSpmuId").val())).val() != ""){
			total_dpmu_fund += +$("#fund_"+(i + +$("#countSpmuId").val())).val();
		}
	}
	$("#total_fund_dpmu").val(total_dpmu_fund); 
	totalfunds();
};
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2><spring:message code="Label.PMUheader" htmlEscape="true" /> CEC</h2>
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
								<form:form method="post" name="pmuController"
									action="addUpdatePmu.html" modelAttribute="PMU_ACTIVITY">
									<input type="hidden" name="<csrf:token-name/>"
										value="<csrf:token-value uri="addPmuActivity.html" />" />
											<div class="table-responsive">
									<table class="table table-bordered" id="supportStaff">
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
														<spring:message code="Label.NoOfUnits" htmlEscape="true" />
														<br>(A)
													</div></th>
												<th><div align="center">
														<spring:message code="Label.UnitCost" htmlEscape="true" />
														<br>(B)
													</div></th>
												<th><div align="center">
														<spring:message code="Label.NoOfMonths" htmlEscape="true" />
														<br>(C)
													</div></th>
												<th><div align="center">
														<spring:message code="Label.Funds" htmlEscape="true" />
														<br>D= (A*B*C)
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
											<c:set var="countSpmu" value="0" scope="page" />
											<c:set var="countDpmu" value="0" scope="page" />
											<!-- SPMU LOOP STARTS -->
												<c:forEach items="${LIST_OF_ACTIVITY_PMU_TYPE}" var="ACTIVITY" varStatus="srl" begin="0" end="2">
													<input type="hidden" name="pmuActivityDetails[${srl.index}].pmuActivityTypeId" value="${ACTIVITY.pmuActivityTypeId}">
													<input type="hidden" name="pmuActivityDetails[${srl.index}].pmuDetailsId" value="${pmuActivity.pmuActivityDetails[srl.index].pmuDetailsId}">
													<input	type="hidden" name="pmuActivityDetails[${srl.index}].pmuActivityType.pmuActivityTypeId"	value="${ACTIVITY.pmuActivityTypeId}" />
													<tr>
														<td><div align="center">
																<strong>${ACTIVITY.pmuType.pmuTypeName}</strong>
															</div></td>
														<td><div align="center">
																<strong>${ACTIVITY.pmuActivityName}</strong>
															</div></td>
														<td>
														<div align="center" id="noOfUnitsState_${srl.index}">${pmuActivityState.pmuActivityDetails[srl.index].noOfUnits}</div>
														<input
															value="${pmuActivity.pmuActivityDetails[srl.index].noOfUnits}"
															name="pmuActivityDetails[${srl.index}].noOfUnits" min="1"
															maxlength="3" onkeypress="return isNumber(event)"
															oninput="validity.valid||(value='');" type="text"
															class="active12 form-control" id="noOfUnits_${srl.index}"
															onkeyup="onLoadChangeColor();calculate(${srl.index})"
															style="text-align: right;" required="required"/></td>
														<td>
														<div align="center" id="unitCostState_${srl.index}">${pmuActivityState.pmuActivityDetails[srl.index].unitCost}</div>
														<input
															value="${pmuActivity.pmuActivityDetails[srl.index].unitCost}"
															name="pmuActivityDetails[${srl.index}].unitCost" min="1"
															maxlength="7" onkeypress="return isNumber(event)"
															oninput="validity.valid||(value='');" type="text"
															class="active12 form-control" id="unitCost_${srl.index}"
															onkeyup="calculate(${srl.index});onLoadChangeColor()"
															style="text-align: right;" required="required"/></td>
														<td>
														<div align="center" id="noOfMonthsState_${srl.index}">${pmuActivityState.pmuActivityDetails[srl.index].noOfMonths}</div>
														<input
															value="${pmuActivity.pmuActivityDetails[srl.index].noOfMonths}"
															name="pmuActivityDetails[${srl.index}].noOfMonths"  type="text" min="1"
															class="active12 form-control" onkeyup="calculate(${srl.index});onLoadChangeColor()"
															oninput="validity.valid||(value='');" onkeypress="return isNumber(event)"
															id="noOfMonths_${srl.index}" style="text-align: right;" required="required"/></td>
														<c:set var="totalFundToCalc"
															value="${pmuActivity.pmuActivityDetails[srl.index].fund}"></c:set>
														<td>
														<div align="center" id="fundState_${srl.index}">${pmuActivityState.pmuActivityDetails[srl.index].fund}</div>
														<input
															value="${pmuActivity.pmuActivityDetails[srl.index].fund}"
															readonly="readonly"
															name="pmuActivityDetails[${srl.index}].fund"
															onkeypress="return isNumber(event)"
															onchange="onLoadChangeColor()"
															oninput="validity.valid||(value='');" type="text" min="1"
															class="active12 form-control txtCal" id="fund_${srl.index}"
															style="text-align: right;" /></td>
														<c:choose>
															<c:when test="${srl.index eq 0 }">
																<td><button type="button" style="margin-top: 18px;"
																		class="btn btn-primary btn-lg" data-toggle="modal"
																		data-target="#myModal">Fill <spring:message code="Label.DomainDetails" htmlEscape="true" /></button></td>
															</c:when>
															<c:when test="${srl.index eq 3}">
																<td><button type="button" style="margin-top: 18px;"
																		class="btn btn-primary btn-lg" data-toggle="modal"
																		data-target="#myModal2">Fill <spring:message code="Label.DomainDetails" htmlEscape="true" /></button></td>
															</c:when>
															<c:otherwise>
																<td></td>
															</c:otherwise>
														</c:choose>
														<td><textarea
																name="pmuActivityDetails[${srl.index}].remarks" rows="3"
																class="form-control" cols="5"><c:out
																	value="${pmuActivity.pmuActivityDetails[srl.index].remarks}"></c:out></textarea></td>
													</tr>
													<c:set var="countSpmu" value="${countSpmu + 1}" scope="page" />
												</c:forEach>
												<tr>
													<th colspan="5"><label>Total SPMU Fund</label></th>
													<td>
													<div align="center" id="total_fund_spmu_state">${SPMU_TOTAL_STATE }</div>
													<input type="text" style="background: #dddddd;"
														class="form-control Align-Right" id="total_fund_spmu"
														value="" disabled="disabled" onchange="onLoadChangeColor()"></td>
													<td></td>
													<td></td>
												</tr>
												<!-- SPMU LOOP ENDS HERE -->
												
												<!-- DPMU LOOP STARTS -->
												<c:forEach items="${LIST_OF_ACTIVITY_PMU_TYPE}" var="ACTIVITY" varStatus="srl" begin="3" end="5">
													<input type="hidden" name="pmuActivityDetails[${srl.index}].pmuActivityTypeId" value="${ACTIVITY.pmuActivityTypeId}">
													<input type="hidden" name="pmuActivityDetails[${srl.index}].pmuDetailsId" value="${pmuActivity.pmuActivityDetails[srl.index].pmuDetailsId}">
													<input	type="hidden" name="pmuActivityDetails[${srl.index}].pmuActivityType.pmuActivityTypeId"	value="${ACTIVITY.pmuActivityTypeId}" />
													<tr>
														<td><div align="center">
																<strong>${ACTIVITY.pmuType.pmuTypeName}</strong>
															</div></td>
														<td><div align="center">
																<strong>${ACTIVITY.pmuActivityName}</strong>
															</div></td>
														<td>
														<div align="center" id="noOfUnitsState_${srl.index}">${pmuActivityState.pmuActivityDetails[srl.index].noOfUnits}</div>
														<input
															value="${pmuActivity.pmuActivityDetails[srl.index].noOfUnits}"
															name="pmuActivityDetails[${srl.index}].noOfUnits" min="1"
															maxlength="3" onkeypress="return isNumber(event)"
															oninput="validity.valid||(value='');" type="text"
															class="active12 form-control" id="noOfUnits_${srl.index}"
															onkeyup="onLoadChangeColor();calculate(${srl.index})"
															onchange="calculateValueAcDomain('noOfUnits_${srl.index}')"
															style="text-align: right;" required="required"/></td>
														<td>
														<div align="center" id="unitCostState_${srl.index}">${pmuActivityState.pmuActivityDetails[srl.index].unitCost}</div>
														<input
															value="${pmuActivity.pmuActivityDetails[srl.index].unitCost}"
															name="pmuActivityDetails[${srl.index}].unitCost" min="1"
															maxlength="7" onkeypress="return isNumber(event)"
															oninput="validity.valid||(value='');" type="text"
															class="active12 form-control" id="unitCost_${srl.index}"
															onkeyup="calculate(${srl.index});onLoadChangeColor()"
															style="text-align: right;" required="required"/></td>
														<td>
														<div align="center" id="noOfMonthsState_${srl.index}">${pmuActivityState.pmuActivityDetails[srl.index].noOfMonths}</div>
														<input
															value="${pmuActivity.pmuActivityDetails[srl.index].noOfMonths}"
															name="pmuActivityDetails[${srl.index}].noOfMonths"  type="text" min="1"
															class="active12 form-control" onkeyup="calculate(${srl.index});onLoadChangeColor()"
															oninput="validity.valid||(value='');" onkeypress="return isNumber(event)"
															id="noOfMonths_${srl.index}" style="text-align: right;" required="required"/></td>
														<c:set var="totalFundToCalc"
															value="${pmuActivity.pmuActivityDetails[srl.index].fund}"></c:set>
														<td>
														<div align="center" id="fundState_${srl.index}">${pmuActivityState.pmuActivityDetails[srl.index].fund}</div>
														<input
															value="${pmuActivity.pmuActivityDetails[srl.index].fund}"
															readonly="readonly"
															name="pmuActivityDetails[${srl.index}].fund"
															onkeypress="return isNumber(event)"
															onchange="onLoadChangeColor()"
															oninput="validity.valid||(value='');" type="text" min="1"
															class="active12 form-control txtCal" id="fund_${srl.index}"
															style="text-align: right;" /></td>
														<c:choose>
															<c:when test="${srl.index eq 0 }">
																<td><button type="button" style="margin-top: 18px;"
																		class="btn btn-primary btn-lg" data-toggle="modal"
																		data-target="#myModal">Fill <spring:message code="Label.DomainDetails" htmlEscape="true" /></button></td>
															</c:when>
															<c:when test="${srl.index eq 3}">
																<td><button type="button" style="margin-top: 18px;"
																		class="btn btn-primary btn-lg" data-toggle="modal"
																		data-target="#myModal2">Fill <spring:message code="Label.DomainDetails" htmlEscape="true" /></button></td>
															</c:when>
															<c:otherwise>
																<td></td>
															</c:otherwise>
														</c:choose>
														<td><textarea
																name="pmuActivityDetails[${srl.index}].remarks" rows="3"
																class="form-control" cols="5"><c:out
																	value="${pmuActivity.pmuActivityDetails[srl.index].remarks}"></c:out></textarea></td>
													</tr>
													<c:set var="countDpmu" value="${countDpmu + 1}" scope="page" />
												</c:forEach>
												<tr>
													<th colspan="5"><label>Total DPMU Fund</label></th>
													<td>
													<div align="center" id="total_fund_dpmu_state">${DPMU_TOTAL_STATE }</div>
													<input type="text" style="background: #dddddd;"
														class="form-control Align-Right" id="total_fund_dpmu"
														value="" disabled="disabled" onchange="onLoadChangeColor()"></td>
													<td></td>
													<td></td>
												</tr>
												<!-- DPMU LOOP ENDS HERE -->
												<tr>
													<th colspan="5"><label><spring:message
																code="Label.TotalAmountProposed" htmlEscape="true" /></label></th>
													<td>
													<div align="center" id="totalFundIdState">${SPMU_TOTAL_STATE + DPMU_TOTAL_STATE }</div>
													<input type="text" style="background: #dddddd;"
														class="form-control Align-Right" id="grandtotal"
														value="${totalFundToCalc}" disabled="disabled" onchange="onLoadChangeColor()"></td>
													<td></td>
													<td></td>
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
																<label for="sprc" class="col-sm-3"><spring:message
																		code="Label.InstituteType" htmlEscape="true" /></label>
																<div class="col-sm-5">
																	<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS"
																		begin="1" end="1">
																		<c:if test="${DOMAINS.pmuType.pmuTypeId eq 1}">
																			<p class="text-justify">
																				<strong>${DOMAINS.pmuType.pmuTypeName}</strong>
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
																			<c:forEach items="${LIST_OF_PMU_DOMAINS}"
																				var="DOMAINS">
																				<c:if test="${DOMAINS.pmuType.pmuTypeId eq 1 }">
																					<input type="hidden"
																						name="pmuWiseProposedDomainExperts[${temp}].pmuWiseProposedDomainExpertsId"
																						value="${pmuWiseDomainList[temp].pmuWiseProposedDomainExpertsId}" />
																					<tr>
																						<th><div align="center">${DOMAINS.pmuDomainName}</div>
																							<input type="hidden"
																							name="pmuWiseProposedDomainExperts[${temp}].domainId"
																							value="${DOMAINS.pmuDomainId}"></th>
																						<td>
																						<div align="center" id="noOfFacultyState_${temp}">${pmuWiseDomainListState[temp].noOfExperts}</div>
																						<input
																							name="pmuWiseProposedDomainExperts[${temp}].noOfExperts"
																							value="${pmuWiseDomainList[temp].noOfExperts}"
																							onkeyup="onLoadChangeColor();calculateValueAcDomain(${temp})"
																							type="text"
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
															data-dismiss="modal">
															<spring:message code="Label.CLOSE" htmlEscape="true" />
														</button>
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
																<label for="sprc" class="col-sm-3"><spring:message
																		code="Label.InstituteType" htmlEscape="true" /></label>
																<div class="col-sm-5">
																	<!-- <select> -->
																	<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS"
																		begin="1" end="3">
																		<c:if test="${DOMAINS.pmuType.pmuTypeId eq 2}">
																			<p class="text-justify">
																				<strong>${DOMAINS.pmuType.pmuTypeName}</strong>
																			</p>
																		</c:if>
																	</c:forEach>
																</div>
															</div>
														</div>
														<%-- <div class="row">
															<div class="form-group">
																<label for="Dprc" class="col-sm-3"><spring:message
																		code="Label.District" htmlEscape="true" /></label>
																<div class="col-sm-5">
																<div  id="districtTextState"><strong>${DISTRICT_DETAILS_STATE.districtNameEnglish}</strong></div>
																<input type="hidden" id="districtCodeStateId" name="setDistrictIdPmuWise" value="${DISTRICT_DETAILS_STATE.districtCode}">
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
																				<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS">
																					<c:if test="${DOMAINS.pmuType.pmuTypeId eq 2}">
																						<th><div align="center">${DOMAINS.pmuDomainName}</div></th>
																					</c:if>
																				</c:forEach>
																			</tr>
																		</thead>
																		<tbody id="modal2Tbody" style="display: block;overflow-x: auto;height: 500px;">
																			
																			<c:set var="dprcIndex" value="0" scope="page" />
																			<c:forEach items="${LIST_OF_DISTRICT}" var="DISTRICT" varStatus="index">
																			<tr>
																				<td style="width: 234px;"><div align="center"><strong>${DISTRICT[1]}</strong></div></td>
																				<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS">
																					<c:if test="${DOMAINS.pmuType.pmuTypeId eq 2}">
																						<td>
																						<c:choose>
																							<c:when test="${not empty pmuWiseDomainListState[dprcIndex+3].noOfExperts}">
																								<div align="center" id="noOfFacultyDpmuState_${dprcIndex}">${pmuWiseDomainListState[dprcIndex+3].noOfExperts}</div>
																								<form:input path="pmuWiseProposedDomainExperts[${dprcIndex + 3}].noOfExperts" class="active12 form-control Align-Right" id="noOfFacultyDpmu_${dprcIndex}" onkeypress="return isNumber(event)"  onkeyup="onLoadChangeColor();calculateValueAcDomain(${dprcIndex})"/>
																							</c:when>
																							<c:otherwise>
																								<div align="center" id="noOfFacultyDpmuState_${dprcIndex}">${pmuWiseDomainListState[dprcIndex+3].noOfExperts}</div>
																								<form:input path="pmuWiseProposedDomainExperts[${dprcIndex + 3}].noOfExperts" class="active12 form-control Align-Right" id="noOfFacultyDpmu_${dprcIndex}" style="margin-top: 18px;" onkeypress="return isNumber(event)"  onkeyup="onLoadChangeColor();calculateValueAcDomain(${dprcIndex})"/>
																							</c:otherwise>
																						</c:choose>
																						</td>
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
																			
																			<%-- <c:set var="temp" value="0" scope="page" />
																			<c:forEach items="${LIST_OF_PMU_DOMAINS}"
																				var="DOMAINS">
																				<c:if test="${DOMAINS.pmuType.pmuTypeId eq 2}">
																					<input type="hidden"
																						name="pmuWiseProposedDomainExperts[${temp}].pmuWiseProposedDomainExpertsId"
																						value="${pmuWiseDomainList[temp].pmuWiseProposedDomainExpertsId}" />
																					<tr>
																						<th><div align="center">${DOMAINS.pmuDomainName}</div>
																							<input type="hidden"
																							name="pmuWiseProposedDomainExperts[${temp}].domainId"
																							value="${DOMAINS.pmuDomainId}"></th>
																						<td>
																						<div align="center" id="noOfFacultyDpmuState_${temp}">${pmuWiseDomainListState[temp].noOfExperts}</div>
																						<input
																							name="pmuWiseProposedDomainExperts[${temp}].noOfExperts"
																							value="${pmuWiseDomainList[temp].noOfExperts}"
																							type="text"
																							onkeyup="onLoadChangeColor();calculateValueAcDomain(${temp})"
																							id="noOfFacultyDpmu_${temp}"
																							class="active12 form-control Align-Right" /></td>
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
															data-dismiss="modal">
															<spring:message code="Label.CLOSE" htmlEscape="true" />
														</button>
													</div>
												</div>
											</div>
										</div>
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
										<button type="submit" id="saveButtn" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
										<c:choose>
										<c:when test="${initial_status}">
										<button type="button" class="freeze btn bg-green waves-effect"	id="frzButtn" onclick="toFreeze();" disabled="disabled"><spring:message code="Label.FREEZE" htmlEscape="true" /></button>
										</c:when>
										<c:otherwise>
										<button type="button" class="freeze btn bg-green waves-effect"	id="frzButtn" onclick="toFreeze();"><spring:message code="Label.FREEZE" htmlEscape="true" /></button>
										</c:otherwise>
										</c:choose>
										<button type="button" class="unfreeze btn bg-green waves-effect" id="unFrzButtn" onclick="toFreeze();"><spring:message code="Label.UNFREEZE" htmlEscape="true" /></button>
										<button type="button" id="clearButtn" onclick="onClear(this)"	class="btn bg-light-blue waves-effect"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
										<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"	class="btn bg-orange waves-effect"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
										
									</div>
									</div>
									
									<!-- HIDDEN FIELDS STARTS -->
									<input type="hidden" name="pmuActivityId" value="${pmuActivity.pmuActivityId}">
									<input type="hidden" id="isFreeze" name="isFreeze" value="${pmuActivity.isFreeze}">
									<input type="hidden" name="userType" value="${pmuActivity.userType}" />
									<input type="hidden" id="countSpmuId" value="${countSpmu}">
									<input type="hidden" id="countDpmuId" value="${countDpmu}">
									
								</form:form>
							</div>
						<!-- MOPR TAB STARTS -->		
							<div class="container tab-pane fade" id="MOPR"
								style="width: auto;">
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
														<spring:message code="Label.NoOfUnits" htmlEscape="true" />
														<br>(A)
													</div></th>
												<th><div align="center">
														<spring:message code="Label.UnitCost" htmlEscape="true" />
														<br>(B)
													</div></th>
												<th><div align="center">
														<spring:message code="Label.NoOfMonths" htmlEscape="true" />
														<br>(C)
													</div></th>
												<th><div align="center">
														<spring:message code="Label.Funds" htmlEscape="true" />
														<br>D= (A*B*C)
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
										<tbody id="myTableId">
										<!-- SPMU LOOP STARTS -->
											<c:forEach items="${LIST_OF_ACTIVITY_PMU_TYPE}" var="ACTIVITY" varStatus="srl" begin="0" end="2">
											<tr>
												<td><div align="center"><strong>${ACTIVITY.pmuType.pmuTypeName}</strong></div></td>
												<td><div align="center"><strong>${ACTIVITY.pmuActivityName}</strong></div></td>
												<td><div align="center">${pmuActivityMOPR.pmuActivityDetails[srl.index].noOfUnits}</div></td>
												<td><div align="center"> ${pmuActivityMOPR.pmuActivityDetails[srl.index].unitCost }</div></td>
												<td><div align="center">${pmuActivityMOPR.pmuActivityDetails[srl.index].noOfMonths}</div></td>
												<td><div align="center" id="fundMOPR_${srl.index}">${pmuActivityMOPR.pmuActivityDetails[srl.index].fund}</div></td>
													<c:choose>
														<c:when test="${srl.index eq 0 }">
															<td><button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal3">See <spring:message code="Label.DomainDetails" htmlEscape="true" /></button></td>
														</c:when>
														<c:when test="${srl.index eq 3}">
															<td><button type="button"	class="btn btn-primary btn-lg" data-toggle="modal"	data-target="#myModal4">See <spring:message code="Label.DomainDetails" htmlEscape="true" /></button></button></td>
														</c:when>
														<c:otherwise>
															<td></td>
														</c:otherwise>
													</c:choose>
	                                             <td><c:choose>
	                                             			<c:when test="${pmuActivityMOPR.pmuActivityDetails[srl.index].isApproved}">	
														  		 <i class="fa fa-check" aria-hidden="true" style="color: #00cc00 "></i>
														   </c:when>
														   <c:otherwise>
														   		<i class="fa fa-times" aria-hidden="true" style="color: red "></i>
														   </c:otherwise>
													</c:choose>
												</td>
										   		<td><div align="center">${pmuActivityMOPR.pmuActivityDetails[srl.index].remarks}</div></td>
												</tr>
											</c:forEach>
											<tr>
											<th colspan="5"><label>Total SPMU Fund</label></th>
													<td><div align="center">${SPMU_TOTAL_MOPR}</div></td>
														<td colspan="4"></td>
												</tr>
											<!-- SPMU LOOP ENDS -->
											<!-- DPMU LOOP STARTS -->
											<c:forEach items="${LIST_OF_ACTIVITY_PMU_TYPE}" var="ACTIVITY" varStatus="srl" begin="3" end="5">
											<tr>
												<td><div align="center"><strong>${ACTIVITY.pmuType.pmuTypeName}</strong></div></td>
												<td><div align="center"><strong>${ACTIVITY.pmuActivityName}</strong></div></td>
												<td><div align="center">${pmuActivityMOPR.pmuActivityDetails[srl.index].noOfUnits}</div></td>
												<td><div align="center"> ${pmuActivityMOPR.pmuActivityDetails[srl.index].unitCost }</div></td>
												<td><div align="center">${pmuActivityMOPR.pmuActivityDetails[srl.index].noOfMonths}</div></td>
												<td><div align="center" id="fundMOPR_${srl.index}">${pmuActivityMOPR.pmuActivityDetails[srl.index].fund}</div></td>
													<c:choose>
														<c:when test="${srl.index eq 0 }">
															<td><button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal3">See <spring:message code="Label.DomainDetails" htmlEscape="true" /></button></td>
														</c:when>
														<c:when test="${srl.index eq 3}">
															<td><button type="button"	class="btn btn-primary btn-lg" data-toggle="modal"	data-target="#myModal4">See <spring:message code="Label.DomainDetails" htmlEscape="true" /></button></button></td>
														</c:when>
														<c:otherwise>
															<td></td>
														</c:otherwise>
													</c:choose>
	                                             <td><c:choose>
	                                             			<c:when test="${pmuActivityMOPR.pmuActivityDetails[srl.index].isApproved}">	
														  		 <i class="fa fa-check" aria-hidden="true" style="color: #00cc00 "></i>
														   </c:when>
														   <c:otherwise>
														   		<i class="fa fa-times" aria-hidden="true" style="color: red "></i>
														   </c:otherwise>
													</c:choose>
												</td>
										   		<td><div align="center">${pmuActivityMOPR.pmuActivityDetails[srl.index].remarks}</div><%-- <textarea name="pmuActivityDetails[${count}].remarks" rows="3" class="form-control" cols="5"><c:out value="${pmuActivity.pmuActivityDetails[count].remarks}"></c:out></textarea> --%></td>
												</tr>
											</c:forEach>
											<tr>
											<th colspan="5"><label>Total DPMU Fund</label></th>
													<td><div align="center">${DPMU_TOTAL_MOPR}</div></td>
														<td colspan="4"></td>
												</tr>
												<!-- DPMU LOOP ENDS -->
											<tr>
											<th colspan="5"><label><spring:message code="Label.TotalAmountProposed" htmlEscape="true" /></label></th>
													<td><div align="center" id="totalFundIdMOPR">${DPMU_TOTAL_MOPR + SPMU_TOTAL_MOPR}</div></td>
														<td colspan="4"></td>
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
																		<thead>
																			<tr>
																				<th><div align="center"><spring:message code="Label.Domain" htmlEscape="true" /></div></th>
																				<th><div align="center"><spring:message code="Label.NoOfExperts" htmlEscape="true" /></div></th>
																			</tr>
																		</thead>
																		<tbody>
																			<c:set var="temp" value="0" scope="page" />
																			<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS">
																				<c:if	test="${DOMAINS.pmuType.pmuTypeId eq 1 }">
																					<tr>
																						<th><div align="center">${DOMAINS.pmuDomainName}</div>
																						<td><div align="center">${pmuWiseDomainListMOPR[temp].noOfExperts}</div></td>
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
															data-dismiss="modal"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
													</div>
												</div>
		
											</div>
										</div>
										
										<div id="myModal4" class="modal fade" role="dialog">
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
														<%-- <div class="row">
															<div class="form-group">
																<label for="Dprc" class="col-sm-3"><spring:message code="Label.District" htmlEscape="true" /></label>
																<div class="col-sm-5">
																<div align="center"><strong>${DISTRICT_DETAILS_MOPR.districtNameEnglish}</strong></div>
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
																				<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS">
																					<c:if test="${DOMAINS.pmuType.pmuTypeId eq 2}">
																						<th><div align="center">${DOMAINS.pmuDomainName}</div></th>
																					</c:if>
																				</c:forEach>
																			</tr>
																		</thead>
																		<tbody style="display: block;overflow-x: auto;height: 500px;">
																		<c:set var="dprcIndex" value="0" scope="page" />
																		<c:forEach items="${LIST_OF_DISTRICT}" var="DISTRICT"
																			varStatus="index">
																			<tr>
																				<td style="width: 234px;"><div align="center">
																						<strong>${DISTRICT[1]}</strong>
																					</div></td>
																				<c:forEach items="${LIST_OF_PMU_DOMAINS}"
																					var="DOMAINS">
																					<c:if test="${DOMAINS.pmuType.pmuTypeId eq 2}">
																						<c:choose>
																								<c:when test="${DOMAINS.pmuDomainId eq 4}"><td style="width: 207px;"><div align="center">${pmuWiseDomainListMOPR[dprcIndex+3].noOfExperts}</div></td></c:when>
																								<c:when test="${DOMAINS.pmuDomainId eq 5}"><td style="width: 159px;"><div align="center">${pmuWiseDomainListMOPR[dprcIndex+3].noOfExperts}</div></td></c:when>
																								<c:when test="${DOMAINS.pmuDomainId eq 6}"><td style="width: 210px;"><div align="center">${pmuWiseDomainListMOPR[dprcIndex+3].noOfExperts}</div></td></c:when>
																							</c:choose>
																						<c:set var="dprcIndex" value="${dprcIndex + 1}"
																							scope="page"></c:set>
																					</c:if>
																				</c:forEach>
																			</tr>
																		</c:forEach>

																		<%-- <c:set var="temp" value="0" scope="page" />
																			<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS">
																				<c:if test="${DOMAINS.pmuType.pmuTypeId eq 2}">
																					<tr>
																						<th><div align="center">${DOMAINS.pmuDomainName}</div>
																						<td><div align="center">${pmuWiseDomainListMOPR[temp].noOfExperts}</div></td>
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
														<button type="button" class="btn btn-danger" data-dismiss="modal"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
													</div>
												</div>
											</div>
										</div>
											<div class="col-md-4">
										<button type="button"
											onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
											class="btn bg-orange waves-effect">
											<i class="fa fa-arrow-left" aria-hidden="true"></i>
											<spring:message code="Label.BACK" htmlEscape="true" />
										</button>
									</div>
										<div class="text-right"><button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"	class="btn bg-orange waves-effect"><spring:message code="Label.CLOSE" htmlEscape="true" /></button></div>
								</div>
							</div>
						</div>
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
											