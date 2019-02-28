<html>
<head>

<%@include file="../taglib/taglib.jsp"%>

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
	var myBoolean = document.getElementById("isFreeze").value;
	if(myBoolean == "true"){
		 $("input").prop('disabled', true);
		 $("select").prop('disabled', true);
		 $("#saveButtn").prop('disabled', true);
		 $("#frzButtn").hide();
		 $("#addNewRowBtn").hide();
		 $("#unFrzButtn").show();
		 $("#clearButtn").prop('disabled', true);
	 }
	
	if(myBoolean == "false"){
		 $("input").prop('disabled', false);
		 $("select").prop('disabled', false);
		 $("#saveButtn").prop('disabled', false);
		 $("#frzButtn").show();
		 $("#unFrzButtn").hide();
		 $("#clearButtn").prop('disabled', false);
	 }
	
	$("#mytable").on('input',$("#fundsName"), function () {
		var calculated_total_sum = 0;
		
		$("#mytable,#fundsName").each(function () {
			var get_textbox_value = $(this).val();
			if ($.isNumeric(get_textbox_value)) {
			calculated_total_sum += parseFloat(get_textbox_value);
		}	
		});
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
	
	 if($('#userTypeId').val() =='M'){
		 $("input:not(.exclud)").prop("disabled", true);
		 $("select").prop('disabled', true);
	 }
	 if($('#userTypeId').val() =='C'){
		 $("input:not(.exclud)").prop("disabled", true);
		 $("select").prop('disabled', true);
	 }
}); 

