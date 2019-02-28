indexModule.service('indexService', [ '$http', function($http) {
	
  var service = {};

  service.findLatestImages = function() {
	  return $http.get("findImage.html",{});
  };
  
  service.findNewDocs = function() {
	  return $http.get("findNew.html",{});
  };
  
  
  service.fetchStatewiseEntitiesCount = function() {
	  return $http.get("fetchStatewiseEntitiesCount.html",{});
  };
  


  
  return service;

} ]);


