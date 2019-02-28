publicModule.service('adminAndTechStaffStatusService', [ '$http', function($http) {
	
	this.fetchPosts=function(){
		return $http.get("fetchPostForAdminsAndTechStatus.html?<csrf:token uri=fetchPostForAdminsAndTechStatus.htm/>");
	}

	this.saveCurrentStatus=function(adminAndTechStaffStatusObj){
		console.log("inside saveCurrentStatus service");
		adminAndTechStaffStatusObj.isFreeze = false;
		return $http.post("saveAdminsAndTechStatus.html?<csrf:token uri=saveAdminsAndTechStatus.htm/>",adminAndTechStaffStatusObj);
	}
	
	this.freezUnFreezAdminAndTechStaffStatus=function(adminAndTechStaffStatus){
		return $http.post("freezUnFreezAdminAndTechStaffStatus.html?<csrf:token uri=freezUnFreezAdminAndTechStaffStatus.html/>",adminAndTechStaffStatus);
	}
	
} ]);