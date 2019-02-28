<html ng-app="panchayatBhawanApp">

<head>	
	<%@include file="../taglib/taglib.jsp"%>
	<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
	<script src="http://angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/panchayatBhawan/panchayatBhawanActivityController.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/panchayatBhawan/panchayatBhawanActivityService.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/panchayatBhawan/panchayatController.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">

<style type="text/css">
	.modal-content{
		width: 176%;
		margin-left: -20%;"
		height: 700px;
		overflow-y: scroll;
	}
</style>
<script type="text/javascript">
function calculateGrandTotal(){
	var grand_total=0;
	if(document.getElementById("additionalRequirementId").value > 0.25 *document.getElementById("fund").value){
		alert("Additional Requirement should be less than or equal to 25% of Total Fund");
		document.getElementById("additionalRequirementId").value = '';
		document.getElementById("grandTotalId").value = '';
	}else{
		document.getElementById("grandTotalId").value = +document.getElementById("additionalRequirementId").value + +document.getElementById("fund").value;
	}
} 

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

function calculate(obj)
{
	document.getElementById("funds_"+obj).value = 2000 * document.getElementById("unitCost_"+obj).value;
	/* document.getElementById("totalFund_"+obj).value = document.getElementById("fund_"+obj).value; */
	/* calculateTotal(obj) */
}

function calculateTotal(obj){
	var total=0;
	for(var i=0;i<=obj;i++){
		total += +$("#totalFund_"+i).val();
	}
	document.getElementById("total").value =total;
	calculateGrandTotal();
}

</script>

</head>
	<section class="content" ng-controller="panchayatBhawanActivityCntrl">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2><spring:message code="Label.PanchayatBhawanHeader" htmlEscape="true" /></h2>
						</div>
						<div class="body">
	
							<div class="card">
								<!-- nav bar -->
								<ul class="nav nav-tabs" role="tablist">
									<li role="presentation" class="active">
										<a href="#home_with_icon_title" data-toggle="tab">
											<i class="fa fa-info-circle view-color fa-lg" aria-hidden="true"><spring:message code="Label.PanchayatBhawanHeader" htmlEscape="true" /></i>
										</a>
					
									</li>
								</ul>
								<!-- nav bar ended -->
								<div class="tab-content">
									<div role="tabpanel" class="tab-pane fade in active" id="home_with_icon_title">
										<div class="table-responsive">
										
											<table id="table1id" class="table table-bordered">
