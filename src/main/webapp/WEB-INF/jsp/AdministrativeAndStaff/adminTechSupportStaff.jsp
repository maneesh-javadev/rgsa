<%@include file="../taglib/taglib.jsp"%>

<html data-ng-app="publicModule">
<head>

<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/adminTechSupportSaff/adminTechSupportSaffController.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/adminTechSupportSaff/adminTechSupportSaffService.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>

<script type="text/javascript"> 

$( document ).ready(function() {
	$(".validate").keypress(function (e) {
	    //if the letter is not digit then display error and don't type anything
	    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	       //display error message
	       $("#errmsg").html("Digits Only").show().fadeOut("slow");
	              return false;
	   }
	  });
});


</script>

<style type="text/css">

.alignment{
	text-align: right;
}

</style>

</head>
<section data-ng-controller="adminTechSupportSaffController" class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Administrative & Technical Support to Gram Panchayat</h2>
					</div>
					<div class="body">
						<div class="table-responsive">
						<form name="myForm">
							<table class="table table-bordered" id="mytable">
								<thead>
									<tr>
										<th>S.No.</th>
										<th>Post Type</th>
										<th>Post Name</th>
										<th>Level</th>
										<th><div align="center">No. of Block(s) <br> (A) </div> </th>
										<th><div align="center">Unit Cost  <br> (B)</div></th>
										<th><div align="center">No. of Months <br> (C)</div></th>
										<th ><div align="center">Funds(in Rs.) <br> D= (A*B*C)</div></th>
										<th data-ng-if="userType != 'S'">Is Approved</th>
										<th data-ng-if="userType != 'S'"><div align="center"><strong>Remarks</strong></div></th>
									</tr>
								</thead>
								<tbody>
										<tr data-ng-repeat="postType in postTypes" data-ng-init="outerIndex=$index">
											<td>{{$index + 1}}</td>
											<td>
												{{postType.master.postTypeName}}
											</td>
											<td>
												{{postType.postName}}
											</td>
											<td>
											 <select data-ng-disabled="adminTechStaffObject.status == 'F'" convert-to-number data-ng-model="adminTechStaffObject.supportDetails[outerIndex].postLevel.postLevelId">
												<option data-ng-repeat="level in levels" data-ng-selected="{{adminTechStaffObject.supportDetails[outerIndex].postLevel.postLevelId == level.postLevelId}}" value="{{level.postLevelId}}">{{level.postLevelName}}</option>
											</select> 
											</td>
											<td><input data-ng-disabled="adminTechStaffObject.status == 'F'" type="text" class="form-control validate alignment" restrict-input="{type: 'digitsOnly',index: $index}" 
												maxlength="6" data-ng-model="adminTechStaffObject.supportDetails[$index].noOfUnits" 
													data-ng-change="calculateFunds($index);validateValue($index)" /></td>
											<td><input data-ng-disabled="adminTechStaffObject.status == 'F'" type="text" class="form-control validate alignment" restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" data-ng-model="adminTechStaffObject.supportDetails[$index].unitCost" data-ng-change="calculateFunds($index);validateValue($index)"/></td>
											<td><input data-ng-disabled="adminTechStaffObject.status == 'F'" type="text" class="form-control validate alignment" restrict-input="{type: 'digitsOnly',index: $index}" maxlength="6" data-ng-model="adminTechStaffObject.supportDetails[$index].noOfMonths" data-ng-change="calculateFunds($index);validateValue($index)"/></td>
											<td><input data-ng-disabled="adminTechStaffObject.status == 'F'" type="text" data-ng-disabled="true" data-ng-model="adminTechStaffObject.supportDetails[$index].funds" class="form-control validate alignment" /></td>
											<td data-ng-if="userType != 'S'">
												<input type="checkbox" data-ng-model="adminTechStaffObject.supportDetails[$index].isApproved" data-ng-disabled="adminTechStaffObject.status == 'F'"/>
											</td>
											<td data-ng-if="userType != 'S'"><textarea data-ng-disabled="adminTechStaffObject.status == 'F'" rows="2" cols="10" data-ng-model="adminTechStaffObject.supportDetails[$index].remarks"></textarea></td>
										</tr>
                                     <tr>
										<td colspan="7">Total Fund</td>
										<td>
											<input type="text" class="form-control alignment" data-ng-disabled="true" data-ng-change="validateAdditionalRequirement()" 
												data-ng-model="fundTotal" placeholder="Fund" />
										</td>
									</tr>
									<tr>
										<td colspan="7">Additional Requirement</td>
										<td>
											<input type="text" class="form-control alignment" restrict-input="{type: 'digitsOnly',index: $index}" 
												data-ng-change="validateAdditionalRequirement()" data-ng-model="adminTechStaffObject.additionalRequirement" data-ng-if='adminTechStaffObject.status == "F"' placeholder="Additional Requirements" disabled="disabled" />
										<input type="text" class="form-control alignment" restrict-input="{type: 'digitsOnly',index: $index}" 
												data-ng-change="validateAdditionalRequirement()" data-ng-model="adminTechStaffObject.additionalRequirement" data-ng-if='adminTechStaffObject.status != "F"' placeholder="Additional Requirements" />
										</td>
									</tr>
									<tr>
										<th colspan="7">Total Proposed Fund</th>
										<td ><b>Rs. {{grandTotal}}</b></td>
									</tr>
								</tbody>
							</table>
							<!-- <table class="table table-bordered">
								<tbody>
									<tr>
										<td colspan="7">Fund</td>
										<td>
											<input type="text" class="form-control" data-ng-disabled="true" data-ng-change="validateAdditionalRequirement()" 
												data-ng-model="fundTotal" placeholder="Fund" />
										</td>
									</tr>
									<tr>
										<td colspan="7">Additional Requirement</td>
										<td>
											<input type="text" class="form-control" restrict-input="{type: 'digitsOnly',index: $index}" 
												data-ng-change="validateAdditionalRequirement()" data-ng-model="adminTechStaffObject.additionalRequirement" data-ng-if='adminTechStaffObject.status == "F"' placeholder="Additional Requirements" disabled="disabled" />
										<input type="text" class="form-control" restrict-input="{type: 'digitsOnly',index: $index}" 
												data-ng-change="validateAdditionalRequirement()" data-ng-model="adminTechStaffObject.additionalRequirement" data-ng-if='adminTechStaffObject.status != "F"' placeholder="Additional Requirements" />
										</td>
									</tr>
									<tr>
										<td colspan="7">Total Proposed Fund</td>
										<td><b>Rs. {{grandTotal}}</b></td>
									</tr>
								</tbody>
							</table> -->
							</form>
						</div>
						<div class="form-group text-right">
							<button data-ng-click="saveData('S')" data-ng-disabled="adminTechStaffObject.status == 'F'" type="button" class="btn bg-green waves-effect"><spring:message code="SAVE" htmlEscape="true" /></button>
							<button data-ng-click="saveData('U')" data-ng-if='adminTechStaffObject.status == "F"' type="button" class="btn bg-green waves-effect">UNFREEZE</button>
							<button data-ng-click="saveData('F')" data-ng-if='adminTechStaffObject.status == "S" || adminTechStaffObject.status == "U"' type="button" class="btn bg-green waves-effect">FREEZE</button>
							<button data-ng-click="onClear()" type="button" data-ng-disabled="adminTechStaffObject.status == 'F'" class="btn bg-light-blue waves-effect"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
							<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"class="btn bg-orange waves-effect"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
</html>
