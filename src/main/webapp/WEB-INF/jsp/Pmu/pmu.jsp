<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	
	 var calculated_total_sum = 0;
     
     $("#supportStaff .txtCal").each(function () {
         var get_textbox_value = $(this).val();
         if ($.isNumeric(get_textbox_value)) {
            calculated_total_sum += parseFloat(get_textbox_value);
            }                  
          });
     document.getElementById("grandtotal").value=calculated_total_sum;
     
   
	
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
function calculate(obj)
{
	var noOfMonths = $("#noOfMonths_"+obj).val();
	if(noOfMonths > 12)
		{
			alert("Months should be less than 12 !");
			$("#noOfMonths_"+obj).val(0);
		}
	else if(noOfMonths > 0) {
		$("#fund_"+obj).val(parseFloat($("#noOfUnits_"+obj).val()) * parseFloat($("#unitCost_"+obj).val()) * parseFloat($("#noOfMonths_"+obj).val())); 
		$("#totalFund_"+obj).val(parseFloat($("#fund_"+obj).val()));
		totalfunds();
	}
	else if((noOfMonths == 0 || noOfMonths < 0) && noOfMonths !="") {
		alert("Months should be greater than 0!");
		$("#noOfMonths_"+obj).val(1);
		totalfunds();
	}
}

