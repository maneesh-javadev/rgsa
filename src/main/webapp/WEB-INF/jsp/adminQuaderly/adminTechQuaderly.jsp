<%@include file="../taglib/taglib.jsp"%>
<%@include file="adminTechQuaderlyJs.jsp"%>
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
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Administrative And Technical Support to Gram Panchayat</h2>
					</div>
					<form:form method="post" name="administrativeTechnicalProgress"
						action="adminTechQuaderly.html" modelAttribute="ADMIN_QUATER">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="adminTechQuaderly.html" />" />

						<div class="body">
							<div class="row clearfix">
								<div class="form-group">
									<div class="col-lg-2">
										<label for="QuaterId1"><strong>Quarter
												Duration :</strong></label>
									</div>
									<div align="center" class="col-lg-4">
										<select id="quaterDropDownId" name="quarterDuration.qtrId"
											class="form-control" onchange="saveAndGetDataQtrRprt('qtrChange');">
											<option value="0">Select quarter</option>
											<c:forEach items="${QUATER_DETAILS}" var="qtr">
												<option value="${qtr.qtrId}">${qtr.qtrDuration}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
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
											<th>S.No.</th>
											<th>Post Type</th>
											<th>Post Name</th>
											<th>No. Of Unit Approved</th>
											<th>Unit Cost Approved</th>
											<th>Approved Amount</th>
											<th>No. of Unit Filled</th>
											<th>Expenditure Incurred</th>
										</tr>

									</thead>
									<tbody id="tbodyId">
										<c:forEach
											items="${APPROVED_ADMIN_TECH_ACT.supportDetails}"
											var="obj" varStatus="count">
											
											<!-- total number of units filled in rest quaters -->
											<c:choose>
												<c:when test="${not empty DEATIL_FOR_TOTAL_NO_OF_UNIT}">
												<input type="hidden" id="totalExpenditureIncurred_${count.index}"
														value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[count.index].expenditureIncurred}" />
												
													<input type="hidden" id="totalNoOfUnit_${count.index}"
														value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[count.index].noOfUnitCompleted}" />
												</c:when>
												<c:otherwise>
													<input type="hidden" id="totalNoOfUnit_${count.index}"
														value="0" />
													<input type="hidden" id="totalExpenditureIncurred_${count.index}"
														value="0" />	
												</c:otherwise>
											</c:choose>
											<!-- ends here -->

											<input type="hidden" name="atsId" id="qprActivityId" value="${ADMINISTRATIVE_TECHNICAL_PROGRESS.atsId}"><!-- progress report main table id -->
											<input type="hidden" name="administrativeTechnicalDetailProgress[${count.index}].atsDetailsProgressId"
												value="${ADMINISTRATIVE_TECHNICAL_PROGRESS.administrativeTechnicalDetailProgress[count.index].atsDetailsProgressId}">
											<input type="hidden" name="administrativeTechnicalDetailProgress[${count.index}].postType.postId"
												value="${obj.postType.postId}">
												<input type="hidden" id ="getExpDetail"
												value="${GET_EXPENDITURE_DETAILS_OF_QPR}">
											<tr>
												<td><strong>${count.index+1}.</strong></td>
												<td><strong>${obj.postType.master.postTypeName}</strong></td>
												<td><strong>${obj.postType.postName}</strong></td>
												<td id="noOfUnitCecId_${count.index}"><strong>${obj.noOfUnits}</strong></td>
												<td><strong>${obj.unitCost}</strong></td>
												<td id="fundCecId_${count.index}"><strong>${obj.funds}</strong></td>
												<td><form:input
													path="administrativeTechnicalDetailProgress[${count.index}].noOfUnitCompleted" id="noOfUnitCompleted_${count.index}"
													value="${ADMINISTRATIVE_TECHNICAL_PROGRESS.administrativeTechnicalDetailProgress[count.index].noOfUnitCompleted}"
													class="form-control validate" onkeyup="validateNoOfUnits(${count.index});" readonly="${ADMINISTRATIVE_TECHNICAL_PROGRESS.isFreeze}"/></td>
												<td><form:input 
													path="administrativeTechnicalDetailProgress[${count.index}].expenditureIncurred" id="expenditureIncurred_${count.index}"
													value="${ADMINISTRATIVE_TECHNICAL_PROGRESS.administrativeTechnicalDetailProgress[count.index].expenditureIncurred}"
													class="form-control validate" onkeyup="validateFundByAllocatedFund(${count.index});validateWithCorrespondingFund(${count.index});isNoOfUnitAndExpInurredFilled(${count.index});calTotalExpenditure()" 
													readonly="${ADMINISTRATIVE_TECHNICAL_PROGRESS.isFreeze}"
													onblur="validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[0].balanceAmount}',this)"/>
													<span class="errormsg" id="error_expenditureIncurred_${count.index}"></span>
													</td>
											</tr>
										</c:forEach>
										<tr>
											<th colspan="2"><div align="center">Additional Requirement</div></th>
											<th colspan="3"><div align="center" id="additionalReqStateId">${APPROVED_ADMIN_TECH_ACT.additionalRequirement }</div></th>
											<td colspan="2"></td>
											<td><form:input path="additionalRequirement" id="additionalReqId" value="${ADMINISTRATIVE_TECHNICAL_PROGRESS.additionalRequirement}" class="form-control validate Align-Right" onkeyup="validateAddReq();calTotalExpenditure()" readonly="${ADMINISTRATIVE_TECHNICAL_PROGRESS.isFreeze}" /></td>
										</tr>
										
										<tr>
											<th colspan="2"><div align="center">Total Expenditure Incurred</div></th>
											<td colspan="5"></td>
											<td><input type="text" id="totalExpenditureId"  class="form-control validate Align-Right" disabled="disabled" /></td>
										</tr>
									</tbody>
								</table>
								<div class="text-right">
									<form:button onclick="saveAndGetDataQtrRprt('save')" class="btn bg-green waves-effect" disabled="${ADMINISTRATIVE_TECHNICAL_PROGRESS.isFreeze}" id="savebtn">SAVE</form:button>
									<c:choose>
										<c:when test="${ADMINISTRATIVE_TECHNICAL_PROGRESS.isFreeze}"><form:button class="btn bg-orange waves-effect" onclick="FreezeAndUnfreeze('unfreeze')" id="unfreezebtn">UNFREEZE</form:button></c:when>
										<c:otherwise><form:button class="btn bg-orange waves-effect" disabled="${DISABLE_FREEZE}" onclick="FreezeAndUnfreeze('freeze')" id="freezebtn">FREEZE</form:button></c:otherwise>
									</c:choose>
									
								 
									<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-red waves-effect">CLOSE</button>
								</div>
								</div>
							</div>
							</div>
							</div>
						</div>
						<!-- hidden fields -->
						<input type="hidden" id="quaterTransient" name="qtrIdJsp2" value='${QTR_ID}' />
						<input type="hidden" id="origin" name="origin" />
						<input type="hidden" name="administrativeTechnicalSupport.administrativeTechnicalSupportId" value="${APPROVED_ADMIN_TECH_ACT.administrativeTechnicalSupportId}">
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
