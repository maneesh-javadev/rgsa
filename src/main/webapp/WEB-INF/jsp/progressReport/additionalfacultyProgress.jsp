<%@include file="../taglib/taglib.jsp"%>
<script>

function getSelelctedQtrRprt(){
	 var qtId = $('#quaterId').val();
	 $('#qtrIdJsp3').val(qtId);
	 	document.additionalFacultyProgress.method = "get";
		document.additionalFacultyProgress.action = "additionalfacultyProgress.html?<csrf:token uri='additionalfacultyProgress.html'/>";
		document.additionalFacultyProgress.submit();
}


$( document ).ready(function() {
	$(".validate").keypress(function (e) {
	    //if the letter is not digit then display error and don't type anything
	    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	       //display error message
	       $("#errmsg").html("Digits Only").show().fadeOut("slow");
	              return false;
	   }
	  });
});

</script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>

<section class="content" > 
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Additional Faculty and Maintenance at SPRC and DPRC</h2>
					</div>
					<form:form method="post" name="additionalFacultyProgress" action="additionalfacultyProgress.html"
						modelAttribute="ADD_QUATER">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="additionalfacultyProgress.html" />" />
					<div class="body">
					<c:set var="count" value="0" scope="page" />
					<div class="row clearfix">
					 <div class="form-group">
						<div class="col-lg-2">
						  	<label for="QuaterId1"><strong>Quarter Duration :</strong></label>
					    </div>
							<div align="center" class="col-lg-4">
					<select id="quaterId"  name="quarterDuration.qtrId" class="form-control" onchange="getSelelctedQtrRprt();">
								<option value="">Select</option>
							<c:choose>
			            		<c:when test="${not empty Additional_Faculty_PROGRESS}">
				            				<c:forEach items="${QUATER_DETAILS}" var="duration">
					            				<c:choose>
						            				<c:when test="${duration.qtrId == Additional_Faculty_PROGRESS.quarterDuration.qtrId}">
					                   					<option value="${duration.qtrId}" selected="selected">${duration.qtrDuration} </option>
					                   				</c:when>
					                   				<c:otherwise>
					                   					<option value="${duration.qtrId}">${duration.qtrDuration}</option>
					                   				</c:otherwise>
				                   				</c:choose>
				                       		</c:forEach>
			            			</c:when> 
			            			<c:when test="${not empty SetNewQtrId1}">
			            			<c:forEach items="${QUATER_DETAILS}" var="duration">
			            				<c:choose>
						            				<c:when test="${duration.qtrId == SetNewQtrId1}">
					                   					<option value="${duration.qtrId}" selected="selected">${duration.qtrDuration} </option>
					                   				</c:when>
					                   				<c:otherwise>
					                   					<option value="${duration.qtrId}">${duration.qtrDuration} </option>
					                   				</c:otherwise>
					                   	</c:choose>
					                   	</c:forEach>
			            			</c:when>
			            			<c:otherwise>
			            				<c:forEach items="${QUATER_DETAILS}" var="duration">
		                   					<option value="${duration.qtrId}">${duration.qtrDuration} </option>
			                       		</c:forEach>
			                       		
			            			</c:otherwise>
			            		</c:choose> 
								
                          </select>
                             </div>
                           </div>
                        </div>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>
										<div align="center">
											<strong>Type of Center</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>Faculty and Staff</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>No of Units Approved<br>A
											</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>Unit Cost Approved<br>B
											</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>No. of Unit Filled
											</strong>
										</div>
									</th>
								   <th>
								   		<div align="center">Expenditure Incurred </div>
								   </th>
									<input type="hidden" id="qtrIdJsp3" name="qtrIdJsp3" value=''/>
								   
								</tr>
							</thead>
							<tbody>
							<c:if test="${approved}">
					<c:choose>
							<c:when test="${not empty Additional_Faculty_PROGRESS}">
							
							
							<c:forEach items="${adtnlfacltyDtlsList}"  var="obj" varStatus="count" >
							
						<input type="hidden" name="institueInfraHrActivity.instituteInfraHrActivityId" value="${Additional_Faculty_PROGRESS.institueInfraHrActivity.instituteInfraHrActivityId}" > 
						 	 <input type="hidden" name="qprInstInfraHrId"  value="${Additional_Faculty_PROGRESS.qprInstInfraHrId}">
							 	<input type="hidden" name="additionalFacultyProgressDetail[${count.index}].qprInstInfraHrDetailsId" value="${Additional_Faculty_PROGRESS.additionalFacultyProgressDetail[count.index].qprInstInfraHrDetailsId}">
	
								<tr>
									<%-- <c:forEach items="${fetchinstitueInfraHrActivityDetails}"  var="obj1" varStatus="count"> --%>
									<td>
										 <strong>${fetchinstitueInfraHrActivityDetails[count.index].instituteInfraHrActivityType.trainingInstitueType.trainingInstitueTypeName}</strong> 
										
									</td>
									<td><strong>${fetchinstitueInfraHrActivityDetails[count.index].instituteInfraHrActivityType.instituteInfraHrActivityName}</strong></td>
									<td><input type="text" class="form-control" value="${fetchinstitueInfraHrActivityDetails[count.index].noOfUnits}" disabled/></td>
									<td><input type="text" class="form-control" value="${fetchinstitueInfraHrActivityDetails[count.index].unitCost}" disabled /></td>
								<%-- </c:forEach> --%>
								<td><input name="additionalFacultyProgressDetail[${count.index}].noOfUnitsFilled" type="text" style="text-align: right;" class="form-control validate" value="${obj.noOfUnitsFilled}" /></td>
								 	<td><input name="additionalFacultyProgressDetail[${count.index}].expenditureIncurred" type="text" style="text-align: right;" class="form-control validate" value="${obj.expenditureIncurred}"></td>
						
								</tr>
								</c:forEach>
								
						</c:when>
						<c:otherwise>
						<c:forEach items="${fetchinstitueInfraHrActivityDetails}" var="obj" varStatus="count">
						
					 <input type="hidden" name="institueInfraHrActivity.instituteInfraHrActivityId"  value="${instituteInfraHrActivityId}">
							<%-- 	<input type="hidden" name="qprInstInfraHrId"  value="${qprInstInfraHrId}"> --%>
