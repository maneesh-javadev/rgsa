/**
 * Sourabh Rai
 */
var publicModule=angular.module("publicModule",['ui.bootstrap']);

publicModule.controller("panchyatBhawanCurrentStatusController",['$scope','panchayatBhawanCurrentStatusService','$modal',
		function($scope,panchayatBhawanCurrentStatusService,$modal){
	

$(document).ready(function() {
	fetchServicesProvided();
	});



$scope.panchayatBhawanCurrentStatus={};
$scope.panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails=[];

$scope.selectedGpsArray=[];
	
	$scope.fetchDistrictsBasedOnStateCode=function(){
		$scope.selectPanchayats();
	}
	
	
	function fetchServicesProvided(){
		panchayatBhawanCurrentStatusService.fetchServicesProvided().then(function(response){
			$scope.servicesProvided = response.data.serviceProvided;
		});
	}
	
	
	$scope.selectPanchayats=function(){
		var modalInstance = $modal.open({
			templateUrl:'resources/js/panchayatBhawanCurrentStatus/selectPanchayat.htm', 
			controller:'selectGramPanchayatController',
			windowClass: 'app-modal-window',
			resolve: {
				alreadySelectedGps: function () {
					return $scope.selectedGPs;
				}
			}
		});
		
		 modalInstance.result.then(function (selectedGPs) {
			 	$scope.selectedGPs=selectedGPs;
			 	if($scope.selectedGPs.size > 0){
			 		let keys = Array.from($scope.selectedGPs);
			 		$scope.selectedGpsArray=keys;
			 		var keysArray=[] ;
			 		angular.forEach(keys,function(value){
			 			keysArray.push(value[0]);
			 		})
			 		panchayatBhawanCurrentStatusService.fetchPanchyatBhawanCurrentStatusBasedOnLocalBodySelected(keysArray).then(function(response){
			 			if(response.panchyatBhawanCurrentStatus != undefined){
			 				for (var i = 0; i < response.panchyatBhawanCurrentStatus.length; i++) {
			 					$scope.panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[i]= response.panchyatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails[i];
							}
			 			}
			 		})
//			 		$scope.panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails.localbodyList.push($scope.selectedGpsArray);
			 	}
			 	console.log($scope.selectedGpsArray);
		 	});
		
	}
	
	$scope.savePanchayatBhawanCsDetails=function(){
		if($scope.panchayatBhawanCurrentStatus.panchayatBhawanCurrentStatusDetails.length > 0){
			panchayatBhawanCurrentStatusService.savePanchayatBhawanCsDetails($scope.panchayatBhawanCurrentStatus).then(function(response){
				toastr.success("Data Save Successfully")
			});
		}else{
			toastr.error("Please Select Details!!");
		}
	}
	
}]);