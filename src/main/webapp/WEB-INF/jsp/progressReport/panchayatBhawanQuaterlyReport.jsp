
<head>	
	<%@include file="../taglib/taglib.jsp"%>
	<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
	<script src="http://angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet">
</head>
	<section class="content">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Panchayat Bhawan Quaterly Progress Report</h2>
						</div>
						<div class="body">
							<div class="card">
								<!-- nav bar -->
							<div align="center" class="row">
								<br />
								<div align="center" class="form-group">
									<label for="selectLevel" class="col-sm-3">Select
										Quarter Duration</label>
									<div class="col-sm-3">
										<select class="form-control">
											<option value="">Select</option>
											<option value="0">APRIL-JUNE</option>
											<option value="1">JULY-SEPT</option>
											<option selected="selected" value="2">OCT_DEC</option>
											<option value="3">JAN-MAR</option>
										</select>
									</div>
								</div>
							</div>

							<div class="table-responsive">
											<table id="table1id" class="table table-bordered">
												<thead>
													<tr>
														<th>
															<div align="center">
																<strong>Activities</strong>
															</div>
														</th>
														<th>
															<div align="center">
																<strong>No. of GPs</strong>
															</div>
														</th>
														<th>
															<div align="center">
																<strong>No. of Aspirational GPs selected</strong>
															</div>
														</th>
														
														<th>
															<div align="center">
																<strong>Unit Cost (in Rs) </strong>
															</div>
														</th>
														<th>
															<div align="center">
																<strong>Funds (in Rs) </strong>
															</div>
														</th>
														<th>
															<div align="center">
																<strong>Expenditure incurred </strong>
															</div>
														</th>
													</tr>
												</thead>
												<tbody>
												<c:forEach begin="0" end="2">
													<tr>
													<td><strong>Construction of new Panchayat Bhawan</strong> </td>
													<td>7886</td>
													<td>78</td>
													<td>150000</td>
													<td>7886 </td>
													<td>62188996</td>
													</tr>
													</c:forEach>
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

