publicModule.service('institutionalInfraActivityPlanService', [ '$http', function($http) {
	
	this.fetchDistrictListBasedOnState=function(){
		return $http.get("fetchDistrictsBasedOnStateCode.html?<csrf:token uri=fetchDistrictsBasedOnStateCode.htm/>");
	}
	
	this.fetchTrainingInstituteType=function(){
		return $http.get("fetchTrainingInstituteType.html?<csrf:token uri=fetchTrainingInstituteType.htm/>");
	}
	
	this.saveCec = function(institutionalInfraActivityPlan){
		return $http.post("saveInstitutionalInfraActivityCEC.html?<csrf:token uri=saveInstitutionalInfraActivityCEC.htm/>",institutionalInfraActivityPlan);
	}
	
	this.saveInstitutionalInfraActivityPlanDetails = function(institutionalInfraActivityPlan,instituteType,updateStatus){
		var instituteTypeFlag = instituteType == 2 ? 2 : 4;
		return $http.post("saveInstitutionalInfraActivityPlanDetails.html?<csrf:token uri=saveInstitutionalInfraActivityPlanDetails.htm/>&instituteType="+instituteTypeFlag+"&updateStatus="+updateStatus+"",institutionalInfraActivityPlan);
	}
	
	this.fetchDataBasedOnInstituteType = function(instituteType){
		if(instituteType == 2){
			return $http.get("fetchInstitutionalInfraDataForStateAndMOPR.html?<csrf:token uri=fetchInstitutionalInfraDataForStateAndMOPR.htm/>&instituteType=2");
			}
		else{
			return $http.get("fetchInstitutionalInfraDataForStateAndMOPR.html?<csrf:token uri=fetchInstitutionalInfraDataForStateAndMOPR.htm/>&instituteType=4");
			}
		
		}
	
	this.freezUnFreezInstitutionalInfraActivityPlan=function(institutionalInfraActivityPlan){
		return $http.post("feezUnFreezInstitutionalInfraActivityPlan.html?<csrf:token uri=feezUnFreezInstitutionalInfraActivityPlan.html/>",institutionalInfraActivityPlan);
	}
	
	this.fetchInstitutionalInfraDataForStateAndMOPRNew=function(){
		return $http.get("fetchInstitutionalInfraDataForStateAndMOPRNew.html?<csrf:token uri=fetchInstitutionalInfraDataForStateAndMOPRNew.html/>");
	}
	
	this.saveInstitutionalInfraActivityPlanDetailsMOPRCEC = function(institutionalInfraActivityPlan){
		return $http.post("saveInstitutionalInfraActivityPlanDetailsMOPRCEC.html?<csrf:token uri=saveInstitutionalInfraActivityPlanDetailsMOPRCEC.htm/>",institutionalInfraActivityPlan);
	}
	
	this.fetchInstitutionalInfraDataForCECNew=function(){
		return $http.get("fetchInstitutionalInfraDataForCECNew.html?<csrf:token uri=fetchInstitutionalInfraDataForCECNew.html/>");
	}
	
	this.deleteRecord = function(detailId){
		return $http.post("deleteRecord.html?<csrf:token uri=deleteRecord.htm/>&detailId="+detailId);
	}
} ]);