<%@include file="../taglib/taglib.jsp"%>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Current status of Faculty and Maintenance at PMU</h2> 
					</div>
					<div class="body">
						<div class="card">

							<table class="table table-bordered">
								<thead>
									<tr>
										<th>Functional Area</th>
										<th>Post Name</th>
										<th>No. of Staff Positioned</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach begin="0" end="3">
									<tr>
										<td>
											<select>
												<option value="0">Select</option>
												<option value="1">SAHEBGANJ,</option>
												<option value="2">RAJGARH</option>
												<option value="3">SHRAWASTI</option>
											</select>
										</td>
										<td>
											<select>
												<option value="0">Select</option>
												<option value="1">ASDF</option>
												<option value="2">ASWE</option>
												<option value="3">MJDK</option>
											</select>
										</td>
										<td><input type="text" class="form-control" /></td>
									</tr>
								</c:forEach>
                           		</tbody>
							</table>

						</div>
						<div class="form-group text-right">
							<button type="button" class="btn bg-green waves-effect">
								<spring:message code="Label.SAVE" htmlEscape="true" />
							</button>
							<button type="button" onclick="onClear(this)"
								class="btn bg-light-blue waves-effect">
								<spring:message code="Label.CLEAR" htmlEscape="true" />
							</button>
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
</section>