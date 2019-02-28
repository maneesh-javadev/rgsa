<%@include file="../taglib/taglib.jsp"%>
<script>

function getSelelctedQtrRprt(){
	 var districtId = $('#districtId').val();
	 var quaterId = $('#quaterId').val();
	 $('#districtId').val(districtId);
	 $('#qrtId').val(quaterId);
	 	document.qprEnablement.method = "get";
		document.qprEnablement.action = "enablementQuaterly.html?<csrf:token uri='enablementQuaterly.html'/>";
		document.qprEnablement.submit();
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
						<h2>e-Enablement Quarter Progress Report</h2>
					</div>
					<form:form method="post" name="qprEnablement" action="enablementQuaterly.html"
						modelAttribute="Enablement">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="enablementQuaterly.html" />" />
											<div class="body">
							<div class="card">
							
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
			            		<c:when test="${not empty Qpr_Enablement}">
				            				<c:forEach items="${QUATER_DETAILS}" var="duration">
					            				<c:choose>
						            				<c:when test="${duration.qtrId == Qpr_Enablement.quarterDuration.qtrId}">
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
						<div class="row clearfix">
					 <div class="form-group">
						<div class="col-lg-2">
						  	<label for="QuaterId1"><strong>District :</strong></label>
					    </div>
							<div align="center" class="col-lg-4">
						<select class="form-control" name="districtId" multiple="multiple"  id= "districtId" onchange="getSelelctedQtrRprt();" >
							<option value="">Select</option>
								<c:if test="${not empty eEnablementReportDto}">
							<c:forEach items="${LGD_DISTRICT}" var="district">
							<%-- <c:forEach items="${eEnablementGPs}" var="obj" varStatus="count">
							 --%>	
								<c:choose>
								<%-- <c:when test="${ ${district.districtCode}=='${eEnablementGPs.districtCode}' }">
         --%>
									 <c:when test="${district.districtCode == eEnablementGPs[1].districtCode}">
                                        <option value="${district.districtCode}" selected="selected">${district.districtNameEnglish}</option>	
                                    </c:when>
                                  
	                   				<c:otherwise>
                                             <option value="${district.districtCode}">${district.districtNameEnglish}</option>		
                                    </c:otherwise>
                   				</c:choose>
                   				<%--  </c:forEach> --%>
                   				
                   				<%-- <c:choose>
									<c:when test="${district.districtCode == eEnablementGPs[1].districtCode}">
                                        <option value="${district.districtCode}" selected="selected">${district.districtNameEnglish}</option>	
                                    </c:when>
	                   				<c:otherwise>
                                             <option value="${district.districtCode}">${district.districtNameEnglish}</option>		
                                    </c:otherwise>
                   				</c:choose> --%>
							</c:forEach>
							</c:if>
							
								
						</select></div> </div></div>
						<br>
											<table class="table table-bordered">
							<thead>
								<tr>
								
									<th>
										<div align="center">
											<strong>Gp Name.</strong>
										</div>
									</th>
									
									<th>
										<div align="center">
											<strong>Approved Amount</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>Expenditure Incurred(in Rs.)</strong>
										</div>
									</th>
								</tr>
								<input type="hidden" id="districtId" name="districtId" value=''/>
								<input type="hidden" id="qrtId" name="qrtId" value=''/>
							</thead>
							<tbody>
							<c:if test="${approved}">
							
							 
								<c:set var="count" value="0" scope="page" />
								
								 <c:choose>  
										  <c:when test="${not empty Qpr_Enablement}">
										  <c:forEach items="${EnablementDtlsList}"  var="obj" varStatus="count" begin="0" end="1">
										  <%-- <c:forEach items="${eEnablementReportDto}" var="localbody"  >  --%>
									<tr>			
											 <input type="hidden" name="eEnablement.eEnablementId" value="${Qpr_Enablement.eEnablement.eEnablementId}" > 
						 	                 <input type="hidden" name="qprEEnablementId"  value="${Qpr_Enablement.qprEEnablementId}">
							               	 <input type="hidden" name="qprEnablementDetails[${count.index}].qprEEenablementDetailsId" value="${Qpr_Enablement.qprEnablementDetails[count.index].qprEEenablementDetailsId}">
									         <input type="hidden" name="qprEnablementDetails[${count.index}].localBodyCode"  value="${Qpr_Enablement.qprEnablementDetails[count.index].localBodyCode}">
										<tr>
									</td>
									
									 <%-- <td><strong>${localbody.localBodyNameEnglish}</strong></td>
									 <td><strong>${localbody.unitCost}</strong></td> --%>
									 <td><strong>${eEnablementReportDto[count.index].localBodyNameEnglish}</strong></td>
									 <td><strong>${eEnablementReportDto[count.index].unitCost}</strong></td>
									
									<td>
								<%-- 	<input type="text" class="form-control" name="qprEnablementDetails[${count.index}].expenditureIncurred" value="${obj.expenditureIncurred}"   placeholder="Post Type aa">
								 --%>	
								
										
 											<input type="text" class="form-control" name="qprEnablementDetails[${count.index}].expenditureIncurred" value="${obj.expenditureIncurred}"   placeholder="Post Type aa">
											
											<%-- <input type="text" class="form-control" name="qprEnablementDetails[${count.index}].expenditureIncurred" value="${fetchDetails[0].expenditureIncurred}"   placeholder="Post Type bb"> --%>
								<%-- </c:otherwise>
									</c:choose> --%>
									
									</td>
									</c:forEach>
									
									</tr>
										
										 		
										 	
										 	<%-- </c:forEach> --%>	 
										
										
										</c:when> 
										
									 <c:otherwise>  
										<c:forEach items="${eEnablementReportDto}" var="localbody" varStatus="count"> 
										 <input type="hidden" name="eEnablement.eEnablementId"  value="${idEEnablement}">
<%-- 	                              		 <input type="hidden" name="qprEEnablementId"  value="${qprEEnablementId}"> 
 --%>		                                 <input type="hidden" name="qprEnablementDetails[${count.index}].localBodyCode"  value="${localbody.localBodyCode}">
										 <input type="hidden" name="qprEnablementDetails[${count.index}].qprEEenablementDetailsId" value="${Qpr_Enablement.qprEnablementDetails[count.index].qprEEenablementDetailsId}">
							
							<tr>
									 <td><strong>${localbody.localBodyNameEnglish}</strong>
									</td>
									
									<td><strong>${localbody.unitCost}</strong></td>
									<td>
									<input type="text" class="form-control" name="qprEnablementDetails[${count.index}].expenditureIncurred" <%-- value="${fetchDetails[0].expenditureIncurred}"  --%> placeholder="Post Type"></td>
								</tr>
								 </c:forEach> 													
												
												
									</c:otherwise>
										
										</c:choose> 
							</tbody>
							</c:if>
								 <c:if test="${record == 'false'}">
								<div class="alert alert-danger">
	  								<strong>Danger!</strong> No Gps. Record Avaliable of that district"
								</div>
							</c:if> 
							
						</table>
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
</section>
                             
                        
                            