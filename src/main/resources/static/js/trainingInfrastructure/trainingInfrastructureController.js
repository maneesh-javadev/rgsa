var publicModule = angular.module("publicModule", ['ui.bootstrap']);
publicModule.controller("trainingInfrastructureController", [ '$scope',"trainingInfrastructureService",'$modal',
		function($scope, trainingInfrastructureService,$modal) {
	
	$scope.trainingInstitute={};
	$scope.trainingInstitute.trainingInstituteCurrentStatusDetails=[];
	
	fetchTrainingInstituteBasedOnFinYearAndStateCode();
	
	function fetchTrainingInstituteBasedOnFinYearAndStateCode(){
		trainingInfrastructureService.fetchTrainingInstituteBasedOnFinYearAndStateCode().then(function(response){
			$scope.trainingInstitute = response.data;
			
		},function(error){
			console.log(error);
		})
	}
	
	$scope.OpenModal=function(toModify){
		if(!toModify){
			$scope.modifiableObject = undefined;
		}
		var modalInstance = $modal.open({
			templateUrl:'resources/js/trainingInfrastructure/addTrainingInfrastructure.jsp', 
			controller:'addTrainingInstituteController',
			windowClass: 'app-modal-window',
			resolve: {
				modifiableObject: function () {
					return $scope.modifiableObject;
				}
			}
		});
		
		 modalInstance.result.then(function (trainingInstitute) {
			 $scope.newTrainingInstitute=trainingInstitute;
			 	trainingInfrastructureService.saveInfrastructureDetails($scope.newTrainingInstitute).then(function(data){
					 toastr.success("Data Save Sucessfully");
					 $scope.fetchDetails();
				 },function(error){
					 $scope.fetchDetails();
					 toastr.success("Data Save Sucessfully");
				 })
		 	});
	}
	
	$scope.fetchDetails=function(){
		fetchTrainingInstituteBasedOnFinYearAndStateCode();
	}
	
	$scope.modifyDetails=function(obj){
		console.log(obj);
		$scope.modifiableObject = angular.copy($scope.trainingInstitute);
		$scope.modifiableObject.trainingInstituteCurrentStatusDetails = [];
		$scope.modifiableObject.trainingInstituteCurrentStatusDetails.push(obj.details);
		$scope.OpenModal(true);
	}
	
	$scope.OpenDeleteModal=function(obj){
		var modalInstance = $modal.open({
			templateUrl:'resources/js/trainingInfrastructure/deleteTrainingInfrastructure.jsp', 
			controller:'deleteTrainingDetailsController',
			windowClass: 'app-modal-window',
			resolve: {
				objectToDelete: function () {
					return obj;
				}
			}
		});
		
		modalInstance.result.then(function (objectToDelete) {
			console.log(objectToDelete);
			trainingInfrastructureService.deleteTrainingInfrastructureDetails(parseInt(objectToDelete.details.trainingInstituteCsDetailsId)).then(function(data){
				toastr.success("Detail Deleleted Sucessfully");
				$scope.fetchDetails()
			},function(error){
				$scope.fetchDetails();
				toastr.success("Detail Deleleted Sucessfully");
			})
	 	});
		
	}
	
}]);