<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html data-ng-app="publicModule">
<head>
<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/planAllocation/planAllocationController.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/planAllocation/planAllocationService.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
.form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control
	{
	background-color: #eee !important;
	opacity: 1;
}
</style>

<script>

function isNumberKey(evt, obj) {

    var charCode = (evt.which) ? evt.which : event.keyCode
    var value = obj.value;
    var dotcontains = value.indexOf(".") != -1;
    if (dotcontains)
        if (charCode == 46) return false;
    if (charCode == 46) return true;
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

var relAmount=parseInt('${PLAN_ALLOCATION.totalAmount}');
var isPlanAllocationNotExist=('${isPlanAllocationNotExist}');
/* var count=0;
var countFlag=false;

function isNumber(evt) {
    e = (evt) ? evt : window.event;
    if (e.which != 8 && e.which != 0 &&   e.which !=46  && (e.which < 48 || e.which > 57)  ) {
	       //display error message
	    	$("#errmsg").html("Digits Only").show().fadeOut("slow");
	              return false;
	   }
	    if($(this).val().length==0 && e.which ==46){
	    	alert("first Digit only number");
	    	return false;
	    }
	    if((e.which >= 48 || e.which <= 57) && $(this).val().indexOf(".")>0){
	    	 if(countFlag==true){
	  	    	count++;
	  	    }
	  	    
	  	    if(count>3){
	  	    	 alert("3 Digits Only after decimal");
	               return false;
	  	    }
	    }else{
	    	count=0;
	    }
	    
		  if(e.which ==46 ){
	    	countFlag=true;
	    }
}
 */


var $_checkEmptyObject_value = function(obj) {
	if (jQuery.type(obj) === "undefined" || (obj == null || $.trim(obj).length == 0)) {
		return 0;
	}
	return parseInt(obj);
};

validateSave=function(){
	totalAmount=0;
	$("input[type='text']").each(function () {  
		totalAmount=totalAmount+$_checkEmptyObject_value($(this).val());
       
    }) 
    return (relAmount>=totalAmount); 
}
 validate=function(){
	totalAmount=0;
	$("input[type='text']").each(function () {  
		totalAmount=totalAmount+$_checkEmptyObject_value($(this).val());
       
    }) 
    return (relAmount==totalAmount);  
}

setStatus=function(status){
	$("#status").val(status);
	if(status=="F" && !validate()){
		alert("Please allocate fund equal to release fund of installment");
	}if((status=="S" || status=="M") && !validateSave()){
		alert("Please allocate fund not greater then release fund of installment ");
	}else{
		callActionUrl();
	}
}

callActionUrl=function(){
 	$( 'form[id=planAllocationForm]' ).submit();
};
</script>

</head>
<body>


<section class="content" data-ng-controller="planAllocationController"> 
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Plan Allocation </h2>
					</div>
					<div class="body">
					<form:form method="post" action="savePlanAllocation.html" modelAttribute="PLAN_ALLOCATION" id="planAllocationForm">
					<input type="hidden" name="<csrf:token-name/>"	value="<csrf:token-value uri="savePlanAllocation.html"/>" />
					<form:hidden path="planCode" />
					<form:hidden path="installmentNo" />
					<form:hidden path="status" />
						<div class="form-group">
									<span class="errormessage" id="errorMessage"></span><br/>
						</div>
						
						<!-- <div ng-repeat="(indexX,value1) in planAllocationList" data-ng-if="value1.eType == 'C'">
    					<div ng-repeat="(indexY,value2) in planAllocationList" data-ng-if="value2.eType == 'S' &&  value2.componentsId==value1.componentsId" >
							       {{indexX}} - {{indexY}} - {{value1.eName}}- {{value2.eName}}
							    </div>
							</div>
						 -->
						<table class="table table-bordered"  ng-init="counter = 0">
							<thead>
								<tr>
									<th>
										<div >
											<strong>SI.No.</strong>
										</div>
									</th>
									<th>
										<div >
											<strong>Component</strong>
										</div>
									</th>
									<th style="text-align:right;padding-right:10px;">
										<div >
											<strong>Approved Amount</strong>
										</div>
									</th>
									<th>
										<div style="text-align:right;padding-right:10px;">
											<strong>Amount Allocation ({{totalAmount}})</strong>
										</div>
									</th>
								</tr>
							</thead>
							<tbody data-ng-repeat="(pcindex,pc) in planAllocationList | orderBy:componentsId" data-ng-if="pc.eType == 'C'"  
							 ng-init="counter = counter + 1">
							
							
							<tr >
												<td >{{pcindex+1}}</td>
												<td align="left"
														data-ng-model="PLAN_ALLOCATION.stateAllocationList[pc.noOfUnitsMOPR].componentId" 
														data-ng-init="PLAN_ALLOCATION.stateAllocationList[pc.noOfUnitsMOPR].componentId=pc.componentsId">
														<strong>	{{pc.eName}}</strong>
													
												</td>
												<td style="text-align:right;padding-right:10px;" data-ng-model="PLAN_ALLOCATION.stateAllocationList[pc.noOfUnitsMOPR].subcomponentId" 
														data-ng-init="PLAN_ALLOCATION.stateAllocationList[pc.noOfUnitsMOPR].subcomponentId=pc.subcomponentsId">
												<div  data-ng-if="pc.status=='U'">
														{{pc.amountProposedCEC}}
												</div>
												</td>
												
												<td style="text-align:right;padding-right:10px;">
													<div  data-ng-if="pc.status=='F'">
													<input type="text" class="form-control"	readonly />
													</div>
													<div data-ng-if="pc.noOfUnits<1 && pc.status=='U'">
													
												
													
													<input type="text" class="form-control"
													data-ng-change="calculateTotal(pc.noOfUnitsMOPR)" 
													data-ng-disabled="isFreezeOrUnfreeze"
													onkeypress="return isNumberKey(event,this)"
													data-ng-model="PLAN_ALLOCATION.stateAllocationList[pc.noOfUnitsMOPR].fundsAllocated"
													placeholder="{{remainAmount}}"
													maxlength="15"
												
													style="text-align: right;" />
													</div>
												
												</td>
												
							</tr>
							
							
							<tr data-ng-repeat="(pscindex,psc) in planAllocationList
							| filter: { eType: 'S' } | filter: { componentsId:pc.componentsId }:true"   >
							<!-- |  psc.eType === 'S' &&  psc.componentsId==pc.componentsId" > -->
							
												<td data-ng-model="PLAN_ALLOCATION.stateAllocationList[psc.noOfUnitsMOPR].srNo">{{(pscindex+10).toString(36)}} 
												 
												 </td>
												<td align="left"
														data-ng-model="PLAN_ALLOCATION.stateAllocationList[psc.noOfUnitsMOPR].componentId" 
														data-ng-init="PLAN_ALLOCATION.stateAllocationList[psc.noOfUnitsMOPR].componentId=psc.componentsId">
														<strong>	{{psc.eName}}</strong>
													
												</td>
												<td style="text-align:right;padding-right:10px;" data-ng-model="PLAN_ALLOCATION.stateAllocationList[psc.noOfUnitsMOPR].subcomponentId" 
														data-ng-init="PLAN_ALLOCATION.stateAllocationList[psc.noOfUnitsMOPR].subcomponentId=psc.subcomponentsId">
												<div  data-ng-if="psc.status=='U'">
												{{psc.amountProposedCEC}}
												</div>
												
												</td>
												
												<td style="text-align:right;padding-right:10px;">
													<div  data-ng-if="psc.status=='F'">
													<input type="text" class="form-control"	readonly />
													</div>
													<div  data-ng-if="psc.status=='U'">
													<input type="text" class="form-control"
													data-ng-change="calculateTotal(psc.noOfUnitsMOPR)" 
													data-ng-disabled="isFreezeOrUnfreeze"
													onkeypress="return isNumberKey(event,this)"
													data-ng-model="PLAN_ALLOCATION.stateAllocationList[psc.noOfUnitsMOPR].fundsAllocated"
													maxlength="15"
													placeholder="{{remainAmount}}"
													style="text-align: right;" />
													</div>
												
												</td>
							</tr>
							
							</tbody>
							
							<tr>
							<th></th>
							<th></th>
							<th style="text-align:right;padding-right:10px;">Total</th>
							<th style="text-align:right;padding-right:10px;">{{totalAllocatedFund}}</th>
							</tr>

						</table>
						<div class="text-right">
						
							
						 	
							
								
								
											
												<button  type="button" class="btn bg-green waves-effect" data-ng-click="savePlanAllocationcDetails(btnoneStatus)"
												data-ng-disabled="isFreezeOrUnfreeze" data-ng-show="btnoneStatus=='S'" data-legend="{{btnoneValue}}">SAVE</button>
											
											
											
											
								                  <button  type="button" id="btntwo" class="btn bg-green waves-effect" data-ng-click="savePlanAllocationcDetails(btntwoStatus)"
												  data-legend="{{btntwoValue}}">Freeze</button>
							
							
					
							<!-- <button type="button"  ng-click="claerAll()" class="btn bg-light-blue waves-effect">CLEAR</button> -->
							<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"class="btn bg-orange waves-effect">CLOSE</button>
						</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/jquery.dataTables.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/dataTables.bootstrap.min.js"></script>
<script>
$(function () {
    $('#js-basic-example').DataTable({
        responsive: true
    });
});
</script>
</body>
</html>