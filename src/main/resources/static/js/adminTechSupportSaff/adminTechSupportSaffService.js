publicModule.service('adminTechSupportSaffService', [ '$http', function($http) {
	
		this.getPostTypeMaster = function() {
			return $http.get("fetchPostTypeMaster.html?<csrf:token uri=fetchPostTypeMaster.htm/>");
		};
		
		this.saveData=function(dataObejct){
			return $http.post("saveAdminTechStaff.html?<csrf:token uri=saveAdminTechStaff.html/>",dataObejct);
		}
		/*
		this.fetchAdminTechSupportStaffForMOPRAndState=function(){
			return $http.get("fetchAdminTechSupportStaffForMOPRAndState.html?<csrf:token uri=fetchAdminTechSupportStaffForMOPRAndState.html/>");
		}*/
		
}]);

