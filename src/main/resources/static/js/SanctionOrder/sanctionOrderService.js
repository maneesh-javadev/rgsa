/**
 * 
 */
sanctionOrder.service('sanctionOrderService', ['$q','$http', function($q,$http) {
	 var deffered = $q.defer();
	 var responseData;
	 
	 this.uploadFileToUrl = function(file, uploadUrl){
		 
		 var fd = new FormData();
		 fd.append('file', file);
		 return $http.post(uploadUrl,fd, {
		 transformRequest: angular.identity,
		 headers: { 'Content-Type' : undefined}
		 });

		}

	 this.saveSanctionOrder = function(snactionOrderModel) {
			return $http.post("saveSanctionOrder.html?<csrf:token uri=saveSanctionOrder.html/>",snactionOrderModel);
		};	
	
		
		
		
	
	this.getAllState = function(yearId) {
		return $http.get("allStateList.html?<csrf:token uri=allStateList.htm/>&yearId="+yearId);
	};	
	
	this.getAllFinYear = function() {
		return $http.get("allFinYearList.html?<csrf:token uri=allFinYearList.htm/>");
	};
	
	this.getAllSanctionOrderComponent = function() {
		return $http.get("fetchAllSanctionOrderComponent.html?<csrf:token uri=fetchAllSanctionOrderComponent.htm/>");
	};
	
	
	this.getAllSanctionOrderComponentAmount = function(planCode) {
		return $http.get("fetchAllSanctionOrderCompomentAmount.html?<csrf:token uri=fetchAllSanctionOrderCompomentAmount.htm/>&planCode="+planCode);
	};
	
	this.fetchSanctionOrderData = function(planCode,installmentNo) {
		return $http.get("fetchSanctionOrderData.html?<csrf:token uri=fetchSanctionOrderData.htm/>&planCode="+planCode+"&installmentNo="+installmentNo);
	};
  
	
	this.downloadSanctionOrder = function(fileName) {
		return $http.get("downloadSanctionOrder.html?<csrf:token uri=downloadSanctionOrder.htm/>&fileName="+fileName);
	};
	
	
}]);