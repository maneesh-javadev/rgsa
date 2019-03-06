<%@include file="../taglib/taglib.jsp"%>
<style type="text/css">
/* By Abhishek Kumar Singh dated 03-01-18 */

/* The container */
.container {
	display: block;
	position: relative;
	padding-left: 65px;
	margin-bottom: 12px;
	cursor: pointer;
	font-size: 22px;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	width: 0px;
}

/* Hide the browser's default checkbox */
.container input {
	position: absolute;
	opacity: 0;
}

/* Create a custom checkbox */
.checkmark {
	position: absolute;
	top: 0;
	left: 30px;
	height: 25px;
	width: 25px;
	background-color: #eee;
}

/* On mouse-over, add a grey background color */
.container:hover input ~ .checkmark {
	background-color: #ccc;
}

/* When the checkbox is checked, add a blue background */
.container input:checked ~ .checkmark {
	background-color: #2196F3;
}

/* Create the checkmark/indicator (hidden when not checked) */
.checkmark:after {
	content: "";
	position: absolute;
	display: none;
}

/* Show the checkmark when checked */
.container input:checked ~ .checkmark:after {
	display: block;
}

/* Style the checkmark/indicator */
.container .checkmark:after {
	left: 9px;
	top: 5px;
	width: 5px;
	height: 10px;
	border: solid white;
	border-width: 0 3px 3px 0;
	-webkit-transform: rotate(45deg);
	-ms-transform: rotate(45deg);
	transform: rotate(45deg);
}

#trainingActivityTblId {
	table-layout: auto;
}

table#trainingActivityTblId tbody tr td:first-child {
	width: 12px;
}

#trainingActivityTblId th, #trainingActivityTblId td {
	overflow: hidden;
	width: 112px;
	white-space: inherit;
	word-wrap: break-word;
}

table#trainingActivityTblId tbody tr td {
	white-space: inherit;
}

#trainingActivityTblId th {
	text-align: center;
	text-transform: none;
	font-weight: bold;
	color: #FFF;
	background-color: cornflowerblue;
}

.card .body {
	font-size: 12px;
	color: #4B4B4B;
	font-weight: initial;
	opacity: 1.9px;
}

.not-active {
	pointer-events: none;
	cursor: default;
}

#jquery-search-sample {
	box-sizing: border-box;
	border: 2px solid #ccc;
	border-radius: 4px;
	background-color: white;
	font-size: 15px;
	background-image: url('<%=request.getContextPath()%>/resources/images/search_icon.gif');
	background-position: 9px 8px;
	background-repeat: no-repeat;
	-webkit-transition: width 0.4s ease-in-out;
	transition: width 0.4s ease-in-out;
	padding: 11px 20px 3px 34px;
}

table {
  position: relative;
  width: 100%; 
  /*background-color: #aaa; */
  overflow: hidden;
  border-collapse: collapse;
}


/*thead*/
thead {
  position: relative;
  display: block; /*seperates the header from the body allowing it to be positioned*/
 /*  width: 100%; 
  overflow: visible; */
}

thead th {
 /*  background-color: #99a; */
  min-width: 113px; 
  height: 32px;
  border: 1px solid #222;
}

thead th:nth-child(1) {/*first cell in the header*/
  position: relative;
  /* display: block;  */ /*seperates the first cell in the header from the header*/
 /*  background-color: #88b; */
}


/* tbody*/
tbody {
  position: relative;
  display: block; /*seperates the tbody from the header*/
  width: 100%;
  height: 470px;
  overflow: scroll;
}

tbody td {
 /*  background-color: #bbc; */
  min-width: 112px;
  border: 1px solid #222;
}

tbody tr td:nth-child(1) {  /*the first cell in each tr*/
  position: relative;
 /*  display: block; */ /*seperates the first column from the tbody*/
  height: 40px;
  /* background-color: #99a; */
}

</style>
<script
	src="<c:out value='${pageContext.request.contextPath}'/>/resources/plugins/jquery/jquery.min.js"></script>
<script
	src="<c:out value='${pageContext.request.contextPath}'/>/resources/plugins/bootstrap/js/bootstrap.min.js"></script>
<script
	src="<c:out value='${pageContext.request.contextPath}'/>/resources/bs/jq_search/jquery.search.min.js"></script>
