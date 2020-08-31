/**
 * 
 */
finalizeInstInfra.service('finalizeInstInfraService', [ '$http', function($http) {
	
	this.getInstInfraActivityValidation = function() {
		return $http.get("getInstInfraActivityValidation.html?<csrf:token uri=getInstInfraActivityValidation.htm/>");
	};
	
	this.getInstInfraActivity = function() {
		return $http.get("getInstInfraActivityCEC.html?<csrf:token uri=getInstInfraActivityCEC.htm/>");
	};
	
	this.getRemovableDistList = function(object) {
		return $http.post("getRemovableDistList.html?<csrf:token uri=getRemovableDistList.htm/>",object);
	};
	
	this.saveInstInfoFinalizeWorkLocation= function(instInfo) {
		return $http.post("saveInstInfoFinalizeWorkLocation.html?<csrf:token uri=saveInstInfoFinalizeWorkLocation.htm/>",instInfo);
		};
	
}]);