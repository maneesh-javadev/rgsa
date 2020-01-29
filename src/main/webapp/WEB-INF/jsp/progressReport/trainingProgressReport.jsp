<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../taglib/taglib.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<script type="text/javascript">
$(document).ready(function() { 
	$("#hidetbody").hide();
});
  

function totalParticipants(types,listIndex,catgryIndex){
	/* var total = 0;
	var rowCount = $('#tbodyId tr').length-1;
	for(var i = 0 ; i< rowCount;i++){
	total += parseFloat($('#sc'+i).val() || 0) + parseFloat($('#st'+i).val() || 0) + parseFloat($('#other'+i).val() || 0);
	}
	$('#totalParticipantsId').val(total); */
	 }

function setData() {
	var targetGroupLength='${TARGET_GROUP.size()}';
	 alert(targetGroupLength); 
}
 function validateForm(){
	 $('#totalParticipantsId').prop('disabled',false);
 }
 
 function getSelelctedQtrRprt(){
	 var qtId = $('#qtrIdDurtn').val();
	  $('#qtrIdJsp').val(qtId); 
	/*  $.ajax({
	        type: 'GET',
	        url: "trainingProgressReport.html?<csrf:token uri='trainingProgressReport.html'/>",
	        data: {"qtrIdJsp" : qtId},
	       
	        error:function(){
	            alert("Something Went Wrong");
	        }

	    }); */
	 	 document.trainingProgressReport.method = "post";
		document.trainingProgressReport.action = "trainingProgressRptQtr.html?<csrf:token uri='trainingProgressRptQtr.html'/>";
		document.trainingProgressReport.submit(); 
 }
 
 
 function setSc(cnt,indx){
	$('#sc_'+cnt+"_"+indx).val($('#sc_'+cnt+"_"+indx).val());
 }
 function setSt(cnt,indx){
		$('#st_'+cnt+"_"+indx).val($('#st_'+cnt+"_"+indx).val());
	 }
 function setOther(cnt,indx){
		$('#other_'+cnt+"_"+indx).val($('#other_'+cnt+"_"+indx).val());
	 }
function hideModal(){
	$('#participantsBreak').modal('hide');
}
</script>

