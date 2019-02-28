panchayatBhawanApp.service('panchayatBhawanActivityService', [ '$http', function($http) {
	
	this.getPanchayatBhawanActivity = function() {
		return $http.get("getPanchayatBhawanActivity.html?<csrf:token uri=getPanchayatBhawanActivity.htm/>");
	};
	
	this.saveData=function(dataObejct){
		console.log("inside service")
		return $http.post("savePanchayatBhawanActivity.html?<csrf:token uri=savePanchayatBhawanActivity.html/>",dataObejct);
	}
	
	this.getGramPanchayat=function(districtCode){
		return $http.post("gramPanchayatList.html?<csrf:token uri=gramPanchayatList.htm/>",districtCode);
	};
		
}]);