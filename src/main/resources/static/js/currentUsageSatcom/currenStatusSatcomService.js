publicModule.service('currenStatusSatcomService', [ '$http', function($http) {
	
	this.fetchSatcomMastersAndSatcomStatus=function(){
		return $http.get("fetchSatcomMastersAndSatcomStatus.html?<csrf:token uri=fetchSatcomMastersAndSatcomStatus.htm/>");
	}
	
	this.saveSatcomCurrentStatus=function(satcomDetails){
		return $http.post("saveSatcomCurrentStatus.html?<csrf:token uri=saveSatcomCurrentStatus.htm/>",satcomDetails);
	}
	
	/*this.freezUnFreezCapacityBuilding=function(capacityBuilding){
		return $http.post("feezUnFreezCapacityBuilding.html?<csrf:token uri=feezUnFreezCapacityBuilding.html/>",capacityBuilding);
	}*/
	
} ]);