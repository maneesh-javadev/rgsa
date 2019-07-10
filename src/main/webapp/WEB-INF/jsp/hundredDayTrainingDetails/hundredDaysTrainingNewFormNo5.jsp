<%@include file="../taglib/taglib.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/datepicker/css/bootstrap-datetimepicker.min.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/datepicker/js/bootstrap-datetimepicker.min.js"></script>
<script>
var startDate = '${HUN_DAY_TRAINING.demoDate}';
$('document').ready(function(){
	if(startDate != ''){
		$('#mainDivId').show();
	}
	calMaleSar();
	calFemaleSar();
	calOtherErMale();
	calOtherErFemale();
	calFunMale();
	calFunFemale();
	calGrandTotalFields();
	calAspDistrictTotal()
});

	$(function() {
		$("#bstartDate").datetimepicker({
			format : 'dd-mm-yyyy',
			startView : 'month',
			endDate : '+100d',
			autoclose : true,
			minView : 'month',
			startDate : '01/06/2019',
			pickerPosition : "bottom-left",
			endDate : '08/09/2019'
		});
	});
	
function calMaleSar(){
	$('#totalMaleSarpanch').val(+$('#sarpanchMaleScId').val() + +$('#sarpanchMaleStId').val() + +$('#sarpanchMaleOthersId').val());
	calGrandTotalFields()
	
}
	
function calFemaleSar(){
	$('#totalFemaleSarpanch').val(+$('#sarpanchFemaleScId').val() + +$('#sarpanchFemaleStId').val() + +$('#sarpanchFemaleOthersId').val());	
	calGrandTotalFields()
}
	
function calOtherErMale(){
	$('#totalMaleOtherEr').val(+$('#otherErMaleScId').val() + +$('#otherErMaleStId').val() + +$('#otherErMaleOthersId').val());
	calGrandTotalFields()
}

function calOtherErFemale(){
	$('#totalFemaleOtherEr').val(+$('#otherErFemaleScId').val() + +$('#otherErFemaleStId').val() + +$('#otherErFemaleOthersId').val());
	calGrandTotalFields()
}

function calFunMale(){
	$('#totalMaleFunctionaries').val(+$('#functionariedMaleScId').val() + +$('#functionariedMaleStId').val() + +$('#functionariedMaleOthersId').val());
	calGrandTotalFields()
}

function calFunFemale(){
	$('#totalFemaleFunctionaries').val(+$('#functionariedFemaleScId').val() + +$('#functionariedFemaleStId').val() + +$('#functionariedFemaleOthersId').val());
	calGrandTotalFields()
}

function calGrandTotalFields(){
	$('#totalMaleId').val(+$('#totalMaleSarpanch').val() + +$('#totalMaleOtherEr').val() + +$('#totalMaleFunctionaries').val());
	$('#totalFemaleId').val(+$('#totalFemaleSarpanch').val() + +$('#totalFemaleOtherEr').val() + +$('#totalFemaleFunctionaries').val());
	$('#totalParticipantsId').val(+$('#totalMaleId').val() + +$('#totalFemaleId').val());
}

function validateAsprirationalData(){
	if(+$('#noOfTrainingConductedId').val() < +$('#noOfTrainingConductedAspDistId').val()){
		alert('value should not exceed ' + +$('#noOfTrainingConductedId').val() );
		$('#noOfTrainingConductedAspDistId').val('');
	}
	
	var totalEr = +$('#totalMaleSarpanch').val() + +$('#totalFemaleSarpanch').val() + +$('#totalMaleOtherEr').val() + +$('#totalFemaleOtherEr').val(); 
	
	var totalFun = +$('#totalMaleFunctionaries').val() + +$('#totalFemaleFunctionaries').val();
	
	if(totalEr < +$('#electativeRepresentativeInAspDistrictId').val()){
		alert('value should not exceed ' + totalEr);
		$('#electativeRepresentativeInAspDistrictId').val('');
		}
		
	if(totalFun < +$('#funcAndStakeHolderInAspDistrictId').val()){
		alert('value should not exceed ' + totalFun );
		$('#funcAndStakeHolderInAspDistrictId').val('');
	}
	
	calAspDistrictTotal()
}

