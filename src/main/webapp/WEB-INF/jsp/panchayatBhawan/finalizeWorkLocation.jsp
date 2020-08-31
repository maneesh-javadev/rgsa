<html ng-app="publicModule">

<head>	
	<%@include file="../taglib/taglib.jsp"%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/dataTables/css/dataTables.bootstrap.min.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/dataTables.bootstrap.min.js"></script>
	
	<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/plugins/angular/ui-bootstrap-tpls-0.11.0.js"></script>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/panchayatBhawan/workLocation/workLocationController.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/panchayatBhawan/workLocation/workLocationService.js"></script>

	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
	<!-- angular-confirm files -->
    <link rel="stylesheet"  type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/angular-confirm.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular-confirm.js"></script>
    <!--END angular-confirm files-->

<style type="text/css">
	.modal-content{
		width: 200%;
		margin-left: -30%;"
		height: 700px;
		overflow-y: scroll;
	}
	
	.modal .modal-content .modal-body {
    padding: 0px 0px !important;
	}
	
	
</style>


</head>

		
	<section class="content" ng-controller="workLocationController">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Finalize Work Location of Panchayat Bhawan</h2>
						</div>
						<div class="body">
	
	
							<div class="card">
								
								<div class="tab-content">
									<div role="tabpanel" class="tab-pane fade in active" id="home_with_icon_title">
									
									<!-- Modal content summary#started   style="width:950px;"-->
								      <div class="modal fade" id="garamPanchayatModal" role="dialog">
									    <div class="modal-dialog" >
									      <!-- Modal content-->
									      <div class="modal-content">
									        <div class="modal-header">
											  <!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
									          <h4 class="modal-title" id="garamPanchayatHead"></h4>
									        </div>
									        <div class="modal-body" >
									         	<div id="garamPanchayatBody">
									         	</div>
									        </div>
									         <div class="modal-footer">
							        			<center><button type="button" class="btn btn-primary" ng-click="SaveData()">Close</button></center>
							      			</div>
									      </div>
									      
									    </div>
									  </div>	
									<!-- Modal content summary#end-->
									
									<div class="form-group">
									<span class="errormessage" id="errorMessage"></span><br/>
									</div>
									
									
										<div class="table-responsive">
										
											<table id="table1id" class="table table-bordered">
												<thead>
													<tr>
														<th>
															<div align="center">
																<strong>Activities</strong>
															</div>
														</th>
														<th>
															<div align="center">
																<strong>Garam Panchayat</strong><br>
															</div>
														</th>
														
														
													</tr>
												</thead>
												<tbody>		
												<c:set var="count" value="0"></c:set>
													<tr ng-repeat="obj in panchayatBhawanActivity | orderBy : 'activity.activityId'">
													
														<td>{{obj.activity.activityName}}
														<div data-ng-if="obj.activity.activityId == 1">
														( {{selGPs1}}/{{totGPS1}})
														</div>
														<div data-ng-if="obj.activity.activityId == 2">
														( {{selGPs2}}/{{totGPS2}})
														</div>
														<div data-ng-if="obj.activity.activityId == 3">
														( {{selGPs3}}/{{totGPS3}})
														</div>
														
															
														</td>
														<td>
															
															<select class="form-control col-sm-1"  data-ng-model="districtModel" ng-options="item.districtCode as item.districtNameEnglish for item in districtCodes"	>
															    <option  value="">Select District</option>
															</select>
															
															<button class="btn bg-green waves-effect"   type="button" ng-click="showGaramPanchayatModal(districtModel,obj.activity.activityId)" >Select Panchayat</button>
														</td>
														
														<c:set var="count" value="${count +1}" />						
													</tr>
											
													
												</tbody>
											</table>
										</div>
									   	<div class="form-group text-right">
									   		<c:choose>
									   			<c:when test="!isQPRDataExist">
									   				 <button ng-click="savePanchayatBhawanData()" ng-disabled="isbtnDisabled" ng-show="isSaveVisible && !freezestatus" type="button" class="btn bg-green waves-effect" ><spring:message code="Label.SAVE" htmlEscape="true"/></button> 
									   				 <button ng-click="freezeConfirmation(true)" ng-disabled="isbtnDisabled" ng-show="!freezestatus" type="button" class="btn bg-green waves-effect" ><spring:message code="Label.FREEZE" htmlEscape="true"/></button> 
										   			 <button ng-click="freezePanchayatBhawanDataGP(false)" ng-disabled="isbtnDisabled" ng-show="freezestatus" type="button" class="btn bg-green waves-effect" ><spring:message code="Label.UNFREEZE" htmlEscape="true"/></button>
										
									   			</c:when>
									   			<c:otherwise>
									   					<div align="center" class="Alert">
															<i class="fa fa-meh-o fa-lg" aria-hidden="true"></i><span>
															Annual Progress Details/Quarter wise Progress Details fill , So can't Change in finalize</span><br />
														</div>
									   			</c:otherwise>
									   		
									   		</c:choose>
									   		
											<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect">
												<spring:message code="Label.CLOSE" htmlEscape="true" />
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

</html>