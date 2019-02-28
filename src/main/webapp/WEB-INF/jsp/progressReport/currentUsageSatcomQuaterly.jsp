<%@include file="../taglib/taglib.jsp"%>
<script>

function getSelelctedQtrRprt(){
	 var qtId = $('#quaterId').val();
	 $('#qtrIdJsp1').val(qtId);
	 	document.satcomActivityProgress.method = "post";
		document.satcomActivityProgress.action = "currentUsageSatcomQuaterlyPost.html?<csrf:token uri='currentUsageSatcomQuaterlyPost.html'/>";
		document.satcomActivityProgress.submit();
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
						<h2>Distance learning Facility through SATCOM/IP based
							virtual Class room/similar technology</h2>
					</div>
					<form:form method="post" name="satcomActivityProgress" action="currentUsageSatcomQuaterly.html"
						modelAttribute="SATCOM_QUATER">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="currentUsageSatcomQuaterlyPost.html" />" />
					<div class="body">
					<c:set var="count" value="0" scope="page" />
					<div class="row clearfix">
					 <div class="form-group">
						<div class="col-lg-2">
						  	<label for="QuaterId1"><strong>Quarter Duration :</strong></label>
					    </div>
							<div align="center" class="col-lg-4">
					<select id="quaterId"  name="satcomActivityProgressDetails[${count}].quarterDuration.qtrId" class="form-control" onchange="getSelelctedQtrRprt();">
								<option value="">Select</option>
							<c:choose>
			            			<c:when test="${not empty SATCOM_ACTIVITY_PROGRESS}">
			            				<c:forEach items="${SATCOM_ACTIVITY_PROGRESS.satcomActivityProgressDetails}" var="fetchTargetGrp" begin="0" end="0">
				            				<c:forEach items="${QUATER_DETAILS}" var="duration">
					            				<c:choose>
						            				<c:when test="${duration.qtrId == fetchTargetGrp.quarterDuration.qtrId}">
					                   					<option value="${duration.qtrId}" selected="selected">${duration.qtrDuration} </option>
					                   				</c:when>
					                   				<c:otherwise>
					                   					<option value="${duration.qtrId}">${duration.qtrDuration} </option>
					                   				</c:otherwise>
				                   				</c:choose>
				                       		</c:forEach>
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
								<%-- <c:forEach items="${QUATER_DETAILS}" var="quaters">
	                                <option value="${quaters.qtrId}">${quaters.qtrDuration}</option>
                                </c:forEach> --%>
                          </select>
                             </div>
                           </div>
                        </div>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>
										<div align="center">
											<strong>Name of the Activity</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>Panchayat Level</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>No. of Units<br>A
											</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>Unit Cost (in Rs)<br>B
											</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>Fund Proposed (in Rs)<br>C = A * B
											</strong>
										</div>
									</th>
								   <th>
								   		<div align="center">No. of units completed/Persons involved </div>
								   </th>
									
									<th><div align="center">Expenditure incurred</div></th>
									 <input type="hidden" id="qtrIdJsp1" name="qtrIdJsp1" value=''/>
								   
								</tr>
							</thead>
							<tbody>
							<c:if test="${approved}">
					<c:choose>
							<c:when test="${not empty SATCOM_ACTIVITY_PROGRESS}">
							
							
							<c:forEach items="${SATCOM_ACTIVITY_PROGRESS.satcomActivity.activityDetails}"  var="obj" varStatus="count">
							
							 <input type="hidden" name="satcomActivity.satcomActivityId" value="${SATCOM_ACTIVITY_PROGRESS.satcomActivity.satcomActivityId}" > 
						 	 <input type="hidden" name="satcomActivityProgressId"  value="${SATCOM_ACTIVITY_PROGRESS.satcomActivityProgressId}">
							 	<input type="hidden" name="satcomActivityProgressDetails[${count.index}].satcomDetailsProgressId" value="${SATCOM_ACTIVITY_PROGRESS.satcomActivityProgressDetails[count.index].satcomDetailsProgressId}">
	
								<tr>
									<td>
										<div align="center">
											<strong>${obj.satcomMaster.satcomMasterName}</strong>
										</div>
									</td>
									<td><strong>${obj.level.satcomLevelName}</strong>
										
									</td>
									<td><input type="text" class="form-control" style="text-align: right;" value="${obj.noOfUnits}" disabled/></td>
									<td><input type="text" class="form-control" style="text-align: right;" value="${obj.unitCost}" disabled /></td>
									<td><input type="text" class="form-control" style="text-align: right;" value="${obj.funds}" disabled/></td>
									<td><input name="satcomActivityProgressDetails[${count.index}].noOfUnitCompleted" type="text" style="text-align: right;" class="form-control validate" value="${SATCOM_ACTIVITY_PROGRESS.satcomActivityProgressDetails[count.index].noOfUnitCompleted}"/></td>
								 	<td><input name="satcomActivityProgressDetails[${count.index}].expenditureIncurred" type="text" style="text-align: right;" class="form-control validate" value="${SATCOM_ACTIVITY_PROGRESS.satcomActivityProgressDetails[count.index].expenditureIncurred}"/></td>
								
								</tr>
								</c:forEach>
								
						</c:when>
						<c:otherwise>
						<c:forEach items="${Satcom_Activity_Pro}" var="obj"  begin="0" end="0">
							<%-- <input type="hidden" name="satcomActivity.satcomActivityId" value="${SATCOM_ACTIVITY_PROGRESS.satcomActivity.satcomActivityId}"  --%>> 
							<%--  <input type="hidden" name="trainingReportId"  value="${getSatcomId}"> --%>
							<input type="hidden" name="satcomActivity.satcomActivityId"  value="${satcomActivityId}">
		                    <input type="hidden" name="satcomActivityProgressId"  value="${getSatcomId}">
		
							<c:forEach items="${obj.activityDetails}" var="obj1" varStatus="index"> 
								<tr>
									<td>
										<div align="center">
											<strong>${obj1.satcomMaster.satcomMasterName}</strong>
										</div> 
									</td>
									<td><strong>${obj1.level.satcomLevelName}</strong>
										
									</td>
									<td><input type="text" class="form-control" value="${obj1.noOfUnits}" disabled/></td>
									<td><input type="text" class="form-control" value="${obj1.unitCost}" disabled /></td>
									<td><input type="text" class="form-control" value="${obj1.funds}" disabled/></td>
									<td><input name="satcomActivityProgressDetails[${index.count-1}].noOfUnitCompleted" type="text" class="form-control validate" /></td>
								 	<td><input name="satcomActivityProgressDetails[${index.count-1}].expenditureIncurred" type="text" class="form-control validate"/></td> 
								 	
								 
								</tr>
								</c:forEach>
								<c:set var="count" value="${count + 1}" scope="page"/>
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
                             
                            