<%-- 							 <input type="hidden" name="additionalFacultyProgressDetail[${count.index}].instituteInfraHrActivityType.instituteInfraHrActivityTypeId"  value="${fetchinstitueInfraHrActivityDetails.instituteInfraHrActivityTypeId}">
 --%>		
							
								<tr>
							<td>
										<div align="center">
										 <strong>${obj.instituteInfraHrActivityType.trainingInstitueType.trainingInstitueTypeName}</strong> 
										</div>
									</td>
									<td><strong>${obj.instituteInfraHrActivityType.instituteInfraHrActivityName}</strong></td> 
									<td><input type="text" class="form-control" value="${obj.noOfUnits}" disabled/></td>
									<td><input type="text" class="form-control" value="${obj.unitCost}" disabled /></td>
									<td><input name="additionalFacultyProgressDetail[${count.index}].noOfUnitsFilled" type="text" class="form-control validate" /></td>
								 	<td><input name="additionalFacultyProgressDetail[${count.index}].expenditureIncurred" type="text" class="form-control validate"/></td> 
								 	
								</tr>
								
								
							 </c:forEach> 
							</c:otherwise>
						</c:choose>
						</c:if>
						
							</tbody>
						</table>
						<c:if test="${!approved}">
								<div class="alert alert-danger">
	  								<strong>Danger!</strong> There is no training Activity.
								</div>
							</c:if>
						<div class="text-right"><button type="submit" class="btn bg-green waves-effect">
										SAVE</button>
									<button type="button" onclick="onClear(this)"
										class="btn bg-light-blue waves-effect">CLEAR</button>
									<button type="button"
										onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-orange waves-effect">CLOSE</button>
								</div> 
								
					</div>
					</form:form>
				</div>
				
			</div>
		</div>
	</div>
</section>
                             
                            