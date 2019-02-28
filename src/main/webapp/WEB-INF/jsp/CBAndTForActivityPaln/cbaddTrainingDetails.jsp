<%@include file="../taglib/taglib.jsp"%>

<html>
<head>
<script type="text/javascript">

$(document).ready(function(){
    $('#noOfParticipants').keyup(calculate);
    $('#noOfDays').keyup(calculate);
    $('#unitCost').keyup(calculate);
});
function calculate(e)
{
	
	if($('#venueId').val() == '1'){
		var check = $('#noOfDays').val() * 1900;
		var calc = 	$('#noOfDays').val()* $('#unitCost').val();
		if(calc <= check){
    $('#funds').val($('#noOfParticipants').val() * calc);
	}else {
		alert("Upper ceiling  limit  Rs. 1900 per participant per day");
		$('#unitCost').val(0);
		/* $('#noOfDays').val(0); */
		$('#funds').val(0);
	}
		
		}if($('#venueId').val() == '2'){
			var check = $('#noOfDays').val() * 1100;
			var calc = 	$('#noOfDays').val()* $('#unitCost').val();
			if(calc <= check){
	    $('#funds').val($('#noOfParticipants').val() * calc);
		}else {
			alert("Upper ceiling  limit  Rs. 1100 per participant per day");
			$('#unitCost').val(0);
			/* $('#noOfDays').val(0); */
			$('#funds').val(0);
		}
			
		}
				    if($('#venueId').val() == '3'){
				    	var check = $('#noOfDays').val() * 800;
						var calc = 	$('#noOfDays').val()* $('#unitCost').val();
						if(calc <= check){
				    $('#funds').val($('#noOfParticipants').val() * calc);
					}else {
						alert("Upper ceiling  limit  Rs. 800 per participant per day");
						$('#unitCost').val(0);
						/* $('#noOfDays').val(0); */
						$('#funds').val(0);
					}
				}
}

function addRow() {
    var tds = '<tr>';
    tds+=$("#newRowHtml").html();
    tds += '</tr>';
	$("#tbodyId").append(tds);
    
}
function removeRow(){
	if($('#tableId tr').length>2){
    $('#tableId tr:last').remove();
	}
}
function showSbjctDrpDwn(tadId){
	var id = $("#categoryId").val();
	if(id  > 0){
	document.getElementById("catgryId").value = id; 
	document.getElementById("idToEdit").value = tadId; 
	document.cpbaddtraining.method = "post";
	document.cpbaddtraining.action = "modifyTrainingActivity.html?<csrf:token uri='modifyTrainingActivity.html'/>";
	document.cpbaddtraining.submit();
	}
	else{
		$('#sbjctListId').empty();
		return false;
	}
}

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

</script>
</head>

