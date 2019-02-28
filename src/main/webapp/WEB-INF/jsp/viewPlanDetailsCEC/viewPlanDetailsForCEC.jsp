<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%@include file="../taglib/taglib.jsp"%>
	<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
</head>
<body>


<section class="content">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Plan Forwarded By ${stateName}/MOPR</h2>
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
										<td colspan="4"><b><a href="${planCompotents.cecLink}?menuId=0&<csrf:token uri='${planCompotents.cecLink}'/>">View Details</a></b></td>
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
						
						
							<%-- <div class="card">
								<div class="sub-header">
										<h4>PESA PLAN</h4>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td><b><a href="pesaPlanForCEC.html?<csrf:token uri='pesaPlanForCEC.html'/>">View Details</a></b></td>
											</tr>v
										</tbody>
									</table>
								</div>
							</div>
							
							<div class="card">
								<div class="sub-header">
										<h4>Administrative & Technical Support to Gram Panchayat</h4>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td><b><a href="adminTechsupportStaffForCEC.html?<csrf:token uri='adminTechsupportStaffForCEC.html'/>">View Details</a></b></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="card">
								<div class="sub-header">
										<h4>Innovative Activity</h4>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td><b><a href="innovativeActivityForCEC.html?<csrf:token uri='innovativeActivityForCEC.html'/>">View Details</a></b></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="card">
								<div class="sub-header">
										<h4>e-Governance Support Group</h4>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td><b><a href="egovernanceCEC.html?<csrf:token uri='egovernanceCEC.html'/>">View Details</a></b></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div> --%>
							
						<b></b><div align="right"><a href="ApprovePlanByCec.html?<csrf:token uri='ApprovePlanByCec.html'/>" class="btn btn-success" role="button">APPROVE PLAN</a></div>
						</div>
					</div>
				</div>
			</div>
		</div>
</section>


</body>
</html>