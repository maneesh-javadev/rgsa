<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/plugins/flipBook/css/bookblock.css">
<%@include file="../taglib/taglib.jsp"%>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Report</h2>
					</div>
					<div class="body">

						<div class="form-group ">
							<div id="bb-bookblock" class="bb-bookblock">
								<c:forEach items="${MENU_HEADER}" var="menu" varStatus="count">
									<div class="bb-item card table-responsive">
										<div class="row">
											<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
												<div class="header">
													<b>${menu.resourceId}</b> <span class="pull-right">Page-${count.count}</span>
												</div>
												<div>
													<c:choose>
														<c:when test="${menu.menuId eq 14}">





															<table class="table table-bordered">


																<thead>
																	<tr>
																		<th colspan="8" scope="colgroup">Details of
																			Domain Expert</th>
																		<th colspan="8" scope="colgroup">Details of
																			Administrative Staff</th>
																	</tr>
																	<tr>
																		<th><div align="center">
																				<strong>Type of Center</strong>
																			</div></th>
																		<th><div align="center">
																				<strong>District Name </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Domain Name </strong>
																			</div></th>

																		<th><div align="center">
																				<strong>No. of Faculty </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Unit Cost (in Rs) </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>No. of Months </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Funds (in Rs) </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Remarks</strong>
																			</div></th>


																		<th><div align="center">
																				<strong>Type of Center</strong>
																			</div></th>
																		<th><div align="center">
																				<strong>District Name </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Domain Name </strong>
																			</div></th>

																		<th><div align="center">
																				<strong>No. of Faculty </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Unit Cost (in Rs) </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>No. of Months </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Funds (in Rs) </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Remarks</strong>
																			</div></th>

																	</tr>
																</thead>
																<tbody>
																	<tr>
																		<td><div>
																				<strong>SPRC</strong>
																			</div></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>




																		<td><div>
																				<strong>SPRC</strong>

																			</div></td>




																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>



																	</tr>
																	<tr>
																		<td><div>
																				<strong>DPRC</strong>

																			</div></td>






																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>


																		<td><div>
																				<strong>DPRC</strong>

																			</div></td>




																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>


																	</tr>

																	<tr>
																	<tr>
																		<td colspan="16"></td>
																	</tr>
																	<tr>
																		<td colspan="8">
																			<div class="form-inline">
																				<strong>SPRC Total Cost (A):</strong>
																			</div>
																		</td>
																		<td colspan="8"><div class="form-inline">
																				<strong>DPRC Total Cost(C) :</strong>
																			</div></td>
																	</tr>
																	<tr>
																		<td colspan="8"><strong> Additional
																				Requirement (B)</strong></td>
																		<td colspan="8"><strong> Additional
																				Requirement (D)</strong></td>
																	</tr>

																	<tr>
																		<td colspan="8"><input type="text"
																			class="form-control"
																			placeholder="(FUNDS REQUIRED
																				for SPRC = A + B) < = 40 Lakhs" />
																		</td>
																		<td colspan="8"><input type="text"
																			class="form-control"
																			placeholder="(FUNDS REQUIRED
																				for DPRC = C + D) < = 10 Lakhs" />
																		</td>
																	</tr>
																</tbody>
															</table>


														</c:when>
														<c:when test="${menu.menuId eq 22}">
															<table class="table table-bordered">
																<thead>

																	<tr>
																		<th>Functional Area</th>
																		<th>Post Name</th>
																		<th>No. of Staff Required</th>
																		<th>Unit Cost (in Rs)</th>
																		<th>No. of Months</th>
																		<th>Funds (in Rs)</th>
																		<th>Others</th>
																		<th>Total Cost (in Rs)</th>
																		<th>Remarks</th>
																	</tr>
																</thead>
																<tbody>
																	<tr>
																		<td><input type="text" class="form-control"></td>
																		<td><input type="text" class="form-control"></td>
																		<td><input type="text" class="form-control"></td>
																		<td><input type="text" class="form-control"></td>
																		<td><input type="text" class="form-control"></td>
																		<td><input type="text" class="form-control"></td>
																		<td><input type="text" class="form-control"></td>
																		<td><input type="text" class="form-control"></td>
																		<td><textarea rows="2" cols="5"></textarea></td>
																	</tr>
																	<tr>
																		<td colspan="7"></td>
																		<td><input type="text" class="form-control"
																			style="width: 100px"
																			placeholder="5% of total Project Cost"></td>
																	</tr>
																</tbody>
															</table>
														</c:when>


														<c:when test="${menu.menuId eq 29}">
															<table class="table table-bordered">


																<thead>

																	<tr>
																		<th><div align="center">
																				<strong>S.No.</strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Post type </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Post name </strong>
																			</div></th>

																		<th><div align="center">
																				<strong>Level (Block Panchayat) </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Unit</strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Unit Cost (in Rs) </strong>
																			</div></th>

																		<th><div align="center">
																				<strong>No. of Months </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Funds (in Rs)</strong>
																			</div></th>


																		<th colspan="3"><div align="center">
																				<strong>GPs covered</strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Remarks by state </strong>
																			</div></th>

																	</tr>
																	<tr>
																		<th><div align="center">
																				<strong></strong>
																			</div></th>
																		<th><div align="center">
																				<strong> </strong>
																			</div></th>
																		<th><div align="center">
																				<strong> </strong>
																			</div></th>

																		<th><div align="center">
																				<strong> </strong>
																			</div></th>
																		<th><div align="center">
																				<strong></strong>
																			</div></th>
																		<th><div align="center">
																				<strong> </strong>
																			</div></th>

																		<th><div align="center">
																				<strong> </strong>
																			</div></th>
																		<th><div align="center">
																				<strong></strong>
																			</div></th>


																		<th><div align="center">
																				<strong>Number of GPs</strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Aspirational GPs </strong>
																			</div></th>

																		<th><div align="center">
																				<strong>Mission Antyodaya GPs </strong>
																			</div></th>
																		<th><div align="center">
																				<strong></strong>
																			</div></th>


																	</tr>
																</thead>
																<tbody>
																	<tr>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																	<tr>



																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																	</tr>
																	<tr>

																		<td rowspan="2"><input type="text"
																			class="form-control" placeholder="" /></td>
																		<td rowspan="2"><input type="text"
																			class="form-control" placeholder="" /></td>
																		<td rowspan="2"><input type="text"
																			class="form-control" placeholder="" /></td>

																		<td rowspan="2"><input type="text"
																			class="form-control" placeholder="" /></td>
																		<td rowspan="2"><input type="text"
																			class="form-control" placeholder="" /></td>
																		<td rowspan="2"><input type="text"
																			class="form-control" placeholder="" /></td>
																		<td rowspan="2"><input type="text"
																			class="form-control" placeholder="" /></td>
																		<td rowspan="2"><input type="text"
																			class="form-control" placeholder="" /></td>
																		<td rowspan="2"><input type="text"
																			class="form-control" placeholder="" /></td>
																		<td rowspan="2"><input type="text"
																			class="form-control" placeholder="" /></td>

																		<td rowspan="2"><input type="text"
																			class="form-control" placeholder="" /></td>
																		<td rowspan="2"><input type="text"
																			class="form-control" placeholder="" /></td>

																	</tr>
																	<tr>



																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																	</tr>
																	<tr>



																		<td></td>
																		<td></td>
																		<td></td>

																		<td></td>
																		<td></td>
																		<td></td>
																		<td></td>
																		<td><input type="text" class="form-control"
																			placeholder="Total cost" /></td>
																		<td></td>
																		<td></td>

																		<td></td>
																		<td></td>

																	</tr>




																	<tr>
																		<td colspan="6"><strong> Additional
																				Requirement</strong></td>
																		<td colspan="6"><input type="text"
																			class="form-control"
																			placeholder="25% of Sub Total Cost" /></td>
																	</tr>

																	<tr>
																		<td colspan="6"><strong> Total Proposed
																				Fund</strong></td>
																		<td colspan="6"><input type="text"
																			class="form-control"
																			placeholder="Additional Requirement + Total Cost" /></td>
																	</tr>
																</tbody>
															</table>


														</c:when>





														<c:when test="${menu.menuId eq 31}">

															<div class="panel-group" id="InstitutionalId">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#InstitutionalId" href="#ActivityPlan"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> Activity Plan</i></a>
																		</h4>
																	</div>
																</div>
																<div id="ActivityPlan" class="panel-collapse collapse">
																	<div class="panel-body">
																		<table class="table table-bordered">
																			<thead>
																				<tr>
																					<th colspan="8"><strong>Activity Plan</strong></th>
																				</tr>
																				<tr>
																					<th><div align="center">
																							<strong>Type of Building(SPRC/ DPRC)</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>District Name </strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Land identified (YES/NO)</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Any other source of funding
																								(YES/NO)</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Design and Layout of building
																								(YES/NO) </strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Upload Photo </strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Remarks</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Funds Proposed (in Rs) </strong>
																						</div></th>
																				</tr>
																			</thead>
																			<tbody>
																				<tr>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="checkbox"
																						class="form-check-input" /></td>
																					<td><input type="checkbox"
																						class="form-check-input" /></td>
																					<td><input type="checkbox"
																						class="form-check-input" /></td>
																					<td><input type="file"
																						class="form-control-file" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>

																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>

															<!-- form 2 -->
															<div class="panel-group" id="InstitutionalId">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#InstitutionalId"
																				href="#CarryForwardId"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> Carry Forward</i></a>
																		</h4>
																	</div>
																</div>
																<div id="CarryForwardId" class="panel-collapse collapse">
																	<div class="panel-body">
																		<table class="table table-bordered">
																			<thead>
																				<tr>
																					<th colspan="8"><strong>Carry Forward</strong></th>
																				</tr>
																				<tr>
																					<th><div align="center">
																							<strong>New Building/ Extension</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>District Name </strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Funds Released</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Fund Utilized</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Status</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Upload Photo </strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Remarks</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Funds Proposed (in Rs) </strong>
																						</div></th>
																				</tr>
																			</thead>
																			<tbody>
																				<tr>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="file" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>

																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>
														</c:when>


														<c:when test="${menu.menuId eq 17}">



															<table class="table table-bordered">


																<thead>

																	<tr>
																		<th><div align="center">
																				<strong>E-infrastructure Resource</strong>
																			</div></th>
																		<th><div align="center">
																				<strong>GPs </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Aspirational/Mission Antyodaya </strong>
																			</div></th>

																		<th><div align="center">
																				<strong>Unit Cost (in Rs.) </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Remarks</strong>
																			</div></th>
																	</tr>
																</thead>
																<tbody>
																	<tr>

																		<td><input type="text" class="form-control"
																			placeholder="Computer and Accessories(Printer, Scanner and UPS)" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="Unit Cost<=  40,000 per Computer" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																	</tr>



																	<tr>

																		<td></td>
																		<td></td>
																		<td></td>
																		<td><input type="text" class="form-control"
																			placeholder="Total Proposed Cost" /></td>

																		<td></td>
																	</tr>
																</tbody>
															</table>


														</c:when>






														<c:when test="${menu.menuId eq 18}">


															<table class="table table-bordered">


																<thead>

																	<tr>
																		<th><div align="center">
																				<strong>Type pf Center</strong>
																			</div></th>
																		<th><div align="center">
																				<strong>District Name </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Designation </strong>
																			</div></th>

																		<th><div align="center">
																				<strong>No. of Posts proposed </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>No. of Months</strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Unit Cost (in Rs) </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Proposed Fund (in Rs) </strong>
																			</div></th>


																		<th><div align="center">
																				<strong>Remarks</strong>
																			</div></th>
																	</tr>
																</thead>
																<tbody>
																	<tr>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="Remarks" /></td>

																	</tr>

																	<tr>

																		<td><strong>e-SPMU</strong></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="Remarks" /></td>

																	</tr>

																	<tr>

																		<td><strong>e-DPMU</strong></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="Remarks" /></td>

																	</tr>


																	<tr>

																		<td></td>
																		<td></td>
																		<td></td>
																		<td></td>
																		<td></td>
																		<td></td>
																		<td><input type="text" class="form-control"
																			placeholder="Total Cost" /></td>

																		<td></td>
																	</tr>
																	<tr>
																		<td colspan="8"></td>
																	</tr>
																	<tr>
																		<td colspan="4"><strong> Additional
																				Requirement </strong></td>

																		<td colspan="4"><input type="text"
																			class="form-control"
																			placeholder="<= 25% of Total Cost" /></td>
																	</tr>

																	<tr>
																		<td colspan="4"><strong> Total Proposed
																				Fund</strong></td>
																		<td colspan="4"><input type="text"
																			class="form-control"
																			placeholder="Total Cost + Additional Cost" /></td>
																	</tr>
																</tbody>
															</table>


														</c:when>

														<c:when test="${menu.menuId eq 20}">


															<table class="table table-bordered">


																<thead>

																	<tr>
																		<th><div align="center">
																				<strong>Designation</strong>
																			</div></th>
																		<th><div align="center">
																				<strong>No. of Units </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Unit Cost per month (in Rs) </strong>
																			</div></th>

																		<th><div align="center">
																				<strong>No. of Months </strong>
																			</div></th>
																		<th><div align="center">
																				<strong>Funds (in Rs)</strong>
																			</div></th>



																		<th><div align="center">
																				<strong>Remarks</strong>
																			</div></th>
																	</tr>
																</thead>
																<tbody>
																	<tr>

																		<td><strong>District Coordinator</strong></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>


																		<td><input type="text" class="form-control"
																			placeholder="Remarks" /></td>

																	</tr>

																	<tr>

																		<td><strong>Block Coordinator</strong></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>


																		<td><input type="text" class="form-control"
																			placeholder="Remarks" /></td>

																	</tr>

																	<tr>

																		<td><strong>GP PESA Mobilizer</strong></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>


																		<td><input type="text" class="form-control"
																			placeholder="Remarks" /></td>

																	</tr>
																	<tr>

																		<td><strong>Gram Sabha Orientation</strong></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>

																		<td><input type="text" class="form-control"
																			placeholder="" /></td>
																		<td><input type="text" class="form-control"
																			placeholder="" /></td>


																		<td><input type="text" class="form-control"
																			placeholder="Remarks" /></td>

																	</tr>


																	<tr>

																		<td></td>
																		<td></td>
																		<td></td>
																		<td></td>

																		<td><input type="text" class="form-control"
																			placeholder="Total Cost" /></td>

																		<td></td>
																	</tr>
																	<tr>
																		<td colspan="6"></td>
																	</tr>
																	<tr>
																		<td colspan="4"><strong> Additional
																				Requirement </strong></td>

																		<td colspan="2"><input type="text"
																			class="form-control"
																			placeholder="<= 25% of Total Cost" /></td>
																	</tr>

																	<tr>
																		<td colspan="4"><strong> Total Proposed
																				Fund</strong></td>
																		<td colspan="2"><input type="text"
																			class="form-control"
																			placeholder="Additional Requirement + Total Cost" />
																		</td>
																	</tr>
																</tbody>
															</table>


														</c:when>

														<c:when test="${menu.menuId eq 13}">
															<table class="table table-bordered">
																<thead>
																	<tr>
																		<th>Activities</th>
																		<th>GPs</th>
																		<th>Aspirational/Mission Antyodaya</th>
																		<th>Unit Cost</th>
																		<th>Land Identified</th>
																		<th>Design/ Layout/ Map Approved</th>
																		<th>Provision for Separate Toilet</th>
																		<th>Provision for Barrier free Access</th>
																		<th>Provision for Water Facility</th>
																		<th>Provision for Internet Facility</th>
																		<th>Provision for Electricity</th>
																		<th>Remarks</th>
																		<th>Photo</th>
																	</tr>
																</thead>
																<tbody>
																	<tr>
																		<td><input type="text" class="form-control"
																			value="Construction of new Panchayat Bhawan" readonly
																			style="width: 200px" /></td>
																		<td><input type="text" class="form-control"
																			style="width: 75px" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control"
																			style="width: 75px" /></td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><textarea rows="2" cols="5"></textarea></td>
																		<td><input type="file" class="form-control-file"></td>
																	</tr>
																	<tr>
																		<td><input type="text" class="form-control"
																			value="Repair of Panchayat Bhawan" readonly
																			style="width: 200px" /></td>
																		<td><input type="text" class="form-control"
																			style="width: 75px" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control"
																			style="width: 75px" /></td>
																		<td><input type="checkbox" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><textarea rows="2" cols="5"></textarea></td>
																		<td><input type="file" class="form-control-file"></td>
																	</tr>
																	<tr>
																		<td><input type="text" class="form-control"
																			value="Co-location of CSC with Panchayat Bhawan"
																			readonly style="width: 200px" /></td>
																		<td><input type="text" class="form-control"
																			style="width: 75px" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control"
																			style="width: 75px" /></td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><input type="checkbox" /> Yes</td>
																		<td><input type="checkbox"
																			class=" form-check-input" /> Yes</td>
																		<td><textarea rows="2" cols="5"></textarea></td>
																		<td><input type="file" class="form-control-file"></td>
																	</tr>
																	<tr>
																		<td colspan="3"><b>Additional requirement</b></td>
																		<td colspan="3"><input type="text"
																			class="form-control" /></td>
																	</tr>
																	<tr>
																		<td colspan="3"><b>Funds Required</b></td>
																		<td colspan="3"><input type="text"
																			class="form-control" /></td>
																	</tr>
																</tbody>
															</table>
														</c:when>

														<c:when test="${menu.menuId eq 19}">
															<table class="table table-bordered">
																<thead>
																	<tr>
																		<th>Name of the Activity</th>
																		<th>Funds (in Rs)</th>
																		<th>Brief about the Activity</th>
																		<th>Upload File</th>
																		<th>Remarks</th>
																	</tr>
																</thead>
																<tbody>
																	<tr>
																		<td><input type="text" class="form-control"
																			style="width: 75px" /></td>
																		<td><input type="text" class="form-control"
																			style="width: 75px" /></td>
																		<td><input type="text" class="form-control"
																			style="width: 75px" /></td>
																		<td><input type="file" class="form-control-file"></td>
																		<td><textarea rows="2" cols="5"></textarea></td>
																	</tr>
																	<tr>
																		<td colspan="2"><b>Additional requirement</b></td>
																		<td colspan="2"><input type="text"
																			class="form-control" style="width: 250px"
																			placeholder="<= 25% of Total Cost" /></td>
																	</tr>
																	<tr>
																		<td colspan="2"><b>Total Funds Proposed</b></td>
																		<td colspan="2"><input type="text"
																			class="form-control"
																			placeholder="Additional Requirements + Total Cost"
																			style="width: 250px" /></td>
																	</tr>
																</tbody>
															</table>
														</c:when>
														<c:when test="${menu.menuId eq 22}">
															<table class="table table-bordered">
																<thead>
																	<tr>
																		<th>Functional Area</th>
																		<th>Post Name</th>
																		<th>No. of Staff Required</th>
																		<th>Unit Cost (in Rs)</th>
																		<th>No. of Months</th>
																		<th>Funds (in Rs)</th>
																		<th>Others</th>
																		<th>Total Cost (in Rs)</th>
																		<th>Remarks</th>
																	</tr>
																</thead>
																<tbody>
																	<tr>
																		<td><input type="text" class="form-control"></td>
																		<td><input type="text" class="form-control"></td>
																		<td><input type="text" class="form-control"></td>
																		<td><input type="text" class="form-control"></td>
																		<td><input type="text" class="form-control"></td>
																		<td><input type="text" class="form-control"></td>
																		<td><input type="text" class="form-control"></td>
																		<td><input type="text" class="form-control"></td>
																		<td><textarea rows="2" cols="5"></textarea></td>
																	</tr>
																	<tr>
																		<td colspan="7"></td>
																		<td><input type="text" class="form-control"
																			style="width: 100px"
																			placeholder="5% of total Project Cost"></td>
																	</tr>
																</tbody>
															</table>
														</c:when>

														<c:when test="${menu.menuId eq 21}">
															<table class="table table-hover dashboard-task-infos">
																<thead>
																	<tr>
																		<th rowspan="2">Name of Activity</th>
																		<th rowspan="2">Name of Ministry/Scheme</th>
																		<th rowspan="2">District Name</th>
																		<th rowspan="2">Block Name</th>
																		<th rowspan="2">No. of GPs</th>
																		<th rowspan="2">No. of GPS in Mission Antyodaya</th>
																		<th rowspan="2">No. of Aspirational GPs</th>
																		<th colspan="2">Time Frame of project(year wise)</th>
																		<th rowspan="2">Total cost of project</th>
																		<th rowspan="2">Fund required (in RS.)</th>
																		<th rowspan="2">Brief about Activity</th>
																		<th rowspan="2">Upload File(PDF)</th>
																		<th rowspan="2">Plan approved by DPC</th>
																	</tr>
																	<tr>
																		<th>From</th>
																		<th>To</th>
																	</tr>

																</thead>
																<tbody>

																	<tr>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>

																		<td><input type="text" class="form-control" /></td>


																		<td><input type="text" class="form-control" /></td>

																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>

																		<td><input type="file" class="form-control-file" /></td>
																		<td><input type="checkbox"
																			class="form-check-input" /></td>

																	</tr>

																</tbody>
															</table>
														</c:when>
														<c:when test="${menu.menuId eq 21}">
															<table class="table table-hover dashboard-task-infos">
																<thead>
																	<tr>
																		<th rowspan="2">Name of Activity</th>
																		<th rowspan="2">Name of Ministry/Scheme</th>
																		<th rowspan="2">District Name</th>
																		<th rowspan="2">Block Name</th>
																		<th rowspan="2">No. of GPs</th>
																		<th rowspan="2">No. of GPS in Mission Antyodaya</th>
																		<th rowspan="2">No. of Aspirational GPs</th>
																		<th colspan="2">Time Frame of project(year wise)</th>
																		<th rowspan="2">Total cost of project</th>
																		<th rowspan="2">Fund required (in RS.)</th>
																		<th rowspan="2">Brief about Activity</th>
																		<th rowspan="2">Upload File(PDF)</th>
																		<th rowspan="2">Plan approved by DPC</th>
																	</tr>
																	<tr>
																		<th>From</th>
																		<th>To</th>
																	</tr>

																</thead>
																<tbody>

																	<tr>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>

																		<td><input type="text" class="form-control" /></td>


																		<td><input type="text" class="form-control" /></td>

																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>

																		<td><input type="file" class="form-control-file" /></td>
																		<td><input type="checkbox"
																			class="form-check-input" /></td>

																	</tr>

																</tbody>
															</table>
														</c:when>
														<c:when test="${menu.menuId eq 21}">
															<table class="table table-hover dashboard-task-infos">
																<thead>
																	<tr>
																		<th rowspan="2">Name of Activity</th>
																		<th rowspan="2">Name of Ministry/Scheme</th>
																		<th rowspan="2">District Name</th>
																		<th rowspan="2">Block Name</th>
																		<th rowspan="2">No. of GPs</th>
																		<th rowspan="2">No. of GPS in Mission Antyodaya</th>
																		<th rowspan="2">No. of Aspirational GPs</th>
																		<th colspan="2">Time Frame of project(year wise)</th>
																		<th rowspan="2">Total cost of project</th>
																		<th rowspan="2">Fund required (in RS.)</th>
																		<th rowspan="2">Brief about Activity</th>
																		<th rowspan="2">Upload File(PDF)</th>
																		<th rowspan="2">Plan approved by DPC</th>
																	</tr>
																	<tr>
																		<th>From</th>
																		<th>To</th>
																	</tr>

																</thead>
																<tbody>

																	<tr>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>

																		<td><input type="text" class="form-control" /></td>


																		<td><input type="text" class="form-control" /></td>

																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>
																		<td><input type="text" class="form-control" /></td>

																		<td><input type="file" class="form-control-file" /></td>
																		<td><input type="checkbox"
																			class="form-check-input" /></td>

																	</tr>

																</tbody>
															</table>
														</c:when>

														<c:when test="${menu.menuId eq 15}">
															<div class="panel-group" id="capacityPlanBuildingId">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#capacityPlanBuildingId"
																				href="#needAssessmentId"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> Training Need Assessments</i></a>
																		</h4>
																	</div>
																</div>
																<div id="needAssessmentId"
																	class="panel-collapse collapse">
																	<div class="panel-body">
																		<table id="table1id" class="table table-bordered">
																			<thead>
																				<tr>
																					<th><div align="center">
																							<strong>Subject of Trainings</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>No. of Assessments </strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Unit Cost</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Funds proposed(in Rs)</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Remarks </strong>
																						</div></th>
																				</tr>
																			</thead>
																			<tbody id="body1">
																				<tr id="tr1">
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><textarea rows="2" cols="5"></textarea></td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>
															<!-- form 2 -->
															<div class="panel-group" id="capacityPlanBuildingId">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#capacityPlanBuildingId"
																				href="#TrainingModuleId"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> Training Module</i></a>
																		</h4>
																	</div>
																</div>
																<div id="TrainingModuleId"
																	class="panel-collapse collapse">
																	<div class="panel-body">
																		<table id="table2id" class="table table-bordered">
																			<thead>
																				<tr>
																					<th><div align="center">
																							<strong>Subject of Trainings</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>No. of Modules</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Unit Cost</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Funds proposed(in Rs) </strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Remarks </strong>
																						</div></th>
																				</tr>
																			</thead>
																			<tbody id="body2">
																				<tr id="tr2">
																					<td><select>
																							<option value="0">Select</option>
																							<option value="1">SAHEBGANJ,</option>
																							<option value="2">RAJGARH,</option>
																							<option value="3">SHRAWASTI</option>
																					</select></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><textarea rows="2" cols="5"></textarea></td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>
															<!-- form 3 -->
															<div class="panel-group" id="capacityPlanBuildingId">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#capacityPlanBuildingId"
																				href="#TrainingMaterialId"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> Training Material</i></a>
																		</h4>
																	</div>
																</div>
																<div id="TrainingMaterialId"
																	class="panel-collapse collapse">
																	<div class="panel-body">
																		<div class="table-responsive">
																			<table id="table3id" class="table table-bordered">
																				<thead>
																					<tr>
																						<th><div align="center">
																								<strong>Subject of Trainings</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>No. of Training Material</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Unit Cost</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Funds proposed(in Rs) </strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Remarks </strong>
																							</div></th>
																					</tr>
																				</thead>
																				<tbody id="body3">
																					<tr id="tr3">
																						<td><select>
																								<option value="0">Select</option>
																								<option value="1">SAHEBGANJ,</option>
																								<option value="2">RAJGARH,</option>
																								<option value="3">SHRAWASTI</option>
																						</select></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><textarea rows="2" cols="5"></textarea></td>
																					</tr>
																				</tbody>
																			</table>
																		</div>
																	</div>
																</div>
															</div>

															<!-- form 4 -->
															<div class="panel-group" id="capacityPlanBuildingId">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#capacityPlanBuildingId"
																				href="#EvaluationofTrainingId"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> Evaluation of Training</i></a>
																		</h4>
																	</div>
																</div>
																<div id="EvaluationofTrainingId"
																	class="panel-collapse collapse">
																	<div class="panel-body">
																		<div class="table-responsive">
																			<table id="table4id" class="table table-bordered">
																				<thead>
																					<tr>
																						<th><div align="center">
																								<strong>Subject of Trainings</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>No. of Training Evaluation</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Unit Cost</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Funds proposed(in Rs) </strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Remarks </strong>
																							</div></th>
																					</tr>
																				</thead>
																				<tbody id="body4">
																					<tr id="tr4">
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><textarea rows="2" cols="5"></textarea></td>
																					</tr>
																				</tbody>
																			</table>
																		</div>
																	</div>
																</div>
															</div>

															<!-- form 5 -->
															<div class="panel-group" id="capacityPlanBuildingId">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#capacityPlanBuildingId"
																				href="#ExposureVisitId"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> Exposure Visit (within
																					State)</i></a>
																		</h4>
																	</div>
																</div>
																<div id="ExposureVisitId"
																	class="panel-collapse collapse">
																	<div class="panel-body">
																		<div class="table-responsive">
																			<table id="table5id" class="table table-bordered">
																				<thead>
																					<tr>
																						<th><div align="center">
																								<strong>Subject of Visit</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>No. of Batches</strong>
																							</div></th>

																						<th><div align="center">
																								<strong>No. of Units</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Unit Cost</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Funds proposed(in Rs) </strong>
																							</div></th>
																						<th><div align="center">
																								<strong>GPs within State </strong>
																							</div></th>

																						<th><div align="center">
																								<strong>Remarks </strong>
																							</div></th>
																					</tr>
																				</thead>
																				<tbody id="body5">
																					<tr id="tr5">
																						<td><input type="file" class="form-control"></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><div class="form-group">
																								<div class="form-line">
																									<select multiple="multiple"
																										data-selected-text-format="count">
																										<option value="1">BHIND</option>
																										<option value="2">FATEHABAD</option>
																										<option value="3">SAHEBGANJ</option>
																										<option value="4">RAJGARH</option>
																									</select>
																								</div>
																							</div></td>
																						<td><textarea rows="2" cols="5"></textarea></td>
																					</tr>
																				</tbody>
																			</table>
																		</div>
																	</div>
																</div>
															</div>

															<!-- form 6 -->
															<div class="panel-group" id="capacityPlanBuildingId">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#capacityPlanBuildingId"
																				href="#ExposureVisit2Id"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> Exposure Visit (Outside
																					State)</i></a>
																		</h4>
																	</div>
																</div>
																<div id="ExposureVisit2Id"
																	class="panel-collapse collapse">
																	<div class="panel-body">
																		<div class="table-responsive">
																			<table id="table6id" class="table table-bordered">
																				<thead>
																					<tr>

																						<th colspan="4"><div align="center">
																								<strong>Subject of Visit</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>No. of Batches</strong>
																							</div></th>

																						<th><div align="center">
																								<strong>No. of Units</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Unit Cost</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Funds proposed(in Rs) </strong>
																							</div></th>
																						<th><div align="center">
																								<strong>State Name</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>GPs within State </strong>
																							</div></th>

																						<th><div align="center">
																								<strong>Remarks </strong>
																							</div></th>
																					</tr>
																				</thead>
																				<tbody id="body6">
																					<tr id="tr6">
																						<td colspan="4"><input type="file"
																							class="form-control"></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><div class="form-group">
																								<div class="form-line">
																									<select multiple="multiple"
																										data-selected-text-format="count">
																										<option value="1">Punjab</option>
																										<option value="2">Haryana</option>
																										<option value="3">Uttar Pradesh</option>
																										<option value="4">Bihar</option>
																									</select>
																								</div>
																							</div></td>
																						<td><div class="form-group">
																								<div class="form-line">
																									<select multiple="multiple"
																										data-selected-text-format="count">
																										<option value="1">BHIND</option>
																										<option value="2">FATEHABAD</option>
																										<option value="3">SAHEBGANJ</option>
																										<option value="4">RAJGARH</option>
																									</select>
																								</div>
																							</div></td>
																						<td><textarea rows="2" cols="5"></textarea></td>
																					</tr>
																				</tbody>
																			</table>
																		</div>
																	</div>
																</div>
															</div>

															<!-- form 7 -->
															<div class="panel-group" id="capacityPlanBuildingId">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#capacityPlanBuildingId"
																				href="#GPDPFormulationID"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> Hand Holding for GPDP
																					formulation</i></a>
																		</h4>
																	</div>
																</div>
																<div id="GPDPFormulationID"
																	class="panel-collapse collapse">
																	<div class="panel-body">
																		<div class="table-responsive">
																			<table id="table7id" class="table table-bordered">
																				<thead>
																					<tr>
																						<th colspan="4"><div align="center">
																								<strong>Subject</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>No. of Units</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Unit Cost</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Funds proposed(in Rs) </strong>
																							</div></th>
																						<th><div align="center">
																								<strong>GPs within State </strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Collaboration with Inst</strong>
																							</div></th>

																						<th><div align="center">
																								<strong>Remarks </strong>
																							</div></th>
																					</tr>
																				</thead>
																				<tbody id="body7">
																					<tr id="tr7">
																						<td colspan="4"><input type="file"
																							class="form-control"></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><div class="form-group">
																								<div class="form-line">
																									<select multiple="multiple"
																										data-selected-text-format="count">
																										<option value="1">BHIND</option>
																										<option value="2">FATEHABAD</option>
																										<option value="3">SAHEBGANJ</option>
																										<option value="4">RAJGARH</option>
																									</select>
																								</div>
																							</div></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><textarea rows="2" cols="5"></textarea></td>
																					</tr>
																				</tbody>
																			</table>
																		</div>
																	</div>
																</div>
															</div>

															<!-- from 8 -->
															<div class="panel-group" id="capacityPlanBuildingId">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#capacityPlanBuildingId"
																				href="#PanchayatLearningCenter"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> Panchayat Learning Center</i></a>
																		</h4>
																	</div>
																</div>
																<div id="PanchayatLearningCenter"
																	class="panel-collapse collapse">
																	<div class="panel-body">
																		<div class="table-responsive">
																			<table id="table8id" class="table table-bordered">
																				<thead>
																					<tr>
																						<th colspan="4"><div align="center">
																								<strong>Subject</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>No. of Units</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Unit Cost</strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Funds proposed(in Rs) </strong>
																							</div></th>
																						<th><div align="center">
																								<strong>GPs within State </strong>
																							</div></th>
																						<th><div align="center">
																								<strong>Collaboration with Inst</strong>
																							</div></th>

																						<th><div align="center">
																								<strong>Remarks </strong>
																							</div></th>
																					</tr>
																				</thead>
																				<tbody id="body8">
																					<tr id="tr8">
																						<td colspan="4"><input type="file"
																							class="form-control"></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><div class="form-group">
																								<div class="form-line">
																									<select multiple="multiple"
																										data-selected-text-format="count">
																										<option value="1">BHIND</option>
																										<option value="2">FATEHABAD</option>
																										<option value="3">SAHEBGANJ</option>
																										<option value="4">RAJGARH</option>
																									</select>
																								</div>
																							</div></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><textarea rows="2" cols="5"></textarea></td>
																					</tr>
																				</tbody>
																			</table>

																		</div>
																	</div>
																</div>
															</div>
															<table class="table table-bordered">
																<tbody>
																	<tr>
																		<th><strong>Total Cost </strong></th>
																		<td colspan="2"></td>
																		<td><input type="text" class="form-control"
																			style="width: 300px" /></td>
																	</tr>
																	<tr>
																		<th><strong>Additional Requirement</strong></th>
																		<td colspan="2"></td>
																		<td><input type="text" class="form-control"
																			style="width: 300px" placeholder="25% of total" /></td>
																	</tr>
																	<tr>
																		<th><strong>Total Proposed Fund </strong></th>
																		<td colspan="2"></td>
																		<td><input type="text" class="form-control"
																			style="width: 300px"
																			placeholder="Additional Requirement +  Total Cost" /></td>
																	</tr>
																</tbody>
															</table>

															<table class="table table-bordered">
																<tbody>
																	<tr>
																		<th><strong>Total Cost </strong></th>
																		<td colspan="2"></td>
																		<td><input type="text" class="form-control"
																			style="width: 300px" /></td>
																	</tr>
																	<tr>
																		<th><strong>Additional Requirement</strong></th>
																		<td colspan="2"></td>
																		<td><input type="text" class="form-control"
																			style="width: 300px" placeholder="25% of total" /></td>
																	</tr>
																	<tr>
																		<th><strong>Total Proposed Fund </strong></th>
																		<td colspan="2"></td>
																		<td><input type="text" class="form-control"
																			style="width: 300px"
																			placeholder="Additional Requirement +  Total Cost" /></td>
																	</tr>
																</tbody>
															</table>
															<table class="table table-bordered">
																<tbody>
																	<tr>
																		<th><strong>Total Cost </strong></th>
																		<td colspan="2"></td>
																		<td><input type="text" class="form-control"
																			style="width: 300px" /></td>
																	</tr>
																	<tr>
																		<th><strong>Additional Requirement</strong></th>
																		<td colspan="2"></td>
																		<td><input type="text" class="form-control"
																			style="width: 300px" placeholder="25% of total" /></td>
																	</tr>
																	<tr>
																		<th><strong>Total Proposed Fund </strong></th>
																		<td colspan="2"></td>
																		<td><input type="text" class="form-control"
																			style="width: 300px"
																			placeholder="Additional Requirement +  Total Cost" /></td>
																	</tr>
																</tbody>
															</table>
														</c:when>

														<c:when test="${menu.menuId eq 35}">
															<div class="panel-group" id="capacityPlanBuilding2Id">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#capacityPlanBuildingId" href="#GPDPid"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> GPDP</i></a>
																		</h4>
																	</div>
																</div>
																<div id="GPDPid" class="panel-collapse collapse">
																	<div class="panel-body">
																		<table id="table1id" class="table table-bordered">
																			<thead>
																				<tr>
																					<th>Training Subject</th>
																					<th>Training Venue Level</th>
																					<th>Training Institute</th>
																					<th>Target Group Level</th>
																					<th>No. of Participants</th>
																					<th>No. of Days Proposed</th>
																					<th>Unit Cost</th>
																					<th>Funds Proposed</th>
																					<th>Whether Master Trainer Trained for
																						Training</th>
																					<th>Whether Training need Assessment done</th>
																					<th>Whether Training Module Prepared</th>
																					<th>Arrangements for coordinating and
																						monitoring cascading training.</th>
																					<th>Arrangements for evaluation</th>
																					<th>Remarks</th>
																				</tr>
																			</thead>
																			<tbody>
																				<tr>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><textarea rows="2" cols="5"></textarea></td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>

															<!-- form 2 -->
															<div class="panel-group" id="capacityPlanBuilding2Id">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#capacityPlanBuildingId"
																				href="#GeneralOrientationId"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> General Orientation</i></a>
																		</h4>
																	</div>
																</div>
																<div id="GeneralOrientationId"
																	class="panel-collapse collapse">
																	<div class="panel-body">
																		<table id="table1id" class="table table-bordered">
																			<thead>
																				<tr>
																					<th>Training Subject</th>
																					<th>Training Venue Level</th>
																					<th>Training Institute</th>
																					<th>Target Group Level</th>
																					<th>No. of Participants</th>
																					<th>No. of Days Proposed</th>
																					<th>Unit Cost</th>
																					<th>Funds Proposed</th>
																					<th>Whether Master Trainer Trained for
																						Training</th>
																					<th>Whether Training need Assessment done</th>
																					<th>Whether Training Module Prepared</th>
																					<th>Arrangements for coordinating and
																						monitoring cascading training.</th>
																					<th>Arrangements for evaluation</th>
																					<th>Remarks</th>
																				</tr>
																			</thead>
																			<tbody>
																				<tr>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><textarea rows="2" cols="5"></textarea></td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>



															<!-- form 3 -->
															<div class="panel-group" id="capacityPlanBuilding2Id">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#capacityPlanBuildingId" href="#SDGsId"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> SDGs/ Thematic Areas</i></a>
																		</h4>
																	</div>
																</div>
																<div id="SDGsId" class="panel-collapse collapse">
																	<div class="panel-body">
																		<table id="table1id" class="table table-bordered">
																			<thead>
																				<tr>
																					<th>Training Subject</th>
																					<th>Training Venue Level</th>
																					<th>Training Institute</th>
																					<th>Target Group Level</th>
																					<th>No. of Participants</th>
																					<th>No. of Days Proposed</th>
																					<th>Unit Cost</th>
																					<th>Funds Proposed</th>
																					<th>Whether Master Trainer Trained for
																						Training</th>
																					<th>Whether Training need Assessment done</th>
																					<th>Whether Training Module Prepared</th>
																					<th>Arrangements for coordinating and
																						monitoring cascading training.</th>
																					<th>Arrangements for evaluation</th>
																					<th>Remarks</th>
																				</tr>
																			</thead>
																			<tbody>
																				<tr>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><textarea rows="2" cols="5"></textarea></td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>

															<!-- form 4 -->
															<div class="panel-group" id="capacityPlanBuilding2Id">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#capacityPlanBuildingId"
																				href="#EGovernanceid"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> e-Governance</i></a>
																		</h4>
																	</div>
																</div>
																<div id="EGovernanceid" class="panel-collapse collapse">
																	<div class="panel-body">
																		<table id="table1id" class="table table-bordered">
																			<thead>
																				<tr>
																					<th>Training Subject</th>
																					<th>Training Venue Level</th>
																					<th>Training Institute</th>
																					<th>Target Group Level</th>
																					<th>No. of Participants</th>
																					<th>No. of Days Proposed</th>
																					<th>Unit Cost</th>
																					<th>Funds Proposed</th>
																					<th>Whether Master Trainer Trained for
																						Training</th>
																					<th>Whether Training need Assessment done</th>
																					<th>Whether Training Module Prepared</th>
																					<th>Arrangements for coordinating and
																						monitoring cascading training.</th>
																					<th>Arrangements for evaluation</th>
																					<th>Remarks</th>
																				</tr>
																			</thead>
																			<tbody>
																				<tr>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><textarea rows="2" cols="5"></textarea></td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>



															<!-- form 3 -->
															<div class="panel-group" id="capacityPlanBuilding2Id">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#capacityPlanBuildingId" href="#SDGsId"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> SDGs/ Thematic Areas</i></a>
																		</h4>
																	</div>
																</div>
																<div id="SDGsId" class="panel-collapse collapse">
																	<div class="panel-body">
																		<table id="table1id" class="table table-bordered">
																			<thead>
																				<tr>
																					<th>Training Subject</th>
																					<th>Training Venue Level</th>
																					<th>Training Institute</th>
																					<th>Target Group Level</th>
																					<th>No. of Participants</th>
																					<th>No. of Days Proposed</th>
																					<th>Unit Cost</th>
																					<th>Funds Proposed</th>
																					<th>Whether Master Trainer Trained for
																						Training</th>
																					<th>Whether Training need Assessment done</th>
																					<th>Whether Training Module Prepared</th>
																					<th>Arrangements for coordinating and
																						monitoring cascading training.</th>
																					<th>Arrangements for evaluation</th>
																					<th>Remarks</th>
																				</tr>
																			</thead>
																			<tbody>
																				<tr>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><textarea rows="2" cols="5"></textarea></td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>
															<!-- form 4 -->
															<div class="panel-group" id="capacityPlanBuilding2Id">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#capacityPlanBuildingId"
																				href="#EGovernanceid"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> e-Governance</i></a>
																		</h4>
																	</div>
																</div>
																<div id="EGovernanceid" class="panel-collapse collapse">
																	<div class="panel-body">
																		<table id="table1id" class="table table-bordered">
																			<thead>
																				<tr>
																					<th>Training Subject</th>
																					<th>Training Venue Level</th>
																					<th>Training Institute</th>
																					<th>Target Group Level</th>
																					<th>No. of Participants</th>
																					<th>No. of Days Proposed</th>
																					<th>Unit Cost</th>
																					<th>Funds Proposed</th>
																					<th>Whether Master Trainer Trained for
																						Training</th>
																					<th>Whether Training need Assessment done</th>
																					<th>Whether Training Module Prepared</th>
																					<th>Arrangements for coordinating and
																						monitoring cascading training.</th>
																					<th>Arrangements for evaluation</th>
																					<th>Remarks</th>
																				</tr>
																			</thead>
																			<tbody>
																				<tr>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><textarea rows="2" cols="5"></textarea></td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>
															<!-- form 5 -->
															<div class="panel-group" id="capacityPlanBuilding2Id">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#capacityPlanBuildingId" href="#Pesaid"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true">Pesa</i></a>
																		</h4>
																	</div>

																	<div id="Pesaid" class="panel-collapse collapse">
																		<div class="panel-body">
																			<table id="table1id" class="table table-bordered">
																				<thead>
																					<tr>
																						<th>Training Subject</th>
																						<th>Training Venue Level</th>
																						<th>Training Institute</th>
																						<th>Target Group Level</th>
																						<th>No. of Participants</th>
																						<th>No. of Days Proposed</th>
																						<th>Unit Cost</th>
																						<th>Funds Proposed</th>
																						<th>Whether Master Trainer Trained for
																							Training</th>
																						<th>Whether Training need Assessment done</th>
																						<th>Whether Training Module Prepared</th>
																						<th>Arrangements for coordinating and
																							monitoring cascading training.</th>
																						<th>Arrangements for evaluation</th>
																						<th>Remarks</th>
																					</tr>
																				</thead>
																				<tbody>
																					<tr>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><input type="text" class="form-control" /></td>
																						<td><textarea rows="2" cols="5"></textarea></td>
																					</tr>
																				</tbody>
																			</table>
																		</div>
																	</div>
																</div>
															</div>

															<table class="table table-bordered">
																<tbody>
																	<tr>
																		<th><strong>Total Cost </strong></th>
																		<td colspan="2"></td>
																		<td><input type="text" class="form-control"
																			style="width: 300px" /></td>
																	</tr>
																	<tr>
																		<th><strong>Additional Requirement</strong></th>
																		<td colspan="2"></td>
																		<td><input type="text" class="form-control"
																			style="width: 300px" placeholder="25% of total" /></td>
																	</tr>
																	<tr>
																		<th><strong>Total Proposed Fund </strong></th>
																		<td colspan="2"></td>
																		<td><input type="text" class="form-control"
																			style="width: 300px"
																			placeholder="Additional Requirement +  Total Cost" /></td>
																	</tr>
																</tbody>
															</table>
														</c:when>


														<c:when test="${menu.menuId eq 31}">
															<div class="panel-group" id="InstitutionalId">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#InstitutionalId" href="#ActivityPlan"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> Activity Plan</i></a>
																		</h4>
																	</div>
																</div>
																<div id="ActivityPlan" class="panel-collapse collapse">
																	<div class="panel-body">
																		<table class="table table-bordered">
																			<thead>
																				<tr>
																					<th colspan="8"><strong>Activity Plan</strong></th>
																				</tr>
																				<tr>
																					<th><div align="center">
																							<strong>Type of Building(SPRC/ DPRC)</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>District Name </strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Land identified (YES/NO)</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Any other source of funding
																								(YES/NO)</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Design and Layout of building
																								(YES/NO) </strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Upload Photo </strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Remarks</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Funds Proposed (in Rs) </strong>
																						</div></th>
																				</tr>
																			</thead>
																			<tbody>
																				<tr>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="checkbox"
																						class="form-check-input" /></td>
																					<td><input type="checkbox"
																						class="form-check-input" /></td>
																					<td><input type="checkbox"
																						class="form-check-input" /></td>
																					<td><input type="file"
																						class="form-control-file" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>

																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>

															<!-- form 2 -->
															<div class="panel-group" id="InstitutionalId">
																<div class="panel panel-default">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<a data-toggle="collapse"
																				data-parent="#InstitutionalId"
																				href="#CarryForwardId"><i
																				class="fa fa-caret-square-o-down view-color fa-lg"
																				aria-hidden="true"> Carry Forward</i></a>
																		</h4>
																	</div>
																</div>
																<div id="CarryForwardId" class="panel-collapse collapse">
																	<div class="panel-body">
																		<table class="table table-bordered">
																			<thead>
																				<tr>
																					<th colspan="8"><strong>Carry Forward</strong></th>
																				</tr>
																				<tr>
																					<th><div align="center">
																							<strong>New Building/ Extension</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>District Name </strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Funds Released</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Fund Utilized</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Status</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Upload Photo </strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Remarks</strong>
																						</div></th>
																					<th><div align="center">
																							<strong>Funds Proposed (in Rs) </strong>
																						</div></th>
																				</tr>
																			</thead>
																			<tbody>
																				<tr>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="file" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>
																					<td><input type="text" class="form-control" /></td>

																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>
														</c:when>
														<c:otherwise>A - ${count.count}</c:otherwise>

													</c:choose>
												</div>
											</div>
										</div>
									</div>

								</c:forEach>

							</div>
						</div>
					</div>
					<div class="text-right">
						<div class="form-group text-right">
							<button type="button" id="bb-nav-prev"
								class="btn bg-blue-grey waves-effect bg-maroon ">
								<i class="fa fa-arrow-left" aria-hidden="true"></i> Previous
								Page
							</button>
							<button type="button" id="bb-nav-next"
								class="bg-maroon  btn bg-blue-grey waves-effect">
								<i class="fa fa-arrow-right" aria-hidden="true"></i> Next page
							</button>
							<button type="button"
								onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
								class="btn bg-orange waves-effect">CLOSE</button>
						</div>
						<br />
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/flipBook/js/modernizr.custom.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/flipBook/js/jquery.bookblock.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/flipBook/js/page.js"></script>
<script>

	$(function() {
		Page.init();
	});

</script>
