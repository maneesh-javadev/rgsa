publicModule.service('loginService', [ '$http', function($http) {
	
  var service = {};
 
  service.authenticate = function(data) {
	  return $http.post("authanticate.html",data);
  };
  
  return service;

} ]);


