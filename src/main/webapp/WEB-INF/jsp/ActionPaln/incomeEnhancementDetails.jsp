<html>
<head>

<%@include file="../taglib/taglib.jsp"%>
<script
	src="<%=request.getContextPath()%>/resources/plugins/jquery/jquery.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/bs/slimscroll/jquery.slimscroll.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/bs/slimscroll/HorScroll.js"></script>
<script type="text/javascript">
var deleteFile =new Map();
var delTrainingIdArr=[];
var finalDetailArr=[];
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
		 $("#saveButtn").prop('disabled', true);
		 $("#saveButtn").hide();
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
		 $("#saveButtn").show();
		 $("#unFrzButtn").hide();
		 $("#clearButtn").prop('disabled', false);
	 }
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



function saveSubmit(){
	
	 $.each( delTrainingIdArr, function( index, value ) {
    	fname=deleteFile.get(value);
    	finalDetailArr.push(value+"@"+fname);
	});
	 
	document.getElementById("dbFileName").value = finalDetailArr.toString();
	document.getElementById("path").value = '${incomeEnhancementDetails.fileLocation}';
	
	document.incomeEnhancement.method = "post";
	document.incomeEnhancement.action = "incomeEnhancementAdd.html?<csrf:token uri='incomeEnhancementAdd.html'/>";
	document.incomeEnhancement.submit();
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
		tds+='<td><input name="incomeEnhancementDetails['+i+'].activtyName" id="activityNameId" placeholder="Activity Name" required="required" maxlength="200" type="text" class="form-control letters"/></td>';
		
		tds+='<td><select required="required" class="form-control" name="incomeEnhancementDetails['+i+'].fundSourceCode"><option value="0">Select Scheme</option><c:forEach items="${schemeMasterList}" var="obj"><option value="${obj.schemeId}">${obj.schemeName}</option> </c:forEach></select></td>';
		tds+='<td><select required="required" class="form-control dId" onchange="callBlockList('+i+');" id="districtId'+i+'" name="incomeEnhancementDetails['+i+'].districtCode"><option value="0"> Select District </option><c:forEach items="${districtList}" var="dlist"><option value="${dlist.districtCode}">${dlist.districtNameEnglish}</option></c:forEach>	</select></td>';
		tds+='<td><select required="required" class="form-control bId" id="blockId'+i+'" name="incomeEnhancementDetails['+i+'].blockCode"><option value="-1"> Select Block </option></select></td>';
		tds+='<td><input type="text" min="1" oninput="validity.valid||(value="");" onKeyPress="if(this.value.length==3) return false;" required="required" placeholder="Total GP\'s covered" name="incomeEnhancementDetails['+i+'].totalNoOfGpCovered" id="noOfGpCoveredId_'+i+'"  onkeyup="calculateAspirationalGPs('+i+')" class="form-control Align-Right numbers"/></td>';
		tds+='<td><input type="text" min="1" oninput="validity.valid||(value="");" onKeyPress="if(this.value.length==3) return false;" required="required" placeholder="Total Aspirational GP" name="incomeEnhancementDetails['+i+'].noOfAspirationalGp" id="aspirationalGpId_'+i+'" onkeyup="calculateAspirationalGPs('+i+')" class="form-control Align-Right numbers"/></td>';
		tds+='<td><select required="required" class="form-control" id="yearOne_'+i+'" onchange="validateYear('+i+');"  name="incomeEnhancementDetails['+i+'].yearFrom"><option value=""> From Year</option><option value="2018">2018</option><option value="2019">2019</option><option value="2020">2020</option><option value="2021">2021</option><option value="2022">2022</option></select></td>';
		tds+='<td><select required="required" class="form-control" id="yearTwo_'+i+'" onchange="validateYear('+i+');" name="incomeEnhancementDetails['+i+'].yearTo"><option value=""> To Year </option><option value="2018">2018</option><option value="2019">2019</option><option value="2020">2020</option><option value="2021">2021</option><option value="2022">2022</option></select></td>';
		tds+='<td><input type="text" onKeyPress="if(this.value.length==7) return false;" min="1" name="incomeEnhancementDetails['+i+'].totalCostOfProject" placeholder="Total Project cost" required="required" class="form-control Align-Right numbers"/></td>';
		tds+='<td><input type="text" oninput="validity.valid||(value="");" onKeyPress="if(this.value.length==7) return false;" id="fundsName" min="1" placeholder="Fund Proposed" name="incomeEnhancementDetails['+i+'].fundsRequired" required="required" class="form-control Align-Right numbers"/></td>';
		tds+='<td><input type="text" name="incomeEnhancementDetails['+i+'].briefAboutActivity" required="required" maxlength="1000" placeholder="Brief About Activity" class="form-control alphaonly"/></td>';
		tds+='<td><input type="file" name="incomeEnhancementDetails['+i+'].file" /></td>';
		/* tds+='<td><input type="checkbox" name="incomeEnhancementDetails['+i+'].planApprovedByDpc" class="form-control"/></td>'; */
		tds+='<td><label class="container"><input type="checkbox" name="incomeEnhancementDetails['+i+'].planApprovedByDpc"/><span class="checkmark"></span></label></td>';
		tds+='<td><input type="text" name="incomeEnhancementDetails['+i+'].remarks" Class="form-control exclud" rows="2" cols="4" onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9 ]/g,);" maxlength="1000"/></td>'
		/* tds+='<td><input type="button" value="Delete" onclick="deleteRow();" class="btn bg-red waves-effect"/></td>' */
		tds+='<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}"><td></td>';
		tds+='<td></td></c:if>';
		tds+='<td><a href="javascript:deleteRow();"><span class="glyphicon glyphicon-trash"></span></a></td>';
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
	

	 if(!delTrainingIdArr.includes(idToDelete)){
		 delTrainingIdArr.push(idToDelete);
		 $("#delete"+idToDelete).addClass('glyphicon-repeat');
		 $("#delete"+idToDelete).removeClass('glyphicon-trash');
		
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
		 	 
		 	 $("#delete"+idToDelete).removeClass('glyphicon-repeat');
			 $("#delete"+idToDelete).addClass('glyphicon-trash');
			// $("#modifyButtn"+idToDelete).removeClass('not-active');
	  }
	
	//document.getElementById("idToDelete").value = idToDelete;
	//document.getElementById("path").value = path;
	//document.getElementById("dbFileName").value = name;
	//document.incomeEnhancement.method = "post";
	/* document.incomeEnhancement.action = "deleteIncomeEnhancementDtls.html?<csrf:token uri='deleteIncomeEnhancementDtls.html'/>";
	document.incomeEnhancement.submit(); */
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

/* function fetchUrl(vid,path,name){
	
	document.getElementById("path").value = path;
	document.getElementById("dbFileName").value = name;
	document.incomeEnhancement.method = "post";
	var url="viewFileOfIncmEnhncmntActivity.html?<csrf:token uri='viewFileOfIncmEnhncmntActivity.html'/>&path="+path+"&dbFileName="+name;
	
	//document.incomeEnhancement.action = "viewFileOfIncmEnhncmntActivity.html?<csrf:token uri='viewFileOfIncmEnhncmntActivity.html'/>";
	//document.incomeEnhancement.submit();
	//var url="viewFileOfIncmEnhncmntActivity.html?path="+path+"&dbFileName="+name+"<csrf:token uri='viewFileOfIncmEnhncmntActivity.html'/>"
    $("#"+vid).attr("href",url);
} */


</script>
<style type="text/css">
/* By Abhishek Kumar Singh dated 03-01-18 */

/* The container */
.container {
	display: block;
	position: relative;
	padding-left: 65px;
	margin-bottom: 12px;
	cursor: pointer;
	font-size: 22px;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	width: 0px;
}

/* Hide the browser's default checkbox */
.container input {
	position: absolute;
	opacity: 0;
}

/* Create a custom checkbox */
.checkmark {
	position: absolute;
	top: 0;
	left: 30px;
	height: 25px;
	width: 25px;
	background-color: #eee;
}

/* On mouse-over, add a grey background color */
.container:hover input ~ .checkmark {
	background-color: #ccc;
}

/* When the checkbox is checked, add a blue background */
.container input:checked ~ .checkmark {
	background-color: #2196F3;
}

/* Create the checkmark/indicator (hidden when not checked) */
.checkmark:after {
	content: "";
	position: absolute;
	display: none;
}

/* Show the checkmark when checked */
.container input:checked ~ .checkmark:after {
	display: block;
}

/* Style the checkmark/indicator */
.container .checkmark:after {
	left: 9px;
	top: 5px;
	width: 5px;
	height: 10px;
	border: solid white;
	border-width: 0 3px 3px 0;
	-webkit-transform: rotate(45deg);
	-ms-transform: rotate(45deg);
	transform: rotate(45deg);
}

#mytable th {
	text-align: center;
	text-transform: none;
	font-weight: bold;
	color: #FFF;
	background-color: cornflowerblue;
}

