<%@include file="../taglib/taglib.jsp"%>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular-messages.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
	
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/eGovtQuarterly/eGovtQuarterly.js"></script>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">


<section class="content" data-ng-app="qGovProgressApp">

	<div class="container-fluid" data-ng-controller="qGovProgressCtrl">
		<div class="row-clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>e-Governance Support Group</h2>
					</div>

					<div align="center" class="row">
						<div align="center" class="form-group padding_top">
							<label for="qtrIdDurtn" class="col-sm-3">Select Quarter
								Duration</label>
							<div class="col-sm-3">
								<select name="quarterSelect" class="form-control" id="qtrIdDurtn"
								data-ng-model="selectedQuarterId" data-ng-change="fetchData( selectedQuarterId, '{{selectedQuarterId}}')">
									<option value="0" selected="selected">-- Select Duration --</option>
									<c:forEach items="${quarter_duration}" var="duration" varStatus="index">
										<option value="${duration.qtrId}">${duration.qtrDuration}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>

					<div class="body">
						<form class="table-responsive" name="pageForm" ng-show="formObj !== null">
							<table id="tableId" class="table table-bordered">
								<thead>
									<tr>
										<th><div align="center">
												<strong>Level</strong>
											</div></th>
										<th><div align="center">
												<strong>Designation</strong>
											</div></th>
										<th><div align="center">
												<strong>No. of Posts approved<br> A
												</strong>
											</div></th>
										<th><div align="center">
												<strong>Unit Cost Approved (in Rs)<br> B
												</strong>
											</div></th>
										<th><div align="center">
												<strong>No of Post filled<br/>C <= A
												</strong>
											</div></th>
										<th><div align="center">
												<strong>Expenditure Incurred (in Rs)<br>D <= B * C
												</strong>
											</div></th>
									</tr>
								</thead>
								<tbody id="tbodyId">
									<tr data-ng-repeat="expenditure in formObj.expenditures" >

											<td class="text-center">
												<span>{{expenditure.egovPostLevelName}}</span>
											</td>

											<td class="text-center">
												<span  data-ng-model="expenditure.egovPostId">{{expenditure.egovPostName}}</span>
											</td>
											<td class="text-center" data-ng-if="expenditure.isPost">
												<span>{{expenditure.postApproved}}</span>
											</td>
											<td class="text-center" data-ng-if="expenditure.isPost">
												<span>{{expenditure.costApproved}}</span>
											</td>
											<td class="text-right" data-ng-if="expenditure.isPost">
												<input type="number" name="postFilled_{{$index}}"
													data-ng-model="expenditure.postFilled"
													data-ng-disabled="formObj.isFreeze"
													class="form-control no-scroll" placeholder="Post filled"
													min="0"
													max="{{expenditure.postApproved}}" />
												<span class="help-block" data-ng-messages="pageForm['postFilled_' + $index].$error">
													<span ng-message="max" class="text-danger">Above allowed limit of {{expenditure.postApproved}}</span>
												</span>
											</td>
											<td class="text-right" colspan="{{expenditure.isPost?1:4}}">
												<input type="number" name="incurred_{{$index}}"
													data-ng-model="expenditure.incurred"
													data-ng-disabled="formObj.isFreeze"
													class="form-control no-scroll"
													placeholder=" <= {{expenditure.funds - expenditure.spent}} "
													min="0"
													max="{{expenditure.funds - expenditure.spent}}"/>
												<span class="help-block" data-ng-messages="pageForm['incurred_' + $index].$error">
													<span ng-message="max" class="text-danger">Above allowed limit of {{expenditure.funds - expenditure.spent}}</span>
												</span>
											</td>
										</tr>
									
									
									
									<tr>
										<td><div align="center">
												<strong>Expenditure</strong>
											</div></td>
										<td colspan="4"></td>
										<td class="text-right"><span>{{getExpenditure()}}</span></td>
									</tr>
									<tr>
										<td><div align="center">
												<strong>Expenditure on <br /> Additional
													Requirement(Spmu)
												</strong>
											</div></td>
										<td colspan="4"></td>
										<td class="text-right">
											<input type="number"
												   class="form-control no-scroll"
												   data-ng-disabled="formObj.isFreeze"
												   data-ng-model="formObj.addReqSpmu"
												   name="addReqSpmu"
												   placeholder=" <= {{formObj.addReqSpmuApproved - formObj.addReqSpmuUsed}} "
												   min="0"
												   max="{{formObj.addReqSpmuApproved - formObj.addReqSpmuUsed}}" />
											<span class="help-block" data-ng-messages="pageForm['addReqSpmu'].$error">
												<span ng-message="max" class="text-danger">Above allowed limit of {{formObj.addReqSpmuApproved - formObj.addReqSpmuUsed}}</span>
											</span>
										</td>
									</tr>
									<tr>
										<td><div align="center">
												<strong>Expenditure on <br /> Additional
													Requirement(Dpmu)
												</strong>
											</div></td>
										<td colspan="4"></td>
										<td class="text-right">
											<input type="number"
												   class="form-control no-scroll"
												   data-ng-disabled="formObj.isFreeze"
												   data-ng-model="formObj.addReqDpmu"
												   name="addReqDpmu"
												   placeholder=" <= {{formObj.addReqDpmuApproved - formObj.addReqDpmuUsed}} "
												   min="0"
												   max="{{formObj.addReqDpmuApproved - formObj.addReqDpmuUsed}}" />
											<span class="help-block" data-ng-messages="pageForm['addReqDpmu'].$error">
												<span ng-message="max" class="text-danger">Above allowed limit of {{formObj.addReqDpmuApproved - formObj.addReqDpmuUsed}}</span>
											</span>
										</td>
									</tr>
									<tr>
										<td><div align="center">
												<strong>Total Expenditure</strong>
											</div></td>
										<td colspan="4"></td>
										<td  class="text-right grand-text"><span><b>{{getTotalExpenditure()}}</b></span></td>
									</tr>
								</tbody>
							</table>
							
							<div class="text-right">
								<button type="submit" class="btn btn-primary"
									ng-click="save()"
									ng-disabled="!pageForm.$dirty || actionDisable" ng-show="!formObj.isFreeze && pageForm.$valid">Submit</button>
								<!-- Provides extra visual weight and identifies the primary action in a set of buttons -->
								<button type="button" class="btn btn-info"
									ng-click="freezeUnfreeze()" ng-show="!pageForm.$dirty && !formObj.isNew" ng-disabled="actionDisable">
									{{ formObj.isFreeze ? 'UnFreeze' : 'Freeze' }}</button>
								<!-- Indicates a successful or positive action -->
								<button type="button" class="btn btn-danger" ng-click="clear()"
									ng-show="pageForm.$dirty">Reset</button>
								<button type="button" class="btn btn-warning"  onclick="onClose('home.html?<csrf:token uri='home.html'/>')">Close</button>
							</div>
						
						</form>

						
					</div>



				</div>
			</div>
		</div>
	</div>
</section>

