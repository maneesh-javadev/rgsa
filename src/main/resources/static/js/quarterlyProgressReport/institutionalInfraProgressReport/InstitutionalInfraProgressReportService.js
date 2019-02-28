publicModule.service('InstitutionalInfraProgressReportService', [ '$http', function($http) {
	
	this.fetchDetailsForInstitutionalInfraProgressReport=function(){
		return $http.get("fetchDetailsForInstInfraProgressReport.html?<csrf:token uri=fetchDetailsForInstInfraProgressReport.htm/>");
	};
	
	this.fetchInstInfraStatus=function(TrainingInstituteTypeId){
		return $http.get("fetchInstInfraStatus.html?<csrf:token uri=fetchInstInfraStatus.htm/>&TrainingInstituteTypeId="+TrainingInstituteTypeId+"");
	};

	this.fetchInstInfraStateData=function(TrainingInstituteTypeId){
		return $http.get("fetchInstInfraStateData.html?<csrf:token uri=fetchInstInfraStateData.htm/>&TrainingInstituteTypeId="+TrainingInstituteTypeId+"");
	};
	
	this.fetchDataAccordingToQuator=function(quatorId,TrainingInstituteTypeId){
		return $http.get("fetchDataAccordingToQuatorInstInfra.html?<csrf:token uri=fetchDataAccordingToQuatorInstInfra.htm/>&quatorId="+quatorId+"&TrainingInstituteTypeId="+TrainingInstituteTypeId+"");
	};
	
	this.saveQprInstitutionalInfrastructureData=function(qprInstitutionalInfrastructure){
		return $http.post("saveQprInstitutionalInfrastructureData.html?<csrf:token uri=saveQprInstitutionalInfrastructureData.htm/>",qprInstitutionalInfrastructure);
	};
}]);