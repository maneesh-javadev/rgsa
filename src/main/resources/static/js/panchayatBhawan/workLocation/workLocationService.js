/**
 * 
 */
workLocation.service('workLocationService', [ '$http', function($http) {
	
	this.getPanchayatBhawanActivity = function() {
		return $http.get("getPanchayatBhawanActivityCEC.html?<csrf:token uri=getPanchayatBhawanActivityCEC.htm/>");
	};
	
	
	
	this.getAllGramPanchayat = function(districtCode) {
		return $http.post("gramPanchayatList.html?<csrf:token uri=gramPanchayatList.htm/>",districtCode);
	};
	
	
	this.savefFinalizeWorkLocation= function(pbProposedInfo) {
	return $http.post("savefFinalizeWorkLocation.html?<csrf:token uri=savefFinalizeWorkLocation.htm/>",pbProposedInfo);
	};
	
	this.getactivityGPs = function(activityDetailsId) {
		return $http.get("fetchFinalizeWorkLocationGPs.html?<csrf:token uri=fetchFinalizeWorkLocationGPs.htm/>&activityDetailsId="+activityDetailsId);
	};
	
	
		
}]);