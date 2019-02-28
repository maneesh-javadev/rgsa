<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="planStatus">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	<%@include file="../taglib/taglib.jsp"%>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/planSubmittedByStates/planController.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/planSubmittedByStates/planStateDetailsService.js"></script>

</head>
<body>

<section class="content" ng-controller="planStateDetailsController">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>List of Plan Submitted by State(s)</h2>
						</div>
						<div class="body">
							<div class="card">
								<div class="table-responsive">
						        	<table class="table table-hover dashboard-task-infos">
						            	<thead>
						            		<th>State Name</th>
						            		<th>Submitted Date</th>
						            	</thead>
						            	
						            	<tbody>
						            		<tr ng-repeat="plan in planStateList">
						            			<td><a ng-href="viewPlanDetails.html?stateCode={{plan.stateCode}}&&<csrf:token uri='viewPlanDetails.html'/>">{{plan.stateName}}</a></td>
						            			<td><mydate>{{plan.createdOn | date:'yyyy-MM-dd'}}</mydate></td>
							            	</tr>
						            	</tbody>
						            
						            </table>
       							</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
</section>
		

</body>
</html>