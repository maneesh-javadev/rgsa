/**
 * Sourabhrai
 */
publicModule.controller('selectGramPanchayatController',function($scope,panchayatBhawanCurrentStatusService,alreadySelectedGps,$modalInstance){
	
	$scope.selectedGps = new Map();
	
	panchayatBhawanCurrentStatusService.fetchDistrictsBasedOnStateCode().then(function(response){
		console.log(response.data);
		$scope.districtList = response.data;
		
		if(alreadySelectedGps != undefined){
			let keys = Array.from(alreadySelectedGps);
			var keysArray=[] ;
	 		angular.forEach(keys,function(value){
	 			$scope.selectedGps.set(value[0],value[1]);
	 			console.log($scope.selectedGps);
	 		})
	 		console.log("final : " + $scope.selectedGps);
		}
		
	});
	
	$scope.fetchBlockListBasedOnDistrict=function(selectedDistrict){
			panchayatBhawanCurrentStatusService.fetchBlockListBasedOnDistrictCode(parseInt(selectedDistrict)).then(function(response){
				console.log(response.data);
				$scope.blockList = response.data;
			},function(error){
				
			});
	}
	
	$scope.fetchGramPanchayats=function(selectedBlock){
		panchayatBhawanCurrentStatusService.fetchGramPanchayats(selectedBlock).then(function(response){
			$scope.gramPanchayatList=response.data;
			
			if(alreadySelectedGps != undefined){
				var i = 0;
				angular.forEach($scope.gramPanchayatList,function(value){
					if(alreadySelectedGps.get(value[0]) != undefined){
						$scope.gramPanchayatList[i].push(true);
					}
					i++;
				})
			}
		});
	}
	
	$scope.addToList = function(selectedGp,event){
		if(event.currentTarget.checked){
			$scope.selectedGps.set(selectedGp[0],selectedGp[1]);
		}else{
			$scope.selectedGps.delete(selectedGp[0]);
		}
	}
	
	$scope.save=function(){
		$modalInstance.close($scope.selectedGps);
	}
	
	$scope.cancel = function () {
		$modalInstance.dismiss('cancel');
	};
	
});