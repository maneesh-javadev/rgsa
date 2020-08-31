<%@include file="../taglib/taglib.jsp"%>
<%@include file="additionalfacultyProgressJs.jsp"%>


<style>
.Align-Right{
	text-align: right;
	}
</style>
<section class="content" > 
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Additional Faculty and Maintenance at SPRC and DPRC</h2>
					</div>
					<form:form method="post" name="additionalFacultyProgress" action="additionalfacultyProgress.html" modelAttribute="HR_SUPPORT_SPRC_DPRC_QUATER">
					<input type="hidden" name="<csrf:token-name/>" value="<csrf:token-value uri="additionalfacultyProgress.html" />" />
					<input type="hidden" name="qprInstInfraHrId"  value="${QPR_ACTIVITY.qprInstInfraHrId}" id="qprActivityId"/>
					<div class="body">
					<c:set var="count" value="0" scope="page" />
					<div class="row clearfix">
					 <div class="form-group">
						<div class="col-lg-2">
						  	<label for="QuaterId1"><strong>Quarter Duration :</strong></label>
					    </div>
							<div align="center" class="col-lg-4">
								<select id="quaterDropDownId" name="quarterDuration.qtrId"
									class="form-control" onchange="saveAndGetDataQtrRprt('qtrChange');">
									<option value="0">Select quarter</option>
									<c:forEach items="${QUATER_DETAILS}" var="qtr">
										<option value="${qtr.qtrId}">${qtr.qtrDuration}</option>
									</c:forEach>
								</select>
							</div>
                           </div>
                        </div>
                        
                        <div class="records">
                        <div class="">
                           <div  class="col-lg-6 sub_head Alert">
                             (Balance Amount SPRC:${subcomponentwiseQuaterBalanceList[0].balanceAmount})
                           </div>
                           
                            <div  class="col-lg-6 sub_head Alert">
                             (Balance Amount DPRC:${subcomponentwiseQuaterBalanceList[1].balanceAmount})
                           </div>
                           
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                        <div id="mainDivId">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th><div align="center">Type of Center</div></th>
									<th><div align="center">Faculty and Staff</div></th>
									<th><div align="center">No of Units Approved</div></th>
									<th><div align="center">Approved Amount</div></th>
									<th><div align="center">No. of Unit Filled</div></th>
								   <th><div align="center">Expenditure Incurred </div></th>
								</tr>
							</thead>
							<tbody id="tbodyId">
								<c:forEach items="${CEC_APPROVED_ACTIVITY_DETAILS}"  var="approvedActDetail" varStatus="count" >
									
									<!-- total number of units filled in rest quaters -->
										<c:choose>
											<c:when test="${not empty DEATIL_FOR_TOTAL_NO_OF_UNIT}">
											<input type="hidden" id="totalExpenditureIncurred_${count.index}"
													value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[count.index].expenditureIncurred}" />
											
												<input type="hidden" id="totalNoOfUnit_${count.index}"
													value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[count.index].noOfUnitsFilled}" />
											</c:when>
											<c:otherwise>
												<input type="hidden" id="totalNoOfUnit_${count.index}"
													value="0" />
												<input type="hidden" id="totalExpenditureIncurred_${count.index}"
													value="0" />	
											</c:otherwise>
										</c:choose>
									<!-- ends here -->
										
									<input type="hidden" name="institueInfraHrActivity.instituteInfraHrActivityId" value="${CEC_APPROVED_ACTIVITY.instituteInfraHrActivityId}" /> 

						 	 		<input type="hidden" name="additionalFacultyProgressDetail[${count.index}].instituteInfraHrActivityType.instituteInfraHrActivityTypeId" value="${approvedActDetail.instituteInfraHrActivityType.instituteInfraHrActivityTypeId}" />
							 		<input type="hidden" name="additionalFacultyProgressDetail[${count.index}].qprInstInfraHrDetailsId" value="${QPR_ACTIVITY.additionalFacultyProgressDetail[count.index].qprInstInfraHrDetailsId}" />
									<tr>
										<td><div align="center"><strong>${approvedActDetail.instituteInfraHrActivityType.trainingInstitueType.trainingInstitueTypeName}</strong></div></td>
										<td><div align="center"><strong>${approvedActDetail.instituteInfraHrActivityType.instituteInfraHrActivityName}</strong></div></td>
										<td><div align="center" id="noOfUnitCecId_${count.index}"><strong>${approvedActDetail.noOfUnits}</strong></div></td>
										<td><div align="center" id="fundCecId_${count.index}"><strong>${approvedActDetail.fund}</strong></div></td>
										<c:choose>
											<c:when test="${not empty QPR_ACTIVITY}">
												<td><c:if test="${count.index ne 2 and count.index ne 5}">
													<form:input path="additionalFacultyProgressDetail[${count.index}].noOfUnitsFilled" id="noOfUnitCompleted_${count.index}" style="text-align: right;" class="form-control validate"  value="${QPR_ACTIVITY.additionalFacultyProgressDetail[count.index].noOfUnitsFilled}" onkeyup="validateNoOfUnits(${count.index})" onchange="domainValidation('noOfUnitCompleted_${count.index}')" readonly="${QPR_ACTIVITY.isFreeze}"/>
																<c:choose>
																	<c:when test="${count.index eq 0 }">
																		<div align="right" style="margin-top: 5px"><button type="button"
																				class="btn btn-primary btn-lg" data-toggle="modal"
																				data-target="#myModal">Fill Domain Details</button></div>
																	</c:when>

																	<c:when test="${count.index eq 3}">
																		<div align="right" style="margin-top: 5px"><button type="button"
																				class="btn btn-primary btn-lg" data-toggle="modal"
																				data-target="#myModal2">Fill Domain Details</button></div>
																	</c:when>
																	<c:otherwise>
																	</c:otherwise>
																</c:choose>
															</c:if>
														<span class="errormsg" id="error_noOfUnitCompleted_${count.index}"></span>	
													</td>
									 				<td>
									 				<form:input path="additionalFacultyProgressDetail[${count.index}].expenditureIncurred" 
									 				id="expenditureIncurred_${count.index}" style="text-align: right;" class="form-control validate" 
									 				value="${QPR_ACTIVITY.additionalFacultyProgressDetail[count.index].expenditureIncurred }" 
									 				readonly="${QPR_ACTIVITY.isFreeze}"
									 				onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[0].balanceAmount}','${subcomponentwiseQuaterBalanceList[1].balanceAmount}','${approvedActDetail.fund}',this,'${count.index}')"/>
									 				<span class="errormsg" id="error_expenditureIncurred_${count.index}"></span>
									 				</td>
											</c:when>
											<c:otherwise>
												<td><c:if test="${count.index ne 2 and count.index ne 5}">
													<input name="additionalFacultyProgressDetail[${count.index}].noOfUnitsFilled" id="noOfUnitCompleted_${count.index}" type="text" style="text-align: right;" class="form-control validate" onkeyup="validateNoOfUnits(${count.index})" />
																<c:choose>
																	<c:when test="${count.index eq 0 }">
																		<div align="right" style="margin-top: 5px">
																			<button type="button" class="btn btn-primary btn-lg"
																				data-toggle="modal" data-target="#myModal">Fill
																				Domain Details</button>
																		</div>
																	</c:when>

																	<c:when test="${count.index eq 3}">
																		<div align="right" style="margin-top: 5px">
																			<button type="button" class="btn btn-primary btn-lg"
																				data-toggle="modal" data-target="#myModal2">Fill
																				Domain Details</button>
																		</div>
																	</c:when>
																	<c:otherwise>
																	</c:otherwise>
																</c:choose>
															</c:if>
															<span class="errormsg" id="error_noOfUnitCompleted_${count.index}"></span>
															</td>
									 				<td><input name="additionalFacultyProgressDetail[${count.index}].expenditureIncurred" 
									 				id="expenditureIncurred_${count.index}" type="text" style="text-align: right;" 
									 				class="form-control validate" 
									 				onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[0].balanceAmount}','${subcomponentwiseQuaterBalanceList[1].balanceAmount}','${approvedActDetail.fund}',this,'${count.index}')">
									 				<span class="errormsg" id="error_expenditureIncurred_${count.index}"></span>
									 				</td>
											</c:otherwise>
										</c:choose>
										
									</tr>
								</c:forEach>
									<tr>
										<th colspan="2"><div align="center">Additional Requirement SPRC</div></th>
										<td colspan="2"><div align="center" id="additionalReqSprcStateId">${CEC_APPROVED_ACTIVITY.additionalRequirementSprc }</div></td>
										<td></td>
										<td><form:input path="additionalReqSprc" id="additionalReqSprcId" style="text-align: right;" value="${QPR_ACTIVITY.additionalReqSprc}" class="form-control validate" onkeyup="validateAddReq('sprc');calTotalExpenditure()" readonly="${QPR_ACTIVITY.isFreeze}"/></td>
									</tr>
									
									<tr>
										<th colspan="2"><div align="center">Additional Requirement DPRC</div></th>
										<td colspan="2"><div align="center" id="additionalReqDprcStateId">${CEC_APPROVED_ACTIVITY.additionalRequirementDprc }</div></td>
										<td></td>
										<td><form:input path="additionalReqDprc" id="additionalReqDprcId" style="text-align: right;" value="${QPR_ACTIVITY.additionalReqDprc}" class="form-control validate" onkeyup="validateAddReq('dprc');calTotalExpenditure()" readonly="${QPR_ACTIVITY.isFreeze}"/></td>
									</tr>

									<tr>
										<th colspan="2"><div align="center">Total
												Expenditure Incurred</div></th>
										<td colspan="3"></td>
										<td><input type="text" id="totalExpenditureId"
											class="form-control validate Align-Right"
											disabled="disabled"  style="text-align: right;"/></td>
									</tr>
									</tbody>
						</table>
						<!-- MODAL SPRC -->
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
														<label for="sprcModal" class="col-sm-3">Institute Type
															:</label>
														<div class="col-sm-5">
															<!-- <select> -->
															<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS"
																begin="1" end="1">
																<c:if
																	test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 2}">
																	<p class="text-justify">
																		<strong>
																			${DOMAINS.trainingInstitueType.trainingInstitueTypeName}</strong>
																	</p>
																</c:if>
															</c:forEach>
														</div>
													</div>
												</div>
												<div class="row clearfix">
													<div class="body">
														<div class="table-responsive">
															<table class="table table-hover">
																<thead style="background-color: #b39ad8;color: #2f2b2bf2;">
																	<tr>
																		<th><div align="center">Domain</div></th>
																		<th><div align="center">No.of Experts</div></th>
																	</tr>
																</thead>
																<tbody id="sprcModalTbody">
																<c:set var="temp" value="0" scope="page" />
																	<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS">
																		<c:if test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 2 }">
																			<tr>
																				<th><div align="center">${DOMAINS.domainName}</div>
																					<input type="hidden"
																					name="qprTiWiseDomainExpert[${temp}].domainId"
																					value="${DOMAINS.domainId}"></th>
																				<td><form:input path="qprTiWiseDomainExpert[${temp}].noOfExperts" id="noOfExpertsSprc_${temp}" class="form-control validate Align-Right" onkeyup="domainValidation(${temp})" readonly="${QPR_ACTIVITY.isFreeze}"/></td>
																			</tr>
																			<form:hidden path="qprTiWiseDomainExpert[${temp}].qprTiWiseProposedDomainExpertsId"/>
																			<c:set var="temp" value="${temp+1}" scope="page" />
																		</c:if>
																	</c:forEach>
																</tbody>
															</table>
														</div>
													</div>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-danger"
													data-dismiss="modal">Close</button>
											</div>
										</div>
									</div>
								</div>
						<!-- MODAL SPRC ENDS HERE -->
						
						<!-- MODAL DPRC -->
						<div id="myModal2" class="modal fade" role="dialog">
									<div class="modal-dialog modal-lg">

										<!-- Modal content-->
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">&times;</button>
											</div>
											<div class="modal-body">
												<div class="row">
													<div class="form-group">
														<label for="sprc" class="col-sm-3">Institute Type
															:</label>
														<div class="col-sm-5">
															<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS"
																begin="1" end="3">
																<c:if
																	test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 4}">
																	<p class="text-justify">
																		<strong>${DOMAINS.trainingInstitueType.trainingInstitueTypeName}</strong>
																	</p>
																</c:if>
															</c:forEach>
														</div>
													</div>
												</div>
												<div class="row clearfix">
													<div class="body">
														<div class="table-responsive">
															<table class="table table-hover">
																<thead style="background-color: #b39ad8;color: #2f2b2bf2;display: table;width: 100%;">
																	<tr>
																		<th><div align="center">District Name</div></th>
																		<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS">
																			<c:if test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 4}">
																				<th><div align="center">${DOMAINS.domainName}</div></th>
																			</c:if>
																		</c:forEach>
																	</tr>
																</thead>
																<tbody style="display: block;overflow-x: auto;height: 500px;" id="dprcModalTbody">
																	<c:set var="dprcIndex" value="0" scope="page" />	
																		<c:forEach items="${LIST_OF_DISTRICT}" var="DISTRICT">
																			<tr>
																				<td style="width: 234px;"><div align="center"><strong>${DISTRICT.districtNameEnglish}</strong></div></td>
																				<c:forEach items="${LIST_OF_DOMAINS}" var="DOMAINS">
																					<c:if test="${DOMAINS.trainingInstitueType.trainingInstitueTypeId eq 4}">
																						<td><form:input path="qprTiWiseDomainExpert[${dprcIndex+LIST_OF_DOMAINS_LENGTH}].noOfExperts" class="form-control Align-Right validate" onkeyup="domainValidation(${dprcIndex})" id="noOfExpertsDprc_${dprcIndex}" readonly="${QPR_ACTIVITY.isFreeze}"/></td>
																					<!-- hidden fields  -->
																							<input type="hidden" name="qprTiWiseDomainExpert[${dprcIndex + LIST_OF_DOMAINS_LENGTH}].domainId" value="${DOMAINS.domainId}">
																							<input type="hidden" name="qprTiWiseDomainExpert[${dprcIndex + LIST_OF_DOMAINS_LENGTH}].districtCode" value="${DISTRICT.districtCode}">
																							<form:hidden path="qprTiWiseDomainExpert[${dprcIndex + LIST_OF_DOMAINS_LENGTH}].qprTiWiseProposedDomainExpertsId"/>
																					<!-- hidden fields ends here  -->
																					<c:set var="dprcIndex" value="${dprcIndex + 1}" scope="page"></c:set>
																					</c:if>
																				</c:forEach>
																			</tr>
																		</c:forEach>
																</tbody>
															</table>
														</div>
													</div>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-danger"
													data-dismiss="modal">Close</button>
											</div>
										</div>

									</div>
								</div>
						<!-- MODAL SPRC ENDS HERE -->
							<div class="text-right">
								<c:choose>
									<c:when test="${QPR_ACTIVITY.isFreeze}">
										<button type="button" onclick="saveAndGetDataQtrRprt('save')" class="btn bg-green waves-effect" disabled="disabled" id="savebtn">SAVE</button>
										<button type="button" onclick="FreezeAndUnfreeze('unfreeze')"  class="btn bg-orange waves-effect" id="unfreezebtn">UNFREEZE</button>
										<!-- <button type="button" onclick="onClear(this)" class="btn bg-light-blue waves-effect" disabled="disabled">CLEAR</button> -->
									</c:when>
									<c:otherwise>
										<button type="button" onclick="saveAndGetDataQtrRprt('save')" class="btn bg-green waves-effect" id="savebtn">SAVE</button>
										<c:choose>
											<c:when test="${DISABLE_FREEZE}">
												<button type="button" onclick="" disabled="disabled"
													class="btn bg-orange waves-effect" id="freezebtn">FREEZE</button>
											</c:when>
											<c:otherwise><button type="button" onclick="FreezeAndUnfreeze('freeze')"
													class="btn bg-orange waves-effect" id="freezebtn">FREEZE</button></c:otherwise>
										</c:choose>
										<!-- <button type="button" onclick="onClear(this)" class="btn bg-light-blue waves-effect">CLEAR</button> -->
									</c:otherwise>
								</c:choose>
							
							
								
								<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-red waves-effect">CLOSE</button>
							</div>
						</div>
						</div>
						</div>
							<input type="hidden" id="qtrIdJsp3" name="qtrIdJsp3" value=""/>
							<input type="hidden" id="origin" name="origin" />
							
					</form:form>
				</div>
				
			</div>
		</div>
	</div>
</section>
 <script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>                          