/**
 * Monty
 */
var panchayatBhawanApp=angular.module("panchayatBhawanApp",['ui.bootstrap']);

panchayatBhawanApp.controller("panchayatBhawanActivityCntrl",['$scope','panchayatBhawanActivityService','$modal',function($scope,panchayatBhawanActivityService,$modal,$compile,$https){
	
fetchOnLoad();

$scope.panchayatBhawanActivity={};
$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails=[];
$scope.activityList=[];
$scope.perposedInfo=[];
$scope.panchayatWithoutBhawan = null;
$scope.userType = null;


   
	
	function fetchOnLoad(){
		 $scope.onloadFun = function() {
		      alert(1);
		    }
		panchayatBhawanActivityService.getPanchayatBhawanActivity().then(function(response){
			$scope.activityList=response.data.PANCHAYAT_ACTIVITY;
			$scope.districtList=response.data.DISTRICT_LIST;
			$scope.panchayatWithoutBhawan = response.data.panchayatWithoutBhawan;
			$scope.userType = response.data.userType;
			if(response.data.PANCHAYAT_BHAWAN_ACTIVITY!=undefined){
				$scope.panchayatBhawanActivity=response.data.PANCHAYAT_BHAWAN_ACTIVITY;
			}
			if($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails != undefined)
				$scope.calculateTotal();
			if($scope.userType == "C"){
				$scope.panchayatBhawanActivityState=response.data.PANCHAYAT_BHAWAN_ACTIVITY_STATE;
				$scope.totalState=$scope.calTotalForCEC($scope.panchayatBhawanActivityState);
				$scope.panchayatBhawanActivityMOPR=response.data.PANCHAYAT_BHAWAN_ACTIVITY_MOPR;
				$scope.totalMOPR=$scope.calTotalForCEC($scope.panchayatBhawanActivityMOPR);
			}
			
		});
	}
	

		$scope.calTotalForCEC = function(object) {
		var total = 0;
		for (var i = 0; i < object.panchatayBhawanActivityDetails.length; i++) {
			if (object.panchatayBhawanActivityDetails[i] != undefined) {
				total = total + +object.panchatayBhawanActivityDetails[i].funds;
			}
		}
		return total;
	}
	
	$scope.calculateTotal=function(){
		var totalOfFunds = 0;
			for (var i = 0; i < $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails.length; i++) {
				if($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i] != undefined){
					totalOfFunds = totalOfFunds + $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds;
				}
			}
		$scope.totalWithoutAddRequirements = totalOfFunds;
		$scope.grandTotal = $scope.totalWithoutAddRequirements + $scope.panchayatBhawanActivity.additionalRequirement;
	}
	
	$scope.calculateAspirationalGps = function(index){
		
		if(+$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].aspirationalGps > $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].noOfGPs){
			$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].aspirationalGps='';
			toastr.error("Aspirational GPs should not be greater than no. of entered GPs. ") ;
		}
	}
	
	$scope.calculateFundsAndTotalWithoutAdditionaRequirement=function(index){
		
		if($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[0].noOfGPs >  +$scope.panchayatWithoutBhawan){
			$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[0].noOfGPs ='';
			toastr.error("Number of GPs should not be greater than " + $scope.panchayatWithoutBhawan + " i.e. panchayat without bhawan");
			$scope.calculateAspirationalGps(0);
		}
		
		if($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].unitCost > $scope.activityList[index].ceilingValue){
			$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].unitCost='';
			toastr.error("Unit Cost for " + $scope.activityList[index].activityName + " should not be greater than " + $scope.activityList[index].ceilingValue);
		}
		
		
		
		/*if($scope.pesaPlan.pesaPlanDetails[index].noOfUnits == 0){
			$scope.pesaPlan.pesaPlanDetails[index].noOfUnits ='';
			return false;
		}*/
		
		/*if($scope.pesaPlan.pesaPlanDetails[index].noOfMonths == 0){
			$scope.pesaPlan.pesaPlanDetails[index].noOfMonths ='';
			return false;
		}*/
		
		$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].funds = $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].unitCost * $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].noOfGPs;
		var totalOfFunds = 0;
		for (var i = 0; i < $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails.length; i++) {
			if($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i]!=undefined){
				if($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds != undefined && !isNaN($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds) ){
					totalOfFunds = $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds + totalOfFunds;
				}
			}
		}
		$scope.totalWithoutAddRequirements = totalOfFunds;
		$scope.calculateGrandTotal();
	}
	
	
     $scope.calculateGrandTotal=function(){
		
		$scope.allowedAdditionalRequirement = (25/100)*$scope.totalWithoutAddRequirements
		if($scope.panchayatBhawanActivity.additionalRequirement == ""){
		if($scope.panchayatBhawanActivity.additionalRequirement > $scope.allowedAdditionalRequirement){
			toastr.error("Additional requirement should not be greater than " + $scope.allowedAdditionalRequirement);
			$scope.panchayatBhawanActivity.additionalRequirement = undefined;
			$scope.grandTotal = '';
			return false;
		}
		
		$scope.grandTotal = $scope.totalWithoutAddRequirements + 0;
	
		}
		else{
			if($scope.panchayatBhawanActivity.additionalRequirement > $scope.allowedAdditionalRequirement){
				toastr.error("Additional requirement should not be greater than " + $scope.allowedAdditionalRequirement);
				$scope.panchayatBhawanActivity.additionalRequirement = undefined;
				$scope.grandTotal = '';
				return false;
			}
			
			$scope.grandTotal = $scope.totalWithoutAddRequirements + parseInt($scope.panchayatBhawanActivity.additionalRequirement);
		
		}
		}
	
	$scope.saveData=function(status){
		$scope.panchayatBhawanActivity.status=status;
		panchayatBhawanActivityService.saveData($scope.panchayatBhawanActivity).then(function(response){
			if($scope.panchayatBhawanActivity.status == 'S'){
			toastr.success("Data Save Sucessfully");
			}
			else if($scope.panchayatBhawanActivity.status == 'F'){
				toastr.success("Freeze Sucessfully");
			}
			else{
				toastr.success("Unfreeze Sucessfully");
			}
			fetchOnLoad();
		});
	}
	
	$scope.claerAll=function(){
		$scope.panchayatBhawanActivity={};
		$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails=[];
		$scope.grandTotal = '';
		$scope.totalWithoutAddRequirements = '';
	}
	
	$scope.selectPanchayats=function(districtCode,activityId){
		var modalInstance = $modal.open({
			templateUrl:'resources/js/panchayatBhawan/createPanchayat.htm', 
			controller:'panchayatController',
			windowClass: 'app-modal-window',
			resolve: {	
				activityId: function () {
                    return activityId;
                },
                districtCode: function () {
		            return districtCode;
		        },
                perposedInfo: function () {
                	return $scope.perposedInfo;
                }
			}
		});
		
		 modalInstance.result.then(function (selectedItem) {
		        $scope.perposedInfo=selectedItem.panchayatBhawanGPs;
		        $scope.activityId=selectedItem.currActivityId;
		        angular.forEach($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails, function(item) {
		        	if(item.activity.activityId == parseInt($scope.activityId)){
		        		item.proposedInfo=$scope.perposedInfo;
		        		
						console.log(item);
		        	}
				});
		    }, function () {
		        $log.info('Modal dismissed at: ' + new Date());
		    });
		
	}
	
}]);