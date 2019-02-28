<%@include file="../taglib/taglib.jsp"%>
<html>
<head>
<script type="text/javascript">

/* function count(){
	var aspirational=​document.getElementById("aspirationalId").options.length;
} */
</script>
</head>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Panchayat Bhawan</h2>
					</div>
					<div class="body">
						<div class="card">
							<ul class="nav nav-tabs" role="tablist">
								<li role="presentation" class="active"><a
									href="#Panchayat_Bhawan_New_Activity_Id" data-toggle="tab">
										<i class="fa fa-info-circle view-color fa-lg"
										aria-hidden="true"> Panchayat Bhawan New Activity</i>
								</a></li>
								<li role="presentation"><a href="#Gp_Distribution_Id"
									data-toggle="tab"> <i class="fa fa-users view-color fa-lg"
										aria-hidden="true"> GPs Distribution</i>
								</a></li>
								<li role="presentation"><a href="#StatusofPanchayatsId"
									data-toggle="tab"> <i class="fa fa-users view-color fa-lg"
										aria-hidden="true">Status of Panchayats</i>
								</a></li>
							</ul>
						</div>
						<!-- Tab panes -->
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane fade in active"
								id="Panchayat_Bhawan_New_Activity_Id">
								<div class="table-responsive">
									<table class="table table-hover dashboard-task-infos">
										<thead>
											<tr>
												<th><div align="center">
														<strong>Activities</strong>
													</div></th>
												<th><div align="center">
														<strong>Unit Proposed <br>A
														</strong>
													</div></th>
												<th><div align="center">
														<strong>Unit Cost (in Rs)<br> B
														</strong>
													</div></th>
												<th><div align="center">
														<strong>Funds (in Rs)<br>C = A * B
														</strong>
													</div></th>
												<th><div align="center">
														<strong>Total Funds<br>D = C + Funds
															Required in Carry forward
														</strong>
													</div></th>
											</tr>
										</thead>
										<tbody>

											<tr>
												<td>
													<div align="center">
														<select>
															<option value="0">Select</option>
															<option value="1">Construction of new Panchayat
																Bhawan</option>
															<option value="2">Repair of Panchayat Bhawan</option>
															<option value="3">Co-location of CSC with
																Panchayat Bhawan</option>
														</select>
													</div>
												</td>
												<td><input type="text" class="form-control" /></td>
												<td><input type="text" class="form-control" /></td>
												<td><input type="text" class="form-control" /></td>
												<td><input type="text" class="form-control" /></td>
											</tr>
											<tr>

												<td colspan="10"></td>

											</tr>
											<tr>

												<td colspan="3">Additional Requirement</td>
												<td><input type="text" class="form-control"
													placeholder="<= 25% of Total" /></td>


											</tr>
											<tr>

												<td colspan="4"></td>
												<td><input type="text" class="form-control"
													placeholder="G_Total = Total_F + Add_REQ" /></td>


											</tr>
										</tbody>
									</table>
								</div>
							</div>

							<div role="tabpanel" class="tab-pane fade"
								id="Gp_Distribution_Id">
								<div class="table-responsive">
									<table class="table table-hover dashboard-task-infos">
										<thead>
										</thead>
										<tr>
											<th><div align="center">
													<strong>Activities</strong>
												</div></th>
											<th><div align="center">
													<strong>Aspirational GPs Covered</strong>
												</div></th>
											<th><div align="center">
													<strong>Mission Antyodaya GPs Covered</strong>
												</div></th>
											<th><div align="center">
													<strong>Other GPs<br>C = Total-(A+B)
													</strong>
												</div></th>
										</tr>
										<tbody>
											<tr>
												<td>
													<div align="center">
														<select>
															<option value="0">Select</option>
															<option value="1">Construction of new Panchayat
																Bhawan</option>
															<option value="2">Repair of Panchayat Bhawan</option>
															<option value="3">Co-location of CSC with
																Panchayat Bhawan</option>
														</select>
													</div>
												</td>
												<td><select class="form-control show-tick"
													onchange="count()" id="aspirationalId" multiple
													data-selected-text-format="count">
														<option>abc</option>
														<option>xyz</option>
														<option>mno</option>
														<option>uvw</option>
												</select></td>
												<td><select class="form-control show-tick"
													id="antodayaGpId" multiple
													data-selected-text-format="count">
														<option>cde</option>
														<option>efg</option>
														<option>hij</option>
														<option>stu</option>
												</select></td>
												<td><select class="form-control show-tick"
													id="othersId" multiple data-selected-text-format="count">
														<option>ace</option>
														<option>base</option>
														<option>pace</option>
														<option>chase</option>
												</select></td>

											</tr>
										</tbody>

									</table>
								</div>
							</div>

							<div role="tabpanel" class="tab-pane fade"
								id="StatusofPanchayatsId">
								<div class="table-responsive">
									<table class="table table-hover dashboard-task-infos">
										<thead style="position: inherit;">

											<tr>
												<th><div align="center">
														<strong>Activities</strong>
													</div></th>
												<th><div align="center">
														<strong>Panchayat Name</strong>
													</div></th>
												<th><div align="center">
														<strong>Land Identified</strong>
													</div></th>
												<th><div align="center">
														<strong>Design/ Layout/ Map Approved</strong>
													</div></th>
												<th><div align="center">
														<strong>Provision for Separate Toilet</strong>
													</div></th>
												<th><div align="center">
														<strong>Provision for Barrier free Access</strong>
													</div></th>
												<th><div align="center">
														<strong>Provision for Water Facility</strong>
													</div></th>
												<th><div align="center">
														<strong>Provision for Internet Facility</strong>
													</div></th>
												<th><div align="center">
														<strong>Provision for Electricity</strong>
													</div></th>
												<th><div align="center">
														<strong>Remarks</strong>
													</div></th>

											</tr>
										</thead>
										<tbody>
											<tr>
												<td>
													<div align="center">
														<select>
															<option value="0">Select</option>
															<option value="1">Construction of new Panchayat
																Bhawan</option>
															<option value="2">Repair of Panchayat Bhawan</option>
															<option value="3">Co-location of CSC with
																Panchayat Bhawan</option>
														</select>
													</div>
												</td>
												<td><select multiple="multiple">
														<optgroup label="Aspirational GPs Covered">
															<option style="font-size: 15px">6</option>
															<option style="font-size: 15px">5</option>
															<option style="font-size: 15px">4</option>
														</optgroup>
														<optgroup label="Mission Antyodaya GPs Covered">
															<option style="font-size: 15px">1</option>
															<option style="font-size: 15px">2</option>
															<option style="font-size: 15px">3</option>
														</optgroup>
														<optgroup label="Other GPs">
															<option style="font-size: 15px">1</option>
															<option style="font-size: 15px">2</option>
															<option style="font-size: 15px">3</option>
														</optgroup>
												</select></td>
												<td><input type="checkbox" /> Yes</td>
												<td><input type="checkbox" /> Yes</td>
												<td><input type="checkbox" /> Yes</td>
												<td><input type="checkbox" /> Yes</td>
												<td><input type="checkbox" /> Yes</td>
												<td><input type="checkbox" /> Yes</td>
												<td><input type="checkbox" /> Yes</td>
												<td><textarea rows="2" cols="10"></textarea></td>

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
	</div>
</section>