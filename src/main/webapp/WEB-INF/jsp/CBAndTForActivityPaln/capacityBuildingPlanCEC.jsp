<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/trainingDetails/training-Details.js"></script>
<script>
$('document').ready(function(){
	if($('#userTypeId').val() == 'S' && $('#userTypeSessionId').val() == 'C'){
		var rowCountState = $('#tbodyState tr').length;
		for (var i = 0; i < rowCountState; i++) {
			$('#unitCost_'+i).val('');
			$('#fundsName_'+i).val('');
		}
		$('#additioinalRequirements').val('');
	}
	calTotalFundAndGrandTotal();
	calTotalFundMopr();
	calTotalFundState();
	changeColor();
});

	function calTotalFundMopr() {
		var rowCountMopr = $('#tbody tr').length;
		var total_fund_mopr = 0;
		for (var i = 0; i < rowCountMopr; i++) {
			total_fund_mopr += +$('#fundMopr_'+i).text();
		}
		$('#totalFundMopr').text(total_fund_mopr);
		$('#grandTotalMopr').text(total_fund_mopr + +$('#additionalReqMopr').text());
	}
	
	function calTotalFundState() {
		var rowCountState = $('#tbodyState tr').length;
		var total_fund_state = 0;
		for (var i = 0; i < rowCountState; i++) {
			total_fund_state += +$('#fundState_'+i).text();
		}
		$('#totalFundState').text(total_fund_state);
		$('#grandTotalState').text(total_fund_state + +$('#additionalReqState').text());
	}
	
	function changeColor(){
		var rowCountState = $('#tbodyState tr').length;
		for (var i = 0; i < rowCountState; i++) {
			+$('#unitCostState_'+i).text() > +$('#unitCost_'+i).val() ? $('#unitCostState_'+i).css('color','red') : $('#unitCostState_'+i).css('color','#00cc00');
			+$('#fundState_'+i).text() > +$('#fundsName_'+i).val() ? $('#fundState_'+i).css('color','red') : $('#fundState_'+i).css('color','#00cc00');
		}
		+$('#totalFundState').text() > +$('#subTotal').val() ? $('#totalFundState').css('color','red') : $('#totalFundState').css('color','#00cc00');
		+$('#additionalReqState').text() > +$('#additioinalRequirements').val() ? $('#additionalReqState').css('color','red') : $('#additionalReqState').css('color','#00cc00');
		+$('#grandTotalState').text() > +$('#grandTotal').val() ? $('#grandTotalState').css('color','red') : $('#grandTotalState').css('color','#00cc00');
	}
	
	function calFund(count){
		$('#fundsName_'+count).val(+$('#unitCost_'+count).val() * +$('#noOfParticipantsState_'+count).text() * +$('#noOfDaysState_'+count).text());
		calTotalFundAndGrandTotal();
	}
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Label.TrainingDetailsHeader"
								htmlEscape="true" />
							(CEC)
						</h2>
					</div>
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
								<form:form action="saveCapctyBuldngPln.html"
									id="cpbaddtrainingID" class="form-inline" name="cpbaddtraining"
									modelAttribute="CBP_ADDTRAINING" method="POST">
									<div class="table-responsive">
										<table id="trainingActivityTblId"
											class="table table-bordered table-striped table-hover dataTable">
											<thead>
												<tr>
													<th rowspan="2" width="5%"><spring:message
															code="S No." htmlEscape="true" /></th>
													<th rowspan="2" width="5%"><spring:message
															code="Training Category" htmlEscape="true" /></th>
													<th rowspan="2" width="5%"><spring:message
															code="Training Subjects" htmlEscape="true" /></th>
													<th rowspan="2" width="5%"><spring:message
															code="Training Target Group" htmlEscape="true" /></th>
													<th rowspan="2" width="5%"><spring:message
															code="Venue Level" htmlEscape="true" /></th>
													<th rowspan="2" width="5%"><spring:message
															text="Mode Of Training" htmlEscape="true" /></th>
													<th rowspan="2" width="5%"><spring:message
															code="No. of Participants" htmlEscape="true" /></th>
													<th rowspan="2" width="5%"><spring:message
															code="No.of Days" htmlEscape="true" /></th>
													<th rowspan="2" width="5%"><spring:message
															code="Unit Cost" htmlEscape="true" /></th>
													<th rowspan="2" width="5%"><spring:message
															code="Funds Proposed" htmlEscape="true" /></th>
											</thead>
											<tbody id="tbodyState">
														<c:forEach
															items="${allTrainingActivity.trainingActivityDetailsList}"
															var="obj" varStatus="count">
															<tr>
																<td>${count.count}</td>
																<td>${trainingActivitiesState.trainingActivityDetailsList[count.index].trainingCategoryId.trainingCategoryName}

																<td>
																<ul type="circle">
																		<c:forEach items="${trainingActivitiesState.trainingActivityDetailsList[count.index].trainingSubjectsList}"
																			var="subj">
																			<li>${subj.trngSubjectId.subjectName}</li>
																		</c:forEach>
																	</ul>
																</td>
																<td>
																<ul type="circle">
																		<c:forEach
																			items="${trainingActivitiesState.trainingActivityDetailsList[count.index].trainingTargetGroupsList}"
																			var="trgt">
																			<li>${trgt.targetGroupMasterId.targetGroupMasterName}</li>
																		</c:forEach>
																	</ul> 
																</td>
																<td>
																<div align="center">${trainingActivitiesState.trainingActivityDetailsList[count.index].trainingVenueLevelId.trainingVenueLevelName}</div>
																<form:hidden path="trainingActivityDetailsList[${count.index}].trainingVenueLevelId.trainingVenueLevelId" value="${trainingActivitiesState.trainingActivityDetailsList[count.index].trainingVenueLevelId.trainingVenueLevelId}"/>
																	<input type="hidden" class="form-control"
																	name="trainingActivityDetailsList[${count.index}].trainingVenueLevelId.trainingVenueLevelId"
																	value="${trainingActivitiesState.trainingActivityDetailsList[count.index].trainingVenueLevelId.trainingVenueLevelId}">
																</td>
																<td>
																	<div align="center">${trainingActivitiesState.trainingActivityDetailsList[count.index].trainingMode.trainingModeName}</div>
																<input
																	type="hidden" class="form-control" readonly="readonly"
																	name="trainingActivityDetailsList[${count.index}].trainingMode.trainingModeId"
																	value="${trainingActivitiesState.trainingActivityDetailsList[count.index].trainingMode.trainingModeId}"></td>
																<td>
																<div align="center" id="noOfParticipantsState_${count.index}">${trainingActivitiesState.trainingActivityDetailsList[count.index].noOfParticipants}</div>
																<form:hidden path="trainingActivityDetailsList[${count.index}].noOfParticipants" value="${trainingActivitiesState.trainingActivityDetailsList[count.index].noOfParticipants}"/>
																</td>
																<td>
																<div align="center" id="noOfDaysState_${count.index}">${trainingActivitiesState.trainingActivityDetailsList[count.index].noOfDays}</div>
																<form:hidden path="trainingActivityDetailsList[${count.index}].noOfDays" value="${trainingActivitiesState.trainingActivityDetailsList[count.index].noOfDays}"/>
																</td>
																<td>
																<div align="center" id="unitCostState_${count.index}"><b>${trainingActivitiesState.trainingActivityDetailsList[count.index].unitCost }</b></div>
																<form:input type="text"
																	class="form-control fundsName"
																	readonly="${allTrainingActivity.isFreeze}"
																	path="trainingActivityDetailsList[${count.index}].unitCost"
																	onkeyup="changeColor();calFund(${count.index})"
																	value="${obj.unitCost}" style="text-align: right;" id="unitCost_${count.index}" /></td>
																<td>
																<div align="center" id="fundState_${count.index}"><b>${trainingActivitiesState.trainingActivityDetailsList[count.index].funds}</b></div>
																<input type="text" maxlength="8" min="1"
																	class="form-control"
																	name="trainingActivityDetailsList[${count.index}].funds"
																	id="fundsName_${count.index}"
																	readonly="readonly"
																	onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"
																	onchange="changeColor();calTotalFundAndGrandTotal()"
																	value="${obj.funds}" style="text-align: right;"></td>
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
															<input type="hidden" name="userTypeSession" id="userTypeSessionId"
																value="${sessionScope['scopedTarget.userPreference'].userType}">
														</c:forEach>
											</tbody>
										</table>
									
										<div class="row clearfix">
											<div class="col-md-4">
												<label>Total Funds</label>
											</div>
											<div class="col-md-7" align="right">
											<div align="right" id="totalFundState" style="font-weight: bold;"></div>
												<input type="text" class="form-control" id="subTotal"
													value="${totalFundToCalc}" readonly="readonly">
											</div>
										</div>
										<div class="row clearfix">
											<div class="col-md-4">
												<label>Additional Requirements</label>
											</div>
											<div class="col-md-7" align="right">
												<div align="right" id="additionalReqState"><b>${trainingActivitiesState.additionalRequirement}</b></div>
												<input type="text" oninput="validity.valid||(value='');"
													onkeypress="return isNumber(event)" class="form-control"
													value="${allTrainingActivity.additionalRequirement}"
													min="1" name="additionalRequirement"
													onkeyup="changeColor();calTotalFundAndGrandTotal()"
													id="additioinalRequirements" required="required">
											</div>
										</div>
										<div class="row clearfix">
											<div class="col-md-4">
												<label> Total Proposed Fund</label>
											</div>
											<div class="col-md-7" align="right">
											<div id="grandTotalState" style="font-weight: bold;"></div>
												<input type="text" class="form-control" id="grandTotal" readonly="readonly">
											</div>
										</div>

										<input type="hidden" name="trainingActivityId"
											value="${allTrainingActivity.trainingActivityId}" />
										<input type="hidden" name="isFreeze" id="isFreeze"
											value="${allTrainingActivity.isFreeze}" />
										<input type="hidden" name="catgryId" id="catgryId">
									<c:if test="${empty allTrainingActivity}">
										<input type="hidden" name="isFreeze" id="isFreeze"
											value="false" />
									</c:if>
									<input type="hidden" name="idToEdit" id="idToEdit">
									</div><br/>
									<div class="form-group text-right">
										<button type="submit" id="saveButtn" onclick="toValidate();"
											class="btn bg-green waves-effect">SAVE</button>
										<button type="button" id="frzButtn" onclick="toFreeze();"
											class="btn bg-green waves-effect">FREEZE</button>
										<button type="button" id="unFrzButtn" onclick="toFreeze();"
											class="btn bg-green waves-effect">UNFREEZE</button>
										<button type="button" id="clearButtn" onclick="onClear(this)"
											class="btn bg-light-blue waves-effect">CLEAR</button>
										<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">CLOSE</button>
									</div>
								</form:form>
							</div>

							<div role="tabpanel" class="container tab-pane" id="MOPR"
								style="width: auto;">
								<div class="table-responsive">
									<table id="trainingActivityTblId"
										class="table table-bordered table-striped table-hover dataTable">
										<thead>
											<tr>
												<th rowspan="2" width="5%"><spring:message code="S No."
														htmlEscape="true" /></th>
												<th rowspan="2" width="5%"><spring:message
														code="Training Category" htmlEscape="true" /></th>
												<th rowspan="2" width="5%"><spring:message
														code="Training Subjects" htmlEscape="true" /></th>
												<th rowspan="2" width="5%"><spring:message
														code="Training Target Group" htmlEscape="true" /></th>
												<th rowspan="2" width="5%"><spring:message
														code="Venue Level" htmlEscape="true" /></th>
												<th rowspan="2" width="5%"><spring:message
														text="Mode Of Training" htmlEscape="true" /></th>
												<th rowspan="2" width="5%"><spring:message
														code="No. of Participants" htmlEscape="true" /></th>
												<th rowspan="2" width="5%"><spring:message
														code="No.of Days" htmlEscape="true" /></th>
												<th rowspan="2" width="5%"><spring:message
														code="Unit Cost" htmlEscape="true" /></th>
												<th rowspan="2" width="5%"><spring:message
														code="Funds Proposed" htmlEscape="true" /></th>
												<th rowspan="2" width="5%"><spring:message
														text="Is Approved" htmlEscape="true" /></th>
												<th rowspan="2" width="5%"><spring:message
														code="Remarks" htmlEscape="true" /></th>
										</thead>
										<tbody id="tbody">
											<c:forEach
												items="${trainingActivitiesMopr.trainingActivityDetailsList}"
												var="obj" varStatus="count">
												<tr>
													<td>${count.count}</td>
													<td>${obj.trainingCategoryId.trainingCategoryName}</td>
													<td>
														<ul type="circle">
															<c:forEach items="${obj.trainingSubjectsList}" var="subj">
																<li>${subj.trngSubjectId.subjectName}</li>
															</c:forEach>
														</ul>
													</td>

													<td>
														<ul type="circle">
															<c:forEach items="${obj.trainingTargetGroupsList}"
																var="trgt">
																<li>${trgt.targetGroupMasterId.targetGroupMasterName}</li>
															</c:forEach>
														</ul>
													</td>
													<td><div align="center">${obj.trainingVenueLevelId.trainingVenueLevelName }</div></td>
													<td><div align="center">${obj.trainingMode.trainingModeName}</div></td>
													<td><div align="center">${obj.noOfParticipants}</div></td>
													<td><div align="center">${obj.noOfDays}</div></td>
													<td><div align="center">${obj.unitCost}</div></td>
													<td><div align="center" id="fundMopr_${count.index}">${obj.funds}</div></td>
													<td><c:choose>
															<c:when test="${obj.isApproved}">
																<div align="center">
																	<i class="fa fa-check" aria-hidden="true"
																		style="color: #00cc00"></i>
																</div>
															</c:when>
															<c:otherwise>
																<i class="fa fa-check" aria-hidden="true"
																	style="color: red;"></i>
															</c:otherwise>
														</c:choose></td>
													<td><div align="center">${obj.remarks}</div></td>
											</c:forEach>
										</tbody>
									</table>
									<div class="row clearfix">
										<div class="col-md-4">
											<label>Total Funds</label>
										</div>
										<div class="col-md-7">
											<div align="right" id="totalFundMopr"></div>
										</div>
									</div>
									<div class="row clearfix">
										<div class="col-md-4">
											<label>Additional Requirements</label>
										</div>
										<div class="col-md-7" align="right" id="additionalReqMopr">
											${trainingActivitiesMopr.additionalRequirement}
										</div>
									</div>
									<div class="row clearfix">
										<div class="col-md-4">
											<label> Total Proposed Fund</label>
										</div>
										<div class="col-md-7" align="right" id="grandTotalMopr">
											
										</div>
									</div>
								</div>
								<br/>
								<div class="text-right">
										<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"  class="btn bg-orange waves-effect"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
									</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>