/**
 * By Abhishek Singh dated 12-2-19
 */
var trgModuleCEC=angular.module("trainingActivityModuleCEC",[]);

trgModuleCEC.controller("trainingActivityCEC",['$scope','trgActivityCecService',function($scope,trgActivityCecService,$https){
	$scope.userType = null;
	$scope.stateData;
	$scope.totalFund=0;
	$scope.additionalReq;
	$scope.grandTotal;
	$scope.isFreezeOrUnfreeze;
	$scope.status="";
	$scope.stateAdditionalReq;
	$scope.stateTotalFund;
	$scope.stateGrandTotal;
	fetchOnLoad();
	function fetchOnLoad(){
		trgActivityCecService.getActivityList().then(function(response){
			//For MOPR
			$scope.cbmasters = response.data.cbMasters;
			$scope.userType =  response.data.userType;
			$scope.moprData= response.data.trg_activity_mopr;
			$scope.additionalReq=$scope.moprData.additionalRequirement;
			$scope.calculateFundTotal($scope.moprData.capacityBuildingActivityDetails);
			//For State
			$scope.stateData=response.data.trg_activity_state;
			$scope.stateAdditionalReq=$scope.stateData.additionalRequirement
			//For Change Data for CEC that has to be saved
			$scope.cecData=response.data.capacityBuildingDetails;
			$scope.isFreezeOrUnfreeze=$scope.cecData.isFreeze;
			if($scope.isFreezeOrUnfreeze != null && $scope.isFreezeOrUnfreeze !=undefined){
				if($scope.isFreezeOrUnfreeze == true){
					$scope.status="U";
				}else{
					$scope.status="F";
				}
			}
			calculateOther($scope.cecData);
			console.log("cec  isfreeze ="+$scope.cecData.isFreeze);
		});
	}
	//jsp local function handling here
	$scope.calculateFundTotal=function(capacityBuildingActivityDetails){
		var totalFundVal = 0;
		for (var i = 0; i < capacityBuildingActivityDetails.length; i++) {
		if(capacityBuildingActivityDetails[i].funds != null && capacityBuildingActivityDetails[i].funds != undefined)
		totalFundVal = totalFundVal + capacityBuildingActivityDetails[i].funds;
		}
		$scope.totalFund=totalFundVal;
		//console.log("totalFundVal ="+ totalFundVal);
		$scope.calculateGrandTotal();
	}
	//jsp local function handling here
	$scope.calculateGrandTotal=function(){
		var total = 0;
		if($scope.additionalReq == undefined || $scope.additionalReq == ""){
			total = 0 + parseInt($scope.totalFund);
		}else{
			total = parseInt($scope.additionalReq) + parseInt($scope.totalFund);
		}
		$scope.grandTotal=total;
	}
	//jsp local function handling here
	$scope.calculateNewFund=function(index){
		var noOfDays=1;
		var noOfUnits=1;
		if($scope.stateData.capacityBuildingActivityDetails[index].noOfDays != null && $scope.stateData.capacityBuildingActivityDetails[index].noOfDays != undefined){
			noOfDays=$scope.stateData.capacityBuildingActivityDetails[index].noOfDays;
		}
		if($scope.stateData.capacityBuildingActivityDetails[index].noOfUnits != null && $scope.stateData.capacityBuildingActivityDetails[index].noOfUnits != undefined){
			noOfUnits=$scope.stateData.capacityBuildingActivityDetails[index].noOfUnits;
		}
		$scope.cecData.capacityBuildingActivityDetails[index].funds=$scope.cecData.capacityBuildingActivityDetails[index].unitCost*noOfDays*noOfUnits;
		//For total change in fund calculation		
		calculateOther($scope.cecData);
	}
	var calculateOther=function(object){
		//For total change in fund calculation	
		var totalFundVal = 0;
		for (var i = 0; i < object.capacityBuildingActivityDetails.length; i++) {
			if(object.capacityBuildingActivityDetails[i].funds != null && object.capacityBuildingActivityDetails[i].funds != undefined){
				totalFundVal = totalFundVal + object.capacityBuildingActivityDetails[i].funds;
			}
		}
		$scope.stateTotalFund = totalFundVal;
		$scope.stateGrandTotal = totalFundVal + $scope.stateAdditionalReq;
	}
	//saving details
	$scope.saveTrainingActivityCecDetails=function(){
		trgActivityCecService.saveCapacityBuildingCEC($scope.cecData).then(function(response){
			fetchOnLoad();
			toastr.success("Data Saved Successfully");
		},function(error){
			toastr.error("Something is wrong");
		});
	}
	$scope.freezeUnfreezeTrainingActivityCecDetails=function(e){
		//console.log();
		//var status=$(e.target).data('legend');
		var status=$scope.status;
		if(status != null && status != undefined){
			if(status == 'F'){
				//$scope.isFreezeOrUnfreeze = true;
				$scope.cecData.isFreeze=true;
				//$(e.target).data('legend','U');
				//$scope.status="U";
			}else{
				//$scope.isFreezeOrUnfreeze = false;
				$scope.cecData.isFreeze=false;
				//$(e.target).data('legend','F')
				//$scope.status="F"
			}
			//$scope.$digest();
			trgActivityCecService.saveCapacityBuildingCEC($scope.cecData).then(function(response){
				//$scope.cecData = response.data;
				if(status == 'F'){
					$(e.target).html("Unfreeze")
					fetchOnLoad();
					toastr.success("CEC data freezed successfully");
				}else{
					fetchOnLoad();
					$(e.target).html("Freeze")
					toastr.success("CEC data unFreezed successfully");
				}
			},function(error){
				alert(error);
			});
		}else{
			alert("Please set your status first");
		}	
	}
}]);
