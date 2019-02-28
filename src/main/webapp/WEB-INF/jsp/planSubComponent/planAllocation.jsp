<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../taglib/taglib.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


<section class="content"> 
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Plan Allocation</h2>
					</div>
					<div class="body">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>
										<div align="center">
											<strong>SI.No.</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>Component</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>Amount Allocation</strong>
										</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${PLAN_ALLOCATION_LIST}" var="planCompotents" varStatus="index">
									<tr>
										<td><b>${index.count}</b></td>
										<td><b>${planCompotents.componentName}</b></td>
										<td></td>
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
												<div align="center">
													 <input type="text" class="form-control"/>
												</div>
											</td>
										</tr>
									</c:forEach>
									
								</c:forEach>
							</tbody>

						</table>
						<div class="text-right">
							<button  type="button" ng-click="saveData('S')" class="btn bg-green waves-effect">SAVE</button>
							<button type="button"  ng-click="claerAll()" class="btn bg-light-blue waves-effect">CLEAR</button>
							<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"class="btn bg-orange waves-effect">CLOSE</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

</body>
</html>