<%@include file="../taglib/taglib.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/datepicker/css/bootstrap-datetimepicker.min.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/datepicker/js/bootstrap-datetimepicker.min.js"></script>
<script>
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
								<div class="col-sm-2">
									<label for="trainingStartDate"> Training Start Date :</label>
								</div>
								<div class="col-xs-4">
									<c:choose>
										<c:when test="${HUN_DAY_TRAINING.isFreeze}">
											<div class="" id="">
												<div class="form-group">
													<div class="form-line">
														<form:input path="" class="form-control" id="startDate"
															onchange="fetchEndDate();"
															readonly="${HUN_DAY_TRAINING.isFreeze}" />
													</div>
												</div>
											</div>
										</c:when>
										<c:otherwise>
											<div class="form-line">
												<div class="input-group date datepicker" id="bstartDate">
													<form:input path="" class="form-control" id="startDate"
														onchange="fetchEndDate();"
														readonly="${HUN_DAY_TRAINING.isFreeze}" />
													<span class="input-group-addon"><span
														class="glyphicon glyphicon-calendar"></span></span>
												</div>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>

							<div class="row clearfix">
								<div class="col-sm-3">
									<label for="NoOfTrainingConducted"> Number of training
										Conducted :</label>
								</div>
								<div class="col-sm-4">
									<div class="form-group">
										<div class="form-line">
											<form:input path="" id="noOfTrainingConductedId"
												class="form-control Align-Right"
												onkeypress="return isNumber(event)"
												readonly="${HUN_DAY_TRAINING.isFreeze}" />
										</div>
									</div>
								</div>
							</div>
							
							<div class="table-responsive">
								<table class="table table-bordered table-hover">
									<thead>
										<tr>
											<th rowspan="3" style="padding-bottom: 4%;"><div align="center"><strong>Participants category</strong></div></th>
											<th colspan="4"><div align="center"><strong>Elected Representative</strong></div></th>
											<th colspan="2" rowspan="2" style="padding-bottom: 2%;"><div align="center"><strong>Functionaries & other stakeholders</strong></div></th>
										</tr>
										<tr>
											<th colspan="2"><div align="center"><strong>Sarpanchs</strong></div></th>
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
											<td><input type="text" class="form-control" id="sarpanchMaleScId"/></td>
											<td><input type="text" class="form-control" id="sarpanchFemaleScId"/></td>
											<td><input type="text" class="form-control" id="otherErMaleScId"/></td>
											<td><input type="text" class="form-control" id="otherErFemaleScId"/></td>
											<td><input type="text" class="form-control" id="functionariedMaleScId"/></td>
											<td><input type="text" class="form-control" id="functionariedFemaleScId"/></td>
										</tr>
										<tr>
											<td><div align="center"><strong>ST</strong></div></td>
											<td><input type="text" class="form-control" id="sarpanchMaleStId"/></td>
											<td><input type="text" class="form-control" id="sarpanchFemaleStId"/></td>
											<td><input type="text" class="form-control" id="otherErMaleStId"/></td>
											<td><input type="text" class="form-control" id="otherErFemaleStId"/></td>
											<td><input type="text" class="form-control" id="functionariedMaleStId"/></td>
											<td><input type="text" class="form-control" id="functionariedFemaleStId"/></td>
										</tr>
										<tr>
											<td><div align="center"><strong>Others</strong></div></td>
											<td><input type="text" class="form-control" id="sarpanchMaleOthersId"/></td>
											<td><input type="text" class="form-control" id="sarpanchFemaleOthersId"/></td>
											<td><input type="text" class="form-control" id="otherErMaleOthersId"/></td>
											<td><input type="text" class="form-control" id="otherErFemaleOthersId"/></td>
											<td><input type="text" class="form-control" id="functionariedMaleOthersId"/></td>
											<td><input type="text" class="form-control" id="functionariedFemaleStId"/></td>
										</tr>
										<tr>
											<td><div align="center"><strong>Total</strong></div></td>
											<td><input type="text" class="form-control" disabled="disabled" id="totalMaleSarpanch"/></td>
											<td><input type="text" class="form-control" disabled="disabled" id="totalFemaleSarpanch"/></td>
											<td><input type="text" class="form-control" disabled="disabled" id="totalMaleOtherEr"/></td>
											<td><input type="text" class="form-control" disabled="disabled" id="totalFemaleOtherEr"/></td>
											<td><input type="text" class="form-control" disabled="disabled" id="totalMaleFunctionaries"/></td>
											<td><input type="text" class="form-control" disabled="disabled" id="totalFemaleFunctionaries"/></td>
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
												readonly="${HUN_DAY_TRAINING.isFreeze}" />
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
												readonly="${HUN_DAY_TRAINING.isFreeze}" />
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
												readonly="${HUN_DAY_TRAINING.isFreeze}" />
										</div>
									</div>
								</div>
							</div>
							<div class="text-right">
								<button type="button" class="btn bg-green waves-effect" onclick="setAndSaveDetails()" >SAVE</button>
								<button type="button" class="btn bg-blue waves-effect">FREEZE</button>
								<button type="button" onclick="onClear(this)"
								class="btn bg-light-blue waves-effect" disabled="disabled">CLEAR</button>
								<button type="button"
								onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
								class="btn bg-orange waves-effect">CLOSE</button>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