$('document').ready(function(){
	$(".reset").bind("click", function() {
	  $("input[type=text]").val('');
	});
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
	
	
function addNewRow(){
	
	var rowCount = $('#mytable tr').length;
	var i = rowCount-2;
	var sno = rowCount-1;
	var tds = '<tr>';
		tds+='<td>'+sno+'</td>';
		tds+='<td><input name="incomeEnhancementDetails['+i+'].activtyName" id="activityNameId" required="required" maxlength="200" type="text" class="form-control letters"/></td>';
		
		tds+='<td><select required="required" class="form-control" name="incomeEnhancementDetails['+i+'].fundSourceCode"><option value=""> Select </option><c:forEach items="${schemeMasterList}" var="obj"><option value="${obj.schemeId}">${obj.schemeName}</option> </c:forEach></select></td>';
		tds+='<td><select required="required" class="form-control dId" onchange="callBlockList('+i+');" id="districtId'+i+'" name="incomeEnhancementDetails['+i+'].districtCode"><option value=""> Select </option><c:forEach items="${districtList}" var="dlist"><option value="${dlist.districtCode}">${dlist.districtNameEnglish}</option></c:forEach>	</select></td>';
		tds+='<td><select required="required" class="form-control bId" id="blockId'+i+'" name="incomeEnhancementDetails['+i+'].blockCode"><option value="-1"> Select </option></select></td>';
		tds+='<td><input type="text" min="1" oninput="validity.valid||(value="");" onKeyPress="if(this.value.length==3) return false;" required="required" name="incomeEnhancementDetails['+i+'].totalNoOfGpCovered" id="noOfGpCoveredId_'+i+'" class="form-control Align-Right numbers"/></td>';
		tds+='<td><input type="text" min="1" oninput="validity.valid||(value="");" onKeyPress="if(this.value.length==3) return false;" required="required" name="incomeEnhancementDetails['+i+'].noOfAspirationalGp" id="aspirationalGpId_'+i+'" onkeyup="calculateAspirationalGPs('+i+')" class="form-control Align-Right numbers"/></td>';
		tds+='<td><select required="required" class="form-control" id="yearOne_'+i+'" onchange="validateYear('+i+');"  name="incomeEnhancementDetails['+i+'].yearFrom"><option value=""> From Year</option><option value="2018">2018</option><option value="2019">2019</option><option value="2020">2020</option><option value="2021">2021</option><option value="2022">2022</option></select></td>';
		tds+='<td><select required="required" class="form-control" id="yearTwo_'+i+'" onchange="validateYear('+i+');" name="incomeEnhancementDetails['+i+'].yearTo"><option value=""> To Year </option><option value="2018">2018</option><option value="2019">2019</option><option value="2020">2020</option><option value="2021">2021</option><option value="2022">2022</option></select></td>';
		tds+='<td><input type="text" onKeyPress="if(this.value.length==7) return false;" min="1" name="incomeEnhancementDetails['+i+'].totalCostOfProject" required="required" class="form-control Align-Right numbers"/></td>';
		tds+='<td><input type="text" oninput="validity.valid||(value="");" onKeyPress="if(this.value.length==7) return false;" id="fundsName" min="1" name="incomeEnhancementDetails['+i+'].fundsRequired" required="required" class="form-control Align-Right numbers"/></td>';
		tds+='<td><input type="text" name="incomeEnhancementDetails['+i+'].briefAboutActivity" required="required" maxlength="1000" class="form-control alphaonly"/></td>';
		tds+='<td><input type="file" name="incomeEnhancementDetails['+i+'].file"/></td>';
		tds+='<td><input type="checkbox" name="incomeEnhancementDetails['+i+'].planApprovedByDpc" class="form-control"/></td>';
		tds+='<td><input type="button" value="Delete" onclick="deleteRow();" class="btn bg-red waves-effect"/></td>'
								
	tds += '</tr>';
	i++;
	$('#mytable tr:last').after(tds);
	regexValidation();
}
function deleteRow(){
	if($('#mytable tr').length>2){
		$('#mytable tr:last').remove();
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
</script>

</head>
    <section class="content">
        <div class="container-fluid">
            <div class="block-header">
            </div>
            
            <div class="row clearfix">
                <!-- Task Info -->
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="card">
                        <div class="header">
                            <h2>Project based support for Income Development & Income Enhancement</h2>
                        </div>
                        <div class="body">
                            <form:form method="POST" id="incomeEnhancementId" name="incomeEnhancement" class="form-inline" action="incomeEnhancementAdd.html" modelAttribute="Income_Enhancement" enctype="multipart/form-data">
                           <input type="hidden" name="<csrf:token-name/>" value="<csrf:token-value uri="incomeEnhancementAdd.html"/>" />
                            <div class="table-responsive">
                            <c:if test="${fn:containsIgnoreCase(dbActivitiesList.userType,'S')}">
                            <button type="button" id="addNewRowBtn" class="btn bg-green" onclick="addNewRow()">Add New Row</button>
                            </c:if>
                                <table class="table table-bordered" id="mytable">
                                    <thead>
                                        <tr>
                                        	<th rowspan="2">S.No.</th>
                                        	<th rowspan="2">Name of the Activity</th>
                                        	<!-- <th rowspan="2">Select Ministry/Scheme</th> -->
                                        	<th rowspan="2"><div align="center">Select Scheme</div></th>
                                        	<th rowspan="2">District Name</th>
                                        	<th rowspan="2">Block Name</th>
                                        	<th rowspan="2">Total No. of GP's Covered</th>
                                        	<th rowspan="2">No. of Aspirational GPs</th>
                                        	<th colspan="2">Time Frame of project(year wise)</th>
                                        	<th rowspan="2">Total cost of project</th>
                                        	<th rowspan="2">Funds Proposed in current year</th>
                                        	<th rowspan="2">Brief about the Activity</th>
                                        	<th rowspan="2">Upload File(PDF)</th>
                                        	<th rowspan="2">Plan approved by DPC</th>
                                        	<c:if test="${fn:containsIgnoreCase(dbActivitiesList.userType,'S')}">
                                        		<th rowspan="2">Delete</th>
                                        	</c:if>
                                        	<c:if test="${fn:containsIgnoreCase(dbActivitiesList.userType,'M')}">
	                                        	<th rowspan="2">Is Approved</th>
	                                        	<th rowspan="2">Remarks</th>
                                        	</c:if>
                                        	<c:if test="${fn:containsIgnoreCase(dbActivitiesList.userType,'C')}">
	                                        	<th rowspan="2">Is Approved</th>
	                                        	<th rowspan="2">Remarks</th>
                                        	</c:if>
                                        </tr>
                                        <tr>
	                                        <th>From </th>
	                                        <th> To</th>
                                        </tr>
                                        
                                    </thead>
                                    <tbody>
                                    <c:if test="${empty dbActivitiesList}">
                                    <tr>
                                       	<td>1</td>
                                       	<td><input name="incomeEnhancementDetails[0].activtyName" id="activityNameId" required="required" onkeyup="this.value=this.value.replace(/[^a-zA-Z ]/,'');" maxlength="200" type="text" class="form-control"/></td>
                                       	<!-- <td>
                                       		<select required="required" class="form-control" name="incomeEnhancementDetails[0].fundSourceType">
				                            	<option value=""> Select </option>
				                               	<option value="M">Ministry</option>
				                                <option value="S">Scheme</option>
			                              	</select>
			                            </td> -->
                                       	<td>
                                       		<select required="required" class="form-control" name="incomeEnhancementDetails[0].fundSourceCode">
						                            	<option value=""> Select </option>
		                                       	<c:forEach items="${schemeMasterList}" var="obj">
						                               	<option value="${obj.schemeId}">${obj.schemeName}</option>
						                         </c:forEach>
			                              	</select>
                                       	</td>
                                       	<td>
											<select required="required" class="form-control dId" onchange='callBlockList("0");' id="districtId0" name="incomeEnhancementDetails[0].districtCode">
					                            	<option value=""> Select </option>
												<c:forEach items="${districtList}" var="dlist">
					                               	<option value="${dlist.districtCode}">${dlist.districtNameEnglish}</option>
				                               	</c:forEach>
			                              	</select>
                                       	</td>
                                    	<td>
                                    		<select required="required" class="form-control bId" id="blockId0" name="incomeEnhancementDetails[0].blockCode">
					                            	<option value="-1"> Select </option>
			                              	</select>
			                            </td>  
                                        <td><input type="text" oninput="validity.valid||(value='');" onKeyPress="if(this.value.length==3) return false;" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" min="1" required="required" name="incomeEnhancementDetails[0].totalNoOfGpCovered" id="noOfGpCoveredId_0" class="form-control Align-Right"/></td>
                                       	<td><input type="text" oninput="validity.valid||(value='');" onKeyPress="if(this.value.length==3) return false;" min="1" required="required" name="incomeEnhancementDetails[0].noOfAspirationalGp" id="aspirationalGpId_0" onkeyup="this.value=this.value.replace(/[^0-9]/g,'') ; calculateAspirationalGPs(0)" class="form-control Align-Right"/></td>
                                       	<td><select required="required" id="yearOne_1" class="form-control" onchange='validateYear("1");' name="incomeEnhancementDetails[0].yearFrom">
				                            		<option value=""> From Year</option>
				                               		<option value="2018">2018</option>
													<option value="2019">2019</option>
													<option value="2020">2020</option>
													<option value="2021">2021</option>
													<option value="2022">2022</option>
			                              	</select>
                                       	</td>
                                       	<td><select required="required" id="yearTwo_1" onchange='validateYear("1");' class="form-control" name="incomeEnhancementDetails[0].yearTo">
					                            	<option value=""> To Year </option>
					                               	<option value="2018">2018</option>
													<option value="2019">2019</option>
													<option value="2020">2020</option>
													<option value="2021">2021</option>
													<option value="2022">2022</option>
			                              	</select>
                                       	</td>
	                                       	<td><input type="text" oninput="validity.valid||(value='');" onKeyPress="if(this.value.length==7) return false;" min="1" name="incomeEnhancementDetails[0].totalCostOfProject" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" required="required" class="form-control Align-Right"/></td>
	                                        <td><input type="text" oninput="validity.valid||(value='');" onKeyPress="if(this.value.length==5) return false;" min="1" max="50000" id="fundsName" name="incomeEnhancementDetails[0].fundsRequired" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" required="required" class="form-control Align-Right Align-Right"/></td>
	                                        <td><input type="text" name="incomeEnhancementDetails[0].briefAboutActivity" onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9 ]/g,'');" required="required" maxlength="1000" class="form-control"/></td>
	                                       	<td><input type="file" name="incomeEnhancementDetails[0].file"/></td>
	                                       	<td><input type="checkbox" name="incomeEnhancementDetails[0].planApprovedByDpc"  class="form-control"/></td>
	                                       	<td><input type="button" value="Delete" class="btn" onclick='toDelete("${incomeEnhancementDetails.id}","${incomeEnhancementDetails.fileLocation}","${incomeEnhancementDetails.fileName}");'/></td>
                                 </tr>
                                       	<input type="hidden" name="setBlockId" />
                           </c:if>
                        <c:if test="${not empty dbActivitiesList}">
                           <c:forEach items="${dbActivitiesList.incomeEnhancementDetails}" var="dblist" varStatus="count">
                                    <tr>
                                       	<td>${count.count}</td>
                                       	<td><input name="incomeEnhancementDetails[${count.index}].activtyName" id="activityNameId" value="${dblist.activtyName}" required="required" onkeyup="this.value=this.value.replace(/[^a-zA-Z ]/,'');" maxlength="200" type="text" class="form-control"/></td>
                                       	<%-- <td>
                                       	
                                       	<c:set value="${dblist.fundSourceType}" var="stype"></c:set>
                                       		<select required="required" class="form-control"  name="incomeEnhancementDetails[${count.index}].fundSourceType">
				                               	<option value="M" <c:if test="${fn:containsIgnoreCase(stype,'M')}"> selected="selected"</c:if> >Ministry</option>
				                                <option value="S" <c:if test="${fn:containsIgnoreCase(stype,'S')}"> selected="selected"</c:if> >Scheme</option>
			                              	</select>
			                            </td> --%>
                                       	<td>
                                       		<select required="required" class="form-control" name="incomeEnhancementDetails[${count.index}].fundSourceCode">
		                                       	<c:forEach items="${schemeMasterList}" var="scm">
		                                       		<c:choose>
		                                       			<c:when test="${dblist.fundSourceCode == scm.schemeId}">
		                                       				<option value="${scm.schemeId}" selected="selected">${scm.schemeName}</option>
		                                       			</c:when>
		                                       			<c:otherwise>
		                                       				<option value="${scm.schemeId}">${scm.schemeName}</option>
		                                       			</c:otherwise>
		                                       		</c:choose>
						                         </c:forEach>
			                              	</select>
                                       	</td>
                                       	<td>
											<select required="required" class="form-control dId" onchange='callBlockList("${count.index}");' id="districtId${count.index}" name="incomeEnhancementDetails[${count.index}].districtCode">
												<c:forEach items="${districtList}" var="dlist">
													<c:choose>
		                                       			<c:when test="${dblist.districtCode == dlist.districtCode}">
						                               		<option value="${dlist.districtCode}" selected="selected">${dlist.districtNameEnglish}</option>
						                               	</c:when>
						                               	<c:otherwise>
						                               		<option value="${dlist.districtCode}" >${dlist.districtNameEnglish}</option>
						                               	</c:otherwise>
						                            </c:choose>
				                               	</c:forEach>
				                               	
			                              	</select>
                                       	</td>
                                    	<td>
                                    		<select required="required" class="form-control bId" id="blockId${count.index}" name="incomeEnhancementDetails[${count.index}].blockCode">
					                            	<%-- <c:forEach items="${blockFromDb}" var="obj"> --%>
					                            	<c:forEach items="${dblist.blockListFromDb}" var="obj">
					                            		<c:choose>
					                            			<c:when test="${obj.blockCode == dblist.blockCode}">
					                            				<option value="${obj.blockCode}" selected="selected"> ${obj.blockNameEnglish}</option>
					                            			</c:when>
					                            			<c:otherwise>
					                            				<option value="${obj.blockCode}"> ${obj.blockNameEnglish}</option>
					                            			</c:otherwise>
					                            		</c:choose>
					                            	</c:forEach>
			                              	</select>
			                            </td>
                                        <td><input type="text" oninput="validity.valid||(value='');" min="1" onKeyPress="if(this.value.length==3) return false;" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" required="required" value="${dblist.totalNoOfGpCovered}" name="incomeEnhancementDetails[${count.index}].totalNoOfGpCovered" id="noOfGpCoveredId_${count.index}" class="form-control Align-Right"/></td>
                                       	<td><input type="text" oninput="validity.valid||(value='');" min="1" onKeyPress="if(this.value.length==3) return false;" onkeyup="this.value=this.value.replace(/[^0-9]/g,''); calculateAspirationalGPs(${count.index})" required="required" value="${dblist.noOfAspirationalGp}" name="incomeEnhancementDetails[${count.index}].noOfAspirationalGp" id="aspirationalGpId_${count.index}" class="form-control Align-Right"/></td>
                                       	<td><select required="required" id="yearOne_${count.index}" class="form-control" onchange='validateYear("${count.index}");' name="incomeEnhancementDetails[${count.index}].yearFrom">
				                            		<option value="${dblist.yearFrom}">${dblist.yearFrom}</option>
				                               		<option value="2018">2018</option>
													<option value="2019">2019</option>
													<option value="2020">2020</option>
													<option value="2021">2021</option>
													<option value="2022">2022</option>
			                              	</select>
                                       	</td>
                                       	<td><select required="required" id="yearTwo_${count.index}" onchange='validateYear("${count.index}");' class="form-control" name="incomeEnhancementDetails[${count.index}].yearTo">
					                            	<option value="${dblist.yearTo}">${dblist.yearTo}</option>
					                               	<option value="2018">2018</option>
													<option value="2019">2019</option>
													<option value="2020">2020</option>
													<option value="2021">2021</option>
													<option value="2022">2022</option>
			                              	</select>
                                       	</td>
	                                       	<td><input type="text" oninput="validity.valid||(value='');" onKeyPress="if(this.value.length==7) return false;" min="1" value="${dblist.totalCostOfProject}" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" name="incomeEnhancementDetails[${count.index}].totalCostOfProject" required="required" class="form-control Align-Right"/></td>
	                                       <c:set var="totalFundToCalc" value="${totalFundToCalc + dblist.fundsRequired}"></c:set>
	                                        <td><input type="text" oninput="validity.valid||(value='');" onKeyPress="if(this.value.length==5) return false;" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" min="1" max="50000" value="${dblist.fundsRequired}" id="fundsName"  name="incomeEnhancementDetails[${count.index}].fundsRequired" required="required" class="form-control Align-Right exclud"/></td>
	                                        <td><input type="text" value="${dblist.briefAboutActivity}" name="incomeEnhancementDetails[${count.index}].briefAboutActivity" onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9 ]/,'');" required="required" maxlength="1000" class="form-control"/></td>
	                                       	<td><input type="file" name="incomeEnhancementDetails[${count.index}].file"/>
	                                       	<button type="button" value="Download File" class="btn bg-grey waves-effect" onclick='showImage("${dblist.fileLocation}","${dblist.fileName}");' />Download File</button></td>
	                                       	<td><c:choose>
														<c:when test="${dblist.planApprovedByDpc}">
															<input type="checkbox" name="incomeEnhancementDetails[${count.index}].planApprovedByDpc"  checked="checked" Class="form-control">
														</c:when>
														<c:otherwise>
															<input type="checkbox" name="incomeEnhancementDetails[${count.index}].planApprovedByDpc"  Class="form-control">
														</c:otherwise>
													</c:choose>
	                                       	</td>
	                                       	<c:if test="${fn:containsIgnoreCase(dbActivitiesList.userType,'S')}">
	                                       		<td><input type="button" value="Delete" class="btn bg-red waves-effect" onclick='toDelete("${dblist.incomeEnhancementDetailsId}","${dblist.fileLocation}","${dblist.fileName}");'/></td>
	                                       	</c:if>
	                                       	<c:if test="${fn:containsIgnoreCase(dbActivitiesList.userType,'M')}">
		                                     <td><c:choose>
														<c:when test="${dblist.isApproved}">
															<input type="checkbox" name="incomeEnhancementDetails[${count.index}].isApproved"  checked="checked" Class="form-control exclud">
														</c:when>
														<c:otherwise>
															<input type="checkbox" name="incomeEnhancementDetails[${count.index}].isApproved"  Class="form-control exclud">
														</c:otherwise>
													</c:choose>
											</td>
		                                       	<td><input type="text"  name="incomeEnhancementDetails[${count.index}].remarks" value="${dblist.remarks}" onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9 ]/g,'');" Class="form-control exclud" rows="2" cols="4" maxlength="1000" /></td>
	                                       	</c:if>
	                                       	<c:if test="${fn:containsIgnoreCase(dbActivitiesList.userType,'C')}">
		                                     <td><c:choose>
														<c:when test="${dblist.isApproved}">
															<input type="checkbox" name="incomeEnhancementDetails[${count.index}].isApproved"  checked="checked" Class="form-control exclud">
														</c:when>
														<c:otherwise>
															<input type="checkbox" name="incomeEnhancementDetails[${count.index}].isApproved"  Class="form-control exclud">
														</c:otherwise>
													</c:choose>
											</td>
		                                       	<td><input type="text"  name="incomeEnhancementDetails[${count.index}].remarks" value="${dblist.remarks}" onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9 ]/g,'');" Class="form-control exclud" rows="2" cols="4" maxlength="1000" /></td>
	                                       	</c:if>
                                 </tr>
                                       	<input type="hidden" name="setBlockId" />
                                        <input type="hidden" name="incomeEnhancementDetails[${count.index}].incomeEnhancementDetailsId" value="${dblist.incomeEnhancementDetailsId}"/>
                                        <input type="hidden" name="incomeEnhancementDetails[${count.index}].fileName" value="${dblist.fileName}">
										<input type="hidden" name="incomeEnhancementDetails[${count.index}].fileContentType" value="${dblist.fileContentType}">
										<input type="hidden" name="incomeEnhancementDetails[${count.index}].fileLocation" value="${dblist.fileLocation}">
                       </c:forEach>
                                       		</c:if>
                                    </tbody>
                                </table><br><br><br><br><br><br>
                            </div>
                            <br/>
                            <table class="table table-bordered" id="myTable">
                            		<tr>
			                            <td>Funds</td>
			                            <td><input type="text" id="subTotal" value="${totalFundToCalc}" Class="form-control Align-Right" readonly="readonly"></td>
		                            </tr>
		                            <tr>
		                            <td>Additional Requirements</td>
		                            <c:set var="addtnlReqrmnt" value="${addtnlReqrmnt + dbActivitiesList.additionalRequirement}"></c:set>
		                             <td><input type="text" oninput="validity.valid||(value='');" onKeyPress="if(this.value.length==7) return false;" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="${dbActivitiesList.additionalRequirement}" min="1" name="additionalRequirement" id="additioinalRequirements" Class="form-control Align-Right exclud" required="required"></td>
		                            </tr>
		                            <tr>
		                            <td>Total Proposed Funds</td>
		                           <td><input type="text" id="grandTotal" value="${addtnlReqrmnt + totalFundToCalc}" Class="form-control Align-Right" readonly="readonly"></td>
	                           	</tr>
	                         </table>
	                           	<input type="hidden" name="incomeEnhancementId" value="${dbActivitiesList.incomeEnhancementId}" />
	                           	<input type="hidden" name="isFreeze" id="isFreeze" value="${dbActivitiesList.isFreeze}" />
	                           	<input type="hidden" name="userType" id="userTypeId" value="${dbActivitiesList.userType}">
	                            <input type="hidden" name="idToDelete" id="idToDelete" >
								<input type="hidden" name="path" id="path" > 
								<input type="hidden" name="dbFileName" id="dbFileName" >
                              <div class="form-group text-right">
                                    <button type="submit" id="saveButtn" onclick="$('input,select').prop('disabled', false);" class="btn bg-green waves-effect">SAVE</button>
                               		<button type="button" id="frzButtn" onclick="toFreeze();" class="btn bg-green waves-effect">FREEZE</button>
	                                <button type="button" id="unFrzButtn" onclick="toFreeze();" class="btn bg-green waves-effect">UNFREEZE</button>                                	
                                	<button type="button" id="clearButtn" class="btn bg-light-blue waves-effect reset">CLEAR</button>
                                	<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"  class="btn bg-orange waves-effect">CLOSE</button>
                               </div>
                           </form:form>     
                        </div>
                    </div>
                </div>
                <!-- #END# Task Info -->
            </div>
        </div>
    </section>
    </html>
<style>
.Align-Right{
			text-align: right;
              }
</style>