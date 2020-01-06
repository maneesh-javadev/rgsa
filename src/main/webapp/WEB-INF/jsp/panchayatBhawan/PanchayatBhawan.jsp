
<%@include file="../taglib/taglib.jsp"%>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Panchayat Bhawan New Activity</h2>
					</div>
					<div class="body">


						<div class="card">
							<!-- nav bar -->
							<ul class="nav nav-tabs" role="tablist">
								<li role="presentation" class="active"><a
									href="#home_with_icon_title" data-toggle="tab"> <i
										class="fa fa-info-circle view-color fa-lg" aria-hidden="true">
											Panchayat Bhawan New Activity</i>
								</a></li>
								<li role="presentation"><a href="#profile_with_icon_title"
									data-toggle="tab"> <i class="fa fa-users view-color fa-lg"
										aria-hidden="true">Information of Proposed Activities</i>
								</a></li>

							</ul>

							<!-- nav bar ended -->
							<div class="tab-content">
								<div role="tabpanel" class="tab-pane fade in active"
									id="home_with_icon_title">
									<div align="right">
										<button type="button" onclick="addNewRow(1)"
											class="btn btn-success waves-effect">
											<i class="fa fa-plus"></i> Add New Row
										</button>

										<button type="button" onclick="removeRow(1)"
											class="btn btn-danger waves-effect ">
											<i class="fa fa-minus" aria-hidden="true"></i> Remove Row
										</button>
									</div>
									<div class="table-responsive">
										<table id="table1id" class="table table-bordered">
											<thead>
												<tr>
													<th><div align="center">
															<strong>Activities</strong>
														</div></th>
													<th><div align="center">
															<strong>No. of GPs</strong><br> A
														</div></th>
													<th><div align="center">
															<strong>No. of Aspirational GPs selected</strong>
														</div></th>
													<th><div align="center">
															<strong>No. of GPs coming under mission
																Antyodaya</strong>
														</div></th>
													<th><div align="center">
															<strong>Unit Cost (in Rs) </strong><br> B
														</div></th>
													<th><div align="center">
															<strong>Funds (in Rs) </strong><br> C = A * B
														</div></th>
												</tr>
											</thead>
											<tbody id="body1">

												<tr id="tr1">


													<td><select>
															<option value="o">Select</option>
															<option value="1">Construction of new Panchayat
																Bhawan</option>
															<option value="2">Repair of Panchayat Bhawan</option>
															<option value="2">Co-location of CSC with
																Panchayat Bhawan</option>

													</select></td>
													<td><select class="active" multiple="multiple"
														data-selected-text-format="count">
															<option value="1">GPs 1</option>
															<option value="2">GPs 2</option>
															<option value="3">GPs 3</option>
													</select></td>
													<td><input type="text" class="form-control" /></td>

													<td><input type="text" class="form-control" /></td>
													<td><input type="text" class="form-control" /></td>
													<td><input type="text" class="form-control" /></td>
												</tr>

											</tbody>
										</table>
										<table class="table table-bordered">
											<tbody>
												<tr>
													<th><div>
															<strong>Additional Requirement </strong>
														</div></th>
													<td colspan="2"></td>
													<td><input type="text" class="form-control col-sm-1"
														placeholder="25% of total" /></td>
													<td><textarea rows="2" cols="6"></textarea></td>

												</tr>
											</tbody>
										</table>
										<br>
										<br>
									</div>
								</div>



								<div role="tabpanel" class="tab-pane fade"
									id="profile_with_icon_title">
									<div align="right">
										<button type="button" onclick="addNewRow(2)"
											class="btn btn-success waves-effect">
											<i class="fa fa-plus"></i> Add New Row
										</button>

										<button type="button" onclick="removeRow(2)"
											class="btn btn-danger waves-effect ">
											<i class="fa fa-minus" aria-hidden="true"></i> Remove Row
										</button>
									</div>
									<div class="table-responsive">
										<table id="table2id" class="table table-bordered">
											<thead>
												<tr>
													<th><div align="center">
															<strong>Activities</strong>
														</div></th>
													<th ><div align="center">
															<strong>Panchayat Name</strong>
														</div></th>
													<th class="landId" style="display: none"><div align="center">
															<strong>Land Identified</strong>
														</div></th>
													<th class="designId" style="display: none"><div align="center">
															<strong>Design/ Layout/ Map Approved</strong>
														</div></th>
													<th><div align="center">
															<strong>Provision for Separate Toilet</strong>
														</div></th>
													<th><div align="center">
															<strong>Provision for Barrier free Access </strong>
														</div></th>
													<th><div align="center">
															<strong>Provision for Water Facility </strong>
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
													<th class="photoUpload" style="display: none"><div align="center">
															<strong>Upload Photo</strong>
														</div></th>
												</tr>
											</thead>
											<tbody id="body2">
												<tr id="tr2">
													<td><select onchange="show(this.value)">
															<option value="0">Select</option>
															<option value="1">Construction of new Panchayat
																Bhawan</option>
															<option value="2">Repair of Panchayat Bhawan</option>
															<option value="3">Co-location of CSC with
																Panchayat Bhawan</option>
													</select></td>
													<td><select>
															<option value="o">Select</option>
															<option value="1">GPs1</option>
															<option value="2">GPs 2</option>
													</select></td>
													<td class="landId" style="display: none"><input type="checkbox" id="check1"
														onclick="active()" /> Yes</td>
													<td class="designId" style="display: none"><input type="checkbox" id="check1"
														onclick="active()" /> Yes</td>
													<td><input type="checkbox" id="check1"
														onclick="active()" /> Yes</td>
													<td><input type="checkbox" id="check1"
														onclick="active()" /> Yes</td>
													<td><input type="checkbox" id="check1"
														onclick="active()" /> Yes</td>
													<td><input type="checkbox" id="check1"
														onclick="active()" /> Yes</td>
													<td><input type="checkbox" id="check1"
														onclick="active()" /> Yes</td>
													<td><input type="text" class="form-control" /></td>
													<td class="photoUpload" style="display: none"><input type="file" /></td>
												</tr>
											</tbody>
										</table>
										<br>
										<br>
										<br>
										<br>
										<br>
										<br>
										<br>
									</div>
								</div>
							</div>
							<div class="form-group text-right">
								<button type="button" class="btn bg-green waves-effect">
									<spring:message code="Label.SAVE" htmlEscape="true" />
								</button>
								<%-- <button type="button" onclick="onClear(this)"
									class="btn bg-light-blue waves-effect">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</button> --%>
								<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-orange waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script>
function addNewRow(val){
	if(val == 1){
		var tds = '<tr>';
	    tds+=$("#tr1").html();
	    tds += '</tr>';
		$("#body1").append(tds);}
	if(val == 2){
		var tds = '<tr>';
	    tds+=$("#tr2").html();
	    tds += '</tr>';
		$("#body2").append(tds);}
}
function removeRow(val){
	if(val == 1){if($('#table1id tr').length>2){ $('#table1id tr:last').remove();}}
	 if(val == 2){if($('#table2id tr').length>2){ $('#table2id tr:last').remove();}}
}

function show(val)
{
	if(val == 1)
		{ $(".photoUpload").hide();
		 $(".landId").show();
		 $(".designId").show();
		
		}
	if(val == 2 || val == 3)
	{ $(".photoUpload").show();
	 $(".landId").hide();
	 $(".designId").hide();
	
	}
		}
</script>