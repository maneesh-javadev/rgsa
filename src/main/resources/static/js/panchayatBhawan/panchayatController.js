/**
 * Monty
 */
panchayatBhawanApp.controller('panchayatController',function($scope,panchayatBhawanActivityService,$modalInstance,activityId,districtCode,perposedInfo){
	$scope.item={};
	$scope.currActivityId=activityId;
	$scope.districtCode= districtCode;
	$scope.panchayatBhawanGPs=perposedInfo;
	panchayatBhawanActivityService.getGramPanchayat($scope.districtCode).then(function(response){
		$scope.gramPanchayatList=response.data;
		
	});
	$scope.save=function(){
		$scope.item.panchayatBhawanGPs=$scope.panchayatBhawanGPs;
		$scope.item.currActivityId=$scope.currActivityId;
        $modalInstance.close($scope.item); 
	}
	$scope.cancel = function () {
        $modalInstance.dismiss('cancel'); 
    };
});