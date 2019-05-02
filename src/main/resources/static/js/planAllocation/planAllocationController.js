

var planAllocation=angular.module("publicModule",[]);



planAllocation.controller("planAllocationController",['$scope','planAllocationService',function($scope,planAllocationService ){
	$scope.planAllocationList=[]
	$scope.lindex=0;
	$scope.pscindex = 0;
	$scope.PLAN_ALLOCATION={};
	$scope.PLAN_ALLOCATION.stateAllocationList=[];
	var totalFundVal=0;
	fetchOnLoad();
	function fetchOnLoad(){
		$scope.isFreezeOrUnfreeze=false;
		$scope.btnoneStatus='S';
		$scope.btntwoStatus='F';
		$scope.btnoneValue='SAVE';
		$scope.btntwoValue='Freeze';
		$scope.isFreezeOrUnfreeze=false;
		planAllocationService.fetchPlanAllocation().then(function(response){
			
			totalFundVal=0;
			$scope.planAllocationList=response.data.PLAN_ALLOCATION_LIST;
			$scope.PLAN_ALLOCATION=response.data.stateAllocationModal;
			//load_calculateTotal();
			if($scope.PLAN_ALLOCATION.status!=null && $scope.PLAN_ALLOCATION.status=='F'){
				$scope.btnoneStatus='R';
				$scope.btntwoStatus='U';
				$scope.btnoneValue='Update';
				$scope.btntwoValue='Unfreeze';
				$scope.isFreezeOrUnfreeze=true;
				$("#btntwo").html('Unfreeze');
			}else if($scope.PLAN_ALLOCATION.status!=null && ($scope.PLAN_ALLOCATION.status=='S') ){
				$scope.btnoneValue='Update';
			}
			
			
			
			for (var i = 0; i < $scope.PLAN_ALLOCATION.stateAllocationList.length; i++) {
				if(!checkEmptyObject($scope.PLAN_ALLOCATION.stateAllocationList[i].fundsAllocated)) 
				totalFundVal = totalFundVal + parseFloat($scope.PLAN_ALLOCATION.stateAllocationList[i].fundsAllocated);
			}
			$scope.totalAmount=$scope.PLAN_ALLOCATION.totalAmount;
			$scope.remainAmount=$scope.totalAmount-totalFundVal;
			$scope.totalAllocatedFund=$scope.totalAmount;
			
			
			if(!$scope.PLAN_ALLOCATION.sanctionOrderExist){
				$('#errorMessage').addClass('show');
				$('#errorMessage').html('Sanction Order details not freeze or Plan not Approved.');
				$scope.isFreezeOrUnfreeze=true;
			}else if(isPlanAllocationNotExist){
				$('#errorMessage').addClass('show');
				$('#errorMessage').html('Freeze plan allocation before quterly form.');
			}
			
			
		});
	}
	
	
	load_calculateTotal=function(){
		for (var i = 0; i < $scope.PLAN_ALLOCATION.stateAllocationList.length; i++) {
			if(!checkEmptyObject($scope.PLAN_ALLOCATION.stateAllocationList[i].fundsAllocated)) 
			totalFundVal = totalFundVal + parseFloat($scope.PLAN_ALLOCATION.stateAllocationList[i].fundsAllocated);
		}
		
		$scope.totalAllocatedFund=totalFundVal;
	}
	
	$scope.calculateTotal=function(index){
		totalFundVal=0;
		$scope.remainAmount=$scope.totalAmount;
		
		for (var i = 0; i < $scope.PLAN_ALLOCATION.stateAllocationList.length; i++) {
			if(!checkEmptyObject($scope.PLAN_ALLOCATION.stateAllocationList[i].fundsAllocated)) 
			totalFundVal = totalFundVal + parseFloat($scope.PLAN_ALLOCATION.stateAllocationList[i].fundsAllocated);
			}
		
		curObj=$scope.PLAN_ALLOCATION.stateAllocationList[index];
		curAmountProposedCEC=0;
		for (var i = 0; i < $scope.planAllocationList.length; i++) {
			if($scope.planAllocationList[i].componentsId==curObj.componentId && $scope.planAllocationList[i].subcomponentsId==curObj.subcomponentId ) {
				curAmountProposedCEC=$scope.planAllocationList[i].amountProposedCEC;
				}
			
		}
		
		if(curObj.fundsAllocated>curAmountProposedCEC){
			
			totalFundVal= totalFundVal - parseFloat($scope.PLAN_ALLOCATION.stateAllocationList[index].fundsAllocated);
			$scope.remainAmount=$scope.remainAmount-totalFundVal;
			$scope.totalAllocatedFund=totalFundVal;
			$scope.PLAN_ALLOCATION.stateAllocationList[index].fundsAllocated="";
			toastr.error("you are reahed maximum value of approved amount of this element");
		}
		else if(totalFundVal>$scope.totalAmount){
			
			totalFundVal= totalFundVal - parseFloat($scope.PLAN_ALLOCATION.stateAllocationList[index].fundsAllocated);
			$scope.remainAmount=$scope.remainAmount-totalFundVal;
			$scope.totalAllocatedFund=totalFundVal;
			$scope.PLAN_ALLOCATION.stateAllocationList[index].fundsAllocated="";
			toastr.error("you are reahed maximum value of sanction amount");
		}else{
			$scope.remainAmount=$scope.remainAmount-totalFundVal;
			$scope.totalAllocatedFund=totalFundVal;
		}
		
	}
	
	
	
	
	$scope.savePlanAllocationcDetails=function(status){
		var isFreeze=false;
		$scope.PLAN_ALLOCATION.status=status;
		if(status=="F" ){
			if($scope.totalAmount!=$scope.totalAllocatedFund){
				isFreeze=true;
			}
			$scope.totalAmount
		}
		if(!isFreeze){
			alert("data saved");
			planAllocationService.savePlanAllocation($scope.PLAN_ALLOCATION).then(function(response){
				if(response!=null && response.status==200){
					toastr.success(response.data.responseMessage);
					fetchOnLoad();
				}else{
					toastr.error(response.data.responseMessage);
					fetchOnLoad();
				}
			},function(error){
				toastr.error("Something is wrong");
			});
		}else{
			toastr.error("allocate fund must be equal to release fund of installment");
		}
		
	}
	
	var checkEmptyObject = function(obj) {
		if (jQuery.type(obj) === "undefined" || (obj == null || $.trim(obj).length == 0)) {
			return true;
		}
		return false;
	};
	
	
	
}]);

