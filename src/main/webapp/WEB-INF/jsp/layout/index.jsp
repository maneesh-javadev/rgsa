<html data-ng-app="publicModule">
	<head>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/dataTables/css/dataTables.bootstrap.min.css">
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/jquery.dataTables.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/dataTables.bootstrap.min.js"></script>
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/kendo/kendo.all.min.js"></script>
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/consolidatedReport/consolidatedReportController.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/consolidatedReport/consolidatedReportService.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>
		
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/font-awesome/font-awesome-4.2.0/css/font-awesome.min.css">
		<%@include file="../taglib/taglib.jsp"%> 
		
		<script>
		
			$(function () {
				$('.js-basic-example').DataTable({
					responsive: true
				});
				
				//alert("Financial year is 2019-2020!");
			});
			
			toggleSubComponent=function(id,flag){
				$(".slide"+id).slideToggle();
				$(".slidex"+id).slideToggle();
				 if($('#collapseRow'+id).css('display') == 'none'){
			     	$("#collapseRow"+id).show();
			     	$("#expendRow"+id).hide();
			     }else{
			     	$("#collapseRow"+id).hide();
			     	$("#expendRow"+id).show();
			     	
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
		</script>
	
		<style type="text/css">
		/*.row {

		    margin-right: -15px;
		    margin-left: 5px;
		    margin-top: 23px;
		    margin-bottom: 44px;

		}*/


		.wizard {
			/*margin-top: 20px;*/
		}
		.wizard .nav-tabs {
			position: relative;
			margin-bottom: 0;
		}
		.wizard > div.wizard-inner {
			position: relative;
		}

		.connecting-line {
			height: 2px;
			background: #e0e0e0;
			position: absolute;
			width: 80%;
			margin: 0 auto;
			left: 0;
			right: 0;
			top: 50%;
			z-index: 1;
			background-color: black;
		}
		.wizard .nav-tabs > li.active > a, .wizard .nav-tabs > li.active > a:hover, .wizard .nav-tabs > li.active > a:focus {
			color: #555555;
			cursor: default;
			border: 0;
			border-bottom-color: transparent;
		}
		span.round-tab {
			width: 70px;
			height: 70px;
			line-height: 70px;
			display: inline-block;
			border-radius: 100px;
			background: #fff;
			border: 2px solid #e0e0e0;
			z-index: 2;
			position: absolute;
			left: 0;
			text-align: center;
			font-size: 25px;
		}
		span.round-tab i{
			color:#555555;
		}
		.wizard li.active span.round-tab {
			background: #fff;
			border: 2px solid #5bc0de;

		}
		.wizard li.active span.round-tab i{
			color: #5bc0de;
		}
		span.round-tab:hover {
			color: #333;
			border: 2px solid #333;
		}
		.wizard .nav-tabs > li {
			width: 25%;
		}
		.wizard li:after {
			content: " ";
			position: absolute;
			left: 46%;
			opacity: 0;
			margin: 0 auto;
			bottom: 0px;
			border: 5px solid transparent;
			border-bottom-color: #5bc0de;
			transition: 0.1s ease-in-out;
		}
		.wizard li.active:after {
			content: " ";
			position: absolute;
			left: 46%;
			opacity: 1;
			margin: 0 auto;
			bottom: 0px;
			border: 10px solid transparent;
			border-bottom-color: #5bc0de;
		}
		.wizard .nav-tabs > li a {
			width: 70px;
			height: 70px;
			margin: 20px auto;
			border-radius: 100%;
			padding: 0;
		}
			.wizard .nav-tabs > li a:hover {
				background: transparent;
			}
			.wizard .tab-pane {
				position: relative;
				padding-top: 50px;
			}
		.wizard h3 {
			margin-top: 0;
		}
		@media( max-width : 585px ) {
			.wizard {
				width: 90%;
				height: auto !important;
			}
			span.round-tab {
				font-size: 16px;
				width: 50px;
				height: 50px;
				line-height: 50px;
			}
			.wizard .nav-tabs > li a {
				width: 50px;
				height: 50px;
				line-height: 50px;
			}
			.wizard li.active:after {
				content: " ";
				position: absolute;
				left: 35%;
			}
		}

		.thumbs{
			text-align: center;
		}

		.thumb-card .thumbnail {
		    min-height: 100px;
		    padding: 10px;
		}

		.thumbnail.dark-1{
			background-color: #3F51B5;
			color: white;
		}
		.thumbnail.dark-2{
			background-color: #9C27B0;
			color: white;
		}
		.thumbnail.dark-3{
			background-color:  #E91E63;
			color: white;
		}
		.thumbnail.dark-4{
			background-color:  #5cb85c;
			color: white;
		}
		.thumbnail.dark-1 > p, .thumbnail.dark-2 > p, .thumbnail.dark-3 > p ,.thumbnail.dark-4 > p {
		    color: ghostwhite;
		}
		.thumbnail.dark-1 > a, .thumbnail.dark-2 > a, .thumbnail.dark-3 > a ,.thumbnail.dark-4 > a {
		    color: ghostwhite;
		    font-size: 10px;
		}
		.nav-tabs > li > a.no-bottom::before{
			border-bottom: none;
		}
		
		</style>
			
	</head>




	<section data-ng-controller="consolidatedReportController" class="content">
		<div class="container-fluid">
			<div class="block-header">
				<h2>
					<spring:message code="Label.dashboard" />
				</h2>
			</div>

			<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
			<div class="row clearfix">
						<!-- Task Info -->
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="card">
							<table width="100%" cellspacing="2px" style="border-spacing: 10px;">
								<thead>
								<tr>
									<th width="20%" class="btn bg-blue"><h4>Plan Status</h4></th>
									<th width="20%" style="float: right;"class="btn bg-green"><h4>${PlanStatusName}</h4></th>
								</tr>
							</thead>
								</table>				
							</div>
						</div>
			</div>
				<!-- <div class="wizard" style="background-color: transparent;">
					<div class="wizard-inner">
						<div class="connecting-line"></div>
						<ul class="nav nav-tabs" role="tablist">
		
							<li role="presentation" class="active"><a href="#step1"
								aria-controls="step1" role="tab" title="Step 1" class="no-bottom"> <span
									class="round-tab"> <i
										class="glyphicon glyphicon-folder-open"></i>
								</span> <p>Plan Submitted</p>
							</a></li>
		
							<li role="presentation" class="disabled"><a href="#step2"
								aria-controls="step2" role="tab" title="Step 2" class="no-bottom"> <span
									class="round-tab"> <i class="glyphicon glyphicon-pencil"></i>
								</span>
							</a></li>
							<li role="presentation" class="disabled"><a href="#step3"
								aria-controls="step3" role="tab" title="Step 3" class="no-bottom"> <span
									class="round-tab"> <i class="glyphicon glyphicon-picture"
										style="color: red;"></i>
								</span>
							</a></li>
		
							<li role="presentation" class="disabled"><a href="#complete"
								aria-controls="complete" role="tab" title="Complete"> <span
									class="round-tab"> <i class="glyphicon glyphicon-ok"
										style="color: green;"></i>
								</span>
							</a></li>
						</ul>
					</div>
				</div> -->
				<div class="table-responsive">
					<div class="row clearfix">
						<!-- Task Info -->
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="card">
		
								<div class="header">
									<h2>Action plan </h2>
		
									<ul class="header-dropdown m-r--5">
										<li class="dropdown"><a href="javascript:void(0);"
											class="dropdown-toggle" data-toggle="dropdown" role="button"
											aria-haspopup="true" aria-expanded="false"> <i
												class="fa fa-globe" aria-hidden="true"></i>
										</a>
											<ul class="dropdown-menu pull-right">
												<li><a href="javascript:void(0);">Action</a></li>
											</ul></li>
									</ul>
								</div>
		
								<div class="body">
									
									<table class="table table-hover dashboard-task-infos">
		
										<thead>
											<tr>
												<th rowspan="2" width="10%"></th>
												<th rowspan="2" width="10%">Sr.No</th>
												<th rowspan="2" width="40%" >Components</th>
												<td colspan="2" align="center" width="40%"><b>State Proposed</b></td>
												
												
											</tr>
											<tr>
												
												
												<td width="20%" align="right"><b>Amount</b></td>
												<td width="20%" align="right" style="padding-right:20px"><b>No. of Unit</b></td>
												
												
											</tr>
										</thead>
										<c:set var="t_fund" value="0"/>
										<c:set var="t_unit" value="0"/>
										<tbody>
										<c:set var="buttonStatus" value="false" />
										<c:set var="iecStatus" value="true" scope="page" />
										<c:set var="pmuStatus" value="true" scope="page" />
										<c:if test="${sessionScope['scopedTarget.userPreference'].planStatus eq 1 or sessionScope['scopedTarget.userPreference'].planStatus eq 3}">
										<c:set var="buttonStatus" value="true" />
										</c:if>
										<c:forEach items="${sessionScope['scopedTarget.userPreference'].statePlanComponentsFunds}" var="pc" varStatus="pcindex">
										  	<c:if test="${pc.eType eq 'C'}">
											  	<c:set var="trStatus" value="bg-test" />
											 	<c:if test="${pc.componentsId eq 11 or pc.componentsId eq 12}">
												 	<c:choose>
														<c:when test="${pc.status eq 'G'}">
																<c:if test="${pc.componentsId eq 11}"><c:set var="iecStatus" value="true" /></c:if>
																<c:if test="${pc.componentsId eq 12}"><c:set var="pmuStatus" value="true" /></c:if>
																<c:set var="trStatus" value="bg-success"/>
														</c:when>
														<c:when test="${pc.status eq 'R'}">
																<c:if test="${pc.componentsId eq 11}"><c:set var="iecStatus" value="false" /></c:if>
																<c:if test="${pc.componentsId eq 12}"><c:set var="pmuStatus" value="false" /></c:if>
																<c:set var="trStatus" value="bg-danger"/>
														</c:when>
													</c:choose>
											  	</c:if>
												<tr class="${trStatus}">
												
														<td align="center" id="plusId${pc.componentsId}" >
															<c:if test="${pc.componentsId ne 11 and pc.componentsId ne 12}">
															<div id="expendRow${pc.componentsId}" onclick="toggleSubComponent('${pc.componentsId}',true)"><i class="fa fa-plus-circle" aria-hidden="true"></i></div>
															<div id="collapseRow${pc.componentsId}" onclick="toggleSubComponent('${pc.componentsId}',false)" style="display:none;"><i class="fa fa-minus-circle" aria-hidden="true"></i></div>
															</c:if>
								 						</td>
														<td><b>${pcindex.count}</b></td>
														<td><b>${pc.eName}</b></td>
														<td align="right">
														<c:if test="${(pc.amountProposed+pc.addtionalRequirement)>0}">
															<b><fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposed+pc.addtionalRequirement}" /></b>
														</c:if>
														</td>
														<td align="right" style="padding-right:20px"><b><c:out value="${pc.noOfUnits}"/></b> </td>
														  
														
														
														<c:set var="t_fund" value="${t_fund+pc.amountProposed+pc.addtionalRequirement}" />
														<c:set var="t_unit" value="${t_unit+pc.noOfUnits}"/>
														
														
														
													</tr>
												
												<c:set var="pscindex" value="0"/> 
												<c:set var="totalNewBuildingInstInfra" value="0"/>
												<c:set var="totalCarryForwardInstInfra" value="0"/>
												<c:set var="totalNewBuildingPanchayat" value="0"/>
												<c:set var="totalCarryForwardPacnhayat" value="0"/>
												
												<c:set var="totalUnitNewBuildingInstInfra" value="0"/>
												<c:set var="totalUnitCarryForwardInstInfra" value="0"/>
												<c:set var="totalUnitNewBuildingPanchayat" value="0"/>
												<c:set var="totalUnitCarryForwardPacnhayat" value="0"/>
												
												<c:forEach items="${sessionScope['scopedTarget.userPreference'].statePlanComponentsFunds}" var="fundTotal">
													<c:if test="${fundTotal.eType eq 'S' and pc.componentsId==fundTotal.componentsId }">
													<c:if test="${fundTotal.subcomponentsId eq 8 or fundTotal.subcomponentsId eq 9}">
														<c:if test="${fundTotal.amountProposed>0}">
														<c:set var="totalNewBuildingInstInfra" value="${totalNewBuildingInstInfra + fundTotal.amountProposed}"/>
														</c:if>
													</c:if>
													<c:if test="${fundTotal.subcomponentsId eq 23 or fundTotal.subcomponentsId eq 24}">
													<c:if test="${fundTotal.amountProposed>0}">
														<c:set var="totalCarryForwardInstInfra" value="${totalCarryForwardInstInfra + fundTotal.amountProposed}"/>
														</c:if>
													</c:if>
													<c:if test="${fundTotal.subcomponentsId eq 12 or fundTotal.subcomponentsId eq 13 or fundTotal.subcomponentsId eq 14}">
													<c:if test="${fundTotal.amountProposed>0}">
														<c:set var="totalNewBuildingPanchayat" value="${totalNewBuildingPanchayat + fundTotal.amountProposed}"/>
														</c:if>
													</c:if>
													<c:if test="${fundTotal.subcomponentsId eq 20 or fundTotal.subcomponentsId eq 21 or fundTotal.subcomponentsId eq 22}">
													<c:if test="${fundTotal.amountProposed>0}">
														<c:set var="totalCarryForwardPacnhayat" value="${totalCarryForwardPacnhayat + fundTotal.amountProposed}"/>
														</c:if>
													</c:if>
													
													
													<c:if test="${fundTotal.subcomponentsId eq 8 or fundTotal.subcomponentsId eq 9}">
														<c:if test="${fundTotal.noOfUnits>0}">
														<c:set var="totalUnitNewBuildingInstInfra" value="${totalUnitNewBuildingInstInfra + fundTotal.noOfUnits}"/>
														</c:if>
													</c:if>
													<c:if test="${fundTotal.subcomponentsId eq 23 or fundTotal.subcomponentsId eq 24}">
													<c:if test="${fundTotal.noOfUnits>0}">
														<c:set var="totalUnitCarryForwardInstInfra" value="${totalUnitCarryForwardInstInfra + fundTotal.noOfUnits}"/>
														</c:if>
													</c:if>
													<c:if test="${fundTotal.subcomponentsId eq 12 or fundTotal.subcomponentsId eq 13 or fundTotal.subcomponentsId eq 14}">
													<c:if test="${fundTotal.noOfUnits>0}">
														<c:set var="totalUnitNewBuildingPanchayat" value="${totalUnitNewBuildingPanchayat + fundTotal.noOfUnits}"/>
														</c:if>
													</c:if>
													<c:if test="${fundTotal.subcomponentsId eq 20 or fundTotal.subcomponentsId eq 21 or fundTotal.subcomponentsId eq 22}">
													<c:if test="${fundTotal.noOfUnits>0}">
														<c:set var="totalUnitCarryForwardPacnhayat" value="${totalUnitCarryForwardPacnhayat + fundTotal.noOfUnits}"/>
														</c:if>
													</c:if>
													</c:if>
												</c:forEach>
												
												<c:forEach items="${sessionScope['scopedTarget.userPreference'].statePlanComponentsFunds}" var="psc" varStatus="index">
													
													<c:if test="${psc.eType eq 'S' and pc.componentsId==psc.componentsId }">
													
													<c:set var="pscindex" value="${pscindex+1}"/>
														<c:if test="${psc.componentsId ne 2 and psc.componentsId ne 3 }">	
														<tr class="slide${pc.componentsId}"  style="display: none;">
															<td></td>
															<td >&#${96+pscindex})</td>
															
															<td >${psc.eName}</td>
															<td align="right">
																<c:if test="${psc.amountProposed>0}">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${psc.amountProposed}" />
																</c:if>
															</td>
															<td align="right" style="padding-right:20px">${psc.noOfUnits}</td>
														</tr>
														</c:if>
													</c:if>
												</c:forEach>
												
												<c:if test="${pc.componentsId eq 2}">
													<tr class="slide${pc.componentsId}"
																	style="display: none;">
																	<td></td>
																	<td align="center">
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
																	<td align="right"><strong><fmt:formatNumber
																				type="number" maxFractionDigits="3"
																				value="${totalNewBuildingInstInfra}" /></strong></td>
																	<td align="right"><strong><fmt:formatNumber
																				type="number" maxFractionDigits="3"
																				value="${totalUnitNewBuildingInstInfra}" /></strong></td>			
																</tr>

													<c:forEach
														items="${sessionScope['scopedTarget.userPreference'].statePlanComponentsFunds}"
														var="innerData">
														<%-- <c:if test="${pc.componentsId == innerData.componentsId}"> --%>
															<c:if test="${innerData.subcomponentsId eq 8 or innerData.subcomponentsId eq 9}">
																<tr class="newBuildingInstituteInfra" style="display: none;">
																	<td></td>
																	<td></td>
																	<td>${innerData.eName}</td>
																	<td align="right"><c:if
																			test="${innerData.amountProposed>0}">
																			<fmt:formatNumber type="number" maxFractionDigits="3"
																				value="${innerData.amountProposed}" />
																		</c:if></td>
																	<td align="right" style="padding-right: 20px">${innerData.noOfUnits}</td>
																</tr>
															<%-- </c:if> --%>
														</c:if>
													</c:forEach>
													
													<tr class="slide${pc.componentsId}" style="display: none;">
															<td></td>
																<td align="center">
																	<div id="carryForwardInstituteInfraExpand${pc.componentsId}" onclick="toggleInstInfraAndPanchayatBhawan('${pc.componentsId}','carryForwardInstituteInfra')"><i class="fa fa-plus-circle" aria-hidden="true"></i></div>
																	<div id="carryForwardInstituteInfraCollapse${pc.componentsId}" onclick="toggleInstInfraAndPanchayatBhawan('${pc.componentsId}','carryForwardInstituteInfra')" style="display:none;"><i class="fa fa-minus-circle" aria-hidden="true"></i></div>
										 						</td>
										 						<td><strong>Carry Forward</strong></td>
										 						<td align="right"><strong><fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${totalCarryForwardInstInfra}" /></strong></td>
										 						<td align="right"><strong><fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${totalUnitCarryForwardInstInfra}" /></strong></td>
													</tr>
													
													<c:forEach
														items="${sessionScope['scopedTarget.userPreference'].statePlanComponentsFunds}"
														var="innerData">
														<%-- <c:if test="${pc.componentsId == innerData.componentsId}"> --%>
															<c:if test="${innerData.subcomponentsId eq 23 or innerData.subcomponentsId eq 24}">
																<tr class="carryForwardInstituteInfra" style="display: none;">
																	<td></td>
																	<td></td>
																	<td>${innerData.eName}</td>
																	<td align="right"><c:if
																			test="${innerData.amountProposed>0}">
																			<fmt:formatNumber type="number" maxFractionDigits="3"
																				value="${innerData.amountProposed}" />==${innerData.amountProposed}
																		</c:if></td>
																	<td align="right" style="padding-right: 20px">${innerData.noOfUnits}</td>
																</tr>
															<%-- </c:if> --%>
														</c:if>
													</c:forEach>

												</c:if>
												
												<c:if test="${pc.componentsId eq 3}">
													<tr class="slide${pc.componentsId}"
																	style="display: none;">
																	<td></td>
																	<td align="center">
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
																	<td align="right"><strong><fmt:formatNumber
																				type="number" maxFractionDigits="3"
																				value="${totalNewBuildingPanchayat}" /></strong></td>
																	<td align="right"><strong><fmt:formatNumber
																				type="number" maxFractionDigits="3"
																				value="${totalUnitNewBuildingPanchayat}" /></strong></td>			
																</tr>

													<c:forEach
														items="${sessionScope['scopedTarget.userPreference'].statePlanComponentsFunds}"
														var="innerData">
														<%-- <c:if test="${pc.componentsId == innerData.componentsId}"> --%>
															<c:if test="${innerData.subcomponentsId eq 12 or innerData.subcomponentsId eq 13 or innerData.subcomponentsId eq 14}">
																<tr class="newBuildingPanchayatBhawan" style="display: none;">
																	<td></td>
																	<td></td>
																	<td>${innerData.eName}</td>
																	<td align="right"><c:if
																			test="${innerData.amountProposed>0}">
																			<fmt:formatNumber type="number" maxFractionDigits="3"
																				value="${innerData.amountProposed}" />
																		</c:if></td>
																	<td align="right" style="padding-right: 20px">${innerData.noOfUnits}</td>
																</tr>
															<%-- </c:if> --%>
														</c:if>
													</c:forEach>
													
													<tr class="slide${pc.componentsId}" style="display: none;">
															<td></td>
																<td align="center">
																	<div id="carryForwardPanchayatBhawanExpand${pc.componentsId}" onclick="toggleInstInfraAndPanchayatBhawan('${pc.componentsId}','carryForwardPanchayatBhawan')"><i class="fa fa-plus-circle" aria-hidden="true"></i></div>
																	<div id="carryForwardPanchayatBhawanCollapse${pc.componentsId}" onclick="toggleInstInfraAndPanchayatBhawan('${pc.componentsId}','carryForwardPanchayatBhawan')" style="display:none;"><i class="fa fa-minus-circle" aria-hidden="true"></i></div>
										 						</td>
										 						<td><strong>Carry Forward</strong></td>
										 						<td align="right"><strong><fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${totalCarryForwardPacnhayat}" /></strong></td>
										 						<td align="right"><strong><fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${totalUnitCarryForwardPacnhayat}" /></strong></td>
													</tr>
													
													<c:forEach
														items="${sessionScope['scopedTarget.userPreference'].statePlanComponentsFunds}"
														var="innerData">
														<%-- <c:if test="${pc.componentsId == innerData.componentsId}"> --%>
															<c:if test="${innerData.subcomponentsId eq 20 or innerData.subcomponentsId eq 21 or innerData.subcomponentsId eq 22}">
																<tr class="carryForwardPanchayatBhawan" style="display: none;">
																	<td></td>
																	<td></td>
																	<td>${innerData.eName}</td>
																	<td align="right"><c:if
																			test="${innerData.amountProposed>0}">
																			<fmt:formatNumber type="number" maxFractionDigits="3"
																				value="${innerData.amountProposed}" />
																		</c:if></td>
																	<td align="right" style="padding-right: 20px">${innerData.noOfUnits}</td>
																</tr>
															<%-- </c:if> --%>
														</c:if>
													</c:forEach>

												</c:if>
												
												<c:if test="${pscindex eq 0 and pc.componentsId ne 11 and pc.componentsId ne 12}">
													<tr class="slidex${pc.componentsId}"  style="display: none;">
															<td></td>
															<td></td>
															<td>${pc.eName}</td>
															<td align="right">
																<c:if test="${pc.amountProposed>0}">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposed}" />
																</c:if>
															</td>
															<td align="right" style="padding-right:20px">${pc.noOfUnits}</td>
													</tr>
												</c:if>
												<c:if test="${pc.componentsId ne 11 and pc.componentsId ne 12}">
													<tr class="slidex${pc.componentsId}"  style="display: none;">
															<td></td>
															<td></td>
															<td style="color: #0d1d92c9">Additional Requirement </td>
															<td><p align="right"><fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.addtionalRequirement}" /></p></td>
															<td></td>
														</tr>
													</c:if>
													<c:if test="${pc.componentsId==10}">
													<tr class="table_th"><th colspan="5"></th></tr>
														<tr class="table_th">
															<th></th>
															<th></th>
															<th>Sub-Total</th>
															<th><p align="right">
															<c:if test="${t_fund>0}">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund}" />
															</c:if>
															</p></th>
															<th><p align="right">
															<c:if test="${t_unit>0}">
															<c:out value="${t_unit}" />
															</c:if>
															</p></th>
															
															
														</tr>
													</c:if>
												</c:if>
										</c:forEach>
											<tr class="table_th"><th colspan="5"></th></tr>
											
											 <tr class="table_th">
												 <th></th>
												<th></th>
												<th>Total</th>
												<th>
													<c:if test="${t_fund>0}">
														<p align="right"><fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund}" /></p>
													</c:if>
												</th>
												<th>
												<c:if test="${t_unit>0}">
												<p align="right"><c:out value="${t_unit}" /></p>
												</c:if>
												</th>
												</tr>
										</tbody>
									</table>
									<c:set var="forwardPlanStatus" value="true" scope="page"></c:set>
									<c:forEach items="${sessionScope['scopedTarget.userPreference'].isFreezeStatusList}" var="KAR98">
										<c:if test="${not empty KAR98.stateIsFreeze and not KAR98.stateIsFreeze}">
											<c:set var="forwardPlanStatus" value="false"></c:set>
										</c:if>
									</c:forEach>
									
									<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
										<!-- <button data-ng-click="exportData()">Download Consolidated Report</button> -->
										<c:if test="${buttonStatus}">
											<c:choose>
												<c:when test="${not forwardPlanStatus or not isallCompVerify}"><input type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal" value="Forward Plan"/></c:when>
												<c:when test="${forwardPlanStatus and isallCompVerify}">
													<c:if test="${isShowForwardButton}">
													<input type="button" class="btn bg-light-blue" data-ng-click="forwardPlan(${forwardPlanStatus})" value="Forward Plan" ng-disabled="btn_disabled"/>
													</c:if>
												</c:when>
												<c:otherwise>something goes wrong during calculation</c:otherwise>
											</c:choose>
										</c:if>	
									</c:if>
									
								<%-- 	<div id="myModal" class="modal fade" role="dialog">
									<div class="modal-dialog modal-lg">
										<!-- Modal content-->
										<div class="modal-content">
											<div class="modal-header">
												<h4>Status of All Action Plan Forms</h4>
												<button type="button" class="close" data-dismiss="modal">&times;</button>
											</div>
											<div class="modal-body">
												<div class="table-responsive">
													<table class="table table-hover">
														<thead style="background-color: #b39ad8;color: #2f2b2bf2;">
															<tr>
															<th><div align="center">S.No.</div></th>
															<th><div align="center">Form Name</div></th>
															<th><div align="center">Status</div></th>
															<th><div align="center">Go to form</div></th>
															</tr>
														</thead>
														<tbody>
															<c:forEach items="${sessionScope['scopedTarget.userPreference'].isFreezeStatusList}" var="KAR98">
																<tr>
																	<td><div align="center"><strong>${KAR98.componentId}.</strong></div></td>
																	<td><div align="center"><strong>${KAR98.componentName}</strong></div></td>
																	<td>
																		<c:choose>
																		<c:when test="${not pmuStatus and KAR98.componentId eq 12}"><div align="center" style="color: red;font-weight: bold;">PMU should be 5% of total Fund</div></c:when>
																			<c:when test="${not iecStatus and KAR98.componentId eq 11}"><div align="center" style="color: red;font-weight: bold;">IEC should be 2% of total Fund</div></c:when>
																			<c:when test="${not empty KAR98.stateIsFreeze and KAR98.stateIsFreeze}"><div align="center" style="color: green;font-weight: bold;">Form Freezed</div></c:when>
																			<c:when test="${not empty KAR98.stateIsFreeze and not KAR98.stateIsFreeze}"><div align="center" style="color: red;font-weight: bold;">Form Not Freezed</div></c:when>
																			<c:otherwise><div align="center" style="color: orange;font-weight: bold;">Form Not filled</div></c:otherwise>
																		</c:choose>
																	</td>
																	<td><div align="center"><span><a href="${KAR98.stateLink}?<csrf:token uri='${KAR98.stateLink}'/>"><i class="fa fa-pencil-square-o fa-lg edit-color" aria-hidden="true"></i></a></span></div></td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
												</div>
											</div>
											<div class="modal-footer">
											<div align="left" style="color: red"><sup>*</sup> In order to forward plan you have to <b><u><i>freeze</u></b> all the forms which are filled.</div>
												<button type="button" class="btn btn-danger"
													data-dismiss="modal">Close</button>
											</div>
										</div>

									</div>
								</div> --%>
								
								<div id="myModal" class="modal fade" role="dialog">
									<div class="modal-dialog modal-lg">
										<!-- Modal content-->
										<div class="modal-content">
											<div class="modal-header">
												<h4>Status of All Action Plan Forms</h4>
												<button type="button" class="close" data-dismiss="modal">&times;</button>
											</div>
											<div class="modal-body">
												<div class="table-responsive">
													<table class="table table-hover">
														<thead style="background-color: #b39ad8;color: #2f2b2bf2;">
															<tr>
															<th><div align="center">S.No.</div></th>
															<th><div align="center">Form Name</div></th>
															<th><div align="center">Fill Status</div></th>
															<th><div align="center">Freeze Status </div></th>
															<th><div align="center">Go to form</div></th>
															</tr>
														</thead>
														<tbody>
															<c:forEach items="${checkAllComponentforForwardPlanList}" var="obj" varStatus="rowstatus">
																<tr>
																	<td><div align="center"><strong>${rowstatus.count}.</strong></div></td>
																	<td>
																		<div align="center"><strong>${obj.componentName}</strong></div>
																		<c:if test="${!obj.checkFilled}">
																		<input type="hidden" value="${obj.masterTableId}" id="tblId" />
																		<input type="hidden" value="${obj.masterTableId}" id="tblId" />
																		</c:if>
																	</td>
																	<td>
																		<c:choose>
																			<c:when test="${not pmuStatus and obj.componentId eq 12}"><div align="center" style="color: red;font-weight: bold;">PMU should be 5% of total Fund</div></c:when>
																			<c:when test="${not iecStatus and obj.componentId eq 11}"><div align="center" style="color: red;font-weight: bold;">IEC should be 2% of total Fund</div></c:when>
																			<c:when test="${obj.checkFilled}"><div align="center" style="color: green;font-weight: bold;">Form filled</div></c:when>
																			<c:otherwise><div align="center" style="color: red;font-weight: bold;">Form Not filled</div></c:otherwise>
																		</c:choose>
																	</td>
																	<td>
																		<c:choose>
																			<c:when test="${obj.checkFreeze}"><div align="center" style="color: green;font-weight: bold;">Form Freezed</div></c:when>
																			<c:otherwise><div align="center" style="color: red;font-weight: bold;">Form Not Freezed</div></c:otherwise>
																		</c:choose>
																	</td>
																	<td><div align="center"><span><a href="${obj.link}?<csrf:token uri='${obj.link}'/>"><i class="fa fa-pencil-square-o fa-lg edit-color" aria-hidden="true"></i></a></span></div></td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
												</div>
											</div>
											<div class="modal-footer">
											<div align="left" style="color: red"><sup>*</sup> In order to forward plan you have to <b><u><i>freeze</u></b> all the forms which are filled.</div>
												<button type="button" class="btn btn-danger"
													data-dismiss="modal">Close</button>
											</div>
										</div>

									</div>
								</div>
								
								</div>
							</div>
						</div>
					</div>
					<!-- #END# Task Info -->
				</div>
			</c:if>
		<%-- 			<%@include file="../../jsp/ConsolidatedReport/consolidatedReport.jsp"%> --%>
			<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">	
				<div class="row clearfix">		
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="card">
							<div class="body">
								<div class="row thumbs">
									<div class="col-md-2 col-xs-6 thumb-card">
										<div class="thumbnail dark-1">
											<h2>${sessionScope['scopedTarget.userPreference'].countPlanSubmittedByState}</h2>
											<p>Plan Submitted By State</p>
											<a href="submitedPlanByState.html?<csrf:token uri='submitedPlanByState.html'/>">More Info <i class="fa fa-arrow-circle-right"></i></a>
										</div>
									</div>
									<div class="col-md-2  col-md-offset-1 col-xs-6 thumb-card">
										<div class="thumbnail dark-2">
											<h2>0</h2>
											<p>Plan Reverted By MOPR</p>
											<a href="statuswisePlanDetails.html?<csrf:token uri='statuswisePlanDetails.html'/>&statusId=3">More Info <i class="fa fa-arrow-circle-right"></i></a>
										</div>
									</div>
									<div class="col-md-2  col-md-offset-1 col-xs-6 thumb-card">
										<div class="thumbnail dark-3">
											<h2>${sessionScope['scopedTarget.userPreference'].countPlanSubmittedByMOPR}</h2>
											<p>Plan forwarded To CEC</p>
											<a href="statuswisePlanDetails.html?<csrf:token uri='statuswisePlanDetails.html'/>&statusId=4">More Info <i class="fa fa-arrow-circle-right"></i></a>
										</div>
									</div>
									<div class="col-md-2  col-md-offset-1 col-xs-6 thumb-card">
										<div class="thumbnail dark-4 ">
											<h2>${sessionScope['scopedTarget.userPreference'].countPlanApprovedByCec}</h2>
											<p>Plan Approved By CEC</p>
											<a href="approvePlanList.html?<csrf:token uri='approvePlanList.html'/>&statusId=5">More Info <i class="fa fa-arrow-circle-right"></i></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			
			<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">	
				<div class="row clearfix">		
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="card">
							<div class="body">
								<div class="row thumbs">
									
									<div class="col-md-2  col-md-offset-1 col-xs-3 thumb-card btn ">
										<div class="btn btn-warning btn-rounded">
											<h2>${sessionScope['scopedTarget.userPreference'].countPlanSubmittedByMOPR}</h2>
											<p>Plan forwarded To CEC</p>
											<a href="submitedPlanByState.html?<csrf:token uri='submitedPlanByState.html'/>">More Info <i class="fa fa-arrow-circle-right"></i></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			
		</div>
	</section>
</html>
											
											 