.slimScrollRail {
	opacity: 0 !important;
}

input[type="text"]::placeholder {
	/* Firefox, Chrome, Opera */
	text-align: center;
	/* color:#2196F3; */
}
/* select{
	 color: #2196F3 !important;
}
/* select option { color: black; } */
select option:first-child{
  color: #2196F3 !important;
} */
</style>
</head>
<section class="content">
	<div class="container-fluid">
		<div class="block-header"></div>

		<div class="row clearfix">
			<!-- Task Info -->
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="card">
					<div class="header">
						<h2>Project based support for Income Development & Income
							Enhancement</h2>
					</div>
					<div class="body">
						<form:form method="POST" id="incomeEnhancementId"
							name="incomeEnhancement" class="form-inline"
							action="incomeEnhancementAdd.html"
							modelAttribute="Income_Enhancement" enctype="multipart/form-data" onsubmit="disablingSave()">
							<input type="hidden" name="<csrf:token-name/>"
								value="<csrf:token-value uri="incomeEnhancementAdd.html"/>" />
							<div class="table-responsive" id="records">
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
											<th rowspan="2">Remarks</th>
											<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
											<th colspan="2" rowspan="1">
												<div align="center">
													<strong>Previous comment history</strong>
												</div>
											</th>
											</c:if>
											<c:if
												test="${USER_TYPE eq 'S'}">
												<th rowspan="2">Delete</th>
											</c:if>
											<c:if
												test="${USER_TYPE eq 'M' or USER_TYPE eq 'C'}">
												<th rowspan="2">Is Approved</th>
											</c:if>
										</tr>
										<tr>
											<th>From</th>
											<th>To</th>
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
									<tbody>
										<c:if test="${empty dbActivitiesList}">
											<tr>
												<td>1</td>
												<td><input
													name="incomeEnhancementDetails[0].activtyName" placeholder="Activity Name"
													id="activityNameId" required="required"
													onkeyup="this.value=this.value.replace(/[^a-zA-Z ]/,'');"
													maxlength="200" type="text" class="form-control " /></td>
												<!-- <td>
                                       		<select required="required" class="form-control" name="incomeEnhancementDetails[0].fundSourceType">
				                            	<option value=""> Select </option>
				                               	<option value="M">Ministry</option>
				                                <option value="S">Scheme</option>
			                              	</select>
			                            </td> -->
												<td><select required="required" class="form-control"
													name="incomeEnhancementDetails[0].fundSourceCode">
														<option value="" style="color:#2196F3;">Select Scheme</option>
														<c:forEach items="${schemeMasterList}" var="obj">
															<option value="${obj.schemeId}">${obj.schemeName}</option>
														</c:forEach>
												</select></td>
												<td><select required="required"
													class="form-control dId" onchange='callBlockList("0");'
													id="districtId0"
													name="incomeEnhancementDetails[0].districtCode">
														<option value="" style="color:#2196F3;">Select District</option>
														<c:forEach items="${districtList}" var="dlist">
															<option value="${dlist.districtCode}">${dlist.districtNameEnglish}</option>
														</c:forEach>
												</select></td>
												<td><select required="required"
													class="form-control bId" id="blockId0"
													name="incomeEnhancementDetails[0].blockCode">
														<option value="-1" style="color:#2196F3;">Select Block</option>
												</select></td>
												<td><input type="text"
													oninput="validity.valid||(value='');" placeholder="Total GP's covered"
													onKeyPress="if(this.value.length==3) return false;"
													onkeyup="this.value=this.value.replace(/[^0-9]/g,'');calculateAspirationalGPs(0)"
													min="1" required="required"
													name="incomeEnhancementDetails[0].totalNoOfGpCovered"
													id="noOfGpCoveredId_0" class="form-control Align-Right" /></td>
												<td><input type="text" placeholder="Total Aspirational GP"
													oninput="validity.valid||(value='');"
													onKeyPress="if(this.value.length==3) return false;" min="1"
													required="required"
													name="incomeEnhancementDetails[0].noOfAspirationalGp"
													id="aspirationalGpId_0"
													onkeyup="this.value=this.value.replace(/[^0-9]/g,'') ; calculateAspirationalGPs(0)"
													class="form-control Align-Right" /></td>
												<td><select required="required" id="yearOne_1"
													class="form-control" onchange='validateYear("1");'
													name="incomeEnhancementDetails[0].yearFrom">
														<option value="" style="color:#2196F3;">From Year</option>
														<option value="2018">2018</option>
														<option value="2019">2019</option>
														<option value="2020">2020</option>
														<option value="2021">2021</option>
														<option value="2022">2022</option>
												</select></td>
												<td><select required="required" id="yearTwo_1"
													onchange='validateYear("1");' class="form-control"
													name="incomeEnhancementDetails[0].yearTo">
														<option value="" style="color:#2196F3;">To Year</option>
														<option value="2018">2018</option>
														<option value="2019">2019</option>
														<option value="2020">2020</option>
														<option value="2021">2021</option>
														<option value="2022">2022</option>
												</select></td>
												<td><input type="text"
													oninput="validity.valid||(value='');" placeholder="Total Project Cost"
													onKeyPress="if(this.value.length==7) return false;" min="1"
													name="incomeEnhancementDetails[0].totalCostOfProject"
													onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"
													required="required" class="form-control Align-Right" />
												</td>
												<td><input type="text" placeholder="Fund Proposed"
													oninput="validity.valid||(value='');"
													onKeyPress="if(this.value.length==5) return false;" min="1"
													max="50000" id="fundsName"
													name="incomeEnhancementDetails[0].fundsRequired"
													onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"
													required="required"
													class="form-control Align-Right Align-Right" /></td>
												<td><input type="text" placeholder="Brief About Activity"
													name="incomeEnhancementDetails[0].briefAboutActivity"
													onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9 ]/g,'');"
													required="required" maxlength="1000" class="form-control" /></td>
												<td><input type="file"
													name="incomeEnhancementDetails[0].file" /></td>
												<td><label class="container"><input type="checkbox" 
													name="incomeEnhancementDetails[0].planApprovedByDpc"
													 /><span class="checkmark"></span></label></td>
												<%-- <td><input type="button" value="Delete" class="btn" onclick='toDelete("${incomeEnhancementDetails.id}","${incomeEnhancementDetails.fileLocation}","${incomeEnhancementDetails.fileName}");'/></td> --%>
												<td><input type="text"
															name="incomeEnhancementDetails[0].remarks"
															onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9 ]/g,'');"
															Class="form-control exclud" rows="2" cols="4"
															maxlength="1000" /></td>
															
												<td><a id="deleteButtn" class="not-active"
													href='javascript:toDelete("${incomeEnhancementDetails.id}","${incomeEnhancementDetails.fileLocation}","${incomeEnhancementDetails.fileName}");'>
														<span id="delete${incomeEnhancementDetails.id}" class="glyphicon glyphicon-trash"></span>
												</a></td>
												
											</tr>
											<input type="hidden" name="setBlockId" />
										</c:if>
										<c:if test="${not empty dbActivitiesList}">
											<c:forEach
												items="${dbActivitiesList.incomeEnhancementDetails}"
												var="dblist" varStatus="count">
												<tr>
													<td>${count.count}</td>
													<td><input 
														name="incomeEnhancementDetails[${count.index}].activtyName"
														id="activityNameId" value="${dblist.activtyName}"
														required="required"
														onkeyup="this.value=this.value.replace(/[^a-zA-Z ]/,'');"
														maxlength="200" type="text" class="form-control" /></td>
													<%-- <td>
                                       	
                                       	<c:set value="${dblist.fundSourceType}" var="stype"></c:set>
                                       		<select required="required" class="form-control"  name="incomeEnhancementDetails[${count.index}].fundSourceType">
				                               	<option value="M" <c:if test="${fn:containsIgnoreCase(stype,'M')}"> selected="selected"</c:if> >Ministry</option>
				                                <option value="S" <c:if test="${fn:containsIgnoreCase(stype,'S')}"> selected="selected"</c:if> >Scheme</option>
			                              	</select>
			                            </td> --%>
													<td><select required="required" class="form-control"
														name="incomeEnhancementDetails[${count.index}].fundSourceCode">
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
													</select></td>
													<td><select required="required"
														class="form-control dId"
														onchange='callBlockList("${count.index}");'
														id="districtId${count.index}"
														name="incomeEnhancementDetails[${count.index}].districtCode">
															<c:forEach items="${districtList}" var="dlist">
																<c:choose>
																	<c:when
																		test="${dblist.districtCode == dlist.districtCode}">
																		<option value="${dlist.districtCode}"
																			selected="selected">${dlist.districtNameEnglish}</option>
																	</c:when>
																	<c:otherwise>
																		<option value="${dlist.districtCode}">${dlist.districtNameEnglish}</option>
																	</c:otherwise>
																</c:choose>
															</c:forEach>

													</select></td>
													<td><select required="required"
														class="form-control bId" id="blockId${count.index}"
														name="incomeEnhancementDetails[${count.index}].blockCode">
															<%-- <c:forEach items="${blockFromDb}" var="obj"> --%>
															<c:forEach items="${dblist.blockListFromDb}" var="obj">
																<c:choose>
																	<c:when test="${obj.blockCode == dblist.blockCode}">
																		<option value="${obj.blockCode}" selected="selected">
																			${obj.blockNameEnglish}</option>
																	</c:when>
																	<c:otherwise>
																		<option value="${obj.blockCode}">
																			${obj.blockNameEnglish}</option>
																	</c:otherwise>
																</c:choose>
															</c:forEach>
													</select></td>
													<td><input type="text"
														oninput="validity.valid||(value='');" min="1"
														onKeyPress="if(this.value.length==3) return false;"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,'');calculateAspirationalGPs(${count.index})"
														required="required" value="${dblist.totalNoOfGpCovered}"
														name="incomeEnhancementDetails[${count.index}].totalNoOfGpCovered"
														id="noOfGpCoveredId_${count.index}"
														class="form-control Align-Right" /></td>
													<td><input type="text"
														oninput="validity.valid||(value='');" min="1"
														onKeyPress="if(this.value.length==3) return false;"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,''); calculateAspirationalGPs(${count.index})"
														required="required" value="${dblist.noOfAspirationalGp}"
														name="incomeEnhancementDetails[${count.index}].noOfAspirationalGp"
														id="aspirationalGpId_${count.index}"
														class="form-control Align-Right" /></td>
													<td><select required="required"
														id="yearOne_${count.index}" class="form-control"
														onchange='validateYear("${count.index}");'
														name="incomeEnhancementDetails[${count.index}].yearFrom">
															<option value="${dblist.yearFrom}">${dblist.yearFrom}</option>
															<option value="2018">2018</option>
															<option value="2019">2019</option>
															<option value="2020">2020</option>
															<option value="2021">2021</option>
															<option value="2022">2022</option>
													</select></td>
													<td><select required="required"
														id="yearTwo_${count.index}"
														onchange='validateYear("${count.index}");'
														class="form-control"
														name="incomeEnhancementDetails[${count.index}].yearTo">
															<option value="${dblist.yearTo}">${dblist.yearTo}</option>
															<option value="2018">2018</option>
															<option value="2019">2019</option>
															<option value="2020">2020</option>
															<option value="2021">2021</option>
															<option value="2022">2022</option>
													</select></td>
													<td><input type="text"
														oninput="validity.valid||(value='');"
														onKeyPress="if(this.value.length==7) return false;"
														min="1" value="${dblist.totalCostOfProject}"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,'');calculateAspirationalGPs(0)"
														name="incomeEnhancementDetails[${count.index}].totalCostOfProject"
														required="required" class="form-control Align-Right" /></td>
													<c:set var="totalFundToCalc"
														value="${totalFundToCalc + dblist.fundsRequired}"></c:set>
													<td><input type="text"
														oninput="validity.valid||(value='');"
														onKeyPress="if(this.value.length==5) return false;"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,'');calculateAspirationalGPs(0)"
														min="1" max="50000" value="${dblist.fundsRequired}"
														id="fundsName"
														name="incomeEnhancementDetails[${count.index}].fundsRequired"
														required="required"
														class="form-control Align-Right exclud" /></td>
													<td><input type="text"
														value="${dblist.briefAboutActivity}"
														name="incomeEnhancementDetails[${count.index}].briefAboutActivity"
														onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9 ]/,'');"
														required="required" maxlength="1000" class="form-control" /></td>
													<td><input type="file"
														name="incomeEnhancementDetails[${count.index}].file" /> <%-- <button type="button" value="Download File"
															class="btn bg-grey waves-effect"
															onclick='showImage("${dblist.fileLocation}","${dblist.fileName}");'>Download
															File</button>  --%>
														<a
														href='javascript:showImage("${dblist.fileLocation}","${dblist.fileName}");'
														class="btn btn-info btn-sm"> <span
															class="glyphicon glyphicon-download-alt"></span> Download
													</a> 
													
												<%-- 	<a href="#"  method="post" id="pdfDownload_${count.index}" onclick="fetchUrl(this.id,'${dblist.fileLocation}','${dblist.fileName}');"><span class="glyphicon glyphicon-download-alt"></span> </a>
												 --%>	</td>
													<td><c:choose>
															<c:when test="${dblist.planApprovedByDpc}">
																<label class="container"> <input type="checkbox"
																	name="incomeEnhancementDetails[${count.index}].planApprovedByDpc"
																	checked="checked" /> <span
																	class="checkmark"></span>
																</label>

															</c:when>
															<c:otherwise>
																<label class="container"> <input type="checkbox"
																	name="incomeEnhancementDetails[${count.index}].planApprovedByDpc"
																	/> <span class="checkmark"></span>
																</label>
															</c:otherwise>
														</c:choose></td>
													<td><input type="text"
															name="incomeEnhancementDetails[${count.index}].remarks"
															value="${dblist.remarks}"
															onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9 ]/g,'');"
															Class="form-control exclud" rows="2" cols="4"
															maxlength="1000" /></td>	
															
													<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
														<td>
															<ol>
															<c:forEach items="${STATE_PRE_COMMENTS[count.index]}" varStatus="indexInner" var="stateComments">
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
															<c:forEach items="${MOPR_PRE_COMMENTS[count.index]}" varStatus="indexMopr" var="moprComments">
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
													<c:if
														test="${USER_TYPE eq 'S'}">
														<td><%-- <input type="button" value="Delete"
															class="btn bg-red waves-effect"
															onclick='toDelete("${dblist.incomeEnhancementDetailsId}","${dblist.fileLocation}","${dblist.fileName}");' /> --%>
															<a 
															href='javascript:toDelete("${dblist.incomeEnhancementDetailsId}","${dblist.fileLocation}","${dblist.fileName}");'>
																<span id="delete${dblist.incomeEnhancementDetailsId}" class="glyphicon glyphicon-trash"></span>
														</a></td>
													</c:if>
													<c:if
														test="${USER_TYPE eq 'M' or USER_TYPE eq 'C'}">
														<td><c:choose>
																<c:when test="${dblist.isApproved}">
																	<input type="checkbox"
																		name="incomeEnhancementDetails[${count.index}].isApproved"
																		checked="checked" Class="form-control exclud">
																</c:when>
																<c:otherwise>
																	<input type="checkbox"
																		name="incomeEnhancementDetails[${count.index}].isApproved"
																		Class="form-control exclud">
																</c:otherwise>
															</c:choose></td>
													</c:if>
												</tr>
												<input type="hidden" name="setBlockId" />
												<input type="hidden"
													name="incomeEnhancementDetails[${count.index}].incomeEnhancementDetailsId"
													value="${dblist.incomeEnhancementDetailsId}" />
												<input type="hidden"
													name="incomeEnhancementDetails[${count.index}].fileName"
													value="${dblist.fileName}">
												<input type="hidden"
													name="incomeEnhancementDetails[${count.index}].fileContentType"
													value="${dblist.fileContentType}">
												<input type="hidden"
													name="incomeEnhancementDetails[${count.index}].fileLocation"
													value="${dblist.fileLocation}">
											</c:forEach>
										</c:if>
									</tbody>
								</table>
								
							</div>
							<br/>
							<br/>
							<c:if
								test="${USER_TYPE eq 'S'}">
								<button type="button" id="addNewRowBtn" class="btn bg-green"
									onclick="addNewRow()">Add New Row</button>
							</c:if>
							<br />
							<br/>
							<br/>
							<table class="table table-bordered" id="myTable">
								<tr>
									<td>Funds</td>
									<td><input type="text" id="subTotal"
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
									<c:set var="addtnlReqrmnt"
										value="0"></c:set>
									</c:otherwise>
									</c:choose>
									<td>
									<input type="text"
										oninput="validity.valid||(value='');"
										onKeyPress="if(this.value.length==7) return false;"
										onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"
										value="${addtnlReqrmnt}" min="1"
										name="additionalRequirement" id="additioinalRequirements"
										Class="form-control Align-Right exclud" required="required">
									
									</td>
								</tr>
								<tr>
									<td>Total Proposed Funds</td>
									<td><input type="text" id="grandTotal"
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
							<div class="form-group text-right">
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
							<c:choose>
							
							<c:when test="${not empty dbActivitiesList}">
										<c:if test="${Plan_Status eq true}">
											<button type="button" id="saveButtn"  
												onclick="$('input,select').prop('disabled', false);saveSubmit();"
												class="btn bg-green waves-effect save-button">SAVE</button>
											<c:if test="${dbActivitiesList.isFreeze != undefined}">
												<button type="button" id="frzButtn" onclick="toFreeze();"
													class="btn bg-orange waves-effect">FREEZE</button>
											</c:if>
											<button type="button" id="unFrzButtn" onclick="toFreeze();"
												class="btn bg-orange waves-effect">UNFREEZE</button>
											<button type="button" id="clearButtn"
												class="btn bg-light-blue waves-effect reset">CLEAR</button>
										</c:if>

									</c:when>
							<c:otherwise>
										<button type="submit" id="saveButtn"
											onclick="$('input,select').prop('disabled', false);"
											class="btn bg-green waves-effect">SAVE</button>
										<button type="button" id="frzButtn" onclick="toFreeze();"
											class="btn bg-orange waves-effect">FREEZE</button>
										<button type="button" id="clearButtn"
											class="btn bg-light-blue waves-effect reset">CLEAR</button>
									</c:otherwise>
							</c:choose>
								 
								<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-red waves-effect">CLOSE</button>
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
.Align-Right {
	text-align: right;
}
</style>
<script>
var heightDynamic=450;
<c:if test="${empty dbActivitiesList}">
	heightDynamic=150;
</c:if>
$('#records').slimScroll({
    height: heightDynamic,
    width:'auto',
    railVisible: true,
    alwaysVisible: true,
}); 
$('#records').slimscrollH({
	position: 'bottom',
	height: 'auto',
	width:'auto',
	railVisible: true,
    alwaysVisible: true,
}); 
</script>