<%@include file="../taglib/taglib.jsp"%>
<html>
<head>
<script type="text/javascript">
var deleteFile =new Map();
var delTrainingIdArr=[];
var finalDetailArr=[];
	 $(document).ready(function() { 
		 
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
		$("#supportStaff").on('input',$("#fundsName"), function () {
				var calculated_total_sum = 0;
				
				$("#supportStaff,#fundsName").each(function () {
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
					
					/* if(calculated_total_sum >= 100000000){
						 alert("Total fund value should be equal to 10 Crore than Additional Requirements should be 0."); 
						 document.getElementById("additioinalRequirements").value = "";
						/*  $(this).val("");
						 $("#subTotal").val(""); */
						/*  return true; */
					/*} */
					
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
function addRow() {
	var rowCount = $('#supportStaff tr').length;
	var i = rowCount-3;
	var tds = '<tr>';
		 tds+='<td><input type = "text" name="innovativeActivityDetails['+i+'].activityName" id="activityNameId" Class="form-control letters" required="required" placeholder="Enter Activity Name" maxlength="200"/></td>';
		 tds+='<td><input  type="text" oninput="validity.valid||(value="");" onKeyPress="if(this.value.length==7) return false;" id="fundsName" name="innovativeActivityDetails['+i+'].fundsName"  Class="form-control Align-Right numbers" required="required" placeholder="Enter Funds"  maxlength="12"/></td>';
		 tds+='<td><input type = "text" name="innovativeActivityDetails['+i+'].aboutActivity"  Class="form-control alphaonly" required="required" placeholder="Enter Brief About Activity"  maxlength="250"/></td>';
		 tds+='<td><select required="required" class="form-control" id="yearOne_'+i+'" onchange="validateYear('+i+');"  name="innovativeActivityDetails['+i+'].yearFrom"><option value=""> From Year</option><option value="2018">2018</option><option value="2019">2019</option><option value="2020">2020</option><option value="2021">2021</option><option value="2022">2022</option></select></td>';
		 tds+='<td><select required="required" class="form-control" id="yearTwo_'+i+'" onchange="validateYear('+i+');" name="innovativeActivityDetails['+i+'].yearTo"><option value=""> To Year </option><option value="2018">2018</option><option value="2019">2019</option><option value="2020">2020</option><option value="2021">2021</option><option value="2022">2022</option></select></td>';
		 tds+='<td><input type="file" id="" name="innovativeActivityDetails['+i+'].file" required="required" ></td>';
		 tds+='<td><input type="button" value="Delete" onclick="deleteRow();" class="btn bg-red waves-effect"/></td>';
		tds += '</tr>';
	i++;
	$('#supportStaff tr:last').after(tds);
	regexValidation();
}

 function deleteRow(){
	
	if($('#supportStaff tr').length>2){
			
		$('#supportStaff tr:last').remove();
		
	}
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
	
	if(!delTrainingIdArr.includes(idToDelete)){
		 delTrainingIdArr.push(idToDelete);
		 $("#delete"+idToDelete).val('Undo');
		 $(".delete"+idToDelete).prop('disabled', true);
		 $("#file"+idToDelete).prop('disabled', true);
		 
		 //$("#modifyButtn"+idToDelete).addClass('not-active');
		 if(!deleteFile.has(idToDelete)){
			 deleteFile.set(idToDelete,name);
		}
	  }else{
		  var index = delTrainingIdArr.indexOf(idToDelete);
		 	if (index > -1) {
		 		delTrainingIdArr.splice(index, 1);
		   }
		 	
		 	 if(deleteFile.has(idToDelete)){
				 deleteFile.delete(idToDelete);
			}
		 	 $(".delete"+idToDelete).prop('disabled', false);
		 	 $("#file"+idToDelete).prop('disabled', false);
		 	  $("#delete"+idToDelete).val('Delete');
			// $("#modifyButtn"+idToDelete).removeClass('not-active');
	  }
	
	/* document.getElementById("idToDelete").value = idToDelete;
	document.getElementById("path").value = path;
	document.getElementById("dbFileName").value = name;
	document.innovativeActivity.method = "post";
	document.innovativeActivity.action = "deleteInnovativeActivity.html?<csrf:token uri='deleteInnovativeActivity.html'/>";
	document.innovativeActivity.submit(); */
}



function saveSubmit(){
	 $.each( delTrainingIdArr, function( index, value ) {
	    	fname=deleteFile.get(value);
	    	finalDetailArr.push(value+"@"+fname);
	    	$(".delete"+value).prop('disabled', false);
	    	$("#file"+value).prop('disabled', false);
		});
	 	
		document.getElementById("dbFileName").value = finalDetailArr.toString();
		document.getElementById("path").value = '${innovativeActivityDetails.fileLocation}';
	
	 document.innovativeActivity.method = "post";
	document.innovativeActivity.action = "innovativeActivityDetails.html?<csrf:token uri='innovativeActivity.html'/>";
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
</script>
</head>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2><spring:message  text="Innovative Activity" htmlEscape="true" /></h2>
					</div>
					<div class="body">
					<form:form method="POST" id="innovativeActivityId" name="innovativeActivity" class="form-inline" action="innovativeActivityDetails.html" modelAttribute="INNOVATIVE_ACTIVITY" enctype="multipart/form-data" onsubmit="disablingSave()">
						<div align="right">
						<c:if test = "${fn:containsIgnoreCase(userTypeSwitch, 'S')}">
						<c:if test="${innovativeAcitivityList[0].isFreeze == false}">
							<button type="button" onclick="addRow()"
								class="btn bg-green waves-effect"><i class="fa fa-plus"></i>Add New Row</button>
						</c:if>
						<c:if test="${empty innovativeAcitivityList}">
							<button type="button" onclick="addRow()"
								class="btn bg-green waves-effect"><i class="fa fa-plus"></i>Add New Row</button>
						</c:if>
						</c:if>
							<input type="hidden" name="<csrf:token-name/>" value="<csrf:token-value uri="innovativeActivity.html"/>" />
							<div class="table-responsive">
							<table class="table table-bordered" id="supportStaff">
								<thead>
									<tr>
										<th scope="col" rowspan="2"><div align="center">
										<spring:message   text="Name of the Activity" htmlEscape="true" />
											</div></th>
										<th scope="col" rowspan="2"><div align="center">
										<spring:message code="Label.Funds" text="Funds" htmlEscape="true" />
											</div></th>
										<th scope="col" rowspan="2"><div align="center">
										<spring:message  text="Brief about the Activity" htmlEscape="true" />
											</div></th>
										<th scope="col" colspan="2"><div align="center">Time Frame of project(year wise)</div></th>
										<th scope="col" rowspan="2"><div align="center">
										<spring:message  text="Upload File(Pdf)" htmlEscape="true" />
											</div></th>
										
										 <c:if test = "${fn:containsIgnoreCase(userTypeSwitch, 'M')}">
												<th scope="col" rowspan="2"><div align="center">
												<spring:message text="Is Approved" htmlEscape="true" />
													</div></th>	
											</c:if>
										<th scope="col" rowspan="2"><div align="center">
												<spring:message code="Label.Remarks" text="Remarks" htmlEscape="true" />
													</div></th>	
													
										<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1 and not empty innovativeActivity.innovativeActivityDetails}">
											<th colspan="2" >
												<div align="center">
													<strong>Previous comment history</strong>
												</div>
											</th>
										</c:if>			
										<c:if test = "${fn:containsIgnoreCase(userTypeSwitch, 'S')}">	
										<th scope="col" rowspan="2"><div align="center">
										<spring:message code="Label.Delete" htmlEscape="true" />
											</div></th>
										</c:if>	
									</tr>
									<tr>
										<!-- <th colspan="3"></th> -->
                                        <th>From </th>
                                        <th> To</th>
                                        
											<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1 and not empty innovativeActivity.innovativeActivityDetails}">
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
								<tbody id="newBody">
								<c:forEach var="innovativeActivity" items="${innovativeAcitivityList}">
								<c:if test="${not empty innovativeActivity.innovativeActivityDetails}">
									<c:forEach var="innovativeActivityDetails" items="${innovativeActivity.innovativeActivityDetails}" varStatus="count">
									<tr id="newRow">
										<td><input type="text" name="innovativeActivityDetails[${count.index}].activityName" id="activityNameId" value="${innovativeActivityDetails.activityName}" onkeyup="this.value=this.value.replace(/[^a-zA-Z ]/,'');" Class="form-control usrType delete${innovativeActivityDetails.id}" maxlength="200" placeholder="Enter Activity Name"/></td>
										 <c:set var="totalFundToCalc" value="${totalFundToCalc + innovativeActivityDetails.fundsName}"></c:set> 
										<td><input type="text"  oninput="validity.valid||(value='');" onKeyPress="if(this.value.length==8) return false;" min="0" id="fundsName" name="innovativeActivityDetails[${count.index}].fundsName" value="${innovativeActivityDetails.fundsName}" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" Class="form-control Align-Right delete${innovativeActivityDetails.id}"  maxlength="12" placeholder="Enter Funds"/></td>
										<td><input type = "text" name="innovativeActivityDetails[${count.index}].aboutActivity" value="${innovativeActivityDetails.aboutActivity}" Class="form-control usrType delete${innovativeActivityDetails.id}" onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9 ]/,'');"  maxlength="250" placeholder="Enter Brief About Activity"/></td>
										<td><select required="required" id="yearOne_${count.index}" class="form-control delete${innovativeActivityDetails.id}" onchange='validateYear("${count.index}");' name="innovativeActivityDetails[${count.index}].yearFrom">
				                            		<option value="${innovativeActivityDetails.yearFrom}">${innovativeActivityDetails.yearFrom}</option>
				                               		<option value="2018">2018</option>
													<option value="2019">2019</option>
													<option value="2020">2020</option>
													<option value="2021">2021</option>
													<option value="2022">2022</option>
			                              	</select>
                                       	</td>
                                       			<td><select required="required" id="yearTwo_${count.index}" onchange='validateYear("${count.index}");' class="form-control delete${innovativeActivityDetails.id}" name="innovativeActivityDetails[${count.index}].yearTo">
					                            	<option value="${innovativeActivityDetails.yearTo}">${innovativeActivityDetails.yearTo}</option>
					                               	<option value="2018">2018</option>
													<option value="2019">2019</option>
													<option value="2020">2020</option>
													<option value="2021">2021</option>
													<option value="2022">2022</option>
			                              	</select>
                                       	</td>
										<td> 
												<input type="file" ${innovativeActivityDetails.id} name="innovativeActivityDetails[${count.index}].file" id="file${innovativeActivityDetails.id}" onclick='pathImage("${innovativeActivityDetails.fileLocation}","${innovativeActivityDetails.fileName}");' >
												<input type="button" value="Download File" class="btn bg-grey waves-effect delete${innovativeActivityDetails.id}" onclick='showImage("${innovativeActivityDetails.fileLocation}","${innovativeActivityDetails.fileName}");' />
										</td>
										 	<c:if test = "${fn:containsIgnoreCase(userTypeSwitch, 'M')}">
										 	<td><c:choose>
													<c:when test="${innovativeActivityDetails.isApproved}">
														<input type="checkbox" name="innovativeActivityDetails[${count.index}].isApproved"  checked="checked" Class="form-control">
													</c:when>
													<c:otherwise>
														<input type="checkbox" name="innovativeActivityDetails[${count.index}].isApproved"  Class="form-control">
													</c:otherwise>
												</c:choose>
											</td>
										   </c:if>
										   <td><input type="text"  name="innovativeActivityDetails[${count.index}].remarks" value="${innovativeActivityDetails.remarks}" onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9 ]/g,'');" Class="form-control" rows="2" cols="4" maxlength="1000" /></td>
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
										  <c:if test = "${fn:containsIgnoreCase(userTypeSwitch, 'S')}">
										 	<td><input id="delete${innovativeActivityDetails.id}" type="button" value="Delete" class="btn bg-red waves-effect"   onclick='toDelete("${innovativeActivityDetails.id}","${innovativeActivityDetails.fileLocation}","${innovativeActivityDetails.fileName}");'/></td>
										 </c:if>
									</tr>
										<input type="hidden" name="innovativeActivityId" value="${innovativeActivity.innovativeActivityId}">
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
										</c:forEach>
										</c:if>
									 </c:forEach>
									 <c:if test="${empty innovativeAcitivityList}">
										<tr id="newRow">
										<td><input name="innovativeActivityDetails[0].activityName" id="activityNameId" Class="form-control" required="required" onkeyup="this.value=this.value.replace(/[^a-zA-Z ]/,'');" placeholder="Enter Activity Name" maxlength="200"/></td>
										<td><input id="fundsName" oninput="validity.valid||(value='');" onKeyPress="if(this.value.length==7) return false;" name="innovativeActivityDetails[0].fundsName" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" Class="form-control Align-Right" required="required" placeholder="Enter Funds" type="text" maxlength="12"/></td>
										<td><input name="innovativeActivityDetails[0].aboutActivity"  Class="form-control" required="required" onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9 ]/,'');" placeholder="Enter Brief About Activity" maxlength="250"/></td>
										<td><select required="required" id="yearOne_1" class="form-control" onchange='validateYear("1");' name="innovativeActivityDetails[0].yearFrom">
				                            		<option value=""> From Year</option>
				                               		<option value="2018">2018</option>
													<option value="2019">2019</option>
													<option value="2020">2020</option>
													<option value="2021">2021</option>
													<option value="2022">2022</option>
			                              	</select>
                                       	</td>
                                       	<td><select required="required" id="yearTwo_1" onchange='validateYear("1");' class="form-control" name="innovativeActivityDetails[0].yearTo">
					                            	<option value=""> To Year </option>
					                               	<option value="2018">2018</option>
													<option value="2019">2019</option>
													<option value="2020">2020</option>
													<option value="2021">2021</option>
													<option value="2022">2022</option>
			                              	</select>
                                       	</td>
										<td><input type="file" name="innovativeActivityDetails[0].file" required="required" id="file"><br/></td>
										<td><input type="text" name="innovativeActivityDetails[0].remarks" required="required" Class="form-control" rows="2" cols="4" maxlength="1000"/></td>
										<td><input type="button" value="Delete" class="btn bg-red waves-effect"/></td>
									</tr>
										</c:if>
										<tr>
											<td colspan="10"></td>
										</tr>
								</tbody>
							</table>
							
							<table class="table table-bordered" id="myTable">
									<tr>
										<td><spring:message  text="Total Funds" htmlEscape="true" /></td>
										<td><input type="text" id="subTotal" value="${totalFundToCalc}" disabled="disabled" Class="form-control Align-Right"/></td>
									</tr>	
									 <tr>
										<c:forEach var="innovativeActivity" items="${innovativeAcitivityList}">
										<c:if test="${not empty innovativeAcitivityList}">
										<td><spring:message  text="Additional Requirement" htmlEscape="true" /></td>
										<input type="hidden" name="innovativeActivityId" value="${innovativeActivity.innovativeActivityId}">
										 <c:set var="addtnlReqrmnt" value="${addtnlReqrmnt + innovativeActivity.additioinalRequirements}"></c:set>
										<td><input min="0" type="text" oninput="validity.valid||(value='');" onKeyPress="if(this.value.length==7) return false;" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" name="additioinalRequirements" id="additioinalRequirements"  value="${innovativeActivity.additioinalRequirements}" maxlength="15"  Class="form-control Align-Right" placeholder="<= 25% of Total"/></td>
										</c:if>
										
										</c:forEach>
									</tr>
									
										<c:if test="${empty innovativeAcitivityList}">
									<tr>
										<td><spring:message text="Additional Requirement" htmlEscape="true" /></td>
										<td><input required="required" type="text" min="0" oninput="validity.valid||(value='');" onKeyPress="if(this.value.length==7) return false;" name="additioinalRequirements" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" id="additioinalRequirements"  Class="form-control Align-Right" placeholder="<= 25% of Total" maxlength="15"/></td>
									</tr>
										</c:if>
									<tr>
										<td><spring:message  text="Total Proposed Fund" htmlEscape="true" /></td>
										<td><input type="text" id="grandTotal" value="${addtnlReqrmnt + totalFundToCalc}"  disabled="disabled" Class="form-control Align-Right"/></td>
									</tr>
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
						<div class="form-group text-right">
						 <c:if test="${Plan_Status eq true}"> 
						<c:if test="${innovativeAcitivityList[0].isFreeze == true}">
							<button type="button" id="save" disabled="disabled" onclick ="saveSubmit();" class="btn bg-green waves-effect">
								<spring:message text="SAVE" htmlEscape="true" />
							</button>
							
							<button type="button" id="unfreeze" onclick='freezUnfreez("Unf");' class="btn bg-green waves-effect">
								<spring:message code="Label.UNFREEZE" text="Unfreeze" htmlEscape="true" />
							</button>
							
							<button type="button" id="clear" disabled="disabled" 
								class="btn bg-light-blue waves-effect">
								<spring:message code="Label.CLEAR" htmlEscape="true" />
							</button>
						</c:if>		
						<c:if test="${innovativeAcitivityList[0].isFreeze == false}">
							<button type="button" id="save" onclick="validate(); saveSubmit();" class="btn bg-green waves-effect save-button">
								<spring:message text="SAVE" htmlEscape="true" />
							</button>
							
							<button type="button" id="freeze" onclick='freezUnfreez("Frz");' class="btn bg-green waves-effect">
								<spring:message code="Label.FREEZE" text="Freeze" htmlEscape="true" />
							</button>
							
							<button type="button" id="clear" 
								class="btn bg-light-blue waves-effect reset">
								<spring:message code="Label.CLEAR" htmlEscape="true" />
							</button>
						</c:if>
						</c:if>
							<c:if test="${ not empty innovativeAcitivityList}">
							<button type="button"
								onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
								class="btn bg-orange waves-effect">
								<spring:message code="Label.CLOSE" htmlEscape="true" />
							</button>
							</c:if>
						</div>
						<c:if test="${empty innovativeAcitivityList}">
						<div class="form-group text-right">
						 <c:if test="${Plan_Status eq true}"> 
						<button type="submit" id="submit" class="btn bg-green waves-effect" >
								<spring:message text="SAVE" htmlEscape="true" />
							</button>
 					
						<%-- <button type="button" id="freeze"  class="btn bg-green waves-effect">
								<spring:message code="Label.FREEZE" text="Freeze" htmlEscape="true" />
							</button> --%>
							
							<button type="button" id="clear"  
								class="btn bg-light-blue waves-effect">
								<spring:message code="Label.CLEAR" htmlEscape="true" />
							</button>
							</c:if>
							<button type="button"
								onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
								class="btn bg-orange waves-effect">
								<spring:message code="Label.CLOSE" htmlEscape="true" />
							</button>
						</div>
						</c:if>
						</div>
					</form:form>
					</div>
				</div>
				</div>
			</div>
		</div>
</section>
<script type="text/javascript">
function showUpload(){
	if(document.getElementById("check").checked){
		$("#fileUploadId").css("display","block")
		$("#uploadCheckId").css("display","none")}
	else {
		$("#fileUploadId").css("display","none")
		$("#uploadCheckId").css("display","block")
	}
}
</script>
<style>
.Align-Right{
			text-align: right;
              }
</style>