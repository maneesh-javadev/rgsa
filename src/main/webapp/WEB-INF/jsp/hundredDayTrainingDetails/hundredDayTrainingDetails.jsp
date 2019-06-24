<%@include file="../taglib/taglib.jsp"%>
<script>
$('document').ready(function(){
	var totalRecords = +$('#noOfTargetMaster').val();
	var totalPopulationMale = 0;
	var totalPopulationFemale = 0;
	for(var i=0;i<totalRecords;i++){
		$('#totalMale_'+i).val( +$('#scMale_'+i).val() + +$('#stMale_'+i).val() + +$('#othersMale_'+i).val());
		$('#totalFemale_'+i).val( +$('#scFemale_'+i).val() + +$('#stFemale_'+i).val() + +$('#othersFemale_'+i).val());
		
		totalPopulationMale += +$('#totalMale_'+i).val();
		totalPopulationFemale += +$('#totalFemale_'+i).val();
	}
	$('#totalParticipantsId').val(totalPopulationMale + totalPopulationFemale);
});

/* function ableBreakFields(){
	if($('#totalNumberOfParticipantsId').val() != ''){
		$('.break-down').prop('disabled',false);
		$('.break-down').prop('required',true);
	}else{
		$('.break-down').prop('disabled',true);
		$('.break-down').prop('required',false);
	}
} */

/* function showBreakDownDiv(){
	$('#plusId').hide();
	$('#breakDownFieldsId').show();
	$('#minusId').show();
}

function hideBreakDownDiv(){
	$('#minusId').hide();
	$('#breakDownFieldsId').hide();
	$('#plusId').show();
} */

