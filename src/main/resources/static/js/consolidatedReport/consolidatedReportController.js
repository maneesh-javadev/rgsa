var publicModule = angular.module("publicModule", []);
publicModule.controller("consolidatedReportController", [ '$scope', "consolidatedReportService",
		function($scope, consolidatedReportService) {
	
	$scope.pesaPlan={};
	$scope.pesaPlan.pesaPlanDetails=[];
	$scope.pesaPlan.additionalRequirement;
	
	$scope.capacityBuilding={};
	$scope.capacityBuilding.capacityBuildingActivityDetails=[];
	$scope.capacityBuilding.additionalRequirement;
	
	fetchConsolidatedReportDetails();
	
	function fetchConsolidatedReportDetails(){
		console.log("inside fetchConsolidatedReportDetails");
		fetchPesaPlanDetails();
		fetchCBMastersAndCapacityBuildingData();
		getPanchayatBhawanActivity();
	}
	
	function fetchCBMastersAndCapacityBuildingData(){
		consolidatedReportService.fetchCBMastersAndCapacityBuildingData().then(function(response){
			console.log(response.data);
			$scope.cbmasters = response.data.cbMasters;
			if(response.data.capacityBuildingDetails != null){
				$scope.capacityBuilding = response.data.capacityBuildingDetails;
			}
		},function(error){
			
		});
	}
	
	function getPanchayatBhawanActivity(){
		consolidatedReportService.getPanchayatBhawanActivity().then(function(response){
			$scope.activityList=response.data.PANCHAYAT_ACTIVITY;
			$scope.districtList=response.data.DISTRICT_LIST;
			if(response.data.PANCHAYAT_BHAWAN_ACTIVITY!=undefined){
				$scope.panchayatBhawanActivity=response.data.PANCHAYAT_BHAWAN_ACTIVITY;
			}
		});
	}
	
	function fetchPesaPlanDetails(){
		consolidatedReportService.fetchPesaPlanDetails().then(function(response){
			$scope.designationArray = response.data.pesaPosts;
			$scope.pesaPlan.isFreez =false;
			if(response.data.pesaPlanResponseMap != undefined ){
				$scope.pesaPlan = response.data.pesaPlanResponseMap;
				$scope.pesaPlan.pesaPlanId = $scope.pesaPlan.pesaPlanId;
				$scope.pesaPlan.isFreez = $scope.pesaPlan.isFreez;
				$scope.pesaPlan.additionalRequirement = $scope.pesaPlan.additionalRequirement;
				$scope.pesaPlan.pesaPlanDetails = response.data.pesaPlanDetails;
				
				$scope.postToPesaDetails = new Map();
				
				for (var i = 0; i < $scope.pesaPlan.pesaPlanDetails.length; i++) {
					var obj={};
					for (var j = 0; j < $scope.designationArray.length; j++) {
						if($scope.pesaPlan.pesaPlanDetails[i].pesaPostId == $scope.designationArray[j].pesaPostId){
							$scope.postToPesaDetails.set($scope.designationArray[j].pesaPostId , $scope.pesaPlan.pesaPlanDetails[i]);
							continue;
						}
					}
				}
				
				$scope.pesaPlan.pesaPlanDetails = [];
				for (var i = 0; i < $scope.designationArray.length; i++) {
					var obj =[];
					if($scope.postToPesaDetails.get($scope.designationArray[i].pesaPostId) == null){
						obj.noOfUnits ='';
						obj.unitCostPerMonth ='';
						obj.noOfMonths ='';
						obj.funds ='';
						obj.remarks ='';
						obj.pesaPostId = $scope.designationArray[i].pesaPostId;
						$scope.pesaPlan.pesaPlanDetails.push(obj);
					}else{
						$scope.pesaPlan.pesaPlanDetails.push($scope.postToPesaDetails.get($scope.designationArray[i].pesaPostId))
					}
				}
				
			}
			var designationArray = $scope.designationArray;
			$scope.designationIdToCellingValueMap = new Map();
			
			for (var i = 0; i < $scope.designationArray.length; i++) {
				var obj = {}
				obj.id = $scope.designationArray[i].pesaPostId;
				obj.value = $scope.designationArray[i].ceilingValue;
				$scope.designationIdToCellingValueMap.set(obj.id,obj.value);
			}
			
			if($scope.pesaPlan.pesaPlanDetails != undefined)
				$scope.calculateTotal();
		})
	}
	
	$scope.calculateTotal=function(){
		var totalOfFunds = 0;
			for (var i = 0; i < $scope.pesaPlan.pesaPlanDetails.length; i++) {
				if($scope.pesaPlan.pesaPlanDetails[i] != undefined){
					totalOfFunds = totalOfFunds + $scope.pesaPlan.pesaPlanDetails[i].funds;
				}
			}
		$scope.totalWithoutAddRequirements = totalOfFunds;
		$scope.grandTotal = parseInt($scope.totalWithoutAddRequirements) + $scope.pesaPlan.additionalRequirement;
	}
	
	$scope.exportData = function(){
		
		kendo.drawing.drawDOM("#mytable", 
				{
					paperSize: "A4",
					margin: { top: "1cm", bottom: "1cm" },
					scale: 0.8,
					height: 500
				}).then(function(group){
					kendo.drawing.pdf.saveAs(group, "Consolidated Report.pdf")
				});
	}
	
	$scope.forwardPlan=function(plansAreFreezed){
		if(!plansAreFreezed){
			toastr.error("All Plans Are Not Freezed");
		}else{
			consolidatedReportService.forwardPlans().then(function(data){
				var result = data.data.result;
				switch (result) {
				case "S" :
					toastr.success("Plans are forward");
					break;
				case "N" :
					toastr.error("Please fill Nodal Officers deatils first.");
					break;	
				default:
					break;
				}
			})
		}
	}
	
}]);