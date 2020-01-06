<%@include file="../taglib/taglib.jsp"%>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Distance learning Facility through SATCOM/IP based
							virtual Class room/similar technology</h2>
					</div>
					<div class="body">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>
										<div align="center">
											<strong>Type of Center</strong>
										</div>
									</th>
									
									<th>
										<div align="center">
											<strong>Name of Activity</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>Level</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>No. of Units<br>A
											</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>Unit Cost (in Rs)<br>B
											</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>Fund Proposed (in Rs)<br>C = A * B
											</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>Remarks</strong>
										</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<div align="center">
											<select>
												<option value="0">Select</option>
												<option value="1">Two way video terminal</option>
												<option value="2">Satellite-Interactive-Terminal(SIT)</option>
												<option value="3">Other</option>
											</select>
										</div>
									</td>
									<td>
										<div align="center">
											<select>
												<option value="0">Select</option>
												<option value="1">District</option>
												<option value="2">Block</option>
												<option value="3">GP</option>
											</select>
										</div>
									</td>
									<td><input type="text" class="form-control" /></td>
									<td><input type="text" class="form-control" /></td>
									<td><input type="text" class="form-control" /></td>
									<td><textarea rows="2" cols="10"></textarea></td>
								</tr>
							</tbody>

						</table>
						<div class="text-right">
									<button type="button" class="btn bg-green waves-effect">
										SAVE</button>
									<!-- <button type="button" onclick="onClear(this)"
										class="btn bg-light-blue waves-effect">CLEAR</button> -->
									<button type="button"
										onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
										class="btn bg-orange waves-effect">CLOSE</button>
								</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>