function totalfunds(){
	var totalFunds = 0;
	 for(var i=0;i<6;i++){
		 	var funds = $("#fund_"+i).val();
		 	if(funds != "")
	    	totalFunds += parseInt(funds);
	    }
	    $("#grandtotal").val(totalFunds);
}
function toFreeze(){
	 $("input").prop('disabled', false);
	document.pmuController.method = "post";
	document.pmuController.action = "pmuFreezUnfreez.html?<csrf:token uri='pmuFreezUnfreez.html'/>";
	document.pmuController.submit();
}
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
						<form:form method="post" name="pmuController" action="addUpdatePmu.html"	modelAttribute="PMU_ACTIVITY">
							<input type="hidden" name="<csrf:token-name/>"	value="<csrf:token-value uri="addPmuActivity.html" />" />
								<div class="card">
									<div class="table-responsive">
										<table class="table table-bordered" id="supportStaff">
											<thead>
												<tr>
													<th><div align="center"><spring:message code="Label.TypeOfCenter" htmlEscape="true" /></div></th>
													<th><div align="center"><spring:message code="Label.Faculty&Staff" htmlEscape="true" /></div></th>
													<th><div align="center"><spring:message code="Label.NoOfUnits" htmlEscape="true" /><br>(A)</div></th>
													<th><div align="center"><spring:message code="Label.UnitCost" htmlEscape="true" /><br>(B)</div></th>
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
											<tbody id="myTableId">
											<c:set var="count" value="0" scope="page" />
											<c:forEach items="${LIST_OF_ACTIVITY_PMU_TYPE}" var="ACTIVITY" varStatus="srl">
											<input	type="hidden" name="pmuActivityId"	value="${pmuActivity.pmuActivityId}">
											<input	type="hidden" name="pmuActivityDetails[${count}].pmuActivityTypeId"	value="${ACTIVITY.pmuActivityTypeId}">
											<input	type="hidden" id="isFreeze" name="isFreeze"	value="${pmuActivity.isFreeze}">
											<input	type="hidden" name="pmuActivityDetails[${count}].pmuDetailsId"	value="${pmuActivity.pmuActivityDetails[count].pmuDetailsId}">
											<input type="hidden" name="userType" value="${pmuActivity.userType}"/>
											<tr>
												<td><div align="center"><strong>${ACTIVITY.pmuType.pmuTypeName}</strong></div></td>
												<td><div align="center"><strong>${ACTIVITY.pmuActivityName}</strong></div></td>
												<td><input value="${pmuActivity.pmuActivityDetails[srl.index].noOfUnits}"	name="pmuActivityDetails[${srl.index}].noOfUnits" min="1" maxlength="3"  onkeypress="return isNumber(event)" oninput="validity.valid||(value='');"	type="text" class="active12 form-control" id="noOfUnits_${count}" onchange="calculate(${count});" style="text-align:right;"/></td>
												<td><input value="${pmuActivity.pmuActivityDetails[srl.index].unitCost}"	name="pmuActivityDetails[${srl.index}].unitCost" min="1" maxlength="7"  onkeypress="return isNumber(event)" oninput="validity.valid||(value='');" type="text" class="active12 form-control"	id="unitCost_${count}" onchange="calculate(${count});" style="text-align:right;"/></td>
												<td><input value="${pmuActivity.pmuActivityDetails[srl.index].noOfMonths}" 	name="pmuActivityDetails[${srl.index}].noOfMonths" min="1"  onkeypress="return isNumber(event)" oninput="validity.valid||(value='');"	type="text" class="active12 form-control" id="noOfMonths_${count}" onchange="calculate(${count});" style="text-align:right;"/></td>
												<c:set var="totalFundToCalc" value="${pmuActivity.pmuActivityDetails[srl.index].fund}"></c:set>
												<td><input value="${pmuActivity.pmuActivityDetails[srl.index].fund}" readonly="readonly" name="pmuActivityDetails[${srl.index}].fund"  onkeypress="return isNumber(event)" oninput="validity.valid||(value='');" type="text" min="1" class="active12 form-control txtCal" id="fund_${count}" style="text-align:right;"/></td>
												<%-- <c:set var="totalexpns" value="${pmuActivity.pmuActivityDetails[srl.index].otherExpenses}"></c:set> --%>
												<%-- <td><input value="${pmuActivity.pmuActivityDetails[srl.index].otherExpenses}"	name="pmuActivityDetails[${srl.index}].otherExpenses" min="1"  onkeypress="return isNumber(event)" oninput="validity.valid||(value='');"	type="text" class="active12 form-control"	id="otherExpenses_${count}" onchange="calculate(${count});" style="text-align:right;"/></td>
												<td><input type="text" readonly="readonly" class="form-control" value="${totalFundToCalc}" id="totalFund_${count}" /></td> --%>
													<c:choose>
														<c:when test="${count eq 0 }">
															<td><button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">Fill Domain Details</button></td>
														</c:when>
														<c:when test="${count eq 3}">
															<td><button type="button"	class="btn btn-primary btn-lg" data-toggle="modal"	data-target="#myModal2">Fill Domain Details</button></td>
														</c:when>
														<c:otherwise>
															<td></td>
														</c:otherwise>
													</c:choose>
											<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
	                                             <td><c:choose>
	                                             			<c:when test="${pmuActivity.pmuActivityDetails[count].isApproved}">	
														  		 <input type="checkbox" name="pmuActivityDetails[${count}].isApproved" checked="checked"  />
														   </c:when>
														   <c:otherwise>
														   		<input type="checkbox" name="pmuActivityDetails[${count}].isApproved" />
														   </c:otherwise>
													</c:choose>
												</td>
										   </c:if>
										   <td><textarea name="pmuActivityDetails[${count}].remarks" rows="3" class="form-control" cols="5"><c:out value="${pmuActivity.pmuActivityDetails[count].remarks}"></c:out></textarea></td>
												</tr>
												<c:set var="count" value="${count +1}" scope="page" />
											</c:forEach>
											<tr>
											<th colspan="5"><label><spring:message code="Label.TotalAmountProposed" htmlEscape="true" /></label></th>
													<td>											
															<input type="text" style="background: #dddddd;"
																class="form-control Align-Right" id="grandtotal"
																value="${totalFundToCalc}" disabled="disabled">
														</td>
														<td></td>
														<td></td>
														
												</tr>
											<%-- <tr>
												<td><div align="center"><strong>Additional Requirement</strong></div></td>
												<td colspan="6"></td>
												<td><input type="text" name="additionalRequirement" value="${pmuActivity.additionalRequirement}" class="active12 form-control" /></td>
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
																					<input type="hidden" name="pmuWiseProposedDomainExperts[${temp}].pmuWiseProposedDomainExpertsId" value="${pmuWiseDomainList[temp].pmuWiseProposedDomainExpertsId}"/>
																					<tr>
																						<th><div align="center">${DOMAINS.pmuDomainName}</div>
																							<input type="hidden" name="pmuWiseProposedDomainExperts[${temp}].domainId"	value="${DOMAINS.pmuDomainId}"></th>
																						<td><input	name="pmuWiseProposedDomainExperts[${temp}].noOfExperts" value="${pmuWiseDomainList[temp].noOfExperts}"	type="text" class="active12 form-control Align-Right"	id="noOfFaculty_${temp}" /></td>
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
																	<select name="setDistrictIdPmuWise" id="activedropdown">
																		<option value="0">---select---</option>
																		<c:forEach items="${LIST_OF_DISTRICT}" var="DISTRICT">
																		<c:choose>
																			<%-- <c:when test="${pmuActivity.setDistrictIdPmuWise == DISTRICT[0]}"> --%>
																			<c:when test="${pmuWiseDomainList[0].districtId == DISTRICT[0]}">
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
																				<c:if test="${DOMAINS.pmuType.pmuTypeId eq 2}">
																					<input type="hidden" name="pmuWiseProposedDomainExperts[${temp}].pmuWiseProposedDomainExpertsId" value="${pmuWiseDomainList[temp].pmuWiseProposedDomainExpertsId}"/>
																					<tr>
																						<th><div align="center">${DOMAINS.pmuDomainName}</div>
																							<input type="hidden" name="pmuWiseProposedDomainExperts[${temp}].domainId" value="${DOMAINS.pmuDomainId}"></th>
																						<td><input	name="pmuWiseProposedDomainExperts[${temp}].noOfExperts" value="${pmuWiseDomainList[temp].noOfExperts}"	type="text" class="active12 form-control Align-Right"/></td>
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
										</div>
									</div>
									<div class="form-group text-right">
										<button type="submit" id="saveButtn" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
										<button type="button" class="freeze btn bg-green waves-effect"	id="frzButtn" onclick="toFreeze();"><spring:message code="Label.FREEZE" htmlEscape="true" /></button>
										<button type="button" class="unfreeze btn bg-green waves-effect" id="unFrzButtn" onclick="toFreeze();"><spring:message code="Label.UNFREEZE" htmlEscape="true" /></button>
										<button type="button" id="clearButtn" onclick="onClear(this)"	class="btn bg-light-blue waves-effect"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
										<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"	class="btn bg-orange waves-effect"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
										
									</div>
								</div>
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