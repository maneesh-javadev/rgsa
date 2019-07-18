<%@include file="../taglib/taglib.jsp"%>
<link rel="stylesheet" type="text/css"
	href="<c:out value="<%=request.getContextPath()%>"/>/resources/bs/css_js/bootstrap.min.css" />
<script
	src="<c:out value="<%=request.getContextPath()%>"/>/resources/bs/css_js/bootstrap.min.js"></script>
<script
	src="<c:out value="<%=request.getContextPath()%>"/>/resources/bs/bs_dt/js/dataTables.responsive.min.js"></script>
<script
	src="<c:out value="<%=request.getContextPath()%>"/>/resources/bs/bs_dt/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet"
	href="<c:out value="<%=request.getContextPath()%>"/>/resources/bs/bs_dt/css/jquery.dataTables.min.css" />
	
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/datepicker/css/bootstrap-datetimepicker.min.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/datepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript">
var startDate = '${HUN_DAY_TRAINING.demoStartDate}';
$('document').ready(function(){
	if(startDate != ''){
		$('#mainDivId').show();
	}
	getTotal();
	
});

$(function () {   
    $("#bstartDate").datetimepicker({
		format: 'dd-mm-yyyy',
		daysOfWeekDisabled: [0,2,3,4,5,6],
		startView : 'month',
		endDate: '+100d',
        autoclose: true,
		minView : 'month',
		startDate :'03/06/2019',
		pickerPosition : "bottom-left",
		endDate:'11/09/2019'
	}) ;
});

function fetchEndDate(){
	 var monthNames = [
		    "01", "02", "03",
		    "04", "05", "06", "07",
		    "08", "09", "10",
		    "11", "12"
		  ];
	 var from = $("#startDate").val().split("-")
	 var f = new Date(from[2], from[1] - 1, from[0]);
	 if(f.getDate() > 5 && monthNames[f.getMonth()] == '09'){
		 $('#endDate').val('11' + '-' + '09'+ '-'+ '2019');
	 }else{
		 f.setDate(f.getDate()+6); 
		 $('#endDate').val(f.getDate() + '-' + monthNames[f.getMonth()] + '-'+ f.getFullYear());
	 }
	 
	 fetchDataFromBack();
}
function getTotal(){
	var total=0;
	var totalAspirational=0;
	total = +$('#totalSC').val() + +$('#totalST').val() + +$('#totalWomen').val() + +$('#totalOthers').val();
	totalAspirational = +$('#aspirationalSC').val() + +$('#aspirationalST').val() + +$('#aspirationalWomen').val() + +$('#aspirationalOthers').val();
	$('#TotalParticipants').val(total);
	$('#TotalAspirationalParticipants').val(totalAspirational);
}

function validateWithAspirational(){
	if($('#totalSC').val() != '' && $('#aspirationalSC').val() != ''){
		if(+$('#totalSC').val() < +$('#aspirationalSC').val()){
			alert('Value should not exceed the total SC participants.');
			 $('#aspirationalSC').val('');
		}
	}
	if($('#totalST').val() != '' && $('#aspirationalST').val() != ''){
		if(+$('#totalST').val() < +$('#aspirationalST').val()){
			alert('Value should not exceed the total ST participants.');
			 $('#aspirationalST').val('');
		}
	}
	if($('#totalWomen').val() != '' && $('#aspirationalWomen').val() != ''){
		if(+$('#totalWomen').val() < +$('#aspirationalWomen').val()){
			alert('Value should not exceed the total Women participants.');
			 $('#aspirationalWomen').val('');
		}
	}
	if($('#totalOthers').val() != '' && $('#aspirationalOthers').val() != ''){
		if(+$('#totalOthers').val() < +$('#aspirationalOthers').val()){
			alert('Value should not exceed the total Others participants.');
			 $('#aspirationalOthers').val('');
		}
	}
	getTotal();
}

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

