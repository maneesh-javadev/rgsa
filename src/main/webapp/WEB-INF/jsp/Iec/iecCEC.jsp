<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		onloadChangeColor();
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
	
	 function onloadChangeColor(){
			var noOfRowCount = $('#newBody tr').length;
			for(var i= 0; i<noOfRowCount ;i++){
			
		+$("#totalAmountProposed_"+i).val() < +$("#totalAmountProposedState_"+i).text() ? $("#totalAmountProposedState_"+i).css("color","red") : $("#totalAmountProposedState_"+i).css("color","#00cc00");

		} 
			+$("#totalState").text() > +$("#grandtotal").val() ? $("#totalState").css('color','red') : $("#totalState").css('color','#00cc00');

		 }
	
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



	function freezeAndUnfreeze(obj){
		if(obj == "unfreeze"){
			
			$('.active1').attr('readonly',false);
		} 
		
		document.getElementById("dbFileName").value = obj;
		document.IecName.method = "post";
		document.IecName.action = "freezAndUnfreezIEC.html?<csrf:token uri='freezAndUnfreezIEC.html'/>";
		document.IecName.submit();
	}
	
	
 
	
	
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Label.ProposalForIEC" htmlEscape="true" />
						</h2>
					</div>
					<form:form method="POST" name="IecName" action="iec.html"
						id="iecId" modelAttribute="IEC_ACTIVITY" path="iec"
						onsubmit="return validateForm()">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="iec.html"/>" />
						<input type="hidden" name="iecActivity.userType"
							value="${IEC_LIST.userType}" />
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
								<div class="table-responsive">
									<table class="table table-bordered" id="mytable">

										



										<thead>
											<tr>
											<c:set var="count" value="0" scope="page" />
												<th scope="col"><div align="center">
														<strong><spring:message
																code="Label.NatureOfTheIECActivity" htmlEscape="true" /></strong>
													</div></th>
												<th scope="col"><div align="center">
														<strong><spring:message
																code="Label.AmountProposed" htmlEscape="true" /></strong>
													</div></th>



												<th scope="col">
													<div align="center">
														<strong><spring:message code="Label.Remarks"
																htmlEscape="true" /></strong>
													</div>
												</th>

											</tr>
										</thead>
										<tbody id="newBody1">
											<c:forEach items="${IEC_LIST_FOR_STATE}"
												var="iecActivityDetails" varStatus="count">
												<c:set var="totalFundToCalc"
													value="${totalFundToCalc + IEC_LIST_DETAILS[count.index].totalAmountProposed}"></c:set>
												<input type="hidden"
													name="iecActivity.iecActivityDetails[${count.index}].idMain"
													value="${IEC_LIST_DETAILS[count.index].idMain}" /> 

												<tr id="newRow">
											<input type="hidden" name="iecActivity.iecActivityDetails[${count.index}].iecActivityDropedown.iecId" value="${IEC_LIST_FOR_STATE[count.index].iecActivityDropedown.iecId}"/>
												 
													<td><strong>${iecActivityDetails.iecActivityDropedown.natureIecActivity}</strong></td>
													<c:choose>
														<c:when test="${IEC_LIST.isFreez eq true}">
															<td><div align="center"
																	id="totalAmountProposedState_${count.index}">${IEC_LIST_FOR_STATE[count.index].totalAmountProposed}</div>
																<input type="number"
																value="${IEC_LIST_DETAILS[count.index].totalAmountProposed}"
																name="iecActivity.iecActivityDetails[${count.index}].totalAmountProposed" 
																min="1"
																class="active1 form-control txtCal  "
																placeholder="Total Amount Proposed"  id="totalAmountProposed_${count.index}"
																 required
																oninvalid="this.setCustomValidity('Entered value greater than 99999999')"
																oninput="setCustomValidity('')" style="text-align:right"
																onkeypress="return isNumber(event)"  max="99999999"
															 readonly="readonly" onkeyup="onloadChangeColor()" /></td>


															<td><textarea cols="1"
																	name="iecActivity.iecActivityDetails[${count.index}].remarks"
																	class=" active1 form-control" readonly="readonly" placeholder="remarks"
																	required ><c:out value="${IEC_LIST_DETAILS[count.index].remarks}"></c:out></textarea></td>

														</c:when>
														<c:otherwise>
															<td><div align="center" 
																	id="totalAmountProposedState_${count.index}">${IEC_LIST_FOR_STATE[count.index].totalAmountProposed}</div>
																<input type="number"
																value="${IEC_LIST_DETAILS[count.index].totalAmountProposed}"
																name="iecActivity.iecActivityDetails[${count.index}].totalAmountProposed"
																min="1" 
																class="active1  form-control txtCal  " style="text-align:right"
																placeholder="Total Amount Proposed"
																id="totalAmountProposed_${count.index}" 
																 required
																oninvalid="this.setCustomValidity('Entered value greater than 99999999')"
																oninput="setCustomValidity('')"
																onkeypress="return isNumber(event)" max="99999999" onkeyup="onloadChangeColor()"/></td>



															<td><textarea cols="1"
																	name="iecActivity.iecActivityDetails[${count.index}].remarks"
																	class=" active1 form-control" placeholder="remarks"
																	required><c:out
																		value="${IEC_LIST_DETAILS[count.index].remarks}"></c:out> </textarea></td>

														</c:otherwise>
													</c:choose>

												</tr>
											</c:forEach>

										</tbody>
									</table>
									<table class="table table-bordered">
										<tr>
											<th><label><spring:message
														code="Label.TotalAmountProposed" htmlEscape="true" /></label></th>
											<td><div style="margin-left: 28%" class="col-sm-4" id="totalState">
													<strong>${totalAmountProposedState}</strong> <input style="text-align:right"
														type="text" style="background: #dddddd;"
														class="form-control Align-Right" id="grandtotal"
														value="${totalFundToCalc}" disabled="disabled">
												</div></td>
										</tr>
									</table>
									<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
                        <div class="col-md-4  text-left"  style="margin-bottom: 5px">
								&nbsp;&nbsp;<button type="button"
									onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
									class="btn bg-orange waves-effect">
									<i class="fa fa-arrow-left" aria-hidden="true"></i>
									<spring:message code="Label.BACK" htmlEscape="true" />
								</button><br>
							</div>
							</c:if>
									<div class="text-right">
										<c:if test="${IEC_LIST.isFreez eq false || empty IEC_LIST}">
											<button type="submit" class="btn bg-green waves-effect"
												id="save">
												<spring:message code="Label.SAVE" text="Save"
													htmlEscape="true" />
											</button>
											<button type="button" onclick='freezeAndUnfreeze("freeze")'
												class="btn bg-green waves-effect" id="FREEZE">
												<spring:message code="Label.FREEZE" text="Freeze"
													htmlEscape="true" />
											</button>
											<button type="button"
												class="btn bg-light-blue waves-effect reset" id="clearId"
												onclick="onClear(this)">
												<spring:message code="Label.CLEAR" text="Clear"
													htmlEscape="true" />
											</button>
										</c:if>
										<c:if test="${IEC_LIST.isFreez eq true}">
											<button type="button" onclick='freezeAndUnfreeze("unfreeze")'
												class="btn bg-green waves-effect" id="UNFREEZE">
												<spring:message code="Label.UNFREEZE" text="Unfreeze"
													htmlEscape="true" />
											</button>
										</c:if>
										<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">
											<spring:message code="Label.CLOSE" text="Close"
												htmlEscape="true" />
										</button>
										<input type="hidden" name="iecActivity.dbFileName"
											id="dbFileName" /> <input type="hidden"
											name="iecActivity.id" value="${IEC_LIST.id}" /> <input
											type="hidden" name="idToDelete" id="idToDelete" /> <input
											type="hidden" name="iecActivity.isfreez" id="isfreez" />
									</div>
								</div>
							</div>
							


							<div role="tabpanel" class="container tab-pane " id="MOPR"
								style="width: auto;">
								<div class="table-responsive">
									<table class="table table-bordered">
										<thead>
											<tr>
												<th scope="col"><div align="center">
														<strong><spring:message
																code="Label.NatureOfTheIECActivity" htmlEscape="true" /></strong>
													</div></th>
												<th scope="col"><div align="center">
														<strong><spring:message
																code="Label.AmountProposed" htmlEscape="true" /></strong>
													</div></th>
												<th><div align="center">
														<spring:message code="Label.IsApproved" htmlEscape="true" />
													</div></th>
												<th scope="col">
													<div align="center">
														<strong><spring:message code="Label.Remarks"
																htmlEscape="true" /></strong>
													</div>
												</th>



											</tr>
										</thead>
										<tbody id="newBody">
											<c:forEach items="${IEC_LIST_FOR_MOPR}"
												var="iecActivityDetails" varStatus="count">
												<c:set var="totalFundToMOPRCalc"
													value="${totalFundToMOPRCalc + iecActivityDetails.totalAmountProposed}"></c:set>
												<input type="hidden"
													name="iecActivity.iecActivityDetails[${count.index}].idMain"
													value="${iecActivityDetails.idMain}" />

												<tr id="newRow">
													<td><strong>${iecActivityDetails.iecActivityDropedown.natureIecActivity}</strong></td>
													<td><strong>${iecActivityDetails.totalAmountProposed}</strong></td>

													<td><div align="center">
															<c:choose>
																<c:when test="${iecActivityDetails.isApproved eq true}">
																	<i class="fa fa-check" aria-hidden="true"
																		style="color: #00cc00"></i>
																</c:when>
																<c:otherwise>
																	<i class="fa fa-times" aria-hidden="true"
																		style="color: red"></i>
																</c:otherwise>
															</c:choose>
														</div></td>



													<td><strong>${iecActivityDetails.remarks}</strong></td>
	</tr>
											</c:forEach>

										</tbody>
									</table>
									<table class="table table-bordered" id="TotalTable">
										<tr>
											<th><label><spring:message
														code="Label.TotalAmountProposed" htmlEscape="true" /></label></th>
											<td><div style="margin-left: 31%" class="col-sm-4">
													<input type="text" style="background: #dddddd;"
														class="form-control Align-Right" id="grandtotal"
														value="${totalFundToMOPRCalc}" disabled="disabled">
												</div></td>
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
							</div>
						</div>

					</form:form>



				</div>
			</div>
		</div>



	</div>

</section>
