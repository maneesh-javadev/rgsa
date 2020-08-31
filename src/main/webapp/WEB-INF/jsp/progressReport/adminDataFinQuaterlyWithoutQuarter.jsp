<%@include file="../taglib/taglib.jsp"%>
<%@include file="adminDataFinQuaterlyWithoutQuarterJs.jsp"%>
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
		<div class="block-header"></div>
		<div class="row clearfix">
			<!-- Task Info -->
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Label.AdminAndFinancialDataCell"
								htmlEscape="true" />
							Quaterly Report
						</h2>
					</div>
					<form:form method="POST" id="qprAdminAndFinancialDataActivityId"
						name="qprAdminAndFinancialDataActivity" class="form-inline"
						action="adminDataFinQuaterlyGet.html"
						modelAttribute="QPR_ADMIN_DATA_FIN">
						<input type="hidden" name="<csrf:token-name/>"
								value="<csrf:token-value uri="adminDataFinQuaterlyGet.html" />" />
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
								<table class="table table-bordered" id="mytable">
									<thead>
										<tr>
											<th rowspan="2">Type of Center</th>
											<th rowspan="2">Domain Experts</th>
											<th rowspan="2">Approved No. of Staff</th>
											<th rowspan="2">Approved Unit Cost</th>
											<th rowspan="2">Approved Amount</th>
											<th rowspan="2"><div align="center">no. Of Units
													Filled</div></th>
											<th rowspan="2"><div align="center">Expenditure
													incurred</div></th>
										</tr>
									</thead>
									<tbody id="tbodyId">
									<c:set var="count_length" value="0"/>
										<c:forEach
											items="${CEC_APPROVED_ACTIVITY.adminFinancialDataCellActivityDetails}"
											var="obj" varStatus="index">
											<c:set var="count_length" value="${index.index+1}"/>
											<tr>
												<!-- total number of units filled in rest quaters -->
												
											<c:choose>
												<c:when test="${not empty DEATIL_FOR_TOTAL_NO_OF_UNIT}">
												<input type="hidden" id="totalExpenditureIncurred_${index.index}"
														value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[index.index].expenditureIncurred}" />
												
													<input type="hidden" id="totalNoOfUnit_${index.index}"
														value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[index.index].noOfUnitsFilled}" />
												</c:when>
												<c:otherwise>
													<input type="hidden" id="totalNoOfUnit_${index.index}"
														value="0" />
													<input type="hidden" id="totalExpenditureIncurred_${index.index}"
														value="0" />	
												</c:otherwise>
											</c:choose>
											<!-- ends here -->
											<td><div align="center">
													<strong>${obj.pmuActivityType.pmuType.pmuTypeName}</strong>
												</div></td>
											<td><div align="center">
													<strong>${obj.pmuActivityType.pmuActivityName}</strong>
													<input type="hidden" name="qprAdminAndFinancialDataActivityDetails[${index.index}].pmuActivityType.pmuActivityTypeId" value="${obj.pmuActivityType.pmuActivityTypeId}"/>
												</div></td>
											<td><div align="center" id="noOfUnitCecId_${index.index}">
													<strong>${obj.noOfStaffProposed}</strong>
												</div></td>
											<td><div align="center" id="noOfUnitCecId_${index.index}">
												<strong>${obj.unitCost}</strong>
											</div></td>
											<td><div align="center" id="fundCecId_${index.index}">
													<strong>${obj.funds}</strong>
												</div></td>
											<c:choose>
												<c:when test="${not empty ADMIN_FIN_CELL_QPR_ACT}">
												<!-- hidden field on condition  -->
													<input type="hidden" name="qprAfpId" value="${ADMIN_FIN_CELL_QPR_ACT.qprAfpId}" id="qprActivityId"/>
													<input type="hidden" name="qprAdminAndFinancialDataActivityDetails[${index.index}].qprAfpDetailsId" value="${ADMIN_FIN_CELL_QPR_ACT.qprAdminAndFinancialDataActivityDetails[index.index].qprAfpDetailsId}" />
												<!-- hidden field ends here -->
													<td><form:input maxlength="7"
														class="form-control expnditureId"
														id="noOfUnitCompleted_${index.index}"
														path="qprAdminAndFinancialDataActivityDetails[${index.index}].noOfUnitsFilled"
														value="${ADMIN_FIN_CELL_QPR_ACT.qprAdminAndFinancialDataActivityDetails[index.index].noOfUnitsFilled}"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,'');validateNoOfUnits(${index.index});" 
														required="required" style="text-align: right;" 
														readonly="${ADMIN_FIN_CELL_QPR_ACT.isFreeze}"/>
														<span class="errormsg" id="error_noOfUnitCompleted_${index.index}"></span>	
														</td>

													<td>
													<form:input maxlength="7"
														class="form-control expnditureId"
														path="qprAdminAndFinancialDataActivityDetails[${index.index}].expenditureIncurred"
														id="expenditureIncurred_${index.index}" required="required"
														value="${ADMIN_FIN_CELL_QPR_ACT.qprAdminAndFinancialDataActivityDetails[index.index].expenditureIncurred}"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,'');isNoOfUnitAndExpInurredFilled(${index.index});calTotalExpenditure()" 
														style="text-align: right;" 
														readonly="${ADMIN_FIN_CELL_QPR_ACT.isFreeze}"
														onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[0].balanceAmount}',this,null,'${obj.funds}')"/>
														<span class="errormsg" id="error_expenditureIncurred_${index.index}"></span>
													</td>
												</c:when>
												<c:otherwise>
													<td><form:input maxlength="7"
														class="form-control expnditureId"
														id="noOfUnitCompleted_${index.index}" required="required"
														path="qprAdminAndFinancialDataActivityDetails[${index.index}].noOfUnitsFilled"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,'');validateNoOfUnits(${index.index});" style="text-align: right;"/>
														<span class="errormsg" id="error_noOfUnitCompleted_${index.index}"></span>	
														</td>

													<td><form:input maxlength="7"
														class="form-control expnditureId"
														path="qprAdminAndFinancialDataActivityDetails[${index.index}].expenditureIncurred"
														id="expenditureIncurred_${index.index}" required="required"
														onkeyup="this.value=this.value.replace(/[^0-9]/g,'');isNoOfUnitAndExpInurredFilled(${index.index});calTotalExpenditure()" 
														style="text-align: right;"
														onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[0].balanceAmount}',this,null,'${obj.funds}')"/>
														<span class="errormsg" id="error_expenditureIncurred_${index.index}"></span>
													</td>
														
												</c:otherwise>
											</c:choose>
											</tr>
										</c:forEach>
										<input type="hidden" id="admin_and_fin_count_length" value="${count_length}"/>
										<tr>
											<th colspan="2"><div align="center">Additional Requirement</div></th>
											<th colspan="4"><div align="center" id="additionalReqStateId">${CEC_APPROVED_ACTIVITY.additionalRequirement }</div></th>
											<td><form:input path="additionalRequirement" id="additionalReqId" value="${ADMIN_FIN_CELL_QPR_ACT.additionalRequirement}" class="form-control validate Align-Right" onkeyup="validateAddReq();calTotalExpenditure()" style="text-align: right;" readonly="${ADMIN_FIN_CELL_QPR_ACT.isFreeze}"/></td>
										</tr>
										
										<tr>
											<th colspan="2"><div align="center">Total Expenditure Incurred</div></th>
											<td colspan="4"></td>
											<td><input type="text" id="totalExpenditureId"  class="form-control validate Align-Right" disabled="disabled" style="text-align: right;"/>
											<span class="errormsg" id="error_total"></span></td>
										</tr>
									</tbody>
								</table>
								<br>
							</div>
							<div class="form-group text-right" style="padding-right: 10px;">
								<c:choose>
									<c:when test="${ADMIN_FIN_CELL_QPR_ACT.isFreeze}">
										<button type="button" onclick="saveAndGetDataQtrRprt('save')" id="saveButtn" disabled="disabled"
												class="btn bg-green waves-effect">SAVE</button>
										<button type="button" onclick="FreezeAndUnfreeze('unfreeze')"
													class="btn bg-orange waves-effect" id="unfreezebtn">UNFREEZE</button>
										<!-- <button type="button" id="clearButtn" onclick="onClear(this)"
											class="btn bg-light-blue waves-effect" disabled="disabled">CLEAR</button>	 -->				
									</c:when>
									<c:otherwise>
										<button type="button" onclick="saveAndGetDataQtrRprt('save')" id="saveButtn"
												class="btn bg-green waves-effect">SAVE</button>
										<c:choose>
											<c:when test="${DISABLE_FREEZE}">
												<button type="button" onclick="" disabled="disabled"
													class="btn bg-orange waves-effect" id="freezebtn">FREEZE</button>
												</c:when>
											<c:otherwise><button type="button" onclick="FreezeAndUnfreeze('freeze')"
													class="btn bg-orange waves-effect" id="freezebtn">FREEZE</button></c:otherwise>
										</c:choose>
										<!-- <button type="button" id="clearButtn" onclick="onClear(this)"
											class="btn bg-light-blue waves-effect">CLEAR</button> -->
										</c:otherwise>
								</c:choose>
								<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-red waves-effect">CLOSE</button>
							</div>
						</div>
						</div>
						</div>
						<br />
						<!-- hidden fields -->
						<input type="hidden" name="showQqrtrId" id="showQqrtrId">
						<input type="hidden" id="origin" name="origin" />
						<input type="hidden" name="adminAndFinancialDataActivity.adminFinancialDataActivityId" value="${CEC_APPROVED_ACTIVITY.adminFinancialDataActivityId}">
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
