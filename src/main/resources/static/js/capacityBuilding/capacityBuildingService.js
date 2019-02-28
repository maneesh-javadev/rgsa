publicModule.service('capacityBuildingService', [ '$http', function($http) {
	
	this.fetchCBMastersAndCapacityBuildingData=function(){
		return $http.get("fetchCBMastersAndCapacityBuildingData.html?<csrf:token uri=fetchCBMastersAndCapacityBuildingData.htm/>");
	}
	
	this.saveCapacityBuildingActivityAndDetails=function(capacityBuilding){
		return $http.post("saveCapacityBuildingActivityAndDetails.html?<csrf:token uri=saveCapacityBuildingActivityAndDetails.htm/>",capacityBuilding);
	}
	
	this.freezUnFreezCapacityBuilding=function(capacityBuilding){
		return $http.post("feezUnFreezCapacityBuilding.html?<csrf:token uri=feezUnFreezCapacityBuilding.html/>",capacityBuilding);
	}
	
} ]);