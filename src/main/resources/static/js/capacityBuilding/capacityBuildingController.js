var publicModule = angular.module("publicModule", []);
publicModule.controller("capacityBuildingController", [ '$scope', "capacityBuildingService",
		function($scope, capacityBuildingService) {
	
	
	$scope.capacityBuilding={};
	$scope.capacityBuilding.capacityBuildingActivityDetails=[];
	$scope.capacityBuilding.additionalRequirement;
	$scope.userType = null;
	
	fetchCBMastersAndCapacityBuildingData();
	
	function fetchCBMastersAndCapacityBuildingData(){
		$scope.btn_disabled=false;
		capacityBuildingService.fetchCBMastersAndCapacityBuildingData().then(function(response){
			console.log(response.data);
			$scope.cbmasters = response.data.cbMasters;
			$scope.userType =  response.data.userType;
			if(response.data.capacityBuildingDetails != null){
				$scope.capacityBuilding = response.data.capacityBuildingDetails;
				
				$scope.preStateComments = response.data.STATE_PRE_COMMENTS;
				$scope.preMoprComments = response.data.MOPR_PRE_COMMENTS;
				
				$scope.calculateSubTotal($scope.capacityBuilding.capacityBuildingActivityDetails);
				
				$scope.cbToCurrentStatusDetails = new Map();
				
				for (var i = 0; i < $scope.capacityBuilding.capacityBuildingActivityDetails.length; i++) {
					var obj={};
					for (var j = 0; j < $scope.cbmasters.length; j++) {
						if($scope.capacityBuilding.capacityBuildingActivityDetails[i].cbMaster == $scope.cbmasters[j].cbMasterId){
							$scope.cbToCurrentStatusDetails.set($scope.cbmasters[j].cbMasterId , $scope.capacityBuilding.capacityBuildingActivityDetails[i]);
							continue;
						}
					}
				}
				console.log($scope.cbToCurrentStatusDetails);
				
				$scope.capacityBuilding.capacityBuildingActivityDetails = [];
				
				for (var i = 0; i < $scope.cbmasters.length; i++) {
					var obj ={};
					if($scope.cbToCurrentStatusDetails.get($scope.cbmasters[i].cbMasterId) == null){
						obj.noOfDays ='';
						obj.noOfUnits ='';
						obj.unitCost ='';
						
						obj.cbMaster = '';
						$scope.capacityBuilding.capacityBuildingActivityDetails.push(obj);
					}else{
						$scope.capacityBuilding.capacityBuildingActivityDetails.push($scope.cbToCurrentStatusDetails.get($scope.cbmasters[i].cbMasterId));
					}
				}
				
			}
		},function(error){
			
		});
	}
	
	$scope.insertCBMasterInScope=function(index){
		console.log("inside insertCBMasterInScope");
		$scope.capacityBuilding.capacityBuildingActivityDetails[index].cbMaster=$('#cbMaster'+'_'+index).val();
//		$scope.adminAndTechStaffStatus.administrativeAndTechnicalStaffStatusDetails[index].postType.postId = $('#cbMaster'+'_'+index).val();
	}
	
	$scope.calculateFunds=function(index){
		console.log(index);
		if(index == 4 || index == 5){
			$scope.capacityBuilding.capacityBuildingActivityDetails[index].funds = $scope.capacityBuilding.capacityBuildingActivityDetails[index].noOfUnits * 
				$scope.capacityBuilding.capacityBuildingActivityDetails[index].unitCost * $scope.capacityBuilding.capacityBuildingActivityDetails[index].noOfDays;
		}else{
			$scope.capacityBuilding.capacityBuildingActivityDetails[index].funds = $scope.capacityBuilding.capacityBuildingActivityDetails[index].noOfUnits * 
				$scope.capacityBuilding.capacityBuildingActivityDetails[index].unitCost;
		}
		
		$scope.calculateSubTotal($scope.capacityBuilding.capacityBuildingActivityDetails);
		
	}
	
	$scope.checkForCellingValue=function(index){
		console.log($scope.capacityBuilding.capacityBuildingActivityDetails[index].unitCost > $scope.cbmasters[index].ceilingValue);
		if($scope.capacityBuilding.capacityBuildingActivityDetails[index].unitCost > $scope.cbmasters[index].ceilingValue){
			$scope.capacityBuilding.capacityBuildingActivityDetails[index].unitCost ='';
			$scope.capacityBuilding.capacityBuildingActivityDetails[index].funds = '';
			toastr.error("Unit Cost for " + $scope.cbmasters[index].cbName + " should not be greater than " + $scope.cbmasters[index].ceilingValue);
		}
	}
	
	$scope.calculateSubTotal=function(capacityBuildingActivityDetails){
		var totalFund = 0;
		for (var i = 0; i < capacityBuildingActivityDetails.length; i++) {
		if(capacityBuildingActivityDetails[i].funds != null && capacityBuildingActivityDetails[i].funds != undefined)
		totalFund = totalFund + capacityBuildingActivityDetails[i].funds;
		}
		$scope.subTotal=totalFund;
		$scope.validateAmount();
		$scope.calculateGrandTotal();
	}
	
	$scope.calculateGrandTotal=function(){
		var grandTotal = 0;
		if($scope.capacityBuilding.additionalRequirement == undefined || $scope.capacityBuilding.additionalRequirement == ""){
			grandTotal = 0 + parseInt($scope.subTotal);
		}else{
			grandTotal = parseInt($scope.capacityBuilding.additionalRequirement) + parseInt($scope.subTotal);
		}
		$scope.grandTotal=grandTotal;
	}
	
	$scope.validateAmount=function(){
		var totalFund = 0;
		for (var i = 0; i < $scope.capacityBuilding.capacityBuildingActivityDetails.length; i++) {
			if($scope.capacityBuilding.capacityBuildingActivityDetails[i].funds != undefined)
			totalFund = totalFund + $scope.capacityBuilding.capacityBuildingActivityDetails[i].funds;
		}
		
		var allowedAdditionalRequirement = (25/100)*totalFund;
		
		if($scope.capacityBuilding.additionalRequirement > allowedAdditionalRequirement){
			toastr.error("Additional requirement should not be greater than " + allowedAdditionalRequirement);
			$scope.capacityBuilding.additionalRequirement='';
		}
		$scope.calculateGrandTotal();
	}
	
	$scope.saveCapacityBuildingActivityAndDetails=function(){
		console.log($scope.capacityBuilding);
		$scope.btn_disabled=true;
		$scope.capacityBuilding.isFreeze = false;
		if($scope.capacityBuilding.capacityBuildingActivityDetails.isApproved == null){
			$scope.capacityBuilding.capacityBuildingActivityDetails.isApproved = false;
		}
		capacityBuildingService.saveCapacityBuildingActivityAndDetails($scope.capacityBuilding).then(function(response){
			fetchCBMastersAndCapacityBuildingData();
			toastr.success("Data Saved Successfully");
		},function(error){
			toastr.error("Something is wrong");
		});
	}
	
	$scope.freezUnFreezCapacityBuilding=function(freezUnfreez){
		if(freezUnfreez == 'freeze'){
			$scope.capacityBuilding.isFreeze = true;
		}else{
			$scope.capacityBuilding.isFreeze = false;
		}
		capacityBuildingService.freezUnFreezCapacityBuilding($scope.capacityBuilding).then(function(response){
			$scope.capacityBuilding = response.data;
			if($scope.capacityBuilding.isFreeze){
				toastr.success("Plan Freezed Successfully");
			}else{
				toastr.success("Plan UnFreezed Successfully");
			}
			fetchCBMastersAndCapacityBuildingData();
		},function(error){
			alert(error);
		});
	}
	
	$scope.onClear=function(){
		$scope.capacityBuilding={};
		$scope.capacityBuilding.capacityBuildingActivityDetails=[];
		$scope.grandTotal = '';
		$scope.subTotal = '';
	}
}]);