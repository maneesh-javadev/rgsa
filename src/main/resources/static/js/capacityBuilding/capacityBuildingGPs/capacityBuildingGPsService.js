/**
 * 
 */
capacityBuildingGPs.service('capacityBuildingGPsService', [ '$http', function($http) {
	
	this.fetchCBMastersAndCapacityBuildingData=function(){
		return $http.get("fetchCBMastersAndCapacityBuildingDataCEC.html?<csrf:token uri=fetchCBMastersAndCapacityBuildingDataCEC.htm/>");
	}
	
	
	this.getAllDistrict = function() {
		return $http.get("fetchDistrictsBasedOnStateCode.html?<csrf:token uri=fetchDistrictsBasedOnStateCode.htm/>");
	};
	
	this.getAllState = function() {
		return $http.get("fetchAllState.html?<csrf:token uri=fetchAllState.htm/>");
	};
	
	this.getAllDistrictbyStateCode = function(stateCode) {
		return $http.get("fetchDistrictsbyStateCode.html?<csrf:token uri=fetchDistrictsbyStateCode.htm/>&stateCode="+stateCode);
	};
	
	
	this.getAllGramPanchayat = function(districtCode) {
		return $http.post("gramPanchayatList.html?<csrf:token uri=gramPanchayatList.htm/>",districtCode);
	};
	
	
	this.saveFinalizeWorkLocation= function(capacityBuildingActivityGPs) {
	return $http.post("saveCapacitybuildGPs.html?<csrf:token uri=saveCapacitybuildGPs.htm/>",capacityBuildingActivityGPs);
	};
	
	this.getCBActivityGPs = function(cbActivityDetailsId,cbMasterId) {
		return $http.get("fetchCapacityBuildingActivityGPs.html?<csrf:token uri=fetchCapacityBuildingActivityGPs.htm/>&capacityBuildingActivityDetailsId="+cbActivityDetailsId+"&cbMasterId="+cbMasterId);
	};
	
		
}]);