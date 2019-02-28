<%@include file="../taglib/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
 var calculated_total_sum = 0;
     
     $("#mytable .expnditure").each(function () {
         var get_textbox_value = $(this).val();
         if ($.isNumeric(get_textbox_value)) {
            calculated_total_sum += parseFloat(get_textbox_value);
            }                  
          });
     document.getElementById("totalFunds").value=calculated_total_sum;
     document.getElementById("grandTotal").value=calculated_total_sum +  parseInt($('#additionalRequirements').val());
     
     $("#adtnlCalc").on('input',$("#additionalRequirements"), function () {
    	 if($('#additionalRequirements').val() == ''){
    		 return false;
    	 }else
		 document.getElementById("grandTotal").value=calculated_total_sum +  parseInt($('#additionalRequirements').val());
	})
     
		});

function getSelelctedQtrRprt(){
	 var qtId = $('#qtrIdDurtn').val();
	  $('#showQqrtrId').val(qtId); 
	 	 document.qpqCapacityBuilding.method = "post";
		document.qpqCapacityBuilding.action = "qprCapacityBuildingBasedOnQtr.html?<csrf:token uri='qprCapacityBuildingBasedOnQtr.html'/>";
		document.qpqCapacityBuilding.submit(); 
}

</script>

<html>
	<section class="content">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Training Activities</h2>
						</div>
						<form action="saveQprCapacityBuilding.html" method="POST" name="qpqCapacityBuilding" class="form-inline" modelAttribute="Qpr_Capacity_Building" enctype="multipart/form-data">
						 <input type="hidden" name="<csrf:token-name/>" value="<csrf:token-value uri="saveQprCapacityBuilding.html"/>" />
						<div align="center"><label><strong >Select Quarter Duration</strong></label></div>
							<div align="center"><label>
								<select name="quarterDuration.qtrId" id="qtrIdDurtn" onchange="getSelelctedQtrRprt();"  class="form-control">
									 <c:forEach items="${quarter_duration}" var="duration">
										<c:choose>
					            				<c:when test="${duration.qtrId == SetNewQtrId}">
				                   					<option value="${duration.qtrId}" selected="selected">${duration.qtrDuration} </option>
				                   				</c:when>
				                   				<c:otherwise>
				                   					<option value="${duration.qtrId}">${duration.qtrDuration} </option>
				                   				</c:otherwise>
						                   	</c:choose>
			                       		</c:forEach>
                             	</select>
                             </label></div>
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane fade in active"
								id="home_with_icon_title">
								<div class="table-responsive">
								
									<table class="table table-hover dashboard-task-infos" id="mytable" >
										<thead>
											<tr>
												<th>
													<div align="center">
														<strong>S.No.</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Activity
														</strong>
													</div>
												</th>
												
												<th>
													<div align="center">
														<strong>No. of Days Completed
														</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>No. of Units Completed
														</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Expenditure Incurred</strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>Fill Details</strong>
													</div>
												</th>
											</tr>
										</thead>
										
										<tbody>
										 <c:forEach items="${cbMasters}" var="cbMasters" varStatus="count">
											<tr>
												<td>${count.count}</td>
												<td>${cbMasters.cbName}
													<input type="hidden" class="form-control" value="${cbMasters.cbMasterId}" style="text-align:right;" />
												</td>
												<td>
													<input style="text-align:right;" name="qprCbActivityDetails[${count.index}].noOfDaysCompleted" value="${qprCbActivities.qprCbActivityDetails[count.index].noOfDaysCompleted}" type="text" maxlength="3" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" class="form-control"/>
												</td>
												<td>
													<input  maxlength="5" type="text"  name="qprCbActivityDetails[${count.index}].noOfUnitsCompleted" value="${qprCbActivities.qprCbActivityDetails[count.index].noOfUnitsCompleted}" class="form-control" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="text-align:right;"/>
												</td>
												<td>
													<input maxlength="7"  min="1"  type="text" name="qprCbActivityDetails[${count.index}].expenditureIncurred" value="${qprCbActivities.qprCbActivityDetails[count.index].expenditureIncurred}" class="form-control expnditure" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="text-align:right;" />
												</td>
												<!----------------------------- modal Starts  here------------------------------------------------ -->
													<c:choose>
												<c:when test="${count.index eq 0 }">
													<td><button type="button"
															class="btn btn-primary btn-lg" data-toggle="modal"
															data-target="#myModal">Fill Details</button></td>
												</c:when>

												<c:when test="${count.index eq 1}">
													<td><button type="button"
															class="btn btn-primary btn-lg" data-toggle="modal"
															data-target="#myModal1">Fill Details</button></td>
												</c:when>
												<c:when test="${count.index eq 2}">
													<td><button type="button"
															class="btn btn-primary btn-lg" data-toggle="modal"
															data-target="#myModal2">Fill Details</button></td>
												</c:when>
												<c:when test="${count.index eq 3 }">
													<td><button type="button"
															class="btn btn-primary btn-lg" data-toggle="modal"
															data-target="#myModal3">Fill Details</button></td>
												</c:when>
												<c:when test="${count.index eq 6}">
													<td><button type="button"
															class="btn btn-primary btn-lg" data-toggle="modal"
															data-target="#myModal6">Fill Details</button></td>
												</c:when>
												<c:when test="${count.index eq 7}">
													<td><button type="button"
															class="btn btn-primary btn-lg" data-toggle="modal"
															data-target="#myModal7">Fill Details</button></td>
												</c:when>
												
												<c:otherwise>
													<td></td>
												</c:otherwise>
											</c:choose>
												
												<!----------------------------- modal ends  here------------------------------------------------ -->
											</tr>
											 <input type="hidden" name="showQqrtrId" id="showQqrtrId">
											 <input type="hidden" name="isFreeze" id="isFreeze" value="${qprCapacityBuilding.isFreeze}" />
											 <input type="hidden" name="qpCbActivityId" value="${qprCbActivities.qpCbActivityId}">
											 <input type="hidden" name="qprCbActivityDetails[${count.index}].capacityBuildingActivityDetails.capacityBuildingActivityDetailsId" value="${capacityBuildingDetails[count.index].capacityBuildingActivityDetailsId}">
											 <input type="hidden" name="qprCbActivityDetails[${count.index}].qprCbActivityDetailsId" value="${qprCbActivities.qprCbActivityDetails[count.index].qprCbActivityDetailsId}">
											 <input type="hidden" name="capacityBuildingActivity.cbActivityId" value="${capacityBuildingActivity.cbActivityId}" >
											</c:forEach>
											 
											<tr>
												<th colspan="4" align="center" >&nbsp;&nbsp;Total Funds</th>
												<td><input type="text" maxlength="5" id="totalFunds" disabled="disabled"  class="form-control" style="text-align:right;" /></td>											
												<td></td>
												<td></td>
											</tr>
											<tr id="adtnlCalc">
												<th colspan="4">&nbsp;&nbsp;Additional Requirement</th>
												<td ><input type="text" class="form-control" id="additionalRequirements" value="${qprCbActivities.additionalRequirement}" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" name="additionalRequirement" placeholder="25% of Total Cost " style="text-align:right;" /></td>
												<td></td>
												<td><input type="hidden" name="qprCbActivityDetails[0].qprTnaTrgEvaluation[0].qprTnaTrgEvaluationId" value="${qprCbActivities.qprCbActivityDetails[0].qprTnaTrgEvaluation[0].qprTnaTrgEvaluationId}">
													 <input type="hidden" name="qprCbActivityDetails[0].qprTnaTrgEvaluation[0].fileName" value="${qprCbActivities.qprCbActivityDetails[0].qprTnaTrgEvaluation[0].fileName}">
													 <input type="hidden" name="qprCbActivityDetails[0].qprTnaTrgEvaluation[0].fileLocation" value="${qprCbActivities.qprCbActivityDetails[0].qprTnaTrgEvaluation[0].fileLocation}">
													 <input type="hidden" name="qprCbActivityDetails[0].qprTnaTrgEvaluation[0].fileContentType" value="${qprCbActivities.qprCbActivityDetails[0].qprTnaTrgEvaluation[0].fileContentType}">
													 <input type="hidden" name="qprCbActivityDetails[3].qprTnaTrgEvaluation[0].qprTnaTrgEvaluationId" value="${qprCbActivities.qprCbActivityDetails[3].qprTnaTrgEvaluation[0].qprTnaTrgEvaluationId}">
													 <input type="hidden" name="qprCbActivityDetails[3].qprTnaTrgEvaluation[0].fileName" value="${qprCbActivities.qprCbActivityDetails[3].qprTnaTrgEvaluation[0].fileName}">
													 <input type="hidden" name="qprCbActivityDetails[3].qprTnaTrgEvaluation[0].fileLocation" value="${qprCbActivities.qprCbActivityDetails[3].qprTnaTrgEvaluation[0].fileLocation}">
													 <input type="hidden" name="qprCbActivityDetails[3].qprTnaTrgEvaluation[0].fileContentType" value="${qprCbActivities.qprCbActivityDetails[3].qprTnaTrgEvaluation[0].fileContentType}">
													 <input type="hidden" name="qprCbActivityDetails[1].qprTrgMaterialAndModule[0].qprTrgMaterialAndModuleId" value="${qprCbActivities.qprCbActivityDetails[1].qprTrgMaterialAndModule[0].qprTrgMaterialAndModuleId}">
													 <input type="hidden" name="qprCbActivityDetails[2].qprTrgMaterialAndModule[0].qprTrgMaterialAndModuleId" value="${qprCbActivities.qprCbActivityDetails[2].qprTrgMaterialAndModule[0].qprTrgMaterialAndModuleId}">
													 <input type="hidden" name="qprCbActivityDetails[6].qprHandholdingGpdp.qprHandholdingGpdpId" value="${qprCbActivities.qprCbActivityDetails[6].qprHandholdingGpdp.qprHandholdingGpdpId}">
													 <input type="hidden" name="qprCbActivityDetails[6].qprHandholdingGpdp.fileName" value="${qprCbActivities.qprCbActivityDetails[6].qprHandholdingGpdp.fileName}">
													 <input type="hidden" name="qprCbActivityDetails[6].qprHandholdingGpdp.fileLocation" value="${qprCbActivities.qprCbActivityDetails[6].qprHandholdingGpdp.fileLocation}">
													 <input type="hidden" name="qprCbActivityDetails[6].qprHandholdingGpdp.fileContentType" value="${qprCbActivities.qprCbActivityDetails[6].qprHandholdingGpdp.fileContentType}">
													 <input type="hidden" name="qprCbActivityDetails[7].qprPanchayatLearningCenter.qprPanchayatLearningId" value="${qprCbActivities.qprCbActivityDetails[7].qprPanchayatLearningCenter.qprPanchayatLearningId}">
													 <input type="hidden" name="qprCbActivityDetails[7].qprPanchayatLearningCenter.fileName" value="${qprCbActivities.qprCbActivityDetails[7].qprPanchayatLearningCenter.fileName}">
													 <input type="hidden" name="qprCbActivityDetails[7].qprPanchayatLearningCenter.fileLocation" value="${qprCbActivities.qprCbActivityDetails[7].qprPanchayatLearningCenter.fileLocation}">
													 <input type="hidden" name="qprCbActivityDetails[7].qprPanchayatLearningCenter.fileContentType" value="${qprCbActivities.qprCbActivityDetails[7].qprPanchayatLearningCenter.fileContentType}">
											</td>
											</tr>
											<tr>
												<th colspan="4">&nbsp;Total Proposed Fund</th>
												<td ><input type="text" maxlength="5" id="grandTotal" disabled="disabled" class="form-control" style="text-align:right;" /></td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
									</table>
									<!-- Modal content TNA & Training Evaluation-->
									<div id="myModal" class="modal fade" role="dialog">
									<div class="modal-dialog">
										<div class="modal-content">
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
																	<td><input type="text" name="qprCbActivityDetails[0].qprTnaTrgEvaluation[0].noOfPersons" value="${qprCbActivities.qprCbActivityDetails[0].qprTnaTrgEvaluation[0].noOfPersons}" class="active12 form-control Align-Right"></td>
																	<td>
																		<select name="qprCbActivityDetails[0].qprTnaTrgEvaluation[0].trngSubject.subjectId" type="text" class="active12 form-control">
																			<c:forEach items="${subjectsList}" var="sbjctLst">
																			<c:choose>
																				<c:when test="${qprCbActivities.qprCbActivityDetails[0].qprTnaTrgEvaluation[0].trngSubject.subjectId == sbjctLst.subjectId}">
																					<option value="${sbjctLst.subjectId}" selected="selected">${sbjctLst.subjectName}</option>
																				</c:when>
																				<c:otherwise>
																					<option value="${sbjctLst.subjectId}" >${sbjctLst.subjectName}</option>
																				</c:otherwise>
																			</c:choose>	
																			</c:forEach>	
																		</select>
																	</td>
																	<td><input name="qprCbActivityDetails[0].qprTnaTrgEvaluation[0].file" type="file" class="active12 form-control"/></td>
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
								<!-- Modal content Training Module-->
									<div id="myModal1" class="modal fade" role="dialog">
									<div class="modal-dialog">
										<div class="modal-content">
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
																		<th><div align="center">Module Used</div></th>
																		<th><div align="center">Institute Involved</div></th>
																	</tr>
																</thead>
																<tbody>
																<tr> <c:if test="${qprCbActivities.qprCbActivityDetails[1].qprTrgMaterialAndModule[0].materialUsed ==  true}">
																		<td><input type="radio" name="qprCbActivityDetails[1].qprTrgMaterialAndModule[0].materialUsed" checked="checked" class="active12 form-control"></td>
																	</c:if>
																	<c:if test="${empty qprCbActivities.qprCbActivityDetails[1].qprTrgMaterialAndModule[0].materialUsed}">
																		<td><input type="radio" name="qprCbActivityDetails[1].qprTrgMaterialAndModule[0].materialUsed" class="active12 form-control"></td>
																	</c:if>
																	
																	<td><input type="text" name="qprCbActivityDetails[1].qprTrgMaterialAndModule[0].instituteInvolved" value="${qprCbActivities.qprCbActivityDetails[1].qprTrgMaterialAndModule[0].instituteInvolved}" class="active12 form-control"  /></td>
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
								<!-- Modal content Training Material-->
									<div id="myModal2" class="modal fade" role="dialog">
									<div class="modal-dialog">
										<div class="modal-content">
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
																<tr> <c:if test="${qprCbActivities.qprCbActivityDetails[2].qprTrgMaterialAndModule[0].materialUsed ==  true}">
																		<td><input type="radio" name="qprCbActivityDetails[2].qprTrgMaterialAndModule[0].materialUsed" checked="checked" class="active12 form-control"></td>
																	</c:if>
																	<c:if test="${empty qprCbActivities.qprCbActivityDetails[2].qprTrgMaterialAndModule[0].materialUsed}">
																		<td><input type="radio" name="qprCbActivityDetails[2].qprTrgMaterialAndModule[0].materialUsed" class="active12 form-control"></td>
																	</c:if>
																	
																	<td><input type="text" name="qprCbActivityDetails[2].qprTrgMaterialAndModule[0].instituteInvolved" value="${qprCbActivities.qprCbActivityDetails[2].qprTrgMaterialAndModule[0].instituteInvolved}" class="active12 form-control"  /></td>
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
								<!-- Modal content TNA & Training Evaluation-->
									<div id="myModal3" class="modal fade" role="dialog">
									<div class="modal-dialog">
										<div class="modal-content">
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
																	<td><input type="text" name="qprCbActivityDetails[3].qprTnaTrgEvaluation[0].noOfPersons" value="${qprCbActivities.qprCbActivityDetails[3].qprTnaTrgEvaluation[0].noOfPersons}" class="active12 form-control Align-Right"></td>
																	<td>
																		<select name="qprCbActivityDetails[3].qprTnaTrgEvaluation[0].trngSubject.subjectId" type="text" class="active12 form-control">
																			<c:forEach items="${subjectsList}" var="sbjctLst">
																			<c:choose>
																				<c:when test="${qprCbActivities.qprCbActivityDetails[3].qprTnaTrgEvaluation[0].trngSubject.subjectId == sbjctLst.subjectId}">
																					<option value="${sbjctLst.subjectId}" selected="selected">${sbjctLst.subjectName}</option>
																				</c:when>
																				<c:otherwise>
																					<option value="${sbjctLst.subjectId}" >${sbjctLst.subjectName}</option>
																				</c:otherwise>
																			</c:choose>	
																			</c:forEach>	
																		</select>
																	</td>
																	<td><input name="qprCbActivityDetails[3].qprTnaTrgEvaluation[0].file" type="file" class="active12 form-control"/></td>
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
								<!-- Modal content Hand Holding For gpdp-->
									<div id="myModal6" class="modal fade" role="dialog">
									<div class="modal-dialog">
										<div class="modal-content">
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
																	<td><input name="qprCbActivityDetails[6].qprHandholdingGpdp.instituteInvolved" value="${qprCbActivities.qprCbActivityDetails[6].qprHandholdingGpdp.instituteInvolved}" type="text" class="active12 form-control"/></td>
																	<td><input name="qprCbActivityDetails[6].qprHandholdingGpdp.file" type="file" class="active12 form-control"/></td>
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
								<!-- Modal content Panchayat Learning Center-->
									<div id="myModal7" class="modal fade" role="dialog">
									<div class="modal-dialog">
										<div class="modal-content">
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
																	<td><div align="center"><input name="qprCbActivityDetails[7].qprPanchayatLearningCenter.file" type="file" class="active12 form-control"/></div></td>
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
								
									</div>
							</div>
							
							<div class="form-group text-right ex1">
							<button  type="submit" class="btn bg-green waves-effect">
									<spring:message code="Label.SAVE" htmlEscape="true" />
								</button>
								<%-- <button  type="button"  class="btn bg-green waves-effect">
									<spring:message code="UNFREEZE" htmlEscape="true" />
								</button>
								<button type="button" class="btn bg-green waves-effect">
									<spring:message code="FREEZE" htmlEscape="true" />
								</button> --%>
								
								<button type="button" data-ng-click="onClear()" class="btn bg-light-blue waves-effect">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</button>
								<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
							</div>
							
						</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
</html>
<style>
.ex1 {
  margin-left: -26px;
}
</style>