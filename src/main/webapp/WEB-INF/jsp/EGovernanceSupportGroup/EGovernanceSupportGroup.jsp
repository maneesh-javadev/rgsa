<%@include file="../taglib/taglib.jsp"%>

<html>
<head>
<script type="text/javascript">
	function show(val){

		if (val == 1 ) {
			$("#eSPMUid").css("display","block")
			$("#eDPMUid").css("display","none")
			$("#simple").css("display","none")
		}
		if(val == 2) {
			$("#eDPMUid").css("display","block")
			$("#eSPMUid").css("display","none")
			$("#simple").css("display","none")
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
						<h2>e-Governance Support Group</h2>
					</div>
					<div class="body">
						<div class="table-responsive">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th><div align="center">
												<strong>Type of Center</strong>
											</div></th>
										<th><div align="center">
												<strong>District Name</strong>
											</div></th>
										<th><div align="center">
												<strong>Designation</strong>
											</div></th>
										<th><div align="center">
												<strong>No. of Posts proposed<br> A
												</strong>
											</div></th>
										<th><div align="center">
												<strong>No. of Months<br> B
												</strong>
											</div></th>
										<th><div align="center">
												<strong>Unit Cost (in Rs)<br>C
												</strong>
											</div></th>
										<th><div align="center">
												<strong>Proposed Fund (in Rs)<br>D = A * B * C
												</strong>
											</div></th>
										<th><div align="center">
												<strong>Remarks</strong>
											</div></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><select id="selectId" onchange="show(this.value)">
												<option value="0">Select</option>
												<option value="1">SPRC</option>
												<option value="2">DPRC</option>
										</select></td>

										<td><select>
												<option value="1">AGRA</option>
												<option value="2">MATHURA</option>
												<option value="2">MEERUT</option>
												<option value="2">MUZZAFARNAGAR</option>
										</select></td>
										<td><div id="simple" style="display:block">
												<select>
													<option value="0">Select</option>
													
												</select>
											</div>
										
											<div class="row clearfix collapse" id="eSPMUid" style="display: none">
												<select>
													<option value="0">Select</option>
													<option value="1">Project Manager</option>
													<option value="2">Accounts Expert</option>
													<option value="2">Technical Assistant</option>
													<option value="2">Others</option>
												</select>
											</div>
											<div class="row clearfix collapse" id="eDPMUid" style="display: none">

												<select>
													<option value="0">Select</option>
													<option value="1">District Project Manager</option>
													<option value="2">Technical Assistant</option>
													<option value="2">Others</option>
												</select>
											</div>
										</td>
										<td><input type="text" class="form-control" /></td>
										<td><input type="text" class="form-control" /></td>
										<td><input type="text" class="form-control" /></td>
										<td><input type="text" class="form-control" /></td>
										<td><textarea rows="4" cols="10"></textarea></td>

									</tr>
									<tr></tr>
									<tr>
									<td><div align="center">
												<strong>Additional Requirement</strong>
											</div></td>
											<td colspan="4"></td>
											<td colspan="2"><input type="text" class="form-control" /></td>
											
									</tr>
									
								</tbody>
							</table>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</section>