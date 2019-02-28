/**
 * 
 */
publicModule.service('satcomService', [ '$http', function($http) {
	
	this.getActivityList=function(){
		return $http.get("getOnLoadData.html?<csrf:token uri=getOnLoadData.htm/>");
	}
		
	this.saveData=function(dataObejct){
		console.log("inside service")
		return $http.post("saveSatcomFacility.html?<csrf:token uri=saveSatcomFacility.html/>",dataObejct);
	}
	
}]);