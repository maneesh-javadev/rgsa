<%@include file="../taglib/taglib.jsp"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/institutionalInfraActivityPlan/institutionalInfraActivityPlanController.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/institutionalInfraActivityPlan/institutionalInfraActivityPlanService.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>
<script>
	
function calculateGrandTotal(){
	alert(document.getElementById("trainingInstituteId").value);
	if(document.getElementById("trainingInstituteId").value == 2){
		document.getElementById("totalFundId").value = +document.getElementById("fundProposedId").value;
		document.getElementById("grandTotalId").value=0;
		document.getElementById("grandTotalId").value = +document.getElementById("totalFundId").value + +document.getElementById("additionalRequirementId").value;
	}else{
		document.getElementById("totalFundId").value = +document.getElementById("fundProposedId").value;
		document.getElementById("grandTotalId").value=0;
		document.getElementById("grandTotalId").value = +document.getElementById("totalFundId").value + +document.getElementById("additionalRequirementId").value;
	}
}
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<html data-ng-app="publicModule">
	<section class="content" data-ng-controller="institutionalInfraActivityPlanController">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2><spring:message code="Label.InstitutionalInfrastructure" htmlEscape="true" /></h2>
						</div>
						<div class="body">
						<div class="row">
								<div class="form-group">
									<div class="col-lg-1"></div>
										<div class="col-lg-3">
											<label for="institute"><spring:message code="Label.SelectBuildingType" htmlEscape="true" /></label>
										</div>
										<div class="col-lg-4">
											<select class="form-control" data-ng-init="trainingInstituteTypeId='0'"  convert-to-number data-ng-model="trainingInstituteTypeId" 
												data-ng-change="fetchDistricts(trainingInstituteTypeId); fetchData(trainingInstituteTypeId);">
												<option value="0" >Select Type</option>
												<option  data-ng-repeat="trainingInstitute in trainingInstituteType" data-ng-if="trainingInstitute.trainingInstitueTypeId == 2 || trainingInstitute.trainingInstitueTypeId == 4" value="{{trainingInstitute.trainingInstitueTypeId}}">
												{{trainingInstitute.trainingInstitueTypeName}}
												</option>
											</select>
										</div>
									</div> 
								</div>
								<div class="row"  data-ng-if="trainingInstituteTypeId != 0">
									<div class="form-group">
										<div class="col-lg-1"></div>
											<div class="col-lg-3">
												<label for="District"><spring:message code="Label.District" htmlEscape="true" />:</label>
											</div>
											<div class="col-lg-4">
												<select data-ng-show="!institutionalInfraActivityPlan.isFreeze" multiple="multiple" data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[0].locationName" data-ng-change="validateDistrictSelection(trainingInstituteTypeId);" required="required">
													<option data-ng-repeat="district in districtList" value="{{district.districtCode}}">
														{{district.districtNameEnglish}}
													</option>
												</select>
												<select data-ng-show="institutionalInfraActivityPlan.isFreeze" multiple="multiple" data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[0].locationName" disabled="disabled">
													<option data-ng-repeat="district in districtList" value="{{district.districtCode}}">
														{{district.districtNameEnglish}}
													</option>
												</select>
											</div>
									</div>
								</div>
								<input type="hidden" data-ng-model="updateStatus" />
								 <div class="table-responsive" data-ng-if="trainingInstituteTypeId != undefined && trainingInstituteTypeId	 != 0">
									<table class="table table-bordered" id="supportStaff">
										<thead>
											<tr>
												<th><div align="center">
														<strong><spring:message code="Label.BuildingType" htmlEscape="true" />
														</strong>
													</div></th>
													
													<th>
														<div align="center">
															<strong><spring:message code="Label.District" htmlEscape="true" /> 
															</strong>
														</div>
													</th>
													
														<th>
														<div align="center">
															<strong><spring:message code="Label.WorkType" htmlEscape="true" /> 
															</strong>
														</div>
													</th>
											
												<th><div align="center">
														<strong><spring:message code="Label.Funds" htmlEscape="true" /> <br> A
														</strong>
													</div></th>
												<th><div align="center">
														<strong>Total Fund<br>(B = A + Funds required <br>in carry forward section)
														</strong>
													</div></th>
												<th data-ng-if="userType == 'M'"> 
													<div align="center">
														<strong><spring:message code="Label.IsApproved" htmlEscape="true" />
														</strong>
													</div>
												</th>	
													
												<th> 
													<div align="center">
														<strong><spring:message code="Label.Remarks" htmlEscape="true" />
														</strong>
													</div>
												</th>
											</tr>
										</thead>
										<tbody>
											<tr data-ng-if="flag != false" data-ng-repeat="details in institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails">
												<td align="center"><strong>{{details.trainingInstitueType.trainingInstitueTypeName}}</strong></td>
												<td align="center"><strong>{{details.districtName}}</strong></td>
												<td>
													<select class="form-control" data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[$index].workType" data-ng-disabled="institutionalInfraActivityPlan.isFreeze">
														<option value="N">New Building</option>
														<option value="C">Carry Forward</option>
													</select>
												</td>	
												<td>
												<input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[$index].fundProposed" class="form-control" id="fundProposedId" data-ng-keyup="calculationDependentField(trainingInstituteTypeId)" maxlength="8" style="text-align:right;" required="required" />
													<input type="number" restrict-input="{type: 'digitsOnly'}" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[$index].fundProposed" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<td>
													<input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="!institutionalInfraActivityPlan.isFreeze"  data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[$index].totalFund" class="form-control" id="totalFundId" data-ng-keyup="calculationDependentField(trainingInstituteTypeId)" readonly="readonly" style="text-align:right;"/>
													<input type="text" restrict-input="{type: 'digitsOnly'}" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[$index].totalFund" class="form-control" readonly="readonly" style="text-align:right;"/>
												</td>
												<!-- <td>
													<input type="checkbox" data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[0].landIndentified" class="active"/>
												</td>
												<td>
													<input type="checkbox" data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[0].anyOtherSourceOfFunding" class="active"/>
												</td>
												<td>
													<input type="checkbox" data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[0].designAndLayoutOfBuilding" class="active"/>
												</td> -->
												<td data-ng-if="userType =='M'">
													<input type="checkbox" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[$index].isApproved">
													<input type="checkbox" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[$index].isApproved" disabled="disabled">
												</td>
												<td>
													<textarea rows="2" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[$index].remarks" cols="10"></textarea>
													<textarea rows="2" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[$index].remarks" cols="10" readonly="readonly"></textarea>
												</td>
											</tr>
											<tr>
												<td colspan="1"></td>
											</tr>
											
											<tr>
												<td colspan="4"><strong><spring:message code="Label.SubTotal" htmlEscape="true" /></strong></td>
												<td>
													<input type="text" class="form-control" value="{{subTotal}}" disabled="disabled" style="text-align:right;"/>
												</td>
											</tr>
											
											<tr>
												<td colspan="4"><strong><spring:message code="Label.AdditionalRequirement" htmlEscape="true" /> (SPRC + DPRC)</strong></td>
												<td>
													<input type="text" restrict-input="{type: 'digitsOnly'}" class="form-control" data-ng-readonly="institutionalInfraActivityPlan.isFreeze" data-ng-model="institutionalInfraActivityPlan.additionalRequirement" placeholder=" 25% of Grand Total cost " id="additionalRequirementId" data-ng-keyup="validateAdditionalRequirement()" maxlength="8" style="text-align:right;"/>
													<!-- <input type="text" restrict-input="{type: 'digitsOnly'}" class="form-control" data-ng-show="institutionalInfraActivityPlan.isFreeze || trainingInstituteTypeId == 4" data-ng-model="institutionalInfraActivityPlan.additionalRequirement" placeholder=" 25% of Grand Total cost " readonly="readonly" id="additionalRequirementId" style="text-align:right;"/> -->
												</td>
											</tr>
											<tr>
												<td colspan="4"><strong><spring:message code="Label.TotalProposedFund" htmlEscape="true" /> (SPRC + DPRC)</strong></td>
												<td>
												<input type="text" data-ng-show="!institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="totalFundAdditional" id="grandTotalId" style="text-align:right;" readonly="readonly"/>
												<input type="text" data-ng-show="institutionalInfraActivityPlan.isFreeze" class="form-control" data-ng-model="totalFundAdditional" readonly="readonly" id="grandTotalId" style="text-align:right;"/>
												</td>
											</tr>
										</tbody>
									</table>
									<div class="col-md-4  text-left" data-ng-show="userType !='S'" style="margin-bottom: 5px">
								&nbsp;&nbsp;<button type="button"
									onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
									class="btn bg-orange waves-effect">
									<i class="fa fa-arrow-left" aria-hidden="true"></i>
									<spring:message code="Label.BACK" htmlEscape="true" />
								</button><br>
							</div>
									<div class="form-group text-right">
									 <c:if test="${Plan_Status eq true}"> 
								<button data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-click="saveInstitutionalInfraActivityPlanDetails(trainingInstituteTypeId,updateStatus)" type="button" class="btn bg-green waves-effect" disabled="disabled"><spring:message code="Label.SAVE" htmlEscape="true"/></button>
								<button data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-click="saveInstitutionalInfraActivityPlanDetails(trainingInstituteTypeId,updateStatus)" type="button" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
								<button data-ng-show="institutionalInfraActivityPlan.isFreeze" type="button" data-ng-click="freezUnFreezInstitutionalInfraActivityPlan('unfreez')" class="btn bg-green waves-effect">
									<spring:message code="UNFREEZE" htmlEscape="true" />
								</button>
								<button data-ng-show="!institutionalInfraActivityPlan.isFreeze "   data-ng-disabled="updateStatus == 'saving'" type="button" data-ng-click="freezUnFreezInstitutionalInfraActivityPlan('freez')" class="btn bg-green waves-effect">
									<spring:message code="FREEZE" htmlEscape="true" />
								</button>
							
								<button type="button" data-ng-show="institutionalInfraActivityPlan.isFreeze" data-ng-click="onClearField()" class="btn bg-light-blue waves-effect" disabled="disabled"><spring:message code="Label.CLEAR" htmlEscape="true"/></button>
								<button type="button" data-ng-show="!institutionalInfraActivityPlan.isFreeze" data-ng-click="onClearField()" class="btn bg-light-blue waves-effect"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
								</c:if>
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
		</div>
	</section>
</html>