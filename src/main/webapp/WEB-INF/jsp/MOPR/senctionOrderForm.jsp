<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script>
	var InstallmentNo = '${InstallmentNo}';
	var PlanCode = '${PlanCode}';
	var yearId = '${yearId}';
	
	$(document).ready(function() {
		
		$("#installmentId").val(InstallmentNo);
		$("#StateId").val(PlanCode);
		
	});
	
	function selectCurrentInstallment(msg) {
		var installmentId = $('#installmentId').val();
		var StateId = $('#StateId').val();
		var flag = true;

		$('#installID').val(installmentId);
		$('#yearId').val(yearId);
		$('#yearId').val(yearId);

		$('#planVersion').val(StateId);
		$('#origin').val(msg);
		document.SnactionOrderModel.method = "post";
		document.SnactionOrderModel.action = "senctionOrderForm.html?<csrf:token uri='senctionOrderForm.html'/>";

		document.SnactionOrderModel.submit();
	}
	
	
	
	
	function showImage(name){
		document.getElementById("dbFileName").value = name;
		document.SnactionOrderModel.method = "post";
		document.SnactionOrderModel.action = "downloadSanctionOrder.html?<csrf:token uri='downloadSanctionOrder.html'/>";
		document.SnactionOrderModel.submit();
		
	}
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Sanction Order</h2>
					</div>
					<form:form method="post" name="SnactionOrderModel"
						action="senctionOrderForm.html"
						modelAttribute="SnactionOrderModel" enctype="multipart/form-data">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="senctionOrderForm.html" />" />
						<div class="body">

							<c:set var="count" value="0" scope="page" />
							<div class="row clearfix">
								<div class="form-group">
									<div class="col-lg-2">
										<label for="QuaterId1"><strong>Select State:</strong></label>
									</div>
									<div align="center" class="col-lg-4">
										<select id="StateId" name="quarterDuration.qtrId"
											class="form-control" onchange="showDistrictDropDown()">
											<option value="0">Select</option>
												<c:forEach items="${stateList}" var="stateL">
												<option value="${stateL.stateVersion}">${stateL.stateNameEnglish}
												</option>
											</c:forEach>

											<%-- </c:choose> --%>
										</select>
									</div>
								</div>
							</div>

							<div class="row clearfix">
								<div class="form-group" id="districtDropDownId">
									<div class="col-lg-2">
										<label for="QuaterId1"><strong>District :</strong></label>
									</div>
									<div align="center" class="col-lg-4">


										<select class="form-control" id="installmentId"
											name="installmentModel"
											onchange="selectCurrentInstallment('onclick')">
											<option value="">Select installment</option>
											<option value="1">installment one</option>
											<option value="2">installment two</option>
										</select>

									</div>
								</div>
							</div>
							<br>


							<div class="row">
								<div class="col-xs-12">
									<table class="table table-bordered">
										<c:if test="${not empty sanctionOrderCompomentAmount}">
										<thead>
											<tr>
												<th ><div align="center">S.No.</div></th>
												<th ><div align="center">Component Name</div></th>
												<th ><div align="center">Component wise Amount</div></th>
												<th colspan="2"><div align="center">Upload File</div></th>
												<!-- <th>
    							 Upload File Status
    							</th> -->
											</tr>
										</thead>
										<tbody id="tbodyId">
											<c:set var="count" value="0" scope="page" />
											<c:choose>

												<c:when test="${not empty sanctionOrderCompomentAmount}">
													<c:forEach items="${sanctionOrderCompomentAmount}"
														var="sanctionOrderAmount" varStatus="count">
														<!-- total number of units filled in rest quaters -->

														<!-- ends here -->
														<%-- <input type="hidden" name="eEnablement.eEnablementId"
															value="${idEEnablement}">
														<input type="hidden" name="qprEEnablementId"
															value="${fetchQprEnablementId.qprEEnablementId}" id="qprActivityId">	
														<input type="hidden"
															name="qprEnablementDetails[${count.index}].localBodyCode"
															value="${localbody.localBodyCode}">
														<input type="hidden"
															name="qprEnablementDetails[${count.index}].qprEEenablementDetailsId"
															value="${Qpr_Enablement.qprEnablementDetails[count.index].qprEEenablementDetailsId}"> --%>
                                                  <input type="hidden"  name="sanctionOrderCompomentAmountList[${count.index}].componentId" 
															value="${sanctionOrderAmount.componentId}" id="componentId">	
															
															<input type="hidden"  name="releaseIntallmentSno" 
															value="${fetchReleaseInstalment.releaseIntallment.releaseIntallmentSno}" id="releaseIntallmentSno">	
															
															 <input type="hidden"  name="sanctionOrderCompomentAmountList[${count.index}].sanctionOrderSno" 
															value="${fetchReleaseInstalment.sanctionOrderList[count.index].sanctionOrderSno}" id="componentId">
															<input type="hidden" name="sanctionOrderCompomentAmountList[${count.index}].filePath" 
															value="${sanctionOrderAmount.filePath}">
															
														<tr>
															<td><div align="center">
																	<strong>${count.index+1}</strong>
																</div></td>
																<td><div align="center">
																	<strong>${sanctionOrderAmount.componentName}</strong>
																</div></td>

															<td><input class="form-control Align-Right"
																name="sanctionOrderCompomentAmountList[${count.index}].componentAmount"
																value="${sanctionOrderAmount.componentAmount}"
																required="required" /></td>

															</td>
															<td><input class="form-control Align-left"
																type="file"  name="sanctionOrderCompomentAmountList[${count.index}].file"
																value="${sanctionOrderAmount.filePath}"/>
																<c:if test="${sanctionOrderAmount.filePath ne '0'}">
																<input type="button" value="Download File" class="btn bg-grey waves-effect delete${innovativeActivityDetails.id}" onclick='showImage("${sanctionOrderAmount.filePath}");' />
																</c:if></td>

														</tr>
													</c:forEach>
                               

												</c:when>
												<%-- <c:otherwise>
													<div class="form-group">
														<div align="center" class="Alert">
															<i class="fa fa-meh-o fa-lg" aria-hidden="true"></i><span>
																Oops! Fund is not allocated for this component.</span><br />
														</div>
													</div>
												</c:otherwise> --%>
											</c:choose>
										</tbody>
										</c:if>
									</table>
                                 <c:choose>
								<c:when test="${not empty sanctionOrderCompomentAmount}">
								
								 <div class="row">
    							<div class="col-xs-4">
    							<label for="fileNo"><c:out value="Select Date." /></label>
    							</div>
    							<div class="form-group">
								<div class="col-xs-4">
									<div class="form-line">
										<div class="input-group date datepicker" id="datetimepicker1">
										<input type="date"  class="form-control"   data-date-format="DD MMMM YYYY"  name="sactionDate"
																value="${fetchReleaseInstalment.releaseIntallment.releaseDate}" />
										<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
										</div>
										
									</div>
								</div>	
								</div>	
							</div> 
									<div class="text-right">
										<form:button onclick="selectCurrentInstallment('save')" class="btn bg-green waves-effect" >
											SAVE</form:button>
										
											<form:button class="btn bg-green waves-effect" onclick="selectCurrentInstallment('freeze')">FREEZE</form:button>
										
										
										
										<form:button
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">CLOSE</form:button>
									</div>
								</c:when>
								<c:otherwise>
									<div class="text-right">
										<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">CLOSE</button>
									</div>
								</c:otherwise>
							</c:choose>
							
									<input type="hidden" id="installID" name="installmentNo"
										value='' /> <input type="hidden" id="planVersion"
										name="planCode" value='' /> <input type="hidden" id="origin"
										name="origin" />
										<input type="hidden" id="yearId"
										name="yearId" />
										<input type="hidden" name="dbFileName" id="dbFileName" >
										
										
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

.Alert {
	font-size: x-large;
	color: red;
	background-color: #fbeeed;
	border-color: #f7d8dd;
	padding-top: 5%;
	padding-bottom: 5%;
}
</style>