</head>
<body>
<form action="trainingProgressReport.html" method="POST"  name="trainingProgressReport" modalAttribute="TRAINING_DETAILS">
<div class="modal fade" id="participantsBreak" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
          <h4 class="modal-title">Break Number Of Participants</h4>
        </div>
        
        <div class="modal-body" style="height: 400px;">
        	
          	<%-- <table class="table table-bordered table table-striped" id="modalTable">
				<thead>
					<tr>
						<th>Training Target Group</th>
						<th colspan="3">No. of Participants</th>
					</tr>
					<tr>
						<td></td>
						<td>SC</td>
						<td>ST</td>
						<td>Other</td>
					</tr>
				</thead>
				<tbody id="tbodyId">
				<c:choose>
					<c:when test="${not empty fetchTrainingProgressReport}">
					<tr>
						<c:forEach items="${fetchTrainingProgressReport.trainingDetailsProgressReportList}" var="fetchTargetGrp" varStatus="counter">
							<c:forEach items="${fetchTargetGrp.categoriesOfParticipantList}" var="fetchCategryOfPartcpnt" varStatus="index">
							<tr>
								<td>
								<input type="hidden" name="trainingDetailsProgressReportList[0].categoriesOfParticipantList[${index.index}].targetGrpMaster.targetGroupMasterId" id="targetGroup${index.index}" value="${targetGroup.targetGroupMasterId}"/>
									${fetchCategryOfPartcpnt.targetGrpMaster.targetGroupMasterName}
								</td>
								<td><input type="text" name="trainingDetailsProgressReportList[${counter.index}].categoriesOfParticipantList[${index.index}].sc" value="${fetchCategryOfPartcpnt.sc}" id="sc${index.index}" onkeyup='totalParticipants();' class="form-control"/> </td>
								<td><input type="text" name="trainingDetailsProgressReportList[${counter.index}].categoriesOfParticipantList[${index.index}].st" value="${fetchCategryOfPartcpnt.st}" id="st${index.index}" onkeyup='totalParticipants();' class="form-control"/></td>
								<td><input type="text" name="trainingDetailsProgressReportList[${counter.index}].categoriesOfParticipantList[${index.index}].other" value="${fetchCategryOfPartcpnt.other}" id="other${index.index}" onkeyup='totalParticipants();' class="form-control"/></td>
							</tr>
							</c:forEach>
						</c:forEach>
					</tr>
					</c:when>
				
				<c:otherwise>
				
						<c:forEach items="${TARGET_GROUP}" var="targetGroup" varStatus="index">
					<tr>	
							<c:forEach items="${allTrainingActivity.trainingActivityDetailsList}" var="obj" varStatus="counter" >
							<c:forEach items="${allTrainingActivity.trainingActivityDetailsList[1].trainingTargetGroupsList}" var="trgt" varStatus="index">		
								<tr>
									<td>
										<input type="hidden" name="trainingDetailsProgressReportList[${counter.index}].categoriesOfParticipantList[${index.index}].targetGrpMaster.targetGroupMasterId" id="targetGroup${index.index}" value="${trgt.targetGroupMasterId.targetGroupMasterId}"/>
										
											${trgt.targetGroupMasterId.targetGroupMasterName}
										</td>
										<td><input type="text" name="trainingDetailsProgressReportList[${counter.index}].categoriesOfParticipantList[${index.index}].sc" id="sc${index.index}" onkeyup='totalParticipants();' class="form-control"/> </td>
										<td><input type="text" name="trainingDetailsProgressReportList[${counter.index}].categoriesOfParticipantList[${index.index}].st" id="st${index.index}" onkeyup='totalParticipants();' class="form-control"/></td>
										<td><input type="text" name="trainingDetailsProgressReportList[${counter.index}].categoriesOfParticipantList[${index.index}].other" id="other${index.index}" onkeyup='totalParticipants();' class="form-control"/></td>
									</tr>
							</c:forEach>
							
					</tr>
						</c:forEach>
				</c:otherwise>
				</c:choose>	
				</tbody>
			</table> --%>
        </div>
        <div class="modal-footer">
        	<!-- <button type="button" class="btn btn-success" onclick="setData()">Save</button> -->
            <!-- <button type="button" class="btn btn-danger" id="modalBtnId" data-dismiss="modal">Close</button> -->
            <button type="button" class="btn btn-danger" id="modalBtnId"  onclick="hideModal();">Close</button>
        </div>
      </div>
      
    </div>
  </div>






