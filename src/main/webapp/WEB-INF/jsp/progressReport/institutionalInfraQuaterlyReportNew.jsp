<%@include file="../taglib/taglib.jsp"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/quarterlyProgressReport/institutionalInfraProgressReport/InstitutionalInfraProgressReportController.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/quarterlyProgressReport/institutionalInfraProgressReport/InstitutionalInfraProgressReportService.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>
<script>
	
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
</script>
<style>
.padding_left_local {
   padding-left: 85px !important;
 }

</style>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<html data-ng-app="publicModule">
	<section class="content" data-ng-controller="InstitutionalInfraProgressReportController">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2><spring:message code="Label.InstitutionalInfrastructure" htmlEscape="true" /></h2>
						</div>
						
						<form>
					
						<div class="row" >
							<div class="form-group">
							<div class="col-lg-2"></div>
								<label for="QuaterDuration" class="col-sm-3"><spring:message code="Label.QuaterDuration" htmlEscape="true" /></label>
								<div class="col-lg-4">
									
									<select  data-ng-model="qtrId" data-ng-change="fetchDetailsForInstitutionalInfraProgressReport(qtrId);" required="required">
													<option data-ng-repeat="obj in quatorDuration" value="{{obj.qtrId}}">
											{{obj.qtrDuration}}
										</option>
									</select>
									
									
								</div>
							</div>
						</div>	 
									
					   
						<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.NewBuilding" htmlEscape="true" />(SPRC)
                           </div>
                           
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                           
                           
                           <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
										
										<th>
											<div align="center">
												<strong><spring:message code="Label.District" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.InstituteStatus" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ApprovedAmount" htmlEscape="true" /></strong>
											</div>
										</th>
										<%-- <th>
											<div align="center">
												<strong><spring:message code="Label.UploadFile" htmlEscape="true" /></strong>
											</div>
										</th> --%>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ExpenditureIncurred" htmlEscape="true" /></strong>
											</div>
										</th>
										 <th>
											<div align="center">
												<strong>file</strong>
											</div>
										</th> 
									</tr>
							  </thead>
                              <tbody>
                                 <tr data-ng-repeat="details in institutionalInfraActivityPlanDetailsNBState | orderBy : 'districtName'">
                                	<td align="center">
										<strong>{{details.districtName}}</strong>
									</td>
									<td align="center">
										
									</td>
									<td align="center">
										
									</td>
									<td align="center">
										
									</td>
									<td align="center">
										
									</td>
								</tr>		
											
                              </tbody>
                              
                             
                           </table>
                           <br/>
                           <br/>
                           
                           
                        </div>
                     </div>
						
					<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.NewBuilding" htmlEscape="true" />(DPRC)
                           </div>
                           
                            <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
										<th>
											<div align="center">
												<strong><spring:message code="Label.SerialNumber" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.District" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.InstituteStatus" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ApprovedAmount" htmlEscape="true" /></strong>
											</div>
										</th>
										<%-- <th>
											<div align="center">
												<strong><spring:message code="Label.UploadFile" htmlEscape="true" /></strong>
											</div>
										</th> --%>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ExpenditureIncurred" htmlEscape="true" /></strong>
											</div>
										</th>
										 <th>
											<div align="center">
												<strong>file</strong>
											</div>
										</th> 
									</tr>
							  </thead>
                              <tbody>
                               	
                              </tbody>
                             
                              
                             
                           </table>
                        </div>
                     </div>   	
						
					<div class="records">
                        <div class="">
                           <div  class="col-lg-12 sub_head">
                              <spring:message code="Label.CarryForward" htmlEscape="true" />(SPRC)
                           </div>
                           <div class="row">
                           <div class="col-lg-12 padding_top"></div>
                           </div>
                          
					  
							<br/>
                           <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
										<th>
											<div align="center">
												<strong><spring:message code="Label.SerialNumber" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.District" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.InstituteStatus" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ApprovedAmount" htmlEscape="true" /></strong>
											</div>
										</th>
										<%-- <th>
											<div align="center">
												<strong><spring:message code="Label.UploadFile" htmlEscape="true" /></strong>
											</div>
										</th> --%>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ExpenditureIncurred" htmlEscape="true" /></strong>
											</div>
										</th>
										 <th>
											<div align="center">
												<strong>file</strong>
											</div>
										</th> 
									</tr>
										</thead>
                              <tbody>
                                
                              </tbody>
                              
                           </table>
                           
					  
							<br/>
                           
                        </div>
                     </div>
						
						
						<div class="records">
                        	<div class="">
	                           <div  class="col-lg-12 sub_head">
	                              <spring:message code="Label.CarryForward" htmlEscape="true" />(DPRC)
	                           </div>
	                           <table id="trainingActivityTblId"
                              class="table table-hover dashboard-task-infos">
                             <thead>
											<tr>
										<th>
											<div align="center">
												<strong><spring:message code="Label.SerialNumber" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.District" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.InstituteStatus" htmlEscape="true" /></strong>
											</div>
										</th>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ApprovedAmount" htmlEscape="true" /></strong>
											</div>
										</th>
										<%-- <th>
											<div align="center">
												<strong><spring:message code="Label.UploadFile" htmlEscape="true" /></strong>
											</div>
										</th> --%>
										<th>
											<div align="center">
												<strong><spring:message code="Label.ExpenditureIncurred" htmlEscape="true" /></strong>
											</div>
										</th>
										 <th>
											<div align="center">
												<strong>file</strong>
											</div>
										</th> 
									</tr>
										</thead>
                              <tbody>
                                
											
                              </tbody>
                             
                           </table>
                           </div>
                         </div>	
						
						</form>
						
						
									<div class="col-md-4  text-left"  style="margin-bottom: 5px">
								&nbsp;&nbsp;<button type="button"
									onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
									class="btn bg-orange waves-effect">
									<i class="fa fa-arrow-left" aria-hidden="true"></i>
									<spring:message code="Label.BACK" htmlEscape="true" />
								</button><br>
							</div>
									<div class="form-group text-right">
									 
								<button data-ng-show="institutionalInfraActivityPlan.isFreeze" type="button" class="btn bg-green waves-effect" disabled="disabled"><spring:message code="Label.SAVE" htmlEscape="true"/></button>
								<button data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-click="save_data('S')" type="button" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
								<button data-ng-show="institutionalInfraActivityPlan.isFreeze" type="button" data-ng-click="save_data('U')" class="btn bg-green waves-effect">
									<spring:message code="UNFREEZE" htmlEscape="true" />
								</button>
								<button data-ng-show="!institutionalInfraActivityPlan.isFreeze "    data-ng-click="save_data('F')" class="btn bg-green waves-effect">
									<spring:message code="FREEZE" htmlEscape="true" />
								</button>
							
								<button type="button" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-click="load_data()" class="btn bg-light-blue waves-effect" disabled="disabled"><spring:message code="Label.CLEAR" htmlEscape="true"/></button>
								<button type="button" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-click="load_data()" class="btn bg-light-blue waves-effect"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
								
								<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-orange waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
								<br/>
								<br/>
							</div>
								</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</html>