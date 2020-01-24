<%@include file="../taglib/taglib.jsp"%>
<script>
	$(document).ready(function() {
		$('#finYearSelectId').val('${VIEW_REPORT_MODEL.finYearId}');
		$('#stateDropDownId').val('${VIEW_REPORT_MODEL.stateCode}');
		var finYear=$('#finYearSelectId').val();
		var stateCode=$('#stateDropDownId').val();
		(finYear > 0) ? $('#stateDropDownBlock').show() : $('#stateDropDownBlock').hide() ;
		(stateCode > 0) ? $('#optionChoosingBlock').show() : $('#optionChoosingBlock').hide() ;
		if ('${VIEW_REPORT_MODEL.isDemoGraphic}' == 'true') {
			$('#demoGraphicBlock').show();
			$('#annualPlanBlock').hide();
			$('#demoGraphicId').attr("checked", true);
			$('#annualActionPlanId').attr("checked", false);
		}
	
	});


		function showStateDropDown() {
		$('#finYearSelectId').val() > 0 ? $('#stateDropDownBlock').show()
				: $('#stateDropDownBlock').hide();
		$('#stateDropDownId').val(0)
		$('#demoGraphicId').attr("checked", false);
		$('#annualActionPlanId').attr("checked", false);
		$('#demoGraphicBlock').hide();
		$('#annualPlanBlock').hide();
	}
	function submitToPost() {
		document.viewReportAtMopr.method = "post";
		document.viewReportAtMopr.action = "viewReportDemographicProfile.html?<csrf:token uri='viewReportDemographicProfile.html'/>";
		document.viewReportAtMopr.submit();
	}
	function showDemoGraphAndAnnualOption() {
		$('#stateDropDownId').val() > 0 ? $('#optionChoosingBlock').show() : $('#optionChoosingBlock').hide();
		$('#demoGraphicId').attr("checked", false);
		$('#annualActionPlanId').attr("checked", false);
		$('#demoGraphicBlock').hide();
		$('#annualPlanBlock').hide();
	}

	function showTableContent(msg) {
		
			if ($('#annualActionPlanId').is(':checked')) {
				$('#annualActionPlanId').attr("checked", false);
			}
			$('#demoGraphicBlock').show();
			$('#annualPlanBlock').hide();
			$('#demoGraphicId').val(true);
		
		submitToPost();
	}

	function exportToPdf(id) {
		 var finYear = $('#finYearSelectId').find('option:selected').text();
		 var stateName = $('#stateDropDownId').find('option:selected').text();
		 var header = (id == 'annualPlanBlockPrint') ? 'Annual action plan '+ finYear + ' - ' + $.trim(stateName): 'Demographic profile and other information '+ finYear + ' - ' + $.trim(stateName);
		 var sTable =$('#'+id).html();
		 var style = "<style>";
		 if(id == 'annualPlanBlockPrint'){
		 	 style = style + "table,th,td{border: solid 1px black;border-collapse: collapse;}";
	         style = style + "thead {color : white; background-color: #9071bf;";
	         style = style + "</style>";
		 }else{
			 style = style + " table , td, th {border: solid 1px grey;border-collapse: collapse;}";
			 style = style + "</style>";
		 }
         var win = window.open('', '', 'height=700,width=700');
         win.document.write('<html><head>');
         win.document.write('<title>'+header+'</title>');  
         win.document.write(style); 
         win.document.write('</head>');
         win.document.write('<body>');
         win.document.write(sTable);         
         win.document.write('</body></html>');
       	 win.document.close(); 	
       	 win.print();    
	}
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h3 style="padding-top: 25px;">&nbsp;&nbsp; Demographic
							profile Report</h3>
					</div>
					<br />
					<form:form method="post" name="viewReportAtMopr" action=""
						modelAttribute="VIEW_REPORT_MODEL">
						<div class="row">
							<div class="col-sm-2">
								<label for="finYear">&nbsp;&nbsp; Select financial year
									: </label>
							</div>
							<div class="col-sm-4">
								<form:select class="form-control"
									onchange="showStateDropDown();submitToPost()"
									id="finYearSelectId" path="finYearId">
									<option value="0">Select fin year</option>
									<c:forEach items="${FIN_YEAR_LIST}" var="finYear">
										<option value="${finYear.yearId}">${finYear.finYear}</option>
									</c:forEach>
								</form:select>
							</div>
						</div>
						<br />

						<div class="row" id="stateDropDownBlock">
							<div class="col-sm-2">
								<label for="state">&nbsp;&nbsp; Select State : </label>
							</div>
							<div class="col-sm-4">
								<form:select class="form-control" id="stateDropDownId"
									onchange="showDemoGraphAndAnnualOption();showTableContent('demo');"
									path="stateCode">
									<option value="0">Select State</option>
									<c:forEach items="${STATE_LIST}" var="state">
										<option value="${state.stateCode}">
											${state.stateNameEnglish}</option>
									</c:forEach>
								</form:select>
							</div>
						</div>
						<br />
							<input type="hidden" id="demoGraphicId" class="radio"
								name="isDemoGraphic" />
							
							<div class="body">
								<div id="demoGraphicBlock" style="display: none;">
									<hr />
									<div id="demoGraphicBlockPrint">
										<table
											class="table table-hover table-bordered dashboard-task-infos"
											id="demoTable">
											<thead style="background-color: #9071bf; color: white;">
												<tr>
													<th class="demoTh"><div align="center">Sr.No</div></th>
													<th class="demoTh"><div align="center">Particulars</div></th>
													<th colspan="3" class="demoTh"><div align="center">Details</div></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${DEMO_GRAPHIC_DATA}" var="demoData"
													varStatus="index">
													<tr class="trMainDemo">

														<c:if test="${demoData.noOfFields eq 1}">
															<td align="center" class="demoTd"><b>${index.count}</b></td>
															<td align="center" class="demoTd"><b>${demoData.particular}
															</b></td>
															<td colspan="3" align="center" class="demoTd">${demoData.details}</td>
														</c:if>

														<c:if test="${demoData.noOfFields ne 1}">
															<td align="center" class="demoTd"><b>${index.count}</b></td>
															<td align="center" class="demoTd"><b>${demoData.particular}</b></td>
															<c:if
																test="${demoData.id eq 9 or demoData.id eq 13 or demoData.id eq 14}">
																<td colspan="3" class="demoTd" style="padding: 0px;">
																	<table class="table table-hover" style="margin: 0px;"
																		class="demoInnerTable">
																		<thead>
																			<tr class="innerSubDemoTr">
																				<th align="center" class="demoInnerTh">Gram
																					Panchayat</th>
																				<th align="center" class="demoInnerTh">Block
																					Panchayat</th>
																				<th align="center" class="demoInnerTh">District
																					Panchayat</th>
																			</tr>
																		</thead>

																		<tbody>
																			<tr class="innerSubDemoTr">
																				<td align="center" class="demoInnerTd">${demoData.gpData}</td>
																				<td align="center" class="demoInnerTd">${demoData.bpData}</td>
																				<td align="center" class="demoInnerTd">${demoData.dpData}</td>
																			</tr>
																		</tbody>
																	</table>
																</td>
															</c:if>
															<c:if test="${demoData.id eq 16}">
																<td colspan="3" class="demoTd" class="demoTd"
																	style="padding: 0px;">
																	<table class="table table-hover" style="margin: 0px;"
																		class="demoInnerTable">
																		<thead>
																			<tr class="innerSubDemoTr">
																				<th><div align="center" class="demoInnerTh">GPs
																						per Block</div></th>
																				<th><div align="center" class="demoInnerTh">Blocks
																						per District</div></th>
																			</tr>
																		</thead>
																		<tbody>
																			<tr class="innerSubDemoTr">
																				<td align="center" class="demoInnerTd">${demoData.gpData}</td>
																				<td align="center" class="demoInnerTd">${demoData.bpData}</td>
																			</tr>
																		</tbody>
																	</table>
																</td>
															</c:if>

															<c:if test="${demoData.id eq 25}">
																<td colspan="3" class="demoTd innerTdTable"
																	style="padding: 0px;">
																	<table class="table table-hover" style="margin: 0px;"
																		class="demoInnerTable">
																		<thead>
																			<tr class="innerSubDemoTr">
																				<th><div align="center" class="demoInnerTh">GP
																						level</div></th>
																				<th><div align="center" class="demoInnerTh">Block
																						level</div></th>
																				<th><div align="center" class="demoInnerTh">District
																						level</div></th>
																			</tr>
																		</thead>
																		<tbody>
																			<tr class="innerSubDemoTr">
																				<td align="center" class="demoInnerTd">${demoData.gpData}</td>
																				<td align="center" class="demoInnerTd">${demoData.bpData}</td>
																				<td align="center" class="demoInnerTd">${demoData.dpData}</td>
																			</tr>
																		</tbody>
																	</table>
																</td>
															</c:if>
														</c:if>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
									<div class="text-right">
										<button type="button" class="btn bg-red waves-effect"
											id="exportButtonId"
											onclick="exportToPdf('demoGraphicBlockPrint')">Export
											File</button>
									</div>
								</div>

							</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>