<section class="content"> 
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			
				<div class="card">
					<div class="header">
						<h2>Quarterly Progress Report</h2>
					</div>
					
					<div class="form-group">
    					<label for="sort" class="col-sm-4 control-label"> Quarter Duration </label>
    					<div class="col-sm-4">
			            	<select class="form-control" name="trainingDetailsProgressReportList[0].quarterDuration.qtrId" id="qtrIdDurtn" onchange="getSelelctedQtrRprt();">
			            		<option value="0">Select Duration</option>
			            		<c:choose>
			            			<c:when test="${not empty fetchTrainingProgressReport}">
				            				<c:forEach items="${quarter_duration}" var="duration" varStatus="index">
					            				<c:choose>
						            				<c:when test="${duration.qtrId == fetchTrainingProgressReport.trainingDetailsProgressReportList[index.index].quarterDuration.qtrId}">
					                   					<option value="${duration.qtrId}" selected="selected">${duration.qtrDuration} </option>
					                   				</c:when>
					                   				<c:otherwise>
					                   					<option value="${duration.qtrId}">${duration.qtrDuration} </option>
					                   				</c:otherwise>
				                   				</c:choose>
				                       		</c:forEach>
			            			</c:when>
			            			<c:when test="${not empty SetNewQtrId}">
			            				<c:forEach items="${quarter_duration}" var="duration">
				            				<c:choose>
					            				<c:when test="${duration.qtrId == SetNewQtrId}">
				                   					<option value="${duration.qtrId}" selected="selected">${duration.qtrDuration} </option>
				                   				</c:when>
				                   				<c:otherwise>
				                   					<option value="${duration.qtrId}">${duration.qtrDuration} </option>
				                   				</c:otherwise>
						                   	</c:choose>
					                   	</c:forEach>
			            			</c:when>
			            			<c:otherwise>
			            				<c:forEach items="${quarter_duration}" var="duration">
		                   					<option value="${duration.qtrId}">${duration.qtrDuration} </option>
			                       		</c:forEach>
			            			</c:otherwise>
			            		</c:choose>
                        	</select>
			            </div>
			        </div>
					
				<div class="body">
					<div class="table-responsive">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th rowspan="2" align="center">
											<strong>SI.No.</strong>
									</th>
									<th rowspan="8" align="center">
											<strong>Training Category</strong>
									</th>
									<th rowspan="8" align="center" width="400">
											<strong>Training Subjects</strong>
									</th>
									<th rowspan="2" align="center" width="500">
											<strong>Training Target Group</strong>
									</th>
									<th rowspan="2" align="center">
											<strong>Venue Level</strong>
									</th>
									<th rowspan="2" align="center">
											<strong>Unit Cost</strong>
									</th>
									<th rowspan="2" align="center" width="200">
											<strong>Training Institute</strong>
									</th>
									<th rowspan="2" align="center">
											<strong>No. of Participants</strong>
									</th>
									<th rowspan="2" align="center">
											<strong>No.of Days</strong>
									</th>
									<th rowspan="2" align="center">
											<strong>Expenditure Incurred</strong>
									<input type="hidden" id="qtrIdJsp" name="qtrIdJsp" value=''/>
									</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${approved}">
							<c:choose>
								<c:when test="${not empty fetchTrainingProgressReport}">
										<c:forEach items="${fetchTrainingProgressReport.trainingActivity.trainingActivityDetailsList}" var="obj" varStatus="count">
											<input type="hidden" name="trainingDetailsProgressReportList[${count.index}].trainingActivityDetails.trainingActivityDetailsId" value="${obj.trainingActivityDetailsId}">
											<input type="hidden" name="trainingActivity.trainingActivityId"  value="${fetchTrainingProgressReport.trainingActivity.trainingActivityId}">
											<input type="hidden" name="trainingReportId"  value="${fetchTrainingProgressReport.trainingReportId}">
											<%-- <c:forEach items="${fetchTrainingProgressReport.trainingDetailsProgressReportList[count.index].categoriesOfParticipantList}" var="ctgryPartcpnt" varStatus="index">
												<input type="hidden" name="trainingDetailsProgressReportList[${count.index}].categoriesOfParticipantList[${index.index}].categoriesOfParticipantId"  value="${ctgryPartcpnt.categoriesOfParticipantId}"/>
												<input type="hidden" name="trainingDetailsProgressReportList[${count.index}].categoriesOfParticipantList[${index.index}].targetGrpMaster.targetGroupMasterId"  value="${ctgryPartcpnt.targetGrpMaster.targetGroupMasterId}"/>
											</c:forEach> --%>
											<input type="hidden" name="trainingDetailsProgressReportList[${count.index}].trainingDetailsReportId"  value="${fetchTrainingProgressReport.trainingDetailsProgressReportList[count.index].trainingDetailsReportId}">
											
										<tr>
										<td>${count.count}</td>
										<td>${obj.trainingCategoryId.trainingCategoryName}</td>
										<td><select class="form-control" id="subjectId"  multiple="multiple" disabled="disabled">
												<c:forEach items="${obj.trainingSubjectsList}" var="subj" >
													<option >${subj.trngSubjectId.subjectName} </option>
												</c:forEach>
											</select>
										</td>
		                                <td>
		                                	<select class="form-control" id="targetGroupId" multiple="multiple" disabled="disabled">
				                                  		<c:forEach items="${obj.trainingTargetGroupsList}" var="trgt" >
				                               				<option value="${trgt.targetGroupMasterId.targetGroupMasterId}" >${trgt.targetGroupMasterId.targetGroupMasterName} </option>
				                                   		</c:forEach>
		                               		</select>
		                                </td>
										<td>${obj.trainingVenueLevelId.trainingVenueLevelName}</td>
										<td>${obj.unitCost}</td>
										<td>
											<%-- <select class="form-control" id="instituteId_${count.index}" onchange="instituteOther(${count.index});" name="trainingDetailsProgressReportList[${count.index}].trainingInstituteId">
		                                  		<c:forEach items="${trainingInstituteList}" var="trainingInstituteList">
			                                  		<c:choose>
			                                  				<c:when test="${(trainingInstituteList.instituteLevel.trainingInstituteLevelId eq obj.trainingVenueLevelId.trainingVenueLevelId) && (trainingInstituteList.trainingInstitueTypeId eq fetchTrainingProgressReport.trainingDetailsProgressReportList[count.index].trainingInstituteId)}">
				                               					<option value="${trainingInstituteList.trainingInstitueTypeId}" selected="selected">${trainingInstituteList.trainingInstitueTypeName} </option>
				                               						<c:if test="${not empty fetchTrainingProgressReport.trainingDetailsProgressReportList[count.index].trainingInstituteName && fn:containsIgnoreCase(trainingInstituteList.trainingInstitueTypeName, 'other')}">
						                               					<input style="display: " type="text" class="form-control" id="institueTypeNameId_${count.index}" name="trainingDetailsProgressReportList[${count.index}].trainingInstituteName" value="${fetchTrainingProgressReport.trainingDetailsProgressReportList[count.index].trainingInstituteName}">
						                               				</c:if>
				                               				</c:when>
				                               				<c:when test="${(trainingInstituteList.instituteLevel.trainingInstituteLevelId eq obj.trainingVenueLevelId.trainingVenueLevelId) && (trainingInstituteList.trainingInstitueTypeId != fetchTrainingProgressReport.trainingDetailsProgressReportList[count.index].trainingInstituteId)}">
				                               					<option value="${trainingInstituteList.trainingInstitueTypeId}">${trainingInstituteList.trainingInstitueTypeName} </option>
				                               				</c:when>
				                               				
				                               		</c:choose>
		                                   		</c:forEach>
		                               		</select> --%>
		                               		<select class="form-control">
		                               			<option value="0">Other</option>
		                               		</select>
		                               		<input type="text" class="form-control" id="institueTypeNameId_${count.index}" name="trainingDetailsProgressReportList[${count.index}].trainingInstituteName" value="${fetchTrainingProgressReport.trainingDetailsProgressReportList[count.index].trainingInstituteName}">
		                               		
										</td>
										<td>
										<input type="text" class="form-control" id="totalParticipantsId" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" name="trainingDetailsProgressReportList[${count.index}].noOfParticipants" value="${fetchTrainingProgressReport.trainingDetailsProgressReportList[count.index].noOfParticipants}">
										<button type="button" class="btn btn-info btn-sm" style="background-color:#661a74"   data-toggle="modal" data-target="#participantsBreak">Break</button>
										<%-- <table class="table table-bordered table table-striped" id="hidetable_${count.index}" style="display: none;">
													<thead>
														<tr>
															<th>Training Target Group</th>
															<th colspan="3">No. of Participants</th>
														</tr>
														<tr>
															<td></td>
															<td>SC</td>
															<td>ST</td>
															<td>Other</td>
														</tr>
													</thead>
											<tbody>
											<c:forEach items="${obj.trainingTargetGroupsList}" var="trgt" varStatus="index">
												<tr>
													<td>
														${trgt.targetGroupMasterId.targetGroupMasterName}
													</td>
													<td><input type="text" id="sc_${count.index}_${index.index}" onkeyup="setSc('${count.index}','${index.index}')" name="trainingDetailsProgressReportList[${count.index}].categoriesOfParticipantList[${index.index}].sc"   value="" class="form-control setValue"/> </td>
													<td><input type="text" id="st_${count.index}_${index.index}" onkeyup="setSt('${count.index}','${index.index}')" name="trainingDetailsProgressReportList[${count.index}].categoriesOfParticipantList[${index.index}].st"  value="" class="form-control setValue"/></td>
													<td><input type="text" id="other_${count.index}_${index.index}" onkeyup="setOther('${count.index}','${index.index}')" name="trainingDetailsProgressReportList[${count.index}].categoriesOfParticipantList[${index.index}].other"   value="" class="form-control setValue"/></td>
													
													<td><input type="text" name="trainingDetailsProgressReportList[${count.index}].categoriesOfParticipantList[${index.index}].sc" value="${fetchTrainingProgressReport.trainingDetailsProgressReportList[count.index].categoriesOfParticipantList[index.index].sc}" id="sc${index.index}" onkeyup='totalParticipants();' class="form-control"/> </td>
													<td><input type="text" name="trainingDetailsProgressReportList[${count.index}].categoriesOfParticipantList[${index.index}].st" value="${fetchTrainingProgressReport.trainingDetailsProgressReportList[count.index].categoriesOfParticipantList[index.index].st}" id="st${index.index}" onkeyup='totalParticipants();' class="form-control"/></td>
													<td><input type="text" name="trainingDetailsProgressReportList[${count.index}].categoriesOfParticipantList[${index.index}].other" value="${fetchTrainingProgressReport.trainingDetailsProgressReportList[count.index].categoriesOfParticipantList[index.index].other}" id="other${index.index}" onkeyup='totalParticipants();' class="form-control"/></td>
												</tr>
												</c:forEach>
											</tbody>
											</table> --%>
										</td>
										<td><input type="text" class="form-control" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="${fetchTrainingProgressReport.trainingDetailsProgressReportList[count.index].noOfDays}" name="trainingDetailsProgressReportList[${count.index}].noOfDays"> <%-- ${obj.noOfDays} --%></td>
										
										<%-- <td>${obj.funds}</td> --%>
										<td><input type="text" class="form-control" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="${fetchTrainingProgressReport.trainingDetailsProgressReportList[count.index].fundsIncurred}" name="trainingDetailsProgressReportList[${count.index}].fundsIncurred"> </td>
										</tr>
										</c:forEach>
								</c:when>
								<c:otherwise>
										<c:forEach items="${allTrainingActivity.trainingActivityDetailsList}" var="obj" varStatus="count">
											<input type="hidden" name="trainingDetailsProgressReportList[${count.index}].trainingActivityDetails.trainingActivityDetailsId" value="${obj.trainingActivityDetailsId}">
											<input type="hidden" name="trainingActivity.trainingActivityId"  value="${allTrainingActivity.trainingActivityId}">
											<input type="hidden" name="trainingReportId"  value="${trainingReportIdFromDb}">
										<tr>	
										<td>${count.count}</td>
										<td>${obj.trainingCategoryId.trainingCategoryName}</td>
										<td><select class="form-control" id="subjectId"  multiple="multiple" disabled="disabled">
												<c:forEach items="${obj.trainingSubjectsList}" var="subj" >
													<option >${subj.trngSubjectId.subjectName} </option>
												</c:forEach>
											</select>
										</td>
		                                <td>
		                                	<select class="form-control" id="targetGroupId" multiple="multiple" disabled="disabled">
		                                  		<c:forEach items="${obj.trainingTargetGroupsList}" var="trgt" >
		                               				<option value="${trgt.targetGroupMasterId.targetGroupMasterId}" >${trgt.targetGroupMasterId.targetGroupMasterName} </option>
		                                   		</c:forEach>
		                               		</select>
		                                </td>
										<td>${obj.trainingVenueLevelId.trainingVenueLevelName}</td>
										<td>${obj.unitCost}</td>
										<td>
											<%-- <select class="form-control" onchange="instituteOther(${count.index});" name="trainingDetailsProgressReportList[${count.index}].trainingInstituteId">
		                                  		<c:forEach items="${trainingInstituteList}" var="trainingInstituteList">
		                                  		<c:if test="${trainingInstituteList.instituteLevel.trainingInstituteLevelId eq obj.trainingVenueLevelId.trainingVenueLevelId}">
		                               				<option value="${trainingInstituteList.trainingInstitueTypeId}">${trainingInstituteList.trainingInstitueTypeName} </option>
		                               			</c:if>
		                                   		</c:forEach>
		                               		</select> --%>
		                               		<select class="form-control">
		                               			<option value="0">Other</option>
		                               		</select>
		                               		<input type="text" class="form-control" id="institueTypeNameId_${count.index}" name="trainingDetailsProgressReportList[${count.index}].trainingInstituteName">
										</td>
										<td>
											<input type="text" class="form-control" id="totalParticipantsId" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" name="trainingDetailsProgressReportList[${count.index}].noOfParticipants">
											<button type="button" class="btn btn-info btn-sm" style="background-color:#661a74"  data-toggle="modal"  data-attr="row_1" data-target="#participantsBreak">Break</button>
											<%-- <table class="table table-bordered table table-striped" id="hidetable_${count.index}" style="display: none;">
													<thead>
														<tr>
															<th>Training Target Group</th>
															<th colspan="3">No. of Participants</th>
														</tr>
														<tr>
															<td></td>
															<td>SC</td>
															<td>ST</td>
															<td>Other</td>
														</tr>
													</thead>
											<tbody>
											<c:forEach items="${obj.trainingTargetGroupsList}" var="trgt" varStatus="index">
												<tr>
													<td>
														<input type="hidden" name="trainingDetailsProgressReportList[${count.index}].categoriesOfParticipantList[${index.index}].targetGrpMaster.targetGroupMasterId" id="targetGroup${index.index}" value="${trgt.targetGroupMasterId.targetGroupMasterId}"/>
														${trgt.targetGroupMasterId.targetGroupMasterName}
													</td>
													<td><input type="text" id="sc_${count.index}_${index.index}" onkeyup="setSc('${count.index}','${index.index}')" name="trainingDetailsProgressReportList[${count.index}].categoriesOfParticipantList[${index.index}].sc"   value="" class="form-control setValue"/> </td>
													<td><input type="text" id="st_${count.index}_${index.index}" onkeyup="setSt('${count.index}','${index.index}')" name="trainingDetailsProgressReportList[${count.index}].categoriesOfParticipantList[${index.index}].st"  value="" class="form-control setValue"/></td>
													<td><input type="text" id="other_${count.index}_${index.index}" onkeyup="setOther('${count.index}','${index.index}')" name="trainingDetailsProgressReportList[${count.index}].categoriesOfParticipantList[${index.index}].other"   value="" class="form-control setValue"/></td>
												</tr>
												</c:forEach>
											</tbody>
											</table> --%>
										</td>
										<td><input type="text" class="form-control" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" name="trainingDetailsProgressReportList[${count.index}].noOfDays"></td>
										<td><input type="text" class="form-control" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" name="trainingDetailsProgressReportList[${count.index}].fundsIncurred"> </td>
										</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:if test="${!approved}">
								<div class="alert alert-danger">
	  								<strong>Danger!</strong> There is no training .
								</div>
							</c:if>
								
							</tbody>

						</table>
						</div>
						<div class="text-right">
							<!-- <button  type="submit" ng-click="saveData('S')" class="btn bg-green waves-effect">SAVE</button> -->
							<button  type="submit" onclick="validateForm();" class="btn bg-green waves-effect">SAVE</button>
							<!-- <button type="button"  ng-click="claerAll()" class="btn bg-light-blue waves-effect">CLEAR</button> -->
							<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"class="btn bg-orange waves-effect">CLOSE</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
