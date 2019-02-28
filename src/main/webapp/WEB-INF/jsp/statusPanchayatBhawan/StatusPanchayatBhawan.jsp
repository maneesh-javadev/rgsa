<%@include file="../taglib/taglib.jsp"%>
<head>
<script>
function active() {
	if ($("#check1").is(':checked')) {
		$('.active').removeAttr("disabled");

	} else {

		$(".active").attr("disabled", true);
	}
	
	if ($("#check2").is(':checked')) {
		$('.active2').removeAttr("disabled");

	} else {

		$(".active2").attr("disabled", true);
	}
	if ($("#check3").is(':checked')) {
		$('.active3').removeAttr("disabled");

	} else {

		$(".active3").attr("disabled", true);
	}


}
</script>
</head>
<section class="content">
	<div class="container-fluid">

		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Status of Panchayat Bhawan</h2>
					</div>
					<form:form method="post">
						<div class="body">
							<div class="row clearfix">
								<div
									class="col-lg-3 col-md-2 col-sm-6 col-xs-5 form-control-label">
									<label for="gramPanchayat"> <spring:message
											code="Label.NoGramPanchayat" htmlEscape="true" />
									</label>
								</div>
								<div class="col-lg-9 col-md-10 col-sm-6 col-xs-7">
									<div class="form-group">
										<div class="form-line">
											<input type="text" class="form-control"
												placeholder="No.Of Gram Panchayats" />
										</div>
									</div>
								</div>
							</div>

							<div class="row clearfix">
								<div
									class="col-lg-3 col-md-2 col-sm-6 col-xs-5 form-control-label">
									<label for="avgSizeGp" class="control-label"><spring:message
											code="Label.AverageSizeOfGP" htmlEscape="true" /></label>
								</div>
								<div class="col-lg-9 col-md-10 col-sm-6 col-xs-7">
									<div class="form-group">
										<div class="form-line">
											<input type="text" class="form-control"
												placeholder="Average size of GP" />
										</div>
									</div>
								</div>
							</div>

							<div class="row clearfix">
								<div class="col-sm-5">
									<div class="form-group">
										<div class="form-line">
											<label for="PanchayatsWithoutBhawan" class="control-label"><spring:message
													code="Label.PanchayatsWithoutBhawan" htmlEscape="true" /></label>
											<input type="text" class="form-control"
												placeholder="Number of Panchayats without Bhawan" />
										</div>
									</div>
								</div>
								<div class="col-sm-5">
									<div class="form-group">
										<div class="form-line">
											<label for="RequirementNewConstruction" class="control-label"><spring:message
													code="Label.RequirementNewConstruction" htmlEscape="true" /></label>
											<input type="text" class="form-control"
												placeholder="Number of Panchayats without Bhawan" />
										</div>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group">
										<label for="IdentifyGPs" class="control-label"><spring:message
												code="Label.IdentifyGPs" htmlEscape="true" /></label> <br>
										<button type="button" class="btn btn-primary"
											data-toggle="modal" data-target="#table1">Identify
											GPs</button>
									</div>
								</div>
							</div>
							<!-- modal start -->
							<div class="modal fade" id="table1" role="dialog">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												onclick="refresh(1)">&times;</button>
											<h4>Construction of New Panchayat Bhawan</h4>
										</div>
										<div class="modal-body">
											<div class="table-responsive">
												<table class="table table-hover" id="table1id">
													<thead>
														<tr>
															<th>Gram Panchayat</th>
															<th>Gram Panchayats under Aspirational Districts</th>
															<th>Panchayat Office Functional or Not</th>
															<th>If functional from where</th>
															<th colspan="4"><div align="center">Number of
																	Staff Positioned</div></th>
															<th>Computer</th>
															<th>Internet</th>
															<th>Electricity</th>
															<th>List of the services provided by Panchayat</th>
															<th>No of GS held during last year</th>
															<th>Gram Panchayat Prepared Annual Plan of Gram
																Panchayat</th>
															<th>Standing Committee Functional</th>
															<th>No of Standing Committee meeting held</th>
															<th>Upload Photo</th>
														</tr>
														<tr>
															<th colspan="4"></th>
															<th colspan="2"><div align="center">Regular</div></th>
															<th colspan="2"><div align="center">Contractual</div></th>
														</tr>
														<tr>
															<th colspan="4"></th>
															<th>Administrative</th>
															<th>Technical</th>
															<th>Administrative</th>
															<th>Technical</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td><input type="text" class="form-control"></td>
															<td><input type="text" class="form-control"></td>
															<td><input type="checkbox" id="check1"
																class="form-check-input" onclick="active()"></td>
															<td><input type="text" class="active form-control"
																disabled="disabled"></td>
															<td><input type="text" class="active form-control"
																disabled="disabled"></td>
															<td><input type="text" class="active form-control"
																disabled="disabled"></td>
															<td><input type="text" class="active form-control"
																disabled="disabled"></td>
															<td><input type="text" class="active form-control"
																disabled="disabled"></td>
															<td><input type="checkbox"
																class="active form-check-input" disabled="disabled"></td>
															<td><input type="checkbox"
																class="active form-check-input" disabled="disabled"></td>
															<td><input type="checkbox"
																class="active form-check-input" disabled="disabled"></td>
															<td><input type="text" class="active form-control"
																disabled="disabled"></td>
															<td><input type="text" class="active form-control"
																disabled="disabled"></td>
															<td><input type="checkbox"
																class="active form-check-input" disabled="disabled"></td>
															<td><input type="checkbox"
																class="active form-check-input" disabled="disabled"></td>
															<td><input type="text" class="active form-control"
																disabled="disabled"></td>
															<td><input type="file"
																class="active form-control-file" disabled="disabled"></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-success">Save</button>
											<button type="button" class="btn btn-danger"
												data-dismiss="modal">Close</button>


										</div>
									</div>
								</div>
							</div>
							<!-- modal ends here -->

							<div class="row clearfix">
								<div class="col-sm-5">
									<div class="form-group">
										<div class="form-line">
											<label for="PanchayatsWithBhawan" class="control-label"><spring:message
													code="Label.PanchayatsWithBhawan" htmlEscape="true" /></label> <input
												type="text" class="form-control"
												placeholder="Number of Panchayats without Bhawan" />
										</div>
									</div>
								</div>
								<div class="col-sm-5">
									<div class="form-group">
										<div class="form-line">
											<label for="RequireRepairOfPanchayatBhawan"
												class="control-label"><spring:message
													code="Label.RequireRepairOfPanchayatBhawan"
													htmlEscape="true" /></label> <input type="text"
												class="form-control"
												placeholder="Number of Panchayats without Bhawan" />
										</div>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group">
										<label for="IdentifyGPs" class="control-label"><spring:message
												code="Label.IdentifyGPs" htmlEscape="true" /></label> <br>
										<button type="button" class="btn btn-primary"
											data-toggle="modal" data-target="#table2">Identify
											GPs</button>
									</div>
								</div>
							</div>

							<!-- modal start -->
							<div class="modal fade" id="table2" role="dialog">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4>Repair of Panchayat Bhawan</h4>
										</div>
										<div class="modal-body">
											<div class="table-responsive">
												<table class="table table-hover" id="table2id">
													<thead>
														<tr>
															<th>Gram Panchayat</th>
															<th>Gram Panchayats under Aspirational Districts</th>
															<th>Panchayat Office Functional or Not</th>
															<th>If functional from where</th>
															<th colspan="4"><div align="center">Number of
																	Staff Positioned</div></th>
															<th>Computer</th>
															<th>Internet</th>
															<th>Electricity</th>
															<th>List of the services provided by Panchayat</th>
															<th>No of GS held during last year</th>
															<th>Gram Panchayat Prepared Annual Plan of Gram
																Panchayat</th>
															<th>Standing Committee Functional</th>
															<th>No of Standing Committee meeting held</th>
															<th>Upload Photo</th>
														</tr>
														<tr>
															<th colspan="4"></th>
															<th colspan="2"><div align="center">Regular</div></th>
															<th colspan="2"><div align="center">Contractual</div></th>
														</tr>
														<tr>
															<th colspan="4"></th>
															<th>Administrative</th>
															<th>Technical</th>
															<th>Administrative</th>
															<th>Technical</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td><input type="text" class="form-control"></td>
															<td><input type="text" class="form-control"></td>
															<td><input type="checkbox" id="check2"
																class="form-check-input" onclick="active()"></td>
															<td><input type="text" class="active2 form-control"
																disabled="disabled"></td>
															<td><input type="text" class="active2 form-control"
																disabled="disabled"></td>
															<td><input type="text" class="active2 form-control"
																disabled="disabled"></td>
															<td><input type="text" class="active2 form-control"
																disabled="disabled"></td>
															<td><input type="text" class="active2 form-control"
																disabled="disabled"></td>
															<td><input type="checkbox"
																class="active2 form-check-input" disabled="disabled"></td>
															<td><input type="checkbox"
																class="active2 form-check-input" disabled="disabled"></td>
															<td><input type="checkbox"
																class="active2 form-check-input" disabled="disabled"></td>
															<td><input type="text" class="active2 form-control"
																disabled="disabled"></td>
															<td><input type="text" class="active2 form-control"
																disabled="disabled"></td>
															<td><input type="checkbox"
																class="active2 form-check-input" disabled="disabled"></td>
															<td><input type="checkbox"
																class="active2 form-check-input" disabled="disabled"></td>
															<td><input type="text" class="active2 form-control"
																disabled="disabled"></td>
															<td><input type="file"
																class="active2 form-control-file" disabled="disabled"></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-success">Save</button>
											<button type="button" class="btn btn-danger"
												data-dismiss="modal">Close</button>
										</div>
									</div>
								</div>
							</div>
							<!-- modal ended -->

							<div class="row clearfix">
								<div class="col-sm-5">
									<div class="form-group">
										<div class="form-line">
											<label for="PanchayatsWithoutCSCs" class="control-label"><spring:message
													code="Label.PanchayatsWithoutCSCs" htmlEscape="true" /></label> <input
												type="text" class="form-control"
												placeholder="Number of Panchayats without Bhawan" />
										</div>
									</div>
								</div>
								<div class="col-sm-5">
									<div class="form-group">
										<div class="form-line">
											<label for="RequireCoLocationOfCSCWithPanchayatBhawan"
												class="control-label"><spring:message
													code="Label.RequireCoLocationOfCSCWithPanchayatBhawan"
													htmlEscape="true" /></label> <input type="text"
												class="form-control"
												placeholder="Number of Panchayats without Bhawan" />
										</div>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group">
										<label for="IdentifyGPs" class="control-label"><spring:message
												code="Label.IdentifyGPs" htmlEscape="true" /></label> <br>
										<button type="button" class="btn btn-primary"
											data-toggle="modal" data-target="#table3">Identify
											GPs</button>
									</div>
								</div>
							</div>
							<!-- modal start -->
							<div class="modal fade" id="table3" role="dialog">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												onclick="refresh(3)">&times;</button>
											<h4>Co-Location of CSC with Panchayat Bhawan</h4>
										</div>
										<div class="modal-body">
											<div class="table-responsive">
												<table class="table table-hover" id="table3id">
													<thead>
														<tr>
															<th>Gram Panchayat</th>
															<th>Gram Panchayats under Aspirational Districts</th>
															<th>Panchayat Office Functional or Not</th>
															<th>If functional from where</th>
															<th colspan="4"><div align="center">Number of
																	Staff Positioned</div></th>
															<th>Computer</th>
															<th>Internet</th>
															<th>Electricity</th>
															<th>List of the services provided by Panchayat</th>
															<th>No of GS held during last year</th>
															<th>Gram Panchayat Prepared Annual Plan of Gram
																Panchayat</th>
															<th>Standing Committee Functional</th>
															<th>No of Standing Committee meeting held</th>
															<th>Upload Photo</th>
														</tr>
														<tr>
															<th colspan="4"></th>
															<th colspan="2"><div align="center">Regular</div></th>
															<th colspan="2"><div align="center">Contractual</div></th>
														</tr>
														<tr>
															<th colspan="4"></th>
															<th>Administrative</th>
															<th>Technical</th>
															<th>Administrative</th>
															<th>Technical</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td><input type="text" class="form-control"></td>
															<td><input type="text" class="form-control"></td>
															<td><input type="checkbox" id="check3"
																class="form-check-input" onclick="active()"></td>
															<td><input type="text" class="active3 form-control"
																disabled="disabled"></td>
															<td><input type="text" class="active3 form-control"
																disabled="disabled"></td>
															<td><input type="text" class="active3 form-control"
																disabled="disabled"></td>
															<td><input type="text" class="active3 form-control"
																disabled="disabled"></td>
															<td><input type="text" class="active3 form-control"
																disabled="disabled"></td>
															<td><input type="checkbox"
																class="active3 form-check-input" disabled="disabled"></td>
															<td><input type="checkbox"
																class="active3 form-check-input" disabled="disabled"></td>
															<td><input type="checkbox"
																class="active3 form-check-input" disabled="disabled"></td>
															<td><input type="text" class="active3 form-control"
																disabled="disabled"></td>
															<td><input type="text" class="active3 form-control"
																disabled="disabled"></td>
															<td><input type="checkbox"
																class="active3 form-check-input" disabled="disabled"></td>
															<td><input type="checkbox"
																class="active3 form-check-input" disabled="disabled"></td>
															<td><input type="text" class="active3 form-control"
																disabled="disabled"></td>
															<td><input type="file"
																class="active3 form-control-file" disabled="disabled"></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-success">Save</button>
											<button type="button" class="btn btn-danger"
												data-dismiss="modal">Close</button>
										</div>
									</div>
								</div>
							</div>
							<!-- modal ended -->
							<div class="form-group text-right">
								<button type="button" class="btn bg-green waves-effect">
									SAVE</button>
								<button type="button" onclick="onClear(this)"
									class="btn bg-light-blue waves-effect">CLEAR</button>
								<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-orange waves-effect">CLOSE</button>

							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>

	</div>
</section>