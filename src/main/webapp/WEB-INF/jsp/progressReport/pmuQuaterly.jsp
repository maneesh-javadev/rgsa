<%@include file="../taglib/taglib.jsp"%>
<<script type="text/javascript">

 

function getSelelctedQtrRprt(){
	 var qtId = $('#quaterId').val();
	 $('#qtrIdJsp6').val(qtId);
	 	document.pmuProgress.method = "get";
		document.pmuProgress.action = "pmuProgresReport.html?<csrf:token uri='pmuProgresReport.html'/>";
		document.pmuProgress.submit();
}
</script> 
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>PMU Progress Report</h2>
					</div>
					<div class="body">
		<form:form method="post" name="pmuProgress" action="pmuProgresReport.html"	modelAttribute="PMU_ACTIVITY_QUATERLY">
						<input type="hidden" name="<csrf:token-name/>"	value="<csrf:token-value uri="pmuProgresReport.html" />" />
						<div class="card">
							<div class="table-responsive">
							<div class="row clearfix">
					 <div class="form-group">
						<div class="col-lg-2">
						  	<label for="QuaterId1"><strong>Quarter Duration :</strong></label>
					    </div>
							<div align="center" class="col-lg-4">
					<select id="quaterId"  name="quarterDuration.qtrId" class="form-control" onchange="getSelelctedQtrRprt();">
								<option value="">Select</option>
							<c:choose>
			            		<c:when test="${not empty PMU_PROGRESS}">
				            				<c:forEach items="${QUATER_DETAILS}" var="duration">
					            				<c:choose>
						            				<c:when test="${duration.qtrId == PMU_PROGRESS.quarterDuration.qtrId}">
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
                             <br>
								<table class="table table-bordered" id="supportStaff">
									<thead>
										<tr>
											<th><div align="center">Type of Center</div></th>
											<th><div align="center">Faculty and Staff</div></th>
											<th><div align="center">No. of Units Approved</div></th>
											<th><div align="center">Approved Unit Cost</div></th>
											<!-- <th><div align="center">No of Months</div></th>
											<th><div align="center">Fund</div></th>
											<th><div align="center">Others Expenses</div></th>
											<th><div align="center">Total Cost</div></th>
											 --><th><div align="center"></div>No. of units completed/Persons involved </th>
											<th><div align="center"></div> Expenditure incurred</th>
											<input type="hidden" id="qtrIdJsp6" name="qtrIdJsp6" value='${qtrIdJsp6}'/>
										</tr>
									</thead>
									<tbody>
									<c:set var="count" value="0" scope="page" />
							
							
							<c:if test="${approved}">
					<c:choose>
							<c:when test="${not empty PMU_PROGRESS}">
							
							
							<c:forEach items="${PMU_PROGRESS.pmuActivity.pmuActivityDetails}"  var="obj" varStatus="count" >
							
						<input type="hidden" name="pmuActivity.pmuActivityId" value="${PMU_PROGRESS.pmuActivity.pmuActivityId}" > 
						 	 <input type="hidden" name="qprPmuId"  value="${PMU_PROGRESS.qprPmuId}">
							 	<input type="hidden" name="pmuProgressDetails[${count.index}].qprPmuDetailsId" value="${PMU_PROGRESS.pmuProgressDetails[count.index].qprPmuDetailsId}">
	                     
								<tr>
									
									<td>
										 <strong>${obj.pmuActivityType.pmuType.pmuTypeName}</strong> 
										
									</td>
									<td><strong>${obj.pmuActivityType.pmuActivityName}</strong></td>
									<td><input type="text" class="form-control" value="${obj.unitCost}" disabled/></td>
									<td><input type="text" class="form-control" value="${obj.noOfMonths}" disabled /></td>
								
								<td><input name="pmuProgressDetails[${count.index}].noOfUnitsFilled" type="text" style="text-align: right;" class="form-control validate" value="${PMU_PROGRESS.pmuProgressDetails[count.index].noOfUnitsFilled}" /></td>
								 	<td><input name="pmuProgressDetails[${count.index}].expenditureIncurred" type="text" style="text-align: right;" class="form-control validate" value="${PMU_PROGRESS.pmuProgressDetails[count.index].expenditureIncurred}"></td>
						
								</tr>
								</c:forEach>
								
						</c:when>
						<c:otherwise> 
						
						<c:forEach items="${fetchPmuActivityDetails.pmuActivityDetails}" var="obj1" varStatus="count" >
							
					 <input type="hidden" name="pmuActivity.pmuActivityId"  value="${pmuActivityId}">
					 <input type="hidden" name="pmuProgressDetails.pmuActivityId"  value="${pmuActivityTypeId}">
					 
							<%-- <%-- 	<input type="hidden" name="qprInstInfraHrId"  value="${qprInstInfraHrId}">
 							 <input type="hidden" name="additionalFacultyProgressDetail[${count.index}].instituteInfraHrActivityType.instituteInfraHrActivityTypeId"  value="${fetchinstitueInfraHrActivityDetails.instituteInfraHrActivityTypeId}">

							 --%>
								<tr>
							<td>
										<div align="center">
										 <strong>${obj1.pmuActivityType.pmuType.pmuTypeName}</strong> 
										</div>
									</td>
									<td><strong>${obj1.pmuActivityType.pmuActivityName}</strong></td> 
									<td><input type="text" class="form-control" value="${obj1.unitCost}" disabled/></td>
									<td><input type="text" class="form-control" value="${obj1.noOfMonths}" disabled /></td>
									<td><input name="pmuProgressDetails[${count.index}].noOfUnitsFilled" type="text" class="form-control validate" /></td>
								 	<td><input name="pmuProgressDetails[${count.index}].expenditureIncurred" type="text" class="form-control validate"/></td> 
								 	
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
						</div>
						
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>