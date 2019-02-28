<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/trainingDetails/training-Details.js"></script>
<section class="content">
		<div class="container-fluid">
	    	<div class="row clearfix">
	        	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
	            	<div class="card">
	                	<div class="header">
	                    	<h2><spring:message code="Label.TrainingDetailsHeader" htmlEscape="true" /></h2>
	                    </div>
					<form:form action="saveCapctyBuldngPln.html" id="cpbaddtrainingID" class="form-inline" name="cpbaddtraining" modelAttribute="CBP_ADDTRAINING" method="POST">
	                    <div class="body">
	                    <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
	                    	<div class="form-group text-right">
	                    	 <c:if test="${not empty allTrainingActivity}">
	                    			<c:if test="${allTrainingActivity.isFreeze == false}">
	                            	<a href="addTrainings.html?<csrf:token uri='addTrainings.html'/>" class="btn bg-green waves-effect"> ADD TRAININGS</a>
	                            	</c:if>
	                          </c:if>
	                           <c:if test="${empty allTrainingActivity}">
	                           <a href="addTrainings.html?<csrf:token uri='addTrainings.html'/>" class="btn bg-green waves-effect"> ADD TRAININGS</a>
	                           </c:if>
	                     </div>
	                    </c:if>
	                    <br />
	                    <br />
						<input type="hidden" name="<csrf:token-name/>" value="<csrf:token-value uri="saveCapctyBuldngPln.html"/>" />
	                    	<div class="table-responsive">
                                <table id="trainingActivityTblId" class="table table-bordered table-striped table-hover dataTable">
                                    <thead> 
								        <tr>
								             <th rowspan="2"><spring:message code="S No." htmlEscape="true" /></th>
								             <th rowspan="2"><spring:message code="Training Category" htmlEscape="true" /></th>
								             <th rowspan="2"><spring:message code="Training Subjects" htmlEscape="true" /></th>
								             <th rowspan="2"><spring:message code="Training Target Group" htmlEscape="true" /></th>
								             <th rowspan="2"><spring:message code="Venue Level" htmlEscape="true" /></th>
								             <th rowspan="2"><spring:message text="Mode Of Training" htmlEscape="true" /></th>
								             <th rowspan="2"><spring:message code="No. of Participants" htmlEscape="true" /></th>
								             <th rowspan="2"><spring:message code="No.of Days" htmlEscape="true" /></th>
								             <th rowspan="2"><spring:message code="Unit Cost" htmlEscape="true" /></th>
								             <th rowspan="2"><spring:message code="Funds Proposed" htmlEscape="true" /></th>
								             <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
								             	<th rowspan="2" width="5%"><spring:message text="Is Approved" htmlEscape="true" /></th>
								             	<th rowspan="2" width="5%"><spring:message code="Remarks" htmlEscape="true" /></th>
								             </c:if>
								              <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
								             	<th rowspan="2" width="5%"><spring:message text="Is Approved" htmlEscape="true" /></th>
								             	<th rowspan="2" width="5%"><spring:message code="Remarks" htmlEscape="true" /></th>
								             </c:if>
								              <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
						                     <th colspan="3" width="10%"><spring:message code="Action" htmlEscape="true" /></th>
						               </tr>
						                  <tr>
						                      <th><spring:message code="Modify" htmlEscape="true" /></th>
						                      <th><spring:message code="Delete" htmlEscape="true" /></th>
						                  </tr>
						                  </c:if>
						    		</thead> 
                                    <tbody id="tbodyState">
	                                        <c:choose>
	                                        	<c:when test="${not empty allTrainingActivity}">
	                                        	<c:forEach items="${allTrainingActivity.trainingActivityDetailsList}" var="obj" varStatus="count">
	                                        		<tr>
			                                            <td>${count.count}</td>
			                                           <td><input type="text" class="form-control" name="trainingActivityDetailsList[${count.index}].trainingCategoryId.trainingCategoryName" readonly="readonly" value="${obj.trainingCategoryId.trainingCategoryName}" ></td>
			                                            	
															<td><%-- <select class="form-control" name="trainingActivityDetailsList[${count.index}].trainingSubjectsArray"  multiple="multiple"> --%>
															<form:select path="trainingActivityDetailsList[${count.index}].trainingSubjectsArray" id="sbjctListId" disabled="true" multiple="true" cssClass="form-control sbjctClass">
						                                            <c:forEach items="${obj.trainingSubjectsList}" var="subj" >
																			 	<option value="${subj.trngSubjectId.subjectId}" selected="selected">${subj.trngSubjectId.subjectName} </option>
																		</c:forEach>
																<!--  </select> -->
																 </form:select>
															</td>
				                                        <td><%-- <select class="form-control" name="trainingActivityDetailsList[${count.index}].trainingTargetGroupsArray" multiple="multiple"> --%>
				                                        <form:select path="trainingActivityDetailsList[${count.index}].trainingTargetGroupsArray"  disabled="true"  cssClass="form-control trgtClass"  multiple="true">
						                                        <c:forEach items="${obj.trainingTargetGroupsList}" var="trgt" >
							                                    	<option value="${trgt.targetGroupMasterId.targetGroupMasterId}" selected="selected">${trgt.targetGroupMasterId.targetGroupMasterName} </option>
						                                         </c:forEach>
						                                     <!-- </select> -->
						                                     </form:select>
			                                            </td>
			                                            <td><input type="text" class="form-control" readonly="readonly"  value="${obj.trainingVenueLevelId.trainingVenueLevelName}">
			                                            	<input type="hidden" class="form-control" readonly="readonly" name="trainingActivityDetailsList[${count.index}].trainingVenueLevelId.trainingVenueLevelId" value="${obj.trainingVenueLevelId.trainingVenueLevelId}">
			                                            </td>
			                                             <td><input type="text" class="form-control" readonly="readonly"  value="${obj.trainingMode.trainingModeName}">
			                                             	<input type="hidden" class="form-control" readonly="readonly" name="trainingActivityDetailsList[${count.index}].trainingMode.trainingModeId" value="${obj.trainingMode.trainingModeId}">
			                                             </td>	
			                                            <td><input type="text" class="form-control" readonly="readonly" name="trainingActivityDetailsList[${count.index}].noOfParticipants" value="${obj.noOfParticipants}" style="text-align:right;" ></td>
			                                            <td><input type="text" class="form-control" readonly="readonly" name="trainingActivityDetailsList[${count.index}].noOfDays" value="${obj.noOfDays}"  style="text-align:right;"></td>
			                                            <td><input type="text" class="form-control fundsName" readonly="readonly" name="trainingActivityDetailsList[${count.index}].unitCost" value="${obj.unitCost}"  style="text-align:right;"></td>
			                                            <c:set var="totalFundToCalc" value="${totalFundToCalc + obj.funds}"></c:set>
			                                           	 <td><input type="text" maxlength="8" min="1" class="form-control" readonly="readonly" name="trainingActivityDetailsList[${count.index}].funds" id="fundsName" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="${obj.funds}" style="text-align:right;"></td>
			                                            
			                                            <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
			                                            	<td>
				                                            	<c:choose>
																	<c:when test="${obj.isApproved}">
																		<input type="checkbox" name="trainingActivityDetailsList[${count.index}].isApproved" class="form-control"  checked="checked">
																	</c:when>
																	<c:otherwise>
																		<input type="checkbox" name="trainingActivityDetailsList[${count.index}].isApproved" >
																	</c:otherwise>
																</c:choose>
															</td>
			                                            	<td><input type="text" class="form-control" name="trainingActivityDetailsList[${count.index}].remarks" value="${obj.remarks}" ></td>
			                                            </c:if>
			                                             <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
			                                            	<td>
				                                            	<c:choose>
																	<c:when test="${obj.isApproved}">
																		<input type="checkbox" name="trainingActivityDetailsList[${count.index}].isApproved" class="form-control"  checked="checked">
																	</c:when>
																	<c:otherwise>
																		<input type="checkbox" name="trainingActivityDetailsList[${count.index}].isApproved" >
																	</c:otherwise>
																</c:choose>
															</td>
			                                            	<td><input type="text" class="form-control" name="trainingActivityDetailsList[${count.index}].remarks" value="${obj.remarks}" ></td>
			                                            </c:if>
			                                            <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
					                                        <c:choose>
					                                            <c:when test="${allTrainingActivity.isFreeze == false}">
					                                            	<td><button type="button" id="modifyButtn"  onclick="toModify('${obj.trainingActivityDetailsId}');" class="btn bg-light-orange waves-effect" >Modify</button></td>
					                                            	<td><button type="button" id="deleteButtn" onclick="toDelete('${obj.trainingActivityDetailsId}');" class="btn bg-light-red waves-effect" >Delete</button></td>
					                                        	</c:when>
					                                        	<c:otherwise>
					                                        		<td><button type="button" id="modifyButtn" disabled="disabled" value="${obj.trainingActivityDetailsId}" class="btn bg-light-orange waves-effect" >Modify</button></td>
					                                            	<td><button type="button" id="deleteButtn" disabled="disabled" onclick="toDelete('${obj.trainingActivityDetailsId}');" class="btn bg-light-red waves-effect" >Delete</button></td>
					                                        	</c:otherwise>
					                                       </c:choose> 	
			                                     	  </c:if>
			                                        </tr>
			                                        <input type ="hidden" name="trainingActivityDetailsList[${count.index}].trainingActivityDetailsId" value="${obj.trainingActivityDetailsId}" />	
			                                        <input type="hidden" name="trainingActivityDetailsList[${count.index}].trainingCategoryId.trainingCategoryId" id="catogryId" value="${obj.trainingCategoryId.trainingCategoryId}" >
			                                        <input type="hidden" name="userType" id="userTypeId" value="${allTrainingActivity.userType}" >
			                                      </c:forEach>  
	                                        	</c:when>
	                                        	<c:otherwise>
	                                        		<tr><td class="text-center" colspan="12"><b class="delete-color">
	                                        			<i class="fa fa-smile-o" aria-hidden="true"></i> There are no Training Details</b>
	                                        		</td>
	                                        		</tr>
	                                        	</c:otherwise>
	                                        </c:choose>
	                                      <%--  <c:if test="${not empty allTrainingActivity}">
	                                       <tr>
	                                       <th> <label >Total Funds</label></th>
	                                       
	                                       </tr>
	                                       </c:if>  --%>
                                    </tbody> 
                                </table>
                            </div><br>
                             <c:if test="${not empty allTrainingActivity}">
                            <div class="row clearfix">
                            		<div class="col-sm-4">
		                            <label >Total Funds</label></div>
		                            <div class="col-sm-8">
		                                 <input type="text" class="form-control" id="subTotal" value="${totalFundToCalc}" readonly="readonly" style="text-align:right;">
	                                </div>
	                            </div>
	                            <div class="row clearfix">
	                            <div class="col-sm-4">
		                            <label >Additional Requirements</label>
		                       </div>
		                       <div class="col-sm-8">
		                            <c:set var="addtnlReqrmnt" value="${addtnlReqrmnt + allTrainingActivity.additionalRequirement}"></c:set>
		                            <input type="text" oninput="validity.valid||(value='');" onkeypress="return isNumber(event)" class="form-control"  value="${allTrainingActivity.additionalRequirement}" min="1" name="additionalRequirement" id="additioinalRequirements" required="required" style="text-align:right;">
		                       </div>
	                           </div> 
	                           <div class="row clearfix">
	                            <div class="col-sm-4">
		                            <label > Total Proposed Fund</label>
		                        </div>
		                        <div class="col-sm-8">   
		                            <input type="text" class="form-control" id="grandTotal" value="${addtnlReqrmnt + totalFundToCalc}" readonly="readonly" style="text-align:right;">
	                            </div>
	                           </div> 
	           
		       <input type="hidden" name="trainingActivityId" value="${allTrainingActivity.trainingActivityId}" />
		       <input type="hidden" name="isFreeze" id="isFreeze" value="${allTrainingActivity.isFreeze}" /> 
		       <input type="hidden" name="catgryId" id="catgryId" >
		       </c:if>
		        <c:if test="${empty allTrainingActivity}">
	            	<input type="hidden" name="isFreeze" id="isFreeze" value="false" /> 
	             </c:if>
	                            </div>
		             <input type="hidden" name="idToEdit" id="idToEdit" >
	                    <div class="form-group text-right">
	                    <%--  <c:if test="${Plan_Status eq true}"> --%>
	                     <button type="submit" id="saveButtn" onclick="toValidate();" class="btn bg-green waves-effect">SAVE</button>
	                      <button type="button" id="frzButtn" onclick="toFreeze();" class="btn bg-green waves-effect">FREEZE</button>
                            <button type="button" id="unFrzButtn" onclick="toFreeze();" class="btn bg-green waves-effect">UNFREEZE</button>
                          
							<%--  </c:if> --%>
	                     <c:if test="${not empty allTrainingActivity}">
<!--                 			<button type="submit" id="saveButtn" onclick="toValidate();" class="btn bg-green waves-effect">SAVE</button>
 -->                            </c:if>
                           
                          
                           
                               	  	<button type="button" id="clearButtn" onclick="onClear(this)" class="btn bg-light-blue waves-effect">CLEAR</button>
                               <button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"  class="btn bg-orange waves-effect">CLOSE</button>
                        </div>
					</form:form>
	                    </div>
	                </div>
	             </div>
	         </div>
</section>