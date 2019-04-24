var publicModule = angular.module("publicModule", []);
publicModule.controller("institutionalInfraActivityPlanController", [ '$scope', "institutionalInfraActivityPlanService",
		function($scope, institutionalInfraActivityPlanService) {
	
	
	$scope.institutionalInfraActivityPlan={};
	$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails=[];

	$scope.institutionalInfraActivityPlanDetailsNBState=[];
	$scope.institutionalInfraActivityPlanDetailsNBDistrict=[];
	$scope.institutionalInfraActivityPlanDetailsCFState=[];
	$scope.institutionalInfraActivityPlanDetailsCFDistrict=[];
	nbdArr=[];
	nbsArr=[];
	cfdArr=[];
	cfsArr=[];
	nbstatetArr =new Map();
	cfstateArr =new Map();
	nbdistrictArr =new Map();
	cfdistrictArr =new Map();
	
	$scope.fullDetails=[];//contains details about sprc and dprc both
	$scope.stackOfPreviousRecord=[];
	$scope.secondStackOfPreviousRecord=[];
	$scope.trainingInstituteTypeId=0;
	$scope.flag=false;
	let total_fund=0;
	let total=0;//sprc+dprc
	init();
	
	function init(){
		institutionalInfraActivityPlanService.fetchDistrictListBasedOnState().then(function(response){
			$scope.districtList = response.data;
			load_data();
		},function(error){
			
		});
	}
	
	/*function fetchInstitutionalInfraActivityPlanData(){
		load_data();
		institutionalInfraActivityPlanService.fetchTrainingInstituteType().then(function(response){
			$scope.trainingInstituteType = response.data.TrainingInstituteType;
			//load_state_data();
			$scope.fetchDistricts();
			load_data();
		},function(error){
			
		});
		
		
	}*/
	$scope.fetchDistricts=function(){
		institutionalInfraActivityPlanService.fetchDistrictListBasedOnState().then(function(response){
			$scope.districtList = response.data;
		
		},function(error){
			
		});
	};
	
	function load_data(){
		$scope.nbsindex=0;
		$scope.nbdindex=0;
		$scope.cfsindex=0;
		$scope.cfdindex=0;
		
		institutionalInfraActivityPlanService.fetchInstitutionalInfraDataForStateAndMOPRNew().then(function(response){
			$scope.institutionalInfraActivityPlan=response.data;
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails=response.data.institutionalInfraActivityPlanDetails;
			for (var i = 0; i < $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length; i++) { 
				workType=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].workType;
				trainingInstitueTypeId=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].trainingInstitueType.trainingInstitueTypeId;
				dlc=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraLocation;
				isactive=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].isactive;
				if(workType=='N' && trainingInstitueTypeId==2 && isactive==true){
					$scope.institutionalInfraActivityPlanDetailsNBState[$scope.nbsindex]=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i];
					districtObj=find_district(dlc);
					$scope.institutionalInfraActivityPlanDetailsNBState[$scope.nbsindex].districtName=districtObj.districtNameEnglish;
					$scope.nbsindex++;
				}else if(workType=='N' && trainingInstitueTypeId==4 && isactive==true){
					$scope.institutionalInfraActivityPlanDetailsNBDistrict[$scope.nbdindex]=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i];
					districtObj=find_district(dlc);
					$scope.institutionalInfraActivityPlanDetailsNBDistrict[$scope.nbdindex].districtName=districtObj.districtNameEnglish;
					
					/*nbdistrictArr.set("fundProposed_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed);
					nbdistrictArr.set("remarks_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].remarks);
					nbdistrictArr.set("institutionalInfraActivityDetailsId"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraActivityDetailsId);*/
					
					$scope.nbdindex++;
				}else if(workType=='C' && trainingInstitueTypeId==2 && isactive==true){
					$scope.institutionalInfraActivityPlanDetailsCFState[$scope.cfsindex]=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i];
					districtObj=find_district(dlc);
					$scope.institutionalInfraActivityPlanDetailsCFState[$scope.cfsindex].districtName=districtObj.districtNameEnglish;
					$scope.cfsindex++;
				}else if(workType=='C' && trainingInstitueTypeId==4 && isactive==true){
					$scope.institutionalInfraActivityPlanDetailsCFDistrict[$scope.cfdindex]=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i];
					districtObj=find_district(dlc);
					$scope.institutionalInfraActivityPlanDetailsCFDistrict[$scope.cfdindex].districtName=districtObj.districtNameEnglish;
					
					/*cfdistrictArr.set("fundSanctioned_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundSanctioned);
					cfdistrictArr.set("fundReleased_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundReleased);
					cfdistrictArr.set("fundUtilized_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundUtilized);
					cfdistrictArr.set("fundRequired_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundRequired);
					cfdistrictArr.set("institutionalInfraActivityDetailsId"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraActivityDetailsId);*/
					
					$scope.cfdindex++;
				}
				
				
			}
			
			
			
			
			
			$scope.institutionalInfraActivityPlan.additionalRequirementNBS=$scope.institutionalInfraActivityPlan.additionalRequirement;
			$scope.institutionalInfraActivityPlan.additionalRequirementNBD=$scope.institutionalInfraActivityPlan.additionalRequirementDPRC;
			
			$scope.calculate_total_fund(1,null,null);
			$scope.calculate_total_fund(2,null,null);
			$scope.calculate_total_fund(3,null,null);
			$scope.calculate_total_fund(4,null,null);
		});
	}
	
	function find_district(dlc){
		var districtObj=null;
		for (var i = 0; i < $scope.districtList.length; i++) { 
			if($scope.districtList[i].districtCode==dlc){
				districtObj=$scope.districtList[i];
			}
		}
		
		  return districtObj;
	}
	
	
	
	
	
	
	
	/*
	 * typeId  Discription    
	 * 1- State New Building
	 * 2- District New Building
	 * 3- State Carry Forward
	 * 4- District Carry Forward
	 */
	$scope.calculate_total_fund=function(typeId,index,id){
		if(typeId==1){
			var totalOfFunds = 0;
			var totalOfFundsReq=0;
			var addiReq=0;
				for (var i = 0; i < $scope.institutionalInfraActivityPlanDetailsNBState.length; i++) {
					if(  $scope.institutionalInfraActivityPlanDetailsNBState[i].fundProposed!= null && $scope.institutionalInfraActivityPlanDetailsNBState[i].fundProposed!= undefined && $scope.institutionalInfraActivityPlanDetailsNBState[i].fundProposed!= ""){
						totalOfFunds = totalOfFunds + parseInt($scope.institutionalInfraActivityPlanDetailsNBState[i].fundProposed);
					}
				}
				
				if(index!=null && totalOfFunds>10000000){
					totalOfFunds=totalOfFunds-$scope.institutionalInfraActivityPlanDetailsNBState[index].fundProposed;
					$scope.institutionalInfraActivityPlanDetailsNBState[index].fundProposed=null;
					toastr.error("Fund proposed in case of SPRC should be less than or equal to 1 crore");
				}
				
			$scope.totalWithoutAddRequirementsNBS = totalOfFunds;
			if($scope.institutionalInfraActivityPlan.additionalRequirementNBS != null && $scope.institutionalInfraActivityPlan.additionalRequirementNBS != undefined){
				addiReq=parseInt($scope.institutionalInfraActivityPlan.additionalRequirementNBS);
			}
			if(addiReq>(totalOfFunds*25/100)){
				$scope.institutionalInfraActivityPlan.additionalRequirementNBS=null;
				addiReq=0;
				toastr.error("Additional Requirement must be less then 25% of total Fund proposed");
			}
			$scope.grandTotalNBS = parseInt($scope.totalWithoutAddRequirementsNBS) + addiReq;
		}
		
		if(typeId==2){
			var totalOfFunds = 0;
			var totalOfFundsReq=0;
			var addiReq=0;
				for (var i = 0; i < $scope.institutionalInfraActivityPlanDetailsNBDistrict.length; i++) {
					if(  $scope.institutionalInfraActivityPlanDetailsNBDistrict[i].fundProposed!= null && $scope.institutionalInfraActivityPlanDetailsNBDistrict[i].fundProposed!= undefined && $scope.institutionalInfraActivityPlanDetailsNBDistrict[i].fundProposed!= ""){
						totalOfFunds = totalOfFunds + parseInt($scope.institutionalInfraActivityPlanDetailsNBDistrict[i].fundProposed);
					}
				}
				
				if(index!=null && totalOfFunds>20000000){
					totalOfFunds=totalOfFunds-$scope.institutionalInfraActivityPlanDetailsNBDistrict[index].fundProposed;
					$scope.institutionalInfraActivityPlanDetailsNBDistrict[index].fundProposed=null;
					toastr.error("Fund proposed in case of DPRC should be less than or equal to 2 crore");
				}
			$scope.totalWithoutAddRequirementsNBD = totalOfFunds;
			if($scope.institutionalInfraActivityPlan.additionalRequirementNBD != null && $scope.institutionalInfraActivityPlan.additionalRequirementNBD != undefined){
				addiReq=parseInt($scope.institutionalInfraActivityPlan.additionalRequirementNBD);
			}
			
			if(addiReq>(totalOfFunds*25/100)){
				$scope.institutionalInfraActivityPlan.additionalRequirementNBD=null;
				addiReq=0;
				toastr.error("Additional Requirement must be less then 25% of total Fund proposed");
			}
			$scope.grandTotalNBD = parseInt($scope.totalWithoutAddRequirementsNBD) + addiReq;
		}	
		
		if(typeId==3){
			
			if(index!=null){
				var FREL=0,FUTI=0,FREQ=0,FSAN=0;
				var isError=false;
				if($scope.institutionalInfraActivityPlanDetailsCFState[index].fundSanctioned != null && $scope.institutionalInfraActivityPlanDetailsCFState[index].fundSanctioned != undefined){
						FSAN=parseInt($scope.institutionalInfraActivityPlanDetailsCFState[index].fundSanctioned);
				}
				if($scope.institutionalInfraActivityPlanDetailsCFState[index].fundReleased != null && $scope.institutionalInfraActivityPlanDetailsCFState[index].fundReleased!= undefined){
						FREL=parseInt($scope.institutionalInfraActivityPlanDetailsCFState[index].fundReleased);
				}
				if($scope.institutionalInfraActivityPlanDetailsCFState[index].fundUtilized != null && $scope.institutionalInfraActivityPlanDetailsCFState[index].fundUtilized != undefined){
						FUTI=parseInt($scope.institutionalInfraActivityPlanDetailsCFState[index].fundUtilized);
				}
					
					if(FREL>FSAN && id!='SAN'){
						toastr.error("Fund Sanctioned must be greater then Fund Released");
						isError=true;
					}else{
						if(id!='SAN'){
							if(FREL>FUTI){
								FREQ=FREL-FUTI;
								if(FSAN>FREQ){
									$scope.institutionalInfraActivityPlanDetailsCFState[index].fundRequired=FREQ;
									
								}
								else{
									toastr.error("Fund Required must be greater then Fund Sanctioned");
									isError=true;
								}
							}else{
								toastr.error("Fund Released must be greater then Fund Utilized");
								isError=true;
							}
						}else{
							$scope.institutionalInfraActivityPlanDetailsCFState[index].fundRequired=null;
							$scope.institutionalInfraActivityPlanDetailsCFState[index].fundReleased=null;
							$scope.institutionalInfraActivityPlanDetailsCFState[index].fundUtilized=null;
						}
						
						
						}
				
					
					
					
					if(isError){
						if(id=='REL'){
							$scope.institutionalInfraActivityPlanDetailsCFState[index].fundReleased=null;
						}else if(id=='UTI')	{
							$scope.institutionalInfraActivityPlanDetailsCFState[index].fundUtilized=null;
						}else if(id=='SAN')	{
							$scope.institutionalInfraActivityPlanDetailsCFState[index].fundSanctioned=null;
						}
						$scope.institutionalInfraActivityPlanDetailsCFState[index].fundRequired=null;
					}
			}
			
				
				var totalOfFunds=0;
				for (var i = 0; i < $scope.institutionalInfraActivityPlanDetailsCFState.length; i++) {
					if(  $scope.institutionalInfraActivityPlanDetailsCFState[i].fundRequired!= null && $scope.institutionalInfraActivityPlanDetailsCFState[i].fundRequired!= undefined && $scope.institutionalInfraActivityPlanDetailsCFState[i].fundRequired!= ""){
						totalOfFunds = totalOfFunds + parseInt($scope.institutionalInfraActivityPlanDetailsCFState[i].fundRequired);
					}
				}
			$scope.totalWithoutAddRequirementsCFS = totalOfFunds;
			
		}
		
		if(typeId==4){

			if(index!=null){
				var FREL=0,FUTI=0,FREQ=0,FSAN=0;
				var isError=false;
				if($scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundSanctioned != null && $scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundSanctioned != undefined){
						FSAN=parseInt($scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundSanctioned);
				}
				if($scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundReleased != null && $scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundReleased!= undefined){
						FREL=parseInt($scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundReleased);
				}
				if($scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundUtilized != null && $scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundUtilized != undefined){
						FUTI=parseInt($scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundUtilized);
				}
					
					if(FREL>FSAN && id!='SAN'){
						toastr.error("Fund Sanctioned must be greater then Fund Released");
						isError=true;
					}else{
						if(id!='SAN'){
							if(FREL>FUTI){
								FREQ=FREL-FUTI;
								if(FSAN>FREQ){
									$scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundRequired=FREQ;
									
								}
								else{
									toastr.error("Fund Required must be greater then Fund Sanctioned");
									isError=true;
								}
							}else{
								toastr.error("Fund Released must be greater then Fund Utilized");
								isError=true;
							}
						}else{
							$scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundRequired=null;
							$scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundReleased=null;
							$scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundUtilized=null;
						}
						
						
						}
				
					
					
					
					if(isError){
						if(id=='REL'){
							$scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundReleased=null;
						}else if(id=='UTI')	{
							$scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundUtilized=null;
						}else if(id=='SAN')	{
							$scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundSanctioned=null;
						}
						$scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundRequired=null;
					}
			}
			
			
				
				var totalOfFunds=0;
				for (var i = 0; i < $scope.institutionalInfraActivityPlanDetailsCFDistrict.length; i++) {
					if(  $scope.institutionalInfraActivityPlanDetailsCFDistrict[i].fundRequired!= null && $scope.institutionalInfraActivityPlanDetailsCFDistrict[i].fundRequired!= undefined && $scope.institutionalInfraActivityPlanDetailsCFDistrict[i].fundRequired!= ""){
						totalOfFunds = totalOfFunds + parseInt($scope.institutionalInfraActivityPlanDetailsCFDistrict[i].fundRequired);
					}
				}
			$scope.totalWithoutAddRequirementsCFD = totalOfFunds;
		}	
		
	}
	
	
	$scope.save_data=function(status){
		$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails=[];
		index=0;
		$scope.institutionalInfraActivityPlan.additionalRequirement=$scope.institutionalInfraActivityPlan.additionalRequirementNBS;
		$scope.institutionalInfraActivityPlan.additionalRequirementDPRC=$scope.institutionalInfraActivityPlan.additionalRequirementNBD;
		for (var i = 0; i < $scope.institutionalInfraActivityPlanDetailsNBState.length; i++) { 
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index]=$scope.institutionalInfraActivityPlanDetailsNBState[i];
			index++;
		}
		
		for (var i = 0; i < $scope.institutionalInfraActivityPlanDetailsNBDistrict.length; i++) { 
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index]=$scope.institutionalInfraActivityPlanDetailsNBDistrict[i];
			index++;
		}
		
		for (var i = 0; i < $scope.institutionalInfraActivityPlanDetailsCFState.length; i++) { 
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index]=$scope.institutionalInfraActivityPlanDetailsCFState[i];
			index++;
		}
		
		for (var i = 0; i < $scope.institutionalInfraActivityPlanDetailsCFDistrict.length; i++) { 
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index]=$scope.institutionalInfraActivityPlanDetailsCFDistrict[i];
			index++;
		}
		
		for(let i=0;i<$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length;i++){
			(($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed !== "" && $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed != 0)
			|| ($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundRequired!== "" && $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundRequired != 0)) 
			? saveStatus = true : saveStatus =false;
		}
		if(saveStatus){
			$scope.institutionalInfraActivityPlan.isFreeze=false;
			if(status=='F'){
				$scope.institutionalInfraActivityPlan.isFreeze=true;
			}
			institutionalInfraActivityPlanService.saveInstitutionalInfraActivityPlanDetailsMOPRCEC($scope.institutionalInfraActivityPlan).then(function(response){
				//$scope.institutionalInfraActivityPlan = response.data;
				//$scope.fetchData($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[0].trainingInstitueType.trainingInstitueTypeId);
					toastr.success("Plan Saved Successfully");
					load_data();
			},function(error){
				toastr.error("Something went wrong");
			});	
		}else{
			toastr.error("Fund value should not be blank or zero.");
		}
	}
	
	
	
}]);