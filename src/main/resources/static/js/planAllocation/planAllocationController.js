var planAllocation=angular.module("publicModule",[]);
planAllocation.controller("planAllocationController",['$scope','planAllocationService',function($scope,planAllocationService ){
	
	$scope.installmentNo=0;
	$scope.fundReleasedId = null;
	$scope.showPlanAllocationBlock=false;
	$scope.showPlanAllocationtable=false;
	$scope.centralShare = 0;
	$scope.stateShare = '';
	$scope.reservedStateShare=null;
	$scope.planCode = 0;
	$scope.totalFund=0;
	$scope.totalFundRemaining=0
	$scope.planAllocationComponentList=[];
	$scope.planAllocationModel={};
	$scope.planAllocationModel.stateAllocationList=[];
	$scope.installmentOneAllocation=[];
	$scope.totalAllocatedFund=0;
	$scope.fundReleasedDetailId=0;
	$scope.disableIsfreeze=false
	$scope.freezeButtonName='FREEZE';
	$scope.saveButtonName='FREEZE';
	$scope.saveButtonValue='S';
	$scope.freezeButtonValue='F';
	
	$scope.fetchFundReleased=function(){
		planAllocationService.fetchfundReleasedInfo($scope.installmentNo).then(function(response){
			if(response.data.message == 'success'){
				$scope.planAllocationModel.stateAllocationList=[];
				$scope.installmentOneAllocation=[];
				$scope.centralShare = response.data.centralShare;
				$scope.stateShare = response.data.stateShare;
				$scope.showPlanAllocationBlock=true;
				$scope.planAllocationComponentList=response.data.planAllocationList;
			    $scope.showPlanAllocationtable=( $scope.stateShare !=null && $scope.stateShare >= '0' ) ? true : false;
				$scope.disableIsfreeze=response.data.disableIsfreeze;
				if($scope.stateShare != null){
					$scope.reservedStateShare = $scope.stateShare;
				}
				if($scope.installmentNo == 2){
					if(response.data.installment_one_exists){
						$scope.installmentOneAllocation=response.data.installment_one_data;
					}else{
						$scope.showPlanAllocationBlock=false;
						alert('Please allocate plan for installment one first.');
					}
				}
				$scope.planCode = response.data.planCode;
				$scope.planAllocationModel = response.data.model;
				if(response.data.model.stateAllocationList.length != 0 && response.data.model.stateAllocationList[0].status == 'F'){
					$scope.freezeButtonName='UNFREEZE';
					$scope.saveButtonName='UPDATE';
					$scope.freezeButtonValue='U';
					$scope.saveButtonValue='M';
				}else if(!$scope.disableIsfreeze){
					$scope.freezeButtonName='FREEZE';
					$scope.saveButtonName='UPDATE';
					$scope.freezeButtonValue='F';
					$scope.saveButtonValue='M';
				}else{
					$scope.freezeButtonName='FREEZE';
					$scope.saveButtonName='SAVE';
					$scope.freezeButtonValue='F';
					$scope.saveButtonValue='S';
				}
				
				$scope.fundReleasedDetailId = response.data.fundReleasedDetailId;
				$scope.calTotalFund();
			}else{
				$scope.showPlanAllocationBlock=false;
				toastr.error('Installment '+$scope.installmentNo + " is not released yet.");
			}
		});
	}
	
	$scope.getLetter = function (index) {
	    return String.fromCharCode(96 + index);
	}
	
	$scope.calTotalFund=function(){
		$scope.totalFund=+$scope.centralShare + +$scope.stateShare;
		$scope.showPlanAllocationtable=( $scope.stateShare !=null && $scope.stateShare >= '0' ) ? true : false;
		$scope.calGrandTotal();
		$scope.calRemainingFund();
	}
	
	 $scope.resetAllAllocations=function(){
		if($scope.reservedStateShare != null && $scope.totalAllocatedFund != 0){
			var flag=confirm('If you change the state share all allocation will reset. Do you want to change ?');
			if(flag){
				var rowCount = $('#tbodyId tr').length;
				$scope.totalAllocatedFund=0;
				for(var i = 0; i< rowCount ; i++){
					$('#fundAllocated_'+i).val('') ;
				}
			}else{
				$scope.stateShare=$scope.reservedStateShare;
			}
			$scope.calTotalFund();
		}else{
			$scope.reservedStateShare = $scope.stateShare;
		}
	}
	
	$scope.calGrandTotal=function(){
		$scope.totalAllocatedFund = 0;
		/*var rowCount = $('#tbodyId tr').length;
		$scope.totalAllocatedFund=0;
		for(var i = 0; i< rowCount ; i++){
			$scope.totalAllocatedFund += +$('#fundAllocated_'+i).val() ;
		}*/
		
			if($scope.totalAllocatedFund == 0  && $scope.planAllocationModel.stateAllocationList.length != 0){
				for(var i =0;i<$scope.planAllocationModel.stateAllocationList.length;i++){
					if($scope.planAllocationModel.stateAllocationList[i].fundsAllocated != undefined)
						$scope.totalAllocatedFund +=+$scope.planAllocationModel.stateAllocationList[i].fundsAllocated;
				}
			}
		$scope.calRemainingFund();
	}
	$scope.calRemainingFund=function(){
		$scope.totalFundRemaining  = (+$scope.centralShare + +$scope.stateShare) - +$scope.totalAllocatedFund;
	}
	
	$scope.validateWithTotalAmountAndCecAmnt=function(index,cecAmount){
		if($scope.installmentNo == 2 && $scope.installmentOneAllocation[index].fundsAllocated != undefined){
			cecAmount -= +$scope.installmentOneAllocation[index].fundsAllocated
		}
		if($('#fundAllocated_'+index).val() > $scope.totalFundRemaining || $('#fundAllocated_'+index).val() > cecAmount){
			alert('Allocating amount should be less than or equal to CEC approved amount or total amount remaining');
			$('#fundAllocated_'+index).val('');
			$scope.planAllocationModel.stateAllocationList[index].fundsAllocated=undefined;
			$scope.calGrandTotal();
		}
		
	}
	
	$scope.savePlanAllocationcDetails=function(status){
		var flag=false;
		$scope.planAllocationModel.status=status;
		$scope.planAllocationModel.planCode=$scope.planCode;
		$scope.planAllocationModel.installmentNo=$scope.installmentNo;
		//$scope.planAllocationModel.installmentNo=$scope.installmentNo;
		$scope.planAllocationModel.stateShare=$scope.stateShare;
		$scope.planAllocationModel.fundReleasedDetailId=$scope.fundReleasedDetailId;
		if($scope.totalAllocatedFund == 0){
			//flag=true;
		}
		if(!flag){
			planAllocationService.savePlanAllocation($scope.planAllocationModel,$scope.installmentNo).then(function(response){
				if(response!=null && response.status==200){
					toastr.success(response.data.responseMessage);
					$scope.fetchFundReleased();
				}else{
					toastr.error(response.data.responseMessage);
				}
			},function(error){
				toastr.error("Something is wrong");
			});
		}else{
			toastr.error("Blank from cann't be submitted.");
		}
	}
	
	/*$scope.planAllocationList=[]
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
			$scope.is_second_inallment=false;
			if ($scope.PLAN_ALLOCATION.status=='F' ){
				$scope.is_second_inallment=true;
			}
		
			
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
	
	$scope.savePlanAllocationcDetails=function(status){
		var isFreeze=false;
		$scope.planAllocationModel.status=status;
			
		if(status=="F" && $scope.totalFund!=$scope.totalAllocatedFund){
			isFreeze=true;
		}
			$scope.totalAmount
			
		if(!isFreeze){
			alert("data saved");
			planAllocationService.savePlanAllocation($scope.planAllocationModel).then(function(response){
				if(response!=null && response.status==200){
					toastr.success(response.data.responseMessage);
				}else{
					toastr.error(response.data.responseMessage);
				}
			},function(error){
				toastr.error("Something is wrong");
			});
		}else{
			toastr.error("allocate fund must be equal to release fund of installment");
		}
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
	
	
	
	
	
	
	var checkEmptyObject = function(obj) {
		if (jQuery.type(obj) === "undefined" || (obj == null || $.trim(obj).length == 0)) {
			return true;
		}
		return false;
	};*/
	
	
	
}]);

