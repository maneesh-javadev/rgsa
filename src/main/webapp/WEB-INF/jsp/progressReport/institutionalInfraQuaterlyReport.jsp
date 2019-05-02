
<head>	
	<%@include file="../taglib/taglib.jsp"%>
	<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
	<script src="http://angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet">
</head>
<script>
$(document).ready(function() {

	/* showHide(); */
/* alert(${QPRPANHCAYATBHAWANDETAILS[1].gpBhawanStatusId}) */



});
function getSelelctedQtrRprt()
{
	 var qtId = $('#qtrId').val();
	 var trainingInstituteTypeId = $('#institutionalInfraActivivtyId').val();
	
	  $('#quaterId').val(qtId); 
	  $('#trainingInstituteTypeId').val(trainingInstituteTypeId); 
	

	document.qprInstitutionalInfrastructure.method = "post";
	document.qprInstitutionalInfrastructure.action = "saveQprInstitutionalInfrastructureData.html?<csrf:token uri='saveQprInstitutionalInfrastructureData.html'/>";
	document.qprInstitutionalInfrastructure.submit();
}


function valdiate_fund(expenditureIncurred,totalFundApproved,fundsAllocated,index)
{
	var incurred=expenditureIncurred!=null?parseInt(expenditureIncurred):0;
	var ifundApproved=totalFundApproved!=null?parseInt(totalFundApproved):0;
	var ifundsAllocated=fundsAllocated!=null?parseInt(fundsAllocated):0;
	if(incurred>ifundApproved || expenditureIncurred>ifundsAllocated ){
		$("#incurredname_"+index).val("");
		$("#error_incurredname").text("expenditure Incurred must be less then fund approved by CEC and fund allocated of this subcomponent");
		$('#error_incurredname').addClass('errormessage show');
		
	}else
		{
		$("#error_incurredname").text("");
		$('#error_incurredname').addClass('errormessage hide');
		}
}


</script>


	<section class="content">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
						<h3><spring:message code="Label.InstitutionalInfrastructureQuaterlyReport" htmlEscape="true" /></h3>

						</div>
						<div class="body">
						<div class="card">
						<form:form method="POST" name="qprInstitutionalInfrastructure" action="saveQprInstitutionalInfrastructureData.html"
						modelAttribute="QPR_INSTITUTIONALINFRAQUATERLY" enctype="multipart/form-data" >
						<input type="hidden" name="<csrf:token-name/>"value="<csrf:token-value uri="saveQprInstitutionalInfrastructureData.html" />" />
					
							
								<!-- nav bar -->
							<div class="row" >
							<div class="form-group">
							<div class="col-lg-2"></div>
								<label for="QuaterDuration" class="col-sm-3"><spring:message code="Label.QuaterDuration" htmlEscape="true" /></label>
								<div class="col-lg-4">
									<select class="form-control" id="qtrId"  name="qtrId" >
										<option value="0">Select Quarter Duration</option>
										
										<c:forEach items="${quarterDuration}" var="duration">
										<c:choose>
										<c:when test="${duration.qtrId == SetQuaterId}">
										<option  value="${duration.qtrId}" selected="selected">${duration.qtrDuration}</option>
										</c:when>
										<c:otherwise>
										<option  value="${duration.qtrId}" >${duration.qtrDuration}</option>
										</c:otherwise></c:choose>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
							<div class="col-lg-2"></div>
								<label for="selectLevel" class="col-sm-3"><spring:message code="Label.SelectBuildingType" htmlEscape="true" /></label>
								<div class="col-lg-4">
									<select class="form-control" id="institutionalInfraActivivtyId"  name="trainingInstitueTypeId" onchange="getSelelctedQtrRprt();">
										<option value="0">Select Activity</option>
										
										
										<option  value="2,N">State Panchayat Resource Center(SPRC)</option>
										<option  value="4,N">District Panchayat Resource Center(DPRC)</option>
										<option  value="2,C">State Panchayat Resource Center(SPRC)(Carry Forward)</option>
										<option  value="4,C">District Panchayat Resource Center(DPRC)(Carry Forward)</option>
										
								
									</select>
								</div>
							</div>
						</div>
						
						<div class="body" id="body" >
						
							<div class="form-group">
								<div class="col-lg-12">
									<span class="errormessage" id="error_incurredname"></span><br/>
								</div>
							</div>
							<table class="table table-bordered table-striped table-hover" >
								<thead>
									<tr>
										<th>
											<div align="center">
												<strong><spring:message code="Label.SerialNumber" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.District" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.InstituteStatus" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ApprovedAmount" htmlEscape="true" /></strong>
											</div>
										</th>
										<%-- <th>
											<div align="center">
												<strong><spring:message code="Label.UploadFile" htmlEscape="true" /></strong>
											</div>
										</th> --%>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ExpenditureIncurred" htmlEscape="true" /></strong>
											</div>
										</th>
										 <th>
											<div align="center">
												<strong>file</strong>
											</div>
										</th> 
									</tr>
								</thead>
								<tbody>
								 <c:if test="${ not empty INSTITUTIONAL_INFRA_REPORT_DTO}">
								 <c:forEach items="${INSTITUTIONAL_INFRA_REPORT_DTO}" var="bhawanDto" varStatus="count">
								<tr>
								
