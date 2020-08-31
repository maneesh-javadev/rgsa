<%@include file="../taglib/taglib.jsp"%>
<%@include file="qprCapacityBuildingJs.jsp"%>
<style>
.padding_left_local {
   padding-left: 85px !important;
 }
.Align-Right{
			text-align: right;
}
.Alert{
	color: red;
}
</style>

<section class="content">

<input type="hidden" id="disabledID" value="${QPR_CB_ACT_DATA.isFreeze}" />

	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Training Activities</h2>
					</div>
					<form:form action="qprCapacityBuilding.html" method="POST" name="qpqCapacityBuilding" class="form-inline" modelAttribute="QPR_CAPACITY_BUILDING" enctype="multipart/form-data">
					<input type="hidden" name="<csrf:token-name/>" value="<csrf:token-value uri="saveQprCapacityBuilding.html"/>" />
						<br />
						<div class="row clearfix">
							<div class="form-group">
								<div class="col-lg-2">
									&nbsp;&nbsp;&nbsp;&nbsp;<label for="QuaterId1"><strong>Quarter Duration :</strong></label>
								</div>
								<div align="center" class="col-lg-4">
									<select id="quaterDropDownId" name="quarterDuration.qtrId" class="form-control"
										onchange="getSelelctedQtrRprt();showTablediv()">
										<option value="0">Select quarter</option>
										<c:forEach items="${quarter_duration}" var="qtr">
											<option value="${qtr.qtrId}">${qtr.qtrDuration}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<br/>
						<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head Alert">
                             (Balance Amount:${subcomponentwiseQuaterBalanceList[0].balanceAmount})
                           </div>
                           
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                           
	<div id="mainDivId">
		<div class="table-responsive">
			<table class="table table-hover dashboard-task-infos" id="mytable">
				<thead>
					<tr>
						<th><div align="center"><strong>S.No.</strong></div></th>
						<th><div align="center"><strong>Activity Name</strong></div></th>
						<th><div align="center"><strong>No. Of Unit Proposed</strong></div></th>
						<th><div align="center"><strong>Approved Amount</strong></div></th>
						<th><div align="center"><strong>No. of Days Completed</strong></div></th>
						<th><div align="center"><strong>No. of Units Completed</strong></div></th>
						<th><div align="center"><strong>Expenditure Incurred</strong></div></th>
						<th><div align="center"><strong>Fill Details</strong></div></th>
					</tr>
				</thead>
				<tbody id="tbodyId">
					<c:forEach items="${CB_MASTERS}" var="master" varStatus="index">
						<tr>
						<!-- total number of units filled in rest quaters -->
						<c:choose>
							<c:when test="${not empty DEATIL_FOR_TOTAL_NO_OF_UNIT}">
								<input type="hidden" id="totalExpenditureIncurred_${index.index}" value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[index.index].expenditureIncurred}" />
								<input type="hidden" id="totalNoOfUnit_${index.index}" value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[index.index].noOfUnitsCompleted}" />
							</c:when>
							<c:otherwise>
								<input type="hidden" id="totalNoOfUnit_${index.index}" value="0" />
								<input type="hidden" id="totalExpenditureIncurred_${index.index}" value="0" />	
							</c:otherwise>
						</c:choose>
						<!-- ends here -->
												
							<td><div align="center"><strong>${index.count}.</strong></div></td>
							<td><div align="center"><strong>${master.cbName}</strong></div></td>
							<td><div align="center" id="noOfUnitCecId_${index.index}"><strong>${CEC_APPROVED_ACTIVITY.capacityBuildingActivityDetails[index.index].noOfUnits}</strong></div></td>
							<td><div align="center" id="fundCecId_${index.index}"><strong>${CEC_APPROVED_ACTIVITY.capacityBuildingActivityDetails[index.index].funds}</strong></div></td>
							<c:choose>
								<c:when test="${not empty QPR_CB_ACT_DATA}">
									<c:choose>
										<c:when test="${QPR_CB_ACT_DATA.isFreeze}">
											<td><div align="center"><input name="qprCbActivityDetails[${index.index}].noOfDaysCompleted" class="form-control Align-Right" id="noOfDaysCompleted_${index.index}" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[index.index].noOfDaysCompleted }" readonly="${QPR_CB_ACT_DATA.isFreeze}"/></div></td>
											<td>
												<div align="center">
													<input name="qprCbActivityDetails[${index.index}].noOfUnitsCompleted" class="form-control Align-Right" id="noOfUnitCompleted_${index.index}" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[index.index].noOfUnitsCompleted}" readonly="${QPR_CB_ACT_DATA.isFreeze}"/>
												</div>
											</td>
											<td>
												<div align="center">
													<input name="qprCbActivityDetails[${index.index}].expenditureIncurred" class="form-control Align-Right" id="expenditureIncurred_${index.index}" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[index.index].expenditureIncurred}" readonly="${QPR_CB_ACT_DATA.isFreeze}"/>
												</div>
											</td>
										</c:when>
										<c:otherwise>
											<td>
												<div align="center">
													<input name="qprCbActivityDetails[${index.index}].noOfDaysCompleted" class="form-control Align-Right" id="noOfDaysCompleted_${index.index}" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[index.index].noOfDaysCompleted }" />
												</div>
											</td>
											<td>
												<div align="center">
													<input name="qprCbActivityDetails[${index.index}].noOfUnitsCompleted" class="form-control Align-Right" id="noOfUnitCompleted_${index.index}" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[index.index].noOfUnitsCompleted}"
														   onkeyup="this.value=this.value.replace(/[^0-9]/g,'');validateNoOfUnits(${index.index});validateFundByAllocatedFund(${index.index})" />
												</div>
											</td>
											<td>
												<div align="center">
														<input name="qprCbActivityDetails[${index.index}].expenditureIncurred" class="form-control Align-Right" id="expenditureIncurred_${index.index}" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[index.index].expenditureIncurred}"
															   onkeyup="this.value=this.value.replace(/[^0-9]/g,'');validateFundByAllocatedFund(${index.index});isNoOfUnitAndExpInurredFilled(${index.index});validateWithCorrespondingFund(${index.index});calTotalExpenditure()" 
															   onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[0].balanceAmount}',this)" />
														<span class="errormsg" id="error_expenditureIncurred_${index.index}"></span>
												</div>
											</td>
										 </c:otherwise>
									  </c:choose>		 
									</c:when>
									<c:otherwise>
														<td><div align="center"><input name="qprCbActivityDetails[${index.index}].noOfDaysCompleted" class="form-control Align-Right" id="noOfDaysCompleted_${index.index}" /></div></td>
														<td><div align="center"><input name="qprCbActivityDetails[${index.index}].noOfUnitsCompleted" class="form-control Align-Right" id="noOfUnitCompleted_${index.index}"
																				onkeyup="this.value=this.value.replace(/[^0-9]/g,'');validateFundByAllocatedFund(${index.index});
																				validateNoOfUnits(${index.index})" /></div></td>
														<td><div align="center"><input name="qprCbActivityDetails[${index.index}].expenditureIncurred" class="form-control Align-Right" id="expenditureIncurred_${index.index}"
																				onkeyup="this.value=this.value.replace(/[^0-9]/g,'');validateFundByAllocatedFund(${index.index});isNoOfUnitAndExpInurredFilled(${index.index});validateWithCorrespondingFund(${index.index})" /></div></td>
										</c:otherwise>
									</c:choose>
												<!----------------------------- modal Starts  here------------------------------------------------ -->
												<c:choose>
													<c:when test="${index.index eq 0 }">
														<td><button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#tnaTrainingEavltionModal">Fill Details</button></td>
													</c:when>

													<c:when test="${index.index eq 1}">
														<td><button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#trainingModuleModal">Fill Details</button></td>
													</c:when>
												
													<c:when test="${index.index eq 2}">
														<td><button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#trainingMaterailModal">Fill Details</button></td>
													</c:when>
												
													<c:when test="${index.index eq 3 }">
														<td><button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#tnaTrainingEavltionModal2">Fill Details</button></td>
													</c:when>
													
													<%-- <c:when test="${index.index eq 4 }">
														<td><button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#exposureVisitState">Fill Details</button></td>
													</c:when>
													
													<c:when test="${index.index eq 5 }">
														<td><button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#exposureVisitOutside">Fill Details</button></td>
													</c:when> --%>
													
													<c:when test="${index.index eq 6}">
														<td><button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#handHoldingModal">Fill Details</button></td>
													</c:when>
												
													<c:when test="${index.index eq 7}">
														<td><button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#panchayatCentrerModal">Fill Details</button></td>
													</c:when>
												
													<c:otherwise>
														<td></td>
													</c:otherwise>
												</c:choose>
												<!----------------------------- modal ends  here------------------------------------------------ -->
											</tr>
											<c:if test="${not empty QPR_CB_ACT_DATA}">
												<input type="hidden" name="qpCbActivityId" value="${QPR_CB_ACT_DATA.qpCbActivityId}" id="qprActivityId"/>
												<input type="hidden" name="qprCbActivityDetails[${index.index}].qprCbActivityDetailsId" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[index.index].qprCbActivityDetailsId }" />
												<input type="hidden" name="qprCbActivityDetails[${index.index}].capacityBuildingActivityDetails.capacityBuildingActivityDetailsId" value="${CEC_APPROVED_ACTIVITY.capacityBuildingActivityDetails[index.index].capacityBuildingActivityDetailsId}" />
											</c:if>
										</c:forEach>
										<tr>
										<th colspan="3"><div align="center">Additional Requirement</div></th>
										<th colspan="1"><div align="center" id="additionalReqStateId">${CEC_APPROVED_ACTIVITY.additionalRequirement }</div></th>
										<c:choose>
										<c:when test="${QPR_CB_ACT_DATA.isFreeze eq true}">
										
										<td colspan="3"><div align="right"><input name="additionalRequirement" id="additionalReqId" value="${QPR_CB_ACT_DATA.additionalRequirement}" class="form-control validate Align-Right" onkeyup="validateAddReq();calTotalExpenditure()" disabled="disabled"/></div></td>
										</c:when>
										<c:otherwise>
										<td colspan="3"><div align="right"><input name="additionalRequirement" id="additionalReqId" value="${QPR_CB_ACT_DATA.additionalRequirement}" class="form-control validate Align-Right" onkeyup="validateAddReq();calTotalExpenditure()" /></div></td>
										</c:otherwise>
										</c:choose>
										
									</tr>
										<tr>
											<th colspan="2"><div align="center">Total Expenditure Incurred</div></th>
											<td colspan="4"></td>
											<td><input type="text" id="totalExpenditureId"  class="form-control validate Align-Right" disabled="disabled" /></td>
										</tr>
									</tbody>
								</table>
								<!-- Modal content TNA & Training Evaluation-->
										<div id="tnaTrainingEavltionModal" class="modal fade" role="dialog">
											<div class="modal-dialog modal-lg">
												<div class="modal-content modal-lg">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">&times;</button>
													</div>
													<div class="modal-body">
														<div class="row">
															<div class="form-group">
																<label for="sprc" class="col-sm-3">
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
																<div class="col-sm-5">
																	<p class="text-justify">
																		<strong>TNA & Training Evaluation</strong>
																	</p>
																</div>
															</div>
														</div>
														<div class="row clearfix">
										
															<div class="body">
																<div class="table-responsive">
																	<table class="table table-bordered">
																		<thead>
																			<tr>
																				<th><div align="center">No. of Person Involved</div></th>
																				<th><div align="center">Training Subjects</div></th>
																				<th><div align="center">File Upload(PDF)</div></th>
																			</tr>
																		</thead>
																		<tbody>
																			<tr>
																				<td><form:input path="qprCbActivityDetails[0].qprTnaTrgEvaluation.noOfPersons"
																					value="${QPR_CB_ACT_DATA.qprCbActivityDetails[0].qprTnaTrgEvaluation.noOfPersons}"
																					class="active12 form-control Align-Right disableClass"  /></td>
																				<td><select class="form-control" id="trainingSubIdDiseable"
																					name="qprCbActivityDetails[0].qprTnaTrgEvaluation.trngSubject" >
																						<option value="">select</option>
																						<c:forEach items="${SUBJECTS_LIST}" var="sbjctLst">
																					<c:choose>
																						<c:when
																							test="${QPR_CB_ACT_DATA.qprCbActivityDetails[0].qprTnaTrgEvaluation.trngSubject == sbjctLst.subjectId}">
																							<option value="${sbjctLst.subjectId}" selected="selected">${sbjctLst.subjectName}</option>
																						</c:when>
																						<c:otherwise>
																							<option value="${sbjctLst.subjectId}">${sbjctLst.subjectName}</option>
																						</c:otherwise>
																					</c:choose>
																				</c:forEach>
																				</select></td>
																				<td>
																					<c:choose>
																						<c:when test="${QPR_CB_ACT_DATA.isFreeze}"><input name="qprCbActivityDetails[0].qprTnaTrgEvaluation.file" type="file" class="active12 form-control disableClass" /></c:when>
																						<c:otherwise><input name="qprCbActivityDetails[0].qprTnaTrgEvaluation.file" type="file" class="active12 form-control " /></c:otherwise>
																					</c:choose>
																					<c:if test="${not empty QPR_CB_ACT_DATA and not empty QPR_CB_ACT_DATA.qprCbActivityDetails[0].qprTnaTrgEvaluation.fileNode.uploadName}">
																						<input type="button" value="Download File" class="btn bg-grey waves-effect" onclick='showImage("TnaTrgEvaluation",${QPR_CB_ACT_DATA.qprCbActivityDetails[0].qprTnaTrgEvaluation.qprTnaTrgEvaluationId});' />
																					</c:if>
																				</td>
																			</tr>
																	</table>
																</div>
															</div>
														</div>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
													</div>
												</div>
											</div>
										</div>
										<!-- Modal content TNA & Training Evaluation ends here-->
										
										<!-- Modal content Training Module-->
										<div id="trainingModuleModal" class="modal fade" role="dialog">
											<div class="modal-dialog modal-lg">
												<div class="modal-content modal-lg">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">&times;</button>
													</div>
													<div class="modal-body">
														<div class="row">
															<div class="form-group">
																<label for="sprc" class="col-sm-3">
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
																<div class="col-sm-5">
																	<p class="text-justify">
																		<strong>Training Material & Module</strong>
																	</p>
																</div>
															</div>
														</div>
														<div class="row clearfix">
										
															<div class="body">
																<div class="table-responsive">
																	<table class="table table-bordered">
																		<thead>
																			<tr>
																				<th><div align="center">Module Used</div></th>
																				<th><div align="center">Institute Involved</div></th>
																			</tr>
																		</thead>
																		<tbody>
																			<tr>
																				<c:choose>
																					<c:when test="${QPR_CB_ACT_DATA.qprCbActivityDetails[1].qprTrgMaterialAndModule.materialUsed eq true}">
																					<c:choose><c:when test="${QPR_CB_ACT_DATA.isFreeze eq true}">
																					<td><div align="center"><input type="checkbox" name="qprCbActivityDetails[1].qprTrgMaterialAndModule.materialUsed" class="active12 form-control" checked="checked" disabled="disabled"></div></td>
																					</c:when><c:otherwise>
																					<td><div align="center"><input type="checkbox" name="qprCbActivityDetails[1].qprTrgMaterialAndModule.materialUsed" class="active12 form-control" checked="checked" ></div></td>
																					</c:otherwise>
																						</c:choose>
																					</c:when>
																					<c:otherwise><td><div align="center"><input type="checkbox" name="qprCbActivityDetails[1].qprTrgMaterialAndModule.materialUsed" class="active12 form-control"></div></td></c:otherwise>
																				</c:choose>
										<c:choose><c:when test="${QPR_CB_ACT_DATA.isFreeze eq true}">
										<td><div align="center"><input name="qprCbActivityDetails[1].qprTrgMaterialAndModule.instituteInvolved"
																					value="${QPR_CB_ACT_DATA.qprCbActivityDetails[1].qprTrgMaterialAndModule.instituteInvolved}"
																					class="active12 form-control Align-Right" disabled="disabled"/></div></td>
										</c:when><c:otherwise>
										<td><div align="center"><input name="qprCbActivityDetails[1].qprTrgMaterialAndModule.instituteInvolved"
																					value="${QPR_CB_ACT_DATA.qprCbActivityDetails[1].qprTrgMaterialAndModule.instituteInvolved}"
																					class="active12 form-control Align-Right" /></div></td>
										</c:otherwise>
										
										</c:choose>
																				
																			</tr>
																	</table>
																</div>
															</div>
														</div>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
													</div>
												</div>
											</div>
										</div>
								<!-- Modal content Training Module ends here-->
								<!-- Modal content Training Material-->
									<div id="trainingMaterailModal" class="modal fade" role="dialog">
									<div class="modal-dialog modal-lg">
										<div class="modal-content modal-lg">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">&times;</button>
											</div>
											<div class="modal-body">
												<div class="row">
													<div class="form-group">
														<label for="sprc" class="col-sm-3"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
														<div class="col-sm-5">
																	<p class="text-justify"><strong>Training Material & Module</strong></p>
														</div>
													</div>
												</div>
												<div class="row clearfix">

													<div class="body">
														<div class="table-responsive">
															<table class="table table-bordered">
																<thead>
																	<tr>
																		<th><div align="center">Material Used</div></th>
																		<th><div align="center">Institute Involved</div></th>
																	</tr>
																</thead>
																<tbody>
																<tr> 
																	<c:choose>
																		<c:when test="${QPR_CB_ACT_DATA.qprCbActivityDetails[2].qprTrgMaterialAndModule.materialUsed eq true}">
																		<c:choose><c:when test="${QPR_CB_ACT_DATA.isFreeze eq true}">
																			<td><div align="center"><input type="checkbox" name="qprCbActivityDetails[2].qprTrgMaterialAndModule.materialUsed" class="form-control" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[2].qprTrgMaterialAndModule.materialUsed}" checked="checked" disabled="disabled"></div></td>
																					</c:when><c:otherwise>
																			<td><div align="center"><input type="checkbox" name="qprCbActivityDetails[2].qprTrgMaterialAndModule.materialUsed" class="form-control" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[2].qprTrgMaterialAndModule.materialUsed}" checked="checked" ></div></td>
																					</c:otherwise>
																						</c:choose>
																		</c:when>
																		<c:otherwise><td><div align="center"><input type="checkbox" name="qprCbActivityDetails[2].qprTrgMaterialAndModule.materialUsed" class="form-control" > </div></td></c:otherwise>
																	</c:choose>
																	<c:choose><c:when test="${QPR_CB_ACT_DATA.isFreeze eq true}">
																	<td><div align="center"><input name="qprCbActivityDetails[2].qprTrgMaterialAndModule.instituteInvolved" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[2].qprTrgMaterialAndModule.instituteInvolved}" class="active12 Align-Right form-control"  disabled="disabled"/></div></td>
																</c:when>
																<c:otherwise>
																<td><div align="center"><input name="qprCbActivityDetails[2].qprTrgMaterialAndModule.instituteInvolved" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[2].qprTrgMaterialAndModule.instituteInvolved}" class="active12 Align-Right form-control"  /></div></td>
																</c:otherwise>
																</c:choose>
																</tr>
															</table>
														</div>
													</div>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
											</div>
										</div>
									</div>
								</div>
								<!-- Modal content Training Material ends here-->
								<!-- Modal content TNA & Training Evaluation second-->
									<div id="tnaTrainingEavltionModal2" class="modal fade" role="dialog">
									<div class="modal-dialog modal-lg">
										<div class="modal-content modal-lg">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">&times;</button>
											</div>
											<div class="modal-body">
												<div class="row">
													<div class="form-group">
														<label for="sprc" class="col-sm-3"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
														<div class="col-sm-5">
																	<p class="text-justify"><strong>TNA & Training Evaluation</strong></p>
														</div>
													</div>
												</div>
												<div class="row clearfix">

													<div class="body">
														<div class="table-responsive">
															<table class="table table-bordered">
																<thead>
																	<tr>
																		<th><div align="center">No. of Person Involved</div></th>
																		<th><div align="center">Training Subjects</div></th>
																		<th><div align="center">File Upload(PDF)</div></th>
																	</tr>
																</thead>
																<tbody>
																<tr>
																	<td><form:input path="qprCbActivityDetails[3].qprTnaTrgEvaluation.noOfPersons" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[3].qprTnaTrgEvaluation.noOfPersons}" class="active12 Align-Right form-control Align-Right" readonly="${QPR_CB_ACT_DATA.isFreeze}"/></td>
																	<td>
																		<select name="qprCbActivityDetails[3].qprTnaTrgEvaluation.trngSubject" id ="sel" class="form-control" >
																			<option value="">select</option>
																			<c:forEach items="${SUBJECTS_LIST}" var="sbjctLst">
																				<c:choose>
																						<c:when
																							test="${QPR_CB_ACT_DATA.qprCbActivityDetails[3].qprTnaTrgEvaluation.trngSubject == sbjctLst.subjectId}">
																							<option value="${sbjctLst.subjectId}" selected="selected">${sbjctLst.subjectName}</option>
																						</c:when>
																						<c:otherwise>
																							<option value="${sbjctLst.subjectId}">${sbjctLst.subjectName}</option>
																						</c:otherwise>
																					</c:choose>
																			</c:forEach>
																		</select>
																	</td>
																	<td>
																	<c:choose>
																		<c:when test="${QPR_CB_ACT_DATA.isFreeze}"><input name="qprCbActivityDetails[3].qprTnaTrgEvaluation.file" type="file" class="form-control" disabled="disabled"/></c:when>
																		<c:otherwise><input name="qprCbActivityDetails[3].qprTnaTrgEvaluation.file" type="file" class="form-control"/></c:otherwise>
																	</c:choose>
																	<c:if test="${not empty QPR_CB_ACT_DATA and  not empty QPR_CB_ACT_DATA.qprCbActivityDetails[3].qprTnaTrgEvaluation.fileNode.uploadName}">
																		<input type="button" value="Download File" class="btn bg-grey waves-effect" onclick='showImage("TnaTrgEvaluation",${QPR_CB_ACT_DATA.qprCbActivityDetails[3].qprTnaTrgEvaluation.qprTnaTrgEvaluationId});' />
																	</c:if>
																	</td>
																</tr>
															</table>
														</div>
													</div>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
											</div>
										</div>
									</div>
								</div>
								<!-- Modal content TNA & Training Evaluation second ends here-->
								<!-- Modal content Hand Holding For gpdp-->
									<div id="handHoldingModal" class="modal fade" role="dialog">
									<div class="modal-dialog modal-lg">
										<div class="modal-content modal-lg">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">&times;</button>
											</div>
											<div class="modal-body">
												<div class="row">
													<div class="form-group">
														<label for="sprc" class="col-sm-3"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
														<div class="col-sm-5">
																	<p class="text-justify"><strong>Hand Holding For GPDP</strong></p>
														</div>
													</div>
												</div>
												<div class="row clearfix">

													<div class="body">
														<div class="table-responsive">
															<table class="table table-bordered">
																<thead>
																	<tr>
																		<th><div align="center">Institute Involved</div></th>
																		<th><div align="center">File Upload(PDF)</div></th>
																	</tr>
																</thead>
																<tbody>
																<tr>
																<c:choose><c:when test="${QPR_CB_ACT_DATA.isFreeze eq true}">
																<td><input name="qprCbActivityDetails[6].qprHandholdingGpdp.instituteInvolved" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[6].qprHandholdingGpdp.instituteInvolved}" class="active12 Align-Right form-control" readonly="${QPR_CB_ACT_DATA.isFreeze}"/></td>
																</c:when>
																<c:otherwise>
																<td><input name="qprCbActivityDetails[6].qprHandholdingGpdp.instituteInvolved" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[6].qprHandholdingGpdp.instituteInvolved}" class="active12 Align-Right form-control" /></td>
																</c:otherwise>
																	</c:choose>
																	<td>
																	<c:choose>
																		<c:when test="${QPR_CB_ACT_DATA.isFreeze}"><input name="qprCbActivityDetails[6].qprHandholdingGpdp.file" type="file" class="active12 form-control" disabled="disabled"/></c:when>
																		<c:otherwise><input name="qprCbActivityDetails[6].qprHandholdingGpdp.file" type="file" class="active12 form-control"/></c:otherwise>
																	</c:choose>
																	
																	<c:if test="${not empty QPR_CB_ACT_DATA and  not empty QPR_CB_ACT_DATA.qprCbActivityDetails[6].qprHandholdingGpdp.fileNode.uploadName}">
																		<input type="button" value="Download File" class="btn bg-grey waves-effect" onclick='showImage("HandholdingGpdp",${QPR_CB_ACT_DATA.qprCbActivityDetails[6].qprHandholdingGpdp.qprHandholdingGpdpId});' />
																	</c:if>
																	</td>
																</tr>
															</table>
														</div>
													</div>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
											</div>
										</div>
									</div>
								</div>
								<!-- Modal content Hand Holding For gpdp ends here-->
								<!-- Modal content Panchayat Learning Center-->
									<div id="panchayatCentrerModal" class="modal fade" role="dialog">
									<div class="modal-dialog modal-lg">
										<div class="modal-content modal-lg">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">&times;</button>
											</div>
											<div class="modal-body">
												<div class="row">
													<div class="form-group">
														<label for="sprc" class="col-sm-3"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
														<div class="col-sm-5">
																	<p class="text-justify"><strong>Panchayat Learning Center</strong></p>
														</div>
													</div>
												</div>
												<div class="row clearfix">

													<div class="body">
														<div class="table-responsive">
															<table class="table table-bordered">
																<thead>
																	<tr>
																		<th><div align="center">File Upload(PDF)</div></th>
																	</tr>
																</thead>
																<tbody>
																<tr>
																	<td>
																		<div align="center" class="row">
																		<c:choose>
																			<c:when test="${QPR_CB_ACT_DATA.isFreeze}"><input name="qprCbActivityDetails[7].qprPanchayatLearningCenter.file" type="file" class="active12 form-control" disabled="disabled"/></c:when>
																			<c:otherwise><input name="qprCbActivityDetails[7].qprPanchayatLearningCenter.file" type="file" class="active12 form-control"/></c:otherwise>
																		</c:choose>
																		<c:if test="${not empty QPR_CB_ACT_DATA and not empty QPR_CB_ACT_DATA.qprCbActivityDetails[7].qprPanchayatLearningCenter.fileNode.uploadName}">
																			<input type="button" value="Download File" class="btn bg-grey waves-effect" onclick='showImage("PanchayatLearningCenter",${QPR_CB_ACT_DATA.qprCbActivityDetails[7].qprPanchayatLearningCenter.qprPanchayatLearningId});' />
																		</c:if>
																		</div>
																	</td>
																</tr>
															</table>
														</div>
													</div>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
											</div>
										</div>
									</div>
								</div>
								<!-- Modal content ends here-->
								
								<!-- Modal content exposure visit inside-->
									<%-- <div id="exposureVisitState" class="modal fade" role="dialog">
									<div class="modal-dialog modal-lg">
										<div class="modal-content modal-lg">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">&times;</button>
											</div>
											<div class="modal-body">
												<div class="row">
													<div class="form-group">
														<div class="col-sm-5">
															<p class="text-justify"><strong>&nbsp;&nbsp;Exposure visit (inside state)</strong></p>
														</div>
													</div>
												</div>
												<div class="row clearfix">

													<div class="body">
														<div class="table-responsive">
															<table class="table table-bordered table-hover">
																<thead>
																	<tr>
																		<th rowspan="3" style="padding-bottom: 4%;"><div align="center"><strong>Participants category</strong></div></th>
																		<th colspan="4"><div align="center"><strong>Elected Representatives</strong></div></th>
																		<th colspan="2" rowspan="2" style="padding-bottom: 2%;"><div align="center"><strong>Functionaries & other stakeholders</strong></div></th>
																	</tr>
																	<tr>
																		<th colspan="2"><div align="center"><strong>Sarpanch</strong></div></th>
																		<th colspan="2"><div align="center"><strong>Other ERs</strong></div></th>
																	</tr>
																	<tr>
																		<th><div align="center"><strong>Male</strong></div></th>
																		<th><div align="center"><strong>Female</strong></div></th>
																		<th><div align="center"><strong>Male</strong></div></th>
																		<th><div align="center"><strong>Female</strong></div></th>
																		<th><div align="center"><strong>Male</strong></div></th>
																		<th><div align="center"><strong>Female</strong></div></th>
																	</tr>
																</thead>
																<tbody>
																	<tr>
																		<td><div align="center"><strong>SC</strong></div></td>
																		<td><form:input path=""  class="form-control Align-Right" id="sarpanchMaleScId" onkeyup="" onkeypress="return isNumber(event)" /></td>
																		<td><form:input path="" class="form-control Align-Right" id="sarpanchFemaleScId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="otherErMaleScId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="otherErFemaleScId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="functionariedMaleScId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="functionariedFemaleScId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																	</tr>
																	<tr>
																		<td><div align="center"><strong>ST</strong></div></td>
																		<td><form:input path="" class="form-control Align-Right" id="sarpanchMaleStId" onkeyup="" onkeypress="return isNumber(event)" /></td>
																		<td><form:input path="" class="form-control Align-Right" id="sarpanchFemaleStId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="otherErMaleStId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="otherErFemaleStId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="functionariedMaleStId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="functionariedFemaleStId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																	</tr>
																	<tr>
																		<td><div align="center"><strong>Others</strong></div></td>
																		<td><form:input path="" class="form-control Align-Right" id="sarpanchMaleOthersId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="sarpanchFemaleOthersId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="otherErMaleOthersId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="otherErFemaleOthersId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="functionariedMaleOthersId" onkeyup="" onkeypress="return isNumber(event)"/></td>
																		<td><form:input path="" class="form-control Align-Right " id="functionariedFemaleOthersId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																	</tr>
																	<tr>
																		<td><div align="center"><strong>Total</strong></div></td>
																		<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalMaleSarpanch" /></td>
																		<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalFemaleSarpanch" /></td>
																		<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalMaleOtherEr" /></td>
																		<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalFemaleOtherEr" /></td>
																		<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalMaleFunctionaries" /></td>
																		<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalFemaleFunctionaries" /></td>
																	</tr>
																</tbody>
															</table>
														</div>
													</div>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
											</div>
										</div>
									</div>
								</div> --%>
								<!-- Modal content ends here-->
								
								<!-- Modal content exposure visit outside-->
									<%-- <div id="exposureVisitOutside" class="modal fade" role="dialog">
									<div class="modal-dialog modal-lg">
										<div class="modal-content modal-lg">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">&times;</button>
											</div>
											<div class="modal-body">
												<div class="row">
													<div class="form-group">
														<div class="col-sm-5">
																<p class="text-justify"><strong>&bnsp;&bnsp;Exposure visit (outside state)</strong></p>
														</div>
													</div>
												</div>
												<div class="row clearfix">

													<div class="body">
														<div class="table-responsive">
															<table class="table table-bordered table-hover">
																<thead>
																	<tr>
																		<th rowspan="3" style="padding-bottom: 4%;"><div align="center"><strong>Participants category</strong></div></th>
																		<th colspan="4"><div align="center"><strong>Elected Representatives</strong></div></th>
																		<th colspan="2" rowspan="2" style="padding-bottom: 2%;"><div align="center"><strong>Functionaries & other stakeholders</strong></div></th>
																	</tr>
																	<tr>
																		<th colspan="2"><div align="center"><strong>Sarpanch</strong></div></th>
																		<th colspan="2"><div align="center"><strong>Other ERs</strong></div></th>
																	</tr>
																	<tr>
																		<th><div align="center"><strong>Male</strong></div></th>
																		<th><div align="center"><strong>Female</strong></div></th>
																		<th><div align="center"><strong>Male</strong></div></th>
																		<th><div align="center"><strong>Female</strong></div></th>
																		<th><div align="center"><strong>Male</strong></div></th>
																		<th><div align="center"><strong>Female</strong></div></th>
																	</tr>
																</thead>
																<tbody>
																	<tr>
																		<td><div align="center"><strong>SC</strong></div></td>
																		<td><form:input path=""  class="form-control Align-Right" id="sarpanchMaleScId" onkeyup="" onkeypress="return isNumber(event)" /></td>
																		<td><form:input path="" class="form-control Align-Right" id="sarpanchFemaleScId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="otherErMaleScId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="otherErFemaleScId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="functionariedMaleScId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="functionariedFemaleScId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																	</tr>
																	<tr>
																		<td><div align="center"><strong>ST</strong></div></td>
																		<td><form:input path="" class="form-control Align-Right" id="sarpanchMaleStId" onkeyup="" onkeypress="return isNumber(event)" /></td>
																		<td><form:input path="" class="form-control Align-Right" id="sarpanchFemaleStId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="otherErMaleStId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="otherErFemaleStId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="functionariedMaleStId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="functionariedFemaleStId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																	</tr>
																	<tr>
																		<td><div align="center"><strong>Others</strong></div></td>
																		<td><form:input path="" class="form-control Align-Right" id="sarpanchMaleOthersId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="sarpanchFemaleOthersId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="otherErMaleOthersId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="otherErFemaleOthersId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																		<td><form:input path="" class="form-control Align-Right" id="functionariedMaleOthersId" onkeyup=""  /></td>
																		<td><form:input path="" class="form-control Align-Right " id="functionariedFemaleOthersId" onkeyup="" onkeypress="return isNumber(event)"  /></td>
																	</tr>
																	<tr>
																		<td><div align="center"><strong>Total</strong></div></td>
																		<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalMaleSarpanch" /></td>
																		<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalFemaleSarpanch" /></td>
																		<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalMaleOtherEr" /></td>
																		<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalFemaleOtherEr" /></td>
																		<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalMaleFunctionaries" /></td>
																		<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalFemaleFunctionaries" /></td>
																	</tr>
																</tbody>
															</table>
														</div>
													</div>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
											</div>
										</div>
									</div>
								</div> --%>
								<!-- Modal content ends here-->
							</div>
							
							<div class="form-group text-right ex1" style="margin-bottom: 5px;">
							<c:choose>
								<c:when test="${QPR_CB_ACT_DATA.isFreeze}"><input type="submit" name="origin" value="SAVE"  class="btn bg-green waves-effect" disabled="disabled" id="savebtn"/></c:when>
								<c:otherwise><input type="submit" name="origin" value="SAVE"  class="btn bg-green waves-effect" id="savebtn" /></c:otherwise>
							</c:choose>
								<c:choose>
									<c:when test="${QPR_CB_ACT_DATA.isFreeze}"><button class="btn bg-orange waves-effect" onclick="FreezeAndUnfreeze('unfreeze')" type="button" id="unfreezebtn">UNFREEZE<button></c:when>
									<c:otherwise><button class="btn bg-orange waves-effect" disabled="${DISABLE_FREEZE}" onclick="FreezeAndUnfreeze('freeze')" type="button" id="freezebtn">FREEZE<button></c:otherwise>
								</c:choose>
								<%-- <form:button type="button" data-ng-click="onClear(this)" class="btn bg-light-blue waves-effect" disabled="${QPR_CB_ACT_DATA.isFreeze}">
									<spring:message code="Label.CLEAR" htmlEscape="true"/>
								</form:button> --%>
								<form:button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-red waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</form:button>
							</div><br />
						</div>
						</div>
						</div>
						<!-- HIDDEN FIELDS STARTS-->
							<!---- qprTnaTrgEvaluation ends ----->
							 <input type="hidden" name="qprCbActivityDetails[0].qprTnaTrgEvaluation.qprTnaTrgEvaluationId" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[0].qprTnaTrgEvaluation.qprTnaTrgEvaluationId}">
							 <input type="hidden" name="qprCbActivityDetails[0].qprTnaTrgEvaluation.fileNode.fileNodeId" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[0].qprTnaTrgEvaluation.fileNode.fileNodeId}">
							 <input type="hidden" name="qprCbActivityDetails[3].qprTnaTrgEvaluation.qprTnaTrgEvaluationId" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[3].qprTnaTrgEvaluation.qprTnaTrgEvaluationId}">
							 <input type="hidden" name="qprCbActivityDetails[3].qprTnaTrgEvaluation.fileNode.fileNodeId" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[3].qprTnaTrgEvaluation.fileNode.fileNodeId}">
							 <!---- qprTnaTrgEvaluation ends ----->
							 <!----materialUsed ----->
							 <input type="hidden" name="qprCbActivityDetails[1].qprTrgMaterialAndModule.qprTrgMaterialAndModuleId" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[1].qprTrgMaterialAndModule.qprTrgMaterialAndModuleId}">
							 <input type="hidden" name="qprCbActivityDetails[2].qprTrgMaterialAndModule.qprTrgMaterialAndModuleId" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[2].qprTrgMaterialAndModule.qprTrgMaterialAndModuleId}">
							 <!---materialUsed end ----->
							 <!------qprHandholdingGpdp starts----->
							 <input type="hidden" name="qprCbActivityDetails[6].qprHandholdingGpdp.qprHandholdingGpdpId" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[6].qprHandholdingGpdp.qprHandholdingGpdpId}">
							 <input type="hidden" name="qprCbActivityDetails[6].qprHandholdingGpdp.fileNode.fileNodeId" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[6].qprHandholdingGpdp.fileNode.fileNodeId}">
							 <!------qprHandholdingGpdp ends----->
							 <!------ qprPanchayatLearningCenter starts -------->
							 <input type="hidden" name="qprCbActivityDetails[7].qprPanchayatLearningCenter.qprPanchayatLearningId" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[7].qprPanchayatLearningCenter.qprPanchayatLearningId}">
							 <input type="hidden" name="qprCbActivityDetails[7].qprPanchayatLearningCenter.fileNode.fileNodeId" value="${QPR_CB_ACT_DATA.qprCbActivityDetails[7].qprPanchayatLearningCenter.fileNode.fileNodeId}">
							 <!------ qprPanchayatLearningCenter ends -------->
							 
							 <input type="hidden" name="showQqrtrId" id="quaterTransient" value="${QTR_ID}" />
							 <input type="hidden" name="capacityBuildingActivity.cbActivityId" value="${CEC_APPROVED_ACTIVITY.cbActivityId}" />
							 <input type="hidden" name="path" id="path" > 
							 <input type="hidden" name="dbFileName" id="dbFileName" >
						<!-- HIDDEN FIELDS ENDS -->
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
<style>
.ex1 {
  margin-left: -10px;
}
.Align-Right {
	text-align: right;
}
</style>
