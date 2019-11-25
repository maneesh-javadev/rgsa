<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	 $("#unFrzButtn").hide();
	 
	 $("#mytable,#activityNameId").keyup(function(){
		    var x=$(this).val();
		    var z=0;
			   $("#mytable,#activityNameId").each(function () {
		        var y=$(this).val();
		        if(($.trim(x)==$.trim(y)) && y!=''){
		        	z=z+1;
		        }
		    });
		    if(z>1){
		    	alert("Duplicate value of name of the activity")
		    	$(this).val('');
		    	return false;
		    }
		 });
	 
	 if($('#fundsName').val() > 50000){
		 $(this).val(0);
		 alert("Value should be less than 50000Rs.")
	 }
	 if($('#isFreeze').val() != undefined){
	 var myBoolean = document.getElementById("isFreeze").value;
	if(myBoolean == "true"){
		 $("input").prop('disabled', true);
		 $("select").prop('disabled', true);
		 $("#saveButtn").hide();
		 $("#frzButtn").hide();
		 $("#addNewRowBtn").hide();
		 $("#unFrzButtn").show();
		 $("#clearButtn").prop('disabled', true);
	 }
	
	if(myBoolean == "false" || myBoolean == "false"){
		 $("input").prop('disabled', false);
		 $("select").prop('disabled', false);
		 $("#saveButtn").prop('disabled', false);
		 $("#frzButtn").show();
		 $("#unFrzButtn").hide();
		 $("#clearButtn").prop('disabled', false);
	 } 
	}
	
	$("#mytable").on('input',$("#fundsName"), function () {
		var calculated_total_sum = 0;
		var rowCount = $('#tbodyId tr').length;
		for(var i=0;i<rowCount;i++){
			if(typeof +$('#fundsName_'+i).val() == 'number'){
				calculated_total_sum += +$('#fundsName_'+i).val();
			}
			
		}
		
		$("#subTotal").val(calculated_total_sum);
		document.getElementById("grandTotal").value = parseFloat(document.getElementById("additioinalRequirements").value) + parseFloat(calculated_total_sum);
		});
	
	$("#additioinalRequirements").on('input',$("#additioinalRequirements"), function () {
		var subTotal = $("#subTotal").val();
		 var check = (25*subTotal)/100;
		 if($("#additioinalRequirements").val() > check){
			 alert("Additional Requirement Should Be Less Than 25% of SubTotal i.e." +" less than "+ check);
			 $("#additioinalRequirements").val("");
			 $("#grandTotal").val(subTotal);
		 }
		 else{
			 $("#grandTotal").val(parseFloat($("#additioinalRequirements").val()) + parseFloat((subTotal)));
		 }
	 });
	
	 
}); 

$('document').ready(function(){
	$(".reset").bind("click", function() {
	  $("input[type=text]").val('');
	});
	 changeColor();
	/* calculateGrandTotal(); */
});
		
function showImage(path,name){
	 $("input").prop('disabled', false);
	document.getElementById("path").value = path;
	document.getElementById("dbFileName").value = name;
	document.incomeEnhancement.method = "post";
	document.incomeEnhancement.action = "viewFileOfIncmEnhncmntActivity.html?<csrf:token uri='viewFileOfIncmEnhncmntActivity.html'/>";
	document.incomeEnhancement.submit();
	var myBoolean = document.getElementById("isFreeze").value;
	 if(myBoolean == "true"){
		 $("input").prop('disabled', true);
	 }
	 if($('#userTypeId').val() =='M'){
		 $("input:not(.exclud)").prop("disabled", true);
		 $("select").prop('disabled', true);
	 }
}
	
	/* $(".dId").change(function(){ */
		function callBlockList(index){
	    var districtId = $("#districtId"+ index).val();
	    $('#setBlockId').val(districtId);
	    $.ajax({
	        type: 'GET',
	        url: "getBlockBasedOnDistrictCode.html?<csrf:token uri='getBlockBasedOnDistrictCode.html'/>",
	        data: {"setBlockId" : districtId},
	        success: function(data){
	            var slctSubcat=$("#blockId"+index), option="";
	            slctSubcat.empty();

	            for(var i=0; i<data.length; i++){
	                option = option + "<option value='"+data[i].blockCode + "'>"+data[i].blockNameEnglish + "</option>";
	            }
	            slctSubcat.append(option);
	        },
	        error:function(){
	            alert("Something Went Wrong");
	        }
	    });
	}

