/**
 * Monty
 */
var publicModule=angular.module("publicModule",[]);

publicModule.controller("trainingInstitutionCFController",['$scope','trgInstitutionCFService',function($scope,trgInstitutionCFService,$https){
	
	$scope.save=true;
	$scope.freeze=false;
	$scope.unFreeze=false;
	$scope.trainingInstitutionCFObject={};
	$scope.trainingInstitutionCFObject.cfDetails=[];
	
	fetchOnLoad();
	function fetchOnLoad(){
		trgInstitutionCFService.getTrainingInstitutionLevel().then(function(response){
			$scope.trainingInstitutionLevel=response.data.TRAINING_ACTIVITY_TYPE;
			if(response.data.TRAINING_INSTITUTION_CF_DETAILS!=undefined){
				$scope.trainingInstitutionCFObject=response.data.TRAINING_INSTITUTION_CF_DETAILS;
				if($scope.trainingInstitutionCFObject.status == 'F'){
					$scope.save=false;
					$scope.freeze=false;
					$scope.unFreeze=true;
				}
				else{
					$scope.save=true;
					$scope.freeze=true;
					$scope.unFreeze=false;
				}
				
			}
		});
	}
	
	
	$scope.saveData=function(status){
		$scope.trainingInstitutionCFObject.status=status;
		trgInstitutionCFService.saveData($scope.trainingInstitutionCFObject).then(function(response){
			toastr.success("Data Save Sucessfully")
			if(response.data.TRAINING_INSTITUTION_CF_DETAILS!=undefined){
				$scope.trainingInstitutionCFObject=response.data.TRAINING_INSTITUTION_CF_DETAILS;
				if($scope.trainingInstitutionCFObject.status == 'F'){
					$scope.save=false;
					$scope.freeze=false;
					$scope.unFreeze=true;
				}
				else{
					$scope.save=true;
					$scope.freeze=true;
					$scope.unFreeze=false;
				}
				
			}
		});
	}
	
}]);