<%@include file="../taglib/taglib.jsp"%>
<%@include file="trainingDetailsProgressReportJs.jsp"%>




<style>
.padding_left_local {
   padding-left: 85px !important;
 }

</style>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<html>
	<section class="content">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Training Details Progress Report</h2>
						</div>
						
						<form:form method="POST" name="quarterTrainings" action="savetrainingProgressReport.html"
						modelAttribute="QPR_TRAINING_DETAILS" enctype="multipart/form-data" >
						<input type="hidden" name="<csrf:token-name/>"value="<csrf:token-value uri="savetrainingProgressReport.html" />" />
						<spring:bind path="QPR_TRAINING_DETAILS.qprTrainingsId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
						</spring:bind>
						<spring:bind path="QPR_TRAINING_DETAILS.trainingActivityId" >
										<input type="hidden" name="${status.expression}" value="${fetchTrainingCEC.trainingActivityId}" /> 
						</spring:bind>
						
						<span class="errormsg show" ><c:out value='${isError}' /></span>
						
						
						<div class="row" >
							<div class="form-group">
							<!-- <div class="col-lg-2" align="left"></div> -->
								<label for="QuaterDuration" class="col-sm-2" style="margin-left: 15px;"><spring:message code="Label.QuaterDuration" htmlEscape="true" />  :</label>
								<div class="col-lg-3">
									
									<select id="qtrId" class="form-control" name="qtrId" onchange="get_quater_wise_data(this.value)" required="required">
										<option value="0">Select Quarter Duration</option>
										
										<c:forEach items="${quarterDuration}" var="duration">
											<option  value="${duration.qtrId}" >${duration.qtrDuration}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>	 
									
					 
						<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                             (Balance Amount:${subcomponentwiseQuaterBalanceList[0].balanceAmount})
                           </div>
                           
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                           
                           
                           <table id="trainingActivityTblId" class="table table-hover dashboard-task-infos">
                             <thead>
								<tr>
									
									<th  align="left">
											<strong>Training Category</strong>
									</th>
									<th align="left" >
											<strong>Training Subjects</strong>
									</th>
									
									<th align="left">
											<strong>Venue Level</strong>
									</th>
									
									<th align="left">
											<strong>Approved Amount</strong>
									</th>
									
									
									<th align="left">
											<strong>Expenditure Incurred</strong>
									</th>
									<th>
										<strong>file</strong>
										
									</th>
								</tr>
							 </thead>
							 
							 
                              <c:forEach items="${fetchTrainingDetailsListCEC}" var="obj" varStatus="count">
                       			<tr>
								<td align="left">
										<strong>${obj.trainingCategoryName}</strong>
										<spring:bind path="QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[${count.index}].qprTrainingsDetailsId">
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[${count.index}].trainingActivityDetailsId">
										<input type="hidden" name="${status.expression}" value="${fetchTrainingDetailsListCEC[count.index].trainingId}" /> 
										</spring:bind>
										
										<spring:bind path="QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[${count.index}].fileNode.fileNodeId" >
										<input type="hidden" name="${status.expression}" value="${status.value}" /> 
										</spring:bind>
										
								
 							 				
								</td>
								<td align="left"><strong>${obj.subjectName}</strong></td>
								<td align="left"><strong>${obj.trainingVenueLevelName}</strong></td>
								<td align="left"><strong>${obj.funds}</strong></td>
								<td align="left">
								
										 <spring:bind path="QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[${count.index}].expenditureIncurred" >
												<input type="text" id="expenditureIncurred_${count.index}" onkeypress="return isNumber(event)"  name="${status.expression}"  class="form-control"  value="${status.value}" 
										maxlength="8" style="text-align:right;" required="required" autocomplete="off" onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[0].balanceAmount}',this)" />
										</spring:bind>
										<span class="errormsg" id="error_expenditureIncurred_${count.index}"></span>
								
										
									</td>
									<td align="left">
									<spring:bind path="QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[${count.index}].file" >
									 <input type="file" id="file"  name="${status.expression}"/><br/>
									 	<c:if test="${QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[count.index].fileNode.fileNodeId!=null }">
											<a type="button" class="btn btn-lg btn-success" href="downloadFileNew.html?fileNodeId=${QPR_TRAINING_DETAILS.quarterTrainingsDetailsList[count.index].fileNode.fileNodeId}" target="_blank">
												<span class="glyphicon glyphicon-download" aria-hidden="true"></span>Download File
											</a>
										</c:if>
									</spring:bind>
									
									
									
									</td>
								</tr>
								 
								</c:forEach>
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
											<spring:message code="Label.AdditionalRequirement" htmlEscape="true" /> (Balance Additional Requirement:${balAddiReq})
											
										</strong>
									</td>
									<td>
										<spring:bind path="QPR_TRAINING_DETAILS.additionalRequirement" >
										<input type="text" onkeypress="return isNumber(event)" id="addReq" class="form-control" name="${status.expression}"  value="${status.value}" onblur="calculcate_total(null,'expenditureIncurred')"  maxlength="8" style="text-align:right;" autocomplete="off"/>
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
                                 
                                
											
                              </tbody>
                              
                             
                           </table>
                           <br/>
                           <br/>
                           
                           
                        </div>
                     </div>
						
					
					</form:form>
						
						
								
									<div class="form-group text-right">
									 
								 <c:if test="${installementExist}">
								<button  onclick="save_data()" type="button" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
								
								<button type="button" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-click="load_data()" class="btn bg-light-blue waves-effect"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
								</c:if>
								<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-orange waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
								<br/>
								<br/>
							</div>
								</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</html>