<link rel="stylesheet" href="<c:out value="${pageContext.request.contextPath}"/>/resources/plugins/check/custom.css"/> 
<script type="text/javascript" 
 	src="<c:out value='${pageContext.request.contextPath}'/>/resources/js/trainingDetails/training-Details.js"></script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Training Details" htmlEscape="true" />
						</h2>
					</div>
					<form:form action="saveCapctyBuldngPln.html" id="cpbaddtrainingID"
						class="form-inline" name="cpbaddtraining"
						modelAttribute="CBP_ADDTRAINING" method="POST">
						<div class="body">
							<c:if
								test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
								<div class="form-group text-right">
									<c:if test="${not empty allTrainingActivity}">
										<c:if test="${allTrainingActivity.isFreeze == false}">
											<a style="margin:0 15px 18px 0"
												href="addTrainings.html?<csrf:token uri='addTrainings.html'/>"
												class="btn bg-green waves-effect"> ADD TRAININGS</a>
										</c:if>
									</c:if>
									<c:if test="${empty allTrainingActivity}">
										<a
											href="addTrainings.html?<csrf:token uri='addTrainings.html'/>"
											class="btn bg-green waves-effect"> ADD TRAININGS</a>
									</c:if>
								</div>
							</c:if>
							<input type="hidden" name="<csrf:token-name/>"
								value="<csrf:token-value uri="saveCapctyBuldngPln.html"/>" />
							<div class="row">
								<div class="form-group">
									<div class="col-sm-9">
										<div class="col-sm-12">
											<span id="msg" style="margin: 0px 0px 0px 0px"></span>
										</div>
									</div>
									<div class="col-sm-3">
										<div class="col-sm-12">
											<input type="text" id="jquery-search-sample"
												class="form-control" placeholder="Search Here...">
										</div>
									</div>
								</div>
							</div>
							<div class="records">
								<div class="">
									<table id="trainingActivityTblId"
										class="table table-bordered table-striped table-hover dataTable">
										<thead>
											<tr>
												<th><spring:message code="Sr. No." htmlEscape="true" /></th>
												<th><spring:message code="Training Category"
														htmlEscape="true" /></th>
												<th><spring:message code="Training Subjects"
														htmlEscape="true" /></th>
												<th><spring:message code="Training Target Group"
														htmlEscape="true" /></th>
												<th><spring:message code="Venue Level"
														htmlEscape="true" /></th>
												<th><spring:message text="Mode Of Training"
														htmlEscape="true" /></th>
												<th><spring:message code="No. of Participants"
														htmlEscape="true" /></th>
												<th><spring:message code="No.of Days" htmlEscape="true" /></th>
												<th><spring:message code="Unit Cost" htmlEscape="true" /></th>
												<th><spring:message code="Funds Proposed"
														htmlEscape="true" /></th>
												<c:if
													test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
													<th><spring:message text="Is Approved"
															htmlEscape="true" /></th>
													<th><spring:message code="Remarks" htmlEscape="true" /></th>
												</c:if>
												<c:if
													test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
													<th><spring:message text="Is Approved"
															htmlEscape="true" /></th>
													<th><spring:message code="Remarks" htmlEscape="true" /></th>
												</c:if>
												<c:if
													test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
													<th><spring:message code="Modify" htmlEscape="true" /></th>
													<th><spring:message code="Delete" htmlEscape="true" /></th>
												</c:if>
											</tr>
										</thead>
										<tbody id="tbodyState">
											<c:choose>
												<c:when test="${not empty allTrainingActivity}">
													<c:forEach
														items="${allTrainingActivity.trainingActivityDetailsList}"
														var="obj" varStatus="count">
														<tr class='jsearch-row'>
															<td align="right"><b>${count.count}</b></td>
															<td class='jsearch-field'>${obj.trainingCategoryId.trainingCategoryName}<input
																type="hidden"
																style="text-align: left; border: none; border-color: transparent;"
																name="trainingActivityDetailsList[${count.index}].trainingCategoryId.trainingCategoryName"
																readonly="readonly"
																value="${obj.trainingCategoryId.trainingCategoryName}" />
															</td>

															<td class='jsearch-field'>
																<%-- <select class="form-control" name="trainingActivityDetailsList[${count.index}].trainingSubjectsArray"  multiple="multiple"> --%>
																<c:forEach var="subj"
																	items="${obj.trainingSubjectsList}"
																	varStatus="numbering">
																	<b>${numbering.count}.</b>
																	<c:out value="${subj.trngSubjectId.subjectName}" />
																	<br />
																</c:forEach> <form:select
																	path="trainingActivityDetailsList[${count.index}].trainingSubjectsArray"
																	id="sbjctListId" disabled="true" multiple="true"
																	cssStyle="display:none"
																	cssClass="form-control sbjctClass">
																	<c:forEach items="${obj.trainingSubjectsList}"
																		var="subj">
																		<option value="${subj.trngSubjectId.subjectId}"
																			selected="selected">${subj.trngSubjectId.subjectName}
																		</option>
																	</c:forEach>
																	<!--  </select> -->
																</form:select>
															</td>
															<td class='jsearch-field'>
																<%-- <select class="form-control" name="trainingActivityDetailsList[${count.index}].trainingTargetGroupsArray" multiple="multiple"> --%>
																<c:forEach var="trgt"
																	items="${obj.trainingTargetGroupsList}"
																	varStatus="numbering">
																	<b>${numbering.count}.</b>
																	<c:out
																		value="${trgt.targetGroupMasterId.targetGroupMasterName}" />
																	<br />
																</c:forEach> <form:select
																	path="trainingActivityDetailsList[${count.index}].trainingTargetGroupsArray"
																	disabled="true" cssClass="form-control trgtClass"
																	cssStyle="display:none" multiple="true">
																	<c:forEach items="${obj.trainingTargetGroupsList}"
																		var="trgt">
																		<option
																			value="${trgt.targetGroupMasterId.targetGroupMasterId}"
																			selected="selected">${trgt.targetGroupMasterId.targetGroupMasterName}
																		</option>
																	</c:forEach>
																	<!-- </select> -->
																</form:select>
															</td>
															<td class='jsearch-field'><c:out
																	value="${obj.trainingVenueLevelId.trainingVenueLevelName}" />
																<input type="hidden" class="form-control"
																readonly="readonly"
																name="trainingActivityDetailsList[${count.index}].trainingVenueLevelId.trainingVenueLevelId"
																value="${obj.trainingVenueLevelId.trainingVenueLevelId}">
															</td>
															<td class='jsearch-field'><c:out
																	value="${obj.trainingMode.trainingModeName}" /><input
																type="hidden" class="form-control" readonly="readonly"
																name="trainingActivityDetailsList[${count.index}].trainingMode.trainingModeId"
																value="${obj.trainingMode.trainingModeId}"></td>
															<td align="right"><c:out
																	value="${obj.noOfParticipants}" /><input type="hidden"
																class="form-control" readonly="readonly"
																name="trainingActivityDetailsList[${count.index}].noOfParticipants"
																value="${obj.noOfParticipants}"
																style="text-align: right;"></td>
															<td align="right"><c:out value="${obj.noOfDays}" /><input
																type="hidden" class="form-control" readonly="readonly"
																name="trainingActivityDetailsList[${count.index}].noOfDays"
																value="${obj.noOfDays}" style="text-align: right;"></td>
															<td align="right"><c:out value="${obj.unitCost}" /><input
																type="hidden" class="form-control fundsName"
																readonly="readonly"
																name="trainingActivityDetailsList[${count.index}].unitCost"
																value="${obj.unitCost}" style="text-align: right;"></td>
															<c:set var="totalFundToCalc"
																value="${totalFundToCalc + obj.funds}"></c:set>
															<td align="right"><c:out value="${obj.funds}" /><input
																type="hidden" maxlength="8" min="1" class="form-control"
																readonly="readonly"
																name="trainingActivityDetailsList[${count.index}].funds"
																id="fundsName"
																onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"
																value="${obj.funds}" style="text-align: right;"></td>

															<c:if
																test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
																<td align="center"><c:choose>
																		<c:when test="${obj.isApproved}">
																			<label class="container"> <input
																				type="checkbox" checked="checked"
																				name="trainingActivityDetailsList[${count.index}].isApproved">
																				<span class="checkmark"></span>
																			</label>
																			<%-- <input type="checkbox"
																			name="trainingActivityDetailsList[${count.index}].isApproved"
																			class="form-control" checked="checked"> --%>
																		</c:when>
																		<c:otherwise>
																			<label class="container"> <input
																				type="checkbox"
																				name="trainingActivityDetailsList[${count.index}].isApproved">
																				<span class="checkmark"></span>
																			</label>
																			<%-- <input type="checkbox"
																			name="trainingActivityDetailsList[${count.index}].isApproved"> --%>
																		</c:otherwise>
																	</c:choose></td>
																<td><textarea class="form-control" rows="5"
																		cols="5"
																		name="trainingActivityDetailsList[${count.index}].remarks"><c:out
																			value="${obj.remarks}" /></textarea> <%-- <input type="text" class="form-control"
																name="trainingActivityDetailsList[${count.index}].remarks"
																value="${obj.remarks}"> --%></td>
															</c:if>
															<c:if
																test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
																<td align="center"><c:choose>
																		<c:when test="${obj.isApproved}">
																			<label class="container"> <input
																				type="checkbox" checked="checked"
																				name="trainingActivityDetailsList[${count.index}].isApproved">
																				<span class="checkmark"></span>
																			</label>
																			<%-- <input type="checkbox"
																			name="trainingActivityDetailsList[${count.index}].isApproved"
																			class="form-control" checked="checked"> --%>
																		</c:when>
																		<c:otherwise>
																			<label class="container"> <input
																				type="checkbox"
																				name="trainingActivityDetailsList[${count.index}].isApproved">
																				<span class="checkmark"></span>
																			</label>
																			<%-- <input type="checkbox"
																			name="trainingActivityDetailsList[${count.index}].isApproved"> --%>
																		</c:otherwise>
																	</c:choose></td>
																<td><textarea class="form-control" rows="5"
																		name="trainingActivityDetailsList[${count.index}].remarks"><c:out
																			value="${obj.remarks}" /></textarea> <%-- <input type="text" class="form-control" width="20%"
																name="trainingActivityDetailsList[${count.index}].remarks"
																value="${obj.remarks}"> --%></td>
															</c:if>
															<c:if
																test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
																<c:choose>
																	<c:when test="${allTrainingActivity.isFreeze == false}">
																		<td align="center"><a id="modifyButtn"
																			href="javascript:toModify('${obj.trainingActivityDetailsId}');">
																				<span class="glyphicon glyphicon-edit"></span>
																		</a> <%-- <button type="button" id="modifyButtn"
																			onclick="toModify('${obj.trainingActivityDetailsId}');"
																			class="btn bg-light-orange waves-effect">Modify</button> --%>
																		</td>
																		<td align="center"><a id="deleteButtn"
																			href="javascript:toDelete('${obj.trainingActivityDetailsId}');">
																				<span class="glyphicon glyphicon-trash"></span>
																		</a> <%-- <button type="button" id="deleteButtn"
																			onclick="toDelete('${obj.trainingActivityDetailsId}');"
																			class="btn bg-light-red waves-effect">Delete</button> --%>
																		</td>
																	</c:when>
																	<c:otherwise>
																		<td><a id="modifyButtn" class="not-active"
																			href="javascript:toModify('${obj.trainingActivityDetailsId}');">
																				<span class="glyphicon glyphicon-edit"></span>
																		</a> <%-- <button type="button" id="modifyButtn"
																			disabled="disabled"
																			value="${obj.trainingActivityDetailsId}"
																			class="btn bg-light-orange waves-effect">Modify</button> --%>
																		</td>
																		<td><a id="deleteButtn" class="not-active"
																			href="javascript:toDelete('${obj.trainingActivityDetailsId}');">
																				<span class="glyphicon glyphicon-trash"></span>
																		</a> <%-- <button type="button" id="deleteButtn"
																			disabled="disabled"
																			onclick="toDelete('${obj.trainingActivityDetailsId}');"
																			class="btn bg-light-red waves-effect">Delete</button> --%>
																		</td>
																	</c:otherwise>
																</c:choose>
															</c:if>
														</tr>
														<input type="hidden"
															name="trainingActivityDetailsList[${count.index}].trainingActivityDetailsId"
															value="${obj.trainingActivityDetailsId}" />
														<input type="hidden"
															name="trainingActivityDetailsList[${count.index}].trainingCategoryId.trainingCategoryId"
															id="catogryId"
															value="${obj.trainingCategoryId.trainingCategoryId}">
														<input type="hidden" name="userType" id="userTypeId"
															value="${allTrainingActivity.userType}">
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td class="text-center" colspan="12"><b
															class="delete-color"> <i class="fa fa-smile-o"
																aria-hidden="true"></i> There are no Training Details
														</b></td>
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
								</div>
							</div>
							<br>
							<c:if test="${not empty allTrainingActivity}">
								<div class="row clearfix">
									<div class="col-sm-4">
										<label>Total Funds</label>
									</div>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="subTotal"
											value="${totalFundToCalc}" readonly="readonly"
											style="text-align: right;">
									</div>
								</div>
								<div class="row clearfix">
									<div class="col-sm-4">
										<label>Additional Requirements</label>
									</div>
									<div class="col-sm-8">
										<c:set var="addtnlReqrmnt"
											value="${addtnlReqrmnt + allTrainingActivity.additionalRequirement}"></c:set>
										<input type="text" oninput="validity.valid||(value='');"
											onkeypress="return isNumber(event)" class="form-control"
											value="${allTrainingActivity.additionalRequirement}" min="1"
											name="additionalRequirement" id="additioinalRequirements"
											required="required" style="text-align: right;">
									</div>
								</div>
								<div class="row clearfix">
									<div class="col-sm-4">
										<label> Total Proposed Fund</label>
									</div>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="grandTotal"
											value="${addtnlReqrmnt + totalFundToCalc}"
											readonly="readonly" style="text-align: right;">
									</div>
								</div>

								<input type="hidden" name="trainingActivityId"
									value="${allTrainingActivity.trainingActivityId}" />
								<input type="hidden" name="isFreeze" id="isFreeze"
									value="${allTrainingActivity.isFreeze}" />
								<input type="hidden" name="catgryId" id="catgryId">
							</c:if>
							<c:if test="${empty allTrainingActivity}">
								<input type="hidden" name="isFreeze" id="isFreeze" value="false" />
							</c:if>
						</div>
						<input type="hidden" name="idToEdit" id="idToEdit">
						<div class="row clearfix">
						<c:choose>
						<c:when test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
						<div class="col-md-12 text-right">
							<%--  <c:if test="${Plan_Status eq true}"> --%>
							<button type="submit" id="saveButtn" onclick="toValidate();"
								class="btn bg-green waves-effect">SAVE</button>
							<button type="button" id="frzButtn" onclick="toFreeze();"
								class="btn bg-green waves-effect">FREEZE</button>
							<button type="button" id="unFrzButtn" onclick="toFreeze();"
								class="btn bg-green waves-effect">UNFREEZE</button>

							<%--  </c:if> --%>
							<c:if test="${not empty allTrainingActivity}">
								<!--                 			<button type="submit" id="saveButtn" onclick="toValidate();" class="btn bg-green waves-effect">SAVE</button>
 -->
							</c:if>

							<button type="button" id="clearButtn" onclick="onClear(this)"
								class="btn bg-light-blue waves-effect">CLEAR</button>
							<button type="button"
								onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
								class="btn bg-orange waves-effect">CLOSE</button><br />
						</div>
						</c:when>
						<c:otherwise>
						<div class="col-md-4 text-left">
	                    &nbsp;<button type="button"
								onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${allTrainingActivity.stateCode}')"
								class="btn bg-orange waves-effect">
								<i class="fa fa-arrow-left" aria-hidden="true"></i> <spring:message
										code="Label.BACK" htmlEscape="true" />
							</button>
	                    </div>
	                    <div class="col-sm-8 text-right">
							<%--  <c:if test="${Plan_Status eq true}"> --%>
							<button type="submit" id="saveButtn" onclick="toValidate();"
								class="btn bg-green waves-effect">SAVE</button>
							<button type="button" id="frzButtn" onclick="toFreeze();"
								class="btn bg-green waves-effect">FREEZE</button>
							<button type="button" id="unFrzButtn" onclick="toFreeze();"
								class="btn bg-green waves-effect">UNFREEZE</button>

							<%--  </c:if> --%>
							<c:if test="${not empty allTrainingActivity}">
								<!--                 			<button type="submit" id="saveButtn" onclick="toValidate();" class="btn bg-green waves-effect">SAVE</button>
 -->
							</c:if>

							<button type="button" id="clearButtn" onclick="onClear(this)"
								class="btn bg-light-blue waves-effect">CLEAR</button>
							<button type="button"
								onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
								class="btn bg-orange waves-effect">CLOSE</button><br />
						</div>
	                    
	                    </c:otherwise>
						</c:choose>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
<script>
	 $("#jquery-search-sample").jsearch({
		  rowClass: '.jsearch-row',
		  fieldClass: '.jsearch-field',
		  minLength: 3,
		  triggers: 'keyup',
		  caseSensitive: false,
	});
	 $(document).ready(function() {
		  $('tbody').scroll(function(e) { //detect a scroll event on the tbody
		  	/*
		    Setting the thead left value to the negative valule of tbody.scrollLeft will make it track the movement
		    of the tbody element. Setting an elements left value to that of the tbody.scrollLeft left makes it maintain it's relative position at the left of the table.    
		    */
		    $('thead').css("left", -$("tbody").scrollLeft()); //fix the thead relative to the body scrolling
		    $('thead th:nth-child(1)').css("left", $("tbody").scrollLeft()); //fix the first cell of the header
		    $('tbody td:nth-child(1)').css("left", $("tbody").scrollLeft()); //fix the first column of tdbody
		  });
		});
</script>