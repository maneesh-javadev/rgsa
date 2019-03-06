
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
	 var activityId = $('#activityId').val();
	 var districtId = $('#districtId').val();
	  $('#quaterId').val(qtId); 
	  $('#activityId1').val(activityId); 
	  $('#selectDistrictId').val(districtId); 

	document.qprPanchayatBhawan.method = "post";
	document.qprPanchayatBhawan.action = "panchayatBhawanQuaterlyReportOnQtr.html?<csrf:token uri='panchayatBhawanQuaterlyReportOnQtr.html'/>";
	document.qprPanchayatBhawan.submit();
	
	


}

</script>

<script type="text/javascript">
 function showHide()
{
	 
	 if(${QPRPANCHAYATBHAWAN} !=0 )
		{
		$('#activityId').show();
		$('#districtId').show();
		$('#body').show();
		return true;
		}
	
	var qtrId = $("#qtrId").val();
	var activityId = $("#activityId").val();
	var districtId = $("#districtId").val();
    
	
	if(qtrId ==0 )
		{
		$('#activityId').hide();
		$('#districtId').hide();
		$('#body').hide();
		return true;
		}
	if(qtrId =!0 && activityId==0 )
		{
		$('#activityId').show();
		$('#qtrId').show();
		
		$('#body').hide();
		return true;
		}

if(activityId =!0 && districtId == 0)
	{
	$('#qtrId').show();
	$('#activityId').show();
	$('#districtId').show();
	$('#body').hide();
	
	return true;
	}
	
if(districtId =!0)
{
$('#qtrId').show();
$('#activityId').show();
$('#districtId').show();
$('#body').show();

return true;
}
	

}


