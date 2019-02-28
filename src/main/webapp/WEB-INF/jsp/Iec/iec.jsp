<%@include file="../taglib/taglib.jsp"%>
<html>
<section class="content">
	<script type="text/javascript">
	$(document).ready(function () {
	$("#mytable").on('input', '.txtCal', function () {
	       // code logic here
	     /*    var getValue=$(this).val();
	        document.getElementById("grandtotal").value = getValue; */
	       

	 
	    var calculated_total_sum = 0;
	     
	       $("#mytable .txtCal").each(function () {
	           var get_textbox_value = $(this).val();
	           if ($.isNumeric(get_textbox_value)) {
	              calculated_total_sum += parseFloat(get_textbox_value);
	              }                  
	            });
	           document.getElementById("grandtotal").value=calculated_total_sum;
	       });
	});
	
	function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
	}
	 $('document').ready(function(){
     	$(".reset").bind("click", function() {
     	  $("input[type=text]").val('');
     	});
     	/* calculateGrandTotal(); */
     });
	
function addRow(userType) {
    var rowCount = $('#mytable tr').length;
	var i = rowCount-1; 
    var tds = '<tr>';
	tds+='<td><select  name="iecActivity.iecActivityDetails['+i+'].iecActivityDropedown.iecId" class="activedrop form-control " data-live-search="true" id="selectDropDownId_'+i+'"><option value="" selected="selected">SELECT ACTIVITY</option><c:forEach items="${NATURE_IEC_LIST}" var="IEC_ACTIVITIES"><option value="${IEC_ACTIVITIES.iecId} " > ${IEC_ACTIVITIES.natureIecActivity}</option></c:forEach></select></td>'; 
	tds+='<td><input  type="number" name="iecActivity.iecActivityDetails['+i+'].totalAmountProposed" min="1" max="99999999" onchange="findTotal"  Class=" active123 form-control txtCal validate "  placeholder="Total Amount Proposed" style="text-align: right;" required /></td>';
	/* tds+='<td><input  type="text" name="iecActivity.iecActivityDetails['+i+'].totalAmountProposed" min="1"   onchange="findTotal"  Class=" active123 form-control txtCal Align-Right" onkeypress="return isNumber(event)"  placeholder="Total Amount Proposed" required/></td>'; */
	if(userType == "M"){
		tds+='<td><input type="textarea" name="iecActivity.iecActivityDetails['+i+'].remarks" Class=" active123 form-control" rows="2" cols="4" required /></td>';
	}
	if(userType == "C"){
		tds+='<td><input type="textarea" name="iecActivity.iecActivityDetails['+i+'].remarks" Class=" active123 form-control" rows="2" cols="4" required /></td>';
	}
	tds+='<td><input type="button" value="Delete" onclick = "removeRow()" class=" activedelete btn btn-danger waves-effect"/></td>';
	tds += '</tr>';
	$('#mytable tr:last').after(tds);	
	i=i++;
}
function removeRow(){
		if($('#mytable tr').length>2){
	$('#mytable tr:last').remove();
	i--;
	}
		}	
function toDelete(idToDelete){
	document.getElementById("idToDelete").value = idToDelete;
	document.IecName.method = "post";
	document.IecName.action = "deleteIecActivity.html?<csrf:token uri='deleteIecActivity.html'/>";
	document.IecName.submit();
}

	function freezeAndUnfreeze(obj){
		if(obj == "unfreeze"){
			$('.activedrop').attr('disabled',false);
		}
		document.getElementById("dbFileName").value = obj;
		document.IecName.method = "post";
		document.IecName.action = "freezAndUnfreezIEC.html?<csrf:token uri='freezAndUnfreezIEC.html'/>";
		document.IecName.submit();
	}
	
	 function validateForm(){
		var rowCount = $('#mytable tr').length;
		var index = rowCount-1;
		for(var j=0;j<index;j++){
			if($("#selectDropDownId_"+j).val() === "" || $("#selectDropDownId_"+j).val() === null){
				alert("Please select an activity from the list.");
				return false;
			}
		}
		return true;
	} 
