

<head>
<%@include file="../taglib/taglib.jsp"%>
<%@include file="panchayatBhawanQuaterlyReportJs.jsp"%>
	<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/plugins/angular/ui-bootstrap-tpls-0.11.0.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/dataTables/css/dataTables.bootstrap.min.css">
	</head>
	<section class="content">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Panchayat Bhawan Quaterly Progress Report</h2>
						</div>
						<div class="body">
							<div class="card">
								<form:form method="POST" name="qprPanchayatBhawan" action="saveQprPanchayatBhawanData1.html" modelAttribute="QPR_PANCHAYAT_BHAWAN" enctype="multipart/form-data" >
									<input type="hidden" name="	 <csrf:token-name/>" value="<csrf:token-value uri="saveQprPanchayatBhawanData1.html" />" />
									<spring:bind path="panchayatBhawanActivityId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
									</spring:bind>
									<spring:bind path="qprPanchayatBhawanId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
									</spring:bind>
									
									<span class="errormsg show" ><c:out value='${isError}' /></span>
									
										<!-- nav bar -->
										<div class="row" >
											<div class="form-group">
												<div class="col-lg-2"></div>
												<label for="QuaterDuration" class="col-sm-3">
													<spring:message code="Label.QuaterDuration" htmlEscape="true" />
												</label>
												<div class="col-lg-4">
													<select class="form-control" id="qtrId"  name="qtrId" onchange="getSelelctedQtrRprt();"  >
														<option value="0">Select Quarter Duration</option>
														<c:forEach items="${quarterDuration}" var="duration">
															
																	<option  value="${duration.qtrId}" >${duration.qtrDuration}</option>
														</c:forEach>
													</select>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="form-group">
												<div class="col-lg-2"></div>
												<label for="selectLevel" class="col-sm-3">
													<spring:message code="Label.ActivityType" htmlEscape="true" />
												</label>
												<div class="col-lg-4">
													<select class="form-control" id="activityId"  name="activityId" onchange="getSelelctedQtrRprt();" >
														<option value="0">Select Activity</option>
														<c:forEach items="${panchayatActivity}" var="activity">
															<option  value="${activity.activityId}">${activity.activityName}</option>
														</c:forEach>
													</select>
												</div>
											</div>
										</div>
										<div class="row" data-ng-show="qprPanchayatBhawan.activityId != 0">
											<div class="form-group">
												<div class="col-lg-2"></div>
												<label for="District" class="col-sm-3">
													<spring:message code="Label.District" htmlEscape="true" />
												</label>
												<div class="col-lg-4">
												
													<select class="form-control" id="districtId" name="selectDistrictId" onchange="getSelelctedQtrRprt();" onclick="showHide()" >
														<option value="0">Select District</option>
														<c:forEach items="${districtList}" var="districtList">
															<option  value="${districtList.districtCode}">${districtList.districtNameEnglish}</option>
														</c:forEach>
													</select>
												</div>
											</div>
										</div>
										<div  class="col-lg-12 sub_head">
                            				  (Balance Amount:${subcomponentwiseQuaterBalance})
                          				 </div>
										<div class="body" id="body" onclick="showHide()" >
											<table class="table table-bordered table-striped table-hover" >
												<thead>
													<tr>
														<th>
															<div align="center">
																<strong>
																	<spring:message code="Label.SerialNumber" htmlEscape="true" />
																</strong>
															</div>
														</th>
														<th>
															<div align="center">
																<strong>
																	<spring:message code="Label.G.P." htmlEscape="true" />
																</strong>
															</div>
														</th>
														<th>
															<div align="center">
																<strong>
																	<spring:message code="Label.GPBhawanStatus" htmlEscape="true" />
																</strong>
															</div>
														</th>
														<th>
															<div align="center">
																<strong>
																	<spring:message code="Label.ExpenditureIncurred" htmlEscape="true" />
																</strong>
															</div>
														</th>
														<th>
															<div align="center">
																<strong>
																	<spring:message code="Label.UploadFile" htmlEscape="true" />
																</strong>
															</div>
														</th>
													</tr>
												</thead>
												<tbody>
													<c:if test="${isExistQprPanchayatBhawan}">
														<c:forEach items="${QprPanchayatBhawanDto}" var="bhawanDto" varStatus="count">
															<tr>
															
																	<spring:bind path="QPR_PANCHAYAT_BHAWAN.qprPanhcayatBhawanDetails[${count.index}].localBodyCode" >
																		<input type="hidden" name="${status.expression}" value="${QprPanchayatBhawanDto[count.index].localBodyCode}" /> 
																	</spring:bind>
																	
																	<spring:bind path="QPR_PANCHAYAT_BHAWAN.qprPanhcayatBhawanDetails[${count.index}].qprPanhcayatBhawanDetailsId" >
																		<input type="hidden" name="${status.expression}" value="${status.value}" /> 
																	</spring:bind>
																	
																		<spring:bind path="QPR_PANCHAYAT_BHAWAN.qprPanhcayatBhawanDetails[${count.index}].panhcayatBhawanActivityDetailsId" >
																		<input type="hidden" name="${status.expression}" value="${QprPanchayatBhawanDto[count.index].panchayatBhawanActivityDetailId}" /> 
																	</spring:bind>
																
																		
																<td>${count.index+1}</td>
																<td>${bhawanDto.localBodyNameEnglish}</td>
																<td>
																		<spring:bind path="QPR_PANCHAYAT_BHAWAN.qprPanhcayatBhawanDetails[${count.index}].gpBhawanStatusId" >
																			<select class="form-control" name="${status.expression}" id="gpBhawanStatusId_${count.index}">
																		<option value="0">Please select gp status</option>
																		<c:forEach items="${GPBhawanStatus}" var="status" >
																			<option value="${status.gpBhawanStatusId}" >${status.gpBhawanStatusName}</option>
																		</c:forEach>
																			</select>
																		</spring:bind>
																</td>
																<td>
																	<spring:bind path="QPR_PANCHAYAT_BHAWAN.qprPanhcayatBhawanDetails[${count.index}].expenditureIncurred" >
																	<input type="text" class="form-control" id="expenditureIncurred_${count.index}" name="${status.expression}"  value="${status.value}"
																	autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalance}',this,null)" onkeypress="return isNumber(event)"/>
																	</spring:bind>
																	<span class="errormsg" id="error_expenditureIncurred_${count.index}"></span>
																</td>
																<td>
																	<spring:bind path="QPR_PANCHAYAT_BHAWAN.qprPanhcayatBhawanDetails[${count.index}].file" >
																	<input type="file" name="${status.expression}" class="form-control"/>
																	</spring:bind>
																	<c:if test="${QPR_PANCHAYAT_BHAWAN.qprPanhcayatBhawanDetails[count.index].fileNode.fileNodeId!=null }">
																		<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${QPR_PANCHAYAT_BHAWAN.qprPanhcayatBhawanDetails[count.index].fileNode.fileNodeId}" target="_blank">
																			<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
																		</a>
																	</c:if>
																	
																</td>
															</tr>
														</c:forEach>
													</c:if>
												</tbody>
											</table>
											
										<div  class="col-lg-12 sub_head">
                            				 Total
                          				 </div>	
											
										<table width="100%">
										<tfoot>
										<tr>
                          					<td colspan="4">
												<strong>
													<spring:message code="Label.SubTotal" htmlEscape="true" />
												</strong>
											</td>
											<td>
												<input type="text" class="form-control" id="subtotal" disabled="disabled" style="text-align:right;"/>
												
											</td>
										</tr>
										<tr>
											<td colspan="4">
												<strong>
													<spring:message code="Label.AdditionalRequirement" htmlEscape="true" /> (Balance Additional Requirement:${balAddiReqSPRC})
													
												</strong>
											</td>
											<td>
												<spring:bind path="QPR_PANCHAYAT_BHAWAN.additionalRequirement" >
												<input type="text" onkeypress="return isNumber(event)" id="addReq" class="form-control" name="${status.expression}"  value="${status.value}" onblur="calculcate_total(null,'expenditureIncurred')" placeholder=" 25% of Grand Total cost " maxlength="8" style="text-align:right;" autocomplete="off"/>
												</spring:bind>
												<span class="errormsg" id="error_addReq"></span>
											</td>
										</tr>
										<tr>
											<td colspan="4">
												<strong>
													<spring:message code="Label.TotalProposedFund" htmlEscape="true" /> 
												</strong>
											</td>
											<td>
												<input type="text" id="total" class="form-control"  style="text-align:right;" readonly="readonly"/>
												
											</td>
										</tr>
										</tfoot>
										</table>	
											<br/><br/>
											
											<div class="form-group text-right">
												<button type="submit" class="btn bg-green waves-effect">
											Save
										</button>
												<button type="button" onclick="" class="btn bg-light-blue waves-effect reset">CLEAR${districtCode}</button>
												<button type="button"
											onclick=" onClose('home.html?
													<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">
													<spring:message code="Label.CLOSE" htmlEscape="true" />
												</button>
											</div>
											
											</div>
													
													</form:form>
													
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</section>