function calAspDistrictTotal(){
	$('#totalParticipantsAspDistId').val(+$('#electativeRepresentativeInAspDistrictId').val() + +$('#funcAndStakeHolderInAspDistrictId').val());
}

function fetchDataByDate(){
	$('#msgId').val('fetch'); 
	document.trainingDetailHundredDay.method = "post";
	document.trainingDetailHundredDay.action = "trainingDetailHundredDay.html?<csrf:token uri='trainingDetailHundredDay.html'/>";
	document.trainingDetailHundredDay.submit();
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
							<%-- <spring:message code="Training Detail" htmlEscape="true" /> --%>Training Details
						</h2>
					</div>
					<form:form method="post" id="trainingDetailId"
						name="trainingDetailHundredDay"
						action="trainingDetailHundredDay.html"
						modelAttribute="HUN_DAY_TRAINING">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="trainingDetailHundredDay.html"/>" />
						<div class="body">
							<div class="row clearfix">
								<div class="col-sm-3">
									<label for="trainingStartDate"> Training Start Date :</label>
								</div>
								<div class="col-xs-4">
									<div class="form-line">
										<div class="input-group date datepicker" id="bstartDate">
											<form:input path="demoDate" class="form-control" id="startDate"
												onchange="fetchDataByDate();"
												readonly="${HUN_DAY_TRAINING.isFreeze}" />
											<span class="input-group-addon"><span
												class="glyphicon glyphicon-calendar"></span></span>
										</div>
									</div>
								</div>
							</div>
						<div id="mainDivId" style="display: none;">
							<div class="row clearfix">
								<div class="col-sm-2">
									<label for="NoOfTrainingConducted"> Number of trainings
										Conducted :</label>
								</div>
								<div class="col-sm-4">
									<div class="form-group">
										<div class="form-line">
											<form:input path="noOfTrainingConducted" id="noOfTrainingConductedId"
												class="form-control Align-Right"
												onkeypress="return isNumber(event)"
												readonly="${HUN_DAY_TRAINING.isFreeze}" required="true"/>
										</div>
									</div>
								</div>
								
								<div class="col-sm-2">
									<label for="NoOfTrainingConducted"> Number of trainings
										Conducted in Aspirational District :</label>
								</div>
								<div class="col-sm-4">
									<div class="form-group">
										<div class="form-line">
											<form:input path="noOfTrainingConductedAspDistrict" id="noOfTrainingConductedAspDistId"
												class="form-control Align-Right"
												onkeypress="return isNumber(event)"
												onkeyup="validateAsprirationalData()"
												readonly="${HUN_DAY_TRAINING.isFreeze}" required="true"/>
										</div>
									</div>
								</div>
							</div>
							
							<div class="table-responsive">
								<table class="table table-bordered table-hover">
									<thead>
										<tr>
											<th rowspan="3" style="padding-bottom: 4%;"><div align="center"><strong>Participants category</strong></div></th>
											<th colspan="4"><div align="center"><strong>Elected Representatives</strong></div></th>
											<th colspan="2" rowspan="2" style="padding-bottom: 2%;"><div align="center"><strong>Functionaries & other stakeholders</strong></div></th>
										</tr>
										<tr>
											<th colspan="2"><div align="center"><strong>Sarpanch</strong></div></th>
											<th colspan="2"><div align="center"><strong>Other ERs</strong></div></th>
										</tr>
										<tr>
											<th><div align="center"><strong>Male</strong></div></th>
											<th><div align="center"><strong>Female</strong></div></th>
											<th><div align="center"><strong>Male</strong></div></th>
											<th><div align="center"><strong>Female</strong></div></th>
											<th><div align="center"><strong>Male</strong></div></th>
											<th><div align="center"><strong>Female</strong></div></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><div align="center"><strong>SC</strong></div></td>
											<td><form:input path="erSarMaleSc"  class="form-control Align-Right" id="sarpanchMaleScId" onkeyup="calMaleSar();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}"/></td>
											<td><form:input path="erSarFemaleSc" class="form-control Align-Right" id="sarpanchFemaleScId" onkeyup="calFemaleSar();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="erOtherMaleSc" class="form-control Align-Right" id="otherErMaleScId" onkeyup="calOtherErMale();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="erOtherFemaleSc" class="form-control Align-Right" id="otherErFemaleScId" onkeyup="calOtherErFemale();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="funMaleSc" class="form-control Align-Right" id="functionariedMaleScId" onkeyup="calFunMale();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="funFemaleSc" class="form-control Align-Right" id="functionariedFemaleScId" onkeyup="calFunFemale();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
										</tr>
										<tr>
											<td><div align="center"><strong>ST</strong></div></td>
											<td><form:input path="erSarMaleSt" class="form-control Align-Right" id="sarpanchMaleStId" onkeyup="calMaleSar();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}"/></td>
											<td><form:input path="erSarFemaleSt" class="form-control Align-Right" id="sarpanchFemaleStId" onkeyup="calFemaleSar();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="erOtherMaleSt" class="form-control Align-Right" id="otherErMaleStId" onkeyup="calOtherErMale();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="erOtherFemaleSt" class="form-control Align-Right" id="otherErFemaleStId" onkeyup="calOtherErFemale();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="funMaleSt" class="form-control Align-Right" id="functionariedMaleStId" onkeyup="calFunMale();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="funFemaleSt" class="form-control Align-Right" id="functionariedFemaleStId" onkeyup="calFunFemale();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
										</tr>
										<tr>
											<td><div align="center"><strong>Others</strong></div></td>
											<td><form:input path="erSarMaleOthers" class="form-control Align-Right" id="sarpanchMaleOthersId" onkeyup="calMaleSar();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="erSarFemaleOthers" class="form-control Align-Right" id="sarpanchFemaleOthersId" onkeyup="calFemaleSar();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="erOtherMaleOthers" class="form-control Align-Right" id="otherErMaleOthersId" onkeyup="calOtherErMale();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="erOtherFemaleOthers" class="form-control Align-Right" id="otherErFemaleOthersId" onkeyup="calOtherErFemale();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="funMaleOthers" class="form-control Align-Right" id="functionariedMaleOthersId" onkeyup="calFunMale();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="funFemaleOthers" class="form-control Align-Right " id="functionariedFemaleOthersId" onkeyup="calFunFemale();validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
										</tr>
										<tr>
											<td><div align="center"><strong>Total</strong></div></td>
											<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalMaleSarpanch" onchange="calGrandTotalFields()"/></td>
											<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalFemaleSarpanch" onchange="calGrandTotalFields()"/></td>
											<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalMaleOtherEr" onchange="calGrandTotalFields()"/></td>
											<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalFemaleOtherEr" onchange="calGrandTotalFields()"/></td>
											<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalMaleFunctionaries" onchange="calGrandTotalFields()"/></td>
											<td><input type="text" class="form-control Align-Right" disabled="disabled" id="totalFemaleFunctionaries" onchange="calGrandTotalFields()"/></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="row clearfix">
								<div class="col-sm-2">
									<label for="TotalMale"> Total Male Participants :</label>
								</div>
								<div class="col-sm-2">
									<div class="form-group">
										<div class="form-line">
											<form:input path="" id="totalMaleId"
												class="form-control Align-Right"
												onkeypress="return isNumber(event)"
												disabled="true" />
										</div>
									</div>
								</div>
								
								<div class="col-sm-2">
									<label for="TotalFemale"> Total Female Participants :</label>
								</div>
								<div class="col-sm-2">
									<div class="form-group">
										<div class="form-line">
											<form:input path="" id="totalFemaleId"
												class="form-control Align-Right"
												onkeypress="return isNumber(event)"
												disabled="true" />
										</div>
									</div>
								</div>
								
								<div class="col-sm-2">
									<label for="TotalParticipants"> Total Participants :</label>
								</div>
								<div class="col-sm-2">
									<div class="form-group">
										<div class="form-line">
											<form:input path="" id="totalParticipantsId"
												class="form-control Align-Right"
												onkeypress="return isNumber(event)"
												disabled="true" />
										</div>
									</div>
								</div>
							</div>
							
							<div class="row clearfix">
								<div class="col-sm-2">
									<label for="TotalMale"> Total Elected Representatives in Aspirational District :</label>
								</div>
								<div class="col-sm-2">
									<div class="form-group">
										<div class="form-line">
											<form:input path="electativeRepresentativeInAspDistrict" id="electativeRepresentativeInAspDistrictId"
												class="form-control Align-Right"
												onkeypress="return isNumber(event)" onkeyup="validateAsprirationalData()" readonly="${HUN_DAY_TRAINING.isFreeze}"/>
										</div>
									</div>
								</div>
								
								<div class="col-sm-2">
									<label for="TotalFemale"> Total Functionaries and Other Stakeholders in Aspirational District :</label>
								</div>
								<div class="col-sm-2">
									<div class="form-group">
										<div class="form-line">
											<form:input path="funcAndStakeHolderInAspDistrict" id="funcAndStakeHolderInAspDistrictId"
												class="form-control Align-Right" onkeyup="validateAsprirationalData()"
												onkeypress="return isNumber(event)" readonly="${HUN_DAY_TRAINING.isFreeze}" />
										</div>
									</div>
								</div>
								
								<div class="col-sm-2">
									<label for="TotalParticipants"> Total Participants in Aspirational District :</label>
								</div>
								<div class="col-sm-2">
									<div class="form-group">
										<div class="form-line">
											<form:input path="" id="totalParticipantsAspDistId"
												class="form-control Align-Right"
												onkeypress="return isNumber(event)"
												disabled="true" />
										</div>
									</div>
								</div>
							</div>
							
							<div class="text-right">
								<c:choose>
									<c:when test="${HUN_DAY_TRAINING.isFreeze}">
										<button type="submit" class="btn bg-green waves-effect"
											disabled="disabled">
											<c:choose>
												<c:when test="${UPDATE_OR_SAVE eq 'update'}">UPDATE</c:when>
												<c:otherwise>SAVE</c:otherwise>
											</c:choose>
										</button>
									</c:when>
									<c:otherwise>
										<button type="submit" class="btn bg-green waves-effect">
											<c:choose>
												<c:when test="${UPDATE_OR_SAVE eq 'update'}">UPDATE</c:when>
												<c:otherwise>SAVE</c:otherwise>
											</c:choose>
										</button>
									</c:otherwise>
								</c:choose>

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
												class="btn bg-blue waves-effect" disabled="disabled">FREEZE</button>
										</c:if>
									</c:otherwise>
								</c:choose>

								<c:choose>
									<c:when test="${HUN_DAY_TRAINING.isFreeze}">
										<button type="button" onclick="onClear(this)"
											class="btn bg-light-blue waves-effect" disabled="disabled">CLEAR</button>
									</c:when>
									<c:otherwise>
										<button type="button" onclick="onClear(this)"
											class="btn bg-light-blue waves-effect">CLEAR</button>
									</c:otherwise>
								</c:choose>


								<button type="button"
									 onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-orange waves-effect">CLOSE</button> &nbsp;
							</div>
							 </div> 
						</div>
						
						<!-- hidden fields -->
						<input type="hidden" name="trgOfHundredDaysProgramCh2Id" value="${HUN_DAY_TRAINING.trgOfHundredDaysProgramCh2Id}" />
						<input type="hidden" name="isFreeze" id="isFreezeId" value="${HUN_DAY_TRAINING.isFreeze}" />
						<input type="hidden" name="msg" id="msgId" value="" />
						<!--  -->
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