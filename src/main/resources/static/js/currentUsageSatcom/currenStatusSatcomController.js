var publicModule = angular.module("publicModule", []);
publicModule.controller("currenStatusSatcomController", [ '$scope', "currenStatusSatcomService",
		function($scope, currenStatusSatcomService) {
	
	
	$scope.satcomCurrentStatus={};
	$scope.satcomCurrentStatus.activityDetails=[];
	

	$scope.zpDisabled=true;
	$scope.gpDisabled=true;
	$scope.bpDisabled=true;
	
	
	$( document ).ready(function() {
		fetchSatcomMastersAndSatcomStatus();
	});
	
	
	function fetchSatcomMastersAndSatcomStatus(){
		
		currenStatusSatcomService.fetchSatcomMastersAndSatcomStatus().then(function(response){
			console.log(response.data);
			$scope.satcomActivity = response.data.satcomActivity;
			$scope.schemeMaster = response.data.schemeMaster;
			if(response.data.satcomCurrentStatus != undefined){
				$scope.satcomCurrentStatus = response.data.satcomCurrentStatus;
				for (var i = 0; i < $scope.satcomCurrentStatus.activityDetails.length; i++) {
					for (var j = 0; j < $scope.satcomCurrentStatus.activityDetails[i].satcomCurrentStatusFundSource.length; j++) {
						$scope.satcomCurrentStatus.activityDetails[i].scheme = $scope.satcomCurrentStatus.activityDetails[i].satcomCurrentStatusFundSource[j].scheme.schemeId;
					}
				}
			}
		},function(error){
			
		});
	}
	
	$scope.saveSatcomCurrentStatus=function(){
		console.log($scope.satcomCurrentStatus);
		currenStatusSatcomService.saveSatcomCurrentStatus($scope.satcomCurrentStatus).then(function(){
//			fetchSatcomMastersAndSatcomStatus();
			toastr.success("Data Saved Successfully");
		},function(error){
			toastr.error("Something went wrong");
		})
	}
	
	$scope.freezUnFreezCapacityBuilding=function(freezUnfreez){
		if(freezUnfreez == 'freeze'){
			$scope.satcomCurrentStatus.isFreeze = true;
		}else{
			$scope.satcomCurrentStatus.isFreeze = false;
		}
		$scope.saveSatcomCurrentStatus();
	}
	
}]);