<!-- <label class="text-success">* No. of GPs should not be greater than {{panchayatWithoutBhawan}} i.e. panchayat without bhawan.</label> 
											 -->
												<thead>
													<tr>
													<th>
															<div align="center">
																<strong><spring:message code="Label.WorkType"
																htmlEscape="true" /></strong>
															</div>
														</th>
														<th>
															<div align="center">
																<strong><spring:message code="Label.Activities"
																htmlEscape="true" /></strong>
															</div>
														</th>
														<!-- <th>
															<div align="center">
																<strong>District</strong><br>
															</div>
														</th> -->
														<th>
															<div align="center">
																<strong><spring:message code="Label.NoOfGPs"
																htmlEscape="true" /></strong><br> A
															</div>
														</th>
														<th>
															<div align="center">
																<strong><spring:message
																code="Label.AspirationalGpsSelected" htmlEscape="true" />selected</strong>
															</div>
														</th>
														
														<th>
															<div align="center">
																<strong><spring:message code="Label.UnitCost"
																htmlEscape="true" />  (in Rs) </strong><br> B
															</div>
														</th>
														<th>
															<div align="center">
																<strong><spring:message code="Label.Funds"
																htmlEscape="true" /></strong><br> C = A * B
															</div>
														</th>
														<th data-ng-if="userType == 'M' || userType == 'C'">
													<div align="center">
														<strong><spring:message code="Label.IsApproved"
																htmlEscape="true" /></strong>
													</div>
												</th>
												<th data-ng-if="userType == 'S'" style="display: none">
													<div align="center" >
														<strong><spring:message code="Label.IsApproved"
																htmlEscape="true" /></strong>
													</div>
												</th>
													</tr>
												</thead>
												<tbody>		
												<c:set var="count" value="0"></c:set>
													<tr ng-repeat="activity in activityList">
													
													   <td><select class="form-control col-sm-1"   ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].workType" data-ng-disabled="panchayatBhawanActivity.status == 'F'" data-ng-selected="selected">
													   <option value="0">select</option>
													   <option value="N"><spring:message code="Label.NewBuilding" htmlEscape="true" /></option>
													   <option value="C"><spring:message code="Label.CarryForward" htmlEscape="true" /></option>
													   
													   </select>
													   
													   </td>
														<td>{{activity.activityName}}
															<input type="hidden"  ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].activity.activityId" ng-init="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].activity.activityId=activity.activityId"/>
														</td>
													<!-- 	<td>
															<select data-ng-show="panchayatBhawanActivity.status == 'F'"  class="form-control col-sm-1" ng-model="districtCode" disabled="disabled"
															>
																<option ng-repeat="district in districtList" value={{district.districtCode}}>{{district.districtNameEnglish}}</option>
															</select>
															<select data-ng-show="panchayatBhawanActivity.status != 'F'"  class="form-control col-sm-1"  ng-model="districtCode" 
															>
															    <option  value="">Select District</option>
															
																<option ng-repeat="panchatayBhawanActivityDetails in districtList"  value={{panchatayBhawanActivityDetails.districtCode}}>{{panchatayBhawanActivityDetails.districtNameEnglish}}</option>
															</select>
															
															<button class="btn bg-green waves-effect" data-ng-show="panchayatBhawanActivity.status == 'F'"  type="button" ng-click="selectPanchayats(districtCode,activity.activityId)" disabled="disabled">Select Panchayat</button>
															<button class="btn bg-green waves-effect" data-ng-show="panchayatBhawanActivity.status != 'F'"  type="button" ng-click="selectPanchayats(districtCode,activity.activityId)" >Select Panchayat</button>
														</td> -->
														<td>
														<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status == 'F'" ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].noOfGPs"  style="text-align:right;" disabled="disabled">
														<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status != 'F'" ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].noOfGPs"  onkeypress="return isNumber(event)" data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index);calculateAspirationalGps($index)" maxlength="7" style="text-align:right;">
														</td>
														<td>
														<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status == 'F'" ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].aspirationalGps" style="text-align:right;" disabled="disabled"/>
														<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status != 'F'" onkeypress="return isNumber(event)" ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].aspirationalGps" data-ng-keyup="calculateAspirationalGps($index)" maxlength="7" style="text-align:right;"/>														
														</td>
														
														<td>
														<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status != 'F'" onkeypress="return isNumber(event)" ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].unitCost" data-ng-keyup="calculateFundsAndTotalWithoutAdditionaRequirement($index)" maxlength="7"  style="text-align:right;"/>
														<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status == 'F'" ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].unitCost" style="text-align:right;" disabled="disabled"/>
														</td>
														<td>
														<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status != 'F'" onkeypress="return isNumber(event)" ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].funds" style="text-align:right;"/>
														<input type="text" class="form-control" data-ng-show="panchayatBhawanActivity.status == 'F'" ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].funds" style="text-align:right;" disabled="disabled"/>
														
														</td>
														<td  data-ng-if="userType == 'M' || userType == 'C'" align="center">
													         <input type="checkbox" data-ng-disabled="panchayatBhawanActivity.status == 'F'"  data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].isApproved"  />
												        </td>
												        <td data-ng-if="userType == 'M'" style="display: none">
													         <input type="checkbox" data-ng-disabled="panchayatBhawanActivity.status == 'F'" class="form-control" data-ng-model="panchayatBhawanActivity.panchatayBhawanActivityDetails[$index].isApproved" class="form-control" />
												     	</td>	
														<c:set var="count" value="${count +1}" />						
													</tr>
											
													<tr>
														<th colspan="5"><spring:message code="Label.TotalCost"
														htmlEscape="true" /></th>
														<td><input type="text"  id = "totalFonds" data-ng-model="totalWithoutAddRequirements" class="form-control col-sm-1"  style="text-align:right;" data-ng-disabled = "true"/>														
													</tr>
													<tr>
														<th colspan="5"><spring:message
														code="Label.AdditionalRequirement" htmlEscape="true" /></th>
													<td>
													    <input type="text" ng-model="panchayatBhawanActivity.additionalRequirement" onkeypress="return isNumber(event)" data-ng-show="panchayatBhawanActivity.status != 'F'" data-ng-keyUp="calculateGrandTotal()" class="form-control col-sm-1" placeholder="25% of total" style="text-align:right;"/>
														<input type="text" ng-model="panchayatBhawanActivity.additionalRequirement" data-ng-show="panchayatBhawanActivity.status == 'F'" class="form-control col-sm-1" placeholder="25% of total" style="text-align:right;" disabled="disabled"/></td>
													</tr>
													<tr>
														<th colspan="5">Total Proposed Fund </th>
														<td><input type="text"  id = "totalproposedFonds" data-ng-model="grandTotal" class="form-control col-sm-1"  style="text-align:right;" data-ng-disabled = "true"/>														
													</tr>
													
												</tbody>
											</table>
										</div>
									   	<div class="form-group text-right ex1">
									   	    <button data-ng-show="panchayatBhawanActivity.status == 'F'" data-ng-click="saveData('S')" type="button" class="btn bg-green waves-effect" disabled="disabled"><spring:message code="Label.SAVE" htmlEscape="true"/></button> 
									   		<button type="button" data-ng-show="panchayatBhawanActivity.status != 'F'" ng-click="saveData('S')" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
									   		<button data-ng-show="panchayatBhawanActivity.status != 'F' " data-ng-click="saveData('F')" type="button" class="btn bg-green waves-effect"><spring:message code="Label.FREEZE" htmlEscape="true" /></button>
								       <button data-ng-show="panchayatBhawanActivity.status == 'F'" type="button" data-ng-click="saveData('UF')" class="btn bg-green waves-effect">
									      <spring:message code="Label.UNFREEZE" htmlEscape="true" />
								       </button>
			 						   		<button type="button" data-ng-show="panchayatBhawanActivity.status == 'F'"  class="btn bg-light-blue waves-effect" disabled="disabled">
									   			<spring:message code="Label.CLEAR" htmlEscape="true" />
									   		</button>
									   		<button type="button" data-ng-show="panchayatBhawanActivity.status != 'F'"  class="btn bg-light-blue waves-effect" data-ng-click="claerAll()">
									   			<spring:message code="Label.CLEAR" htmlEscape="true" />
									   		</button>
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
<style>
.ex1 {
  margin-left: -30px;
}
</style>