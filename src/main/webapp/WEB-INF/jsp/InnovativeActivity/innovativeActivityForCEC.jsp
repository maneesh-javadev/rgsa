<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript">
	 $(document).ready(function() { 
		onloadChangeColor();
		if(document.getElementById("isfreeze") != null){
			var myBoolean= document.getElementById("isfreeze").value;
		}
		 if(myBoolean == "true"){
			 $("input").prop('disabled', true);
			 $("select").prop('disabled', true);
		}
		 if($('#userType').val() == 'M'){
			$('#supportStaff , #file').each(function () {
				$('#supportStaff , #file').attr('disabled','disabled');
				$('#supportStaff ,.usrType').prop('readonly','readonly');
				});
		}
		$("#supportStaff").on('input',$(".fundsName"), function () {
				var calculated_total_sum = 0;
				
				$("#supportStaff,.fundsName").each(function () {
					var get_textbox_value = $(this).val();
					 if ($.isNumeric(get_textbox_value)) {
						if(calculated_total_sum + parseFloat(get_textbox_value) > 100000000){
							alert("Total fund value cannot be greater than 10 Crore");
							$(this).val("");
							calculated_total_sum += 0;		
						}else{
							calculated_total_sum += parseFloat(get_textbox_value);
						}
					}
					if(calculated_total_sum > 100000000){
						 alert("Total fund value cannot be greater than 10 Crore");
						 $(this).val("");
						 $("#subTotal").val();
						 return false;
					} 
					
					 if(calculated_total_sum >= 100000000){
						 alert("Total fund value should be equal to 10 Crore than Additional Requirements should be 0."); 
						 document.getElementById("additioinalRequirements").value = "";
						 $(this).val("");
						 $("#subTotal").val("");   
						 return true; 
						 } 
					 	else{
						
						$("#subTotal").val(calculated_total_sum);
						if(calculated_total_sum == 100000000){
							document.getElementById("grandTotal").value = 0 + parseFloat(calculated_total_sum);
							document.getElementById("additioinalRequirements").value='';
							if($("#additioinalRequirements").val() == ""){
								document.getElementById("grandTotal").value = 0 + parseFloat(calculated_total_sum);
							}else{
								document.getElementById("grandTotal").value = parseFloat(document.getElementById("additioinalRequirements").value) + parseFloat(calculated_total_sum);
							}
						}else{
							if($("#additioinalRequirements").val() == ""){
								document.getElementById("grandTotal").value = 0 + parseFloat(calculated_total_sum);
							}else{
								document.getElementById("grandTotal").value = parseFloat(document.getElementById("additioinalRequirements").value) + parseFloat(calculated_total_sum);
							}
								
						}
						
					}
				});
				/* $("#subTotal").val(calculated_total_sum);
				document.getElementById("grandTotal").value = parseFloat(document.getElementById("additioinalRequirements").value) + parseFloat(calculated_total_sum); */
				});
			
		  $("#myTable").on('input',$("#grandTotal"), function () {
			  var adtnlRqrmnt = parseFloat(document.getElementById("additioinalRequirements").value);
				 var subTotal = parseFloat(document.getElementById("subTotal").value);
				 var grandTotal = 0;
				  var check = (25*subTotal)/100;
				  
				  if(adtnlRqrmnt > check){
					  alert("Additional Requirement Should be less than or equal to 25% of fund i.e." +" less than or equal to "+ check );
					  document.getElementById("additioinalRequirements").value = "";
					  return false;
				  }
				  if(subTotal == 100000000){
					  grandTotal = 0 + parseFloat(document.getElementById("subTotal").value);
					  document.getElementById("additioinalRequirements").value = '';
				  }
				  else{
					  grandTotal = parseFloat(document.getElementById("additioinalRequirements").value) + parseFloat(document.getElementById("subTotal").value);
				  }
			 
			  if(grandTotal > 100000000){
				  alert("Total fund value cannot be greater than 10 Crore");
				  /* $("#additioinalRequirements").val(00); */
				  document.getElementById("additioinalRequirements").value = "";
			  }else
			  document.getElementById("grandTotal").value = grandTotal;
		});
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
	});
	 
	 $('document').ready(function(){
			$(".reset").bind("click", function() {
			  $("input[type=text]").val('');
			});
			/* calculateGrandTotal(); */
		});

	 function onloadChangeColor(){
			var noOfRowCount = $('#newBody tr').length;
			for(var i= 0; i<noOfRowCount ;i++){
			
		+$("#fundId_"+i).val() < +$("#fundIdMopr_"+i).text() ? $("#fundIdMopr_"+i).css("color","red") : $("#fundIdMopr_"+i).css("color","#00cc00");
			}
			+$("#additioinalRequirementsMopr").text() > +$("#additioinalRequirements").val() ? $("#additioinalRequirementsMopr").css('color','red') : $("#additioinalRequirementsMopr").css('color','#00cc00');
			+$("#subTotalMopr").text() > +$("#subTotal").val() ? $("#subTotalMopr").css('color','red') : $("#subTotalMopr").css('color','#00cc00');
			+$("#grandTotalMopr").text() > +$("#grandTotal").val() ? $("#grandTotalMopr").css('color','red') : $("#grandTotalMopr").css('color','#00cc00');

		}
	 
		