function  calculateAspirationalGPs(index){
		if(parseInt($("#aspirationalGpId_"+index).val()) > parseInt($("#noOfGpCoveredId_"+index).val())) {
			alert("Aspirational GPs should not be greater than No. of GPs covered.");
			$("#aspirationalGpId_"+index).val('');
		}
	}
	
	

		
function toFreeze(){
	 $("input").prop('disabled', false);
	document.incomeEnhancement.method = "post";
	document.incomeEnhancement.action = "frzUnfrzIncomeEnhancementActivity.html?<csrf:token uri='frzUnfrzIncomeEnhancementActivity.html'/>";
	document.incomeEnhancement.submit();
}	
function toDelete(idToDelete,path,name){
	document.getElementById("idToDelete").value = idToDelete;
	document.getElementById("path").value = path;
	document.getElementById("dbFileName").value = name;
	document.incomeEnhancement.method = "post";
	document.incomeEnhancement.action = "deleteIncomeEnhancementDtls.html?<csrf:token uri='deleteIncomeEnhancementDtls.html'/>";
	document.incomeEnhancement.submit();
}

function validateYear(index){
	
if($("#yearTwo_"+index).val() != ""){
	if($("#yearOne_"+index).val() > $("#yearTwo_"+index).val()){
		alert("Year must be equal to greater than the selected year");
		$("#yearTwo_"+index).val($("#yearOne_"+index).val());
		return false;
		}
	}
	else return true;
	}
	
function regexValidation(){
	$('.letters').bind('keyup blur',function(){ 
	    var node = $(this);
	    node.val(node.val().replace(/[^A-za-z ]/,'') ); }
	);
	$('.numbers').bind('keyup blur',function(){ 
	    var node = $(this);
	    node.val(node.val().replace(/[^0-9]/,'') ); }
	);
	$('.alphaonly').bind('keyup blur',function(){ 
	    var node = $(this);
	    node.val(node.val().replace(/[^A-za-z0-9 ]/,'') ); }
	);
	$("#mytable,#activityNameId").keyup(function(){
		 var x=$(this).val();
		    var z=0;
			   $("#mytable,#activityNameId").each(function () {
		        var y=$(this).val();
		        if(($.trim(x)==$.trim(y)) && y!=''){
		        	z=z+1;
		        }
		    });
		    if(z>1){
		    	alert("Duplicate value of name of the activity")
		    	$(this).val('');
		    	return false;
		    }
		});
}	

function saveSubmit(){
	document.incomeEnhancement.method = "post";
	document.incomeEnhancement.action = "incomeEnhancementAdd.html?<csrf:token uri='incomeEnhancementAdd.html'/>";
	document.incomeEnhancement.submit();
}

