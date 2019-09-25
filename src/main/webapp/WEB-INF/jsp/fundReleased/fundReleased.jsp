<%@include file="../taglib/taglib.jsp"%>
<script>
$(document).ready(function() {
	$('#finYearDropDownId').val('${FUND_RELEASED.finYearId}');
	$('#approvedStateId').val('${FUND_RELEASED.stateCode}');
	var releasePresent = '${RELEASE_PRESENT}';
	if(releasePresent == 'false'){
		alert('Fund is not sanctioned for this State.');
	}
	var stateCode=$('#approvedStateId').val();
	var finYear=$('#finYearDropDownId').val();
	(finYear > 0) ? $('#stateDropDownBlock').show() : $('#stateDropDownBlock').hide() ;
	(stateCode > 0) ? $('#tableBlock').show() : $('#tableBlock').hide() ;
	calTotalFund(0);
	calTotalFund(1);
	enableSecInstallment();
	
});

	function calTotalFund(index){
		$('#totalFund_'+index).val(+$('#unspent_'+index).val() + +$('#central_'+index).val());
	}
	
	function submitToPost(msg){
		if(msg=="freeze_0"){
			$('#isfreeze_0').val(true);
			$('#msgId').val("save");
		}else if(msg=="freeze_1"){
			$('#isfreeze_1').val(true);
			$('#msgId').val("save");
		}else if(msg=="unfreeze_0"){
			$('#isfreeze_0').val(false);
			$('#msgId').val("save");
		}else if(msg=="unfreeze_1"){
			$('#isfreeze_1').val(false);
			$('#msgId').val("save");
		}else{
			$('#msgId').val(msg);
		}
		document.fundReleased.method = "post";
		document.fundReleased.action = "fundReleased.html?<csrf:token uri='fundReleased.html'/>";
		document.fundReleased.submit();
	}
	
	function showStateDropDown() {
		$('#stateDropDownBlock').show();
	}
	
	function showTableContent(){
		$('#tableBlock').show();
	}
	
	function showImage(nodeId){
		document.fundReleased.method = "post";
		document.fundReleased.action = "getFundReleasedPdf.html?<csrf:token uri='getFundReleasedPdf.html'/>&nodeId="+nodeId;
		document.fundReleased.submit();
	}
	
	function enableSecInstallment(){
		if((+$('#unspent_0').val() + +$('#central_0').val()) > 0){
			$('.enable').attr("disabled", false);
		}else{
			$('.enable').attr("disabled", true);
		}
	}
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2> Fund Release </h2>
					</div>
					<form:form method="post" id="fundReleasedId"
						name="fundReleased" modelAttribute="FUND_RELEASED"
						action="fundReleased.html" enctype="multipart/form-data" onsubmit="disablingSave()">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="fundSanction.html"/>" />
						<div class="body">
							<div class="row clearfix">
							<div class="form-group">
								<div class="col-lg-4">
									&nbsp;&nbsp;<label for="FinYear"><strong>Financial Year :</strong></label>
								</div>
								<div align="center" class="col-lg-4">
									<form:select path="finYearId" class="form-control" id="finYearDropDownId" onchange="submitToPost('fetchStateList');showStateDropDown()">
										<form:option value="">Select Financial Year</form:option>
										<c:forEach items="${sessionScope['scopedTarget.userPreference'].finYearList}" var="finYearList">
											<form:option value="${finYearList.yearId}">${finYearList.finYear}</form:option>										
										</c:forEach>
									</form:select>
								</div>
							</div>
						</div>
						
						<div class="row clearfix" id="stateDropDownBlock" style="display: none;">
							<div class="form-group">
								<div class="col-lg-4">
									&nbsp;&nbsp;<label for="FinYear"><strong>Approved State :</strong></label>
								</div>
								<div align="center" class="col-lg-4">
									<form:select path="stateCode" class="form-control" id="approvedStateId" onchange="showTableContent();submitToPost('validateRelease')">
										<form:option value="">Select State</form:option>
										<c:forEach items="${STATE_LIST}" var="state">
										<form:option value="${state.stateCode}">
											${state.stateNameEnglish}</form:option>
									</c:forEach>
									</form:select>
								</div>
							</div>
						</div>
						
						<div class="table-responsive" id="tableBlock" style="display: none;">
							<table class="table table-hover">
								<thead>
									<tr>
										<th><div align="center"><strong>Installment</strong></div></th>
										<th><div align="center"><strong>Unspent Balance</strong></div></th>
										<th><div align="center"><strong>Central Share</strong></div></th>
										<th><div align="center"><strong>Total Fund</strong></div></th>
										<th><div align="center"><strong>File Upload</strong></div></th>
										<th><div align="center"><strong>Freeze Installment</strong></div></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><div align="center"><strong>Installment 1.</strong></div>
											<form:hidden path="fundReleasedDetails[0].installmentId" value="1"/>
											<form:hidden path="fundReleasedDetails[0].fundReleasedDetailsId" value="${FETCHED_DATA.fundReleasedDetails[0].fundReleasedDetailsId}"/>
											<form:hidden path="fundReleasedDetails[0].fileNode.fileNodeId" value="${FETCHED_DATA.fundReleasedDetails[0].fileNode.fileNodeId}"/>
											<form:hidden path="fundReleasedDetails[0].fileNode.fileName" value="${FETCHED_DATA.fundReleasedDetails[0].fileNode.fileName}"/>
											<form:hidden path="fundReleasedDetails[0].fileNode.filePath" value="${FETCHED_DATA.fundReleasedDetails[0].fileNode.filePath}"/>										
											<form:hidden path="fundReleasedDetails[0].fileNode.fileMime" value="${FETCHED_DATA.fundReleasedDetails[0].fileNode.fileMime}"/> 
											<form:hidden path="fundReleasedDetails[0].fileNode.fileSize" value="${FETCHED_DATA.fundReleasedDetails[0].fileNode.fileSize}"/>
											<form:hidden path="fundReleasedDetails[0].fileNode.status" value="${FETCHED_DATA.fundReleasedDetails[0].fileNode.status}"/>
											<form:hidden path="fundReleasedDetails[0].fileNode.uploadName" value="${FETCHED_DATA.fundReleasedDetails[0].fileNode.uploadName}"/>
										</td>
										<td><form:input path="fundReleasedDetails[0].unspentBalance" class="form-control Align-Right" id="unspent_0" onkeyup="calTotalFund('0');enableSecInstallment()" value="${FETCHED_DATA.fundReleasedDetails[0].unspentBalance }" readonly="${FETCHED_DATA.fundReleasedDetails[0].isFreeze}"/></td>
										<td><form:input path="fundReleasedDetails[0].centralShare" class="form-control Align-Right" id="central_0" onkeyup="calTotalFund('0');enableSecInstallment()" value="${FETCHED_DATA.fundReleasedDetails[0].centralShare}" readonly="${FETCHED_DATA.fundReleasedDetails[0].isFreeze}"/></td>
										<td><form:input path="" class="form-control Align-Right" id="totalFund_0" disabled="true" /></td>
										<td>
										<c:choose>
											<c:when test="${FETCHED_DATA.fundReleasedDetails[0].isFreeze}"><input name="fundReleasedDetails[0].file" type="file" class="form-control" disabled="disabled" /></c:when>
											<c:otherwise><input name="fundReleasedDetails[0].file" type="file" class="form-control" /></c:otherwise>
										</c:choose>
											
											<c:if test="${not empty FETCHED_DATA.fundReleasedDetails[0].fileNode.fileNodeId}">
																		<input type="button" value="Download File" class="btn bg-primary waves-effect" onclick='showImage(${FETCHED_DATA.fundReleasedDetails[0].fileNode.fileNodeId});' />
																	</c:if>
										</td>
										<td><div align="center">
											<c:choose>
												<c:when test="${FETCHED_DATA.fundReleasedDetails[0].isFreeze}"><i class="fa fa-lock fa-lg" aria-hidden="true" title="unfreeze the installment" onclick="submitToPost('unfreeze_0')" style="color: red;"></i></c:when>
												<c:otherwise><c:choose>
														<c:when test="${FETCHED_DATA.fundReleasedDetails[0].unspentBalance + FETCHED_DATA.fundReleasedDetails[0].centralShare ne 0}"><i class="fa fa-unlock fa-lg" aria-hidden="true" title="freeze the installment" onclick="submitToPost('freeze_0')" style="color: #34a734"></i></c:when>
														<c:otherwise><i class="fa fa-unlock fa-lg" aria-hidden="true" title="freeze the installment" onclick="alert('Save the information first.');" style="color: #34a734"></i></c:otherwise>
													</c:choose></c:otherwise>
											</c:choose>
											<form:hidden path="fundReleasedDetails[0].isFreeze" id="isfreeze_0"/>
										</div></td>
									</tr>
									<tr>
										<td><div align="center"><strong>Installment 2.</strong></div>
											<form:hidden path="fundReleasedDetails[1].installmentId" value="2"/>
											<form:hidden path="fundReleasedDetails[1].fundReleasedDetailsId" value="${FETCHED_DATA.fundReleasedDetails[1].fundReleasedDetailsId}"/>
											<form:hidden path="fundReleasedDetails[1].fileNode.fileNodeId" value="${FETCHED_DATA.fundReleasedDetails[1].fileNode.fileNodeId}"/>
											<form:hidden path="fundReleasedDetails[1].fileNode.fileName" value="${FETCHED_DATA.fundReleasedDetails[1].fileNode.fileName}"/>
											<form:hidden path="fundReleasedDetails[1].fileNode.filePath" value="${FETCHED_DATA.fundReleasedDetails[1].fileNode.filePath}"/>										
											<form:hidden path="fundReleasedDetails[1].fileNode.fileMime" value="${FETCHED_DATA.fundReleasedDetails[1].fileNode.fileMime}"/> 
											<form:hidden path="fundReleasedDetails[1].fileNode.fileSize" value="${FETCHED_DATA.fundReleasedDetails[1].fileNode.fileSize}"/>
											<form:hidden path="fundReleasedDetails[1].fileNode.status" value="${FETCHED_DATA.fundReleasedDetails[1].fileNode.status}"/>
											<form:hidden path="fundReleasedDetails[1].fileNode.uploadName" value="${FETCHED_DATA.fundReleasedDetails[1].fileNode.uploadName}"/>
										</td>
										<td><form:input path="fundReleasedDetails[1].unspentBalance" class="form-control Align-Right enable" id="unspent_1" onkeyup="calTotalFund('1')" value="${FETCHED_DATA.fundReleasedDetails[1].unspentBalance }" readonly="${FETCHED_DATA.fundReleasedDetails[1].isFreeze}"/></td>
										<td><form:input path="fundReleasedDetails[1].centralShare" class="form-control Align-Right enable" id="central_1" onkeyup="calTotalFund('1')" value="${FETCHED_DATA.fundReleasedDetails[1].centralShare}" readonly="${FETCHED_DATA.fundReleasedDetails[1].isFreeze}"/></td>
										<td><form:input path="" class="form-control Align-Right" id="totalFund_1" disabled="true" /></td>
										<td><c:choose>
											<c:when test="${FETCHED_DATA.fundReleasedDetails[1].isFreeze}"><input name="fundReleasedDetails[1].file" type="file" class="form-control" disabled="disabled" /></c:when>
											<c:otherwise><input name="fundReleasedDetails[1].file" type="file" class="form-control enable" /></c:otherwise>
										</c:choose>
											<c:if test="${not empty FETCHED_DATA.fundReleasedDetails[1].fileNode.fileNodeId}">
																		<input type="button" value="Download File" class="btn bg-primary waves-effect" onclick='showImage(${FETCHED_DATA.fundReleasedDetails[1].fileNode.fileNodeId});' />
																	</c:if>
										</td>
										
										<td><div align="center">
											<c:choose>
												<c:when test="${FETCHED_DATA.fundReleasedDetails[1].isFreeze}"><i class="fa fa-lock fa-lg" aria-hidden="true" title="unfreeze the installment" onclick="submitToPost('unfreeze_1')" style="color: red;"></i></c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${FETCHED_DATA.fundReleasedDetails[1].unspentBalance + FETCHED_DATA.fundReleasedDetails[1].centralShare ne 0}"><i class="fa fa-unlock fa-lg" aria-hidden="true" title="freeze the installment" onclick="submitToPost('freeze_1')" style="color: #34a734"></i></c:when>
														<c:otherwise><i class="fa fa-unlock fa-lg" aria-hidden="true" title="freeze the installment" onclick="alert('Save the information first.');" style="color: #34a734"></i></c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
											<form:hidden path="fundReleasedDetails[1].isFreeze" id="isfreeze_1"/>
										</div></td>
									</tr>
								</tbody>
							</table>
							
							<div class="text-right row clearfix" style="margin-right: 10px; margin-bottom:10px;">
							<c:choose>
								<c:when test="${FETCHED_DATA.fundReleasedDetails[1].isFreeze and FETCHED_DATA.fundReleasedDetails[0].isFreeze }">
									<button class="btn bg-green waves-effect" id="saveId" onclick="submitToPost('save')" disabled="disabled"><spring:message code="Label.SAVE" text="Save" htmlEscape="true" /></button>
									<button type="button" data-ng-click="onClear(this)" class="btn bg-light-blue waves-effect" disabled="disabled"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
								</c:when>
								<c:otherwise>
									<button class="btn bg-green waves-effect save-button" id="saveId" onclick="submitToPost('save')"><spring:message code="Label.SAVE" text="Save" htmlEscape="true" /></button>
									<button type="button" data-ng-click="onClear(this)" class="btn bg-light-blue waves-effect" ><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
								</c:otherwise>
							</c:choose>
								<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
							</div>
						</div>
						</div>
						<!-- hidden fields -->
						<input type="hidden" name="msg" id="msgId" value="" />
						<input type="hidden" name="planCode" id="planCodeId" value="${RELEASE_INSTALLMENT.planCode}" />
						<input type="hidden" name="fundReleasedId"  value="${FETCHED_DATA.fundReleasedId}" />
						<!--  -->
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
<style>
.Align-Right{
			text-align: right;
}</style>
							