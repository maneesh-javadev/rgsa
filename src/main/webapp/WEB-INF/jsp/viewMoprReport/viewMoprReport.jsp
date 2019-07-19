<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.22/pdfmake.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>	
<script>
	$(document).ready(function() {
		$('#finYearSelectId').val('${VIEW_REPORT_MODEL.finYearId}');
		$('#stateDropDownId').val('${VIEW_REPORT_MODEL.stateCode}')
		showStateDropDown();
		showDemoGraphAndAnnualOption();
		if ('${VIEW_REPORT_MODEL.isDemoGraphic}' == 'true') {
			$('#demoGraphicBlock').show();
			$('#annualPlanBlock').hide();
			$('#demoGraphicId').attr("checked", true);
			$('#annualActionPlanId').attr("checked", false);
		}

		if ('${VIEW_REPORT_MODEL.isAnnualPlan}' == 'true') {
			$('#annualPlanBlock').show();
			$('#demoGraphicBlock').hide();
			$('#annualActionPlanId').attr("checked", true);
			$('#demoGraphicId').attr("checked", false);
		}
	});

	toggleSubComponent = function(id, flag) {
		$(".slide" + id).slideToggle();
		$(".slidex" + id).slideToggle();
		if ($('#collapseRow' + id).css('display') == 'none') {
			$("#collapseRow" + id).show();
			$("#expendRow" + id).hide();
		} else {
			$("#collapseRow" + id).hide();
			$("#expendRow" + id).show();
		}

	};

	function expandAll(msg) {
		if (msg == 'expand') {
			$('.mainTrId').css("background-color","#d9edf7");
			$(".expand-all").slideToggle();
			$("#collapseButtonId").show();
			$("#expandButtonId").hide();
			$(".collapseRowAll").show();
			$(".expendRowAll").hide();
		} else {
			$('.mainTrId').css("background-color","white ");
			$(".expand-all").slideToggle();
			$("#collapseButtonId").hide();
			$("#expandButtonId").show();
			$(".collapseRowAll").hide();
			$(".expendRowAll").show();
		}
	}

	function showStateDropDown() {
		$('#finYearSelectId').val() > 0 ? $('#stateDropDownBlock').show()
				: $('#stateDropDownBlock').hide();
	}
	function submitToPost() {
		document.viewReportAtMopr.method = "post";
		document.viewReportAtMopr.action = "viewReportMopr.html?<csrf:token uri='viewReportMopr.html'/>";
		document.viewReportAtMopr.submit();
	}
	function showDemoGraphAndAnnualOption(val) {
		$('#stateDropDownId').val() > 0 ? $('#optionChoosingBlock').show() : $(
				'#optionChoosingBlock').hide();

	}

	function showTableContent(msg) {
		if (msg == 'demo') {
			if ($('#annualActionPlanId').is(':checked')) {
				$('#annualActionPlanId').attr("checked", false);
			}
			$('#demoGraphicBlock').show();
			$('#annualPlanBlock').hide();
			$('#demoGraphicId').val(true);
		} else {
			if ($('#demoGraphicId').is(':checked')) {
				$('#demoGraphicId').attr("checked", false);
			}
			$('#annualPlanBlock').show();
			$('#demoGraphicBlock').hide();
			$('#annualActionPlanId').val(true);
		}
		submitToPost();
	}

	function exportToPdf(id) {
		 var finYear = $('#finYearSelectId').find('option:selected').text();
		 var stateName = $('#stateDropDownId').find('option:selected').text();
		 var header = (id == 'annualPlanBlockPrint') ? 'Annual action plan '+ finYear + ' - ' + $.trim(stateName): 'Demographic profile and other information';
		 var sTable =$('#'+id).html();
		 var style = "<style>";
		 	style = style + "table,th,td{border: solid 1px black;border-collapse: collapse;}";
	        style = style + "thead {color : white; background-color: #9071bf;";
	        style = style + "</style>";
         var win = window.open('', '', 'height=700,width=700');
         win.document.write('<html><head>');
         win.document.write('<title style="text-align:center; font-size : 50px">'+header+'</title>');  
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
						<h3 style="padding-top: 25px;">&nbsp;&nbsp; Demographic profile and Annual action plan Report</h3>
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
									onchange="showDemoGraphAndAnnualOption()" path="stateCode">
									<option value="0">Select State</option>
									<c:forEach items="${STATE_LIST}" var="state">
										<option value="${state.stateCode}">
											${state.stateNameEnglish}</option>
									</c:forEach>
								</form:select>
							</div>
						</div>
						<br />

						<div class="row" id="optionChoosingBlock">
							<div class="col-sm-2" >
								<label for="DemoGraphicProfile">&nbsp;&nbsp;Demographic
									Profile : </label>
							</div>
							<div class="col-sm-3">
								<input type="radio" id="demoGraphicId" class="radio"
									name="isDemoGraphic" onclick="showTableContent('demo')" />
							</div>
							<div class="col-sm-2">
								<label for="DemoGraphicProfile">Annual Action Plan : </label>
							</div>
							<div class="col-sm-3">
								<input type="radio" id="annualActionPlanId" class="radio"
									name="isAnnualPlan" onclick="showTableContent('annual')" />
							</div>
						</div>
						<div class="body">
							<div id="demoGraphicBlock" style="display: none;">
								Demographic block is under Development</div>
							<div id="annualPlanBlock" style="display: none;">
								<hr />
								<div id="annualPlanBlockPrint">
								<table class="table table-hover table-bordered dashboard-task-infos"
									id="annualReportTable">

									<thead>
										<tr>
											<th rowspan="2" width="5%"></th>
											<th rowspan="2" width="5%">Sr.No</th>
											<th rowspan="2" width="22%">Components</th>
											<td align="center"><b> Amount State Proposed</b></td>
											<td align="center"><b>Amount Ministry Recomended</b></td>
											<td align="center"><b>Amount CEC Approved</b></td>
										</tr>
									</thead>
									<c:set var="t_fund" value="0" />
									<c:set var="t_unit" value="0" />
									<tbody>

										<c:forEach items="${planComponentsFunds}" var="pc"
											varStatus="pcindex">
											<c:if test="${pc.eType eq 'C'}">
												<c:set var="moprDiff" value="bg-test" />
												<c:if
													test="${pc.amountProposed+pc.addtionalRequirement ne pc.amountProposedMOPR+pc.addtionalRequirementMOPR and pc.amountProposedMOPR != null }">
													<c:set var="moprDiff" value="bg-warning" />
												</c:if>
												<c:set var="moprDiffUnit" value="bg-test" />
												<c:if
													test="${pc.noOfUnits ne pc.noOfUnitsMOPR and pc.noOfUnitsMOPR != null }">
													<c:set var="moprDiffUnit" value="bg-warning" />
												</c:if>
												<c:set var="cecDiff" value="bg-test" />
												<c:if
													test="${pc.amountProposedMOPR+pc.addtionalRequirementMOPR ne pc.amountProposedCEC+pc.addtionalRequirementCEC and pc.amountProposedCEC != null }">
													<c:set var="cecDiff" value="bg-info" />
												</c:if>
												<c:set var="cecDiffUnit" value="bg-test" />
												<c:if
													test="${pc.noOfUnitsMOPR ne pc.noOfUnitsCEC and pc.noOfUnitsCEC != null }">
													<c:set var="cecDiffUnit" value="bg-info" />
												</c:if>
												<tr class="mainTrId">
													<td align="center" id="plusId${pc.componentsId}"><c:if
															test="${pc.componentsId ne 11 and pc.componentsId ne 12}">
															<div id="expendRow${pc.componentsId}"
																class="expendRowAll"
																onclick="toggleSubComponent('${pc.componentsId}',true)">
																<i class="fa fa-plus-circle" aria-hidden="true"></i>
															</div>
															<div id="collapseRow${pc.componentsId}"
																class="collapseRowAll"
																onclick="toggleSubComponent('${pc.componentsId}',false)"
																style="display: none;">
																<i class="fa fa-minus-circle" aria-hidden="true"></i>
															</div>
														</c:if></td>
													<td><b>${pcindex.count}</b></td>
													<td><b>${pc.eName}</b></td>

													<td align="center"><c:if
															test="${(pc.amountProposed+pc.addtionalRequirement)>0}">
															<b><fmt:formatNumber type="number"
																	maxFractionDigits="3"
																	value="${pc.amountProposed+pc.addtionalRequirement}" /></b>
														</c:if></td>
													<td align="center" class="${moprDiff}"><c:if
															test="${(pc.amountProposedMOPR+pc.addtionalRequirementMOPR)>0}">
															<b><fmt:formatNumber type="number"
																	maxFractionDigits="3"
																	value="${pc.amountProposedMOPR+pc.addtionalRequirementMOPR}" /></b>
														</c:if></td>
													<td align="center" class="${cecDiff}"><c:if
															test="${(pc.amountProposedCEC+pc.addtionalRequirementCEC)>0}">
															<b><fmt:formatNumber type="number"
																	maxFractionDigits="3"
																	value="${pc.amountProposedCEC+pc.addtionalRequirementCEC}" /></b>
														</c:if></td>

													<c:set var="t_fund"
														value="${t_fund+pc.amountProposed+pc.addtionalRequirement}" />
													<c:set var="t_unit" value="${t_unit+pc.noOfUnits}" />
													<c:set var="t_fund_mopr"
														value="${t_fund_mopr+pc.amountProposedMOPR+pc.addtionalRequirementMOPR}" />
													<c:set var="t_unit_mopr"
														value="${t_unit_mopr+pc.noOfUnitsMOPR}" />
													<c:set var="t_fund_cec"
														value="${t_fund_cec+pc.amountProposedCEC+pc.addtionalRequirementCEC}" />
													<c:set var="t_unit_cec"
														value="${t_unit_cec+pc.noOfUnitsCEC}" />
												</tr>

												<c:set var="pscindex" value="0" />

												<c:forEach items="${planComponentsFunds}" var="psc">
													<c:if
														test="${psc.eType eq 'S' and pc.componentsId==psc.componentsId }">
														<c:set var="pscindex" value="${pscindex+1}" />
														<c:set var="moprDiff" value="bg-test" />
														<c:if
															test="${psc.amountProposed gt psc.amountProposedMOPR}">
															<c:set var="moprDiff" value="bg-warning" />
														</c:if>
														<c:set var="moprDiffUnit" value="bg-test" />
														<c:if
															test="${psc.noOfUnits ne psc.noOfUnitsMOPR and psc.noOfUnitsMOPR != null }">
															<c:set var="moprDiffUnit" value="bg-warning" />
														</c:if>
														<c:set var="cecDiff" value="bg-test" />
														<c:if
															test="${psc.amountProposedMOPR+psc.addtionalRequirementMOPR ne psc.amountProposedCEC+psc.addtionalRequirementCEC and psc.amountProposedCEC != null }">
															<c:set var="cecDiff" value="bg-info" />
														</c:if>
														<c:set var="cecDiffUnit" value="bg-test" />
														<c:if
															test="${psc.noOfUnitsMOPR ne psc.noOfUnitsCEC and psc.noOfUnitsCEC != null }">
															<c:set var="cecDiffUnit" value="bg-info" />
														</c:if>
														<tr class="slide${pc.componentsId} expand-all"
															style="display: none;">
															<td></td>
															<td>&#${96+pscindex})</td>

															<td>${psc.eName}</td>
															<td align="center"><fmt:formatNumber type="number"
																	maxFractionDigits="3" value="${psc.amountProposed}" />
															</td>
															<td align="center" class="${moprDiff }"><fmt:formatNumber
																	type="number" maxFractionDigits="3"
																	value="${psc.amountProposedMOPR}" /></td>
															<c:set var="cecDiff" value="bg-test" />
															<c:if
																test="${psc.amountProposedMOPR gt psc.amountProposedCEC}">
																<c:set var="cecDiff" value="bg-danger" />
															</c:if>

															<td align="center" class="${cecDiff}"><fmt:formatNumber
																	type="number" maxFractionDigits="3"
																	value="${psc.amountProposedCEC}" /></td>
														</tr>
													</c:if>
												</c:forEach>
												<c:set var="moprDiff" value="bg-test" />
												<c:if test="${pc.amountProposed gt pc.amountProposedMOPR}">
													<c:set var="moprDiff" value="bg-warning" />
												</c:if>
												<c:set var="moprDiffUnit" value="bg-test" />
												<c:if
													test="${pc.noOfUnits ne pc.noOfUnitsMOPR and pc.noOfUnitsMOPR != null }">
													<c:set var="moprDiffUnit" value="bg-warning" />
												</c:if>
												<c:set var="cecDiff" value="bg-test" />
												<c:if
													test="${pc.amountProposedMOPR+pc.addtionalRequirementMOPR ne pc.amountProposedCEC+pc.addtionalRequirementCEC and pc.amountProposedCEC != null }">
													<c:set var="cecDiff" value="bg-info" />
												</c:if>
												<c:set var="cecDiffUnit" value="bg-test" />
												<c:if
													test="${pc.noOfUnitsMOPR ne pc.noOfUnitsCEC and pc.noOfUnitsCEC != null }">
													<c:set var="cecDiffUnit" value="bg-info" />
												</c:if>
												<c:if
													test="${pscindex eq 0 and pc.componentsId ne 11 and pc.componentsId ne 12}">
													<tr class="slidex${pc.componentsId} expand-all"
														style="display: none;">
														<td></td>
														<td></td>
														<td>${pc.eName}</td>
														<td align="center"><c:if
																test="${pc.amountProposed>0}">
																<fmt:formatNumber type="number" maxFractionDigits="3"
																	value="${pc.amountProposed}" />
															</c:if></td>
														<td align="center" class="${moprDiff}"><c:if
																test="${pc.amountProposedMOPR>0}">
																<fmt:formatNumber type="number" maxFractionDigits="3"
																	value="${pc.amountProposedMOPR}" />
															</c:if></td>
														<td align="center" class="${cecDiff}"><c:if
																test="${pc.amountProposedCEC>0}">
																<fmt:formatNumber type="number" maxFractionDigits="3"
																	value="${pc.amountProposedCEC}" />
															</c:if></td>
													</tr>
												</c:if>
												<c:if
													test="${pc.componentsId ne 11 and pc.componentsId ne 12}">
													<tr class="slidex${pc.componentsId} expand-all"
														style="display: none;">
														<td></td>
														<td></td>

														<td style="color: #0d1d92c9">Additional Requirement</td>
														<td><p align="center">
																<fmt:formatNumber type="number" maxFractionDigits="3"
																	value="${pc.addtionalRequirement}" />
															</p></td>
														<td><p align="center">
																<fmt:formatNumber type="number" maxFractionDigits="3"
																	value="${pc.addtionalRequirementMOPR}" />
															</p></td>
														<td><p align="center">
																<fmt:formatNumber type="number" maxFractionDigits="3"
																	value="${pc.addtionalRequirementCEC}" />
															</p></td>
														<!-- <td></td> -->
													</tr>
												</c:if>
												<c:if test="${pc.componentsId==10}">
													<tr class="table_th">
														<th colspan="10"></th>
													</tr>
													<tr class="table_th">
														<th></th>
														<th></th>
														<th>Sub-Total</th>
														<th><p align="center">
																<c:if test="${t_fund>0}">
																	<fmt:formatNumber type="number" maxFractionDigits="3"
																		value="${t_fund}" />
																</c:if>
															</p></th>
														<th><p align="center">
																<c:if test="${t_fund_mopr>0}">
																	<fmt:formatNumber type="number" maxFractionDigits="3"
																		value="${t_fund_mopr}" />
																</c:if>
															</p></th>
														<th><p align="center">
																<c:if test="${t_fund_cec>0}">
																	<fmt:formatNumber type="number" maxFractionDigits="3"
																		value="${t_fund_cec}" />
																</c:if>
															</p></th>
													</tr>
												</c:if>
											</c:if>
										</c:forEach>
										<tr class="table_th">
											<th colspan="10"></th>
										</tr>
										<tr class="table_th">
											<th></th>
											<th></th>
											<th>Total</th>
											<th><p align="center">
													<c:if test="${t_fund>0}">
														<fmt:formatNumber type="number" maxFractionDigits="3"
															value="${t_fund}" />
													</c:if>
												</p></th>
											<th><p align="center">
													<c:if test="${t_fund_mopr>0}">
														<fmt:formatNumber type="number" maxFractionDigits="3"
															value="${t_fund_mopr}" />
													</c:if>
												</p></th>
											<th><p align="center">
													<c:if test="${t_fund_cec>0}">
														<fmt:formatNumber type="number" maxFractionDigits="3"
															value="${t_fund_cec}" />
													</c:if>
												</p></th>
										</tr>
									</tbody>
								</table>
								</div>
								<div class="text-right">
									<button type="button" class="btn bg-green waves-effect"
										onclick="expandAll('expand')" id="expandButtonId">Expand
										All</button>
									<button type="button" class="btn bg-blue waves-effect"
										onclick="expandAll('collapse')" id="collapseButtonId"
										style="display: none;">Collapse All</button>
									<button type="button" class="btn bg-red waves-effect"
										id="exportButtonId" onclick="exportToPdf('annualPlanBlockPrint')">Export
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