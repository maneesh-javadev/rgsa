publicModule.service('consolidatedReportService', [ '$http', function($http) {
	
	this.fetchPesaPlanDetails=function(){
		return $http.get("fetchPesaPost.html?<csrf:token uri=fetchPesaPost.htm/>");
	}
	
	this.fetchCBMastersAndCapacityBuildingData=function(){
		return $http.get("fetchCBMastersAndCapacityBuildingData.html?<csrf:token uri=fetchCBMastersAndCapacityBuildingData.htm/>");
	}
	
	this.getPanchayatBhawanActivity = function() {
		return $http.get("getPanchayatBhawanActivity.html?<csrf:token uri=getPanchayatBhawanActivity.htm/>");
	};
	
	this.forwardPlans=function(){
		return $http.post("forwardPlans.html?<csrf:token uri=forwardPlans.htm/>");
	}
	
} ]);