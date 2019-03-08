/**
 * By Abhishek Singh dated 12-2-19
 */
trgModuleCEC.service('trgActivityCecService', [ '$http', function($http) {
	
	this.getActivityList=function(){
		return $http.get("getTrgActivityCecMoprData.html?<csrf:token uri=getTrgActivityCecMoprData.htm/>");
	}
	this.saveCapacityBuildingCEC=function(cecData){
		return $http.post("saveCapacityBuildingCEC.html?<csrf:token uri=saveCapacityBuildingCEC.htm/>",cecData);
	}
	
}]);