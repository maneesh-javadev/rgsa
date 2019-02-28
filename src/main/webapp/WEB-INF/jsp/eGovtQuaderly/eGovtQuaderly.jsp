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
						<div align="center" class="form-group">
							<label for="selectLevel" class="col-sm-3">Select Quarter
								Duration</label>
							<div class="col-sm-3">
								<select class="form-control" id="qtrIdDurtn" 
								data-ng-model="selectedQuarterId" data-ng-change="fetchData( selectedQuarterId, '{{selectedQuarterId}}')">
									<option value="0">Select Duration</option>
									<c:forEach items="${quarter_duration}" var="duration"
										varStatus="index">
										<c:choose>
											<c:when
												test="${duration.qtrId == fetchTrainingProgressReport.trainingDetailsProgressReportList[index.index].quarterDuration.qtrId}">
												<option value="${duration.qtrId}" selected="selected">${duration.qtrDuration}
												</option>
											</c:when>
											<c:otherwise>
												<option value="${duration.qtrId}">${duration.qtrDuration}
												</option>
											</c:otherwise>
										</c:choose>
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
									<tr data-ng-repeat="expenditure in formObj.expenditures">

											<td class="text-center">
												<span>{{expenditure.egovPostLevelName}}</span>
											</td>

											<td class="text-center">
												<span  data-ng-model="expenditure.egovPostId">{{expenditure.egovPostName}}</span>
											</td>
											<td class="text-center">
												<span>{{expenditure.postApproved}}</span>
											</td>
											<td class="text-center">
												<span>{{expenditure.costApproved}}</span>
											</td>
											<td class="text-right">
												<input type="number" name="postFilled_{{$index}}"
													data-ng-model="expenditure.postFilled"
													data-ng-disabled="formObj.isFreeze"
													class="form-control no-scroll" placeholder="Post filled"
													min="0"
													max="{{expenditure.postApproved}}" />
												<span class="help-block" data-ng-messages="pageForm['postFilled_' + $index].$error">
													<span ng-message="max" class="text-danger">Above allowed limit</span>
												</span>
											</td>
											<td class="text-right">
												<input type="number" name="incurred_{{$index}}"
													data-ng-model="expenditure.incurred"
													data-ng-disabled="formObj.isFreeze"
													class="form-control no-scroll"
													placeholder=" <= {{expenditure.postFilled*expenditure.costApproved}} "
													min="0"
													max="{{expenditure.postFilled*expenditure.costApproved}}"/>
												<span class="help-block" data-ng-messages="pageForm['incurred_' + $index].$error">
													<span ng-message="max" class="text-danger">Above allowed limit</span>
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
													Requirement
												</strong>
											</div></td>
										<td colspan="4"></td>
										<td class="text-right"><input type="number" class="form-control no-scroll" 
												class="form-control" data-ng-disabled="formObj.isFreeze"
												data-ng-model="formObj.additionalRequirement"
												placeholder="25% of Total Cost" name="additionalRequirement"" /></td>
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
									ng-disabled="!pageForm.$dirty" ng-show="!formObj.isFreeze && pageForm.$valid">Submit</button>
								<!-- Provides extra visual weight and identifies the primary action in a set of buttons -->
								<button type="button" class="btn btn-info"
									ng-click="freezeUnfreeze()" ng-show="!pageForm.$dirty && !formObj.isNew">
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

