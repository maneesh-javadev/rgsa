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
	
	this.freezeUnfreezeFinalizeLocation= function(finalizeFreezeStatus) {
		return $http.post("freezeUnfreezeFinalizeWorkLocation.html?<csrf:token uri=freezeUnfreezeFinalizeWorkLocation.htm/>",finalizeFreezeStatus);
		};
		
	this.loadFreezeUnfreezeData= function(finalizeFreezeStatus) {
			return $http.post("loadFreezeUnfreezeFinalizeWorkLocation.html?<csrf:token uri=loadFreezeUnfreezeFinalizeWorkLocation.htm/>",finalizeFreezeStatus);
	};	
		
}]);