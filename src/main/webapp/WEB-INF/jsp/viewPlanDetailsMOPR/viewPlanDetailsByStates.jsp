<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html data-ng-app="publicModule">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%@include file="../taglib/taglib.jsp"%>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/planSubmittedByStates/viewPlanDetailsController.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/consolidatedReport/consolidatedReportService.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/adminTechSupportSaff/adminTechSupportSaffService.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/satcomeIpBasedTech/satcomService.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pesaPlan/pesa-plan-model.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pesaPlan/pesaPlanService.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
</head>
<body>

<section class="content" data-ng-controller="adminTechSupportSaffController">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Plan Forwarded by State (${stateName})</h2>
						</div>
						<div class="body">
						
						
						<table class="table table-bordered">
							<thead>
								<tr>
									<th width="10%">Sr.No</th>
									<th width="40%">Components</th>
									<th width="10%">Amount Proposed by State</th>
									<th width="20%">No. of Unit</th>
									<th width="20%">Activity Admissible</th>
									<th width="20">Remarks</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${PLAN_ALLOCATION_LIST}" var="planCompotents" varStatus="index">
									<tr>
										<td><b>${index.count}</b></td>
										<td><b>${planCompotents.componentName}</b></td>
										<td colspan="4"><b><a href="${planCompotents.componentLink}?menuId=0&<csrf:token uri='${planCompotents.componentLink}'/>">View Details</a></b></td>
									</tr>
									<c:forEach items="${planCompotents.subcomponents}" var="subComponents" varStatus="status">
										<tr>
											<td>
												&#${96+status.count}
											</td>
											<td>
										 		${subComponents.subcomponentName}
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
										</tr>
									</c:forEach>
								</c:forEach> 
							</tbody>

						</table>
						
						
							<%-- <div class="card" ng-controller="adminTechSupportSaffController">
								<div class="sub-header">
										<h4>Administrative & Technical Support to Gram Panchayat</h4>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<!-- <tr>
												<td>Additional Requirement</td>
												<td>
													<input type="text" class="form-control" data-ng-model="adminTechStaffObject.additionalRequirement" placeholder="fund " />
												</td>
											</tr> -->
											<tr>
												<td>Total Proposed Fund</td>
												<td><b>Rs. {{grandTotal}}</b></td>
												<td><b><a href="adminTechsupportStaffForMOPR.html?<csrf:token uri='adminTechsupportStaffForMOPR.html'/>">View Details</a></b></td>
											</tr>
										</tbody>
									</table>
       							</div>
							</div> --%>
							<%-- <div class="card" data-ng-controller="pesaPlanController">
								<div class="sub-header">
										<h4>PESA Plan</h4>
								</div>
								
						        	<div class="table-responsive">

								
								<table class="table table-bordered">
									<tbody>
										<!-- <tr>
											<td>Additional Requirement</td>
											<td>
												<input type="text" class="form-control" data-ng-model="adminTechStaffObject.additionalRequirement" placeholder="fund " />
											</td>
										</tr> -->
										<tr>
											<td>Total Proposed Fund</td>
											<td>Rs. {{grandTotal}}</td>
											<td><b><a href="pesaPlanForMOPR.html?<csrf:token uri='pesaPlanForMOPR.html'/>">View Details</a></b></td>
										</tr>
									</tbody>
								</table>
								
       							</div>
							</div> --%>
							<%-- <div class="card">
								<div class="sub-header">
										<h4>Plan For Training Activity</h4>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
										
											<tr>
												<td>Total Proposed Fund</td>
												
												<c:if test="${not empty allTrainingActivity}">
		                                        	<c:forEach items="${allTrainingActivity.trainingActivityDetailsList}" var="obj" varStatus="count">
		                                        		<c:set var="totalFundToCalc" value="${totalFundToCalc + obj.funds}"></c:set>
		                                        	</c:forEach>
		                                        	<c:set var="totalFundToCalc" value="${totalFundToCalc + allTrainingActivity.additionalRequirement}"></c:set>
												</c:if>
												<td>Rs. ${totalFundToCalc}</td>
												<td><b><a href="planForCapacityBuilding.html?menuId=0&<csrf:token uri='planForCapacityBuilding.html'/>">View Details</a></b></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div> --%>
							
							<%-- <div class="card">
								<div class="sub-header">
										<h4>e-Enablement of Panchayats</h4>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td>Total Proposed Fund</td>
												<td>Rs. ${enablementFund}</td>
												<td><b><a href="enablepanchayat.html?<csrf:token uri='enablepanchayat.html'/>">View Details</a></b></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div> --%>
							<%-- <div class="card">
								<div class="sub-header">
										<h4>e-Governance Support Group</h4>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td>Total Proposed Fund</td>
												<td>Rs. ${eGovActivityDetails}</td>
												<td><b><a href="egovernancesupportgroup.html?<csrf:token uri='egovernancesupportgroup.html'/>">View Details</a></b></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div> --%>
							<%-- <div class="card">
								<div class="sub-header">
										<h4>innovativeActivity</h4>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td>Total Proposed Fund</td>
												<td>Rs. ${enablementFund}</td>
												<td><b><a href="pesaPlan.html?<csrf:token uri='pesaPlan.html'/>">View Details</a></b></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div> --%>
							<%-- <div class="card">
								<div class="sub-header">
										<h4>Distance learning Facility through SATCOM/IP based virtual Class room/similar technology</h4>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<tr>
											
												<td>Total Proposed Fund</td>
												<td>Rs. ${SATCOM_FUND_TOTAL}</td>
												<td><b><a href="distanceLearningGetMOPR.html?<csrf:token uri='distanceLearningGetMOPR.html'/>">View Details</a></b></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div> --%>
							<%-- <div class="card">
								<div class="sub-header">
										<h4>IEC Activity</h4>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td>Total Proposed Fund</td>
												<td>Rs. ${IEC_FUND_TOTAL}</td>
												<td><b><a href="iec.html?<csrf:token uri='iec.html'/>">View Details</a></b></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div> --%>
							<input type="button" class="btn bg-green waves-effect" data-ng-click="forwardPlan(${sessionScope['scopedTarget.userPreference'].plansAreFreezed})" value="Forward Plan To CEC">
							<input type="button" style="float: right;" class="btn bg-red waves-effect" data-ng-click="" value="Revert Plan To ${stateName}">
						</div>
					</div>
				</div>
			</div>
		</div>
</section>


</body>
</html>