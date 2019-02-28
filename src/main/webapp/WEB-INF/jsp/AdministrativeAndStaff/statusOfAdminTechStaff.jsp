<%@include file="../taglib/taglib.jsp"%>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/dataTables/css/dataTables.bootstrap.min.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/dataTables.bootstrap.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/adminAndTechStaffStatus/adminAndTechStaffStatusController.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/adminAndTechStaffStatus/adminAndTechStaffStatusService.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>

<html data-ng-app="publicModule">
	<section class="content" data-ng-controller="adminAndTechStaffStatusController">
		<div class="container-fluid">
			<div class="block-header"></div>
	
			<div class="row clearfix">
				<!-- Task Info -->
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="card">
						<div class="header">
							<h2>Status of Administrative & Technical Staff at Panchayat</h2>
						</div>
						<div class="body">
							
							<div class="table-responsive">
								<div class="card">
									<table id="tableId"
										class="table table-hover dashboard-task-infos">
										<thead>
											<tr>
												<th>Level</th>
												<th>Type of Post</th>
												<th>Post Name</th>
												<th colspan="2" style="text-align: center">Regular</th>
												<th>Contractual</th>
											</tr>
											<tr>
												<th colspan="3"></th>
												<th>Sanctioned</th>
												<th>Positioned</th>
												<th>Positioned</th>
											</tr>
	
										</thead>
										<tbody>
											
												<tr data-ng-repeat="postAndMaster in postAndPostMasterDetails" data-ng-init="outerIndex = $index">
	
													<td>
														<select convert-to-number data-ng-model="adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[outerIndex].postLevel.postLevelId">
															<option data-ng-repeat="postLevel in postLevels" value="{{postLevel.postLevelId}}">
																{{postLevel.postLevelName}}
															</option>
														</select>
													</td>
													<td>
														<label style="text-align: center;">
															{{postAndMaster.master.postTypeName}}
															
														</label>
													</td>
													<td>
														<label style="text-align: center;" >
															{{postAndMaster.postName}}
															<input type="hidden" id="postTypeNames_{{$index}}" class="form-control" data-ng-value="postAndMaster.postId" 
																data-ng-model="adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[$index].postType.postId" />
														</label>
													</td>
													<td><input type="text" class="form-control" maxlength="5" restrict-input="{type: 'digitsOnly',index: $index}" data-ng-change="insertPostTypeValueInScope($index);validateSanctioned($index)" data-ng-model="adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[$index].regNoOfSanctioned" /></td>
													<td><input type="text" class="form-control" maxlength="5" restrict-input="{type: 'digitsOnly',index: $index}" data-ng-change="insertPostTypeValueInScope($index);validateValue($index)" data-ng-model="adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[$index].regNoOfPositioned"/></td>
													<td><input type="text" class="form-control" maxlength="5" restrict-input="{type: 'digitsOnly',index: $index}" data-ng-change="insertPostTypeValueInScope($index)" data-ng-model="adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[$index].contrNoOfPositioned"/></td>
												</tr>
	
										</tbody>
									</table>
								</div>
							</div>
							<div class="form-group text-right">
								<button data-ng-show="adminAndTechStaffStatus.isFreeze" type="button" data-ng-click="freezUnFreezAdminAndTechStaffStatus('unfreez')" class="btn bg-green waves-effect">
									<spring:message code="UNFREEZE" htmlEscape="true" />
								</button>
								<button data-ng-show="!adminAndTechStaffStatus.isFreeze" type="button" data-ng-click="freezUnFreezAdminAndTechStaffStatus('freez')" class="btn bg-green waves-effect">
									<spring:message code="FREEZE" htmlEscape="true" />
								</button>
								<button type="submit" data-ng-click="saveCurrentStatus()" data-ng-disabled="adminAndTechStaffStatus.isFreeze"  class="btn q waves-effect">SAVE</button>
								<button type="button" data-ng-click="onClear()" class="btn bg-light-blue waves-effect">CLEAR</button>
								<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-orange waves-effect">CLOSE</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</html>
