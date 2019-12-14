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
/* from here by Abhishek Singh dated 25-02-2019 */
table {
  position: relative;
  width: 100%; 
  /*background-color: #aaa; */
  overflow: hidden;
  border-collapse: collapse;
}


/*thead*/
thead {
  position: relative;
  display: block; /*seperates the header from the body allowing it to be positioned*/
  width: 100%; 	
  overflow: visible; 
}

thead th {
 /*  background-color: #99a; */
  min-width: 134px; 
  height: 32px;
  border: 1px solid #222;
}

thead th:nth-child(1) {/*first cell in the header*/
  position: relative;
  /* display: block;  */ /*seperates the first cell in the header from the header*/
 /*  background-color: #88b; */
}


/* tbody*/
tbody {
  position: relative;
  display: block; /*seperates the tbody from the header*/
  width: 100%;
  height: 470px;
  overflow-y: scroll;
}

tbody td {
 /*  background-color: #bbc; */
  min-width: 134px;
  border: 1px solid #222;
}

tbody tr td:nth-child(1) {  /*the first cell in each tr*/
  position: relative;
 /*  display: block; */ /*seperates the first column from the tbody*/
  height: 40px;
  /* background-color: #99a; */
}

#mytable {
	table-layout: auto;
}

table#mytable tbody tr td:first-child {
	width: 12px;
}

#mytable th, #mytable td {
	overflow: hidden;
	width: 100px;
	white-space: inherit;
	word-wrap: break-word;
}

table#mytable tbody tr td {
	white-space: inherit;
}

#mytable th {
	text-align: center;
	text-transform: none;
	font-weight: bold;
	color: #FFF;
	background-color: cornflowerblue;
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
										<th rowspan="2">S.No.</th>
										<th rowspan="2">Post Type</th>
										<th rowspan="2">Post Name</th>
										<th rowspan="2">Level</th>
										<th rowspan="2">No. of Block(s) <br/> (A)</th>
										<th rowspan="2">Unit Cost  <br/>  (B)</th>
										<th rowspan="2">No. of Months <br/> (C)</th>
										<th rowspan="2">Funds &nbsp;&nbsp;&nbsp;(in <strong><i style="font-size: 15px" class="fa">&#xf156;</i></strong>) <br/> D= (A*B*C)</th>
										<th rowspan="2" data-ng-if="userType != 'S'">Recommended</th>
										<th rowspan="2"><strong>Remarks</strong></th>
										<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
										<th colspan="2">Previous comment history</th></c:if>
									</tr>
									<tr>
											<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
												<th >
													<div align="center">
														<strong>State Previous remarks <span style="color: #396721;">&nbsp;<i class="fa fa-circle"></i></span></strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>MOPR's Feedback <span style="color: #bc6317;">&nbsp;<i class="fa fa-circle"></i></span></strong>
													</div>
												</th>
											</c:if>
										</tr>
								</thead>
								<tbody>
										<tr data-ng-repeat="postType in postTypes" data-ng-init="outerIndex=$index">
											<td>{{$index + 1}}</td>
											<td>
											<input type="hidden"  data-ng-model="adminTechStaffObject.supportDetails[outerIndex].postType.master.postTypeId" ng-init="adminTechStaffObject.supportDetails[outerIndex].postType.master.postTypeId=postType.postTypeId"/>{{postType.master.postTypeName}}
											</td>
											<td>
											<input type="hidden"  data-ng-model="adminTechStaffObject.supportDetails[outerIndex].postType.postId" ng-init="adminTechStaffObject.supportDetails[outerIndex].postType.postId=postType.postId"/>{{postType.postName}}
												
												
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
											<td><input  type="text" data-ng-disabled="true" data-ng-model="adminTechStaffObject.supportDetails[$index].funds" class="form-control validate alignment" /></td>
											<td data-ng-if="userType != 'S'">
												<input type="checkbox" data-ng-model="adminTechStaffObject.supportDetails[$index].isApproved" data-ng-disabled="adminTechStaffObject.status == 'F'"/>
											</td>
											<td><textarea data-ng-disabled="adminTechStaffObject.status == 'F'" rows="2" cols="10" data-ng-model="adminTechStaffObject.supportDetails[$index].remarks"></textarea></td>
											
											<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
											<td>
												<ol>
														<li data-ng-repeat="stateComments in preStateRemarks[outerIndex] track by $index" style="color: #396721; font-weight: bold;">
															{{stateComments}}
															</li>
												</ol>
											</td>

											<td>
												<ol>
													<li data-ng-repeat="moprComments in preMoprRemarks[outerIndex] track by $index" style="color: #bc6317; font-weight: bold;">
													{{moprComments}}</li>
												</ol>
											</td>
										</c:if>
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
												data-ng-change="validateAdditionalRequirement()" ng-min="0" data-ng-model="adminTechStaffObject.additionalRequirement" data-ng-if='adminTechStaffObject.status != "F"' placeholder="Additional Requirements" />
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
							<button data-ng-click="saveData('S')" data-ng-disabled="adminTechStaffObject.status == 'F' || btn_disabled" type="button" class="btn bg-green waves-effect"><spring:message code="SAVE" htmlEscape="true" /></button>
							<button data-ng-click="saveData('U')" data-ng-if='adminTechStaffObject.status == "F"' type="button" class="btn bg-orange waves-effect">UNFREEZE</button>
							<button data-ng-click="saveData('F')" data-ng-if='adminTechStaffObject.status == "S" || adminTechStaffObject.status == "U"' type="button" class="btn bg-orange waves-effect">FREEZE</button>
							<button data-ng-click="onClear()" type="button" data-ng-disabled="adminTechStaffObject.status == 'F'" class="btn bg-light-blue waves-effect"><spring:message code="Label.CLEAR" htmlEscape="true" /></button>
							</c:if>
							<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"class="btn bg-red waves-effect"><spring:message code="Label.CLOSE" htmlEscape="true" /></button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
</html>
<script>
$(document).ready(function() {
	  $('tbody').scroll(function(e) { //detect a scroll event on the tbody
	  	/*
	    Setting the thead left value to the negative valule of tbody.scrollLeft will make it track the movement
	    of the tbody element. Setting an elements left value to that of the tbody.scrollLeft left makes it maintain it's relative position at the left of the table.    
	    */
	    $('thead').css("left", -$("tbody").scrollLeft()); //fix the thead relative to the body scrolling
	    $('thead th:nth-child(1)').css("left", $("tbody").scrollLeft()); //fix the first cell of the header
	    $('tbody td:nth-child(1)').css("left", $("tbody").scrollLeft()); //fix the first column of tdbody
	  });
	});
</script>