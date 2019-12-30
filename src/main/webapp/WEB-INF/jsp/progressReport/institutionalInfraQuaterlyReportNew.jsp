<%@include file="../taglib/taglib.jsp"%>
<%@include file="institutionalInfraQuaterlyReportNewJs.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>



<style>
.padding_left_local {
   padding-left: 85px !important;
 }

</style>
<html>
	<section class="content">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2><spring:message code="Label.InstitutionalInfrastructure" htmlEscape="true" /></h2>
						</div>
						
						<form:form method="POST" name="qprInstitutionalInfrastructure" action="saveQprInstitutionalInfrastructureData.html"
						modelAttribute="QPR_INSTITUTIONALINFRAQUATERLY" enctype="multipart/form-data" >
						<input type="hidden" name="<csrf:token-name/>"value="<csrf:token-value uri="saveQprInstitutionalInfrastructureData.html" />" />
						<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.institutionalInfraActivivtyId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
						</spring:bind>
						 
						 
					<input type="hidden" name="qprInstInfraId" value="${qprInstInfraId}" id="qprInstInfraId" />
										
					 
 					
						<span class="errormsg show" ><c:out value='${isError}' /></span>
						
						
						<div class="row" >
							<div class="form-group">
							<div class="col-sm-2"></div>
								<label for="QuaterDuration" class="col-sm-2"><spring:message code="Label.QuaterDuration" htmlEscape="true" /></label>
								<div class="col-lg-4">
									
									<select id="qtrId" name="qtrId" onchange="get_quater_wise_data(this.value)" required="required" class="form-control">
										<option value="0">Select Quarter Duration</option>
										
										<c:forEach items="${quarterDuration}" var="duration">
											<option  value="${duration.qtrId}" >${duration.qtrDuration}</option>
										</c:forEach>
									</select>
									
									
								</div>
							</div>
						</div>	 
									
					   <c:if test="${installementExist}">
						<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.NewBuilding" htmlEscape="true" />(SPRC)(Balance Amount:${subcomponentwiseQuaterBalanceList[0].balanceAmount})
                           </div>
                           
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                           
                           
                           <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
										
										<th>
											<div align="center">
												<strong><spring:message code="Label.District" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.InstituteStatus" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ApprovedAmount" htmlEscape="true" /></strong>
											</div>
										</th>
										<%-- <th>
											<div align="center">
												<strong><spring:message code="Label.UploadFile" htmlEscape="true" /></strong>
											</div>
										</th> --%>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ExpenditureIncurred" htmlEscape="true" /></strong>
											</div>
										</th>
										 <th>
											<div align="left">
												<strong>file</strong>
											</div>
										</th> 
									</tr>
							  </thead>
                              <tbody id="tbodyId">
                              <c:set var="mindex" value="0" />
                              <c:set var="sindex" value="0" />
                              <c:forEach items="${instInfraStateDataForProgressReport}" var="bhawanDto" varStatus="count">
                       		<c:if test="${bhawanDto.workType eq 'N' and bhawanDto.institutionalActivityTypeId==2}">
								<tr>
								<td align="center">
										<strong>${bhawanDto.districtName}</strong>
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].qprInstInfraDetailsId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].trainingInstitueTypeId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalActivityTypeId}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].instituteInfrsaHrActivityDetailsId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalInfraActivityDetailId}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].fileNode.fileNodeId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
 							 				
								</td>
								<td align="center">
									<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].instInfraStatusId" >
											<form:select id="instInfraStatusId${mindex}"
											 class="form-control"  path="${status.expression}"  disabled="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}">
								 			<form:option value="0">Select Status</form:option>
											<c:forEach items="${InstInfraStatus}" var="obj">
												<c:if test="${obj.trainingInstitueType.trainingInstitueTypeId==bhawanDto.institutionalActivityTypeId }">
													
													
													<c:choose>
												<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].instInfraStatusId == obj.instInfraStatusId}">
												<form:option value="${obj.instInfraStatusId}" selected="selected">${obj.instInfraStatusName}</form:option>
												</c:when>
												<c:otherwise>
												<form:option  value="${obj.instInfraStatusId}" >${obj.instInfraStatusName}</form:option>
												</c:otherwise>
												</c:choose>
													
												</c:if>
											</c:forEach>
										</form:select>
									</spring:bind>
								</td>
								<td align="center">
										<strong>${bhawanDto.totalFundApproved}</strong>
								</td>
								<td align="center">
								
										 <spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].expenditureIncurred" >
												<form:input id="nbs_${sindex}" onkeypress="return isNumber(event)"  path="${status.expression}"  class="form-control"  value="${status.value}" 
										maxlength="8" style="text-align:right;" required="required" autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[0].balanceAmount}',this)" readonly="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"/>
										</spring:bind>
										<span class="errormsg" id="error_nbs_${sindex}"></span>
								
										
									</td>
									<td align="left">
									<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].file" >
									 <c:choose>
									 	<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"><input type="file" id="file"  name="${status.expression}" disabled="disabled"/><br/></c:when>
									 	<c:otherwise><input type="file" id="file"  name="${status.expression}"/><br/></c:otherwise>
									 </c:choose>
									 	<c:if test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].fileNode.fileNodeId!=null }">
											<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].fileNode.fileNodeId}" target="_blank">
												<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
											</a>
										</c:if>
									</spring:bind>
									
									
									
									</td>
								</tr>
								 <c:set var="mindex" value="${mindex+1}" />
								  <c:set var="sindex" value="${sindex+1}" />
								 </c:if> 
								</c:forEach>
                           		<tr>
                          
									<td colspan="4">
										<strong>
											<spring:message code="Label.SubTotal" htmlEscape="true" />(SPRC)
										</strong>
									</td>
									<td>
										<input type="text" class="form-control" id="nbs_subtotal" disabled="disabled" style="text-align:right;"/>
										
									</td>
								</tr>
								<tr>
									<td colspan="4">
										<strong>
											<spring:message code="Label.AdditionalRequirement" htmlEscape="true" /> (SPRC)(Balance Additional Requirement:${balAddiReqSPRC})
											
										</strong>
									</td>
									<td>
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.additionalRequirement" >
										<input type="text" onkeypress="return isNumber(event)" id="nbs_addReq" class="form-control" name="${status.expression}"  value="${status.value}" onblur="calculcate_total(null,'nbs')"  maxlength="8" style="text-align:right;" autocomplete="off" readonly="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"/>
										</spring:bind>
										<span class="errormsg" id="error_nbs_addReq"></span>
									</td>
								</tr>
								<tr>
									<td colspan="4">
										<strong>
											<spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (SPRC)
										</strong>
									</td>
									<td>
										<input type="text" id="nbs_total" class="form-control"  style="text-align:right;" readonly="readonly"/>
										
									</td>
								</tr>
                                 
                                
											
                              </tbody>
                              
                             
                           </table>
                           <br/>
                           <br/>
                           
                           
                        </div>
                     </div>
						
					<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.NewBuilding" htmlEscape="true" />(DPRC)(Balance Amount:${subcomponentwiseQuaterBalanceList[1].balanceAmount})
                           </div>
                           
                            <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
										
										<th>
											<div align="center">
												<strong><spring:message code="Label.District" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.InstituteStatus" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ApprovedAmount" htmlEscape="true" /></strong>
											</div>
										</th>
										<%-- <th>
											<div align="center">
												<strong><spring:message code="Label.UploadFile" htmlEscape="true" /></strong>
											</div>
										</th> --%>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ExpenditureIncurred" htmlEscape="true" /></strong>
											</div>
										</th>
										 <th>
											<div align="left">
												<strong>file</strong>
											</div>
										</th> 
									</tr>
							  </thead>
                              <tbody id=tbodyIdNdprc">
                                  <c:set var="sindex" value="0" />
                               	    <c:forEach items="${instInfraStateDataForProgressReport}" var="bhawanDto" >
                       		<c:if test="${bhawanDto.workType eq 'N' and bhawanDto.institutionalActivityTypeId==4}">
                       		
								<tr>
								<td align="center">
										<strong>${bhawanDto.districtName}</strong>
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].qprInstInfraDetailsId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].trainingInstitueTypeId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalActivityTypeId}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].instituteInfrsaHrActivityDetailsId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalInfraActivityDetailId}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].fileNode.fileNodeId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
 							 			
								</td>
								<td align="center">
									<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].instInfraStatusId" >
											<form:select id="instInfraStatusIdNdprc${mindex}"
											 class="form-control"  path="${status.expression}" disabled="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}">
								 			<option value="0">Select Status</option>
											<c:forEach items="${InstInfraStatus}" var="obj" varStatus="count">
												<c:if test="${obj.trainingInstitueType.trainingInstitueTypeId==bhawanDto.institutionalActivityTypeId }">
												<c:choose>
												<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].instInfraStatusId == obj.instInfraStatusId}">
													<option  value="${obj.instInfraStatusId}" selected="selected" >${obj.instInfraStatusName}</option>
												</c:when>
												<c:otherwise>
												<option  value="${obj.instInfraStatusId}" >${obj.instInfraStatusName}</option>
												</c:otherwise>
												</c:choose>
													
												</c:if>
											</c:forEach>
										</form:select>
									</spring:bind>
								</td>
								<td align="center">
										<strong>${bhawanDto.totalFundApproved}</strong>
								</td>
								<td align="center">
								
										 <spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].expenditureIncurred" >
												<form:input id="nbd_${sindex}" onkeypress="return isNumber(event)"  path="${status.expression}"  class="form-control"  value="${status.value}" 
										maxlength="8" style="text-align:right;" required="required" autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[1].balanceAmount}',this,null)" readonly="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"/>
										</spring:bind>
										<span class="errormsg" id="error_nbd_${sindex}"></span>
								
										
									</td>
									<td align="left">
									<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].file" >
									 <c:choose>
									 	<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"><input type="file" id="file"  name="${status.expression}" disabled="disabled"/><br/></c:when>
									 	<c:otherwise><input type="file" id="file"  name="${status.expression}"/><br/></c:otherwise>
									 </c:choose>
									 	<c:if test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].fileNode.fileNodeId!=null }">
											<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].fileNode.fileNodeId}" target="_blank">
												<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
											</a>
										</c:if>
									</spring:bind>
								</td>
								</tr>
								 <c:set var="mindex" value="${mindex+1}" />
								 <c:set var="sindex" value="${sindex+1}" />
								 </c:if> 
								</c:forEach>
								<tr>
                          
									<td colspan="4">
										<strong>
											<spring:message code="Label.SubTotal" htmlEscape="true" />(DPRC)
										</strong>
									</td>
									<td>
										<input type="text" class="form-control" id="nbd_subtotal" disabled="disabled" style="text-align:right;"/>
										
									</td>
								</tr>
								<tr>
									<td colspan="4">
										<strong>
											<spring:message code="Label.AdditionalRequirement" htmlEscape="true" /> (DPRC)(Balance Additional Requirement:${balAddiReqDPRC})
											
										</strong>
									</td>
									<td>
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.additionalRequirementDPRC" >
										<input type="text" onkeypress="return isNumber(event)" id="nbd_addReq" class="form-control" name="${status.expression}"  value="${status.value}" onblur="calculcate_total(null,'nbd')"  maxlength="8" style="text-align:right;" autocomplete="off" readonly="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"/>
										</spring:bind>
										<span class="errormsg" id="error_nbd_addReq"></span>
									</td>
								</tr>
								<tr>
									<td colspan="4">
										<strong>
											<spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (DPRC)
										</strong>
									</td>
									<td>
										<input type="text" id="nbd_total" class="form-control"  style="text-align:right;" readonly="readonly"/>
										
									</td>
								</tr>
								
                              </tbody>
                             
                              
                             
                           </table>
                        </div>
                     </div>   	
						
					<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.CarryForward" htmlEscape="true" />(SPRC)(Balance Amount:${subcomponentwiseQuaterBalanceList[2].balanceAmount})
                           </div>
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                          
					  
							<br/>
                           <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
										
										<th>
											<div align="center">
												<strong><spring:message code="Label.District" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.InstituteStatus" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ApprovedAmount" htmlEscape="true" /></strong>
											</div>
										</th>
										<%-- <th>
											<div align="center">
												<strong><spring:message code="Label.UploadFile" htmlEscape="true" /></strong>
											</div>
										</th> --%>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ExpenditureIncurred" htmlEscape="true" /></strong>
											</div>
										</th>
										 <th>
											<div align="left">
												<strong>file</strong>
											</div>
										</th> 
									</tr>
										</thead>
                              <tbody id="tbodyIdCsprc">
                                  <c:set var="sindex" value="0" />
                                <c:forEach items="${instInfraStateDataForProgressReport}" var="bhawanDto" varStatus="count">
                       		<c:if test="${bhawanDto.workType eq 'C' and bhawanDto.institutionalActivityTypeId==2}">
								<tr>
								<td align="center">
										<strong>${bhawanDto.districtName}</strong>
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].qprInstInfraDetailsId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].trainingInstitueTypeId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalActivityTypeId}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].instituteInfrsaHrActivityDetailsId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalInfraActivityDetailId}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].fileNode.fileNodeId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].fileNode.fileNodeId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
 							 				
								</td>
								<td align="center">
									<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].instInfraStatusId" >
											<form:select id="instInfraStatusId${mindex}"
											 class="form-control"  path="${status.expression}" disabled="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}" >
								 			<option value="0">Select Status</option>
											<c:forEach items="${InstInfraStatus}" var="obj">
												<c:if test="${obj.trainingInstitueType.trainingInstitueTypeId==bhawanDto.institutionalActivityTypeId }">
												<c:choose>
												<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[sindex].instInfraStatusId == obj.instInfraStatusId}">
												<option  value="${obj.instInfraStatusId} selected ="selected" >${obj.instInfraStatusName}</option>
												</c:when>
												<c:otherwise>
												<option  value="${obj.instInfraStatusId}  " >${obj.instInfraStatusName}</option>
												</c:otherwise>
												</c:choose>
												
												</c:if>
											</c:forEach>
										</form:select>
									</spring:bind>
								</td>
								<td align="center">
										<strong>${bhawanDto.totalFundApproved}</strong>
								</td>
								<td align="center">
								
										 <spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].expenditureIncurred" >
												<form:input id="cfs_${sindex}" onkeypress="return isNumber(event)"  path="${status.expression}"  class="form-control"  value="${status.value}" 
										maxlength="8" style="text-align:right;" required="required" autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[2].balanceAmount}',this,null)" readonly="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"/>
										</spring:bind>
										<span class="errormsg" id="error_cfs_${sindex}"></span>
										
									</td>
									<td align="left">
									<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].file" >
									 <c:choose>
									 	<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"><input type="file" id="file"  name="${status.expression}" disabled="disabled"/><br/></c:when>
									 	<c:otherwise><input type="file" id="file"  name="${status.expression}"/><br/></c:otherwise>
									 </c:choose>
									 	<c:if test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].fileNode.fileNodeId!=null }">
											<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].fileNode.fileNodeId}" target="_blank">
												<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
											</a>
										</c:if>
									</spring:bind>
									
									
									
									</td>
								</tr>
								 <c:set var="mindex" value="${mindex+1}" />
								 <c:set var="sindex" value="${sindex+1}" />
								 </c:if> 
								</c:forEach>
								
								<tr>
									<td colspan="4">
										<strong>
											<spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (SPRC)
										</strong>
									</td>
									<td>
										<input type="text" id="cfs_total" class="form-control"  style="text-align:right;" readonly="readonly"/>
										
									</td>
								</tr>
                              </tbody>
                              
                           </table>
                           
					  
							<br/>
                           
                        </div>
                     </div>
						
						
						<div class="records">
                        	<div class="">
	                           <div  class="col-lg-12 sub_head">
	                              <spring:message code="Label.CarryForward" htmlEscape="true" />(DPRC)(Balance Amount:${subcomponentwiseQuaterBalanceList[3].balanceAmount})
	                           </div>
	                           <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
										
										<th>
											<div align="center">
												<strong><spring:message code="Label.District" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.InstituteStatus" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ApprovedAmount" htmlEscape="true" /></strong>
											</div>
										</th>
										<%-- <th>
											<div align="center">
												<strong><spring:message code="Label.UploadFile" htmlEscape="true" /></strong>
											</div>
										</th> --%>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ExpenditureIncurred" htmlEscape="true" /></strong>
											</div>
										</th>
										 <th>
											<div align="left">
												<strong>file</strong>
											</div>
										</th> 
									</tr>
										</thead>
                              <tbody id="tbodyId">
                                    <c:set var="sindex" value="0" />
									<c:forEach items="${instInfraStateDataForProgressReport}" var="bhawanDto" varStatus="count">
                       		<c:if test="${bhawanDto.workType eq 'C' and bhawanDto.institutionalActivityTypeId==4}">
								<tr>
								<td align="center">
										<strong>${bhawanDto.districtName}</strong>
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].qprInstInfraDetailsId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].trainingInstitueTypeId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalActivityTypeId}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].instituteInfrsaHrActivityDetailsId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalInfraActivityDetailId}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].fileNode.fileNodeId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
 							 				
								</td>
								<td align="center">
									<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].instInfraStatusId" >
											<form:select id="instInfraStatusId${mindex}"
											 class="form-control"  path="${status.expression}" disabled="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}">
								 			<option value="0">Select Status</option>
											<c:forEach items="${InstInfraStatus}" var="obj">
												<c:if test="${obj.trainingInstitueType.trainingInstitueTypeId==bhawanDto.institutionalActivityTypeId }">
													
													<c:choose>
												<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].instInfraStatusId == obj.instInfraStatusId}">
												<option  value="${obj.instInfraStatusId}" selected="selected">${obj.instInfraStatusName}</option>
												</c:when>
												<c:otherwise>
												<option  value="${obj.instInfraStatusId}" >${obj.instInfraStatusName}</option>
												</c:otherwise>
												</c:choose>
													
													
												</c:if>
											</c:forEach>
										</form:select>
									</spring:bind>
								</td>
								<td align="center">
										<strong>${bhawanDto.totalFundApproved}</strong>
								</td>
								<td align="center">
								
										 <spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].expenditureIncurred" >
												<form:input id="cfd_${sindex}" onkeypress="return isNumber(event)"  path="${status.expression}"  class="form-control"  value="${status.value}" 
										maxlength="8" style="text-align:right;" required="required" autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[3].balanceAmount}',this,null)" readonly="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"/>
										</spring:bind>
										<span class="errormsg" id="error_cfd_${sindex}"></span>
										
									</td>
									<td align="left">
									<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].file" >
									 <c:choose>
									 	<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"><input type="file" id="file"  name="${status.expression}" disabled="disabled"/><br/></c:when>
									 	<c:otherwise><input type="file" id="file"  name="${status.expression}"/><br/></c:otherwise>
									 </c:choose>
									 	<c:if test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].fileNode.fileNodeId!=null }">
											<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].fileNode.fileNodeId}" target="_blank">
												<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
											</a>
										</c:if>
									</spring:bind>
									
									
									
									</td>
								</tr>
								 <c:set var="mindex" value="${mindex+1}" />
								 <c:set var="sindex" value="${sindex+1}" />
								 </c:if> 
								</c:forEach>	
								
								<tr>
									<td colspan="4">
										<strong>
											<spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (DPRC)
										</strong>
									</td>
									<td>
										<input type="text" id="cfd_total" class="form-control"  style="text-align:right;" readonly="readonly"/>
										
									</td>
								</tr>	
                              </tbody>
                             
                           </table>
                           </div>
                         </div>	
                         
                         <div class="records">
								<div class="">
									<div  class="col-lg-12 sub_head">
										<!-- Grand Total -->
										
									</div>
									<div class="row">
										<div class="col-lg-12 padding_top"></div>
									</div>
									<table width="100%">
									<tfoot>
										<tr>
											<td colspan="4" width="60%">
												<strong>
													Grand Total(New Building Total Fund(SPRC)+New Building Total Fund(DPRC)+Carry Forward Total Fund(SPRC)+Carry Forward Total Fund(DPRC))
												</strong>
											</td>
											<td align="right" width="40%">
												<input type="text"  class="form-control" id="grandTotal" readonly="readonly" style="text-align:right;"/>
											</td>
										</tr>
									</tfoot>
									
									</table>
									<br/><br/>
										
								</div>
							</div>
                         
                         </c:if>

						<div class="form-group text-right">

							<c:if test="${installementExist}">
								<form:button onclick="save_data()" type="button"
									class="btn bg-green waves-effect"
									disabled="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}">
									<spring:message code="Label.SAVE" htmlEscape="true"/>
								</form:button>
								<c:choose>
									<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}">
										<form:button class="btn bg-orange waves-effect"
											onclick="FreezeAndUnfreeze('unfreeze')">UNFREEZE</form:button>
									</c:when>
									<c:otherwise>
										<form:button class="btn bg-orange waves-effect"
											disabled="${DISABLE_FREEZE}"
											onclick="FreezeAndUnfreeze('freeze')">FREEZE</form:button>
									</c:otherwise>
								</c:choose>
								<form:button type="button"
									data-ng-show="!institutionalInfraActivityPlan.isFreeze"
									data-ng-click="load_data()"
									class="btn bg-light-blue waves-effect"
									disabled="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</form:button>
							</c:if>
							<form:button type="button"
								onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
								class="btn bg-orange waves-effect">
								<spring:message code="Label.CLOSE" htmlEscape="true" />
							</form:button>
							<br /> <br />
						</div>
					</form:form>
				</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</html>