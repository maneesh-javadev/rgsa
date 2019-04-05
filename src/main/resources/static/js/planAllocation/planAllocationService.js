/**
 * By Abhishek Singh dated 12-2-19
 */
planAllocation.service('planAllocationService', [ '$http', function($http) {
	
	this.fetchPlanAllocation=function(){
		return $http.get("fetchPlanAllocation.html?<csrf:token uri=fetchPlanAllocation.htm/>");
	}
	
	this.savePlanAllocation=function(PLAN_ALLOCATION){
		return $http.post("savePlanAllocation.html?<csrf:token uri=savePlanAllocation.htm/>",PLAN_ALLOCATION);
	}
	
	
	
}]);