<%-- 								<input type="hidden" name="qprInstitutionalInfraDetails[${count.index}].districtCode" value="${INSTITUTIONAL_INFRA_REPORT_DTO[count.index].districtCode}"/>
 --%> 				 <input type="hidden" name="institutionalInfraActivivtyId" value="${institutionalInfraActivivtyId}"/> 
 	                <input type="hidden" name="qprInstInfraId" value="${QPRPANCHAYATBHAWAN.qprInstInfraId}"/> 
 						<input type="hidden" name="qprInstitutionalInfraDetails[${count.index}].qprInstInfraDetailsId" value="${QPR_INSTITUTIONAL_INFRA_DETAILS[count.index].qprInstInfraDetailsId}" /> 
 							 <input type="hidden" name="qprInstitutionalInfraDetails[${count.index}].instituteInfrsaHrActivityDetailsId" value="${instituteInfrsaHrActivityDetailsId}" />
 								<input type="hidden" name="trainingTypeId" value="${SetActivityId}">
 								<td>${count.index+1}</td>
								<td>${bhawanDto.districtName}</td>
								
								<td><select class="form-control" name="qprInstitutionalInfraDetails[${count.index}].instInfraStatusId" >
								
				<option value="0">Please select gp status</option>
				<c:forEach items="${InstInfraStatus}" var="status" >
			<%-- 	<c:forEach items="${QPRPANHCAYATBHAWANDETAILS}" var="getStatus" > --%>
				<c:choose>
				<c:when test="${status.instInfraStatusId==QPR_INSTITUTIONAL_INFRA_DETAILS[count.index].instInfraStatusId}">
								<option value="${status.instInfraStatusId}" selected="selected">${status.instInfraStatusName}</option>				
				
				</c:when>
				<c:otherwise>
								<option value="${status.instInfraStatusId}">${status.instInfraStatusName}</option>				
				
				</c:otherwise>
				</c:choose>
							
							</c:forEach></select>
								
								
								</td>
								<td><strong>${bhawanDto.totalFundApproved}</strong></td>
								<td>
								<input type="text" class="form-control"  id="incurredname_${count.index}" name="qprInstitutionalInfraDetails[${count.index}].expenditureIncurred" 
								value="${QPR_INSTITUTIONAL_INFRA_DETAILS[count.index].expenditureIncurred} " onchange="valdiate_fund(this.value,'${bhawanDto.totalFundApproved}','${bhawanDto.fundsAllocated}','${count.index}')"/>
								
								</td>
								<td><input type="file" name="qprInstitutionalInfraDetails[${count.index}].file" class="form-control"/></td>
								</tr>
								</c:forEach>
								</c:if>
								<c:if test="${empty INSTITUTIONAL_INFRA_REPORT_DTO}">
								<div class="alert alert-danger">
	  								<strong>Danger!</strong> There is no GP  Available.
								</div>
							</c:if>
								
								</tbody>
							
							</table>
						
							
							<div class="form-group text-right">
										<button type="submit" class="btn bg-green waves-effect">
											Save
										</button>
										<button type="button" onclick="" class="btn bg-light-blue waves-effect reset">CLEAR${districtCode}</button>
										<button type="button"
											onclick=" onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">
											<spring:message code="Label.CLOSE" htmlEscape="true" />
										</button>
										</div>
										
										
									<input type="hidden" name="quaterId" id="quaterId">
									<input type="hidden" name="trainingInstituteTypeId" id="trainingInstituteTypeId"  value="${trainingInstituteTypeId}">
									
											<input type="hidden" name="path" id="path" > 
											<input type="hidden" name="dbFileName" id="dbFileName" >
											
									</div>
									
						</div>

									</form:form>
										
									</div>
									
								</div>
								
							</div>
						</div>
					</div>
				</div>
	</section>

