<html data-ng-app="publicModule">
<head>
<%@include file="../taglib/taglib.jsp"%>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/planAllocation/planAllocationController.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/planAllocation/planAllocationService.js"></script>


</head>
<section class="content" data-ng-controller="planAllocationController" data-ng-init="installmentNo='0';"> 
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
							<h2>Plan Allocation</h2>
					</div>
					<div class="body">
					<form:form method="post" action="savePlanAllocation.html" modelAttribute="PLAN_ALLOCATION" id="planAllocationForm">
					<input type="hidden" name="<csrf:token-name/>"	value="<csrf:token-value uri="savePlanAllocation.html"/>" />
						<div class="row" id="optionChoosingBlock">
							<div class="col-sm-3"> 
								<label for="InstallmentOne">&nbsp;&nbsp;Select Installment : </label>
							</div>
							<div class="col-sm-4">
								<select data-ng-model="installmentNo" class="form-control" data-ng-change="fetchFundReleased();">
									<option value="0">Select Installment</option>
									<option value="1">Installment One</option>
									<option value="2">Installment Two</option>
								</select>
							</div>
						</div>
						
						<div class="row" data-ng-show="showPlanAllocationBlock">
								<h4>&nbsp;&nbsp;&nbsp;&nbsp;Installment {{installmentNo}} plan allocation</h4><hr>
								<div class="row">
									<div class="form-group">
										<div class="col-sm-2"> 
											<label for="InstallmentOne">&nbsp;&nbsp;&nbsp;&nbsp;Central Share : </label>
										</div>
										<div class="col-sm-2"><strong>{{centralShare}}</strong></div>
										
										<div class="col-sm-2"> 
											<label for="InstallmentOne">&nbsp;&nbsp;State Share : </label>
										</div>
										<div class="col-sm-2"><div class="form-line"><input type="text" class="form-control Align-Right" data-ng-model="stateShare" data-ng-keyup="calTotalFund();" data-ng-blur="resetAllAllocations();" data-ng-readonly="planAllocationModel.stateAllocationList[0].status == 'F'"/> </div></div>
										<div class="col-sm-2"> 
											<label for="InstallmentOne">&nbsp;&nbsp;Total fund : </label>
										</div>
										<div class="col-sm-2" data-ng-model="totalFund"><strong>{{+centralShare + +stateShare}}</strong></div>
									</div>
								</div>
							
						<div class="table-responsive" data-ng-show="showPlanAllocationtable">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th style="text-align:center;">
											<div><strong>SI.No.</strong></div>
										</th>
										<th style="text-align:center;">
											<div><strong>Component</strong></div>
										</th>
										<th style="text-align:center;">
											<div><strong>Approved Amount by CEC</strong></div>
										</th>
										<th>
											<div style="text-align:center;"><strong>Amount Allocation ({{totalFund}} of <span data-ng-style="{'color':(totalFundRemaining > 0) ? '#00cc00' : 'red'}">{{totalFundRemaining}}</span> reamining) </strong></div>
										</th>
									</tr>
								</thead>
								<tbody id="tbodyId" data-ng-repeat="component in planAllocationComponentList | orderBy:'componentsId'" data-ng-if="component.eType == 'C'"  data-ng-init="parentIndex = $index">
								<tr data-ng-style="{'background-color':'#f7f7e0'}">
									<td style="text-align:center;"><strong>{{component.componentsId}}</strong></td>
									<td style="text-align:center;"><strong>{{component.eName}}</strong></td>	
									<td style="text-align:center;"><strong>{{component.amountProposedCEC}}</strong></td>
									<td>
										<input type="text" class="form-control Align-Right" readonly="readonly" data-ng-model="planAllocationModel.stateAllocationList[$index].fundsAllocated" value="" data-ng-show="component.status == 'F'"/>
										<div data-ng-show="component.status == 'U'">
										<input type="text" class="form-control Align-Right" data-ng-model="planAllocationModel.stateAllocationList[$index].fundsAllocated" id="fundAllocated_{{$index}}" placeholder="{{totalFundRemaining}}" data-ng-keyup="validateWithTotalAmountAndCecAmnt($index,component.amountProposedCEC)" data-ng-blur="calRemainingFund();calGrandTotal();" data-ng-readonly="planAllocationModel.stateAllocationList[0].status == 'F'"/>
										<input type="hidden" data-ng-model="planAllocationModel.stateAllocationList[$index].componentId" data-ng-init="planAllocationModel.stateAllocationList[$index].componentId = component.componentsId"/>
										<input type="hidden" data-ng-model="planAllocationModel.stateAllocationList[$index].srNo" />
										</div>
									</td>
								</tr>
								<tr data-ng-repeat="subComponent in planAllocationComponentList | orderBy:'componentsId' | filter: {componentsId:component.componentsId }:true" data-ng-if="subComponent.eType == 'S'">
									<td style="text-align:right;"><strong>{{getLetter($index)}}) </strong></td>
									<td style="text-align:center;"><strong>{{subComponent.eName}}</strong></td>	
									<td style="text-align:center;"><strong>{{subComponent.amountProposedCEC}}</strong></td>
									<td>
										<input type="text" class="form-control Align-Right" data-ng-model="planAllocationModel.stateAllocationList[parentIndex + $index].fundsAllocated" value="" readonly="readonly" data-ng-show="subComponent.status == 'F'"/>
										<div data-ng-show="subComponent.status == 'U'">
										<input type="text" class="form-control Align-Right" data-ng-model="planAllocationModel.stateAllocationList[parentIndex + $index].fundsAllocated" id="fundAllocated_{{parentIndex + $index}}" placeholder="{{totalFundRemaining}}" data-ng-keyup="validateWithTotalAmountAndCecAmnt(parentIndex + $index,subComponent.amountProposedCEC)" data-ng-blur="calRemainingFund();calGrandTotal();" data-ng-readonly="planAllocationModel.stateAllocationList[0].status == 'F'"/>
										<input type="hidden" data-ng-model="planAllocationModel.stateAllocationList[parentIndex + $index].subcomponentId" data-ng-init="planAllocationModel.stateAllocationList[parentIndex + $index].subcomponentId=subComponent.subcomponentsId"/>
										<input type="hidden" data-ng-model="planAllocationModel.stateAllocationList[parentIndex + $index].componentId" data-ng-init="planAllocationModel.stateAllocationList[parentIndex + $index].componentId=subComponent.componentsId"/>
										<input type="hidden" data-ng-model="planAllocationModel.stateAllocationList[parentIndex + $index].srNo" />
										</div>
									</td>
								</tr>
								</tbody>
								<tr>
									<th></th>
									<th colspan="2" style="text-align:center;padding-right:10px;">Total fund Allocated</th>
									<th style="text-align:right;padding-right:10px;">{{totalAllocatedFund}}</th> <!-- use calGrandTotal() here to cal remaining fund in placeholder and the total fund allocated -->
								</tr>
							</table>
							
							<div class="text-right">
						  		<button  type="button" class="btn bg-green waves-effect" data-ng-click="savePlanAllocationcDetails(saveButtonValue)" data-ng-disabled="planAllocationModel.stateAllocationList[0].status == 'F'">{{saveButtonName}}</button>
											
		                  		<button  type="button" id="btntwo" class="btn bg-green waves-effect" data-ng-click="savePlanAllocationcDetails(freezeButtonValue)" data-ng-disabled="disableIsfreeze">{{freezeButtonName}}</button>
					
						  		<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"class="btn bg-orange waves-effect">CLOSE</button>
							</div>
						</div>
						</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<style>
.Align-Right{
text-align: right;}
</style>
</html>