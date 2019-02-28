var publicModule = angular.module("publicModule", []);
publicModule.controller("loginController", [ '$scope', "loginService",
		function($scope, loginService) {
	
	$scope.login = new login();
	//console.log(JSON.stringify($scope.login));
	$scope.onLogin = function(){
		
		//console.log(JSON.stringify($scope.login));
		
		loginService.authenticate($scope.login).then(function(response) {
			console.log("response==="+JSON.stringify(response.data))
	    },function(error){
	    	console.log("error==="+JSON.stringify(error.data))
	    });
	}
	
	

	
}]);


