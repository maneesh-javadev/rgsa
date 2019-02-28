<%@include file="../taglib/taglib.jsp"%>
<html >
<head>
<script type="text/javascript"> 

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

function getSelelctedQtrRprt(){
	 var qtId = $('#quaterId').val();
	 $('#qtrIdJsp2').val(qtId);
	 	document.administrativeTechnicalProgress.method = "get";
		document.administrativeTechnicalProgress.action = "adminTechQuaderly.html?<csrf:token uri='adminTechQuaderly.html'/>";
		document.administrativeTechnicalProgress.submit();
}


</script>

<style type="text/css">

.alignment{
	text-align: right;
}


</style>

</head>
<section data-ng-controller="adminTechSupportSaffController" class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Administrative & Technical Support to Gram Panchayat</h2>
					</div>
					<form:form method="post" name="administrativeTechnicalProgress" action="adminTechQuaderly.html"
						modelAttribute="ADMIN_QUATER">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="currentUsageSatcomQuaterlyPost.html" />" />
				
					<div class="body">
				<div class="row clearfix">
					 <div class="form-group">
						<div class="col-lg-2">
						  	<label for="QuaterId1"><strong>Quarter Duration :</strong></label>
					    </div>
							<div align="center" class="col-lg-4">
					<select id="quaterId"  name="quarterDuration.qtrId" class="form-control" onchange="getSelelctedQtrRprt();">
								<option value="">Select</option>
							<c:choose>
			            		<c:when test="${not empty Administrative_Technical_PROGRESS}">
				            				<c:forEach items="${QUATER_DETAILS}" var="duration">
					            				<c:choose>
						            				<c:when test="${duration.qtrId == Administrative_Technical_PROGRESS.quarterDuration.qtrId}">
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
						<div class="table-responsive">
						<form name="myForm">
							<table class="table table-bordered" id="mytable">
								<thead>
									<tr>
										<th>S.No.</th>
										<th>Post Type</th>
										<th>Post Name</th>
										<th>No. Of Unit Approved </th>
										<th>Unit Cost Approved</th>
										<th>No. of Unit Filled</th>
										<th >Expenditure Incurred</th>
										<input type="hidden" id="qtrIdJsp2" name="qtrIdJsp2" value='${qtrIdJsp2}'/>
										</tr>
										
								</thead>
								<tbody>
								<c:if test="${approved}">
								<c:choose> 
										 <c:when test="${not empty Administrative_Technical_PROGRESS}">
										  <c:forEach items="${Administrative_Technical_PROGRESS.administrativeTechnicalSupport.supportDetails}"  var="obj" varStatus="count">
											
											<input type="hidden" name="administrativeTechnicalSupport.administrativeTechnicalSupportId" value="${Administrative_Technical_PROGRESS.administrativeTechnicalSupport.administrativeTechnicalSupportId}" > 
						 	                 <input type="hidden" name="atsId"  value="${Administrative_Technical_PROGRESS.atsId}">
							               	 <input type="hidden" name="administrativeTechnicalDetailProgress[${count.index}].atsDetailsProgressId" value="${Administrative_Technical_PROGRESS.administrativeTechnicalDetailProgress[count.index].atsDetailsProgressId}">
									          <input type="hidden" name="administrativeTechnicalDetailProgress[${count.index}].postType.postId"  value="${Administrative_Technical_PROGRESS.administrativeTechnicalDetailProgress[count.index].postType.postId}">
										<tr>
											<td><strong>${count.index+1}</strong></td>
											<td>
											<strong>${obj.postType.master.postTypeName}</strong></td>
											<td><strong>${obj.postType.postName}</strong></td>
										
											<td><strong>${obj.noOfUnits}</strong></td>
											<td><strong>${obj.unitCost}</strong></td>
											 <td><input type="text" name="administrativeTechnicalDetailProgress[${count.index}].noOfUnitCompleted" value="${Administrative_Technical_PROGRESS.administrativeTechnicalDetailProgress[count.index].noOfUnitCompleted}" class="form-control"></td>
											<td><input type="text" name="administrativeTechnicalDetailProgress[${count.index}].expenditureIncurred" value="${Administrative_Technical_PROGRESS.administrativeTechnicalDetailProgress[count.index].expenditureIncurred}" class="form-control"></td>
										 		</tr>
										 		</c:forEach>
										 		  <tr>
										   <th colspan="5"><label><strong>Additional Requirement :</strong></label><th>
                                          <td><input type="text" class ="form-control" name="additionalRequirement" value="${Administrative_Technical_PROGRESS.additionalRequirement}"/>
                                          </td>
                                          </tr>
										
										
										</c:when>
										
									 <c:otherwise> 
										<c:forEach items="${fetchAdministrativeTechnical.supportDetails}" var="obj1" varStatus="count">
									       <input type="hidden" name="administrativeTechnicalSupport.administrativeTechnicalSupportId"  value="${AdministrativeTechnicalSupportId}">
		                                   <input type="hidden" name="getAtsId"  value="${getAtsId}">
		                                   <input type="hidden" name="administrativeTechnicalDetailProgress[${count.index}].postType.postId"  value="${fetchAdministrativeTechnical.supportDetails[count.index].postType.postId}">
										
											<tr>
											<td><strong>${count.index+1}</strong></td>
											 <td><strong>${obj1.postType.master.postTypeName}</strong></td>
											<td><strong>${obj1.postType.postName}</strong></td>
										
											<td><strong>${obj1.noOfUnits}</strong></td>
											<td><strong>${obj1.unitCost}</strong></td>
											<td><input type="text" class ="form-control" name="administrativeTechnicalDetailProgress[${count.index}].noOfUnitCompleted" ></td>
											<td><input type="text" class ="form-control" name="administrativeTechnicalDetailProgress[${count.index}].expenditureIncurred"></td>
												</tr>
												</c:forEach>
										<tr>
                                           <th colspan="5"><label><strong>Additional Requirement :</strong></label><th>
                                          <td><input type="text" class ="form-control"  value="${fetchAdministrativeTechnical.additionalRequirement}"/>
                                           
                                           
                                          </tr>
												
												
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
							</form>
						</div>
					</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
</html>