function showImage(path,name){
	 $("select").prop('disabled', false);
	$("input").prop('disabled', false);
	document.getElementById("path").value = path;
	document.getElementById("dbFileName").value = name;
	document.innovativeActivity.method = "post";
	document.innovativeActivity.action = "viewFileOfInnovativeActivity.html?<csrf:token uri='viewFileOfInnovativeActivity.html'/>";
	document.innovativeActivity.submit();
	var myBoolean= document.getElementById("isfreeze").value;
	 if(myBoolean == "true"){
		 $("input").prop('disabled', true);
		 $("select").prop('disabled', false);
	 }
	  if($('#userType').val() == 'M'){
			$('#supportStaff , #file').each(function () {
				$('#supportStaff , #file').attr('disabled','disabled');
				});
		}
}
function pathImage(path,name){
	document.getElementById("path").value = path;
	document.getElementById("dbFileName").value = name;
}
function toDelete(idToDelete,path,name){
	document.getElementById("idToDelete").value = idToDelete;
	document.getElementById("path").value = path;
	document.getElementById("dbFileName").value = name;
	document.innovativeActivity.method = "post";
	document.innovativeActivity.action = "deleteInnovativeActivity.html?<csrf:token uri='deleteInnovativeActivity.html'/>";
	document.innovativeActivity.submit();
}

function freezUnfreez(obj){
	$("select").prop('disabled', false);
	$("input").prop('disabled', false);
	$('#file').attr('disabled',false);
	document.getElementById("dbFileName").value = obj;
	document.innovativeActivity.method = "post";
	document.innovativeActivity.action = "freezUnfreez.html?<csrf:token uri='freezUnfreez.html'/>";
	document.innovativeActivity.submit();
}

