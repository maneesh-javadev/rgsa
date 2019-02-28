/**
 * 
 */
statewiseplanStatus.service('statewisePlanStatusService', [ '$http', function($http) {
	
	
	this.getStatewisePlanStatus = function() {
		return $http.get("getStatewisePlanStatus.html?<csrf:token uri=getStatewisePlanStatus.htm/>");
	};	
}]);