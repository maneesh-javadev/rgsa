publicModule.service('panchayatBhawanCurrentStatusService', [ '$http', function($http) {
	
	this.fetchDistrictsBasedOnStateCode = function() {
		return $http.get("fetchDistrictsBasedOnStateCode.html?<csrf:token uri=fetchDistrictsBasedOnStateCode.htm/>");
	};
	
	this.fetchBlockListBasedOnDistrictCode=function(districtCode){
		return $http.post("fetchBlocksBasedOnDistrictCode.html?<csrf:token uri=fetchBlocksBasedOnDistrictCode.htm/>",districtCode);
	}

	this.fetchGramPanchayats = function(blockCode) {
		return $http.post("gramPanchayatListBasedOnBlock.html?<csrf:token uri=gramPanchayatListBasedOnBlock.htm/>",blockCode);
	};

	this.fetchServicesProvided = function() {
		return $http.get("fetchServicesProvided.html?<csrf:token uri=fetchServicesProvided.htm/>");
	};

	this.fetchPanchyatBhawanCurrentStatusBasedOnLocalBodySelected = function(selectedGPs) {
		return $http.post("fetchPanchyatBhawanCurrentStatusBasedOnLocalBodySelected.html?<csrf:token uri=fetchPanchyatBhawanCurrentStatusBasedOnLocalBodySelected.htm/>",selectedGPs);
	};
	
	this.savePanchayatBhawanCsDetails=function(panchyatBhawanCurrentStatus){
		console.log("inside service");
		panchyatBhawanCurrentStatus.isFreeze = false;
		return $http.post("savePanchayatBhawanCsDetails.html?<csrf:token uri=savePanchayatBhawanCsDetails.html/>",panchyatBhawanCurrentStatus);
	}
		
}]);