/**
 * Monty
 */

var planStatus=angular.module("planStatus",[]);

planStatus.controller("planStateDetailsController",['$scope','planStateDetailsService',function($scope,planStateDetailsService){

	
	
	fetchOnLoad();
	
	function fetchOnLoad(){
		
		if(statusId!=null && statusId!=""){
			planStateDetailsService.getAllSubmittedPlanByStatus(parseInt(statusId)).then(function(response){
				$scope.planStateList=response.data;
			});
		}else{
			planStateDetailsService.getAllSubmittedPlanByState().then(function(response){
				$scope.planStateList=response.data;
			});
		}
		
		
		
	}
	
}]);