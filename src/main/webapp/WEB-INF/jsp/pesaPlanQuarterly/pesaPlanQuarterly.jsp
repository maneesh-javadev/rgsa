<%@include file="../taglib/taglib.jsp"%>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular-messages.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>


<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/pesaPlanQuarterly/pesaPlanQController.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<script type="text/javascript">
$('document').ready(function(){
	 $('.active1').prop('readonly',true);
});

</script>

<html data-ng-app="publicModule">

<section data-ng-controller="pesaPlanQController" class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>PESA Plan</h2>
					</div>

					<div align="center" class="row">
						<br />
						<div align="center" class="form-group">
							<label for="selectLevel" class="col-sm-3">Select Quarter
								Duration</label>
							<div class="col-sm-3">
								<select class="form-control" id="qtrIdDurtn" ng-model="selectedQuarterId" ng-change="fetchData( selectedQuarterId, '{{selectedQuarterId}}')">
				            		<option value="0">Select Duration</option>
									<c:forEach items="${quarter_duration}" var="duration" varStatus="index">
			            				<c:choose>
				            				<c:when test="${duration.qtrId == fetchTrainingProgressReport.trainingDetailsProgressReportList[index.index].quarterDuration.qtrId}">
			                   					<option value="${duration.qtrId}" selected="selected">${duration.qtrDuration} </option>
			                   				</c:when>
			                   				<c:otherwise>
			                   					<option value="${duration.qtrId}">${duration.qtrDuration} </option>
			                   				</c:otherwise>
		                   				</c:choose>
		                       		</c:forEach>
	                        	</select>
							</div>
						</div>
					</div>

					<div class="body">
						<form class="table-responsive" name="pageForm" ng-show="formObj !== null">
							<table class="table table-hover dashboard-task-infos" id="mytable">
								<thead>
									<tr>
										<th class="text-center"><strong>Designation</strong></th>
										<th class="text-center"><strong>No. of Units Approved<br>
												A
										</strong></th>
										<th class="text-center"><strong>Unit Cost per
												month (in Rs) Approved<br> B
										</strong></th>
										<th class="text-center"><strong>No. of Units
												Completed<br> C
										</strong></th>
										<th class="text-center"><strong>Expenditure (in
												Rs) <br>D <= B * C
										</strong></th>
									</tr>
								</thead>
								<tbody>
									<tr data-ng-repeat="expenditure in formObj.expenditures">

										<td>
											<div>
												<div>
													<label style="text-align: center;"
														data-ng-model="expenditure.designationId">{{expenditure.designationName}}</label>
												</div>
											</div>
										</td>

										<td class="text-center"><span
											style="text-align: center;">{{expenditure.unitApproved}}</span>
										</td>
										<td class="text-center"><span
											style="text-align: center;">{{expenditure.costApproved}}</span>
										</td>
										<td class="text-right">
											<input type="number" class="no-scroll" name="unitCompleted_{{$index}}"
												data-ng-disabled="formObj.isFreeze"
												data-ng-model="expenditure.unitCompleted"
												class="form-control" placeholder="Units Completed"
												min="0"
												max="{{expenditure.unitApproved}}" />

											<span class="help-block" data-ng-messages="pageForm['unitCompleted_' + $index].$error">
												<span ng-message="max" class="text-danger">Above allowed limit</span>
											</span>
										</td>
										<td class="text-right">
											<input type="number" class="no-scroll" name="expenditure_{{$index}}"
											data-ng-disabled="formObj.isFreeze"
											data-ng-model="expenditure.expenditure"
											class="form-control"
											placeholder=" <= {{expenditure.unitCompleted*expenditure.costApproved}} "
											min="0"
											max="{{expenditure.unitCompleted*expenditure.costApproved}}"/>
											<span class="help-block" data-ng-messages="pageForm['expenditure_' + $index].$error">
												<span ng-message="max" class="text-danger">Above allowed limit</span>
											</span>
										</td>
									</tr>


									<tr>
										<td colspan="2">
											<div class="col-sm-7">
												<label>Additional Requirement</label>
											</div>
										</td>
										<td></td>
										<td></td>
										<td class="text-right">
											<input type="number" 
												data-ng-disabled="formObj.isFreeze"
												class="no-scroll form-control"
												data-ng-model="formObj.additional"
												placeholder="25% of Total Cost"
												name="additional"
												min="0"
												max="{{0.25*getExpenditure()}}"/>
											<span class="help-block" data-ng-messages="pageForm.additional.$error">
												<span ng-message="max" class="text-danger">Above allowed limit i.e. {{0.25*getExpenditure()}}</span>
											</span>
										</td>
										<td></td>
									</tr>

									<tr>
										<td colspan="2">
											<div class="col-sm-8">
												<label>Total Expenditure on Quarter</label>
											</div>
										</td>
										<td></td>
										<td></td>
										<td class="text-right grand-text">
											<span><b>{{getTotalExpenditure()}}</b></span>
										</td>
										<td></td>
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

					

					<!-- <div class="form-group text-right">
						<button type="button" data-ng-click="saveProgress()"
							 data-ng-show="!formObj.isFreez"
							 data-ng-disabled="!qprPesa.$dirty"
							class="btn bg-green waves-effect">
							<spring:message code="Label.SAVE" htmlEscape="true" />
						</button>
						<button data-ng-show="formObj.isFreez" type="button"
							data-ng-click="freezUnFreezPesaPlan('unfreeze')"
							class="btn bg-green waves-effect">
							<spring:message code="UNFREEZE" htmlEscape="true" />
						</button>
						<button data-ng-show="!formObj.isFreez" type="button"
							data-ng-click="freezUnFreezPesaPlan('freeze')"
							class="btn bg-green waves-effect">
							<spring:message code="FREEZE" htmlEscape="true" />
						</button>

						<button type="button" data-ng-click="onClear()"
							data-ng-disabled="formObj.isFreez"
							class="btn bg-light-blue waves-effect">
							<spring:message code="Label.CLEAR" htmlEscape="true" />
						</button>
						<button type="button"
							onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
							class="btn bg-orange waves-effect">
							<spring:message code="Label.CLOSE" htmlEscape="true" />
						</button>
					</div> -->
			</div>
		</div>
	</div>
</section>

</html>