/**
 * 
 */
enablement.service('enablementService', [ '$http', function($http) {
	
	this.getEEnablementMaster = function() {
		return $http.get("fetchEEnablemenEntityListCEC.html?<csrf:token uri=fetchEEnablemenEntityListCEC.htm/>");
	};
	
	this.getAllDistrict = function() {
		return $http.get("fetchDistrictsBasedOnStateCode.html?<csrf:token uri=fetchDistrictsBasedOnStateCode.htm/>");
	};
	
	this.getAllGramPanchayat = function(districtCode) {
		return $http.post("gramPanchayatList.html?<csrf:token uri=gramPanchayatList.htm/>",districtCode);
	};
	
	
	this.savefFinalizeWorkLocation= function(pbProposedInfo) {
	return $http.post("saveEnablemenGPs.html?<csrf:token uri=saveEnablemenGPs.htm/>",pbProposedInfo);
	};
	
	this.getactivityGPs = function(eEnablementDetailsId) {
		return $http.get("fetchEEnablementGPs.html?<csrf:token uri=fetchEEnablementGPs.htm/>&eEnablementDetailsId="+eEnablementDetailsId);
	};
	
	this.fetchEEnablemenCEC= function() {
		return $http.get("fetchEEnablemenCEC.html?<csrf:token uri=fetchEEnablemenCEC.html/>");
	};
	
	this.freezeUnfreezeFinalizeLocation= function(finalizeFreezeStatus) {
		return $http.post("freezeUnfreezeFinalizeWorkLocation.html?<csrf:token uri=freezeUnfreezeFinalizeWorkLocation.htm/>",finalizeFreezeStatus);
		};
		
	this.loadFreezeUnfreezeData= function(finalizeFreezeStatus) {
			return $http.post("loadFreezeUnfreezeFinalizeWorkLocation.html?<csrf:token uri=loadFreezeUnfreezeFinalizeWorkLocation.htm/>",finalizeFreezeStatus);
	};	
		
}]);