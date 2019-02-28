publicModule.controller("addTrainingInstituteController", function($scope, trainingInfrastructureService,modifiableObject,$modalInstance) {
	
	$scope.trainingInstitute={};
	$scope.trainingInstitute.trainingInstituteCurrentStatusDetails=[];
	$scope.trainingInstitueTypeId=0;
	
	$scope.showTable = false;
	$scope.showDistrict = false;
	$scope.showBlock = false;
	$scope.selectLevel = true;
	
	$scope.fetchInstituteTypes=function(levelSelected){
		trainingInfrastructureService.fetchInstituteTypes(parseInt(levelSelected)).then(function(response){
			console.log(response.data);
			$scope.instituteTypes = response.data;
		},function(error){
			
		});
	}
	
	$scope.fetchScheme=function(){
		trainingInfrastructureService.fetchScheme().then(function(response){
			console.log(response.data);
			$scope.schemes = response.data;
		},function(error){
			
		});
	}
	
	assignValues();
	
	function assignValues(){
		if(modifiableObject != undefined){
			$scope.showTable = true;
			$scope.selectLevel = false;
			$scope.showLevelLabel = true;
			$scope.trainingInstitute = modifiableObject;
			$scope.level = $scope.trainingInstitute.trainingInstituteCurrentStatusDetails[0].trainingInstitueType.instituteLevel.trainingInstituteLevelId;
			$scope.fetchInstituteTypes($scope.level);
			$scope.fetchScheme();
		}
	}
	
	$scope.level = 1;
	
	$scope.show=function(val) {

		$scope.showTable = true;
	
		if(val.level == 0){
			$scope.trainingInstitute={};
			$scope.showTable = false;
		}
		
		if(val.level != 0){
			$scope.fetchInstituteTypes(val.level);
			$scope.fetchScheme();
			$scope.level = val.level;
		}
		
		if(val.level == 1) {
			$scope.fetchTrainingInstituteDetails(null,$scope.level);
		}
		
		if(val.level == 2) {
			$scope.showDistrict = true;
			$scope.fetchDistrictListBasedOnState();
		}
		else{
			$scope.showDistrict = false;
		}
		
		if(val.level == 5)
			{
				$scope.fetchDistrictListBasedOnState();
				$scope.showBlock = true;
				$scope.showDistrict = true;
			}
		else{
			$scope.showBlock = false;
		} 
		
	}
	
	$scope.fetchDistrictListBasedOnState=function(){
		trainingInfrastructureService.fetchDistrictListBasedOnState().then(function(response){
			console.log(response.data);
			$scope.districtList = response.data;
		},function(error){
			
		});
	}
	
	$scope.fetchBlockListBasedOnDistrict=function(selectedDistrict){
		if($scope.level == 5){
			trainingInfrastructureService.fetchBlockListBasedOnDistrictCode(parseInt(selectedDistrict)).then(function(response){
				console.log(response.data);
				$scope.blockList = response.data;
			},function(error){
				
			});
		}
	}
	
	$scope.fetchTrainingInstituteDetails=function(location){
		trainingInfrastructureService.fetchTrainingInstituteDetails(location,$scope.level).then(function(response){
			console.log(response.data);
			if(response.data != ""){
				$scope.trainingInstitute = response.data;

				if($scope.trainingInstitute == null){
					$scope.trainingInstitute={};
				}
				
				if($scope.trainingInstitute.trainingInstituteCurrentStatusDetails == null || $scope.trainingInstitute.trainingInstituteCurrentStatusDetails[0]==undefined){
					
					$scope.trainingInstitute.trainingInstituteCurrentStatusDetails=[];
					
					$scope.trainingInstitute.trainingInstituteCurrentStatusDetails[0]={};
					$scope.trainingInstitute.trainingInstituteCurrentStatusDetails[0].tiLocation = '';
					$scope.trainingInstitute.trainingInstituteCurrentStatusDetails[0].tiLocation = location;
					$scope.locationSelected=location;
				}
				else{
					$scope.locationSelected = $scope.trainingInstitute.trainingInstituteCurrentStatusDetails[0].tiLocation;
					$scope.trainingInstitute.trainingInstituteCurrentStatusDetails[0].tiLocation = location;
					
					$scope.trainingInstitute.trainingInstituteCurrentStatusDetails[0].scheme = [];
					angular.forEach($scope.trainingInstitute.trainingInstituteCurrentStatusDetails[0].trainingInstituteFundSource,function(value){
						$scope.trainingInstitute.trainingInstituteCurrentStatusDetails[0].scheme.push(value.scheme.schemeId+"");
					})
					
				}
			}
			
		},function(error){
			
		});
	}
	
	$scope.saveInfrastructureDetails=function(){
		if($scope.trainingInstitute.trainingInstituteCurrentStatusDetails[0]!=null || $scope.trainingInstitute.trainingInstituteCurrentStatusDetails[0]!=undefined){
			$scope.trainingInstitute.trainingInstituteCurrentStatusDetails[0].tiLocation = parseInt($scope.locationSelected);
			$modalInstance.close($scope.trainingInstitute);
		}else{
			alert("Please Fill All The Details");
		}
	}
	
	$scope.cancel = function () {
		$modalInstance.dismiss('cancel'); 
	};
	
});