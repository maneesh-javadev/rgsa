<%@include file="../taglib/taglib.jsp"%>
<link
	href="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.css"
	rel="stylesheet">

<script
	src="https://unpkg.com/tableexport.jquery.plugin/tableExport.min.js"></script>
<script
	src="https://unpkg.com/tableexport.jquery.plugin/libs/jsPDF/jspdf.min.js"></script>
<script
	src="https://unpkg.com/tableexport.jquery.plugin/libs/jsPDF-AutoTable/jspdf.plugin.autotable.js"></script>
<script
	src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.js"></script>
<script
	src="https://unpkg.com/bootstrap-table@1.15.5/dist/extensions/export/bootstrap-table-export.min.js"></script>
<%-- <script
	src="${pageContext.request.contextPath}/resources/bootstrap-table/extensions/export/bootstrap-table-export.min.js"></script>
 --%>
<script>
	$(document).ready(function() {
		$('#finYearSelectId').val('${VIEW_REPORT_MODEL.finYearId}');
		$('#stateDropDownId').val('${VIEW_REPORT_MODEL.stateCode}');
		var finYear=$('#finYearSelectId').val();
		var stateCode=$('#stateDropDownId').val();
		/* (finYear > 0) ? $('#stateDropDownBlock').show() : $('#stateDropDownBlock').hide() ;
		(stateCode > 0) ? $('#optionChoosingBlock').show() : $('#optionChoosingBlock').hide() ;
	 */	if ('${VIEW_REPORT_MODEL.isAnnualPlan}' == 'true') {
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
			
			if(id==2){
	    		 $('.newBuildingInstituteInfra').hide();
	    		$('.carryForwardInstituteInfra').hide();
	    		$('#newBuildingInstituteInfraCollapse'+id).hide();
	       	$('#newBuildingInstituteInfraExpand'+id).show();
	    		$('#carryForwardInstituteInfraCollapse'+id).hide();
	       	$('#carryForwardInstituteInfraExpand'+id).show();
	    	}
	    	
	    	if(id==3){
	    		$('.newBuildingPanchayatBhawan').hide();
	    		$('.carryForwardPanchayatBhawan').hide();
	    		$('#newBuildingPanchayatBhawanCollapse'+id).hide();
	       	$('#newBuildingPanchayatBhawanExpand'+id).show();
	    		$('#carryForwardPanchayatBhawanCollapse'+id).hide();
	       	$('#carryForwardPanchayatBhawanExpand'+id).show();
	    	}
		}

	};
	
	toggleInstInfraAndPanchayatBhawan=function(id,msg){
		 if($('#'+ msg +'Collapse'+ id).css('display') == 'none'){
	   	$('#'+msg+'Collapse'+id).show();
	   	$('#'+msg+'Expand'+id).hide();
	   }else{
	   	$('#'+msg+'Collapse'+id).hide();
	   	$('#'+msg+'Expand'+id).show();
	   }
		 $('.'+msg).slideToggle();
	}

	function expandAll(msg) {
		if (msg == 'expand') {
			$('.mainTrId').css("background-color","#d9edf7");
			$(".expand-all").slideToggle();
			$("#collapseButtonId").show();
			$("#expandButtonId").hide();
			$(".collapseRowAll").show();
			$(".expendRowAll").hide();
			
			$('.newBuildingInstituteInfra').show();
	    	$('.carryForwardInstituteInfra').show();
	    	
	    	$('#newBuildingInstituteInfraCollapse2').show();
	       	$('#newBuildingInstituteInfraExpand2').hide();
    		$('#carryForwardInstituteInfraCollapse2').show();
	       	$('#carryForwardInstituteInfraExpand2').hide();

	       	$('.newBuildingPanchayatBhawan').show();
    		$('.carryForwardPanchayatBhawan').show();
	       	
	       	$('#newBuildingPanchayatBhawanCollapse3').show();
	       	$('#newBuildingPanchayatBhawanExpand3').hide();
    		$('#carryForwardPanchayatBhawanCollapse3').show();
	       	$('#carryForwardPanchayatBhawanExpand3').hide();
		} else {
			$('.mainTrId').css("background-color","white ");
			$(".expand-all").slideToggle();
			$("#collapseButtonId").hide();
			$("#expandButtonId").show();
			$(".collapseRowAll").hide();
			$(".expendRowAll").show();
			$('.newBuildingInstituteInfra').hide();
	    	$('.carryForwardInstituteInfra').hide();
	    	
	    	$('#newBuildingInstituteInfraCollapse2').hide();
	       	$('#newBuildingInstituteInfraExpand2').show();
    		$('#carryForwardInstituteInfraCollapse2').hide();
	       	$('#carryForwardInstituteInfraExpand2').show();
	       	
	    	$('.newBuildingPanchayatBhawan').hide();
    		$('.carryForwardPanchayatBhawan').hide();
	       	
	       	$('#newBuildingPanchayatBhawanCollapse3').hide();
	       	$('#newBuildingPanchayatBhawanExpand3').show();
    		$('#carryForwardPanchayatBhawanCollapse3').hide();
	       	$('#carryForwardPanchayatBhawanExpand3').show();
		}
	}

	function showStateDropDown() {
		$('#finYearSelectId').val() > 0 ? $('#stateDropDownBlock').show()
				: $('#stateDropDownBlock').hide();
		$('#stateDropDownId').val(0)
		$('#demoGraphicId').attr("checked", false);
		$('#annualActionPlanId').attr("checked", false);
		$('#demoGraphicBlock').hide();
		$('#annualPlanBlock').hide();
	}
	/* function submitToPost() {
		document.viewReportAtMopr.method = "post";
		document.viewReportAtMopr.action = "viewReportAnnualAction.html?<csrf:token uri='viewReportAnnualAction.html'/>";
		document.viewReportAtMopr.submit();
	} */
	function showDemoGraphAndAnnualOption() {
		$('#stateDropDownId').val() > 0 ? $('#optionChoosingBlock').show() : $('#optionChoosingBlock').hide();
		$('#demoGraphicId').attr("checked", false);
		$('#annualActionPlanId').attr("checked", false);
		$('#demoGraphicBlock').hide();
		$('#annualPlanBlock').hide();
	}

	function showTableContent(msg) {
	
			if ($('#demoGraphicId').is(':checked')) {
				$('#demoGraphicId').attr("checked", false);
			}
			$('#annualPlanBlock').show();
			$('#demoGraphicBlock').hide();
			$('#annualActionPlanId').val(true);
		
		submitToPost();
	}

	function exportToPdf(id) {
		 var finYear = $('#finYearSelectId').find('option:selected').text();
		 var stateName = $('#stateDropDownId').find('option:selected').text();
		 var header = 'Annual action plan '+ finYear + ' - ' + $.trim(stateName);
		 var sTable =$('#annualPlanBlockPrint').html();
		 var style = "<style>";
		
		 	 style = style + "table,th,td{border: solid 1px black;border-collapse: collapse;}";
	         style = style + "thead {color : white; background-color: #9071bf;";
	         style = style + "</style>";
		
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
						<h3 style="padding-top: 25px;">&nbsp;&nbsp; Annual action
							plan Report</h3>
					</div>
					<br />
					<form:form method="post" name="viewReportAtMopr" action=""
						modelAttribute="VIEW_REPORT_MODEL">
						<div class="row">
							<div class="col-sm-3">
							</div>
							<div class="col-sm-2">
								<label for="finYear">&nbsp;&nbsp; Financial year : </label>
							</div>
							<div class="col-sm-4">
								<span class="badge badge-success">${FIN_YEAR}</span>
							</div>
						</div>
						<br />

						<div class="row" id="stateDropDownBlock">
							<div class="col-sm-3">
							</div>
							<div class="col-sm-2">
								<label for="state">&nbsp;&nbsp; State : </label>
							</div>
							
							<div class="col-sm-4">
								<span class="badge badge-success"><strong>${STATE.stateNameEnglish}</strong>
								</span>
							</div>
						</div>
						<br />
						<input type="hidden" id="annualActionPlanId" class="radio"
							name="isAnnualPlan" />


						<div class="body">

							<div id="annualPlanBlock">
								<hr />
								<div id="annualPlanBlockPrint">
									<table
										class="table table-hover table-bordered dashboard-task-infos"
										id="annualReportTable">

										<thead style="background-color: #9071bf; color: white;">
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

											<!-- declaration of variables -->
											<c:set var="totalNewBuildingStateInstInfra" value="0" />
											<c:set var="totalCarryForwardStateInstInfra" value="0" />

											<c:set var="totalNewBuildingMoprInstInfra" value="0" />
											<c:set var="totalCarryForwardMoprInstInfra" value="0" />

											<c:set var="totalNewBuildingCecInstInfra" value="0" />
											<c:set var="totalCarryForwardCecInstInfra" value="0" />

											<c:set var="totalNewBuildingStatePanchayat" value="0" />
											<c:set var="totalCarryForwardStatePacnhayat" value="0" />

											<c:set var="totalNewBuildingMoprPanchayat" value="0" />
											<c:set var="totalCarryForwardMoprPacnhayat" value="0" />

											<c:set var="totalNewBuildingCecPanchayat" value="0" />
											<c:set var="totalCarryForwardCecPacnhayat" value="0" />

											<!--  -->

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

															<c:if
																test="${psc.subcomponentsId eq 8 or psc.subcomponentsId eq 9}">
																<c:if test="${psc.amountProposed>0}">
																	<c:set var="totalNewBuildingStateInstInfra"
																		value="${totalNewBuildingStateInstInfra + psc.amountProposed}" />
																</c:if>
																<c:if test="${psc.amountProposedMOPR>0}">
																	<c:set var="totalNewBuildingMoprInstInfra"
																		value="${totalNewBuildingMoprInstInfra + psc.amountProposedMOPR}" />
																</c:if>
																<c:if test="${psc.amountProposedCEC>0}">
																	<c:set var="totalNewBuildingCecInstInfra"
																		value="${totalNewBuildingCecInstInfra + psc.amountProposedCEC}" />
																</c:if>
															</c:if>

															<c:if
																test="${psc.subcomponentsId eq 23 or psc.subcomponentsId eq 24}">
																<c:if test="${psc.amountProposed>0}">
																	<c:set var="totalCarryForwardStateInstInfra"
																		value="${totalCarryForwardStateInstInfra + psc.amountProposed}" />
																</c:if>
																<c:if test="${psc.amountProposedMOPR>0}">
																	<c:set var="totalCarryForwardMoprInstInfra"
																		value="${totalCarryForwardMoprInstInfra + psc.amountProposedMOPR}" />
																</c:if>

																<c:if test="${psc.amountProposedCEC>0}">
																	<c:set var="totalCarryForwardCecInstInfra"
																		value="${totalCarryForwardCecInstInfra + psc.amountProposedCEC}" />
																</c:if>
															</c:if>

															<c:if
																test="${psc.subcomponentsId eq 12 or psc.subcomponentsId eq 13 or psc.subcomponentsId eq 14}">
																<c:if test="${psc.amountProposed>0}">
																	<c:set var="totalNewBuildingStatePanchayat"
																		value="${totalNewBuildingStatePanchayat + psc.amountProposed}" />
																</c:if>
																<c:if test="${psc.amountProposedMOPR>0}">
																	<c:set var="totalNewBuildingMoprPanchayat"
																		value="${totalNewBuildingMoprPanchayat + psc.amountProposedMOPR}" />
																</c:if>
																<c:if test="${psc.amountProposedCEC>0}">
																	<c:set var="totalNewBuildingCecPanchayat"
																		value="${totalNewBuildingCecPanchayat + psc.amountProposedCEC}" />
																</c:if>
															</c:if>

															<c:if
																test="${psc.subcomponentsId eq 20 or psc.subcomponentsId eq 21 or psc.subcomponentsId eq 22}">
																<c:if test="${psc.amountProposed>0}">
																	<c:set var="totalCarryForwardStatePacnhayat"
																		value="${totalCarryForwardStatePacnhayat + psc.amountProposed}" />
																</c:if>
																<c:if test="${psc.amountProposedMOPR>0}">
																	<c:set var="totalCarryForwardMoprPacnhayat"
																		value="${totalCarryForwardMoprPacnhayat + psc.amountProposedMOPR}" />
																</c:if>
																<c:if test="${psc.amountProposedCEC>0}">
																	<c:set var="totalCarryForwardCecPacnhayat"
																		value="${totalCarryForwardCecPacnhayat + psc.amountProposedCEC}" />
																</c:if>
															</c:if>



															<c:if
																test="${psc.componentsId ne 2 and psc.componentsId ne 3 }">
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
														</c:if>
													</c:forEach>

													<!-- for institutional infra modification -->
													<c:if test="${pc.componentsId eq 2}">
														<tr class="slide${pc.componentsId} expand-all"
															style="display: none;">
															<td></td>
															<td>
																<div
																	id="newBuildingInstituteInfraExpand${pc.componentsId}"
																	onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'newBuildingInstituteInfra')">
																	<i class="fa fa-plus-circle" aria-hidden="true"></i>
																</div>

																<div
																	id="newBuildingInstituteInfraCollapse${pc.componentsId}"
																	onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'newBuildingInstituteInfra')"
																	style="display: none;">
																	<i class="fa fa-minus-circle" aria-hidden="true"></i>
																</div>
															</td>
															<td><strong>New Building</strong></td>
															<!-- <td></td> -->
															<td align="center"><fmt:formatNumber type="number"
																	maxFractionDigits="3"
																	value="${totalNewBuildingStateInstInfra}" /></td>
															<%-- <td align="right" style="padding-right: 20px"><b><c:out
																		value="${totalUnitNewBuildingStateInstInfra}" /></b></td> --%>
															<td align="center" class="${moprDiff }"><fmt:formatNumber
																	type="number" maxFractionDigits="3"
																	value="${totalNewBuildingMoprInstInfra}" /></td>
															<%-- <td align="right" style="padding-right: 20px"><b><c:out
																		value="${totalUnitNewBuildingMoprInstInfra}" /></b></td> --%>
															<td align="center" class="${cecDiff }"><fmt:formatNumber
																	type="number" maxFractionDigits="3"
																	value="${totalNewBuildingCecInstInfra}" /></td>
															<%-- <td align="right" style="padding-right: 20px"
																class="${cecDiff }"><b><c:out
																		value="${totalUnitNewBuildingCecInstInfra}" /></b></td> --%>
														</tr>

														<c:forEach items="${planComponentsFunds}" var="innerData">
															<c:if
																test="${innerData.eType eq 'S' and pc.componentsId eq 2}"></c:if>
															<c:if
																test="${innerData.subcomponentsId eq 8 or innerData.subcomponentsId eq 9}">
																<tr class="newBuildingInstituteInfra"
																	style="display: none;">
																	<td></td>
																	<td></td>
																	<td>${innerData.eName}</td>
																	<!-- <td></td> -->
																	<td align="center"><fmt:formatNumber type="number"
																			maxFractionDigits="3"
																			value="${innerData.amountProposed}" /></td>
																	<%-- <td align="right" style="padding-right: 20px"><b><c:out
																				value="${innerData.noOfUnits}" /></b></td> --%>
																	<td align="center"><fmt:formatNumber type="number"
																			maxFractionDigits="3"
																			value="${innerData.amountProposedMOPR}" /></td>
																	<%-- <td align="right" style="padding-right: 20px"><b><c:out
																				value="${innerData.noOfUnitsMOPR}" /></b></td> --%>
																	<td align="center"><fmt:formatNumber type="number"
																			maxFractionDigits="3"
																			value="${innerData.amountProposedCEC}" /></td>
																	<%-- <td align="right" style="padding-right: 20px"><b><c:out
																				value="${innerData.noOfUnitsCEC}" /></b></td> --%>
																</tr>
															</c:if>
														</c:forEach>

														<!-- carry forward institutional infra -->

														<tr class="slide${pc.componentsId} expand-all"
															style="display: none;">
															<td></td>
															<td>
																<div
																	id="carryForwardInstituteInfraExpand${pc.componentsId}"
																	onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'carryForwardInstituteInfra')">
																	<i class="fa fa-plus-circle" aria-hidden="true"></i>
																</div>

																<div
																	id="carryForwardInstituteInfraCollapse${pc.componentsId}"
																	onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'carryForwardInstituteInfra')"
																	style="display: none;">
																	<i class="fa fa-minus-circle" aria-hidden="true"></i>
																</div>
															</td>
															<td><strong>Carry Forward</strong></td>
															<!-- 	<td></td> -->
															<td align="center"><fmt:formatNumber type="number"
																	maxFractionDigits="3"
																	value="${totalCarryForwardStateInstInfra}" /></td>
															<%-- <td align="right" style="padding-right: 20px"><b><c:out
																		value="${totalUnitCarryForwardStateInstInfra}" /></b></td> --%>
															<td align="center" class="${moprDiff }"><fmt:formatNumber
																	type="number" maxFractionDigits="3"
																	value="${totalCarryForwardMoprInstInfra}" /></td>
															<%-- <td align="right" style="padding-right: 20px"><b><c:out
																		value="${totalUnitCarryForwardMoprInstInfra}" /></b></td> --%>
															<td align="center" class="${cecDiff }"><fmt:formatNumber
																	type="number" maxFractionDigits="3"
																	value="${totalCarryForwardCecInstInfra}" /></td>
															<%-- <td align="right" style="padding-right: 20px"
																class="${cecDiff }"><b><c:out
																		value="${totalUnitCarryForwardCecInstInfra}" /></b></td> --%>
														</tr>

														<c:forEach items="${planComponentsFunds}" var="innerData">
															<c:if
																test="${innerData.eType eq 'S' and pc.componentsId eq 2}"></c:if>
															<c:if
																test="${innerData.subcomponentsId eq 23 or innerData.subcomponentsId eq 24}">
																<tr class="carryForwardInstituteInfra"
																	style="display: none;">
																	<td></td>
																	<td></td>
																	<td>${innerData.eName}</td>
																	<!-- <td></td> -->
																	<td align="center"><fmt:formatNumber type="number"
																			maxFractionDigits="3"
																			value="${innerData.amountProposed}" /></td>
																	<%-- <td align="right" style="padding-right: 20px"><b><c:out
																				value="${innerData.noOfUnits}" /></b></td> --%>
																	<td align="center"><fmt:formatNumber type="number"
																			maxFractionDigits="3"
																			value="${innerData.amountProposedMOPR}" /></td>
																	<%-- <td align="right" style="padding-right: 20px"><b><c:out
																				value="${innerData.noOfUnitsMOPR}" /></b></td> --%>
																	<td align="center"><fmt:formatNumber type="number"
																			maxFractionDigits="3"
																			value="${innerData.amountProposedCEC}" /></td>
																	<%-- <td align="right" style="padding-right: 20px"><b><c:out
																				value="${innerData.noOfUnitsCEC}" /></b></td> --%>
																</tr>
															</c:if>
														</c:forEach>
													</c:if>
													<!--  -->


													<!-- panchayat bhawan bifurcation in new building and carry forward -->
													<c:if test="${pc.componentsId eq 3}">
														<tr class="slide${pc.componentsId} expand-all"
															style="display: none;">
															<td></td>
															<td>
																<div
																	id="newBuildingPanchayatBhawanExpand${pc.componentsId}"
																	onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'newBuildingPanchayatBhawan')">
																	<i class="fa fa-plus-circle" aria-hidden="true"></i>
																</div>

																<div
																	id="newBuildingPanchayatBhawanCollapse${pc.componentsId}"
																	onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'newBuildingPanchayatBhawan')"
																	style="display: none;">
																	<i class="fa fa-minus-circle" aria-hidden="true"></i>
																</div>
															</td>
															<td><strong>New Building</strong></td>
															<!-- <td></td> -->
															<td align="center"><fmt:formatNumber type="number"
																	maxFractionDigits="3"
																	value="${totalNewBuildingStatePanchayat}" /></td>
															<%-- <td align="right" style="padding-right: 20px"><b><c:out
																		value="${totalUnitNewBuildingStatePanchayat}" /></b></td> --%>
															<td align="center" class="${moprDiff }"><fmt:formatNumber
																	type="number" maxFractionDigits="3"
																	value="${totalNewBuildingMoprPanchayat}" /></td>
															<%-- <td align="right" style="padding-right: 20px"><b><c:out
																		value="${totalUnitNewBuildingMoprPanchayat}" /></b></td> --%>
															<td align="center" class="${cecDiff }"><fmt:formatNumber
																	type="number" maxFractionDigits="3"
																	value="${totalNewBuildingCecPanchayat}" /></td>
															<%-- <td align="right" style="padding-right: 20px"
																class="${cecDiff }"><b><c:out
																		value="${totalUnitNewBuildingCecPanchayat}" /></b></td> --%>
														</tr>

														<c:forEach items="${planComponentsFunds}" var="innerData">
															<c:if
																test="${innerData.eType eq 'S' and pc.componentsId eq 3}"></c:if>
															<c:if
																test="${innerData.subcomponentsId eq 12 or innerData.subcomponentsId eq 13 or innerData.subcomponentsId eq 14}">
																<tr class="newBuildingPanchayatBhawan"
																	style="display: none;">
																	<td></td>
																	<td></td>
																	<td>${innerData.eName}</td>
																	<!-- <td></td> -->
																	<td align="center"><fmt:formatNumber type="number"
																			maxFractionDigits="3"
																			value="${innerData.amountProposed}" /></td>
																	<%-- <td align="right" style="padding-right: 20px"><b><c:out
																				value="${innerData.noOfUnits}" /></b></td> --%>
																	<td align="center"><fmt:formatNumber type="number"
																			maxFractionDigits="3"
																			value="${innerData.amountProposedMOPR}" /></td>
																	<%-- <td align="right" style="padding-right: 20px"><b><c:out
																				value="${innerData.noOfUnitsMOPR}" /></b></td> --%>
																	<td align="center"><fmt:formatNumber type="number"
																			maxFractionDigits="3"
																			value="${innerData.amountProposedCEC}" /></td>
																	<%-- <td align="right" style="padding-right: 20px"><b><c:out
																				value="${innerData.noOfUnitsCEC}" /></b></td> --%>
																</tr>
															</c:if>
														</c:forEach>

														<!-- carry forward entry -->
														<tr class="slide${pc.componentsId} expand-all"
															style="display: none;">
															<td></td>
															<td>
																<div
																	id="carryForwardPanchayatBhawanExpand${pc.componentsId}"
																	onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'carryForwardPanchayatBhawan')">
																	<i class="fa fa-plus-circle" aria-hidden="true"></i>
																</div>

																<div
																	id="carryForwardPanchayatBhawanCollapse${pc.componentsId}"
																	onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'carryForwardPanchayatBhawan')"
																	style="display: none;">
																	<i class="fa fa-minus-circle" aria-hidden="true"></i>
																</div>
															</td>
															<td><strong>Carry Forward</strong></td>
															<!-- <td></td> -->
															<td align="center"><fmt:formatNumber type="number"
																	maxFractionDigits="3"
																	value="${totalCarryForwardStatePacnhayat}" /></td>
															<%-- <td align="right" style="padding-right: 20px"><b><c:out
																		value="${totalUnitCarryForwardStatePacnhayat}" /></b></td> --%>
															<td align="center" class="${moprDiff }"><fmt:formatNumber
																	type="number" maxFractionDigits="3"
																	value="${totalCarryForwardMoprPacnhayat}" /></td>
															<%-- <td align="right" style="padding-right: 20px"><b><c:out
																		value="${totalUnitCarryForwardMoprPacnhayat}" /></b></td> --%>
															<td align="center" class="${cecDiff }"><fmt:formatNumber
																	type="number" maxFractionDigits="3"
																	value="${totalCarryForwardCecPacnhayat}" /></td>
															<%-- <td align="right" style="padding-right: 20px"
																class="${cecDiff }"><b><c:out
																		value="${totalUnitCarryForwardCecPacnhayat}" /></b></td> --%>
														</tr>

														<c:forEach items="${planComponentsFunds}" var="innerData">
															<c:if
																test="${innerData.eType eq 'S' and pc.componentsId eq 3}"></c:if>
															<c:if
																test="${innerData.subcomponentsId eq 20 or innerData.subcomponentsId eq 21 or innerData.subcomponentsId eq 22}">
																<tr class="carryForwardPanchayatBhawan"
																	style="display: none;">
																	<td></td>
																	<td></td>
																	<td>${innerData.eName}</td>
																	<!-- <td></td> -->
																	<td align="center"><fmt:formatNumber type="number"
																			maxFractionDigits="3"
																			value="${innerData.amountProposed}" /></td>
																	<%-- <td align="right" style="padding-right: 20px"><b><c:out
																				value="${innerData.noOfUnits}" /></b></td> --%>
																	<td align="center"><fmt:formatNumber type="number"
																			maxFractionDigits="3"
																			value="${innerData.amountProposedMOPR}" /></td>
																	<%-- <td align="right" style="padding-right: 20px"><b><c:out
																				value="${innerData.noOfUnitsMOPR}" /></b></td> --%>
																	<td align="center"><fmt:formatNumber type="number"
																			maxFractionDigits="3"
																			value="${innerData.amountProposedCEC}" /></td>
																	<%-- <td align="right" style="padding-right: 20px"><b><c:out
																				value="${innerData.noOfUnitsCEC}" /></b></td> --%>
																</tr>
															</c:if>
														</c:forEach>
														<!--  -->
													</c:if>
													<!--  -->


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
										id="exportButtonId"
										onclick="exportToPdf('annualPlanBlockPrint')">Export
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

<!-- <script>
$(document).ready(function() {
    $('#annualReportTable').DataTable();
} );

</script> -->


<!-- <script>
  var $table = $('#annualReportTable')

  $(function() {
    $('#toolbar').find('select').change(function () {
      $table.bootstrapTable('destroy').bootstrapTable({
        exportDataType: $(this).val(),
        exportTypes: ['json', 'xml', 'csv', 'txt', 'sql', 'excel', 'pdf'],
        columns: [
          
          {
            field: 'rowId',
            title: 'Sr.No'
          }, {
            field: 'eName',
            title: 'Components'
          }, {
            field: 'amountProposed',
            title: 'Amount State Proposed'
          },{
              field: 'amountProposedMOPR',
              title: 'Amount Ministry Recomended'
            },{
                field: 'amountProposedCEC',
                title: 'Amount CEC Approved'
              }
        ]
      })
    }).trigger('change')
  })
</script>
 -->