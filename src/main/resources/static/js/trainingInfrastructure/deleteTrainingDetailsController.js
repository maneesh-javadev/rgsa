publicModule.controller("deleteTrainingDetailsController", function($scope, trainingInfrastructureService,objectToDelete,$modalInstance) {
	
	$scope.deleteRecord=function(){
		$modalInstance.close(objectToDelete);
	}
	
	$scope.cancel = function () {
		$modalInstance.dismiss('cancel'); 
	};
	
});