</script>
	<section class="content">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Panchayat Bhawan Quaterly Progress Report</h2>
						</div>
						<div class="body">
						<div class="card">
						<form:form method="POST" name="qprPanchayatBhawan" action="saveQprPanchayatBhawanData1.html"
						modelAttribute="QPR_PANCHAYAT_BHAWAN" enctype="multipart/form-data" >
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="saveQprPanchayatBhawanData1.html" />" />
					
							
								<!-- nav bar -->
							<div class="row" >
							<div class="form-group">
							<div class="col-lg-2"></div>
								<label for="QuaterDuration" class="col-sm-3"><spring:message code="Label.QuaterDuration" htmlEscape="true" /></label>
								<div class="col-lg-4">
									<select class="form-control" id="qtrId"  name="qtrId" onchange="getSelelctedQtrRprt();">
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
								<label for="selectLevel" class="col-sm-3"><spring:message code="Label.ActivityType" htmlEscape="true" /></label>
								<div class="col-lg-4">
									<select class="form-control" id="activityId"  name="activityId" onchange="getSelelctedQtrRprt();">
										<option value="0">Select Activity</option>
										<c:forEach items="${panchayatActivity}" var="activity">
											<c:choose>
										<c:when test="${activity.activityId == SetActivityId}">
									
										<option  value="${activity.activityId}" selected="selected">${activity.activityName}</option>
										</c:when>
										<c:otherwise>
										<option  value="${activity.activityId}">${activity.activityName}</option>
										
										</c:otherwise>
										</c:choose>
									</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="row" data-ng-show="qprPanchayatBhawan.activityId != 0">
							<div class="form-group">
							<div class="col-lg-2"></div>
								<label for="District" class="col-sm-3"><spring:message code="Label.District" htmlEscape="true" /></label>
								<div class="col-lg-4">
									<select class="form-control" id="districtId" name="districtCode" onchange="getSelelctedQtrRprt();" onclick="showHide()" >
										<option value="0">Select District</option>
									<c:forEach items="${districtList}" var="districtList">
												<c:choose>
										<c:when test="${districtList.districtCode == SetDistrict}">
										<option  value="${districtList.districtCode}" selected="selected">${districtList.districtNameEnglish}</option>
										</c:when><c:otherwise>
																				<option  value="${districtList.districtCode}">${districtList.districtNameEnglish}</option>
										
										</c:otherwise>
										</c:choose>
								</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="body" id="body" onclick="showHide()" >
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
												<strong><spring:message code="Label.G.P." htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.GPBhawanStatus" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ExpenditureIncurred" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.UploadFile" htmlEscape="true" /></strong>
											</div>
										</th> 
										
										<%-- <th>
											<div align="center">
												<strong><spring:message code="Label.Remarks" htmlEscape="true" /></strong>
											</div>
										</th> --%>
									</tr>
								</thead>
								<tbody>
								 <c:if test="${ not empty QprPanchayatBhawanDto}">
								 <c:forEach items="${QprPanchayatBhawanDto}" var="bhawanDto" varStatus="count">
								<tr>
								<input type="hidden" name="qprPanhcayatBhawanDetails[${count.index}].localBodyCode" value="${QprPanchayatBhawanDto[count.index].localBodyCode}"/>
 				<input type="hidden" name="panchayatBhawanActivityId" value="${QPRPANCHAYATBHAWAN[0].panchayatBhawanActivityId}"/>
			<input type="hidden" name="qprPanchayatBhawanId" value="${QPRPANCHAYATBHAWAN[0].qprPanchayatBhawanId}" />
 								<input type="hidden" name="qprPanhcayatBhawanDetails[${count.index}].qprPanhcayatBhawanDetailsId" value="${QPRPANHCAYATBHAWANDETAILS[count.index].qprPanhcayatBhawanDetailsId}" />
 							
 								
 								<td>${count.index+1}</td>
								<td>${bhawanDto.localBodyNameEnglish}</td>
								
								<td><select class="form-control" name="qprPanhcayatBhawanDetails[${count.index}].gpBhawanStatusId" >
								
				<option value="0">Please select gp status</option>
				<c:forEach items="${GPBhawanStatus}" var="status" >
			<%-- 	<c:forEach items="${QPRPANHCAYATBHAWANDETAILS}" var="getStatus" > --%>
				<c:choose>
				<c:when test="${status.gpBhawanStatusId==QPRPANHCAYATBHAWANDETAILS[count.index].gpBhawanStatusId}">
								<option value="${status.gpBhawanStatusId}" selected="selected">${status.gpBhawanStatusName}</option>				
				
				</c:when>
				<c:otherwise>
								<option value="${status.gpBhawanStatusId}">${status.gpBhawanStatusName}</option>				
				
				</c:otherwise>
				</c:choose>
							
							</c:forEach></select>
								
								
								</td>
								<td><input type="text" class="form-control" name="qprPanhcayatBhawanDetails[${count.index}].expenditureIncurred" value="${QPRPANHCAYATBHAWANDETAILS[count.index].expenditureIncurred} "/></td>
								<td><input type="file" name="qprPanhcayatBhawanDetails[${count.index}].file" class="form-control"/></td>
								</tr>
								</c:forEach>
								</c:if>
								<c:if test="${empty QprPanchayatBhawanDto}">
								<div class="alert alert-danger">
	  								<strong>Danger!</strong> There is no GP  Available.
								</div>
							</c:if>
								
								</tbody>
								<%-- <tbody>
								<c:set var="count" value="0" scope="page" />
									<tr data-ng-repeat="GPBhawaRincomnData in GPBhawanData">
										<td>{{$index + 1}}
										<input type="hidden" data-ng-model="GPBhawanData" value="{{GPBhawanData}}" /> 
										</td>
										<td><strong>{{GPBhawanData.localBodyNameEnglish}}</strong></td>
										<td>
											<select class="form-control" data-ng-init="qprPanchayatBhawan.qprPanhcayatBhawanDetails[$index].gpBhawanStatusId = '0'" convert-to-number data-ng-model="qprPanchayatBhawan.qprPanhcayatBhawanDetails[$index].gpBhawanStatusId" required="required">
												<option value="0">Select G.P Bhawan Status</option>
												<option data-ng-repeat="GPBhawanStatus in GPBhawanStatus" value="{{GPBhawanStatus.gpBhawanStatusId}}">{{GPBhawanStatus.gpBhawanStatusName}}</option>
											</select>
										</td>
										<!-- <td align="center"><input type="file" class="form-control" fileModel="qprPanchayatBhawan.qprPanhcayatBhawanDetails[$index].file" /></td> -->
										<td align="center"><input type="text" class="form-control"  restrict-input="{type: 'digitsOnly'}"  name="qprPanhcayatBhawanDetails[${count}].expenditureIncurred" required="required" style="text-align: right;">
										
										</td>
										<td><input type="file" name = "qprPanhcayatBhawanDetails[${count}].file"  required="required" id="file"><br/></td>

									</tr>
								</tbody> --%>
							</table>
							<%-- <div class="form-group text-right">
								<button data-ng-show="qprPanchayatBhawan.isFreeze" data-ng-click="saveQprPanchayatBhawanData()" type="button" class="btn bg-green waves-effect" disabled="disabled"><spring:message code="Label.SAVE" htmlEscape="true"/></button>
								<button data-ng-show="!qprPanchayatBhawan.isFreeze" data-ng-click="saveQprPanchayatBhawanData()" type="button" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
								<button type="button" data-ng-show="qprPanchayatBhawan.isFreeze"  class="btn bg-light-blue waves-effect" disabled="disabled"><spring:message code="Label.CLEAR" htmlEscape="true"/></button>
								<button type="button" data-ng-show="!qprPanchayatBhawan.isFreeze" class="btn bg-light-blue waves-effect"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
								<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-orange waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
							
							<div class="form-group text-right"></div> --%>
							
							
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
										
										<input type="hidden" name="qprPanchayatBhawan.qtrId"  value="${quatorId}"/>
										<input type="hidden" name="qprPanchayatBhawan.districtCode"  value="${districtCode}"/>
										<input type="hidden" name="qprPanchayatBhawan.panchayatBhawanActivityId"  value="${PanchayatBhawanActvityId}"/>
									<input type="hidden" name="quaterId" id="quaterId">
									<input type="hidden" name="activityId1" id="activityId1">
									<input type="hidden" name="selectDistrictId" id="selectDistrictId">
											<input type="hidden" name="path" id="path" > 
																			<input type="hidden" name="dbFileName" id="dbFileName" >
											
									</div>
									
						</div>
<%-- 
							<div class="table-responsive">
											<table id="table1id" class="table table-bordered">
												<thead>
													<tr>
														<th>
															<div align="center">
																<strong>Activities</strong>
															</div>
														</th>
														<th>
															<div align="center">
																<strong>No. of GPs</strong>
															</div>
														</th>
														<th>
															<div align="center">
																<strong>No. of Aspirational GPs selected</strong>
															</div>
														</th>
														
														<th>
															<div align="center">
																<strong>Unit Cost (in Rs) </strong>
															</div>
														</th>
														<th>
															<div align="center">
																<strong>Funds (in Rs) </strong>
															</div>
														</th>
														<th>
															<div align="center">
																<strong>Expenditure incurred </strong>
															</div>
														</th>
													</tr>
												</thead>
												<tbody>
												<c:forEach begin="0" end="2">
													<tr>
													<td><strong>Construction of new Panchayat Bhawan</strong> </td>
													<td>7886</td>
													<td>78</td>
													<td>150000</td>
													<td>7886 </td>
													<td>62188996</td>
													</tr>
													</c:forEach>
												</tbody>
											</table>
										</div> --%>
										</form:form>
										
									</div>
									
								</div>
								
							</div>
						</div>
					</div>
				</div>
	</section>

