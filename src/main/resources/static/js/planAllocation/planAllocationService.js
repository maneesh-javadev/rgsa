/**
 * By Abhishek Singh dated 12-2-19
 */
planAllocation.service('planAllocationService', [ '$http', function($http) {
	
	this.fetchPlanAllocation=function(){
		return $http.get("fetchPlanAllocation.html?<csrf:token uri=fetchPlanAllocation.html/>");
	}
	
	this.savePlanAllocation=function(PLAN_ALLOCATION,installmentNo){
		return $http.post("savePlanAllocation.html?<csrf:token uri=savePlanAllocation.html/>&installmentNo="+installmentNo+"",PLAN_ALLOCATION);
	}
	
	this.fetchfundReleasedInfo=function(installmentNo){
		 return $http.get("fetchFundReleased.html?<csrf:token uri=fetchFundReleased.html/>&installmentNo="+installmentNo);
		 
	}
	
	
}]);