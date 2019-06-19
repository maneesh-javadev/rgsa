<%@include file="../taglib/taglib.jsp"%>
<script>
$('document').ready(function(){
	var total_participants = +'${HUN_DAY_TRAINING_DETAIL.noOfParticipantsSC}'  + +'${HUN_DAY_TRAINING_DETAIL.noOfParticipantsST}' + +'${HUN_DAY_TRAINING_DETAIL.noOfParticipantsWomen}' + +'${HUN_DAY_TRAINING_DETAIL.noOfParticipantsOthers}';
	(total_participants == 0) ?  $('#totalNumberOfParticipantsId').val('') : $('#totalNumberOfParticipantsId').val(total_participants);
	ableBreakFields();
});

function ableBreakFields(){
	if($('#totalNumberOfParticipantsId').val() != ''){
		$('.break-down').prop('disabled',false);
		$('.break-down').prop('required',true);
	}else{
		$('.break-down').prop('disabled',true);
		$('.break-down').prop('required',false);
	}
}

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
						action="trainingDetailHundredDay.html" modelAttribute="HUN_DAY_TRAINING_DETAIL">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="trainingDetailHundredDay.html"/>" />
						<div class="body">
							<div class="row clearfix">
								<div class="col-sm-6">
									<label for="selectCategory">Number of trainings conducted</label>
									<div class="form-group">
										<div class="form-line">
											<form:input path="noOfTrainingsConducted" id="noOfTrainingConductedId" class="form-control Align-Right" onkeypress="return isNumber(event)" readonly="${HUN_DAY_TRAINING_DETAIL.isFreeze}"/>
										</div>
									</div>
								</div>
								<div class="col-sm-6">
									<label for="trainingSubject">Number of participants</label>
									<div class="form-group">
										<div class="form-line">
											<form:input path="" class="form-control Align-Right" id="totalNumberOfParticipantsId" onkeyup="ableBreakFields()" onkeypress="return isNumber(event)" readonly="${HUN_DAY_TRAINING_DETAIL.isFreeze}"/>
										</div>
										<!-- <div align="right" style="margin-top: 5px; display: none;"><span id="plusId"><button class="btn btn-primary btn-md" type="button" onclick="showBreakDownDiv()">Expand</button> </span>
											<span style="display: none;" id="minusId"><button class="btn btn-danger btn-md" type="button" onclick="hideBreakDownDiv()">Hide</button></span></div> -->
										
									</div>
								</div>
							</div>
							<!-- <div id="breakDownFieldsId" style="display: none;"> -->
							<div class="row clearfix">
								<div class="col-sm-6">
									<label for="scPacticipants">Number of SC participants</label>
									<div class="form-group">
										<div class="form-line">
											<form:input path="noOfParticipantsSC" id="noOfParticipantsSCId" class="form-control break-down Align-Right" onkeyup="validateWithTotalParticipants(this.id)" onkeypress="return isNumber(event)" disabled="true" readonly="${HUN_DAY_TRAINING_DETAIL.isFreeze}"/>
										</div>
									</div>
								</div>
								<div class="col-sm-6">
									<label for="stPacticipants">Number of ST participants</label>
									<div class="form-group">
										<div class="form-line">
											<form:input path="noOfParticipantsST" class="form-control break-down Align-Right" id="noOfParticipantsSTId" onkeyup="validateWithTotalParticipants(this.id)" onkeypress="return isNumber(event)" disabled="true" readonly="${HUN_DAY_TRAINING_DETAIL.isFreeze}"/>
										</div>
									</div>
								</div>
							</div>
							<div class="row clearfix">
								<div class="col-sm-6">
									<label for="womenPacticipants">Number of Women participants</label>
									<div class="form-group">
										<div class="form-line">
											<form:input path="noOfParticipantsWomen" id="noOfParticipantsWomenId" class="form-control break-down Align-Right" onkeyup="validateWithTotalParticipants(this.id)" onkeypress="return isNumber(event)" disabled="true" readonly="${HUN_DAY_TRAINING_DETAIL.isFreeze}"/>
										</div>
									</div>
								</div>
								<div class="col-sm-6">
									<label for="otherPacticipants">Number of Other participants</label>
									<div class="form-group">
										<div class="form-line">
											<form:input path="noOfParticipantsOthers" class="form-control break-down Align-Right" id="noOfParticipantsOthersId" onkeyup="validateWithTotalParticipants(this.id)" onkeypress="return isNumber(event)" disabled="true" readonly="${HUN_DAY_TRAINING_DETAIL.isFreeze}"/>
										</div>
									</div>
								</div>
							</div>
							</div>
							<div class="form-group text-right" style="padding-bottom: 5px;">
								<button type="submit" class="btn bg-green waves-effect"><c:choose><c:when test="${UPDATE_OR_SAVE eq 'update'}">UPDATE</c:when><c:otherwise>SAVE</c:otherwise> </c:choose></button>
								<c:choose>
								<c:when test="${HUN_DAY_TRAINING_DETAIL.isFreeze eq true}">
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
							
						<!-- </div> -->
						
						<!-- HIDDEN FIELDS -->
						<input type="hidden" name="id" value="${ID}" />
						<input type="hidden" name="isFreeze" id="isFreezeId" value="${HUN_DAY_TRAINING_DETAIL.isFreeze}" />
						<input type="hidden" name="msg" id="msgId" value="" />
						<!-- HIDDEN FIELDS ENDS HERE -->
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
<style>
.Align-Right{
			text-align: right;
}</style>