<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript">
var quater_id = '${QTR_ID}';
var fund_allocated_by_state='${FUND_ALLOCATED_BY_STATE}';
var qtr_1_2_filled='${QTR_ONE_TWO_FILLED}';
var fund_used='${FUND_USED_IN_OTHER_QUATOR}';
if(quater_id > 2){
	var fund_allocated_in_pre_qtr = '${FUND_ALLOCATED_BY_STATE_PREVIOUS}';
	var fund_used_in_qtr_1_and_2 = '${TOTAL_FUND_USED_IN_QTR_1_AND_2}';
}
let domain_list = '${LIST_OF_PMU_DOMAINS}';

$('document').ready(function(){
	
	
	 $('#noOfUnitCompleted_2').prop("disabled", true);

	if(qtr_1_2_filled == "false"){
		alert('Please fill the quater 1 and 2 progress report first.');
	}
	$('#quaterDropDownId').val(quater_id);
	showTablediv();
	calTotalExpenditure();
	
	$(".validate").keypress(function (e) {
	    //if the letter is not digit then display error and don't type anything
	    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	       //display error message
	       $("#errmsg").html("Digits Only").show().fadeOut("slow");
	              return false;
	   }
	  });
});

function saveAndGetDataQtrRprt(msg){
	 $('#quaterTransient').val($('#quaterDropDownId').val());
	 $('#origin').val(msg);
	 	document.pmuProgress.method = "post";
		document.pmuProgress.action = "pmuProgresReport.html?<csrf:token uri='pmuProgresReport.html'/>";
		document.pmuProgress.submit();
}

function showTablediv(){
	if($('#quaterDropDownId').val() > 0){
		$('#mainDivId').show();
	}else{
		$('#mainDivId').hide();
	}
}

function validateNoOfUnits(index){
	var no_of_unit_cec= +$('#noOfUnitCecId_'+index).text();	
	/* var total_no_of_unit_remaining = no_of_unit_cec - $('#totalNoOfUnit_'+index).val(); */
	if($('#noOfUnitCompleted_'+index).val() > no_of_unit_cec){
		alert('total number of units should not exceed '+no_of_unit_cec);
		$('#noOfUnitCompleted_'+index).val('');
		$('#noOfUnitCompleted_'+index).focus();
	}
}

function validateFundByAllocatedFund(obj){
	var noOfRows=$("#tbodyId tr").length;
	var fund_allocated_by_state_local = +fund_allocated_by_state;
	var fund_used_local= +fund_used;
	var total=0;
	
	if(quater_id > 2){
		fund_allocated_by_state_local += +(fund_allocated_in_pre_qtr - fund_used_in_qtr_1_and_2);
	}
	if(fund_used !=0){
		fund_allocated_by_state_local -=  +fund_used_local;
	}
	for (var index = 0; index < noOfRows; index++) {
		total +=  +$('#expenditureIncurred_'+index).val();
	}
	if(total > fund_allocated_by_state_local){
		if(fund_used != 0){
			alert('Total expenditure should not exceed total remaining for this component which is Rs. '+ (fund_allocated_by_state_local - (total - $('#expenditureIncurred_'+obj).val())));
		}else{
			alert('Total expenditure should not exceed total fund allocted by state for this component which is Rs. '+ (fund_allocated_by_state_local - (total - $('#expenditureIncurred_'+obj).val())));
		}
		$('#expenditureIncurred_'+obj).val('');
	}
}

function validateWithCorrespondingFund(index){
	var tota_fund_cec= +$('#fundCecId_'+index).text();	
	var total_corresponding_fund_remaining = tota_fund_cec - $('#totalExpenditureIncurred_'+index).val();
	if($('#expenditureIncurred_'+index).val() > total_corresponding_fund_remaining){
		alert('total expenditure should not exceed '+ total_corresponding_fund_remaining);
		$('#expenditureIncurred_'+index).val('');
		$('#expenditureIncurred_'+index).focus();
	}
}

function isNoOfUnitAndExpInurredFilled(index){
	if(index <2){
	if($('#noOfUnitCompleted_'+index).val() == null || $('#noOfUnitCompleted_'+index).val() ==''){
		alert('Expenditure incurred cannot be filled if number of unit filled is zero or blank.');
		$('#expenditureIncurred_'+index).val('');
		$('#noOfUnitCompleted_'+index).focus();
	}
}}

function calTotalExpenditure(){
	var rowCount=$('#tbodyId tr').length -1;
	var total_expenditure=0;
	for( var i=0;i < rowCount; i++){
		if($('#expenditureIncurred_'+i).val() != null && $('#expenditureIncurred_'+i).val() != undefined){
			total_expenditure += +$('#expenditureIncurred_'+i).val();
		}
	}
	$('#totalExpenditureId').val(total_expenditure);
}