function changeColor(){
	var rowCount = $('#tbodyId tr').length;
	for(var i=0;i<rowCount;i++){
		
		+$('#noOfGpCoveredId_' + i).val() < +$('#noOfGpCoveredMoprId_' + i).text() ? $(
				'#noOfGpCoveredMoprId_' + i).css('color', 'red') : $(
				'#noOfGpCoveredMoprId_' + i).css('color', '#00cc00');
		+$('#aspirationalGpId_' + i).val() < +$('#aspirationalMoprGpId_' + i).text() ? $(
				'#aspirationalMoprGpId_' + i).css('color', 'red') : $(
				'#aspirationalMoprGpId_' + i).css('color', '#00cc00');
		+$('#projectCostId_' + i).val() < +$('#projectCostMoprId_' + i).text() ? $(
				'#projectCostMoprId_' + i).css('color', 'red') : $(
				'#projectCostMoprId_' + i).css('color', '#00cc00');
		+$('#fundsName_' + i).val() < +$('#fundsNameMoprId_' + i).text() ? $(
				'#fundsNameMoprId_' + i).css('color', 'red') : $(
				'#fundsNameMoprId_' + i).css('color', '#00cc00');
	}
	+$('#subTotal').val() < +$('#subTotalMopr').text() ? $(
			'#subTotalMopr').css('color', 'red') : $(
			'#subTotalMopr').css('color', '#00cc00');
	+$('#additioinalRequirements').val() < +$('#additioinalRequirementsMopr').text() ? $(
			'#additioinalRequirementsMopr').css('color', 'red') : $('#additioinalRequirementsMopr').css('color', '#00cc00');
	+$('#grandTotal').val() < +$('#grandTotalState').text() ? $(
	'#grandTotalState').css('color', 'red') : $('#grandTotalState').css('color', '#00cc00');
}
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Project based support for Income Development & Income Enhancement(CEC)</h2>
					</div>
					<form:form method="POST" id="incomeEnhancementId"
						name="incomeEnhancement" class="form-inline"
						action="incomeEnhancementAdd.html"
						modelAttribute="Income_Enhancement" enctype="multipart/form-data" onsubmit="disablingSave()">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="incomeEnhancementAdd.html"/>" />
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
									id="MOPR" style="width: auto;">
									<div class="table-responsive">
										<table class="table table-bordered" id="mytable">
											<thead>
												<tr>
													<th rowspan="2">S.No.</th>
													<th rowspan="2">Name of the Activity</th>
													<!-- <th rowspan="2">Select Ministry/Scheme</th> -->
													<th rowspan="2"><div align="center">Select
															Scheme</div></th>
													<th rowspan="2">District Name</th>
													<th rowspan="2">Block Name</th>
													<th rowspan="2">Total No. of GP's Covered</th>
													<th rowspan="2">No. of Aspirational GPs</th>
													<th colspan="2">Time Frame of project(year wise)</th>
													<th rowspan="2">Total cost of project</th>
													<th rowspan="2">Funds Proposed in current year</th>
													<th rowspan="2">Brief about the Activity</th>
													<th rowspan="2">Download File(PDF)</th>
													<th rowspan="2">Plan approved by DPC</th>


												</tr>
												<tr>
													<th>From</th>
													<th>To</th>
												</tr>
											</thead>
											<tbody id="tbodyId">


												<%-- <c:if test="${not empty dbActivitiesList}"> --%>
													<c:forEach
														items="${INCOMEENHANCEMENTDETAIL_MOPR}"
														var="state_data" varStatus="count">
														<tr>
															<td><strong>${count.count}</strong></td>
															<td><div>
																	${state_data.activtyName}
																</div>
																<input type="hidden" name="incomeEnhancementDetails[${count.index}].activtyName" value="${state_data.activtyName}"/>
															<td><div align="center">
																	<c:forEach items="${schemeMasterList}" var="scm">
																		<c:choose>
																			<c:when
																				test="${state_data.fundSourceCode == scm.schemeId}">
																				${scm.schemeName}
																			</c:when>
																		</c:choose>
																	</c:forEach>
																</div>
																<input type="hidden" name="incomeEnhancementDetails[${count.index}].fundSourceCode" value="${state_data.fundSourceCode}"/>
																</td>
															<td><div align="center">
																	<c:forEach items="${districtList}" var="districtData">
																		<c:choose>
																			<c:when
																				test="${state_data.districtCode == districtData.districtCode}">
																				${districtData.districtNameEnglish}
																			</c:when>
																		</c:choose>
																	</c:forEach>
																</div>
																<input type="hidden" name="incomeEnhancementDetails[${count.index}].districtCode" value="${state_data.districtCode}"/>
																</td>
															<td>
																<div align="center">
																	<c:forEach items="${BLOCK}" var="blockdata">

																		<c:choose>
																			<c:when
																				test="${blockdata.blockCode == state_data.blockCode}">
																				${blockdata.blockNameEnglish}
																			</c:when>

																		</c:choose>
																	</c:forEach>
																</div>
																<input type="hidden" name="incomeEnhancementDetails[${count.index}].blockCode" value="${state_data.blockCode}"/>
																</td>
															<c:choose>
															<c:when test="${not empty dbActivitiesList}">
																<td><div align="center" id="noOfGpCoveredMoprId_${count.index}">${state_data.totalNoOfGpCovered}</div>
																<input type="text" oninput="validity.valid||(value='');"
																placeholder="Total GP's covered"
																onKeyPress="if(this.value.length==3) return false;"
																onkeyup="this.value=this.value.replace(/[^0-9]/g,'');calculateAspirationalGPs(${count.index});changeColor()"
																min="1" required="required"
																value="${dbActivitiesList.incomeEnhancementDetails[count.index].totalNoOfGpCovered}"
																name="incomeEnhancementDetails[${count.index}].totalNoOfGpCovered"
																id="noOfGpCoveredId_${count.index}"
																class="form-control Align-Right" /></td>
															
															<td><div align="center" id="aspirationalMoprGpId_${count.index}">${state_data.noOfAspirationalGp}</div>
															<input type="text" placeholder="Total Aspirational GP"
															oninput="validity.valid||(value='');"
															onKeyPress="if(this.value.length==3) return false;"
															min="1" required="required"
															name="incomeEnhancementDetails[${count.index}].noOfAspirationalGp"
															id="aspirationalGpId_${count.index}"
															value="${dbActivitiesList.incomeEnhancementDetails[count.index].noOfAspirationalGp}"
															onkeyup="this.value=this.value.replace(/[^0-9]/g,'') ; calculateAspirationalGPs(${count.index});changeColor()"
															class="form-control Align-Right" /></td>
															</c:when>
															<c:otherwise>
																<td><div align="center" id="noOfGpCoveredMoprId_${count.index}">${state_data.totalNoOfGpCovered}</div>
																<input type="text" oninput="validity.valid||(value='');"
																placeholder="Total GP's covered"
																onKeyPress="if(this.value.length==3) return false;"
																onkeyup="this.value=this.value.replace(/[^0-9]/g,'');calculateAspirationalGPs(${count.index});changeColor()"
																min="1" required="required"
																name="incomeEnhancementDetails[${count.index}].totalNoOfGpCovered"
																id="noOfGpCoveredId_${count.index}"
																class="form-control Align-Right" /></td>
															
															<td><div align="center" id="aspirationalMoprGpId_${count.index}">${state_data.noOfAspirationalGp}</div>
															<input type="text" placeholder="Total Aspirational GP"
															oninput="validity.valid||(value='');"
															onKeyPress="if(this.value.length==3) return false;"
															min="1" required="required"
															name="incomeEnhancementDetails[${count.index}].noOfAspirationalGp"
															id="aspirationalGpId_${count.index}"
															onkeyup="this.value=this.value.replace(/[^0-9]/g,'') ; calculateAspirationalGPs(${count.index});changeColor()"
															class="form-control Align-Right" /></td>
															</c:otherwise>
															</c:choose>
															
															
															<td><div align="center">${state_data.yearFrom}</div>
															<input type="hidden" name="incomeEnhancementDetails[${count.index}].yearFrom" value="${state_data.yearFrom}"/>
															</td>
															
															<td><div align="center">${state_data.yearTo}</div>
															<input type="hidden" name="incomeEnhancementDetails[${count.index}].yearTo" value="${state_data.yearTo}"/>
															</td>
															<c:choose>
															<c:when test="${not empty dbActivitiesList}">
															<td><div align="center" id="projectCostMoprId_${count.index}">${state_data.totalCostOfProject}</div>
																<form:input oninput="validity.valid||(value='');"
																onKeyPress="if(this.value.length==7) return false;"
																value="${dbActivitiesList.incomeEnhancementDetails[count.index].totalCostOfProject}"																
																min="1" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');changeColor()"
																path="incomeEnhancementDetails[${count.index}].totalCostOfProject"
																id="projectCostId_${count.index}"
																required="required" class="form-control Align-Right" /></td>
															
															<c:set var="totalFundForMopr"
																value="${totalFundForMopr + state_data.fundsRequired}"></c:set>
															<c:set var="totalFundToCalc"
																value="${totalFundToCalc + dbActivitiesList.incomeEnhancementDetails[count.index].fundsRequired}"></c:set>
															
															<td><div align="center" id="fundsNameMoprId_${count.index}">${state_data.fundsRequired}</div>
																<form:input oninput="validity.valid||(value='');"
																onKeyPress="if(this.value.length==5) return false;"
																onkeyup="this.value=this.value.replace(/[^0-9]/g,'');changeColor()"
																min="1" max="50000"
																value="${dbActivitiesList.incomeEnhancementDetails[count.index].fundsRequired}"
																id="fundsName_${count.index}"
																path="incomeEnhancementDetails[${count.index}].fundsRequired"
																required="required"
																class="form-control Align-Right exclud" /></td>
															</c:when>
															<c:otherwise>
															<td><div align="center" id="projectCostMoprId_${count.index}">${state_data.totalCostOfProject}</div>
																<form:input oninput="validity.valid||(value='');"
																onKeyPress="if(this.value.length==7) return false;"
																min="1" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');changeColor()"
																path="incomeEnhancementDetails[${count.index}].totalCostOfProject"
																id="projectCostId_${count.index}"
																required="required" class="form-control Align-Right" /></td>
															
															<c:set var="totalFundForMopr"
																value="${totalFundForMopr + state_data.fundsRequired}"></c:set>
															<c:set var="totalFundToCalc"
																value="${totalFundToCalc + dblist.fundsRequired}"></c:set>
															
															<td><div align="center" id="fundsNameMoprId_${count.index}">${state_data.fundsRequired}</div>
																<form:input oninput="validity.valid||(value='');"
																onKeyPress="if(this.value.length==5) return false;"
																onkeyup="this.value=this.value.replace(/[^0-9]/g,'');changeColor()"
																min="1" max="50000"
																id="fundsName_${count.index}"
																path="incomeEnhancementDetails[${count.index}].fundsRequired"
																required="required"
																class="form-control Align-Right exclud" /></td>
															</c:otherwise>
															</c:choose>
															
															
															<td><div align="center">
																	<strong>${state_data.briefAboutActivity}</strong>
																</div>
																<input type="hidden" name="incomeEnhancementDetails[${count.index}].briefAboutActivity" value="${state_data.briefAboutActivity}"/>
															</td>
															<td><input type="button" value="Download File"
																class="btn bg-grey waves-effect"
																onclick='showImage("${state_data.fileLocation}","${state_data.fileName}");' /></td>
															<td><c:choose>
																	<c:when
																		test="${state_data.planApprovedByDpc eq true}">
																		<i class="fa fa-check" aria-hidden="true"
																			style="color: #00cc00"></i>
																	</c:when>
																	<c:otherwise>
																		<i class="fa fa-times" aria-hidden="true"
																			style="color: red"></i>
																	</c:otherwise>
																</c:choose></td>


														</tr>
														<input type="hidden" name="setBlockId" />
														<c:choose>
														<c:when test="${not empty dbActivitiesList}">
															<input type="hidden"
																name="incomeEnhancementDetails[${count.index}].incomeEnhancementDetailsId"
																value="${dbActivitiesList.incomeEnhancementDetails[count.index].incomeEnhancementDetailsId}" />
															<input type="hidden"
																name="incomeEnhancementDetails[${count.index}].fileName"
																value="${dbActivitiesList.incomeEnhancementDetails[count.index].fileName}">
															<input type="hidden"
																name="incomeEnhancementDetails[${count.index}].fileContentType"
																value="${dbActivitiesList.incomeEnhancementDetails[count.index].fileContentType}">
															<input type="hidden"
																name="incomeEnhancementDetails[${count.index}].fileLocation"
																value="${dbActivitiesList.incomeEnhancementDetails[count.index].fileLocation}">
															<input type="hidden"
																name="incomeEnhancementDetails[${count.index}].districtCode"
																value="${dbActivitiesList.incomeEnhancementDetails[count.index].districtCode}">
														</c:when>
														<c:otherwise>
															 <input type="hidden"
																name="incomeEnhancementDetails[${count.index}].incomeEnhancementDetailsId"
																value="${state_data.incomeEnhancementDetailsId}" />
															<input type="hidden"
																name="incomeEnhancementDetails[${count.index}].fileName"
																value="${state_data.fileName}">
															<input type="hidden"
																name="incomeEnhancementDetails[${count.index}].fileContentType"
																value="${state_data.fileContentType}">
															<input type="hidden"
																name="incomeEnhancementDetails[${count.index}].fileLocation"
																value="${state_data.fileLocation}">
															<input type="hidden"
																name="incomeEnhancementDetails[${count.index}].districtCode"
																value="${state_data.districtCode}">
														</c:otherwise>
														</c:choose>


													</c:forEach>
												<%-- c:if> --%>
											</tbody>
										</table>
										<br>
										<br>
										<br>
										<br>
										<br>
										<br>
									</div>
									<br />
									<table class="table table-bordered" id="myTable">
										<tr>
											<td>Funds</td>
											<td>
											<div id="subTotalMopr" style="margin-left: 15%"><c:out value="${totalFundForMopr}" /></div>
											<input type="text" id="subTotal"
												value="${totalFundToCalc}" Class="form-control Align-Right"
												readonly="readonly"></td>
										</tr>
										<tr>
											<td>Additional Requirements</td>
											<c:choose>
												<c:when test="${not empty dbActivitiesList}">
													<c:set var="addtnlReqrmnt"
														value="${addtnlReqrmnt + dbActivitiesList.additionalRequirement}"></c:set>
												</c:when>
												<c:otherwise>
													<c:set var="addtnlReqrmnt" value="0"></c:set>
												</c:otherwise>
											</c:choose>
											<td>
											<div id="additioinalRequirementsMopr" style="margin-left: 15%">${INCOMEENHANCEMENT_STATE[0].additionalRequirement }</div>
											<input type="text"
												oninput="validity.valid||(value='');"
												onKeyPress="if(this.value.length==7) return false;"
												onkeyup="this.value=this.value.replace(/[^0-9]/g,'');changeColor()"
												value="${addtnlReqrmnt}" min="1"
												name="additionalRequirement" id="additioinalRequirements"
												Class="form-control Align-Right exclud" required="required"></td>
										</tr>
										<tr>
											<td>Total Proposed Funds</td>
											<td>
											<div id="grandTotalState" style="margin-left: 15%">${totalFundForMopr + INCOMEENHANCEMENT_MOPR.additionalRequirement }</div>
											<input type="text" id="grandTotal"
												value="${addtnlReqrmnt + totalFundToCalc}"
												Class="form-control Align-Right" readonly="readonly"></td>
										</tr>
									</table>
									<c:if test="${not empty dbActivitiesList}">
										<input type="hidden" name="incomeEnhancementId"
											value="${dbActivitiesList.incomeEnhancementId}" />
										<input type="hidden" name="isFreeze" id="isFreeze"
											value="${dbActivitiesList.isFreeze}" />
										<input type="hidden" name="userType" id="userTypeId"
											value="${dbActivitiesList.userType}">
									</c:if>
									<input type="hidden" name="idToDelete" id="idToDelete">
									<input type="hidden" name="path" id="path">
									<input type="hidden" name="dbFileName" id="dbFileName">
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
										<button type="button" id="saveButtn"
											onclick="$('input,select').prop('disabled', false);saveSubmit();"
											class="btn bg-green waves-effect save-button">SAVE</button>
										<c:choose>
										<c:when test="${initial_status}"><button type="button" id="frzButtn" onclick="toFreeze();"
											class="btn bg-green waves-effect" disabled="disabled">FREEZE</button></c:when>
										<c:otherwise><button type="button" id="frzButtn" onclick="toFreeze();"
											class="btn bg-green waves-effect">FREEZE</button></c:otherwise>
										</c:choose>
										
										<button type="button" id="unFrzButtn" onclick="toFreeze();"
											class="btn bg-green waves-effect">UNFREEZE</button>
										<button type="button" id="clearButtn"
											class="btn bg-light-blue waves-effect reset">CLEAR</button>
										<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">CLOSE</button>
									</div>
									</div>
								</div>


								<div class="container tab-pane fade" id="state" style="width: auto;">
									<div class="table-responsive">
										<table class="table table-bordered">
											<thead>
												<tr>
													<th rowspan="2">S.No.</th>
													<th rowspan="2">Name of the Activity</th>
													<!-- <th rowspan="2">Select Ministry/Scheme</th> -->
													<th rowspan="2"><div align="center">Select
															Scheme</div></th>
													<th rowspan="2">District Name</th>
													<th rowspan="2">Block Name</th>
													<th rowspan="2">Total No. of GP's Covered</th>
													<th rowspan="2">No. of Aspirational GPs</th>
													<th colspan="2">Time Frame of project(year wise)</th>
													<th rowspan="2">Total cost of project</th>
													<th rowspan="2">Funds Proposed in current year</th>
													<th rowspan="2">Brief about the Activity</th>

													<th rowspan="2">Plan approved by DPC</th>
													<!-- <th rowspan="2">Is Approved</th> -->
													<th rowspan="2">Remarks</th>

												</tr>
												<tr>
													<th>From</th>
													<th>To</th>
												</tr>
											</thead>
											<tbody>

												<c:if test="${not empty INCOMEENHANCEMENTDETAIL_STATE}">
													<c:forEach items="${INCOMEENHANCEMENTDETAIL_STATE}"
														var="dblist" varStatus="count">
														<tr>
															<td>${count.count}</td>
															<td>${dblist.activtyName}</td>

															<td><c:forEach items="${schemeMasterList}" var="scm">
																	<c:choose>
																		<c:when
																			test="${dblist.fundSourceCode == scm.schemeId}">
																			${scm.schemeName}
																		</c:when>


																	</c:choose>
																</c:forEach></td>
															<td><c:forEach items="${districtList}" var="dlist">
																	<c:choose>
																		<c:when
																			test="${dblist.districtCode == dlist.districtCode}">
																			${dlist.districtNameEnglish}
																		</c:when>

																	</c:choose>
																</c:forEach></td>
															<td><c:forEach items="${BLOCK}" var="obj">

																	<c:choose>
																		<c:when test="${obj.blockCode == dblist.blockCode}">
																			${obj.blockNameEnglish}
																		</c:when>

																	</c:choose>
																</c:forEach></td>
															<td>${dblist.totalNoOfGpCovered}</td>
															<td>${dblist.noOfAspirationalGp}</td>
															<td>${dblist.yearFrom}</td>
															<td>${dblist.yearTo}</td>
															<td>${dblist.totalCostOfProject}</td>
															<c:set var="totalFundToCalc"
																value="${totalFundToCalc + dblist.fundsRequired}"></c:set>
															<td>${dblist.fundsRequired}</td>
															<td>${dblist.briefAboutActivity}</td>
															<td><c:choose>
																	<c:when test="${dblist.planApprovedByDpc eq true}">
																		<i class="fa fa-check" aria-hidden="true"
																			style="color: #00cc00"></i>
																	</c:when>
																	<c:otherwise>
																		<i class="fa fa-times" aria-hidden="true"
																			style="color: red"></i>
																	</c:otherwise>
																</c:choose></td>


															<%-- <td><div align="center">
																	<c:choose>
																		<c:when test="${dblist.isApproved eq true}">
																			<i class="fa fa-check" aria-hidden="true"
																				style="color: #00cc00"></i>
																		</c:when>
																		<c:otherwise>
																			<i class="fa fa-times" aria-hidden="true"
																				style="color: red"></i>
																		</c:otherwise>
																	</c:choose>
																</div></td> --%>
															<td><strong>${dblist.remarks}</strong></td>


														</tr>

													</c:forEach>
												</c:if>
											</tbody>
										</table>
										<br>
										<br>
										<br>

									</div>
									<br />
									<table class="table table-bordered" id="myTable">
										<tr>
											<td>Funds</td>
											<td><strong>${totalFundToCalc}</strong></td>
										</tr>
										<tr>
											<td>Additional Requirements</td>
											<td><strong>${INCOMEENHANCEMENT_STATE[0].additionalRequirement}</strong></td>
										</tr>
										<tr>
											<td>Total Proposed Funds</td>
											<td><strong>${INCOMEENHANCEMENT_STATE[0].additionalRequirement + totalFundToCalc}</strong></td>
										</tr>
									</table>
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