function fetchDataFromBack(){
	$('#msgId').val('fetch'); 
	document.trainingDetailHundredDay.method = "post";
	document.trainingDetailHundredDay.action = "fetchTrainingDetails.html?<csrf:token uri='fetchTrainingDetails.html'/>";
	document.trainingDetailHundredDay.submit();
};

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
					<form:form method="post" id="trainingDetailId"
						name="trainingDetailHundredDay"
						action="trainingDetailHundredDay.html"
						modelAttribute="HUN_DAY_TRAINING">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="trainingDetailHundredDay.html"/>" />
						<div class="body">
							<div class="row clearfix">

								<div class="row clearfix">
									<div class="col-sm-2">
										<label for="trainingStartDate"> Training Start Date :</label>
									</div>

									<div class="col-xs-4">
										<!-- <div class="form-line"> -->
										<c:choose>
										<c:when test="${HUN_DAY_TRAINING.isFreeze}"><div class="" id="">
											<div class="form-group">
												<div class="form-line">
													<form:input path="demoStartDate" class="form-control" id="startDate" onchange="fetchEndDate();" readonly="${HUN_DAY_TRAINING.isFreeze}"/>
												</div> <!-- <span class="input-group-addon"><span
													class="glyphicon glyphicon-calendar"></span></span> -->
												</div>
											</div>
										</c:when>
										<c:otherwise>
											<div class="form-line">
												<div class="input-group date datepicker" id="bstartDate">
													<form:input path="demoStartDate" class="form-control" id="startDate" onchange="fetchEndDate();" readonly="${HUN_DAY_TRAINING.isFreeze}"/>
													<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
												</div>
											</div>
										</c:otherwise>
										</c:choose>
											<%-- <div class="input-group date datepicker" id="bstartDate">
												<form:input path="demoStartDate" class="form-control" id="startDate" onchange="fetchEndDate();" readonly="${HUN_DAY_TRAINING.isFreeze}"/>
												<span class="input-group-addon"><span
													class="glyphicon glyphicon-calendar"></span></span>
											</div> --%>

										<!-- </div> -->
									</div>
									<!-- <div class="col-sm-4">
										<div class="form-group">
											<div class="form-line datepicker">
												<input type="text" id="noOfTrainingConductedId"
													class="form-control Align-Right " />
											</div>
										</div>
									</div> -->
						
									<div class="col-sm-2">
										<label for="trainingEndDate"> Training End Date :</label>
									</div>
									<div class="col-xs-4">
										<div class="form-line">
											<div class="input-group date datepicker" id="bendDate">
												<form:input path="demoEndDate" class="form-control" id="endDate" readonly="true"/>
												<span class="input-group-addon"><span
													class="glyphicon glyphicon-calendar"></span></span>
											</div>

										</div>
									</div>
									<!-- <div class="col-sm-4">
										<div class="form-group">
											<div class="form-line datepicker">
												<input type="text" id="noOfTrainingConductedId"
													class="form-control Align-Right" />
											</div>
										</div>
									</div> -->
								</div>
								<!-- DIV STARTS FROM HERE -->
								<div id="mainDivId" style="display: none;">
								<div class="row clearfix">
									<div class="col-sm-4">
										<label for="NoOfTrainingConducted"> Number of training
											Conducted in week :</label>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<div class="form-line">
												<form:input path="noOfTrainingConducted" id="noOfTrainingConductedId"
													class="form-control Align-Right" onkeypress="return isNumber(event)" readonly="${HUN_DAY_TRAINING.isFreeze}"/>
											</div>
										</div>
									</div>
								</div>
								<div class="table-responsive">
									<table class="table table-borderd table-hover">
										<thead>
											<tr>
												<th>Participants Details</th>
												<th>Total Participants</th>
												<th>Participants in Aspirational District</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th>SC</th>
												<td><form:input path="scParticipants" id="totalSC"
														class="form-control Align-Right" onkeyup="getTotal()" onkeypress="return isNumber(event)" readonly="${HUN_DAY_TRAINING.isFreeze}"/></td>
												<td><form:input path="scAspirationalParticipants"
														id="aspirationalSC" class="form-control Align-Right" onkeyup="validateWithAspirational();getTotal()" onkeypress="return isNumber(event)" readonly="${HUN_DAY_TRAINING.isFreeze}"/></td>
											</tr>
											<tr>
												<th>ST</th>
												<td><form:input path="stParticipants" id="totalST"
														class="form-control Align-Right" onkeyup="getTotal()" onkeypress="return isNumber(event)" readonly="${HUN_DAY_TRAINING.isFreeze}"/></td>
												<td><form:input path="stAspirationalParticipants"
														id="aspirationalST" class="form-control Align-Right" onkeyup="validateWithAspirational();getTotal()" onkeypress="return isNumber(event)" readonly="${HUN_DAY_TRAINING.isFreeze}"/></td>
											</tr>
											<tr>
												<th>Women</th>
												<td><form:input path="womenParticipants"
														id="totalWomen" class="form-control Align-Right" onkeyup="getTotal()" onkeypress="return isNumber(event)" readonly="${HUN_DAY_TRAINING.isFreeze}"/></td>
												<td><form:input path="womenAspirationalParticipants"
														id="aspirationalWomen" class="form-control Align-Right" onkeyup="validateWithAspirational();getTotal()" onkeypress="return isNumber(event)" readonly="${HUN_DAY_TRAINING.isFreeze}"/></td>
											</tr>
											<tr>
												<th>Other</th>
												<td><form:input path="othersParticipants"
														id="totalOthers" class="form-control Align-Right" onkeyup="getTotal()" onkeypress="return isNumber(event)" readonly="${HUN_DAY_TRAINING.isFreeze}"/></td>
												<td><form:input path="othersAspirationalParticipants"
														id="aspirationalOthers" class="form-control Align-Right" onkeyup="validateWithAspirational();getTotal()" onkeypress="return isNumber(event)" readonly="${HUN_DAY_TRAINING.isFreeze}"/></td>
											</tr>
											<tr>
												<th>Total</th>
												<td><input type="text" id="TotalParticipants"
													class="form-control Align-Right" disabled="disabled"/></td>
												<td><input type="text"
													id="TotalAspirationalParticipants" class="form-control Align-Right" disabled="disabled"/></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="form-group text-right" style="padding-bottom: 5px;">
							<c:choose>
								<c:when test="${HUN_DAY_TRAINING.isFreeze}">
									<button type="submit" class="btn bg-green waves-effect" disabled="disabled">
								<c:choose>
									<c:when test="${UPDATE_OR_SAVE eq 'update'}">UPDATE</c:when>
									<c:otherwise>SAVE</c:otherwise>
								</c:choose>
							</button>
								</c:when>
								<c:otherwise>
								<button type="submit" class="btn bg-green waves-effect" >
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
								class="btn bg-orange waves-effect">CLOSE</button>
							&nbsp;
						</div>
						</div>
							</div>
						</div>
						
						<!-- hidden fields -->
						<input type="hidden" name="trgOfHundredDaysProgramChId"
							value="${HUN_DAY_TRAINING.trgOfHundredDaysProgramChId}" />
						<input type="hidden" name="isFreeze" id="isFreezeId"
							value="${HUN_DAY_TRAINING.isFreeze}" />
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