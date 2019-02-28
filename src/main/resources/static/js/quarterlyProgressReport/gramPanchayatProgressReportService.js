publicModule.service('gramPanchayatProgressReportService', [ '$http', function($http) {
	
	this.fetchDetailsForGramPanchayatProgressReport=function(){
		return $http.get("fetchDetailsForGramPanchayatProgressReport.html?<csrf:token uri=fetchDetailsForGramPanchayatProgressReport.htm/>");
	};
	
	this.fetchGPBhawanStatus=function(PanchayatBhawanActvityId){
		return $http.get("fetchGpBhawanStatus.html?<csrf:token uri=fetchGpBhawanStatus.htm/>&PanchayatBhawanActvityId="+PanchayatBhawanActvityId+"");
	};

	this.FetchDataOfGps=function(PanchayatBhawanActvityId,DistrictListId){
		return $http.get("fetchGpBhawanData.html?<csrf:token uri=fetchGpBhawanData.htm/>&PanchayatBhawanActvityId="+PanchayatBhawanActvityId+"&DistrictListId="+DistrictListId+"");
	};
	
	this.fetchDataAccordingToQuator=function(quatorId,PanchayatBhawanActvityId,districtCode){
		return $http.get("fetchDataAccordingToQuator.html?<csrf:token uri=fetchDataAccordingToQuator.htm/>&quatorId="+quatorId+"&PanchayatBhawanActvityId="+PanchayatBhawanActvityId+"&districtCode="+districtCode+"");
	};
	
	this.saveQprPanchayatBhawanData=function(qprPanchayatBhawan){
		return $http.post("saveQprPanchayatBhawanData.html?<csrf:token uri=saveQprPanchayatBhawanData.htm/>",qprPanchayatBhawan);
	};
}]);