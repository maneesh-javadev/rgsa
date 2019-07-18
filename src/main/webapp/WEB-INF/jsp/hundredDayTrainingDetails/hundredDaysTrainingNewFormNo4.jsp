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
	calMaleSarAspDist();
	calFemaleSarAspDist();
	calOtherErMaleAspDist();
	calOtherErFemaleAspDist();
	calFunMaleAspDist();
	calFunFemaleAspDist();
	calGrandTotalFieldsAspDist()
	
});

	$(function() {
		$("#bstartDate").datetimepicker({
			format : 'dd-mm-yyyy',
			startView : 'month',
			endDate : '+100d',
			autoclose : true,
			minView : 'month',
			startDate : '03/06/2019',
			pickerPosition : "bottom-left",
			endDate : '11/09/2019'
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

function calMaleSarAspDist(){
	$('#totalMaleSarpanchAspDist').val(+$('#sarpanchMaleScAspDistId').val() + +$('#sarpanchMaleStAspDistId').val() + +$('#sarpanchMaleOthersAspDistId').val());
	calGrandTotalFieldsAspDist()
}
	
function calFemaleSarAspDist(){
	$('#totalFemaleSarpanchAspDist').val(+$('#sarpanchFemaleScAspDistId').val() + +$('#sarpanchFemaleStAspDistId').val() + +$('#sarpanchFemaleOthersAspDistId').val());	
	calGrandTotalFieldsAspDist()
}
	
function calOtherErMaleAspDist(){
	$('#totalMaleOtherErAspDist').val(+$('#otherErMaleScAspDistId').val() + +$('#otherErMaleStAspDistId').val() + +$('#otherErMaleOthersAspDistId').val());
	calGrandTotalFieldsAspDist()
}

function calOtherErFemaleAspDist(){
	$('#totalFemaleOtherErAspDist').val(+$('#otherErFemaleScAspDistId').val() + +$('#otherErFemaleStAspDistId').val() + +$('#otherErFemaleOthersAspDistId').val());
	calGrandTotalFieldsAspDist()
}

function calFunMaleAspDist(){
	$('#totalMaleFunctionariesAspDist').val(+$('#functionariedMaleScAspDistId').val() + +$('#functionariedMaleStAspDistId').val() + +$('#functionariedMaleOthersAspDistId').val());
	calGrandTotalFieldsAspDist()
}

function calFunFemaleAspDist(){
	$('#totalFemaleFunctionariesAspDist').val(+$('#functionariedFemaleScAspDistId').val() + +$('#functionariedFemaleStAspDistId').val() + +$('#functionariedFemaleOthersAspDistId').val());
	calGrandTotalFieldsAspDist()
}

function calGrandTotalFieldsAspDist(){
	$('#totalMaleAspDistId').val(+$('#totalMaleSarpanchAspDist').val() + +$('#totalMaleOtherErAspDist').val() + +$('#totalMaleFunctionariesAspDist').val());
	$('#totalFemaleAspDistId').val(+$('#totalFemaleSarpanchAspDist').val() + +$('#totalFemaleOtherErAspDist').val() + +$('#totalFemaleFunctionariesAspDist').val());
	$('#totalParticipantsAspDistId').val(+$('#totalMaleAspDistId').val() + +$('#totalMaleAspDistId').val());
}

function calGrandTotalFields(){
	$('#totalMaleId').val(+$('#totalMaleSarpanch').val() + +$('#totalMaleOtherEr').val() + +$('#totalMaleFunctionaries').val());
	$('#totalFemaleId').val(+$('#totalFemaleSarpanch').val() + +$('#totalFemaleOtherEr').val() + +$('#totalFemaleFunctionaries').val());
	$('#totalParticipantsId').val(+$('#totalMaleId').val() + +$('#totalFemaleId').val());
}

function validateAsprirationalData(){
	
	if(+$('#noOfTrainingConductedId').val() < +$('#noOfTrainingConductedAspDistId').val()){
		alert('value should be less than : ' + $('#noOfTrainingConductedId').val());
		+$('#noOfTrainingConductedAspDistId').val('')
	}
	
	if(+$('#sarpanchMaleScId').val() < +$('#sarpanchMaleScAspDistId').val()){
		alert('value should be less than : ' + $('#sarpanchMaleScId').val());
		$('#sarpanchMaleScAspDistId').val('');
		calMaleSarAspDist();
	}
	if(+$('#sarpanchFemaleScId').val() < +$('#sarpanchFemaleScAspDistId').val()){
		alert('value should be less than : ' + $('#sarpanchFemaleScId').val());
		$('#sarpanchFemaleScAspDistId').val('');
		calFemaleSarAspDist()
	}
	if(+$('#sarpanchFemaleStId').val() < +$('#sarpanchFemaleStAspDistId').val()){
		alert('value should be less than : ' + $('#sarpanchFemaleStId').val());
		$('#sarpanchFemaleStAspDistId').val('');
		calFemaleSarAspDist()
	}
	if(+$('#sarpanchMaleStId').val() < +$('#sarpanchMaleStAspDistId').val()){
		alert('value should be less than : ' + $('#sarpanchMaleStId').val());
		$('#sarpanchMaleStAspDistId').val('');
		calMaleSarAspDist()
	}
	if(+$('#sarpanchFemaleOthersId').val() < +$('#sarpanchFemaleOthersAspDistId').val()){
		alert('value should be less than : ' + $('#sarpanchFemaleOthersId').val());
		$('#sarpanchFemaleOthersAspDistId').val('');
		calFemaleSarAspDist()
	}
	if(+$('#sarpanchMaleOthersId').val() < +$('#sarpanchMaleOthersAspDistId').val()){
		alert('value should be less than : ' + $('#sarpanchMaleOthersId').val());
		$('#sarpanchMaleOthersAspDistId').val('');
		calMaleSarAspDist()
	}
	
	if(+$('#otherErMaleScId').val() < +$('#otherErMaleScAspDistId').val()){
		alert('value should be less than : ' + $('#otherErMaleScId').val());
		$('#otherErMaleScAspDistId').val('');
		calOtherErMaleAspDist()
	}
	if(+$('#otherErFemaleScId').val() < +$('#otherErFemaleScAspDistId').val()){
		alert('value should be less than : ' + $('#otherErFemaleScId').val());
		$('#otherErFemaleScAspDistId').val('');
		calOtherErFemaleAspDist()
	}
	if(+$('#otherErFemaleStId').val() < +$('#otherErFemaleStAspDistId').val()){
		alert('value should be less than : ' + $('#otherErFemaleStId').val());
		$('#otherErFemaleStAspDistId').val('');
		calOtherErFemaleAspDist()
	}
	if(+$('#otherErMaleStId').val() < +$('#otherErMaleStAspDistId').val()){
		alert('value should be less than : ' + $('#otherErMaleStId').val());
		$('#otherErMaleStAspDistId').val('');
		calOtherErMaleAspDist()
	}
	if(+$('#otherErFemaleOthersId').val() < +$('#otherErFemaleOthersAspDistId').val()){
		alert('value should be less than : ' + $('#otherErFemaleOthersId').val());
		$('#otherErFemaleOthersAspDistId').val('');
		calOtherErFemaleAspDist()
	}
	if(+$('#otherErMaleOthersId').val() < +$('#otherErMaleOthersAspDistId').val()){
		alert('value should be less than : ' + $('#otherErMaleOthersId').val());
		$('#otherErMaleOthersAspDistId').val('');
		calOtherErMaleAspDist()
	}
	
	if(+$('#functionariedMaleScId').val() < +$('#functionariedMaleScAspDistId').val()){
		alert('value should be less than : ' + $('#functionariedMaleScId').val());
		$('#functionariedMaleScAspDistId').val('');
		calFunMaleAspDist()
	}
	if(+$('#functionariedFemaleScId').val() < +$('#functionariedFemaleScAspDistId').val()){
		alert('value should be less than : ' + $('#functionariedFemaleScId').val());
		$('#functionariedFemaleScAspDistId').val('');
		calFunFemaleAspDist()
	}
	if(+$('#functionariedFemaleStId').val() < +$('#functionariedFemaleStAspDistId').val()){
		alert('value should be less than : ' + $('#functionariedFemaleStId').val());
		$('#functionariedFemaleStAspDistId').val('');
		calFunFemaleAspDist()
	}
	if(+$('#functionariedMaleStId').val() < +$('#functionariedMaleStAspDistId').val()){
		alert('value should be less than : ' + $('#functionariedMaleStId').val());
		$('#functionariedMaleStAspDistId').val('');
		calFunMaleAspDist()
	}
	if(+$('#functionariedFemaleOthersId').val() < +$('#functionariedFemaleOthersAspDistId').val()){
		alert('value should be less than : ' + $('#functionariedFemaleOthersId').val());
		$('#functionariedFemaleOthersAspDistId').val('');
		calFunFemaleAspDist()
	}
	if(+$('#functionariedMaleOthersId').val() < +$('#functionariedMaleOthersAspDistId').val()){
		alert('value should be less than : ' + $('#functionariedMaleOthersId').val());
		$('#functionariedMaleOthersAspDistId').val('');
		calFunMaleAspDist()
	}
	
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
								<div class="col-sm-3">
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
											<td><form:input path="erSarMaleSc"  class="form-control Align-Right" id="sarpanchMaleScId" onkeyup="calMaleSar()" readonly="${HUN_DAY_TRAINING.isFreeze}"/></td>
											<td><form:input path="erSarFemaleSc" class="form-control Align-Right" id="sarpanchFemaleScId" onkeyup="calFemaleSar()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="erOtherMaleSc" class="form-control Align-Right" id="otherErMaleScId" onkeyup="calOtherErMale()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="erOtherFemaleSc" class="form-control Align-Right" id="otherErFemaleScId" onkeyup="calOtherErFemale()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="funMaleSc" class="form-control Align-Right" id="functionariedMaleScId" onkeyup="calFunMale()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="funFemaleSc" class="form-control Align-Right" id="functionariedFemaleScId" onkeyup="calFunFemale()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
										</tr>
										<tr>
											<td><div align="center"><strong>ST</strong></div></td>
											<td><form:input path="erSarMaleSt" class="form-control Align-Right" id="sarpanchMaleStId" onkeyup="calMaleSar()" readonly="${HUN_DAY_TRAINING.isFreeze}"/></td>
											<td><form:input path="erSarFemaleSt" class="form-control Align-Right" id="sarpanchFemaleStId" onkeyup="calFemaleSar()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="erOtherMaleSt" class="form-control Align-Right" id="otherErMaleStId" onkeyup="calOtherErMale()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="erOtherFemaleSt" class="form-control Align-Right" id="otherErFemaleStId" onkeyup="calOtherErFemale()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="funMaleSt" class="form-control Align-Right" id="functionariedMaleStId" onkeyup="calFunMale()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="funFemaleSt" class="form-control Align-Right" id="functionariedFemaleStId" onkeyup="calFunFemale()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
										</tr>
										<tr>
											<td><div align="center"><strong>Others</strong></div></td>
											<td><form:input path="erSarMaleOthers" class="form-control Align-Right" id="sarpanchMaleOthersId" onkeyup="calMaleSar()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="erSarFemaleOthers" class="form-control Align-Right" id="sarpanchFemaleOthersId" onkeyup="calFemaleSar()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="erOtherMaleOthers" class="form-control Align-Right" id="otherErMaleOthersId" onkeyup="calOtherErMale()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="erOtherFemaleOthers" class="form-control Align-Right" id="otherErFemaleOthersId" onkeyup="calOtherErFemale()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="funMaleOthers" class="form-control Align-Right" id="functionariedMaleOthersId" onkeyup="calFunMale()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											<td><form:input path="funFemaleOthers" class="form-control Align-Right " id="functionariedFemaleOthersId" onkeyup="calFunFemale()" readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
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
							<hr />
							<br />
							<!-- aspirational district data -->
								
								<div class="row clearfix">
									<div class="col-sm-3">
										<label for="NoOfTrainingConductedAspirationalDistrict"> Number of
											trainings Conducted in Aspirational District :</label>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<div class="form-line">
												<form:input path="noOfTrainingConductedAspDistrict"
													id="noOfTrainingConductedAspDistId"
													class="form-control Align-Right"
													onkeypress="return isNumber(event)"
													onkeyup="validateAsprirationalData()"
													readonly="${HUN_DAY_TRAINING.isFreeze}" required="true" />
											</div>
										</div>
									</div>
								</div>

								<div class="table-responsive">
									<table class="table table-bordered table-hover">
										<thead>
											<tr>
												<th rowspan="3" style="padding-bottom: 4%;"><div
														align="center">
														<strong>Participants category (Aspirational District)</strong>
													</div></th>
												<th colspan="4"><div align="center">
														<strong>Elected Representatives (Aspirational District)</strong>
													</div></th>
												<th colspan="2" rowspan="2" style="padding-bottom: 2%;"><div
														align="center">
														<strong>Functionaries & other stakeholders (Aspirational District)</strong>
													</div></th>
											</tr>
											<tr>
												<th colspan="2"><div align="center">
														<strong>Sarpanch (Aspirational District)</strong>
													</div></th>
												<th colspan="2"><div align="center">
														<strong>Other ERs (Aspirational District)</strong>
													</div></th>
											</tr>
											<tr>
												<th><div align="center">
														<strong>Male</strong>
													</div></th>
												<th><div align="center">
														<strong>Female</strong>
													</div></th>
												<th><div align="center">
														<strong>Male</strong>
													</div></th>
												<th><div align="center">
														<strong>Female</strong>
													</div></th>
												<th><div align="center">
														<strong>Male</strong>
													</div></th>
												<th><div align="center">
														<strong>Female</strong>
													</div></th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><div align="center">
														<strong>SC</strong>
													</div></td>
												<td><form:input path="erSarMaleScAspDist"
														class="form-control Align-Right" id="sarpanchMaleScAspDistId"
														onkeyup="calMaleSarAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
												<td><form:input path="erSarFemaleScAspDist"
														class="form-control Align-Right" id="sarpanchFemaleScAspDistId"
														onkeyup="calFemaleSarAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
												<td><form:input path="erOtherMaleScAspDist"
														class="form-control Align-Right" id="otherErMaleScAspDistId"
														onkeyup="calOtherErMaleAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
												<td><form:input path="erOtherFemaleScAspDist"
														class="form-control Align-Right" id="otherErFemaleScAspDistId"
														onkeyup="calOtherErFemaleAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
												<td><form:input path="funMaleScAspDist"
														class="form-control Align-Right"
														id="functionariedMaleScAspDistId" onkeyup="calFunMaleAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
												<td><form:input path="funFemaleScAspDist"
														class="form-control Align-Right"
														id="functionariedFemaleScAspDistId" onkeyup="calFunFemaleAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											</tr>
											<tr>
												<td><div align="center">
														<strong>ST</strong>
													</div></td>
												<td><form:input path="erSarMaleStAspDist"
														class="form-control Align-Right" id="sarpanchMaleStAspDistId"
														onkeyup="calMaleSarAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
												<td><form:input path="erSarFemaleStAspDist"
														class="form-control Align-Right" id="sarpanchFemaleStAspDistId"
														onkeyup="calFemaleSarAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
												<td><form:input path="erOtherMaleStAspDist"
														class="form-control Align-Right" id="otherErMaleStAspDistId"
														onkeyup="calOtherErMaleAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
												<td><form:input path="erOtherFemaleStAspDist"
														class="form-control Align-Right" id="otherErFemaleStAspDistId"
														onkeyup="calOtherErFemaleAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
												<td><form:input path="funMaleStAspDist"
														class="form-control Align-Right"
														id="functionariedMaleStAspDistId" onkeyup="calFunMaleAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
												<td><form:input path="funFemaleStAspDist"
														class="form-control Align-Right"
														id="functionariedFemaleStAspDistId" onkeyup="calFunFemaleAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											</tr>
											<tr>
												<td><div align="center">
														<strong>Others</strong>
													</div></td>
												<td><form:input path="erSarMaleOthersAspDist"
														class="form-control Align-Right" id="sarpanchMaleOthersAspDistId"
														onkeyup="calMaleSarAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
												<td><form:input path="erSarFemaleOthersAspDist"
														class="form-control Align-Right"
														id="sarpanchFemaleOthersAspDistId" onkeyup="calFemaleSarAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
												<td><form:input path="erOtherMaleOthersAspDist"
														class="form-control Align-Right" id="otherErMaleOthersAspDistId"
														onkeyup="calOtherErMaleAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
												<td><form:input path="erOtherFemaleOthersAspDist"
														class="form-control Align-Right"
														id="otherErFemaleOthersAspDistId" onkeyup="calOtherErFemaleAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
												<td><form:input path="funMaleOthersAspDist"
														class="form-control Align-Right"
														id="functionariedMaleOthersAspDistId" onkeyup="calFunMaleAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
												<td><form:input path="funFemaleOthersAspDist"
														class="form-control Align-Right "
														id="functionariedFemaleOthersAspDistId" onkeyup="calFunFemaleAspDist();validateAsprirationalData()"
														readonly="${HUN_DAY_TRAINING.isFreeze}" /></td>
											</tr>
											<tr>
												<td><div align="center">
														<strong>Total</strong>
													</div></td>
												<td><input type="text" class="form-control Align-Right"
													disabled="disabled" id="totalMaleSarpanchAspDist" /></td>
												<td><input type="text" class="form-control Align-Right"
													disabled="disabled" id="totalFemaleSarpanchAspDist" /></td>
												<td><input type="text" class="form-control Align-Right"
													disabled="disabled" id="totalMaleOtherErAspDist" /></td>
												<td><input type="text" class="form-control Align-Right"
													disabled="disabled" id="totalFemaleOtherErAspDist" /></td>
												<td><input type="text" class="form-control Align-Right"
													disabled="disabled" id="totalMaleFunctionariesAspDist" /></td>
												<td><input type="text" class="form-control Align-Right"
													disabled="disabled" id="totalFemaleFunctionariesAspDist" /></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="row clearfix">
									<div class="col-sm-2">
										<label for="TotalMale"> Total Male Participants in Aspirational District :</label>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<div class="form-line">
												<form:input path="" id="totalMaleAspDistId"
													class="form-control Align-Right"
													onkeypress="return isNumber(event)"
													disabled="true" />
											</div>
										</div>
									</div>

									<div class="col-sm-2">
										<label for="TotalFemale"> Total Female Participants in Aspirational District :</label>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<div class="form-line">
												<form:input path="" id="totalFemaleAspDistId"
													class="form-control Align-Right"
													onkeypress="return isNumber(event)"
													disabled="true" />
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
								<!--  -->
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