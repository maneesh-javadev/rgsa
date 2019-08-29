/**
 * 
 */
var publicModule=angular.module("publicModule",[]);

publicModule.controller("satcomController",['$scope','satcomService',function($scope,satcomService,$http){
	
	$scope.satcomActivityObject={};
	$scope.satcomActivityObject.activityDetails=[];
	
	$scope.save=true;
	$scope.freeze=true;
	$scope.unFreeze=false;
	$scope.clear=true;
	$scope.stateCode=null;
	$scope.red={
			"color" : "red",
	};
	$scope.green={
			"color" : "green",
	};
	
	
	fetchOnLoad();
	
	function fetchOnLoad(){
		$scope.disable_save=false;
		satcomService.getActivityList().then(function(response){
			$scope.satComLevel=response.data.SATCOM_LEVEL;
			$scope.activityList=response.data.SATCOME_ACTIVITY;
			$scope.stateCode=response.data.STATE_CODE;
			$scope.userType = response.data.userType;
			
			if($scope.userType == 'C'){
				$scope.satcomActivityObjectState=response.data.satcomActivityState;
				$scope.calculateTotalForState();
				$scope.satcomActivityObjectMOPR=response.data.satcomActivityMOPR;
				$scope.calculateTotalMOPR();
			}
			
			if(response.data.SATCOME_ACTIVITY_DETAILS!=undefined){
				$scope.satcomActivityObject=response.data.SATCOME_ACTIVITY_DETAILS;
				if($scope.satcomActivityObject.status == 'F'){
					$scope.save=false;
					$scope.freeze=false;
					$scope.unFreeze=true;
					$scope.clear=false;
				}
				$scope.initialFlag=false;
			}else{
				$scope.initialFlag=true;
			}
			if($scope.satcomActivityObject.activityDetails != undefined)
				$scope.calculateTotal();
		});
	}
	
	
	$scope.saveData=function(status){
		$scope.satcomActivityObject.status=status;
		$scope.disable_save=true;
		satcomService.saveData($scope.satcomActivityObject).then(function(response){
			if(response.data.SATCOME_ACTIVITY_DETAILS!=undefined){
				$scope.satcomActivityObject=response.data.SATCOME_ACTIVITY_DETAILS;
				fetchOnLoad();
				if($scope.satcomActivityObject.status == 'F'){
					/*$scope.save=false;
					$scope.freeze=false;
					$scope.unFreeze=true;
					$scope.clear=false;*/
					toastr.success("Data Freeze Sucessfully")
				}
				else if($scope.satcomActivityObject.status == 'UF'){
					toastr.success("Data Unfreeze Sucessfully")
				}
				else{
					toastr.success("Data Save Sucessfully")
					/*$scope.save=true;
					$scope.freeze=true;
					$scope.unFreeze=false;
					$scope.clear=true;*/
				}
				
			}
		});
	}
	
	//used in CEC
	$scope.calculateTotalMOPR=function(){
		var totalOfFunds = 0;
			for (var i = 0; i < $scope.satcomActivityObjectMOPR.activityDetails.length; i++) {
				if($scope.satcomActivityObjectMOPR.activityDetails[i] != undefined){
					totalOfFunds = totalOfFunds + $scope.satcomActivityObjectMOPR.activityDetails[i].funds;
				}
			}
		$scope.totalWithoutAddRequirementsForMOPR = totalOfFunds;
		$scope.grandTotalForMOPR = $scope.totalWithoutAddRequirementsForMOPR + $scope.satcomActivityObjectMOPR.additionalRequirement;
	}
	//---------------------------------------------
	$scope.calculateTotal=function(){
		var totalOfFunds = 0;
			for (var i = 0; i < $scope.satcomActivityObject.activityDetails.length; i++) {
				if($scope.satcomActivityObject.activityDetails[i] != undefined){
					totalOfFunds = totalOfFunds + $scope.satcomActivityObject.activityDetails[i].funds;
				}
			}
		$scope.totalWithoutAddRequirements = totalOfFunds;
		$scope.grandTotal = $scope.totalWithoutAddRequirements + $scope.satcomActivityObject.additionalRequirement;
	}
	
	//used in CEC
	$scope.calculateTotalForState=function(){
		var totalOfFunds = 0;
			for (var i = 0; i < $scope.satcomActivityObjectState.activityDetails.length; i++) {
				if($scope.satcomActivityObjectState.activityDetails[i] != undefined){
					totalOfFunds = totalOfFunds + $scope.satcomActivityObjectState.activityDetails[i].funds;
				}
			}
		$scope.totalWithoutAddRequirementsForState = totalOfFunds;
		$scope.grandTotalForState = $scope.totalWithoutAddRequirementsForState + $scope.satcomActivityObjectState.additionalRequirement;
	}
	//-------------------------------------------
	
	$scope.calculateFunds=function(index){
		$scope.satcomActivityObject.activityDetails[index].funds="";
		if($scope.satcomActivityObject.activityDetails[index].noOfUnits!=null && $scope.satcomActivityObject.activityDetails[index].unitCost!=null
			&& $scope.satcomActivityObject.activityDetails[index].noOfUnits!="" && 	$scope.satcomActivityObject.activityDetails[index].unitCost!=""){
			$scope.satcomActivityObject.activityDetails[index].funds=
				$scope.satcomActivityObject.activityDetails[index].noOfUnits*
				$scope.satcomActivityObject.activityDetails[index].unitCost;
		}
	}
	
	$scope.calculateFundsAndTotalWithoutAdditionaRequirement=function(index){
		/*if($scope.pesaPlan.pesaPlanDetails[index].unitCostPerMonth == 0){
			$scope.pesaPlan.pesaPlanDetails[index].unitCostPerMonth ='';
			return false;
		}*/
		
		/*if($scope.pesaPlan.pesaPlanDetails[index].unitCostPerMonth > $scope.designationArray[index].ceilingValue){
			$scope.pesaPlan.pesaPlanDetails[index].unitCostPerMonth='';
			toastr.error("Unit Cost per month for " + $scope.designationArray[index].pesaPostName + " should not be greater than " + $scope.designationArray[index].ceilingValue);
		}*/
		
		/*if($scope.pesaPlan.pesaPlanDetails[index].noOfUnits == 0){
			$scope.pesaPlan.pesaPlanDetails[index].noOfUnits ='';
			return false;
		}*/
		
		/*if($scope.pesaPlan.pesaPlanDetails[index].noOfMonths == 0){
			$scope.pesaPlan.pesaPlanDetails[index].noOfMonths ='';
			return false;
		}*/
		
		$scope.satcomActivityObject.activityDetails[index].funds = $scope.satcomActivityObject.activityDetails[index].noOfUnits * $scope.satcomActivityObject.activityDetails[index].unitCost 
		var totalOfFunds = 0;
		for (var i = 0; i < $scope.satcomActivityObject.activityDetails.length; i++) {
			if($scope.satcomActivityObject.activityDetails[i]!=undefined){
				if($scope.satcomActivityObject.activityDetails[i].funds != undefined && !isNaN($scope.satcomActivityObject.activityDetails[i].funds) ){
					totalOfFunds = $scope.satcomActivityObject.activityDetails[i].funds + totalOfFunds;
				}
			}
		}
		$scope.totalWithoutAddRequirements = totalOfFunds;
		$scope.calculateGrandTotal();
	}
	
$scope.calculateGrandTotal=function(){
		
		$scope.allowedAdditionalRequirement = (25/100)*$scope.totalWithoutAddRequirements
		if($scope.satcomActivityObject.additionalRequirement ==""){	
		if($scope.satcomActivityObject.additionalRequirement > $scope.allowedAdditionalRequirement){
			toastr.error("Additional requirement should not be greater than " + $scope.allowedAdditionalRequirement);
			$scope.satcomActivityObject.additionalRequirement = undefined;
			$scope.grandTotal =  $scope.totalWithoutAddRequirements;
			return false;
		}
		
		$scope.grandTotal = $scope.totalWithoutAddRequirements + 0;
	
		}
		else{
			if($scope.satcomActivityObject.additionalRequirement > $scope.allowedAdditionalRequirement){
				toastr.error("Additional requirement should not be greater than " + $scope.allowedAdditionalRequirement);
				$scope.satcomActivityObject.additionalRequirement = undefined;
				$scope.grandTotal =  $scope.totalWithoutAddRequirements;
				return false;
			}
			
			$scope.grandTotal = $scope.totalWithoutAddRequirements + parseInt($scope.satcomActivityObject.additionalRequirement);
		
		}
		}
	
	$scope.claerAll=function(){
		$scope.satcomActivityObject={};
		$scope.satcomActivityObject.activityDetails=[];
		$scope.grandTotal = '';
		$scope.totalWithoutAddRequirements = '';
	}
	
}]);