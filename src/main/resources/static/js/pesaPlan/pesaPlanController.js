var publicModule = angular.module("publicModule", []);
publicModule.controller("pesaPlanController", [ '$scope', "pesaPlanService",
		function($scope, pesaPlanService) {
	
	$scope.pesaPlan={};
	$scope.pesaPlan.pesaPlanDetails=[];
	$scope.pesaPlan.additionalRequirement;
	
	$scope.totalWithoutAddRequirements = 0;

	$scope.maxLengthOfMonth = 12;
	
	$(document).ready(function() {
		fetchDesignations();
		});
	
	function fetchDesignations(){
		console.log("inside pesaController");
		pesaPlanService.fetchDesignations().then(function(response) {
			$scope.designationArray = response.data.pesaPosts;
			$scope.userType = response.data.userType;
			/*$scope.pesaPlan.isFreez =false;*/
			if(response.data.pesaPlanResponseMap != undefined ){
				$scope.pesaPlan = response.data.pesaPlanResponseMap;
				$scope.pesaPlan.pesaPlanId = $scope.pesaPlan.pesaPlanId;
				/*$scope.pesaPlan.isFreez = $scope.pesaPlan.isFreez;*/
				$scope.pesaPlan.additionalRequirement = $scope.pesaPlan.additionalRequirement;
				$scope.pesaPlan.pesaPlanDetails = response.data.pesaPlanDetails;
				$scope.statePreComments = response.data.STATE_PRE_COMMENTS;
				$scope.moprPreComments = response.data.MOPR_PRE_COMMENTS;
				$scope.postToPesaDetails = new Map();
				
				for (var i = 0; i < $scope.pesaPlan.pesaPlanDetails.length; i++) {
					var obj={};
					for (var j = 0; j < $scope.designationArray.length; j++) {
						if($scope.pesaPlan.pesaPlanDetails[i].pesaPostId == $scope.designationArray[j].pesaPostId){
							$scope.postToPesaDetails.set($scope.designationArray[j].pesaPostId , $scope.pesaPlan.pesaPlanDetails[i]);
							continue;
						}
					}
				}
				
				$scope.pesaPlan.pesaPlanDetails = [];
				for (var i = 0; i < $scope.designationArray.length; i++) {
					var obj ={};
					if($scope.postToPesaDetails.get($scope.designationArray[i].pesaPostId) == null){
						obj.noOfUnits ='';
						obj.unitCostPerMonth ='';
						obj.noOfMonths ='';
						obj.funds ='';
						obj.remarks ='';
						obj.pesaPostId = $scope.designationArray[i].pesaPostId;
						$scope.pesaPlan.pesaPlanDetails.push(obj);
					}else{
						$scope.pesaPlan.pesaPlanDetails.push($scope.postToPesaDetails.get($scope.designationArray[i].pesaPostId))
					}
				}
				
			}
			var designationArray = $scope.designationArray;
			$scope.designationIdToCellingValueMap = new Map();
			
			for (var i = 0; i < $scope.designationArray.length; i++) {
				var obj = {}
				obj.id = $scope.designationArray[i].pesaPostId;
				obj.value = $scope.designationArray[i].ceilingValue;
				$scope.designationIdToCellingValueMap.set(obj.id,obj.value);
			}
			
			if($scope.pesaPlan.pesaPlanDetails != undefined)
				$scope.calculateTotal();
		},function(error){
			alert(error);
		});
	}
	
	$scope.calculateTotal=function(){
		var totalOfFunds = 0;
			for (var i = 0; i < $scope.pesaPlan.pesaPlanDetails.length; i++) {
				if($scope.pesaPlan.pesaPlanDetails[i] != undefined){
					totalOfFunds = totalOfFunds + $scope.pesaPlan.pesaPlanDetails[i].funds;
				}
			}
		$scope.totalWithoutAddRequirements = totalOfFunds;
		$scope.grandTotal = +$scope.totalWithoutAddRequirements + +$scope.pesaPlan.additionalRequirement;
	}
	
	$scope.calculateFundsAndTotalWithoutAdditionaRequirement=function(index){
		if(index == 3)
			$scope.pesaPlan.pesaPlanDetails[index].noOfMonths=1;
			
		if($scope.pesaPlan.pesaPlanDetails[index].unitCostPerMonth == ''){
			/*$scope.pesaPlan.pesaPlanDetails[index].unitCostPerMonth ='';*/
			return false;
		}
		
		if($scope.pesaPlan.pesaPlanDetails[index].unitCostPerMonth > $scope.designationArray[index].ceilingValue){
			$scope.pesaPlan.pesaPlanDetails[index].unitCostPerMonth='';
			toastr.error("Unit Cost per month for " + $scope.designationArray[index].pesaPostName + " should not be greater than " + $scope.designationArray[index].ceilingValue);
		}
		
		if($scope.pesaPlan.pesaPlanDetails[index].noOfUnits == ''){
			/*$scope.pesaPlan.pesaPlanDetails[index].noOfUnits ='';*/
			return false;
		}
		
		if($scope.pesaPlan.pesaPlanDetails[index].noOfMonths ==''){
			/*$scope.pesaPlan.pesaPlanDetails[index].noOfMonths ='';*/
			return false;
		}
		$scope.pesaPlan.pesaPlanDetails[index].funds = $scope.pesaPlan.pesaPlanDetails[index].noOfUnits * $scope.pesaPlan.pesaPlanDetails[index].unitCostPerMonth * $scope.pesaPlan.pesaPlanDetails[index].noOfMonths
		
		if(index == 3){
			$scope.pesaPlan.pesaPlanDetails[index].funds = $scope.pesaPlan.pesaPlanDetails[index].noOfUnits * $scope.pesaPlan.pesaPlanDetails[index].unitCostPerMonth
		}
		
		var totalOfFunds = 0;
		for (var i = 0; i < $scope.pesaPlan.pesaPlanDetails.length; i++) {
			if($scope.pesaPlan.pesaPlanDetails[i]!=undefined){
				if($scope.pesaPlan.pesaPlanDetails[i].funds != undefined && !isNaN($scope.pesaPlan.pesaPlanDetails[i].funds) ){
					totalOfFunds = $scope.pesaPlan.pesaPlanDetails[i].funds + totalOfFunds;
				}
			}
		}
		$scope.totalWithoutAddRequirements = totalOfFunds;
		$scope.calculateGrandTotal();
	}
	
	$scope.calculateTotalWithoutAddRequirements=function(){
		colsole.log("inside calculateTotalWithoutAddRequirements");
	}
	
	$scope.calculateGrandTotal=function(){
		
		$scope.allowedAdditionalRequirement = (25/100)*$scope.totalWithoutAddRequirements
		
		if($scope.pesaPlan.additionalRequirement > $scope.allowedAdditionalRequirement){
			toastr.error("Additional requirement should not be greater than " + $scope.allowedAdditionalRequirement);
			$scope.pesaPlan.additionalRequirement = undefined;
			$scope.grandTotal = '';
			return false;
		}
		
		$scope.grandTotal = +$scope.totalWithoutAddRequirements + parseInt($scope.pesaPlan.additionalRequirement);
	}
	
	$scope.savePesaPlan=function(){
		console.log("inside savePesaPlan");
		console.log($scope.pesaPlan);
		for (var i = 0; i < $scope.pesaPlan.pesaPlanDetails.length; i++) {
			if($scope.pesaPlan.pesaPlanDetails[i] != undefined){
				if($scope.pesaPlan.pesaPlanDetails[i].unitCostPerMonth > $scope.designationArray[i].ceilingValue){
					toastr.error("Unit Cost per month for " + $scope.designationArray[i].pesaPostName + " should not be greater than " + $scope.designationArray[i].ceilingValue);
					$scope.pesaPlan.pesaPlanDetails[i].unitCostPerMonth = '';
				}
			}
		}
		
		if($scope.validateFields()){
			pesaPlanService.savePesaPlan($scope.pesaPlan).then(function(response){
				fetchDesignations();
				toastr.success("Plan Saved Successfully");
			},function(error){
				toastr.error("Something went wrong");
			});
		}
	}
	
	$scope.validateFields=function(){
		var flag=false;
		for (var i = 0; i < $scope.pesaPlan.pesaPlanDetails.length; i++) {
			if($scope.pesaPlan.pesaPlanDetails[i] != undefined){
				if(!isNaN($scope.pesaPlan.pesaPlanDetails[i].funds) && $scope.pesaPlan.pesaPlanDetails[i].funds != null && $scope.pesaPlan.pesaPlanDetails[i].funds != ''){
					flag= true;
					break;
				}
				/*if($scope.pesaPlan.pesaPlanDetails[i].noOfUnits == undefined){
					toastr.error("Number of units is required");
					return false;
				}
				if($scope.pesaPlan.pesaPlanDetails[i].unitCostPerMonth === ''){
					toastr.error("Unit Cost Per Month is required");
					return false;
				}*/
			}
		}
		if(!flag)
			toastr.error("empty form can't be save or freezed.");	
		return flag;
	}
	
	$scope.onClear = function(){
		$scope.pesaPlan.additionalRequirement = 0;
		for (var i = 0; i < $scope.pesaPlan.pesaPlanDetails.length; i++) {
			if($scope.pesaPlan.pesaPlanDetails[i] != undefined){
				$scope.pesaPlan.pesaPlanDetails[i].noOfUnits='';
				$scope.pesaPlan.pesaPlanDetails[i].unitCostPerMonth='';
				$scope.pesaPlan.pesaPlanDetails[i].noOfMonths='';
				$scope.pesaPlan.pesaPlanDetails[i].funds='';
				$scope.pesaPlan.pesaPlanDetails[i].remarks = '';
				$scope.grandTotal = 0;
				$scope.totalWithoutAddRequirements = 0;
			}
		}
	}
	
	$scope.freezUnFreezPesaPlan=function(freezUnfreez){
		if($scope.validateFields()){
		if(freezUnfreez == 'freez'){
			$scope.pesaPlan.isFreez = true;
		}else{
			$scope.pesaPlan.isFreez = false;
		}
		
		pesaPlanService.freezUnFreezPesaPlan($scope.pesaPlan).then(function(response){
			$scope.pesaPlan = response.data;
			if(freezUnfreez == 'freez'){
				fetchDesignations();
				toastr.success("Plan Freezed Successfully");
			}else{
				fetchDesignations();
				toastr.success("Plan UnFreezed Successfully");
			}
		},function(error){
			alert(error);
		});
		}
	}
}]);