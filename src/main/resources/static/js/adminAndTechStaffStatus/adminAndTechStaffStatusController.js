var publicModule = angular.module("publicModule", []);
publicModule.controller("adminAndTechStaffStatusController", [ '$scope', "adminAndTechStaffStatusService",
		function($scope, adminAndTechStaffStatusService) {
	
	$scope.adminAndTechStaffStatus={};
	$scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails=[];
	
	$( document ).ready(function() {
		fetchPosts();
	});
	
	function fetchPosts(){
		console.log("inside pesaController");
		adminAndTechStaffStatusService.fetchPosts().then(function(response) {
			console.log(response.data);
			$scope.postLevels = response.data.level;
			$scope.postAndPostMasterDetails = response.data.postType;
			if(response.data.details != undefined ){
				
				$scope.adminAndTechStaffStatus = response.data.technicalSupport;
				$scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails = response.data.details;
				
				$scope.postToCurrentStatusDetails = new Map();
				
				for (var i = 0; i < $scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails.length; i++) {
					var obj={};
					for (var j = 0; j < $scope.postAndPostMasterDetails.length; j++) {
						if($scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[i].postType.postId == $scope.postAndPostMasterDetails[j].postId && 
						   $scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[i].postType.master.postTypeId == $scope.postAndPostMasterDetails[j].master.postTypeId){
							
							$scope.postToCurrentStatusDetails.set($scope.postAndPostMasterDetails[j].postId+"_"+$scope.postAndPostMasterDetails[j].master.postTypeId , $scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[i]);
							continue;
						}
					}
				}
				
				$scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails = [];
				
				for (var i = 0; i < $scope.postAndPostMasterDetails.length; i++) {
					var obj ={};
					if($scope.postToCurrentStatusDetails.get($scope.postAndPostMasterDetails[i].postId+"_"+$scope.postAndPostMasterDetails[i].master.postTypeId) == null){
						obj.contrNoOfPositioned ='';
						obj.regNoOfPositioned ='';
						obj.regNoOfSanctioned ='';
						
						obj.postLevel = {}
						obj.postType = {}
						$scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails.push(obj);
					}else{
						$scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails.push($scope.postToCurrentStatusDetails.get($scope.postAndPostMasterDetails[i].postId+"_"+$scope.postAndPostMasterDetails[i].master.postTypeId));
					}
				}
				
			}
		},function(error){
			alert(error);
		});
	}
	
	$scope.insertPostTypeValueInScope=function(index){
		$scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[index].postType={'postId':''};
		$scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[index].postType.postId = $('#postTypeNames'+'_'+index).val();
	}
	
	$scope.onClear = function(){
		
	}
	
	$scope.saveCurrentStatus=function(){
		console.log($scope.adminAndTechStaffStatus);
		$scope.constructObject();
		if($scope.validateObject()){
			adminAndTechStaffStatusService.saveCurrentStatus($scope.adminAndTechStaffStatus).then(function(response){
				toastr.success("Status Saved Successfully");
				fetchPosts();
			},function(error){
				console.log(error);
			});
		}
	}
	
	$scope.constructObject=function(){
		var index = 0;
		var objDetails=[];
		angular.copy($scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails,objDetails );
		$scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails=[];
		angular.forEach(objDetails, function(details, key) {
			if(details.contrNoOfPositioned!='' || details.regNoOfPositioned!='' || details.regNoOfSanctioned !=''){
	//				$scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails=[]; 
					$scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[index]=details;
					index++;
				}
			});
		console.log($scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails);
		/*for (var i = 0; i < $scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails.length; i++) {
			if($scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[i].contrNoOfPositioned != "" 
				&& $scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[i].regNoOfPositioned != ""
					&& $scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[i].regNoOfSanctioned != ""){
				$scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails.pop(i);
			}
		}*/
	}
	
	$scope.validateObject=function(){
		
		if($scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails.length == 0){
			toastr.error("Please Fill The Details");
			return false;
		}
		
		angular.forEach($scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails, function(details, key) {
			
			if(details.postLevel.postLevelId==""){
				toastr.error("Please Select Post Level");
				return false;
			}
			
			if(details.regNoOfPositioned==""){
				toastr.error("No Of Positioned For Regular Should Not Be Left Blank");
				return false;
			}
			if(details.regNoOfSanctioned==""){
				toastr.error("No Of Sanctioned For Regular Should Not Be Left Blank");
				return false;
			}
			if(details.contrNoOfPositioned==""){
				toastr.error("No Of Positioned For Contractual Should Not Be Left Blank");
				return false;
			}
		});
		return true;
	}
	
	$scope.validateValue = function(index){
		if(parseInt($scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[index].regNoOfPositioned) > 
			parseInt($scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[index].regNoOfSanctioned)){
			$scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[index].regNoOfPositioned ='';
			toastr.error("Number Of Positioned Should Not Be greater Than Number Of Sanctioned");
		}
	}

	$scope.validateSanctioned = function(index){
		if(parseInt($scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[index].regNoOfSanctioned) < 
				parseInt($scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[index].regNoOfPositioned)){
			$scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[index].regNoOfSanctioned ='';
			toastr.error("Number Of Sanctioned Should Be greater Than Number Of Positioned");
		}
	}
	
	$scope.freezUnFreezAdminAndTechStaffStatus=function(freezUnfreez){
		if(freezUnfreez == 'freez'){
			$scope.adminAndTechStaffStatus.isFreeze = true;
		}else{
			$scope.adminAndTechStaffStatus.isFreeze = false;
		}
		adminAndTechStaffStatusService.freezUnFreezAdminAndTechStaffStatus($scope.adminAndTechStaffStatus).then(function(response){
			$scope.adminAndTechStaffStatus = response.data;
			if(freezUnfreez == 'freez'){
				toastr.success("Plan Freezed Successfully");
			}else{
				toastr.success("Plan UnFreezed Successfully");
			}
		},function(error){
			alert(error);
		});
	}

}]);