</form>

</body>
</html>
<script>
	/* function SetListCount(listNo){
		 $("#showBreakUp").val(listNo);
		 $(".modal-body").html($("#hidetable_"+listNo).show());
	} */
	
	//on opening of the modal
	
	 $('.btn-sm').on('click',function(){
		var elm=$(this);
		var attr=elm.attr('data-attr');
		$('#modalBtnId').attr('data-attr',attr);
		$(".modal-body").html(elm.closest('tr').find(".table-striped").html());
		/* $(".modal-body tbody tr").find('td').each(function(){
			$(this).children().val($(this).children().attr('data-attr'));
		}); */
	});
	
	//on closing of the modal
	$('#modalBtnId').on('click',function(){
		var elm=$(this);
		var count=0;
		var arr = new Array();
		var attr=elm.attr('data-attr').substring(4);
		$('#hidetable_'+(parseInt(attr)-1) +' tbody').html($(".modal-body").find('tbody').html());
		/* $(".modal-body tbody tr").find('td').each(function(){
			arr.push($(this).children().val());
		});
		$('#hidetable_'+(parseInt(attr)-1) +' tbody tr').find('td').each(function(){console.log("arr[count]"+arr[count]);
			$(this).children().attr('data-attr',arr[count]);
			count++;
		});  */
		//alert($(".modal-body").find('tbody').html());
	});
</script>