/**
 * 
 */
trainingDetail.service('trainingDetailService', [ '$http', function($http) {
	
	this.fetchtrainingDetailData=function(){
		return $http.get("fetchtrainingDetailData.html?<csrf:token uri=fetchtrainingDetailData.htm/>");
	}
	
	this.fetchtrainingOtherbyTrainingId=function(trainingId){
		return $http.get("fetchtrainingOtherbyTrainingId.html?<csrf:token uri=fetchtrainingOtherbyTrainingId.htm/>&trainingId="+trainingId);
	}
	
	this.savetrainingDetailData=function(fetchTrainingDetails){
		return $http.post("savetrainingDetailData.html?<csrf:token uri=savetrainingDetailData.htm/>",fetchTrainingDetails);
	}
	
	this.fetchSubjectsListData=function(strTrainingCategoryIds){
		return $http.get("fetchSubjectsListData.html?<csrf:token uri=fetchSubjectsListData.htm/>&strTrainingCategoryIds="+strTrainingCategoryIds);
	}
	
	this.updateTrainingActivityData=function(fetchTraining){
		return $http.post("updateTrainingActivityData.html?<csrf:token uri=updateTrainingActivityData.htm/>",fetchTraining);
	}
	
	
	this.fetchTrainingDetailsMOPRCEC=function(){
		return $http.get("fetchtrainingDetailDataMOPRCEC.html?<csrf:token uri=fetchtrainingDetailDataMOPRCEC.htm/>");
	}
	
	this.savetrainingDetailMOPRCEC=function(fetchTraining){
		return $http.post("savetrainingDetailDataMOPRCEC.html?<csrf:token uri=savetrainingDetailDataMOPRCEC.htm/>",fetchTraining);
	}
}]);