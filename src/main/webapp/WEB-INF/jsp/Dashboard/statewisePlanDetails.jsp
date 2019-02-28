<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="publicModule">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Statewise Paln Status</title>
	<%@include file="../taglib/taglib.jsp"%>

  	<link rel="stylesheet" href="https://js.arcgis.com/3.22/dijit/themes/claro/claro.css">
  	<link rel="stylesheet" href="https://js.arcgis.com/3.20/esri/css/esri.css">
   <script src="https://js.arcgis.com/3.20/"></script>
  
 		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/bootstrap/css/bootstrap.css">
  		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/bootstrap/css/bootstrap.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/index/css/main.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core/gis.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/font-awesome/font-awesome-4.2.0/css/font-awesome.min.css">
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery-3.1.0.min.js"></script>
	
	<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/bootstrap/js/bootstrap.min.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dashboard/statewisePlanStatusController.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dashboard/statewisePlanStatus.js"></script>
	<!--  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dashboard/gisMapStatePlanStatus.js"></script>
	-->

</head>
<body>

<section class="content" ng-controller="statewisePlanStatusController">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						
						<div class="body">
							<table class="table table-striped table-bordered dataTable" id="example"  class="data_grid">
										<thead>
											<tr>
												<th >S.No.</th>
												<th >Category Name</th>
												<th >Subect Name</th>
												<th >Target Group Name</th>
												<th >Level</th>
												<th >No. of Participant</th>
												<th >Funds</th>
											
											</tr>
										</thead>
										
										<tbody>
										 	<c:forEach var="obj" varStatus="rowstatus" items="${statewisePlanDetailList}">
												<tr >
													<td width="6%"><c:out value="${rowstatus.count}"/></td>
													<td align="left"><c:out value="${obj.trainingCategoryName}"></c:out></td>
													<td align="left"><c:out value="${obj.subjectName}"></c:out></td>
													<td align="left"><c:out value="${obj.targetGroupMasterName}"></c:out></td>
													<td align="left"><c:out value="${obj.trainingVenueLevelName}"></c:out></td>
													<td align="left"><c:out value="${obj.noOfParticipants}"></c:out></td>
													<td align="left"><c:out value="${obj.funds}"></c:out></td>
													
												</tr>
											</c:forEach>
										</tbody>
									</table>
		
						</div>
					</div>
				</div>
			</div>
		</div>
</section>
		

</body>
</html>