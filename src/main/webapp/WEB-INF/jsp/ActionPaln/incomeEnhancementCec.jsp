<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
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
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
				<div class="header">
					<h2>
						 <h2>Project based support for Income Development & Income Enhancement(CEC)</h2>
						
					</h2>
				</div>
				  <form:form method="POST" id="incomeEnhancementId" name="incomeEnhancement" class="form-inline" action="incomeEnhancementAdd.html" modelAttribute="Income_Enhancement" enctype="multipart/form-data">
                           <input type="hidden" name="<csrf:token-name/>" value="<csrf:token-value uri="incomeEnhancementAdd.html"/>" />
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
									<div class="table-responsive">
										<table class="table table-bordered" >
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
                                        	
                                        	
                                        </tr>
                                        <tr>
	                                        <th>From </th>
	                                        <th> To</th>
                                        </tr>
											</thead>
											 <tbody>
                                   
                   
                        <c:if test="${not empty dbActivitiesList}">
                           <c:forEach items="${dbActivitiesList.incomeEnhancementDetails}" var="dblist" varStatus="count">
                                    <tr>
                                       	<td><strong>${count.count}</strong></td>
                                       	<td><div><strong>${INCOMEENHANCEMENTDETAIL_STATE[count.index].activtyName}</strong></div>
                                       	
                                       	<td><div><c:forEach items="${schemeMasterList}" var="scm">
		                                       		<c:choose>
		                                       			<c:when test="${INCOMEENHANCEMENTDETAIL_STATE[count.index].fundSourceCode == scm.schemeId}">
		                                       				<strong>${scm.schemeName}</strong>
		                                       			</c:when>
		                                       			
		                                       		
		                                       		</c:choose>
						                         </c:forEach></div>
                                       		
                                       	</td>
                                       	<td><div>
                                       	<c:forEach items="${districtList}" var="dlist">
													<c:choose>
		                                       			<c:when test="${INCOMEENHANCEMENTDETAIL_STATE[count.index].districtCode == dlist.districtCode}">
						                               		<strong>${dlist.districtNameEnglish}</strong>
						                               	</c:when>
						                               	
						                            </c:choose>
				                               	</c:forEach>
				                               	
                                       	</div>
											
                                       	</td>
                                    	<td>
                                    	<div><c:forEach items="${BLOCK}" var="obj">
					                            	
					                            		<c:choose>
					                            			<c:when test="${obj.blockCode == INCOMEENHANCEMENTDETAIL_STATE[count.index].blockCode}">
					                            				<strong>${obj.blockNameEnglish}</strong> 
					                            			</c:when>
					                            			
					                            		</c:choose>
					                            	</c:forEach>
                                    	</div>
                                    		
			                            </td>
                                        <td><div>${INCOMEENHANCEMENTDETAIL_STATE[count.index].totalNoOfGpCovered}</div></td>
                                       	<td><div>${INCOMEENHANCEMENTDETAIL_STATE[count.index].noOfAspirationalGp}</div>
                                       	<td><div>${INCOMEENHANCEMENTDETAIL_STATE[count.index].yearFrom}</div>
                                       	
                                       	</td>
                                       	<td><div>${INCOMEENHANCEMENTDETAIL_STATE[count.index].yearTo}</div>
                                       	
                                       	</td>
	                                       	<td><div>${INCOMEENHANCEMENTDETAIL_STATE[count.index].totalCostOfProject}</div>
	                                       	<input type="text" oninput="validity.valid||(value='');" onKeyPress="if(this.value.length==7) return false;" min="1" value="${dblist.totalCostOfProject}" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" name="incomeEnhancementDetails[${count.index}].totalCostOfProject" required="required" class="form-control Align-Right"/></td>
	                                    <c:set var="totalFundToCalc" value="${totalFundToCalc + dblist.fundsRequired}"></c:set>
	                                        <td><div>${INCOMEENHANCEMENTDETAIL_STATE[count.index].fundsRequired}</div>
	                                        <input type="text" oninput="validity.valid||(value='');" onKeyPress="if(this.value.length==5) return false;" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" min="1" max="50000" value="${dblist.fundsRequired}" id="fundsName"  name="incomeEnhancementDetails[${count.index}].fundsRequired" required="required" class="form-control Align-Right exclud"/></td>
	                                        <td><div><strong>${INCOMEENHANCEMENTDETAIL_STATE[count.index].briefAboutActivity}</strong></div>
	                                       	<td>
	                                       	<input type="button" value="Download File" class="btn bg-grey waves-effect" onclick='showImage("${dblist.fileLocation}","${dblist.fileName}");'/></td>
	                                       	<td>
	                                       <c:choose>
																<c:when test="${INCOMEENHANCEMENTDETAIL_STATE[count.index].planApprovedByDpc eq true}">
																	<i class="fa fa-check" aria-hidden="true"
																		style="color: #00cc00"></i>
																</c:when>
																<c:otherwise>
																	<i class="fa fa-times" aria-hidden="true"
																		style="color: red"></i>
																</c:otherwise>
															</c:choose>
	                                       	</td>
	                                      
	                                       
                                 </tr>
                                       	<input type="hidden" name="setBlockId" />
                                        <input type="hidden" name="incomeEnhancementDetails[${count.index}].incomeEnhancementDetailsId" value="${dblist.incomeEnhancementDetailsId}"/>
                                        <input type="hidden" name="incomeEnhancementDetails[${count.index}].fileName" value="${dblist.fileName}">
										<input type="hidden" name="incomeEnhancementDetails[${count.index}].fileContentType" value="${dblist.fileContentType}">
										<input type="hidden" name="incomeEnhancementDetails[${count.index}].fileLocation" value="${dblist.fileLocation}">
										<input type="hidden" name="incomeEnhancementDetails[${count.index}].districtCode" value="${dblist.districtCode}">
										
										
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
           </div>


								<div class="container tab-pane fade" id="MOPR"
								style="width: auto;">
								<div class="table-responsive">
									<table class="table table-bordered" >
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
                                        
                                        	<th rowspan="2">Plan approved by DPC</th>
                                        	<th rowspan="2">Is Approved</th>
	                                        	<th rowspan="2">Remarks</th>
                                        	
                                        </tr>
                                        <tr>
	                                        <th>From </th>
	                                        <th> To</th>
                                        </tr>
											</thead>
											 <tbody>
                            
                        <c:if test="${not empty INCOMEENHANCEMENTDETAIL_MOPR}">
                           <c:forEach items="${INCOMEENHANCEMENTDETAIL_MOPR}" var="dblist" varStatus="count">
                                    <tr>
                                       	<td>${count.count}</td>
                                       	<td><strong>${dblist.activtyName}</strong></td>
                                     
                                       	<td>
                                       			<c:forEach items="${schemeMasterList}" var="scm">
		                                       		<c:choose>
		                                       			<c:when test="${dblist.fundSourceCode == scm.schemeId}">
		                                       				<strong>${scm.schemeName}</strong>
		                                       			</c:when>
		                                       			
		                                       		
		                                       		</c:choose>
						                         </c:forEach>
			                             
                                       	</td>
                                       	<td>
												<c:forEach items="${districtList}" var="dlist">
													<c:choose>
		                                       			<c:when test="${dblist.districtCode == dlist.districtCode}">
						                               		<strong>${dlist.districtNameEnglish}</strong>
						                               	</c:when>
						                               	
						                            </c:choose>
				                               	</c:forEach>
				                               	
                                       	</td>
                                    	<td>
					                            	<c:forEach items="${BLOCK}" var="obj">
					                            	
					                            		<c:choose>
					                            			<c:when test="${obj.blockCode == dblist.blockCode}">
					                            				<strong>${obj.blockNameEnglish}</strong> 
					                            			</c:when>
					                            			
					                            		</c:choose>
					                            	</c:forEach>
			                             
			                            </td>
                                         <td><strong>${dblist.totalNoOfGpCovered}</strong></td>
                                            <td><strong>${dblist.noOfAspirationalGp}</strong></td>
                                       	<td><strong>${dblist.yearFrom}</strong>
                                       	</td>
                                       	<td><strong>${dblist.yearTo}</strong>
                                       	</td>
											<td><strong>${dblist.totalCostOfProject}</strong></td>	 
                                      		<c:set var="totalFundToCalc" value="${totalFundToCalc + dblist.fundsRequired}"></c:set>
	                                        <td><strong>${dblist.fundsRequired}</strong></td>
	                                        <td><strong>${dblist.briefAboutActivity}</strong></td>
	                                                	<td>
	                                       <c:choose>
																<c:when test="${dblist.planApprovedByDpc eq true}">
																	<i class="fa fa-check" aria-hidden="true"
																		style="color: #00cc00"></i>
																</c:when>
																<c:otherwise>
																	<i class="fa fa-times" aria-hidden="true"
																		style="color: red"></i>
																</c:otherwise>
															</c:choose>
	                                       	</td>
	                                       
	                                      
		                                   <td><div align="center">
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
														</div></td>
		                                       	<td><strong>${dblist.remarks}</strong></td>
	                                    
	                                       
                                 </tr>
                                      
                       </c:forEach>
                                       		</c:if>
                                    </tbody>
										 </table><br><br><br>
										 
                            </div>
                            <br/>
                            <table class="table table-bordered" id="myTable">
                            		<tr>
			                            <td>Funds</td>
			                            <td><strong>${totalFundToCalc}</strong></td>
		                            </tr>
		                            <tr>
		                            <td>Additional Requirements</td>
		                            <c:set var="addtnlReqrmnt" value="${addtnlReqrmnt + dbActivitiesList.additionalRequirement}"></c:set>
		                             <td><strong>${INCOMEENHANCEMENT_MOPR.additionalRequirement}</strong></td>
		                            </tr>
		                            <tr>
		                            <td>Total Proposed Funds</td>
		                           <td><strong>${INCOMEENHANCEMENT_MOPR.additionalRequirement + totalFundToCalc}</strong></td>
	                           	</tr>
	                         </table>
										<div class="text-right">
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
</section>
<style>
.Align-Right{
text-align: right;}
</style>
													