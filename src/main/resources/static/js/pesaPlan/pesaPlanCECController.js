var publicModule = angular.module("publicModule", []);
publicModule.controller("pesaPlanCECController", [ '$scope', "pesaPlanService",
		function($scope, pesaPlanService) {
	
	$scope.pesaPlanForCEC={};
	$scope.pesaPlanForCEC.pesaPlanDetails=[];
	$scope.pesaPlanForCEC.additionalRequirement;
	
	$scope.totalWithoutAddRequirementsForState = 0;
	$scope.totalWithoutAddRequirementsForMOPR = 0;
	
	$scope.totalWithoutAddRequirementsForCEC = 0;

	$scope.maxLengthOfMonth = 12;
	
	

	$(document).ready(function() {
		fetchPesaPlanDetailsForStateAndMOPR();
		});
	
	
	function fetchPesaPlanDetailsForStateAndMOPR(){
		console.log("inside pesaController");
		pesaPlanService.fetchPesaPlanDetailsForStateAndMOPR().then(function(response) {
			$scope.designationArray = response.data.pesaPosts;
			$scope.userType = response.data.userType;
			

			if(response.data.pesaPlanForState != undefined ){
				$scope.setDataForState(response);
			}
			
			if(response.data.pesaPlanForMOPR != undefined ){
				$scope.setDataForMOPR(response);
			}

			if(response.data.pesaPlanForCEC != undefined ){
				$scope.setDataForCEC(response);
			}
			
			$scope.isFreezeOrUnfreeze =$scope.pesaPlanForCEC.isFreez;
			
			var designationArray = $scope.designationArray;
			$scope.designationIdToCellingValueMap = new Map();
			
			for (var i = 0; i < $scope.designationArray.length; i++) {
				var obj = {}
				obj.id = $scope.designationArray[i].pesaPostId;
				obj.value = $scope.designationArray[i].ceilingValue;
				$scope.designationIdToCellingValueMap.set(obj.id,obj.value);
			}
			
			if($scope.pesaPlanForState.pesaPlanDetails != undefined)
				$scope.calculateTotalForState();
			
			if($scope.pesaPlanForMOPR.pesaPlanDetails != undefined)
				$scope.calculateTotalForMOPR();
			
			if($scope.pesaPlanForCEC.pesaPlanDetails != undefined)
				$scope.calculateTotalForCEC();
				
		},function(error){
			alert(error);
		});
	}
	
	$scope.calculateTotalForState=function(){
		var totalOfFunds = 0;
			for (var i = 0; i < $scope.pesaPlanForState.pesaPlanDetails.length; i++) {
				if($scope.pesaPlanForState.pesaPlanDetails[i] != undefined){
					totalOfFunds = totalOfFunds + $scope.pesaPlanForState.pesaPlanDetails[i].funds;
				}
			}
		$scope.totalWithoutAddRequirementsForState = totalOfFunds;
		$scope.grandTotalForState = +$scope.totalWithoutAddRequirementsForState + +$scope.pesaPlanForState.additionalRequirement;
	}
	
	$scope.calculateTotalForMOPR=function(){
		var totalOfFunds = 0;
			for (var i = 0; i < $scope.pesaPlanForMOPR.pesaPlanDetails.length; i++) {
				if($scope.pesaPlanForMOPR.pesaPlanDetails[i] != undefined){
					totalOfFunds = totalOfFunds + $scope.pesaPlanForMOPR.pesaPlanDetails[i].funds;
				}
			}
		$scope.totalWithoutAddRequirementsForMOPR = totalOfFunds;
		$scope.grandTotalForMOPR = $scope.totalWithoutAddRequirementsForMOPR + $scope.pesaPlanForMOPR.additionalRequirement;
	}
	
	$scope.calculateTotalForCEC=function(){
		var totalOfFunds = 0;
			for (var i = 0; i < $scope.pesaPlanForCEC.pesaPlanDetails.length; i++) {
				if($scope.pesaPlanForCEC.pesaPlanDetails[i] != undefined){
					totalOfFunds = totalOfFunds + $scope.pesaPlanForCEC.pesaPlanDetails[i].funds;
				}
			}
		$scope.totalWithoutAddRequirementsForCEC = totalOfFunds;
		$scope.grandTotalForCEC = +$scope.totalWithoutAddRequirementsForCEC + +$scope.pesaPlanForCEC.additionalRequirement;
	}
	
	$scope.setDataForState=function(response){
		$scope.pesaPlanForState = response.data.pesaPlanForState;
		$scope.pesaPlanForState.pesaPlanId = $scope.pesaPlanForState.pesaPlanId;
		$scope.pesaPlanForState.isFreez = $scope.pesaPlanForState.isFreez;
		$scope.pesaPlanForState.additionalRequirement = $scope.pesaPlanForState.additionalRequirement;
		$scope.pesaPlanForState.pesaPlanDetails = response.data.pesaPlanDetailsForState;
		
		$scope.postToPesaDetailsForState = new Map();
		
		for (var i = 0; i < $scope.pesaPlanForState.pesaPlanDetails.length; i++) {
			var obj={};
			for (var j = 0; j < $scope.designationArray.length; j++) {
				if($scope.pesaPlanForState.pesaPlanDetails[i].pesaPostId == $scope.designationArray[j].pesaPostId){
					$scope.postToPesaDetailsForState.set($scope.designationArray[j].pesaPostId , $scope.pesaPlanForState.pesaPlanDetails[i]);
					continue;
				}
			}
		}
		
		$scope.pesaPlanForState.pesaPlanDetails = [];
		
		for (var i = 0; i < $scope.designationArray.length; i++) {
			var obj =[];
			if($scope.postToPesaDetailsForState.get($scope.designationArray[i].pesaPostId) == null){
				obj.noOfUnits ='';
				obj.unitCostPerMonth ='';
				obj.noOfMonths ='';
				obj.funds ='';
				obj.remarks ='';
				obj.pesaPostId = $scope.designationArray[i].pesaPostId;
				$scope.pesaPlanForState.pesaPlanDetails.push(obj);
			}else{
				$scope.pesaPlanForState.pesaPlanDetails.push($scope.postToPesaDetailsForState.get($scope.designationArray[i].pesaPostId))
			}
		}
		
	}
	
	$scope.setDataForMOPR=function(response){
		$scope.pesaPlanForMOPR = response.data.pesaPlanForMOPR;
		$scope.pesaPlanForMOPR.pesaPlanId = $scope.pesaPlanForMOPR.pesaPlanId;
		$scope.pesaPlanForMOPR.isFreez = $scope.pesaPlanForMOPR.isFreez;
		$scope.pesaPlanForMOPR.additionalRequirement = $scope.pesaPlanForMOPR.additionalRequirement;
		$scope.pesaPlanForMOPR.pesaPlanDetails = response.data.pesaPlanDetailsForMOPR;
		
		$scope.postToPesaDetailsForMOPR = new Map();
		
		for (var i = 0; i < $scope.pesaPlanForMOPR.pesaPlanDetails.length; i++) {
			var obj={};
			for (var j = 0; j < $scope.designationArray.length; j++) {
				if($scope.pesaPlanForMOPR.pesaPlanDetails[i].pesaPostId == $scope.designationArray[j].pesaPostId){
					$scope.postToPesaDetailsForMOPR.set($scope.designationArray[j].pesaPostId , $scope.pesaPlanForMOPR.pesaPlanDetails[i]);
					continue;
				}
			}
		}
		
		$scope.pesaPlanForMOPR.pesaPlanDetails = [];
		
		for (var i = 0; i < $scope.designationArray.length; i++) {
			var obj =[];
			if($scope.postToPesaDetailsForMOPR.get($scope.designationArray[i].pesaPostId) == null){
				obj.noOfUnits ='';
				obj.unitCostPerMonth ='';
				obj.noOfMonths ='';
				obj.funds ='';
				obj.remarks ='';
				obj.pesaPostId = $scope.designationArray[i].pesaPostId;
				$scope.pesaPlanForMOPR.pesaPlanDetails.push(obj);
			}else{
				$scope.pesaPlanForMOPR.pesaPlanDetails.push($scope.postToPesaDetailsForMOPR.get($scope.designationArray[i].pesaPostId))
			}
		}
		
	}
	
	$scope.setDataForCEC=function(response){
		$scope.pesaPlanForCEC = response.data.pesaPlanForCEC;
		$scope.pesaPlanForCEC.pesaPlanId = $scope.pesaPlanForCEC.pesaPlanId;
		$scope.pesaPlanForCEC.isFreez = $scope.pesaPlanForCEC.isFreez;
		$scope.pesaPlanForCEC.additionalRequirement = $scope.pesaPlanForCEC.additionalRequirement;
		$scope.pesaPlanForCEC.pesaPlanDetails = response.data.pesaPlanDetailsForCEC;
		
		$scope.postToPesaDetailsForCEC = new Map();
		
		for (var i = 0; i < $scope.pesaPlanForCEC.pesaPlanDetails.length; i++) {
			var obj={};
			for (var j = 0; j < $scope.designationArray.length; j++) {
				if($scope.pesaPlanForCEC.pesaPlanDetails[i].pesaPostId == $scope.designationArray[j].pesaPostId){
					$scope.postToPesaDetailsForCEC.set($scope.designationArray[j].pesaPostId , $scope.pesaPlanForCEC.pesaPlanDetails[i]);
					continue;
				}
			}
		}
		
		$scope.pesaPlanForCEC.pesaPlanDetails = [];
		
		for (var i = 0; i < $scope.designationArray.length; i++) {
			var obj ={};
			if($scope.postToPesaDetailsForCEC.get($scope.designationArray[i].pesaPostId) == null){
				obj.noOfUnits ='';
				obj.unitCostPerMonth ='';
				obj.noOfMonths ='';
				obj.funds ='';
				obj.remarks ='';
				obj.pesaPostId = $scope.designationArray[i].pesaPostId;
				$scope.pesaPlanForCEC.pesaPlanDetails.push(obj);
			}else{
				$scope.pesaPlanForCEC.pesaPlanDetails.push($scope.postToPesaDetailsForCEC.get($scope.designationArray[i].pesaPostId))
			}
		}
		
	}
	
	$scope.calculateFundsAndTotalWithoutAdditionaRequirement=function(index){

		if(index == 3)
			$scope.pesaPlanForCEC.pesaPlanDetails[index].noOfMonths=1;
		
		if($scope.pesaPlanForCEC.pesaPlanDetails[index].unitCostPerMonth == ''){
			/*$scope.pesaPlanForCEC.pesaPlanDetails[index].unitCostPerMonth ='';*/
			return false;
		}
		
		if(($scope.pesaPlanForCEC.pesaPlanDetails[index].noOfMonths > 12 || $scope.pesaPlanForCEC.pesaPlanDetails[index].noOfMonths < 1) && $scope.pesaPlanForCEC.pesaPlanDetails[index].noOfMonths!=null){
			toastr.error('Number of months should be greater than 0 or less than or equal to 12.');
			$scope.pesaPlanForCEC.pesaPlanDetails[index].noOfMonths='';
		}
		
		if($scope.pesaPlanForCEC.pesaPlanDetails[index].unitCostPerMonth > $scope.designationArray[index].ceilingValue){
			$scope.pesaPlanForCEC.pesaPlanDetails[index].unitCostPerMonth='';
			toastr.error("Unit Cost per month for " + $scope.designationArray[index].pesaPostName + " should not be greater than " + $scope.designationArray[index].ceilingValue);
		}
		
		if($scope.pesaPlanForCEC.pesaPlanDetails[index].noOfUnits ==''){
			/*$scope.pesaPlanForCEC.pesaPlanDetails[index].noOfUnits ='';*/
			return false;
		}
		
		/*if($scope.pesaPlanForCEC.pesaPlanDetails[index].noOfMonths == ''){
			$scope.pesaPlanForCEC.pesaPlanDetails[index].noOfMonths ='';
			return false;
		}*/
		
		if($scope.pesaPlanForState.pesaPlanDetails[index].noOfMonths==null){
			$scope.pesaPlanForState.pesaPlanDetails[index].noOfMonths=1;
		}
		calFund(index);
	}
	
	function calFund(index){
		if(index==3){
			$scope.pesaPlanForCEC.pesaPlanDetails[index].funds = $scope.pesaPlanForCEC.pesaPlanDetails[index].noOfUnits * $scope.pesaPlanForCEC.pesaPlanDetails[index].unitCostPerMonth *1;
		}
		else{
			$scope.pesaPlanForCEC.pesaPlanDetails[index].funds = $scope.pesaPlanForCEC.pesaPlanDetails[index].noOfUnits * $scope.pesaPlanForCEC.pesaPlanDetails[index].unitCostPerMonth *$scope.pesaPlanForCEC.pesaPlanDetails[index].noOfMonths;
		}
		var totalOfFunds = 0;
		for (var i = 0; i < $scope.pesaPlanForCEC.pesaPlanDetails.length; i++) {
			if($scope.pesaPlanForCEC.pesaPlanDetails[i]!=undefined){
				if($scope.pesaPlanForCEC.pesaPlanDetails[i].funds != undefined && !isNaN($scope.pesaPlanForCEC.pesaPlanDetails[i].funds) ){
					totalOfFunds = $scope.pesaPlanForCEC.pesaPlanDetails[i].funds + totalOfFunds;
				}
			}
		}
		$scope.totalWithoutAddRequirementsForCEC = totalOfFunds;
		$scope.calculateGrandTotal();
	}
	
	$scope.calculateGrandTotal=function(){
		
		$scope.allowedAdditionalRequirement = (25/100)*$scope.totalWithoutAddRequirementsForCEC;
		if($scope.pesaPlanForCEC.additionalRequirement > $scope.allowedAdditionalRequirement){
			toastr.error("Additional requirement should not be greater than " + $scope.allowedAdditionalRequirement);
			$scope.pesaPlanForCEC.additionalRequirement = undefined;
			$scope.grandTotal = '';
			/*return false;*/
		}
		

		$scope.grandTotalForCEC = +$scope.totalWithoutAddRequirementsForCEC + +$scope.pesaPlanForCEC.additionalRequirement;

	}
	
	$scope.savePesaPlan=function(){
		$scope.btn_disabled=true;
		$scope.pesaPlanForCEC.isFreez = false;
		console.log($scope.pesaPlanForCEC);
		pesaPlanService.savePesaPlanForCEC($scope.pesaPlanForCEC).then(function(response){
			toastr.success("Plan Saved Successfully");
			$scope.btn_disabled=false;
			fetchPesaPlanDetailsForStateAndMOPR();
		},function(error){
			toastr.error("Something went wrong");
			$scope.btn_disabled=false;
		});
	}
	
	$scope.freezUnFreezPesaPlan=function(freezUnfreez){
		$scope.btn_disabled=true;
		if(freezUnfreez == 'freez'){
			$scope.pesaPlanForCEC.isFreez = true;
		}else{
			$scope.pesaPlanForCEC.isFreez = false;
		}
		pesaPlanService.freezUnFreezPesaPlan($scope.pesaPlanForCEC).then(function(response){
			$scope.pesaPlanForCEC = response.data;
			fetchPesaPlanDetailsForStateAndMOPR();
			if(freezUnfreez == 'freez'){
				toastr.success("Plan Freezed Successfully");
				$scope.btn_disabled=false;
			}else{
				toastr.success("Plan UnFreezed Successfully");
				$scope.btn_disabled=false;
			}
		},function(error){
			alert(error);
		});
	}
	
}]);