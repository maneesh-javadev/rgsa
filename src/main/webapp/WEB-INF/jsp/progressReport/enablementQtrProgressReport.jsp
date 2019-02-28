<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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
						<h2>e-Enablement Quarter Progress Report</h2>
					</div>
					<div class="body">
				<!-- 	<div align="center">
					<strong>Quarter Duration</strong></div>
					<div align="center"><label>
						<select class="form-control">
							<option value="">Select</option>
							<option value="0">APRIL-JUNE</option>
							<option value="1">JULY-SEPT</option>
							<option value="2">OCT_DEC</option>
							<option value="3">JAN-MAR</option>
						</select></label></div> -->
				
				<!-- 	<div align="center">
					<strong>Districts. </strong></div>
					<div align="center"><label>
						<select class="form-control">
							<option value="">Select</option>
							<option value="0">jhar</option>
							<option value="1">Up</option>
							<option value="2">M P</option>
							<option value="3">HARYANA</option>
						</select></label></div> -->
					
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
											<strong>No. of GP's Approved</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>No. of GP's to which equipment Provided</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>Expenditure Incurred(in Rs.)</strong>
										</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><strong>1.</strong></td>
									<td><input type="text" class="form-control" value="80" placeholder="Post Type"></td>
									<td><input type="text" class="form-control" value="50"	placeholder="Level"></td>
									<td><input type="text" class="form-control" value="75000"	placeholder="Amount Utilised"></td>
								</tr>
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
</html> --%>