function validateWithTotalParticipants(id){
	var totalParticipants=$('#totalNumberOfParticipantsId').val();
	totalBreakParticipants= +$('#noOfParticipantsSCId').val() + +$('#noOfParticipantsSTId').val() + +$('#noOfParticipantsWomenId').val() + +$('#noOfParticipantsOthersId').val();
	if(totalParticipants != ''){
		if(totalBreakParticipants > totalParticipants){
			alert('Sum of SC, ST, Women and other should not exceed total participants.')
			$('#'+id).val('');
			$('#'+id).focus();
		}
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

function freezeUnfreeze(msg){
	 if(msg == 'freeze') {
		 $('#isFreezeId').val(true) ;
		 $('#msgId').val('freeze') 
	 }else{
		  $('#isFreezeId').val(false);
	 	$('#msgId').val('unfreeze') ;
	 }
	document.trainingDetailHundredDay.method = "post";
	document.trainingDetailHundredDay.action = "trainingDetailHundredDay.html?<csrf:token uri='trainingDetailHundredDay.html'/>";
	document.trainingDetailHundredDay.submit();
}

function getTotalForEachRow(id){
	$('#totalMale_'+id).val( +$('#scMale_'+id).val() + +$('#stMale_'+id).val() + +$('#othersMale_'+id).val());
	$('#totalFemale_'+id).val( +$('#scFemale_'+id).val() + +$('#stFemale_'+id).val() + +$('#othersFemale_'+id).val());
	calTotalNumberOfParticipants();
}

function calTotalNumberOfParticipants(){
	var totalRecords = +$('#noOfTargetMaster').val();
	var totalPopulationMale = 0;
	var totalPopulationFemale = 0;
	for(var i=0;i<totalRecords;i++){
		totalPopulationMale += +$('#totalMale_'+i).val();
		totalPopulationFemale += +$('#totalFemale_'+i).val();
	}
	
	$('#totalParticipantsId').val(totalPopulationMale + totalPopulationFemale);
}
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Training Detail" htmlEscape="true" />
						</h2>
					</div>
					<form:form method="post" id="trainingDetailId" name="trainingDetailHundredDay"
						action="trainingDetailHundredDay.html" modelAttribute="HUN_DAY_TRAINING">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="trainingDetailHundredDay.html"/>" />
							<c:set var="noOfTargetMaster" value="0"></c:set>
						<div class="body">
							<div class="row clearfix">
								<div class="col-sm-3">
										<label for="noOfTrainingConducted">Number of trainings conducted :</label>
								</div>
								<div class="col-sm-4">		
									<div class="form-group">
										<div class="form-line">
											<form:input path="noOfTrainingConducted" id="noOfTrainingConductedId" class="form-control Align-Right" onkeypress="return isNumber(event)"  readonly="${HUN_DAY_TRAINING.isFreeze}"/>
										</div>
									</div>
								</div>
							</div>
							
							<div class="row clearfix">
								<div class="col-sm-2">
										<label for="weekDuration">State date of training :</label>
								</div>
								<div class="col-sm-4">		
									<div class="form-group">
										<div class="form-line">
											<input type="date" id="dateFormId" class="form-control" readonly="${HUN_DAY_TRAINING.isFreeze}"/>
										</div>
									</div>
								</div>
								
								<div class="col-sm-2">
										<label for="weekDuration">End date of training :</label>
								</div>
								<div class="col-sm-4">		
									<div class="form-group">
										<div class="form-line">
											<input type="date"  id="dateToId" class="form-control" readonly="${HUN_DAY_TRAINING.isFreeze}"/>
										</div>
									</div>
								</div>
							</div>
							
							<div class="table-responsive">
								<table class="table-bordered table-hover">
									<thead style="background-color: #ef7b7b;color: white;">
										<tr>
											<th rowspan="3"><div align="center"><strong>S.No.</strong></div></th>
											<th rowspan="3"><div align="center"><strong>Target Group</strong></div></th>
											<th colspan="8"><div align="center"><strong>Number Of Participants</strong></div></th>										
										</tr>
										
										<tr>
											<th colspan="4"><div align="center"><strong>Males</strong></div></th>
											<th colspan="4"><div align="center"><strong>Females</strong></div></th>
										</tr>
										<tr>
											<th><div align="center"><strong>SC</strong></div></th>
											<th><div align="center"><strong>ST</strong></div></th>
											<th><div align="center"><strong>Others</strong></div></th>
											<th><div align="center"><strong>Total</strong></div></th>
											<th><div align="center"><strong>SC</strong></div></th>
											<th><div align="center"><strong>ST</strong></div></th>
											<th><div align="center"><strong>Others</strong></div></th>
											<th><div align="center"><strong>Total</strong></div></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${TARGET_GROUP_MASTER}" var="targetMaster" varStatus="index">
										<!-- hidden fields -->
										<input type="hidden" name="trgDetailsOfHundredDaysProgram[${index.index}].trgDetailsOfHundredDaysProgramId" value="${HUN_DAY_TRAINING.trgDetailsOfHundredDaysProgram[index.index].trgDetailsOfHundredDaysProgramId}">
										<input type="hidden" name="trgDetailsOfHundredDaysProgram[${index.index}].targetGroupMasterId" value="${targetMaster.targetGroupMasterId}">
										<tr>
										<td><div align="center"><strong>${index.count}</strong></div></td>
										<td><div align="center"><strong>${targetMaster.targetGroupMasterName}</strong></div></td>
										<td><form:input path="trgDetailsOfHundredDaysProgram[${index.index}].maleSC" class="form-control Align-Right" readonly="${HUN_DAY_TRAINING.isFreeze}" title="SC Male" onkeypress="return isNumber(event)" id="scMale_${index.index}" onkeyup="getTotalForEachRow(${index.index})"/></td>
										<td><form:input path="trgDetailsOfHundredDaysProgram[${index.index}].maleST" class="form-control Align-Right" readonly="${HUN_DAY_TRAINING.isFreeze}" title="ST Male" onkeypress="return isNumber(event)" id="stMale_${index.index}" onkeyup="getTotalForEachRow(${index.index})"/></td>
										<td><form:input path="trgDetailsOfHundredDaysProgram[${index.index}].maleOthers" class="form-control Align-Right" readonly="${HUN_DAY_TRAINING.isFreeze}" title="Others Male" onkeypress="return isNumber(event)" id="othersMale_${index.index}" onkeyup="getTotalForEachRow(${index.index})"/></td>
										<td><form:input path="" class="form-control Align-Right" disabled="true" id="totalMale_${index.index}"/></td>
										<td><form:input path="trgDetailsOfHundredDaysProgram[${index.index}].femaleSC" class="form-control Align-Right" readonly="${HUN_DAY_TRAINING.isFreeze}" title="SC Female" onkeypress="return isNumber(event)" id="scFemale_${index.index}" onkeyup="getTotalForEachRow(${index.index})"/></td>
										<td><form:input path="trgDetailsOfHundredDaysProgram[${index.index}].femaleST" class="form-control Align-Right" readonly="${HUN_DAY_TRAINING.isFreeze}" title="ST Female" onkeypress="return isNumber(event)" id="stFemale_${index.index}" onkeyup="getTotalForEachRow(${index.index})"/></td>
										<td><form:input path="trgDetailsOfHundredDaysProgram[${index.index}].femaleOthers" class="form-control Align-Right" readonly="${HUN_DAY_TRAINING.isFreeze}" title="Others Female" onkeypress="return isNumber(event)" id="othersFemale_${index.index}" onkeyup="getTotalForEachRow(${index.index})"/></td>
										<td><form:input path="" class="form-control Align-Right" disabled="true" id="totalFemale_${index.index}"/></td>
										</tr>
										<c:set var="noOfTargetMaster" value="${noOfTargetMaster + 1}"></c:set>
										</c:forEach>
										
										<tr>
										<th colspan="7"><div align="left"><strong>Total Participants :</strong></div></th>
										<td colspan="3"><form:input path="" class="form-control Align-Right" disabled="true" id="totalParticipantsId"/></td>
										</tr>
									</tbody>
								</table>
							</div>
							</div>
							<div class="form-group text-right" style="padding-bottom: 5px;">
								<button type="submit" class="btn bg-green waves-effect"><c:choose><c:when test="${UPDATE_OR_SAVE eq 'update'}">UPDATE</c:when><c:otherwise>SAVE</c:otherwise> </c:choose></button>
								<c:choose>
								<c:when test="${HUN_DAY_TRAINING.isFreeze eq true}">
								<button type="button" onclick="freezeUnfreeze('unfreeze')"
									class="btn bg-blue waves-effect">UNFREEZE</button>
								</c:when>
								<c:otherwise>
								<c:if test="${UPDATE_OR_SAVE eq 'update'}">
								<button type="button" onclick="freezeUnfreeze('freeze')"
									class="btn bg-blue waves-effect">FREEZE</button>
								</c:if>
								<c:if test="${UPDATE_OR_SAVE eq 'save'}">
										<button type="button" onclick="freezeUnfreeze('freeze')"
											class="btn bg-blue waves-effect" disabled="disabled" >FREEZE</button>
								</c:if>
								</c:otherwise>
								</c:choose>
								<button type="button" onclick="onClear(this)"
									class="btn bg-light-blue waves-effect">CLEAR</button>
								<button type="button"
									onclick="onClose('managesubjects.html?<csrf:token uri='managesubjects.html'/>')"
									class="btn bg-orange waves-effect">CLOSE</button>&nbsp;
							</div>
							<!-- HIDDEN FIELDS -->
								<input type="hidden" name="trgOfHundredDaysProgramId" value="${HUN_DAY_TRAINING.trgOfHundredDaysProgramId}" />
								<input type="hidden" name="isFreeze" id="isFreezeId" value="${HUN_DAY_TRAINING.isFreeze}" />
								<input type="hidden" name="msg" id="msgId" value="" />
								<input type="hidden" id="noOfTargetMaster" value="${noOfTargetMaster}" />
							<!-- HIDDEN FIELDS ENDS HERE -->
						</form:form>
						</div> 
				</div>
			</div>
		</div>
	</div>
</section>
<style>
.Align-Right{
			text-align: right;
}</style>