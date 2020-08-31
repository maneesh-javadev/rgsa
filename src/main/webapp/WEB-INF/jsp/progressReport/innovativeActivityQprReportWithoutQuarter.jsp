<%@include file="../taglib/taglib.jsp"%>
<%@include file="innovativeActivityQprReportWithoutQuarterJs.jsp"%>
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
	<div class="container-fluid">
		<div class="row clearfix">
			<!-- Task Info -->
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="card">
					<div class="header">
						<h2>Innovative Activity Quaterly Report</h2>
						<form:form method="POST" id="innovativeActFormId"
							name="innovativeActivity" class="form-inline"
							action="innovativeActivityQpr.html"
							modelAttribute="INNOVATIVE_ACTIVITY_QUATERLY_REPORT">
							<input type="hidden" name="<csrf:token-name/>"
								value="<csrf:token-value uri="innovativeActivityQpr"/>" />
							<div class="body">
								
						<input type="hidden" id="quaterDropDownId" name="quarterDuration.qtrId" value="0"/>	
								
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
										<table class="table table-bordered table-hover">
											<thead>
												<tr>
													<th><div align="center">S.No.</div></th>
													<th><div align="center">Name of Activity</div></th>
													<th><div align="center">Approved Amount</div></th>
													<th><div align="center">Expenditure Incurred</div></th>
												</tr>
											</thead>
											<tbody id="tbodyId">
											<c:forEach items="${CEC_APPROVED_ACTIVITY.innovativeActivityDetails}" var="cecDetailsData" varStatus="index">
													<!-- total number of units filled in rest quaters -->
													<c:choose>
														<c:when test="${not empty DEATIL_FOR_TOTAL_NO_OF_UNIT}">
															<input type="hidden"
																id="totalExpenditureIncurred_${index.index}"
																value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[index.index].expenditureIncurred}" />
														</c:when>
														<c:otherwise>
															<input type="hidden"
																id="totalExpenditureIncurred_${index.index}" value="0" />
														</c:otherwise>
													</c:choose>
													<!-- ends here -->

													<tr>
													<td><div align="center"><strong>${index.index + 1}. </strong></div></td>
													<td><div align="center"><strong>${cecDetailsData.activityName}</strong></div></td>
													<td><div align="center" id="fundCecId_${index.index}"><strong>${cecDetailsData.fundsName}</strong></div></td>
													<td><div align="center">
													<c:choose>
														<c:when test="${not empty QPR_INNOVATIVE_ACTIVITY}">
															<form:input class="form-control validate Align-Right" 
															path="qprInnovativeActivityDetails[${index.index}].expenditureIncurred" 
															id="expenditureIncurred_${index.index}" 
															value="${QPR_INNOVATIVE_ACTIVITY.qprInnovativeActivityDetails[index.index].expenditureIncurred}" 
															onkeyup="calTotalExpenditure()" readonly="${QPR_INNOVATIVE_ACTIVITY.isFreeze}"
															onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[0].balanceAmount}',this,null,'${cecDetailsData.fundsName}')"/>
														</c:when>
														<c:otherwise>
															<input type="text" class="form-control validate Align-Right" 
															name="qprInnovativeActivityDetails[${index.index}].expenditureIncurred" 
															id="expenditureIncurred_${index.index}" 
															onkeyup="calTotalExpenditure()"
															onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[0].balanceAmount}',this,null,'${cecDetailsData.fundsName}')"/>
														</c:otherwise>
													</c:choose>
													</div>
													<span class="errormsg" id="error_expenditureIncurred_${index.index}"></span>
													</td>
												</tr>
												<!-- HIDDEN FIELDS -->
													<input type="hidden" name="qprInnovativeActivityDetails[${index.index}].qprIaDetailsId" value="${QPR_INNOVATIVE_ACTIVITY.qprInnovativeActivityDetails[index.index].qprIaDetailsId}" />
											</c:forEach>
											<tr>
												<th><div align="center">Additional Requirement</div></th>
												<th><div align="center" id="additionalReqStateId">${CEC_APPROVED_ACTIVITY.additioinalRequirements}</div></th>
												<td></td>
												<td><div align="center"><form:input path="additioinalRequirements" id="additionalReqId" value="${QPR_INNOVATIVE_ACTIVITY.additioinalRequirements}" class="form-control validate Align-Right" onkeyup="validateAddReq();calTotalExpenditure()" readonly="${QPR_INNOVATIVE_ACTIVITY.isFreeze}"/></div></td>
											</tr>
											<tr>
											<th colspan="2"><div align="center">Total Expenditure Incurred</div></th>
											<td></td>
											<td><div align="center"><input type="text" id="totalExpenditureId"  class="form-control validate Align-Right" disabled="disabled" /></div></td>
											</tr>
											</tbody>
										</table>
									</div>
									<div class="form-group text-right" style="padding-right: 10px;">
										<form:button onclick="saveAndGetDataQtrRprt('save')" id="saveButtn"
											class="btn bg-green waves-effect" disabled="${QPR_INNOVATIVE_ACTIVITY.isFreeze}" >SAVE</form:button>
										<c:choose>
											<c:when test="${QPR_INNOVATIVE_ACTIVITY.isFreeze}">
												<form:button class="btn bg-orange waves-effect"
													onclick="FreezeAndUnfreeze('unfreeze')" id="unfreezebtn">UNFREEZE</form:button>
											</c:when>
											<c:otherwise>
												<form:button class="btn bg-orange waves-effect"
													disabled="${DISABLE_FREEZE}"
													onclick="FreezeAndUnfreeze('freeze')" id="freezebtn">FREEZE</form:button>
											</c:otherwise>
										</c:choose>	
										<%-- <form:button id="clearButtn" onclick="onClear(this)"
											class="btn bg-light-blue waves-effect" disabled="${QPR_INNOVATIVE_ACTIVITY.isFreeze}">CLEAR</form:button> --%>
										<form:button
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-red waves-effect">CLOSE</form:button>
									</div>
								</div>
								</div>
							</div>
								
							</div>
							<!-- HIDDEN FIELDS -->
							<input type="hidden" id="quaterTransient" name="qtrId" value="0"/>
							<input type="hidden" id="origin" name="origin" />
							<input type="hidden" name="qprIaId" value="${QPR_INNOVATIVE_ACTIVITY.qprIaId}" id="qprActivityId"/>
							<input type="hidden" name="innovativeActivity.innovativeActivityId" value="${CEC_APPROVED_ACTIVITY.innovativeActivityId}" />
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<style>
.Align-Right{
				text-align: right;}
</style>