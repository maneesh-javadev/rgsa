var publicModule = angular.module("publicModule", []);
publicModule.controller("adminTechSupportSaffController",['$scope','adminTechSupportSaffService',function($scope,adminTechSupportSaffService,$http) {
	
	
	$scope.adminTechStaffObjectForCEC={};
	$scope.adminTechStaffObjectForCEC.supportDetails=[];
	$scope.grandTotalForState=0;
	$scope.fundTotalForState=0;
	$scope.grandTotalForMOPR=0;
	$scope.fundTotalForMOPR=0;
	$scope.levels=[];
	
	fetchOnLoad();
	function fetchOnLoad(){
		adminTechSupportSaffService.fetchAdminTechSupportStaffForMOPRAndState().then(function(response){
			$scope.postTypes = response.data.postType;
			$scope.levels = response.data.level;
			$scope.userType = response.data.userType;
			console.log("User type : " + $scope.userType);
			
			if(response.data.technicalSupportForState!=undefined){
				$scope.adminTechStaffObjectForState=response.data.technicalSupportForState;
				$scope.adminTechStaffObjectForState.supportDetails=response.data.detailsForState;
				
				angular.forEach($scope.adminTechStaffObjectForState.supportDetails, function(item, key){
					$scope.fundTotalForState+=item.funds;
				});
				/*$scope.fundTotal = $scope.grandTotal;*/
				$scope.grandTotalForState=$scope.fundTotalForState+parseInt($scope.adminTechStaffObjectForState.additionalRequirement);
				
			}
			
			if(response.data.technicalSupportForMOPR!=undefined){
				$scope.adminTechStaffObjectForMOPR=response.data.technicalSupportForMOPR;
				$scope.adminTechStaffObjectForMOPR.supportDetails=response.data.detailsForMOPR;
				
				angular.forEach($scope.adminTechStaffObjectForMOPR.supportDetails, function(item, key){
					$scope.fundTotalForMOPR+=item.funds;
				});
				/*$scope.fundTotal = $scope.grandTotal;*/
				$scope.grandTotalForMOPR=$scope.fundTotalForMOPR+$scope.adminTechStaffObjectForMOPR.additionalRequirement;
				
			}
			
		});
	}
	
	$scope.validateValue = function(index){
		console.log("inside validate value");
		if($scope.adminTechStaffObject.supportDetails[index].noOfUnits == 0){
			$scope.adminTechStaffObject.supportDetails[index].noOfUnits = '';
			toastr.error("Value should be greater then zero");
		}
		if($scope.adminTechStaffObject.supportDetails[index].unitCost == 0){
			$scope.adminTechStaffObject.supportDetails[index].unitCost = '';
			toastr.error("Value should be greater then zero");
		}
		if($scope.adminTechStaffObject.supportDetails[index].noOfMonths == 0){
			$scope.adminTechStaffObject.supportDetails[index].noOfMonths = '';
			toastr.error("Value should be greater then zero");
		}
	}
	
	$scope.saveData=function(status){
		$scope.adminTechStaffObject.status=status;
		adminTechSupportSaffService.saveData($scope.adminTechStaffObject).then(function(response){
			toastr.success("Data Save Sucessfully");
		});
	}
	
	$scope.validateAdditionalRequirement = function(){
		var additionalThrashhold = ($scope.fundTotal*25)/100;
		if(parseInt($scope.adminTechStaffObject.additionalRequirement) > additionalThrashhold){
			$scope.adminTechStaffObject.additionalRequirement = 0;
			toastr.error("Value should not be greater than 25% of total funds! : " + additionalThrashhold);
			$scope.grandTotal=0;
		}
		$scope.calculateGrandTotal();
	}
	
	$scope.calculateFunds=function(index){
		if($scope.adminTechStaffObject.supportDetails[index].noOfUnits!="" && $scope.adminTechStaffObject.supportDetails[index].unitCost!="" && $scope.adminTechStaffObject.supportDetails[index].noOfMonths!=""){
			$scope.adminTechStaffObject.supportDetails[index].funds=
				$scope.adminTechStaffObject.supportDetails[index].noOfUnits*
				$scope.adminTechStaffObject.supportDetails[index].unitCost*
				$scope.adminTechStaffObject.supportDetails[index].noOfMonths;
		}
		$scope.calculateGrandTotal();
		
		
	}
	
	$scope.calculateGrandTotal = function(){
		$scope.grandTotal=0;
		$scope.fundTotal=0;
		angular.forEach($scope.adminTechStaffObject.supportDetails, function(item, key){
			$scope.fundTotal+=item.funds;
		});
		//$scope.fundTotal = $scope.grandTotal;
//		$scope.grandTotal+=$scope.adminTechStaffObject.additionalRequirement;
		if($scope.adminTechStaffObject.additionalRequirement!=undefined){
			$scope.grandTotal = $scope.fundTotal + parseInt($scope.adminTechStaffObject.additionalRequirement);
		}
		
	}
	
}]);