function validate(){
	 var adtnlRqrmnt = parseFloat(document.getElementById("additioinalRequirements").value);
	 var subTotal = parseFloat(document.getElementById("subTotal").value);
	  var check = (25*subTotal)/100;
	  
	  $('#file').attr('disabled',false);
	  if(adtnlRqrmnt > check){
		  alert("Additional Requirement Should Be Less Than 25% of SubTotal");
		  document.getElementById("additioinalRequirements").value = 0;
		  return false;
	  }
	  
  document.getElementById("grandTotal").value = parseFloat(document.getElementById("additioinalRequirements").value) + parseFloat(document.getElementById("subTotal").value);
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
		
function saveSubmit(){
	document.innovativeActivity.method = "post";
	document.innovativeActivity.action = "innovativeActivityDetails.html?<csrf:token uri='innovativeActivityDetails.html'/>";
	document.innovativeActivity.submit();
}	
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message text="Innovative Activity" htmlEscape="true" />
							(CEC)
						</h2>
					</div>
					<form:form method="POST" id="innovativeActivityId"
						name="innovativeActivity" class="form-inline"
						action="innovativeActivityDetails.html"
						modelAttribute="INNOVATIVE_ACTIVITY" enctype="multipart/form-data" onsubmit="disablingSave()">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="innovativeActivity.html"/>" />

						<ul class="nav nav-tabs">
							<li class="nav-item"><a class="nav-link"
								data-toggle="tab" href="#state"><spring:message
										code="Label.STATE" htmlEscape="true" /></a></li>
							<li class="nav-item  active"><a class="nav-link" data-toggle="tab"
								href="#MOPR"><spring:message code="Label.MOPR"
										htmlEscape="true" /></a></li>
						</ul>

						<div class="tab-content">
							<div role="tabpanel" class="container tab-pane active " id="MOPR"
								style="width: auto;">
								<div class="table-responsive">
									<table class="table table-bordered" id="supportStaff">
										<thead>
											<tr>
												<th scope="col"><div align="center">
														<spring:message text="Name of the Activity"
															htmlEscape="true" />
													</div></th>
												<th scope="col"><div align="center">
														<spring:message text="Brief about the Activity"
															htmlEscape="true" />
													</div></th>
												<th scope="col" colspan="2"><div align="center">Time
														Frame of project(year wise)</div></th>
												<th scope="col"><div align="center">
														<spring:message code="Label.Funds" text="Funds"
															htmlEscape="true" />
													</div></th>

												<th scope="col"><div align="center">
														<spring:message text="Upload File(Pdf)" htmlEscape="true" />
													</div></th>
                                                      <%-- <th scope="col"><div align="center">
														<spring:message text="Is Approved" htmlEscape="true" />
													</div></th> --%>
												<th scope="col"><div align="center">
														<spring:message code="Label.Remarks" text="Remarks"
															htmlEscape="true" />
													</div></th>

												<%-- <c:if test = "${fn:containsIgnoreCase(userTypeSwitch, 'S')}">	
										<th scope="col"><div align="center">
										<spring:message code="Label.Delete" htmlEscape="true" />
											</div></th>
										</c:if>	 --%>
											</tr>
											<tr>
												<th colspan="2"></th>
												<th>From</th>
												<th>To</th>
											</tr>
										</thead>
										<tbody id="newBody">
													<c:forEach var="state_detail" items="${innovativeActivityDetailsMopr}" varStatus="count">
														<tr id="newRow">
															<td><strong>${state_detail.activityName}</strong>
																<input type="hidden" name="innovativeActivityDetails[${count.index}].activityName" value="${state_detail.activityName}"/>
															</td>
															<td><strong>${state_detail.aboutActivity}</strong>
																<input type="hidden" name="innovativeActivityDetails[${count.index}].aboutActivity" value="${state_detail.aboutActivity}"/>
															</td>
															<td><strong>${state_detail.yearFrom}</strong>
																<input type="hidden" name="innovativeActivityDetails[${count.index}].yearFrom" value="${state_detail.yearFrom}"/>
															</td>
															<td><strong>${state_detail.yearTo}</strong>
																<input type="hidden" name="innovativeActivityDetails[${count.index}].yearTo" value="${state_detail.yearTo}"/>
															</td>
															<c:choose>
															
															<c:when test="${not empty innovativeAcitivityList}"><c:set var="totalFundToCalc"
																value="${totalFundToCalc + innovativeAcitivityList[0].innovativeActivityDetails[count.index].fundsName}"></c:set>
															<td><div align="center"
																		id="fundIdMopr_${count.index}"><strong>${state_detail.fundsName}</strong></div>

																<input type="text" oninput="validity.valid||(value='');"
																min="0" id="fundId_${count.index}"
																name="innovativeActivityDetails[${count.index}].fundsName"
																value="${innovativeAcitivityList[0].innovativeActivityDetails[count.index].fundsName}"
																onkeyup="this.value=this.value.replace(/[^0-9]/g,''); onloadChangeColor()"
																Class="form-control Align-Right fundsName"
																placeholder="Enter Funds" /></td>
															</c:when>
															
															<c:otherwise>
															<c:set var="totalFundToCalc"
																value="${totalFundToCalc + 0}"></c:set>
															<td><div align="center"
																		id="fundIdMopr_${count.index}"><strong>${state_detail.fundsName}</strong></div>

																<input type="text" oninput="validity.valid||(value='');"
																min="0" id="fundId_${count.index}"
																name="innovativeActivityDetails[${count.index}].fundsName"
																onkeyup="this.value=this.value.replace(/[^0-9]/g,''); onloadChangeColor()"
																Class="form-control Align-Right fundsName"
																 placeholder="Enter Funds" /></td>
															</c:otherwise>
															</c:choose>
															
															<td><input type="button" value="Download File"
																class="btn bg-grey waves-effect"
																onclick='showImage("${state_detail.fileLocation}","${state_detail.fileName}");' />
															</td>
															<%-- <td><div align="center">
																	<c:choose>
																		<c:when
																			test="${innovativeActivityDetailsMopr[count.index].isApproved eq true}">
																			<i class="fa fa-check" aria-hidden="true"
																				style="color: #00cc00"></i>
																		</c:when>
																		<c:otherwise>
																			<i class="fa fa-times" aria-hidden="true"
																				style="color: red"></i>
																		</c:otherwise>
																	</c:choose>
																</div></td> --%>
														<td>
														<div align="center">
													          <label class="addMore btn bg-green waves-effect" title="${detailsForMOPR[index.index].remarks}">Remark by MoPR</label>
                                                               
															<input type="text" 
																name="innovativeActivityDetails[${count.index}].remarks" class="form-control"
																value="${innovativeAcitivityList[0].innovativeActivityDetails[count.index].remarks}"
																 />
																 </div>
																 </td>
														</tr>
														
														<c:choose>
														 <c:when test="${not empty innovativeAcitivityList}">
																<input type="hidden" name="innovativeActivityId"
																	value="${innovativeAcitivityList[0].innovativeActivityId}">
																<input type="hidden" name="createdBy" id=createdBy
																	value="${innovativeAcitivityList[0].createdBy}" />
																<input type="hidden" name="userType" id=userType
																	value="${innovativeAcitivityList[0].userType}" />
																<input type="hidden" id="isfreeze" name="isFreeze"
																	value="${innovativeAcitivityList[0].isFreeze}">
																<input type="hidden"
																	name="innovativeActivityDetails[${count.index}].id"
																	value="${innovativeAcitivityList[0].innovativeActivityDetails[count.index].id}">
																<input type="hidden"
																	name="innovativeActivityDetails[${count.index}].fileName"
																	value="${innovativeAcitivityList[0].innovativeActivityDetails[count.index].fileName}">
																<input type="hidden"
																	name="innovativeActivityDetails[${count.index}].fileContentType"
																	value="${innovativeAcitivityList[0].innovativeActivityDetails[count.index].fileContentType}">
																<input type="hidden"
																	name="innovativeActivityDetails[${count.index}].fileLocation"
																	value="${innovativeAcitivityList[0].innovativeActivityDetails[count.index].fileLocation}">
															
															</c:when>
														 <c:otherwise>
																<input type="hidden" name="innovativeActivityId"
																	value="${innovativeAcitivityList[0].innovativeActivityId}">
																<input type="hidden" name="createdBy" id=createdBy
																	value="${innovativeAcitivityList[0].createdBy}" />
																<input type="hidden" name="userType" id=userType
																	value="${innovativeAcitivityList[0].userType}" />
																<input type="hidden" id="isfreeze" name="isFreeze"
																	value="${innovativeAcitivityList[0].isFreeze}">
																<input type="hidden"
																	name="innovativeActivityDetails[${count.index}].id"
																	value="${state_detail.id}">
																<input type="hidden"
																	name="innovativeActivityDetails[${count.index}].fileName"
																	value="${state_detail.fileName}">
																<input type="hidden"
																	name="innovativeActivityDetails[${count.index}].fileContentType"
																	value="${state_detail.fileContentType}">
																<input type="hidden"
																	name="innovativeActivityDetails[${count.index}].fileLocation"
																	value="${state_detail.fileLocation}">
																	
																	
															</c:otherwise>
														</c:choose>
														
														<input type="hidden" name="idToDelete" id="idToDelete">
														<input type="hidden" name="path" id="path">
														<input type="hidden" name="dbFileName" id="dbFileName">
													</c:forEach>
											<tr>
												<td colspan="10"></td>
											</tr>
										</tbody>
									</table>

									<table class="table table-bordered" id="myTable">
										<tr>
											<td ><spring:message text="Total Funds"
													htmlEscape="true" /></td>
											
											<td><div style="margin-left: 15%;"
														id="subTotalMopr"><strong>${TOTALFUNDForMopr}</strong></div><input type="text"
												id="subTotal" value="${totalFundToCalc}" disabled="disabled"
												Class="form-control Align-Right" /></td>
										</tr>
										<tr>
											

												<td ><spring:message
														text="Additional Requirement" htmlEscape="true" /></td>
													<c:choose>
													<c:when test="${not empty innovativeAcitivityList }">
													<input type="hidden" name="innovativeActivityId"
														value="${innovativeAcitivityList[0].innovativeActivityId}">
													<c:set var="addtnlReqrmnt"
													value="${addtnlReqrmnt + innovativeAcitivityList[0].additioinalRequirements}"></c:set>
													</c:when>
													<c:otherwise>
														<c:set var="addtnlReqrmnt"
													value="${addtnlReqrmnt + 0}"></c:set>
													</c:otherwise>
													</c:choose>
												
												<td><div id="additioinalRequirementsMopr" style="margin-left: 15%;"><strong>${innovativeAcitivityListForMopr[0].additioinalRequirements}</strong></div>
													<input min="0" type="text"
													oninput="validity.valid||(value='');"
													onKeyPress="if(this.value.length==7) return false;"
													onkeyup="this.value=this.value.replace(/[^0-9]/g,''); onloadChangeColor();"
													name="additioinalRequirements" id="additioinalRequirements"
													value="${addtnlReqrmnt}"
													maxlength="15" Class="form-control Align-Right"
													placeholder="<= 25% of Total" /></td>
										</tr>


										<tr>
											<td ><spring:message
													text="Total Proposed Fund" htmlEscape="true" /></td>
											
											<td><div id="grandTotalMopr"  style="margin-left: 15%;"><strong>${TOTALFUNDForMopr+innovativeAcitivityListForMopr[0].additioinalRequirements}</strong> </div><input
												type="text" id="grandTotal"
												value="${addtnlReqrmnt + totalFundToCalc}"
												disabled="disabled" Class="form-control Align-Right" /></td>
										</tr>
									</table>
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

									<c:if test="${not empty innovativeAcitivityList}">
										<div class="col-md-8 text-right">
											<c:if test="${innovativeAcitivityList[0].isFreeze == true}">
												<button type="button" id="save"
													class="btn bg-green waves-effect" disabled="disabled">
													<spring:message text="SAVE" htmlEscape="true" />
												</button>
												<button type="button" id="unfreeze"
													onclick='freezUnfreez("Unf");'
													class="btn bg-green waves-effect">
													<spring:message code="Label.UNFREEZE" text="Unfreeze"
														htmlEscape="true" />
												</button>
												<%-- <button type="button" id="clear"
													class="btn bg-light-blue waves-effect" disabled="disabled">
													<spring:message code="Label.CLEAR" htmlEscape="true" />
												</button> --%>
											</c:if>
											<c:if test="${innovativeAcitivityList[0].isFreeze == false}">
												<button type="button" id="save"
													class="btn bg-green waves-effect save-button" onclick="saveSubmit();">
													<spring:message text="SAVE" htmlEscape="true" />
												</button>
												<button type="button" id="freeze"
													onclick='freezUnfreez("Frz");'
													class="btn bg-green waves-effect">
													<spring:message code="Label.FREEZE" text="Freeze"
														htmlEscape="true" />
												</button>
												<%-- <button type="button" id="clear"
													class="btn bg-light-blue waves-effect">
													<spring:message code="Label.CLEAR" htmlEscape="true" />
												</button> --%>
											</c:if>
											<button type="button"
												onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
												class="btn bg-orange waves-effect">
												<spring:message code="Label.CLOSE" htmlEscape="true" />
											</button>
										</div>
									</c:if>

									<c:if test="${empty innovativeAcitivityList}">
										<div class="col-md-8 text-right">
											<button type="button" id="save" onclick="saveSubmit();"
												class="btn bg-green waves-effect">
												<spring:message text="SAVE" htmlEscape="true" />
											</button>

											<button type="button" id="freeze"
												class="btn bg-green waves-effect" disabled="disabled">
												<spring:message code="Label.FREEZE" text="Freeze"
													htmlEscape="true" />
											</button>

											<%-- <button type="button" id="clear"
												class="btn bg-light-blue waves-effect">
												<spring:message code="Label.CLEAR" htmlEscape="true" />
											</button> --%>
											<button type="button"
												onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
												class="btn bg-orange waves-effect">
												<spring:message code="Label.CLOSE" htmlEscape="true" />
											</button>
										</div>
									</c:if>
								</div>
							</div>

							<div class="container tab-pane " id="state"
								style="width: auto;">
								<div class="table-responsive">
									<table class="table table-bordered" id="supportStaff">
										<thead>
											<tr>
												<th scope="col"><div align="center">
														<spring:message text="Name of the Activity"
															htmlEscape="true" />
													</div></th>
												<th scope="col"><div align="center">
														<spring:message text="Brief about the Activity"
															htmlEscape="true" />
													</div></th>
												<th scope="col" colspan="2"><div align="center">Time
														Frame of project(year wise)</div></th>
												<th scope="col"><div align="center">
														<spring:message code="Label.Funds" text="Funds"
															htmlEscape="true" />
													</div></th>

												<%-- <th scope="col"><div align="center">
										<spring:message  text="Upload File(Pdf)" htmlEscape="true" />
											</div></th> --%>

												<th>
													<div align="center">
														<strong><spring:message code="Label.Remarks" htmlEscape="true" />  
														</strong>
													</div>
												</th>



											</tr>
											<tr>
												<th colspan="2"></th>
												<th>From</th>
												<th>To</th>
											</tr>
										</thead>
										<tbody id="newBody">
													<c:forEach var="state_data"
														items="${innovativeActivityDetailState}"
														varStatus="count">
														<tr id="newRow">
															<td><strong>${state_data.activityName}</strong></td>
															<td><strong>${state_data.aboutActivity}</strong></td>
															<td><strong>${state_data.yearFrom}</strong>
															</td>
															<td><strong>${state_data.yearTo}</strong>
															</td>

															<td><div align="center"><strong>${state_data.fundsName}</strong></div>
                                                            <td><div align="center"><strong>${state_data.remarks}</strong></div>
																<%-- <td> 
												<input type="file" name="innovativeActivityDetails[${count.index}].file" id="file" onclick='pathImage("${innovativeActivityDetails.fileLocation}","${innovativeActivityDetails.fileName}");' >
												<input type="button" value="Download File" class="btn bg-grey waves-effect" onclick='showImage("${innovativeActivityDetailsMopr[count.index].fileLocation}","${innovativeActivityDetailsMopr[count.index].fileName}");' />
										</td> --%>
															

														</tr>
														<%-- 	<input type="hidden" name="innovativeActivityId" value="${innovativeActivity.innovativeActivityId}">
										<input type="hidden" name="createdBy" id=createdBy  value="${innovativeActivity.createdBy}"/>
										<input type="hidden" name="userType" id=userType  value="${innovativeActivity.userType}"/>
										<input type="hidden" id="isfreeze" name="isFreeze" value="${innovativeAcitivityList[0].isFreeze}">
										<input type="hidden" name="innovativeActivityDetails[${count.index}].id" value="${innovativeActivityDetails.id}">
										<input type="hidden" name="innovativeActivityDetails[${count.index}].fileName" value="${innovativeActivityDetails.fileName}">
										<input type="hidden" name="innovativeActivityDetails[${count.index}].fileContentType" value="${innovativeActivityDetails.fileContentType}">
										<input type="hidden" name="innovativeActivityDetails[${count.index}].fileLocation" value="${innovativeActivityDetails.fileLocation}">
										<input type="hidden" name="idToDelete" id="idToDelete" >
										<input type="hidden" name="path" id="path" > 
										<input type="hidden" name="dbFileName" id="dbFileName" >
									 --%>
													</c:forEach>
											<tr>
												<td colspan="8"></td>
											</tr>
										</tbody>
									</table>
									<table class="table table-bordered" id="myTable">
										<tr>
											<td><strong><spring:message text="Total Funds"
														htmlEscape="true" /></strong></td>

											<td><strong>${TOTALFUND}</strong>
										</tr>
										<tr>
											<td><strong><spring:message
														text="Additional Requirement" htmlEscape="true" /></strong></td>
											<td><strong>${innovativeAcitivityListForState[0].additioinalRequirements}</strong></td>
										</tr>


										<tr>
											<td><strong><spring:message
														text="Total Proposed Fund" htmlEscape="true" /></strong></td>
											<td><strong>${GRANDTOTAL}</strong>
										</tr>
									</table>
								</div>
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
					</form:form>

				</div>
			</div>
		</div>

	</div>

</section>
<style>
.Align-Right{
			text-align: right;
}</style>