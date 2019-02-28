<%@include file="../taglib/taglib.jsp"%>
<html>
<script>

function getSelelctedQtrRprt(){
	 var qtId = $('#quaterId').val();
	 $('#qtrId').val(qtId);
	 	document.iecQuater.method = "post";
		document.iecQuater.action = "iecQtrProgressReportQtr.html?<csrf:token uri='iecQtrProgressReportQtr.html'/>";
		document.iecQuater.submit();
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
<section class="content">
	<div class="container-fluid">   
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Proposal for Information, Education, Communication (IEC) Progress Report</h2>
					</div>
					<form:form method="POST" name="iecQuater" action="iecQtrProgressReport.html"
						id="iecId" modelAttribute="IEC_ACTIVITY_QUATER" path="iecQtrProgressReport">
						<div align="center" class="row" >
								<br/>
							
					<div class="row clearfix">
					 <div class="form-group">
						<div class="col-lg-2">
						  	<label for="QuaterId1"><strong>Quarter Duration :</strong></label>
					    </div>
							<div align="center" class="col-lg-4">
					<select id="quaterId"  name="quarterDuration.qtrId" class="form-control" onchange="getSelelctedQtrRprt();">
								<option value="">Select</option>
							<c:choose>
			            		<c:when test="${not empty IEC_ACTIVITY_PROGRESS}">
				            				<c:forEach items="${QUATER_DETAILS}" var="duration">
					            				<c:choose>
						            				<c:when test="${duration.qtrId == IEC_ACTIVITY_PROGRESS.quarterDuration.qtrId}">
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
						</div>
						
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="iec.html"/>" />
													<div class="body">
							<div class="card">
								<div class="table-responsive">
									<table class="table table-bordered" id="mytable">
										<thead>
											<tr>
												<th scope="col"><div align="center">
														<strong>Nature of the IEC Activity</strong>
													</div></th>
												<th scope="col"><div align="center">
														<strong>Total Amount Proposed</strong>
													</div></th>
												<th scope="col"><div align="center">
														<strong>no. Of Units Filled</strong>
													</div></th>
												<th scope="col"><div align="center">
														<strong>Expenditure Incurred</strong>
													</div></th>
							 <input type="hidden" id="qtrId" name="qtrId" value=''/>
													
											</tr>
										</thead>
										<tbody id="newBody">
										<c:if test="${approved}">
											 <c:choose> 
											 
											
											<c:when test="${not empty IEC_ACTIVITY_PROGRESS}">
										  <c:forEach items="${IEC_ACTIVITY_PROGRESS.iecActivity.iecActivityDetails}"  var="obj" varStatus="count">
										  	<input type="hidden" name="iecActivity.id" value="${IEC_ACTIVITY_PROGRESS.iecActivity.id}" > 
						 	                 <input type="hidden" name="qprIecId"  value="${IEC_ACTIVITY_PROGRESS.qprIecId}">
							               	 <input type="hidden" name="iecQuaterDetails[${count.index}].qprIecDetailsId" value="${IEC_ACTIVITY_PROGRESS.iecQuaterDetails[count.index].qprIecDetailsId}">
									         <tr>
											<td><strong>${obj.iecActivityDropedown.natureIecActivity}</strong></td>
											<td><strong>${obj.totalAmountProposed}</strong></td>
												
											
											
											 <td><input type="text" name="iecQuaterDetails[${count.index}].noOfUnitsFilled" value="${IEC_ACTIVITY_PROGRESS.iecQuaterDetails[count.index].noOfUnitsFilled}" class="form-control validate"></td>
											<td><input type="text" name="iecQuaterDetails[${count.index}].expenditureIncurred" value="${IEC_ACTIVITY_PROGRESS.iecQuaterDetails[count.index].expenditureIncurred}" class="form-control validate"></td>
										</tr></c:forEach>
											</c:when>
											<c:otherwise> 
											<c:forEach items="${fetchIecActivity.iecActivityDetails}" var="obj" varStatus="count">
									      <input type="hidden" name="iecActivity.id"  value="${id}">
		                                 <%--   <input type="hidden" name="qprIecId"  value="${getIecId}"> --%>
		                                  
											<tr>
											<td><strong>${obj.iecActivityDropedown.natureIecActivity}</strong></td>
											<td><strong>${obj.totalAmountProposed}</strong></td>
												
											
											
											 <td><input type="text" name="iecQuaterDetails[${count.index}].noOfUnitsFilled" class="form-control validate"></td>
											<td><input type="text" name="iecQuaterDetails[${count.index}].expenditureIncurred"  class="form-control validate"></td>
										 		</tr>
												</c:forEach>
											
											
											 </c:otherwise> 
										
										
											 </c:choose>
                                              </c:if>
										
										</tbody>
											<c:set var="count" value="0" scope="page" />
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

						</div>
						
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
</html>
<script>
	/* $('document').ready(function(){
		if( '${readOnlyEnabled}' == 'true'){
			$('.active123').prop('readonly',true);
			 $('.activedrop').attr('disabled',true);
			$('.activeadd').prop('disabled',true);
			$('.activedelete').prop('disabled',true);
			$('#save').prop('disabled',true);
			$('#CLEAR').prop('disabled',true);
			$('#FREEZE').hide();
			$('#UNFREEZE').show();
		}
		else{
			$('.active123').prop('readonly' ,false);
			 $('.activedrop').attr('disabled',false); 
			$('.activeadd').prop('disabled',false);
			$('.activedelete').prop('disabled',false);
			$('#UNFREEZE').hide();
			$('#FREEZE').show();
		}
}); */
	
	
	 
	
	  
	
	
</script>