function calculateValueAcDomain(index){
	var rowCountSprc=$('#tbodySprcId tr').length;
	var rowCountDprc=$('#tbodyDprcId tr').length * domain_list.split(',').length / 2;
	var noOfDomainSprc=0;
	var noOfDomainDprc=0;
	for(var i=0;i<rowCountSprc;i++){
		noOfDomainSprc += Number($('#noOfExpertsSprc_'+i).val()) ;
	}
	for(var i=0;i<rowCountDprc;i++){
		noOfDomainDprc += Number($('#noOfExpertsDprc_'+(i)).val());
	}
	
	/* if($('#noOfUnitCompleted_0').val() < noOfDomainSprc){
		alert('Total domains experts should be equal to or less than '+ $('#noOfUnitCompleted_0').val());
		$('#noOfExpertsSprc_'+obj).val('');
		
	}
	 if($('#noOfUnitCompleted_3').val() < noOfDomainDprc){
		alert('Total domains experts should be equal to or less than '+ $('#noOfUnitCompleted_3').val());
		$('#noOfExpertsDprc_'+obj).val('');
		
	} */
	 
	 if(!isNaN(index)){
			if($('#noOfUnitCompleted_0').val() < noOfDomainSprc){
				alert('Total domains experts should be equal to or less than '+ $('#noOfUnitCompleted_0').val());
				$('#noOfExpertsSprc_'+index).val('');
			}else if($('#noOfUnitCompleted_3').val() < noOfDomainDprc){
				alert('Total domains experts should be equal to or less than '+ $('#noOfUnitCompleted_3').val());
				$('#noOfExpertsDprc_'+index).val('');
			}
			}else{ if(index == 'noOfUnitCompleted_0' && noOfDomainSprc != 0){
					var result= confirm("If you change Number of units you have to fill domain details.");
					if(result){
					if($('#noOfUnitCompleted_0').val() < noOfDomainSprc){
						alert('No of units in SPRC should not exceed the sum of domain detail :'+ noOfDomainSprc + ' please fill the domain details again.');
						emptyDomainDetails('spmu',rowCountSprc);
					}
					}else{
						if($('#noOfUnitCompleted_0').val() < noOfDomainSprc){
							alert('No of units in SPRC should not exceed the sum of domain detail '+ noOfDomainSprc );
							$('#noOfUnitCompleted_0').val('');
						}
					}
			}else if(index == 'noOfUnitCompleted_3' && noOfDomainDprc != 0){
				var result= confirm("If you change Number of units you have to fill domain details.");
				if(result){
				if($('#noOfUnitCompleted_3').val() < noOfDomainDprc){
					alert('No of units in DPRC should not exceed the sum of domain detail :'+ noOfDomainDprc + ' please fill the domain details again.');
					emptyDomainDetails('dpmu',rowCountDprc);
				}
				}else{
					if($('#noOfUnitCompleted_3').val() < noOfDomainSprc){
						alert('No of units in DPRC should not exceed the sum of domain detail '+ noOfDomainDprc );
						$('#noOfUnitCompleted_3').val('');
					}
				}
			  }
			} 
	
}

/* this function used in domainValidation function */
function emptyDomainDetails(level,count){
	if(level == 'spmu'){
		for(var i=0;i<count;i++){
			$('#noOfExpertsSprc_'+i).val('');
		}
	}else{
		for(var i=0;i<count;i++){
			$('#noOfExpertsDprc_'+i).val('');
		}
	}
}

function FreezeAndUnfreeze(msg){
	var componentId=12;
	var qprActivityId=$('#qprActivityId').val();
	var quaterId = $('#quaterDropDownId').val();
	document.pmuProgress.method = "post";
	document.pmuProgress.action = "freezeAndUnfreezeReport.html?<csrf:token uri='freezeAndUnfreezeReport.html'/>&componentId="+componentId+"&qprActivityId="+qprActivityId+"&quaterId="+quaterId+"&msg="+msg;
	document.pmuProgress.submit();
}
</script>
<style>
.align-right{
		text-align: right;
		}
