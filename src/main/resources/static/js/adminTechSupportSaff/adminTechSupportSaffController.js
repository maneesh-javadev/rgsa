var publicModule = angular.module("publicModule", []);
publicModule.controller("adminTechSupportSaffController",['$scope','adminTechSupportSaffService',function($scope,adminTechSupportSaffService,$http) {
	
	
	$scope.adminTechStaffObject={};
	$scope.adminTechStaffObject.supportDetails=[];
	$scope.grandTotal=0;
	$scope.fundTotal=0;
	$scope.levels=[];
	
	fetchOnLoad();
	function fetchOnLoad(){
		adminTechSupportSaffService.getPostTypeMaster().then(function(response){
			$scope.postTypes = response.data.postType;
			$scope.levels = response.data.level;
			$scope.userType = response.data.userType;
			console.log("User type : " + $scope.userType);
			if(response.data.technicalSupport!=undefined){
				$scope.adminTechStaffObject=response.data.technicalSupport;
				$scope.adminTechStaffObject.supportDetails=response.data.details;
				$scope.fundTotal=0;
				angular.forEach($scope.adminTechStaffObject.supportDetails, function(item, key){
					$scope.fundTotal+=item.funds;
				});
				/*$scope.fundTotal = $scope.grandTotal;*/
				$scope.grandTotal=$scope.fundTotal+$scope.adminTechStaffObject.additionalRequirement;
				
			}
		});
	}
	
	$scope.validateValue = function(index){
		console.log("inside validate value");
		if($scope.adminTechStaffObject.supportDetails[index].noOfUnits == 0){
			$scope.adminTechStaffObject.supportDetails[index].noOfUnits = '';
			$scope.adminTechStaffObject.supportDetails[index].funds=0;
			toastr.error("Value should be greater then zero");
		}
		
		if($scope.adminTechStaffObject.supportDetails[index].unitCost > 50000 ||$scope.adminTechStaffObject.supportDetails[index].unitCost == 0){
			$scope.adminTechStaffObject.supportDetails[index].unitCost = '';
			$scope.adminTechStaffObject.supportDetails[index].funds=0;
			toastr.error("Value should be greater then 0 and less then  50000");
		}
		if($scope.adminTechStaffObject.supportDetails[index].noOfMonths < 1  || $scope.adminTechStaffObject.supportDetails[index].noOfMonths > 12){
			$scope.adminTechStaffObject.supportDetails[index].noOfMonths = '';
			$scope.adminTechStaffObject.supportDetails[index].funds=0;
			toastr.error("Value should be greater then zero and less then or equals 12.");
		}
	}
	
	$scope.saveData=function(status){
		$scope.adminTechStaffObject.status=status;
		adminTechSupportSaffService.saveData($scope.adminTechStaffObject).then(function(response){
			fetchOnLoad();
			if($scope.adminTechStaffObject.status == 'F'){
				toastr.success("Freeze Sucessfully");
			}else if($scope.adminTechStaffObject.status == 'U'){
				toastr.success("Unfreeze Sucessfully");
			}else{
				toastr.success("Data Save Sucessfully");
			}
			
		});
	}
	
	$scope.validateAdditionalRequirement = function(){
		var additionalThrashhold = ($scope.fundTotal*25)/100;
		if(parseInt($scope.adminTechStaffObject.additionalRequirement) > additionalThrashhold){
			$scope.adminTechStaffObject.additionalRequirement = 0;
			toastr.error("Value should not be greater than 25% of total funds!");
			$scope.grandTotal=0;
		}
		$scope.calculateGrandTotal();
	}
	
	$scope.calculateFunds=function(index){
		$scope.validateValue(index);
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
		for (var i = 0; i < $scope.adminTechStaffObject.supportDetails.length; i++) {
			
			if($scope.adminTechStaffObject.supportDetails[i].funds!=undefined)
				{
				$scope.fundTotal= parseInt($scope.fundTotal)+ parseInt($scope.adminTechStaffObject.supportDetails[i].funds);
				}
			}
		if($scope.adminTechStaffObject.additionalRequirement!=undefined){
			$scope.grandTotal=  parseInt($scope.fundTotal) + parseInt($scope.adminTechStaffObject.additionalRequirement);
			
		}
	}
	
	
	
	/*$scope.claerAll = function(){
		$scope.adminTechStaffObject.additionalRequirement='';
		$scope.grandTotal='';
		$scope.fundTotal='';
		var index=$scope.adminTechStaffObject.supportDetails.length;
		for(var i=0;i < index;i++){
			$scope.adminTechStaffObject.supportDetails[i].postLevel.postLevelId='';
			$scope.adminTechStaffObject.supportDetails[i].unitCost='';
			$scope.adminTechStaffObject.supportDetails[i].noOfUnits='';
			$scope.adminTechStaffObject.supportDetails[i].noOfMonths='';
			$scope.adminTechStaffObject.supportDetails[i].funds='';
		}
		$scope.adminTechStaffObject={};
		$scope.adminTechStaffObject.supportDetails=[];
	
	}*/
	$scope.claerAll = function(){
		$scope.grandTotal=0;
		$scope.fundTotal=0;
		$scope.adminTechStaffObject.additionalRequirement='';
		for (var i = 0; i < $scope.postTypes.length; i++) {
			if($scope.adminTechStaffObject.supportDetails[i] != undefined){
				$scope.adminTechStaffObject.supportDetails[i].postLevel='';
				$scope.adminTechStaffObject.supportDetails[i].unitCost='';
				$scope.adminTechStaffObject.supportDetails[i].noOfUnits='';
				$scope.adminTechStaffObject.supportDetails[i].noOfMonths='';
				$scope.adminTechStaffObject.supportDetails[i].funds='';
				
				
			}
		}
	}
	
}]);


