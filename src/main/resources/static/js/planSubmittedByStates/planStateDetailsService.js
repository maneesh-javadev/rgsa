/**
 * 
 */
planStatus.service('planStateDetailsService', [ '$http', function($http) {
	
	this.getAllSubmittedPlanByState = function() {
		return $http.get("getAllSubmittedPlanByState.html?<csrf:token uri=getAllSubmittedPlanByState.htm/>");
	};
	
	
	this.getAllSubmittedPlanByStatus = function(statusId) {
		return $http.get("getAllSubmittedPlanByStatebyStatus.html?<csrf:token uri=getAllSubmittedPlanByStatebyStatus.htm/>&statusId="+statusId);
	};
		
}]);