<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Add Trainings</h2>
					</div>
					<div class="body">
		  <form:form action="cpbaddtraining.html" id="cpbaddtrainingID" name="cpbaddtraining" class="form-inline" modelAttribute="CBP_ADDTRAINING" method="POST">
								        <div class="row clearfix">
		                                    <div class="col-sm-2">
		                                        <label >Training Category</label>
		                                    </div>
		                                    <input type="hidden" name="<csrf:token-name/>" value="<csrf:token-value uri='cpbaddtraining.html'/>" />
		                                    <div class="col-sm-4">
		                                        <div class="form-group">
		                                                <select id="categoryId" onchange="showSbjctDrpDwn('${showTrainingActivity.trainingActivityDetailsId}');" class="form-control" required="required" name="trainingActivityDetailsList[0].trainingCategoryId.trainingCategoryId">
		                                                 		<option id="0" value="">----------------------Select----------------------</option>
		                                                <c:forEach items="${trainingCatgryList}" var="CatgryList">
		                                                	<c:choose>
			                                                	<c:when test="${showTrainingActivity.trainingCategoryId.trainingCategoryId == CatgryList.trainingCategoryId}">
			                                                		<option id="${CatgryList.trainingCategoryId}" value="${CatgryList.trainingCategoryId}" selected="selected">${CatgryList.trainingCategoryName}</option>
			                                                	</c:when>
			                                                	<c:when test="${setCatgryId == CatgryList.trainingCategoryId}">
			                                                		<option id="${CatgryList.trainingCategoryId}" value="${CatgryList.trainingCategoryId}" selected="selected">${CatgryList.trainingCategoryName}</option>
			                                                	</c:when>
			                                                	<c:otherwise>
			                                                		<option id="${CatgryList.trainingCategoryId}" value="${CatgryList.trainingCategoryId}">${CatgryList.trainingCategoryName}</option>
			                                                	</c:otherwise>
		                                                	</c:choose>
								                    	</c:forEach>
				                    				</select>
		                                        </div>
		                                    </div>
		                                    <div class="col-sm-2">
		                                       <label >Target Group</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                        <div class="form-group">
				                    				<form:select path="trainingActivityDetailsList[0].trainingTargetGroupsArray" cssClass="form-control" multiple="true" required="required">
														<c:forEach items="${targetGrpMstrList}" var="GrpMstrList" varStatus="count">
															<c:set var="isSelected" value="false" />
														<c:forEach items="${showTrainingActivity.trainingTargetGroupsList}" var="trgtGp">
															<c:if test="${trgtGp.targetGroupMasterId.targetGroupMasterId == GrpMstrList.targetGroupMasterId}">
																<c:set var="isSelected" value="true" />
															</c:if>
														</c:forEach>	
															<c:choose>
																<c:when test="${isSelected}">
																	<option  value="${GrpMstrList.targetGroupMasterId}"  selected="selected">${GrpMstrList.targetGroupMasterName}</option>
																</c:when>
																<c:otherwise>
																	<option  value="${GrpMstrList.targetGroupMasterId}">${GrpMstrList.targetGroupMasterName}</option>
																</c:otherwise>
															</c:choose>
														
								                   </c:forEach>
													</form:select>
		                                        </div>
		                                    </div>
		                                </div>
		       <c:if test="${not empty allTrainingActivity}">
		       <input type="hidden" name="trainingActivityId" value="${allTrainingActivity.trainingActivityId}" /> 
		       </c:if>
		       <c:if test="${not empty showTrainingActivity.trainingActivity.trainingActivityId}">
		       <input type="hidden"  name="trainingActivityId" value="${showTrainingActivity.trainingActivity.trainingActivityId}" /> 
		       <input type="hidden" name="additionalRequirement" value="${showTrainingActivity.trainingActivity.additionalRequirement}" /> 
		       <input type ="hidden" name="trainingActivityDetailsList[0].trainingActivityDetailsId" value="${showTrainingActivity.trainingActivityDetailsId}" />
		       </c:if>
		       <c:if test="${not empty setTrainingActivity}">
		       <input type="hidden" name="trainingActivityId" value="${setTrainingActivity}" /> 
		       <input type="hidden" name="additionalRequirement" value="${setAddtnlReqrmnt}" /> 
		       </c:if>
		                                <div class="row clearfix">
		                                    <div class="col-sm-2">
		                                        <label >Training Subjects</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                        <div class="form-group">
		                                        	<form:select path="trainingActivityDetailsList[0].trainingSubjectsArray" id="sbjctListId" multiple="true" cssClass="form-control" required="required">
														<c:forEach items="${subjectsList}" var="subjectsList" varStatus="count"> 
															<c:set var="isSelected" value="false" />
																<c:forEach items="${showTrainingActivity.trainingSubjectsList}" var="subjLst">
															<c:if test="${subjLst.trngSubjectId.subjectId == subjectsList.subjectId}">
																 	<c:set var="isSelected" value="true" />
															</c:if>
																</c:forEach>
															<c:choose>
																<c:when test="${isSelected}">
																	<option id="${subjectsList.subjectId}" value="${subjectsList.subjectId}" selected="selected">${subjectsList.subjectName}</option>
																</c:when>
																<c:otherwise>
																	<option id="${subjectsList.subjectId}" value="${subjectsList.subjectId}">${subjectsList.subjectName}</option>
																</c:otherwise>
															</c:choose>
																	
								                    	</c:forEach>
													</form:select>
		                                        </div>
		                                    </div>
		                                    <div class="col-sm-2">
		                                         <label >Training Venue Level</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                        <div class="form-group">
		                                        	<select id="venueId" class="form-control" name="trainingActivityDetailsList[0].trainingVenueLevelId.trainingVenueLevelId" required="required">
														<c:forEach items="${trngVenueList}" var="VenueList">
															<c:choose>
																<c:when test="${showTrainingActivity.trainingVenueLevelId.trainingVenueLevelId == VenueList.trainingVenueLevelId}">
																	<option id="${VenueList.trainingVenueLevelId}" value="${VenueList.trainingVenueLevelId}" selected="selected">${VenueList.trainingVenueLevelName}</option>
																</c:when>
																<c:otherwise>
									                    			<option id="${VenueList.trainingVenueLevelId}" value="${VenueList.trainingVenueLevelId}">${VenueList.trainingVenueLevelName}</option>
									                    		</c:otherwise>
								                    		</c:choose>
								                    	</c:forEach>
													</select>
		                                        </div>
		                                    </div>
		                                </div>
		                                
		                                <div class="row clearfix">
		                                    <div class="col-sm-2">
		                                        <label >No. of Participants</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                        <input type="text" onkeypress="return isNumber(event)" oninput="validity.valid||(value='');" min="1" id="noOfParticipants" required="required" name="trainingActivityDetailsList[0].noOfParticipants" value="${showTrainingActivity.noOfParticipants}" class="form-control" onKeyPress="if(this.value.length==4) return false;" maxlength="5" style="text-align:right;">
		                                    </div>
		                                    <div class="col-sm-2">
		                                        <label >No. of Days Proposed</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                                <input type="text" onkeypress="return isNumber(event)" oninput="validity.valid||(value='');" min="1" id="noOfDays" onKeyPress="if(this.value.length==3) return false;" required="required" name="trainingActivityDetailsList[0].noOfDays" value="${showTrainingActivity.noOfDays}" class="form-control" maxlength="2" style="text-align:right;">
		                                    </div>
		                                </div>
		                                
		                                <div class="row clearfix">
		                                    <div class="col-sm-2">
		                                        <label >Unit Cost(In Rs.)</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                        <input type="text" onkeypress="return isNumber(event)" oninput="validity.valid||(value='');" min="1" id="unitCost" required="required" onKeyPress="if(this.value.length==4) return false;" name="trainingActivityDetailsList[0].unitCost" value="${showTrainingActivity.unitCost}" class="form-control" style="text-align:right;">
		                                    </div>
		                                    <div class="col-sm-2">
		                                        <label >Funds Proposed(In Rs.)</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                                <input type="number" id="funds" readonly="readonly" name="trainingActivityDetailsList[0].funds" value="${showTrainingActivity.funds}" class="form-control" style="text-align:right;">
		                                    </div>
		                                </div>
		                                
		                                
		                                <div class="row clearfix">
		                                    <div class="col-sm-2">
		                                        <label >Mode of Training </label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                        <div class="form-group">
		                                        	<select class="form-control" name="trainingActivityDetailsList[0].trainingMode.trainingModeId" required="required" >
		                                        		<c:forEach items="${modeOfTrainingList}" var="modeList">
		                                        			<c:choose>
																<c:when test="${showTrainingActivity.trainingMode.trainingModeId == modeList.trainingModeId}">
		                                        					<option value="${modeList.trainingModeId}" selected="selected">${modeList.trainingModeName}</option>
		                                        				</c:when>
		                                        				<c:otherwise>
		                                        					<option value="${modeList.trainingModeId}">${modeList.trainingModeName}</option>
		                                        				</c:otherwise>
		                                        			</c:choose>
		                                        		</c:forEach>
		                                        	</select>
		                                        </div>
		                                    </div>
		                                    <div class="col-sm-2">
		                                        <label >Remarks</label>
		                                    </div>
		                                    <div class="col-sm-4">
		                                                <textarea cols="40" name="trainingActivityDetailsList[0].remarks" rows="2">${showTrainingActivity.remarks}</textarea>
		                                    </div>
		                                </div>
		                                <input type="hidden" name="idToEdit" id="idToEdit" >
		                                 <input type="hidden" name="catgryId" id="catgryId" >
				 			<div class="text-right">
				 			 		 <%-- <c:if test="${Plan_Status eq true}"> --%>
										<button type="submit" class="btn bg-green waves-effect">SAVE</button>
									<%-- </c:if> --%>
									<button type="button" onclick="onClear(this)" class="btn bg-light-blue waves-effect">CLEAR</button>
									 <button type="button"	onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect">CLOSE</button>
							</div>
						</form:form>		
					</div>
				</div>
			</div>
		</div>
	</div>
</section>