</style>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>PMU Progress Report</h2>
					</div>
					<div class="body">
						<form:form method="post" name="pmuProgress"
							action="pmuProgresReport.html"
							modelAttribute="PMU_ACTIVITY_QUATERLY">
							<input type="hidden" name="<csrf:token-name/>"
								value="<csrf:token-value uri="pmuProgresReport.html" />" />
									<div class="row clearfix">
										<div class="form-group">
											<div class="col-lg-2">
												<label for="QuaterId1"><strong>Quarter
														Duration :</strong></label>
											</div>
											<div align="center" class="col-lg-4">
												<select id="quaterDropDownId" name="quarterDuration.qtrId"
													class="form-control" onchange="saveAndGetDataQtrRprt('qtrChange');showTablediv()">
													<option value="0">Select quarter</option>
													<c:forEach items="${QUATER_DETAILS}" var="qtr">
														<option value="${qtr.qtrId}">${qtr.qtrDuration}</option>
													</c:forEach>
												</select>
											</div>
										</div>
									</div>
									<br>
									<div id="mainDivId">
									<table class="table table-bordered">
										<thead>
											<tr>
												<th><div align="center">Type of Center</div></th>
												<th><div align="center">Faculty and Staff</div></th>
												<th><div align="center">No. of Units Approved</div></th>
												<!-- <th><div align="center">Unit Cost Approved</div></th> -->
												<th><div align="center">Fund Sanctioned</div></th>
												<th><div align="center">No. of units
														completed/Persons involved</div></th>
												<th><div align="center">Expenditure incurred</div></th>
											</tr>
										</thead>
										<tbody id="tbodyId">
											<c:forEach
												items="${CEC_APPROVED_ACTIVITY.pmuActivityDetails}"
												var="obj" varStatus="count">
											<!-- total number of units filled in rest quaters -->
											<c:choose>
												<c:when test="${not empty DEATIL_FOR_TOTAL_NO_OF_UNIT}">
												<input type="hidden" id="totalExpenditureIncurred_${count.index}"
														value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[count.index].expenditureIncurred}" />
												
													<input type="hidden" id="totalNoOfUnit_${count.index}"
														value="${DEATIL_FOR_TOTAL_NO_OF_UNIT[count.index].noOfUnitsFilled}" />
												</c:when>
												<c:otherwise>
													<input type="hidden" id="totalNoOfUnit_${count.index}"
														value="0" />
													<input type="hidden" id="totalExpenditureIncurred_${count.index}"
														value="0" />	
												</c:otherwise>
											</c:choose>
											<!-- ends here -->
											<tr>
													<td align="center"><strong>${obj.pmuActivityType.pmuType.pmuTypeName}</strong></td>
													<td align="center"><strong>${obj.pmuActivityType.pmuActivityName}</strong></td>
													<td><div id="noOfUnitCecId_${count.index}" align="center"><strong>${obj.noOfUnits}</strong></div></td>
													
													<td><div id="fundCecId_${count.index}" align="center"><strong>${obj.fund}</strong></div></td>
													<c:choose>
														<c:when test="${not empty PMU_PROGRESS}">
															<td><form:input
																path="pmuProgressDetails[${count.index}].noOfUnitsFilled" style="text-align: right;"
																class="form-control validate" id="noOfUnitCompleted_${count.index}"
																onkeyup="validateNoOfUnits(${count.index});" readonly="${PMU_PROGRESS.isFreeze}"
																value="${PMU_PROGRESS.pmuProgressDetails[count.index].noOfUnitsFilled}" required="required" onchange="calculateValueAcDomain('noOfUnitCompleted_${count.index}')"/>
															<c:if test="${count.index eq 0}">
																<div align="right" style="margin-top: 5px"><button type="button"
																	 class="btn btn-primary btn-lg" data-toggle="modal"
																	 data-target="#myModal">Fill Domain Details</button></div>
															</c:if>
															<c:if test="${count.index eq 3}">
																<div align="right" style="margin-top: 5px"><button type="button"
																	 class="btn btn-primary btn-lg" data-toggle="modal"
																	 data-target="#myModal2">Fill Domain Details</button></div>
															</c:if>
															</td>
															<td><form:input
																path="pmuProgressDetails[${count.index}].expenditureIncurred"
																style="text-align: right;"
																class="form-control validate" id="expenditureIncurred_${count.index}"
																onkeyup="validateFundByAllocatedFund(${count.index});validateWithCorrespondingFund(${count.index});isNoOfUnitAndExpInurredFilled(${count.index});calTotalExpenditure()"
																value="${PMU_PROGRESS.pmuProgressDetails[count.index].expenditureIncurred}" required="required" readonly="${PMU_PROGRESS.isFreeze}" /></td>

															<input type="hidden"
																name="pmuProgressDetails[${count.index}].qprPmuDetailsId"
																value="${PMU_PROGRESS.pmuProgressDetails[count.index].qprPmuDetailsId}">
														</c:when>
														<c:otherwise>
															<td><input
																name="pmuProgressDetails[${count.index}].noOfUnitsFilled"
																type="text" style="text-align: right;"
																id="noOfUnitCompleted_${count.index}"
																onkeyup="validateNoOfUnits(${count.index});"
																class="form-control validate" required="required" onchange="calculateValueAcDomain('noOfUnitCompleted_${count.index}')" />
																
															<c:if test="${count.index eq 0}">
																<div align="right" style="margin-top: 5px">
																	<button type="button" class="btn btn-primary btn-lg"
																		data-toggle="modal" data-target="#myModal">Fill
																		Domain Details</button>
																</div>
															</c:if> <c:if test="${count.index eq 3}">
																<div align="right" style="margin-top: 5px">
																	<button type="button" class="btn btn-primary btn-lg"
																		data-toggle="modal" data-target="#myModal2">Fill
																		Domain Details</button>
																</div>
															</c:if></td>
															<td><input
																name="pmuProgressDetails[${count.index}].expenditureIncurred"
																type="text" style="text-align: right;"
																id="expenditureIncurred_${count.index}"
																onkeyup="validateFundByAllocatedFund(${count.index});validateWithCorrespondingFund(${count.index});isNoOfUnitAndExpInurredFilled(${count.index});calTotalExpenditure()"
																class="form-control validate" required="required" /></td>
														</c:otherwise>
													</c:choose>


												</tr>
											</c:forEach>
												<tr>
											<th colspan="2"><div align="center">Total Expenditure Incurred</div></th>
											<td colspan="2"></td>
											<td><input type="text" id="totalExpenditureId"  class="form-control validate Align-Right" disabled="disabled" style="text-align: right"/></td>
										</tr>
										</tbody>
									</table>
									
									<!-- SPMU MODAL-->
											<div id="myModal" class="modal fade" role="dialog">
											<div class="modal-dialog">
												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">&times;</button>
													</div>
													<div class="modal-body">
														<div class="row">
															<div class="form-group">
																<label for="spmu" class="col-sm-3"><spring:message code="Label.InstituteType" htmlEscape="true" /></label>
																<div class="col-sm-5">
																	<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS" begin="1" end="1">
																		<c:if	test="${DOMAINS.pmuType.pmuTypeId eq 1}">
																			<p class="text-justify"><strong>${DOMAINS.pmuType.pmuTypeName}</strong></p>
																		</c:if>
																	</c:forEach>
																</div>
															</div>
														</div>
														<div class="row clearfix">
		
															<div class="body">
																<div class="table-responsive">
																	<table class="table table-bordered">
																		<thead style="background-color: #b39ad8;color: #2f2b2bf2;">
																			<tr>
																				<th><div align="center"><spring:message code="Label.Domain" htmlEscape="true" /></div></th>
																				<th><div align="center"><spring:message code="Label.NoOfExperts" htmlEscape="true" /></div></th>
																			</tr>
																		</thead>
																		<tbody id="tbodySprcId">
																		<c:set var="temp" value="0" scope="page" />
																			<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS">
																				<c:if	test="${DOMAINS.pmuType.pmuTypeId eq 1 }">
																					<tr>
																						<th><div align="center">${DOMAINS.pmuDomainName}</div>
																						<td><form:input path="qprPmuWiseProposedDomainExperts[${temp}].noOfExperts" class="align-right validate form-control" id="noOfExpertsSprc_${temp}" onkeyup="calculateValueAcDomain(${temp})" readonly="${PMU_PROGRESS.isFreeze}"/></td>
																					</tr>
																					<!-- Hidden fields -->
																						<form:hidden path="qprPmuWiseProposedDomainExperts[${temp}].qprPmuWiseProposedDomainExpertsId" />
																						<input type="hidden" name="qprPmuWiseProposedDomainExperts[${temp}].domainId" value="${DOMAINS.pmuDomainId}">
																					<!-- Hidden Fields Ends Here -->
																				</c:if>
																				<c:set var="temp" value="${temp+1}" scope="page" />
																			</c:forEach>
																		</tbody>
																	</table>
																</div>
															</div>
														</div>
													</div>
													<div class="modal-footer">
														<!-- <button type="button" class="btn btn-success">Save</button> -->
														<button type="button" class="btn btn-danger"
															data-dismiss="modal"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
													</div>
												</div>
		
											</div>
										</div>									
									<!-- SPMU MODAL ENDS HERE -->
									
									<!-- DPMU MODAL -->
										<div id="myModal2" class="modal fade" role="dialog">
											<div class="modal-dialog modal-lg">
												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">&times;</button>
													</div>
													<div class="modal-body">
														<div class="row">
															<div class="form-group">
																<label for="dprc" class="col-sm-3"><spring:message code="Label.InstituteType" htmlEscape="true" /></label>
																<div class="col-sm-5">
																	<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS"	begin="1" end="3">
																		<c:if test="${DOMAINS.pmuType.pmuTypeId eq 2}">
																			<p class="text-justify"><strong>${DOMAINS.pmuType.pmuTypeName}</strong></p>
																		</c:if>
																	</c:forEach>
																</div>
															</div>
														</div>
														<div class="row clearfix">
															<div class="body">
																<div class="table-responsive">
																	<table class="table table-hover">
																		<thead style="background-color: #b39ad8;color: #2f2b2bf2;display: table;width: 100%;">
																			<tr>
																				<th><div align="center">District Name</div></th>
																				<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS">
																					<c:if test="${DOMAINS.pmuType.pmuTypeId eq 2}">
																						<th><div align="center">${DOMAINS.pmuDomainName}</div></th>
																					</c:if>
																				</c:forEach>
																			</tr>
																		</thead>
																		<tbody style="display: block;overflow-x: auto;height: 500px;" id="tbodyDprcId">
																			<c:set var="dprcIndex" value="0" scope="page" />	
																			<c:forEach items="${LIST_OF_DISTRICT}" var="DISTRICT" varStatus="index">
																			<tr>
																				<td style="width: 234px;"><div align="center"><strong>${DISTRICT[1]}</strong></div></td>
																				<c:forEach items="${LIST_OF_PMU_DOMAINS}" var="DOMAINS">
																					<c:if test="${DOMAINS.pmuType.pmuTypeId eq 2}">
																						<td><form:input path="qprPmuWiseProposedDomainExperts[${dprcIndex + LIST_OF_PMU_DOMAINS_LIST}].noOfExperts" class="align-right validate form-control" id="noOfExpertsDprc_${dprcIndex}" onkeyup="calculateValueAcDomain(${dprcIndex})" readonly="${PMU_PROGRESS.isFreeze}"/></td>
																						<!-- Hidden Fields -->
																							<input type="hidden" name="qprPmuWiseProposedDomainExperts[${dprcIndex + LIST_OF_PMU_DOMAINS_LIST}].domainId" value="${DOMAINS.pmuDomainId}">
																							<input type="hidden" name="qprPmuWiseProposedDomainExperts[${dprcIndex + LIST_OF_PMU_DOMAINS_LIST}].districtId" value="${DISTRICT[0]}">
																							<form:hidden path="qprPmuWiseProposedDomainExperts[${dprcIndex + LIST_OF_PMU_DOMAINS_LIST}].qprPmuWiseProposedDomainExpertsId" />
																						<!-- Hidden Fields Ends Here -->	
																						<c:set var="dprcIndex" value="${dprcIndex + 1}" scope="page"></c:set>			
																					</c:if>
																				</c:forEach>
																			</tr>
																		</c:forEach>
																		</tbody>
																	</table>
																</div>
															</div>
														</div>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-danger" data-dismiss="modal"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
													</div>
												</div>
											</div>
										</div>
									<!-- DPMU MODAL ENDS HERE -->
									<div class="text-right">
										<form:button onclick="saveAndGetDataQtrRprt('save')" id="saveButtn"
													class="btn bg-green waves-effect" disabled="${PMU_PROGRESS.isFreeze}">SAVE</form:button>
										<c:choose>
											<c:when test="${PMU_PROGRESS.isFreeze}">
												<form:button class="btn bg-orange waves-effect"
													onclick="FreezeAndUnfreeze('unfreeze')">UNFREEZE</form:button>
											</c:when>
											<c:otherwise>
												<form:button class="btn bg-orange waves-effect"
													disabled="${DISABLE_FREEZE}"
													onclick="FreezeAndUnfreeze('freeze')">FREEZE</form:button>
											</c:otherwise>
										</c:choose>
										<form:button onclick="onClear(this)"
												class="btn bg-light-blue waves-effect" disabled="${PMU_PROGRESS.isFreeze}">CLEAR</form:button>
											<form:button
												onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
												class="btn bg-red waves-effect">CLOSE</form:button>
										</div>
									</div>
							<!-- hidden field -->
							<input type="hidden" name="pmuActivity.pmuActivityId" value="${CEC_APPROVED_ACTIVITY.pmuActivityId}" />
							<input type="hidden" name="qprPmuId" value="${PMU_PROGRESS.qprPmuId}" id="qprActivityId"/>
							<input type="hidden" id="origin" name="origin" />
							<input type="hidden" id="quaterTransient" name="qtrIdJsp6" value='${qtrIdJsp6}' />
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>