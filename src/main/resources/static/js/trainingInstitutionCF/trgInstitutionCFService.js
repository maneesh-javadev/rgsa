/**
 * 
 */
publicModule.service('trgInstitutionCFService', [ '$http', function($http) {
	
	this.getTrainingInstitutionLevel =function(){
		return $http.get("getTrainingIstitutionLevel.html?<csrf:token uri=getTrainingIstitutionLevel.htm/>");
	}
	
	this.saveData=function(dataObejct){
		console.log("inside service")
		return $http.post("saveTrainingInstitutionCF.html?<csrf:token uri=saveTrainingInstitutionCF.html/>",dataObejct);
	}
	
	
}]);