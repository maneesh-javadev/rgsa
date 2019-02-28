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
			});
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
		.thumbnail.dark-1 > p, .thumbnail.dark-2 > p, .thumbnail.dark-3 > p {
		    color: ghostwhite;
		}
		.thumbnail.dark-1 > a, .thumbnail.dark-2 > a, .thumbnail.dark-3 > a {
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
									<h2>Action plan</h2>
		
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
												<th rowspan="2" width="10%">Sr.No</th>
												<th rowspan="2" width="40%" >Components</th>
												<c:if test="${sessionScope['scopedTarget.userPreference'].userType ne 'S'}">
														<td rowspan="2">View Details</td>
												</c:if>
												<td colspan="2" align="center" width="40%"><b>State Proposed</b></td>
												<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
												<th></th>
												</c:if>
											</tr>
											<tr>
												
												
												<td width="20%" align="right"><b>Amount</b></td>
												<td width="20%" align="right" style="padding-right:20px"><b>No. of Unit</b></td>
												<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
												<th width="10%" >Status</th>
												</c:if>
											</tr>
										</thead>
										<c:set var="t_fund" value="0"/>
										<c:set var="t_unit" value="0"/>
										<tbody>
										
										<c:forEach items="${sessionScope['scopedTarget.userPreference'].statePlanComponentsFunds}" var="pc" varStatus="pcindex">
										  	<c:if test="${pc.eType eq 'C'}">
											  	
													<tr>
														<td><b>${pcindex.count}</b></td>
														<td><b>${pc.eName}</b></td>
														
														<c:if test="${sessionScope['scopedTarget.userPreference'].userType ne 'S'}">
																			<td><b><a href="${pc.link}?menuId=0&<csrf:token uri='${pc.link}'/>">View	Details</a></b></td>
														</c:if>
														<c:choose>
															<c:when test="${pc.componentsId eq 11 or pc.componentsId eq 12}">
																<td align="right"><b>
																		<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposed}" /></b>
																</td>
																<td align="right" style="padding-right:20px"><b><c:out value="${pc.noOfUnits}"/></b> </td>
																 <c:choose>
																	<c:when test="${pc.status eq 'G'}">
																	<td class="bg-success"></td>
																	</c:when>
																	<c:when test="${pc.status eq 'R'}">
																	<td class="bg-danger"></td>
																	</c:when>
																	<c:otherwise>
																	<td></td>
																</c:otherwise>
														</c:choose> 
															</c:when>
															<c:otherwise>
																<td></td>
																<td></td>
																<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
																<td></td>
																</c:if>
															</c:otherwise>
														
														</c:choose>
														
														<c:set var="t_fund" value="${t_fund+pc.amountProposed}" />
														<c:set var="t_unit" value="${t_unit+pc.noOfUnits}"/>
														
														<%-- <c:choose>
															<c:when test="${pc.status eq 'G'}">
															<td class="bg-success"></td>
															</c:when>
															<c:when test="${pc.status eq 'R'}">
															<td class="bg-danger"></td>
															</c:when>
															<c:otherwise>
															<td></td>
															</c:otherwise>
														</c:choose> --%>
														
													</tr>
												
												<c:set var="pscindex" value="0"/> 
												<c:set var="s_fund" value="0" />
												<c:set var="s_unit" value="0"/>
												<c:forEach items="${sessionScope['scopedTarget.userPreference'].statePlanComponentsFunds}" var="psc" >
													<c:if test="${psc.eType eq 'S' and pc.componentsId==psc.componentsId }">
													<c:set var="pscindex" value="${pscindex+1}"/> 	
														<tr>
															<td >&#${96+pscindex})</td>
															
															<td >${psc.eName}</td>
															<td align="right">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${psc.amountProposed}" />
															</td>
															<td align="right" style="padding-right:20px">${psc.noOfUnits}</td>
															<c:set var="t_fund" value="${t_fund+psc.amountProposed}" />
															<c:set var="t_unit" value="${t_unit+psc.noOfUnits}"/>
															<c:set var="s_fund" value="${s_fund+psc.amountProposed}" />
															<c:set var="s_unit" value="${s_unit+psc.noOfUnits}"/>
															<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
															<c:choose>
																<c:when test="${psc.status eq 'G'}">
																<td class="bg-success"></td>
																</c:when>
																<c:when test="${psc.status eq 'R'}">
																<td class="bg-danger"></td>
																</c:when>
																<c:otherwise>
																<td></td>
																</c:otherwise>
															</c:choose>
															</c:if>
														</tr>
													</c:if>
												</c:forEach>
												<c:if test="${pc.componentsId ne 11 and pc.componentsId ne 12}">
													<tr >
															<td></td>
															<td style="color: #0d1d92c9">
															
																<b>Total funds=Funds+Additional Requirement 
																<c:set var="t_fund" value="${t_fund+pc.addtionalRequirement}" />
																<c:choose>
																<c:when test="${pscindex eq 0 and pc.amountProposed>0}">
																(<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposed}" />
																<c:out value="+" />
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.addtionalRequirement}" />)
																
																
																
																</c:when>
																<c:otherwise>
																<c:if test="${s_fund gt 0 }">
																(<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${s_fund}" />
																<c:out value="+" />
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.addtionalRequirement}" />)
																
															
																</c:if>
																</c:otherwise>
																
																</c:choose>
																
																</b>
															</td>
																
																
																<c:if test="${sessionScope['scopedTarget.userPreference'].userType ne 'S'}">
																<th></th>
																</c:if>
																<td><p align="right"><b>
																<c:choose>
																<c:when test="${pscindex eq 0 and pc.amountProposed>0}">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposed+pc.addtionalRequirement}" />
																
																</c:when>
																<c:otherwise>
																<c:if test="${s_fund gt 0 }">
																
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${s_fund+pc.addtionalRequirement}" />
																</c:if>
																</c:otherwise>
																
																</c:choose>
																
																</b>
																</p>
																</td>
																<!-- <th>+</th>
																<th>4500</th>
																<th>=</th>
																<th>670067</th> -->
																<c:choose>
																<c:when test="${pscindex eq 0}">
																<td align="right" style="padding-right:20px">${pc.noOfUnits}</td>
																<c:choose>
																	<c:when test="${pc.status eq 'G'}">
																	<td class="bg-success"></td>
																	</c:when>
																	<c:when test="${pc.status eq 'R'}">
																	<td class="bg-danger"></td>
																	</c:when>
																	<c:otherwise>
																	<td></td>
																	</c:otherwise>
																</c:choose>
																</c:when>
																<c:otherwise>
																<td style="padding-right:20px"><c:if test="${s_fund>0 }"><p align="right"><b><c:out value="${s_unit}" /></b></p></c:if></td>
																<c:choose>
																	<c:when test="${pc.status eq 'G'}">
																	<td class="bg-success"></td>
																	</c:when>
																	<c:when test="${pc.status eq 'R'}">
																	<td class="bg-danger"></td>
																	</c:when>
																	<c:otherwise>
																	<td></td>
																	</c:otherwise>
																</c:choose>
																</c:otherwise>
																
																</c:choose>
																
																
																<td></td>
													</tr>
													</c:if>
													<c:if test="${pc.componentsId==10}">
													<tr class="table_th"><th colspan="5"></th></tr>
														<tr class="table_th">
															<th>Sub-Total</th>
															<th></th>
															<c:if test="${sessionScope['scopedTarget.userPreference'].userType ne 'S'}">
															<th></th>
															</c:if>
															<th><p align="right">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund}" />
															</p></th>
															<th><p align="right"><c:out value="${t_unit}" /></p></th>
															
															<th></th>
														</tr>
													</c:if>
												</c:if>
										</c:forEach>
											<tr class="table_th"><th colspan="5"></th></tr>
											
											 <tr class="table_th">
												<th>Total</th>
												<th></th>
												<c:if test="${sessionScope['scopedTarget.userPreference'].userType ne 'S'}">
												<th></th>
												</c:if>
												<th><p align="right">
													<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund}" />
												</p></th>
												<th><p align="right"><c:out value="${t_unit}" /></p></th>
												
												<th></th>
												</tr>
										</tbody>
									</table>
								<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
									<!-- <button data-ng-click="exportData()">Download Consolidated Report</button> -->
								    <input type="button" class="btn bg-light-blue" data-ng-click="forwardPlan(true)" value="Forward Plan">
								</c:if>
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
									<div class="col-md-3 col-xs-6 thumb-card">
										<div class="thumbnail dark-1">
											<h2>${sessionScope['scopedTarget.userPreference'].countPlanSubmittedByState}</h2>
											<p>Plan Submitted By State</p>
											<a href="submitedPlanByState.html?<csrf:token uri='submitedPlanByState.html'/>">More Info <i class="fa fa-arrow-circle-right"></i></a>
										</div>
									</div>
									<div class="col-md-3  col-md-offset-1 col-xs-6 thumb-card">
										<div class="thumbnail dark-2">
											<h2>0</h2>
											<p>Plan Reverted By MOPR</p>
											<a href="statuswisePlanDetails.html?<csrf:token uri='statuswisePlanDetails.html'/>&statusId=3">More Info <i class="fa fa-arrow-circle-right"></i></a>
										</div>
									</div>
									<div class="col-md-3  col-md-offset-1 col-xs-6 thumb-card">
										<div class="thumbnail dark-3">
											<h2>${sessionScope['scopedTarget.userPreference'].countPlanSubmittedByMOPR}</h2>
											<p>Plan forwarded To CEC</p>
											<a href="statuswisePlanDetails.html?<csrf:token uri='statuswisePlanDetails.html'/>&statusId=4">More Info <i class="fa fa-arrow-circle-right"></i></a>
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