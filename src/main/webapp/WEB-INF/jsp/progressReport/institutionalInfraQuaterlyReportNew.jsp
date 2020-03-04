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
										<input type="hidden" name="${status.expression}" value="${instInfraStateDataForProgressReport[0].institutionalInfraActivityId}" /> 
						</spring:bind> 
						 
						 
					<input type="hidden" name="qprInstInfraId" value="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstInfraId}" id="qprInstInfraId" />
										
					 
 					
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
                              <c:set var="mindex" value="0" scope="page" />
                              <c:set var="sindex" value="0" scope="page" />
                               <c:set var="nsindex" value="0" />
                              <c:forEach items="${instInfraStateDataForProgressReport}" var="bhawanDto"  varStatus="count">
                       		<c:if test="${bhawanDto.workType eq 'N' and bhawanDto.institutionalActivityTypeId==2}">
								<c:choose >
								
									<c:when test="${qprInstitutionalNewSprc ne null}">
						
						<tr>
								<td align="center">
										<strong>${qprInstitutionalNewSprc.qprInstitutionalInfraNewSprc[nsindex].districtName}</strong>
										<input type="hidden" name="qprInstitutionalInfraNewSprc[${nsindex}].qprInstInfraDetailsId" value="${qprInstitutionalNewSprc.qprInstitutionalInfraNewSprc[nsindex].qprInstInfraDetailsId}" /> 
										
										<input type="hidden" name="qprInstitutionalInfraNewSprc[${nsindex}].trainingInstitueTypeId" value="${bhawanDto.institutionalActivityTypeId}" /> 
										
										
										<input type="hidden"  name="qprInstitutionalInfraNewSprc[${nsindex}].instituteInfrsaHrActivityDetailsId" value="${qprInstitutionalNewSprc.qprInstitutionalInfraNewSprc[nsindex].instituteInfrsaHrActivityDetailsId}" /> 
									
									
										
										
										
										<input type="hidden" name="qprInstitutionalInfraNewSprc[${nsindex}].districtCode" value="${qprInstitutionalNewSprc.qprInstitutionalInfraNewSprc[nsindex].districtCode}" /> 
														
										
										<input type="hidden" name="qprInstitutionalInfraNewSprc[${nsindex}].fileNode.fileNodeId" value="${qprInstitutionalNewSprc.qprInstitutionalInfraNewSprc[nsindex].fileNode.fileNodeId}" /> 
		
 							 			
										<input type="hidden" name="qprInstitutionalInfraNewSprc[${nsindex}].workType" value="${qprInstitutionalNewSprc.qprInstitutionalInfraNewSprc[nsindex].workType}" /> 
										
										
 							 				
								</td>
								<td align="center">
									<%-- disabled="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}" --%>
											
											<c:if test="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"></c:if>
											<select id="instInfraStatusId${nsindex}"
											 class="form-control xxx"  name="qprInstitutionalInfraNewSprc[${nsindex}].instInfraStatusId"   >
								 			<option value="0">Select Status</option>
											<c:forEach items="${InstInfraStatus}" var="obj">
												<c:if test="${obj.trainingInstitueType.trainingInstitueTypeId==bhawanDto.institutionalActivityTypeId }">
												<c:choose>
												<c:when test="${qprInstitutionalNewSprc.qprInstitutionalInfraNewSprc[nsindex].instInfraStatusId == obj.instInfraStatusId}">
												<option  value="${obj.instInfraStatusId}" selected ="selected" >${obj.instInfraStatusName}</option>
												</c:when>
												<c:otherwise>
												<option  value="${obj.instInfraStatusId}  " >${obj.instInfraStatusName}</option>
												</c:otherwise>
												</c:choose>
												
												</c:if>
											</c:forEach>
										</select>
									
								</td>
								
								
								<td align="center">
										<strong>${bhawanDto.totalFundApproved}</strong>
								</td>
								<td align="center">
								
										
												<input id="nbs_${sindex}" onkeypress="return isNumber(event)"  name="qprInstitutionalInfraNewSprc[${nsindex}].expenditureIncurred" value="${qprInstitutionalNewSprc.qprInstitutionalInfraNewSprc[nsindex].expenditureIncurred}" class="form-control xxx"   
										maxlength="8" style="text-align:right;" required="required" autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[0].balanceAmount}',this)" />
										<%-- readonly="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze} --%>
										<span class="errormsg" id="error_nbs_${sindex}"></span>
										
									</td>
									
									
									
									<td align="left">
									<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraNewSprc[${nsindex}].file" >
									 <c:choose>
									 	<c:when test="${qprInstitutionalNewSprc.isFreeze}"><input type="file" id="file"  name="qprInstitutionalInfraNewSprc[${nsindex}].file" disabled="disabled"/><br/></c:when>
									 	<c:otherwise><input type="file" id="file"  name="${status.expression}"/><br/></c:otherwise>
									 </c:choose>
									 	<c:if test="${qprInstitutionalNewSprc.qprInstitutionalInfraNewSprc[nsindex].fileNode.fileNodeId!=null }">
											<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${qprInstitutionalNewSprc.qprInstitutionalInfraNewSprc[nsindex].fileNode.fileNodeId}" target="_blank">
												<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
											</a>
										</c:if>
									</spring:bind>
									
									
									
									</td>
									
									
									
								</tr>
								
								 <c:set var="nsindex" value="${nsindex+1}" />
						</c:when>
								
								
								
								<c:otherwise>
								
						<c:if test="${bhawanDto.workType eq 'N' and bhawanDto.institutionalActivityTypeId==2}">
						<tr>
								<td align="center">
										
										<strong>${bhawanDto.districtName}</strong>
								       
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraNewSprc[${nsindex}].qprInstInfraDetailsId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraNewSprc[${nsindex}].trainingInstitueTypeId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalActivityTypeId}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraNewSprc[${nsindex}].instituteInfrsaHrActivityDetailsId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalInfraActivityDetailId}" /> 
										</spring:bind>
									
										
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraNewSprc[${nsindex}].districtCode" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.districtCode}" /> 
										</spring:bind>
									
										
									
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraNewSprc[${nsindex}].fileNode.fileNodeId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
 							 			<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraNewSprc[${nsindex}].workType" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.workType}" /> 
										</spring:bind>
										
 							 				
								</td>
								<td align="center">
								
											<form:select id="instInfraStatusId${nsindex}" name="qprInstitutionalInfraNewSprc[${nsindex}].instInfraStatusId"
											 class="form-control"  path="${status.expression}" disabled="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}" >
								 			<option value="0">Select Status</option>
											<c:forEach items="${InstInfraStatus}" var="obj">
												<c:if test="${obj.trainingInstitueType.trainingInstitueTypeId==bhawanDto.institutionalActivityTypeId }">
												<c:choose>
												<c:when test="${qprInstitutionalNewSprc.qprInstitutionalInfraNewSprc[sindex].instInfraStatusId == obj.instInfraStatusId}">
												<option  value="${obj.instInfraStatusId}" selected ="selected" >${obj.instInfraStatusName}</option>
												</c:when>
												<c:otherwise>
												<option  value="${obj.instInfraStatusId}" >${obj.instInfraStatusName}</option>
												</c:otherwise>
												</c:choose>
												
												</c:if>
											</c:forEach>
										</form:select>
									
								</td>
								<td align="center">
										<strong>${bhawanDto.totalFundApproved}</strong>
								</td>
								
								
								<td align="center">
								
										 
												<input id="cfs_${sindex}" onkeypress="return isNumber(event)" name="qprInstitutionalInfraNewSprc[${nsindex}].expenditureIncurred"  class="form-control"  
										maxlength="8" style="text-align:right;" required="required" autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[2].balanceAmount}',this)" />
										
										<span class="errormsg" id="error_nbs_${sindex}"></span>
										
									</td>
									
									
									
									<td align="left">
									
									<%--  <c:choose>
									 	<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"><input type="file" id="file"  name="qprInstitutionalInfraNewSprc[${nsindex}].file" disabled="disabled"/><br/></c:when>
									 	<c:otherwise><input type="file" id="file"  name="qprInstitutionalInfraNewSprc[${nsindex}].file"/><br/></c:otherwise>
									 </c:choose>
									 	<c:if test="${qprInstitutionalNewSprc.qprInstitutionalInfraNewSprc[nsindex].fileNode.fileNodeId!=null }">
											<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${qprInstitutionalInfraNewSprc[nsindex].fileNode.fileNodeId}" target="_blank">
												<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
											</a>
										</c:if> --%>
						<input type="file" id="file"  name="qprInstitutionalInfraNewSprc[${nsindex}].file"/>		
									
									
									
									</td>
								</tr>
								 <c:set var="nsindex" value="${nsindex+1}" />
								 </c:if> 
								
								
								
								</c:otherwise>
								
								
								</c:choose>
								
								
								<%-- <tr>
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
								</tr> --%>
								 <c:set var="mindex" value="${mindex+1}" scope="page"  />
								  <c:set var="sindex" value="${sindex}" scope="page"  />
								 </c:if> 
								</c:forEach>
                           		<tr>
                          
									<td colspan="4">
										<strong>
											<spring:message code="Label.SubTotal" htmlEscape="true" />(SPRC)
										</strong>
									</td>
									<td>
										<input type="text" class="form-control nStotal" id="nbs_subtotal" disabled="disabled" style="text-align:right;"/>
										
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
										<input type="text" onkeypress="return isNumber(event)" id="nbs_addReq" class="form-control nsAdd" name="${status.expression}"  value="${status.value}" onblur="calculcate_total(null,'nbs')"  maxlength="8" style="text-align:right;" autocomplete="off" readonly="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"/>
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
                                  <c:set var="ndindex" value="0" />
                               	    <c:forEach items="${instInfraStateDataForProgressReport}" var="bhawanDto" varStatus="index">
                       		<c:if test="${bhawanDto.workType eq 'N' and bhawanDto.institutionalActivityTypeId==4}">
                       		
								<%-- <tr>
								
								
								
								
								<td align="center">
										
										<c:choose>
										<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].districtCode == null }">
										<strong>${bhawanDto.districtName}</strong>
										</c:when>
										
										<c:otherwise>
										<strong>${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].districtName}</strong>
									</c:otherwise>
										</c:choose> 
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].qprInstInfraDetailsId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].trainingInstitueTypeId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalActivityTypeId}" /> 
										</spring:bind>
										<c:choose>
										<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].instituteInfrsaHrActivityDetailsId ==null }">
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].instituteInfrsaHrActivityDetailsId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalInfraActivityDetailId}" /> 
										</spring:bind>
										</c:when>
										<c:otherwise>
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].instituteInfrsaHrActivityDetailsId" >
										<input type="hidden" name="${status.expression}" value="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].instituteInfrsaHrActivityDetailsId}" /> 
										</spring:bind>
									
										</c:otherwise>
										</c:choose>
										<c:choose>
										<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].districtCode ==null }">
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].districtCode" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.districtCode}" /> 
										</spring:bind>
										</c:when>
										<c:otherwise>
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[${mindex}].districtCode" >
										<input type="hidden" name="${status.expression}" value="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[mindex].districtCode}" /> 
										</spring:bind>
									
										</c:otherwise>
										</c:choose>
										
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
								 --%>
								
							<%-- 	<c:if test="${bhawanDto.workType eq 'N' and bhawanDto.institutionalActivityTypeId==4}"> --%>
                       	
                       		
                       		<c:choose>
                       		
                       		<c:when test="${qprInstitutional   ne null}">
                       		 
                       		<tr>
                       			
								<td align="center">
									<c:choose>
										<c:when test="${qprInstitutional.qprInstitutionalInfraNewDprc[ndindex].districtCode == null }">
										<strong>${bhawanDto.districtName}</strong>
										</c:when>
										
										<c:otherwise>
										<strong>${qprInstitutional.qprInstitutionalInfraNewDprc[ndindex].districtName}</strong>
									  </c:otherwise>
										</c:choose> 
										
										<input type="hidden" name="qprInstitutionalInfraNewDprc[${ndindex}].qprInstInfraDetailsId" value="${qprInstitutional.qprInstitutionalInfraNewDprc[ndindex].qprInstInfraDetailsId}" /> 
										
										
										<input type="hidden" name="qprInstitutionalInfraNewDprc[${ndindex}].trainingInstitueTypeId" value="${bhawanDto.institutionalActivityTypeId}" /> 
										
										<c:choose>
										<c:when test="${carryForwardDPRC[ndindex].instituteInfrsaHrActivityDetailsId ==null }">
									
										<input type="hidden" name="qprInstitutionalInfraNewDprc[${ndindex}].instituteInfrsaHrActivityDetailsId" value="${bhawanDto.institutionalInfraActivityDetailId}" /> 
						
										</c:when>
										<c:otherwise>
										
										<input type="hidden" name="qprInstitutionalInfraNewDprc[${ndindex}].instituteInfrsaHrActivityDetailsId" value="${qprInstitutional.qprInstitutionalInfraNewDprc[ndindex].instituteInfrsaHrActivityDetailsId}" /> 
		
									
										</c:otherwise>
										</c:choose>
										<c:choose>
										<c:when test="${qprInstitutional.qprInstitutionalInfraNewDprc[ndindex].districtCode ==null }">
										
										<input type="hidden" name="qprInstitutionalInfraNewDprc[${ndindex}].districtCode" value="${bhawanDto.districtCode}" /> 
				
										</c:when>
										<c:otherwise>
										
										<input type="hidden" name="qprInstitutionalInfraNewDprc[${ndindex}].districtCode" value="${qprInstitutional.qprInstitutionalInfraNewDprc[ndindex].districtCode}" /> 
										
									
										</c:otherwise>
										</c:choose>
										
										<input type="hidden" name="qprInstitutionalInfraNewDprc[${ndindex}].fileNode.fileNodeId" value="${qprInstitutional.qprInstitutionalInfraNewDprc[ndindex].fileNode.fileNodeId}" /> 
										
 															<c:choose>
										<c:when test="${qprInstitutional.qprInstitutionalInfraNewDprc[ndindex].workType ==null }">
										
	                                 <input type="hidden" name="qprInstitutionalInfraNewDprc[${ndindex}].workType" value="${bhawanDto.workType}" /> 				
										</c:when>
										<c:otherwise>
										
	                               <input type="hidden" name="qprInstitutionalInfraNewDprc[${ndindex}].workType" value="${qprInstitutional.qprInstitutionalInfraNewDprc[ndindex].workType}" /> 										
									
										</c:otherwise>
										</c:choose>
												
									
															
 							 		</td>
								<td align="center">
											<form:select id="instInfraStatusId${ndindex}" name ="qprInstitutionalInfraNewDprc[${ndindex}].instInfraStatusId"
											 class="form-control xxx"  path="${status.expression}" disabled="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}">
								 			<option value="0">Select Status</option>
											<c:forEach items="${InstInfraStatus}" var="obj">
												<c:if test="${obj.trainingInstitueType.trainingInstitueTypeId==bhawanDto.institutionalActivityTypeId }">
													
													<c:choose>
												<c:when test="${qprInstitutional.qprInstitutionalInfraNewDprc[ndindex].instInfraStatusId == obj.instInfraStatusId}">
												<option  value="${obj.instInfraStatusId}" selected="selected">${obj.instInfraStatusName}</option>
												</c:when>
												<c:otherwise>
												<option  value="${obj.instInfraStatusId}" >${obj.instInfraStatusName}</option>
												</c:otherwise>
												</c:choose>
													
													
												</c:if>
											</c:forEach>
										</form:select>
								</td>
								<td align="center">
										<strong>${bhawanDto.totalFundApproved}</strong>
								</td>
								<td align="center">
								
										
												<input id="nbd_${ndindex}" onkeypress="return isNumber(event)"  name="qprInstitutionalInfraNewDprc[${ndindex}].expenditureIncurred"  class="form-control xxx"  value="${qprInstitutional.qprInstitutionalInfraNewDprc[ndindex].expenditureIncurred}" 
										maxlength="8" style="text-align:right;" required="required" autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[1].balanceAmount}',this,null)" />
						
										<span class="errormsg" id="error_cfd_${ndindex}"></span>
										
									</td>
									<td align="left">
									
									 <c:choose>
									 	<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}">
									 	<input type="file" id="file"  name="qprInstitutionalInfraNewDprc[${ndindex}].file" value="${qprInstitutional.qprInstitutionalInfraNewDprc[ndindex].file}" disabled="disabled"/><br/></c:when>
									 	<c:otherwise><input type="file" id="file"  name="qprInstitutionalInfraNewDprc[${ndindex}].file" /><br/></c:otherwise>
									 </c:choose>
									 	<c:if test="${qprInstitutional.qprInstitutionalInfraNewDprc[ndindex].fileNode.fileNodeId!=null }">
											<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${qprInstitutional.qprInstitutionalInfraNewDprc[ndindex].fileNode.fileNodeId}" target="_blank">
												<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
											</a>
										</c:if>
								
									
									
									
									</td>
								</tr>
								 <c:set var="ndindex" value="${ndindex+1}" />
                       		</c:when>
                       		
                       		<c:otherwise>
                       		<c:if test="${bhawanDto.workType eq 'N' and bhawanDto.institutionalActivityTypeId==4}">
                       		
                       		<tr>
								<td align="center">
											<strong>${bhawanDto.districtName}</strong>
								       
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraNewDprc[${ndindex}].qprInstInfraDetailsId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraNewDprc[${ndindex}].trainingInstitueTypeId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalActivityTypeId}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraNewDprc[${ndindex}].instituteInfrsaHrActivityDetailsId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalInfraActivityDetailId}" /> 
										</spring:bind>
									
										
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraNewDprc[${ndindex}].districtCode" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.districtCode}" /> 
										</spring:bind>
									
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraNewDprc[${ndindex}].workType" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.workType}" /> 
										</spring:bind>
										
									
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraNewDprc[${ndindex}].fileNode.fileNodeId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
 								</td>
								<td align="center">
									
											<select id="instInfraStatusId${ndindex}" name="qprInstitutionalInfraNewDprc[${ndindex}].instInfraStatusId"
											 class="form-control"   >
								 			<option value="0">Select Status</option>
											<c:forEach items="${InstInfraStatus}" var="obj">
												<c:if test="${obj.trainingInstitueType.trainingInstitueTypeId==bhawanDto.institutionalActivityTypeId }">
													
													<c:choose>
												<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[ndindex].instInfraStatusId == obj.instInfraStatusId}">
												<option  value="${obj.instInfraStatusId}" selected="selected">${obj.instInfraStatusName}</option>
												</c:when>
												<c:otherwise>
												<option  value="${obj.instInfraStatusId}" >${obj.instInfraStatusName}</option>
												</c:otherwise>
												</c:choose>
													
													
												</c:if>
											</c:forEach>
										</select>
								
								</td>
								<td align="center">
										<strong>${bhawanDto.totalFundApproved}</strong>
								</td>
								<td align="center">
								
												<input id="nbd_${ndindex}" onkeypress="return isNumber(event)"    class="form-control" name="qprInstitutionalInfraNewDprc[${ndindex}].expenditureIncurred" 
										maxlength="8" style="text-align:right;" required="required" autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[1].balanceAmount}',this,null)" />
										
										<span class="errormsg" id="error_cfd_${ndindex}"></span>
										
									</td>
									<td align="left">
									<%-- <spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraNewDprc[${ndindex}].file" >
									 <c:choose>
									 	<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"><input type="file" id="file"  name="${status.expression}" disabled="disabled"/><br/></c:when>
									 	<c:otherwise><input type="file" id="file"  name="qprInstitutionalInfraNewDprc[ndindex].fileNode.fileNodeId"/><br/></c:otherwise>
									 </c:choose>
									 	<c:if test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[ndindex].fileNode.fileNodeId!=null }">
											<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${qprInstitutional.qprInstitutionalInfraNewDprc[mindex].fileNode.fileNodeId}" target="_blank">
												<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
											</a>
										</c:if>
									</spring:bind> --%>
									
									<input type="file" id="file"  name="qprInstitutionalInfraNewDprc[ndindex].fileNode.fileNodeId"/>
									
									</td>
								</tr>
								<c:set var="ndindex" value="${ndindex+1}" />
								 </c:if> 
                       		</c:otherwise>
                       		</c:choose>
								</c:if>
								
								
								
								
								 <c:set var="mindex" value="${mindex+1}" />
								 <c:set var="sindex" value="${sindex+1}" />
								
								</c:forEach>
								<tr>
                          
									<td colspan="4">
										<strong>
											<spring:message code="Label.SubTotal" htmlEscape="true" />(DPRC)
										</strong>
									</td>
									<td>
										<input type="text" class="form-control nDtotal" id="nbd_subtotal" disabled="disabled" style="text-align:right;"/>
										
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
										<input type="text" onkeypress="return isNumber(event)" id="nbd_addReq" class="form-control nDAdd" name="${status.expression}"  value="${status.value}" onblur="calculcate_total(null,'nbd')"  maxlength="8" style="text-align:right;" autocomplete="off" readonly="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"/>
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
						<!-- qprInstitutionalInfraNewSprc   qprInstitutionalInfraNewDprc   -->        
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
                                  <c:set var="csindex" value="0" />
                                <c:forEach items="${instInfraStateDataForProgressReport}" var="bhawanDto" varStatus="count">
                       		<c:if test="${bhawanDto.workType eq 'C' and bhawanDto.institutionalActivityTypeId==2}">
							<c:choose>
						<c:when test="${qprInstitutionalCarrySprc ne null}">
						
						<tr>
								<td align="center">
										<strong>${qprInstitutionalCarrySprc.qprInstitutionalInfraCarrySprc[csindex].districtName}</strong>
										<input type="hidden" name="qprInstitutionalInfraCarrySprc[${csindex}].qprInstInfraDetailsId" value="${qprInstitutionalCarrySprc.qprInstitutionalInfraCarrySprc[csindex].qprInstInfraDetailsId}" /> 
										
										<input type="hidden" name="qprInstitutionalInfraCarrySprc[${csindex}].trainingInstitueTypeId" value="${bhawanDto.institutionalActivityTypeId}" /> 
										
										
										<input type="hidden"  name="qprInstitutionalInfraCarrySprc[${csindex}].instituteInfrsaHrActivityDetailsId" value="${qprInstitutionalCarrySprc.qprInstitutionalInfraCarrySprc[csindex].instituteInfrsaHrActivityDetailsId}" /> 
									
									
										
										
										
										<input type="hidden" name="qprInstitutionalInfraCarrySprc[${csindex}].districtCode" value="${qprInstitutionalCarrySprc.qprInstitutionalInfraCarrySprc[csindex].districtCode}" /> 
														
										
										<input type="hidden" name="qprInstitutionalInfraCarrySprc[${csindex}].fileNode.fileNodeId" value="${qprInstitutionalCarrySprc.qprInstitutionalInfraCarrySprc[csindex].fileNode.fileNodeId}" /> 
		
 							 			
										<input type="hidden" name="qprInstitutionalInfraCarrySprc[${csindex}].workType" value="${qprInstitutionalCarrySprc.qprInstitutionalInfraCarrySprc[csindex].workType}" /> 
										
										
 							 				
								</td>
								<td align="center">
									<%-- disabled="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}" --%>
											<select id="instInfraStatusId${csindex}"
											 class="form-control xxx"  name="qprInstitutionalInfraCarrySprc[${csindex}].instInfraStatusId"   >
								 			<option value="0">Select Status</option>
											<c:forEach items="${InstInfraStatus}" var="obj">
												<c:if test="${obj.trainingInstitueType.trainingInstitueTypeId==bhawanDto.institutionalActivityTypeId }">
												<c:choose>
												<c:when test="${qprInstitutionalCarrySprc.qprInstitutionalInfraCarrySprc[csindex].instInfraStatusId == obj.instInfraStatusId}">
												<option  value="${obj.instInfraStatusId}" selected ="selected" >${obj.instInfraStatusName}</option>
												</c:when>
												<c:otherwise>
												<option  value="${obj.instInfraStatusId}  " >${obj.instInfraStatusName}</option>
												</c:otherwise>
												</c:choose>
												
												</c:if>
											</c:forEach>
										</select>
									
								</td>
								<td align="center">
										<strong>${bhawanDto.totalFundApproved}</strong>
								</td>
								<td align="center">
								
										
												<input id="cfs_${csindex}" onkeypress="return isNumber(event)"  name="qprInstitutionalInfraCarrySprc[${csindex}].expenditureIncurred" value="${qprInstitutionalCarrySprc.qprInstitutionalInfraCarrySprc[csindex].expenditureIncurred}" class="form-control xxx"   
										maxlength="8" style="text-align:right;" required="required" autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[2].balanceAmount}',this,null)" />
										<%-- readonly="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze} --%>
										<span class="errormsg" id="error_cfs_${sindex}"></span>
										
									</td>
									<td align="left">
								<%-- 	<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraCarrySprc[${csindex}].file" >
									 <c:choose>
									 	<c:when test="${qprInstitutionalCarrySprc.isFreeze}"><input type="file" id="file"  name="qprInstitutionalInfraCarrySprc[${csindex}].file" disabled="disabled"/><br/></c:when>
									 	<c:otherwise><input type="file" id="file"  name="${status.expression}"/><br/></c:otherwise>
									 </c:choose>
									 	<c:if test="${qprInstitutionalCarrySprc.qprInstitutionalInfraCarrySprc[csindex].fileNode.fileNodeId!=null }">
											<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${qprInstitutionalCarrySprc.qprInstitutionalInfraCarrySprc[csindex].fileNode.fileNodeId}" target="_blank">
												<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
											</a>
										</c:if>
									</spring:bind> --%>
									
									 <c:choose>
									 	<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}">
									 	<input type="file" id="file"  name="qprInstitutionalInfraCarrySprc[${csindex}].file" value="${qprInstitutionalCarrySprc.qprInstitutionalInfraCarrySprc[csindex].file}" disabled="disabled"/><br/></c:when>
									 	<c:otherwise><input type="file" id="file"  name="qprInstitutionalInfraCarrySprc[${csindex}].file" /><br/></c:otherwise>
									 </c:choose>
									 	<c:if test="${qprInstitutionalCarrySprc.qprInstitutionalInfraCarrySprc[csindex].fileNode.fileNodeId!=null }">
											<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${qprInstitutionalCarrySprc.qprInstitutionalInfraCarrySprc[csindex].fileNode.fileNodeId}" target="_blank">
												<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
											</a>
										</c:if>
									
									</td>
								</tr>
								
								 <c:set var="csindex" value="${csindex+1}" />
						</c:when>	
						<c:otherwise>
						
						<c:if test="${bhawanDto.workType eq 'C' and bhawanDto.institutionalActivityTypeId==2}">
						<tr>
								<td align="center">
										
										<strong>${bhawanDto.districtName}</strong>
								       
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraCarrySprc[${csindex}].qprInstInfraDetailsId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraCarrySprc[${csindex}].trainingInstitueTypeId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalActivityTypeId}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraCarrySprc[${csindex}].instituteInfrsaHrActivityDetailsId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalInfraActivityDetailId}" /> 
										</spring:bind>
									
										
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraCarrySprc[${csindex}].districtCode" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.districtCode}" /> 
										</spring:bind>
									
										
									
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraCarrySprc[${csindex}].fileNode.fileNodeId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
 							 			<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraCarrySprc[${csindex}].workType" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.workType}" /> 
										</spring:bind>
										
 							 				
								</td>
								<td align="center">
								
											<form:select id="instInfraStatusId${csindex}" name="qprInstitutionalInfraCarrySprc[${csindex}].instInfraStatusId"
											 class="form-control"  path="${status.expression}" disabled="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}" >
								 			<option value="0">Select Status</option>
											<c:forEach items="${InstInfraStatus}" var="obj">
												<c:if test="${obj.trainingInstitueType.trainingInstitueTypeId==bhawanDto.institutionalActivityTypeId }">
												<c:choose>
												<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[sindex].instInfraStatusId == obj.instInfraStatusId}">
												<option  value="${obj.instInfraStatusId}" selected ="selected" >${obj.instInfraStatusName}</option>
												</c:when>
												<c:otherwise>
												<option  value="${obj.instInfraStatusId}" >${obj.instInfraStatusName}</option>
												</c:otherwise>
												</c:choose>
												
												</c:if>
											</c:forEach>
										</form:select>
									
								</td>
								<td align="center">
										<strong>${bhawanDto.totalFundApproved}</strong>
								</td>
								<td align="center">
								
										 
												<input id="cfs_${csindex}" onkeypress="return isNumber(event)" name="qprInstitutionalInfraCarrySprc[${csindex}].expenditureIncurred"  class="form-control"  
										maxlength="8" style="text-align:right;" required="required" autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[2].balanceAmount}',this,null)" />
										
										<span class="errormsg" id="error_cfs_${sindex}"></span>
										
									</td>
									<td align="left">
									
									<%--  <c:choose>
									 	<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"><input type="file" id="file"  name="qprInstitutionalInfraCarrySprc[${csindex}].file" disabled="disabled"/><br/></c:when>
									 	<c:otherwise><input type="file" id="file"  name="qprInstitutionalInfraCarrySprc[${csindex}].file"/><br/></c:otherwise>
									 </c:choose>
									 	<c:if test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[csindex].fileNode.fileNodeId!=null }">
											<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${qprInstitutionalInfraDetails[csindex].fileNode.fileNodeId}" target="_blank">
												<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
											</a>
										</c:if> --%>
							<input type="file" id="file"  name="qprInstitutionalInfraCarrySprc[${csindex}].file"/>	
									
									
									
									</td>
								</tr>
								 <c:set var="csindex" value="${csindex+1}" />
								 </c:if> 
						</c:otherwise>	
							</c:choose></c:if>
									
								</c:forEach>
								
								<tr>
									<td colspan="4">
										<strong>
											<spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (SPRC)
										</strong>
									</td>
									<td>
										<input type="text" id="cfs_total" class="form-control cStotal"  style="text-align:right;" readonly="readonly"/>
										
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
	                           <c:set var="cdindex" value="0" />
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
                                   
									<c:forEach items="${instInfraStateDataForProgressReport}" var="bhawanDto" varStatus="count">
                       		
                       		
                       		<c:if test="${bhawanDto.workType eq 'C' and bhawanDto.institutionalActivityTypeId==4}">
                       	
                       		
                       		<c:choose>
                       		
                       		<c:when test="${qprInstitutionalCarryDprc   ne null}">
                       		
                       		<tr>
                       			
								<td align="center">
									<c:choose>
										<c:when test="${qprInstitutionalCarryDprc.qprInstitutionalInfraCarryDprc[cdindex].districtCode == null }">
										<strong>${bhawanDto.districtName}</strong>
										</c:when>
										
										<c:otherwise>
										<strong>${qprInstitutionalCarryDprc.qprInstitutionalInfraCarryDprc[cdindex].districtName}</strong>
									  </c:otherwise>
										</c:choose> 
										
										<input type="hidden" name="qprInstitutionalInfraCarryDprc[${cdindex}].qprInstInfraDetailsId" value="${qprInstitutionalCarryDprc.qprInstitutionalInfraCarryDprc[cdindex].qprInstInfraDetailsId}" /> 
										
										
										<input type="hidden" name="qprInstitutionalInfraCarryDprc[${cdindex}].trainingInstitueTypeId" value="${bhawanDto.institutionalActivityTypeId}" /> 
										
										<c:choose>
										<c:when test="${carryForwardDPRC[cdindex].instituteInfrsaHrActivityDetailsId ==null }">
									
										<input type="hidden" name="qprInstitutionalInfraCarryDprc[${cdindex}].instituteInfrsaHrActivityDetailsId" value="${bhawanDto.institutionalInfraActivityDetailId}" /> 
						
										</c:when>
										<c:otherwise>
										
										<input type="hidden" name="qprInstitutionalInfraCarryDprc[${cdindex}].instituteInfrsaHrActivityDetailsId" value="${qprInstitutionalCarryDprc.qprInstitutionalInfraCarryDprc[cdindex].instituteInfrsaHrActivityDetailsId}" /> 
		
									
										</c:otherwise>
										</c:choose>
										<c:choose>
										<c:when test="${qprInstitutionalCarryDprc.qprInstitutionalInfraCarryDprc[cdindex].districtCode ==null }">
										
										<input type="hidden" name="qprInstitutionalInfraCarryDprc[${cdindex}].districtCode" value="${bhawanDto.districtCode}" /> 
				
										</c:when>
										<c:otherwise>
										
										<input type="hidden" name="qprInstitutionalInfraCarryDprc[${cdindex}].districtCode" value="${qprInstitutionalCarryDprc.qprInstitutionalInfraCarryDprc[cdindex].districtCode}" /> 
										
									
										</c:otherwise>
										</c:choose>
										
										<input type="hidden" name="qprInstitutionalInfraCarryDprc[${cdindex}].fileNode.fileNodeId" value="${qprInstitutionalCarryDprc.qprInstitutionalInfraCarryDprc[cdindex].fileNode.fileNodeId}" /> 
										
 															<c:choose>
										<c:when test="${qprInstitutionalCarryDprc.qprInstitutionalInfraCarryDprc[cdindex].workType ==null }">
										
	                                 <input type="hidden" name="qprInstitutionalInfraCarryDprc[${cdindex}].workType" value="${bhawanDto.workType}" /> 				
										</c:when>
										<c:otherwise>
										
	                               <input type="hidden" name="qprInstitutionalInfraCarryDprc[${cdindex}].workType" value="${qprInstitutionalCarryDprc.qprInstitutionalInfraCarryDprc[cdindex].workType}" /> 										
									
										</c:otherwise>
										</c:choose>
												
									
															
 							 		</td>
								<td align="center">
											<form:select id="instInfraStatusId${cdindex}" name ="qprInstitutionalInfraCarryDprc[${cdindex}].instInfraStatusId"
											 class="form-control xxx"  path="${status.expression}" disabled="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}">
								 			<option value="0">Select Status</option>
											<c:forEach items="${InstInfraStatus}" var="obj">
												<c:if test="${obj.trainingInstitueType.trainingInstitueTypeId==bhawanDto.institutionalActivityTypeId }">
													
													<c:choose>
												<c:when test="${qprInstitutionalCarryDprc.qprInstitutionalInfraCarryDprc[cdindex].instInfraStatusId == obj.instInfraStatusId}">
												<option  value="${obj.instInfraStatusId}" selected="selected">${obj.instInfraStatusName}</option>
												</c:when>
												<c:otherwise>
												<option  value="${obj.instInfraStatusId}" >${obj.instInfraStatusName}</option>
												</c:otherwise>
												</c:choose>
													
													
												</c:if>
											</c:forEach>
										</form:select>
								</td>
								<td align="center">
										<strong>${bhawanDto.totalFundApproved}</strong>
								</td>
								<td align="center">
								
										
												<input id="cfd_${cdindex}" onkeypress="return isNumber(event)"  name="qprInstitutionalInfraCarryDprc[${cdindex}].expenditureIncurred"  class="form-control xxx"  value="${qprInstitutionalCarryDprc.qprInstitutionalInfraCarryDprc[cdindex].expenditureIncurred}" 
										maxlength="8" style="text-align:right;" required="required" autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[3].balanceAmount}',this,null)" />
						
										<span class="errormsg" id="error_cfd_${cdindex}"></span>
										
									</td>
									<td align="left">
									
									 <c:choose>
									 	<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}">
									 	<input type="file" id="file"  name="qprInstitutionalInfraCarryDprc[${cdindex}].file" value="${qprInstitutionalCarryDprc.qprInstitutionalInfraCarryDprc[cdindex].file}" disabled="disabled"/><br/></c:when>
									 	<c:otherwise><input type="file" id="file"  name="qprInstitutionalInfraCarryDprc[${cdindex}].file" /><br/></c:otherwise>
									 </c:choose>
									 	<c:if test="${qprInstitutionalCarryDprc.qprInstitutionalInfraCarryDprc[cdindex].fileNode.fileNodeId!=null }">
											<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${qprInstitutionalCarryDprc.qprInstitutionalInfraCarryDprc[cdindex].fileNode.fileNodeId}" target="_blank">
												<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
											</a>
										</c:if>
								
									
									
									
									</td>
								</tr>
								 <c:set var="cdindex" value="${cdindex+1}" />
                       		</c:when>
                       		
                       		<c:otherwise>
                       		<c:if test="${bhawanDto.workType eq 'C' and bhawanDto.institutionalActivityTypeId==4}">
                       		
                       		<tr>
								<td align="center">
											<strong>${bhawanDto.districtName}</strong>
								       
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraCarryDprc[${cdindex}].qprInstInfraDetailsId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraCarryDprc[${cdindex}].trainingInstitueTypeId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalActivityTypeId}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraCarryDprc[${cdindex}].instituteInfrsaHrActivityDetailsId" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.institutionalInfraActivityDetailId}" /> 
										</spring:bind>
									
										
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraCarryDprc[${cdindex}].districtCode" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.districtCode}" /> 
										</spring:bind>
									
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraCarryDprc[${cdindex}].workType" >
										<input type="hidden" name="${status.expression}" value="${bhawanDto.workType}" /> 
										</spring:bind>
										
									
										
										<spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraCarryDprc[${cdindex}].fileNode.fileNodeId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
 								</td>
								<td align="center">
									
											<select id="instInfraStatusId${cdindex}" name="qprInstitutionalInfraCarryDprc[${cdindex}].instInfraStatusId"
											 class="form-control"   >
								 			<option value="0">Select Status</option>
											<c:forEach items="${InstInfraStatus}" var="obj">
												<c:if test="${obj.trainingInstitueType.trainingInstitueTypeId==bhawanDto.institutionalActivityTypeId }">
													
													<c:choose>
												<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[cdindex].instInfraStatusId == obj.instInfraStatusId}">
												<option  value="${obj.instInfraStatusId}" selected="selected">${obj.instInfraStatusName}</option>
												</c:when>
												<c:otherwise>
												<option  value="${obj.instInfraStatusId}" >${obj.instInfraStatusName}</option>
												</c:otherwise>
												</c:choose>
													
													
												</c:if>
											</c:forEach>
										</select>
								
								</td>
								<td align="center">
										<strong>${bhawanDto.totalFundApproved}</strong>
								</td>
								<td align="center">
								
												<input id="cfd_${cdindex}" onkeypress="return isNumber(event)"    class="form-control" name="qprInstitutionalInfraCarryDprc[${cdindex}].expenditureIncurred" 
										maxlength="8" style="text-align:right;" required="required" autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[3].balanceAmount}',this,null)" />
										
										<span class="errormsg" id="error_cfd_${cdindex}"></span>
										
									</td>
									<td align="left">
									<%-- <spring:bind path="QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraCarryDprc[${cdindex}].file" >
									 <c:choose>
									 	<c:when test="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}"><input type="file" id="file"  name="${status.expression}" disabled="disabled"/><br/></c:when>
									 	<c:otherwise><input type="file" id="file"  name="${status.expression}"/><br/></c:otherwise>
									 </c:choose>
									 	<c:if test="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[cdindex].fileNode.fileNodeId!=null }">
											<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${qprInstitutionalCarryDprc.qprInstitutionalInfraCarryDprc[mindex].fileNode.fileNodeId}" target="_blank">
												<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
											</a>
										</c:if>
									</spring:bind> --%>
						       <input type="file" id="file"  name="qprInstitutionalInfraCarryDprc[${cdindex}].file"/>			
									
									
									</td>
								</tr>
								<c:set var="cdindex" value="${cdindex+1}" />
								 </c:if> 
                       		</c:otherwise>
                       		</c:choose>
								</c:if>
								 <c:set var="mindex" value="${mindex+1}" />
								
								
								</c:forEach>	
								
								<tr>
									<td colspan="4">
										<strong>
											<spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (DPRC)
										</strong>
									</td>
									<td>
										<input type="text" id="cfd_total" class="form-control cDtotal"  style="text-align:right;" readonly="readonly"/>
										
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
												<input type="text"  class="form-control gt" id="grandTotal" readonly="readonly" style="text-align:right;"/>
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
								<%-- <form:button type="button"
									data-ng-show="!institutionalInfraActivityPlan.isFreeze"
									data-ng-click="load_data()"
									class="btn bg-light-blue waves-effect"
									disabled="${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</form:button> --%>
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
	</section>
</html>

<script>
	
$( document ).ready(function() {
	$('.cDtotal').val('${countCDprc}');
	$('.cStotal').val('${countCSprc}');
	$('.nStotal').val('${countNSprc}');
	$('.nDtotal').val('${countNDprc}');
	    $('.nsAdd').val('0');
	    $('.nDAdd').val('0');
	var nSadd =$('.gt').val();
	
	var freeze ='${QPR_INSTITUTIONALINFRAQUATERLY.isFreeze}';
	$("#qtrId option[value='${QPR_INSTITUTIONALINFRAQUATERLY.qtrId}']").attr("selected", "selected");
	if(freeze ==='true'){
		$('.xxx').prop("disabled" ,"disabled");
	}
	//loadElement();
});
</script>