</script>
	<div class="container-fluid">   
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2><spring:message code="Label.ProposalForIEC" htmlEscape="true" /></h2>
					</div>
					<form:form method="POST" name="IecName" action="iec.html"
						id="iecId" modelAttribute="IEC_ACTIVITY" path="iec" onsubmit="return validateForm()">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="iec.html"/>" />
							<input type="hidden" name="iecActivity.userType" value="${IEC_LIST.userType}"/>

						<div class="body">
							<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
							<div align="right">
							<c:if test="${IEC_LIST.isFreez eq true}">
							<button type="button" onclick="addRow('${sessionScope['scopedTarget.userPreference'].userType}')" class="activeadd btn bg-green waves-effect" disabled="disabled">
							<i class="fa fa-plus"></i><spring:message code="Label.AddNewRow" htmlEscape="true" />
							</button>
							</c:if>
							<c:if test="${IEC_LIST.isFreez eq false}">
							<button type="button" onclick="addRow('${sessionScope['scopedTarget.userPreference'].userType}')" class="activeadd btn bg-green waves-effect">
							<i class="fa fa-plus"></i><spring:message code="Label.AddNewRow" htmlEscape="true" />
							</button>
							</c:if>
								
							</div>
							</c:if>
							<div class="card">
								<div class="table-responsive">
									<table class="table table-bordered" id="mytable">
										<thead>
											<tr>
												<th scope="col"><div align="center">
														<strong><spring:message code="Label.NatureOfTheIECActivity" htmlEscape="true" /></strong>
													</div></th>
												<th scope="col"><div align="center">
														<strong><spring:message code="Label.AmountProposed" htmlEscape="true" /></strong>
													</div></th>
												<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
													<th><spring:message code="Label.IsApproved" htmlEscape="true" /></th>
													<th scope="col">
														<div align="center">
															<strong><spring:message code="Label.Remarks" htmlEscape="true" /></strong>
														</div>
													</th>
												</c:if>
													<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
													<th><spring:message code="Label.IsApproved" htmlEscape="true" /></th>
													<th scope="col">
														<div align="center">
															<strong><spring:message code="Label.Remarks" htmlEscape="true" /></strong>
														</div>
													</th>
												</c:if>
											</tr>
										</thead>
										<tbody id="newBody">
											<c:forEach items="${IEC_LIST.iecActivityDetails}" var="iecActivityDetails" varStatus="count">
												<c:set var="totalFundToCalc" value="${totalFundToCalc + iecActivityDetails.totalAmountProposed}"></c:set>
												<input type="hidden" name="iecActivity.iecActivityDetails[${count.index}].idMain" value="${iecActivityDetails.idMain}" />

												<tr id="newRow">
													<td><form:select path="iecActivity.iecActivityDetails[${count.index}].iecActivityDropedown.iecId" id="selectDropDownId_${count.index}" class="activedrop form-control show-tick" disabled="${IEC_LIST.isFreez eq true}">
															<c:forEach items="${NATURE_IEC_LIST}" var="IEC_ACTIVITIES1">
																<c:choose>
																	<c:when test="${iecActivityDetails.iecActivityDropedown.iecId == IEC_ACTIVITIES1.iecId}">
																		<form:option value="${IEC_ACTIVITIES1.iecId}" selected="true">${IEC_ACTIVITIES1.natureIecActivity}</form:option>
																	</c:when>
																	<c:otherwise>
																	<c:if test="${iecActivityDetails.iecActivityDropedown.iecId eq null || iecActivityDetails.iecActivityDropedown.iecId eq 0}">
																		<form:option value="" selected="true">SELECT ACTIVITY</form:option>
																		</c:if>
																		<form:option value="${IEC_ACTIVITIES1.iecId}">${IEC_ACTIVITIES1.natureIecActivity}</form:option>
																	</c:otherwise>
																</c:choose>
															</c:forEach>
														</form:select></td>
													<c:choose>
														<c:when test="${IEC_LIST.isFreez eq true}">
															<td><input type="number"
														value="${iecActivityDetails.totalAmountProposed}"
														name="iecActivity.iecActivityDetails[${count.index}].totalAmountProposed"
														min="1" Class="  active123 form-control txtCal Align-Right"
														placeholder="Total Amount Proposed" id="getTotal"
														onchange="findTotal();" required
														oninvalid="this.setCustomValidity('Entered value greater than 99999999')"
														oninput="setCustomValidity('')"  onkeypress="return isNumber(event)" max="99999999"  readonly="readonly" /></td>
														<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
														<c:choose>
														<c:when test="${iecActivityDetails.isApproved eq true}"><td><input type ="checkbox" name="iecActivity.iecActivityDetails[${count.index}].isApproved" checked="checked" readonly="readonly"/></td></c:when>
														<c:otherwise><td><input type ="checkbox" name="iecActivity.iecActivityDetails[${count.index}].isApproved" readonly="readonly"/></td></c:otherwise>
														</c:choose>
														
														<td><input type="text"
															name="iecActivity.iecActivityDetails[${count.index}].remarks"
															value="${iecActivityDetails.remarks}"
															Class=" active123 form-control" placeholder="remarks"
															required disabled="disabled"/></td>
														</c:if>
														<td><input type="button" value="Delete" class=" activedelete btn btn-danger waves-effect" onclick='toDelete("${iecActivityDetails.idMain}");' disabled="disabled"/></td>
														</c:when>
														<c:otherwise>
														<td><input type="number"
														value="${iecActivityDetails.totalAmountProposed}"
														name="iecActivity.iecActivityDetails[${count.index}].totalAmountProposed"
														min="1" Class="  active123 form-control txtCal Align-Right"
														placeholder="Total Amount Proposed" id="getTotal"
														onchange="findTotal();" required
														oninvalid="this.setCustomValidity('Entered value greater than 99999999')"
														oninput="setCustomValidity('')"  onkeypress="return isNumber(event)" max="99999999" /></td>
														<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
														<c:choose>
														<c:when test="${iecActivityDetails.isApproved eq true}"><td><input type ="checkbox" name="iecActivity.iecActivityDetails[${count.index}].isApproved" checked="checked"/></td></c:when>
														<c:otherwise><td><input type ="checkbox" name="iecActivity.iecActivityDetails[${count.index}].isApproved" /></td></c:otherwise>
														</c:choose>
														
														<td><input type="text"
															name="iecActivity.iecActivityDetails[${count.index}].remarks"
															value="${iecActivityDetails.remarks}"
															Class=" active123 form-control" placeholder="remarks"
															required /></td>
														</c:if>
														<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
														<c:choose>
														<c:when test="${iecActivityDetails.isApproved eq true}"><td><input type ="checkbox" name="iecActivity.iecActivityDetails[${count.index}].isApproved" checked="checked"/></td></c:when>
														<c:otherwise><td><input type ="checkbox" name="iecActivity.iecActivityDetails[${count.index}].isApproved" /></td></c:otherwise>
														</c:choose>
														
														<td><input type="text"
															name="iecActivity.iecActivityDetails[${count.index}].remarks"
															value="${iecActivityDetails.remarks}"
															Class=" active123 form-control" placeholder="remarks"
															required /></td>
														</c:if>
													<td><input type="button" value="Delete" class=" activedelete btn btn-danger waves-effect" onclick='toDelete("${iecActivityDetails.idMain}");' /></td>
														</c:otherwise>
													</c:choose>
													
												</tr>
											</c:forEach>

											<c:if test="${empty IEC_LIST}">
												<tr>
													<td><form:select
															path="iecActivity.iecActivityDetails[0].iecActivityDropedown.iecId"
															class="active123 form-control show-tick"
															data-live-search="true">
															<form:option value="" selected="true">SELECT ACTIVITY</form:option>
															<c:forEach items="${NATURE_IEC_LIST}"
																var="IEC_ACTIVITIES1">
																<form:option value="${IEC_ACTIVITIES1.iecId}">
																	${IEC_ACTIVITIES1.natureIecActivity}
																</form:option>
															</c:forEach>
														</form:select></td>
													
													<td id="totalSum"><input type="number"
														name="iecActivity.iecActivityDetails[0].totalAmountProposed"
														oninvalid="this.setCustomValidity('Entered value greater than 0')"
														oninput="setCustomValidity('')" max="99999999"
														Class=" active123  txtCal  form-control Align-Right" min="1" 
														placeholder="Total Amount Proposed" onkeypress="return isNumber(event)"></td>
													<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
													<td><input type="checkbox" name="iecActivity.iecActivityDetails[0].isApproved" value="${iecActivityDetails.isApproved}" /></td>
													<td><input type="text"
														name="iecActivity.iecActivityDetails[0].remarks"
														Class=" active123 form-control" required></td>
														</c:if>
														<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
													<td><input type="checkbox" name="iecActivity.iecActivityDetails[0].isApproved" value="${iecActivityDetails.isApproved}" /></td>
													<td><input type="text"
														name="iecActivity.iecActivityDetails[0].remarks"
														Class=" active123 form-control" required></td>
														</c:if>
												</tr>
											</c:if>
											<%-- <tr><th><label>Total Amount Proposed</label></th>
											<td><div style="margin-left: 31%" class="col-sm-4">
													<input type="text" style="background: #dddddd;"
														class="form-control Align-Right" id="grandtotal"
														value="${totalFundToCalc}" disabled="disabled">
												</div></td>
										</tr> --%>
										</tbody>
									</table>
									 <table class="table table-bordered" id="TotalTable">
										<tr><th><label><spring:message code="Label.TotalAmountProposed" htmlEscape="true" /></label></th>
											<td><div style="margin-left: 31%" class="col-sm-4">
													<input type="text" style="background: #dddddd;"
														class="form-control Align-Right" id="grandtotal"
														value="${totalFundToCalc}" disabled="disabled">
												</div></td>
										</tr>
									</table> 
				
								</div>
							</div>

						</div>
						<div class="text-right">
							<c:if test="${IEC_LIST.isFreez eq false || empty IEC_LIST}">
							<button type="submit" class="btn bg-green waves-effect" id="save"><spring:message code="Label.SAVE" text="Save" htmlEscape="true" /></button>
							<button type="button" onclick='freezeAndUnfreeze("freeze")' class="btn bg-green waves-effect" id="FREEZE"><spring:message code="Label.FREEZE" text="Freeze" htmlEscape="true" /></button>
							<button type="button"  class="btn bg-light-blue waves-effect reset" id="clearId" onclick="onClear(this)"><spring:message code="Label.CLEAR" text="Clear" htmlEscape="true" /></button>
							</c:if>
							<c:if test="${IEC_LIST.isFreez eq true}">
							<button type="button" onclick='freezeAndUnfreeze("unfreeze")' class="btn bg-green waves-effect" id="UNFREEZE"><spring:message code="Label.UNFREEZE" text="Unfreeze" htmlEscape="true" /></button>
							</c:if>
							<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect"><spring:message code="Label.CLOSE" text="Close" htmlEscape="true" /></button>
							<input type="hidden" name="iecActivity.dbFileName" id="dbFileName" /> 
							<input type="hidden" name="iecActivity.id" value="${IEC_LIST.id}" /> 
							<input type="hidden" name="idToDelete" id="idToDelete" />
						 	<input type="hidden" name="iecActivity.isfreez" id="isfreez" />
						</div>
					</form:form>
				</div>
			</div>
		</div>
		<%-- </c:when>
		<c:otherwise>
		</c:otherwise>
		</c:choose> --%>
	</div>
</section>
</html>
<!-- <script>
	$('document').ready(function(){
		if( '${readOnlyEnabled}' == 'true'){
			$('.active123').prop('readonly',true);
			 $('.activedrop').attr('disabled',true);
			$('.activeadd').prop('disabled',true);
			$('.activedelete').prop('disabled',true);
			$('#save').prop('disabled',true);
			$('#CLEAR').prop('disabled',true);
			$('#FREEZE').hide();
			$('#UNFREEZE').show();
		}
		else{
			$('.active123').prop('readonly' ,false);
			 $('.activedrop').attr('disabled',false); 
			$('.activeadd').prop('disabled',false);
			$('.activedelete').prop('disabled',false);
			$('#UNFREEZE').hide();
			$('#FREEZE').show();
		}
});
</script> -->
<style>
.Align-Right{
			text-align: right;
              }
</style>
<script type="text/javascript">
$( document ).ready(function() {
	$(".validate").keypress(function (e) {
	    //if the letter is not digit then display error and don't type anything
	    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	     /*   //display error message */
	       $("#errmsg").html("Digits Only").show().fadeOut("slow");
	              return false;
	   }
	  });
});
</script>
