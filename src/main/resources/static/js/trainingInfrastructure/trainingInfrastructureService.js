publicModule.service('trainingInfrastructureService', [ '$http', function($http) {
	
	this.fetchStateList=function(){
		return $http.get("fetchStateList.html?<csrf:token uri=fetchStateList.htm/>");
	}

	this.fetchTrainingInstituteBasedOnFinYearAndStateCode=function(){
		return $http.get("fetchTrainingInstituteBasedOnFinYearAndStateCode.html?<csrf:token uri=fetchTrainingInstituteBasedOnFinYearAndStateCode.htm/>");
	}

	this.fetchDistrictListBasedOnState=function(){
		return $http.get("fetchDistrictsBasedOnStateCode.html?<csrf:token uri=fetchDistrictsBasedOnStateCode.htm/>");
	}
	
	this.fetchBlockListBasedOnDistrictCode=function(districtCode){
		return $http.post("fetchBlocksBasedOnDistrictCode.html?<csrf:token uri=fetchBlocksBasedOnDistrictCode.htm/>",districtCode);
	}
	
	this.fetchInstituteTypes=function(selectedLevel){
		return $http.post("fetchInstituteTypes.html?<csrf:token uri=fetchInstituteTypes.htm/>",selectedLevel);
	}

	this.fetchScheme=function(){
		return $http.get("fetchScheme.html?<csrf:token uri=fetchScheme.htm/>");
	}

	this.fetchTrainingInstituteDetails=function(locationId,level){
		var instituteCurrentStatusDetails={};
		if(locationId!=null){
			locationId = parseInt(locationId);
		}
		var params = {
						"levelId":parseInt(level)
					}
		return $http.post("fetchTrainingInstituteDetails.html?<csrf:token uri=fetchTrainingInstituteDetails.htm/>",locationId,{params: params});
	}

	this.saveInfrastructureDetails=function(infrastructureObj){
		return $http.post("saveInfrastructureDetails.html?<csrf:token uri=saveInfrastructureDetails.htm/>",infrastructureObj);
	}
	
	this.deleteTrainingInfrastructureDetails=function(infrastructureObj){
		return $http.post("deleteTrainingInfrastructureDetails.html?<csrf:token uri=deleteTrainingInfrastructureDetails.htm/>",infrastructureObj);
	}
	
} ]);