<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="card">
				<div class="header">
					<h2>Status of Training Needs Assessment</h2>
				</div>
				<div class="body">
					<div class="panel-group" id="TrainingNeedsAssessment">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a data-toggle="collapse"
										data-parent="#TrainingNeedsAssessment"
										href="#statustrainingNA"><i
										class="fa fa-caret-square-o-down view-color fa-lg"
										aria-hidden="true"> Status of Training Needs Assessment</i></a>
								</h4>
							</div>
						</div>
						<div class="panel-collapse collapse" id="statustrainingNA">
							<div class="panel-body">
								<div class="table-responsive">
									<table class="table table-bordered">
										<thead>
											<tr>
												<th>Subject of Training</th>
												<th>Date of Activity</th>
												<th>No. of Persons involved</th>
												<th>Outcome of Activity</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><input type="text" class="form-control"></td>
												<td><input type="text" class="form-control"></td>
												<td><input type="text" class="form-control"></td>
												<td><input type="text" class="form-control"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="panel-group" id="TrainingNeedsAssessment">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a data-toggle="collapse"
										data-parent="#TrainingNeedsAssessment"
										href="#TrainingEvaluationId"><i
										class="fa fa-caret-square-o-down view-color fa-lg"
										aria-hidden="true"> Status of Training Evaluation</i></a>
								</h4>
							</div>
						</div>
					</div>
					<div class="panel-collapse collapse" id="TrainingEvaluationId">
						<div class="panel-body">
							<div class="table-responsive">
								<table class="table table-hover">
									<thead>
										<tr>
											<th>Subject of Training Evaluation</th>
											<th>System of Evaluation</th>
											<th>No of Persons involved</th>
											<th>Training Feedback</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><input type="text" class="form-control"></td>
											<td>
											<select>
											<option value="0">select</option>
											<option value="1">Third Party</option>
											<option value="2">SIRD</option>
											<option value="3">OTHER</option>
											</select>
											</td>
											<td><input type="text" class="form-control"></td>
											<td><input type="file" class="form-control-file"></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="panel-group" id="TrainingNeedsAssessment">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a data-toggle="collapse"
										data-parent="#TrainingNeedsAssessment"
										href="#TrainingModuleId"><i
										class="fa fa-caret-square-o-down view-color fa-lg"
										aria-hidden="true">Status of Training Module</i></a>
								</h4>
							</div>
						</div>
					</div>
					<div class="panel-collapse collapse" id="TrainingModuleId">
						<div class="panel-body">
							<div class="table-responsive">
								<table class="table table-hover">
									<thead>
										<tr>
											<th>Subject of Training Module Available </th>
											<th>Level</th>
											<th>Target Audience for Training Module(Stakeholders of PRI)</th>
											<th>No of Modules prepared</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><select>
											<option value="0">select</option>
											<option value="1">abc</option>
											<option value="2">def</option>
											<option value="3">ghi</option>
											</select></td>
											<td>
											<select>
											<option value="0">select</option>
											<option value="1">DP</option>
											<option value="2">BP</option>
											<option value="3">GP</option>
											</select>
											</td>
											<td><input type="text" class="form-control"></td>
											<td><input type="text" class="form-control"></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<div class="panel-group" id="TrainingNeedsAssessment">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a data-toggle="collapse"
										data-parent="#TrainingNeedsAssessment"
										href="#TrainingMaterialID"><i
										class="fa fa-caret-square-o-down view-color fa-lg"
										aria-hidden="true">Status of Training Material</i></a>
								</h4>
							</div>
						</div>
					</div>
					<div class="panel-collapse collapse" id="TrainingMaterialID">
						<div class="panel-body">
							<div class="table-responsive">
								<table class="table table-hover">
									<thead>
										<tr>
											<th>Subject of Training Material Available</th>
											<th>Level</th>
											<th>Target Audience for Training Material(Stakeholders of PRI)</th>
											<th>No of Material prepared</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><input type="text" class="form-control"></td>
											<td>
											<select>
											<option value="0">select</option>
											<option value="1">DP</option>
											<option value="2">BP</option>
											<option value="3">GP</option>
											</select>
											</td>
											<td><input type="text" class="form-control"></td>
											<td><input type="text" class="form-control"></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="form-group text-right">
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
</section>


