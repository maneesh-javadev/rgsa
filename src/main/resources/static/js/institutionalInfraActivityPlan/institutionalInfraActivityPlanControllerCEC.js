var publicModule = angular.module("publicModule", []);
publicModule.controller("institutionalInfraActivityPlanController", [ '$scope', "institutionalInfraActivityPlanService",
		function($scope, institutionalInfraActivityPlanService) {
	
	
	$scope.institutionalInfraActivityPlan={};
	$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails=[];

	$scope.institutionalPlanDetailsNBState=[];
	$scope.institutionalPlanDetailsNBDistrict=[];
	$scope.institutionalPlanDetailsCFState=[];
	$scope.institutionalPlanDetailsCFDistrict=[];
	
	$scope.institutionalPlanDetailsNBStateMOPR=[];
	$scope.institutionalPlanDetailsNBDistrictMOPR=[];
	$scope.institutionalPlanDetailsCFStateMOPR=[];
	$scope.institutionalPlanDetailsCFDistrictMOPR=[];
	
	$scope.institutionalPlanDetailsNBStateCEC=[];
	$scope.institutionalPlanDetailsNBDistrictCEC=[];
	$scope.institutionalPlanDetailsCFStateCEC=[];
	$scope.institutionalPlanDetailsCFDistrictCEC=[];
	
	
	
	
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
		
		$scope.nbsindexstate=0;
		$scope.nbdindexstate=0;
		$scope.cfsindexstate=0;
		$scope.cfdindexstate=0;
		
		$scope.nbsindexmopr=0;
		$scope.nbdindexmopr=0;
		$scope.cfsindexmopr=0;
		$scope.cfdindexmopr=0;
		
		institutionalInfraActivityPlanService.fetchInstitutionalInfraDataForCECNew().then(function(response){
			$scope.institutionalInfraActivityPlan=response.data.institutionalInfraActivityPlanCEC;
			$scope.institutionalInfraActivityPlanState=response.data.institutionalInfraActivityPlanState;
			$scope.institutionalInfraActivityPlanState.institutionalInfraActivityPlanDetailsState=response.data.institutionalInfraActivityPlanState.institutionalInfraActivityPlanDetails;
			
			if($scope.institutionalInfraActivityPlan!=null && $scope.institutionalInfraActivityPlan!=undefined){
				$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails=response.data.institutionalInfraActivityPlanCEC.institutionalInfraActivityPlanDetails;
				for (var i = 0; i < $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length; i++) { 
					workType=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].workType;
					trainingInstitueTypeId=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].trainingInstitueType.trainingInstitueTypeId;
					dlc=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraLocation;
					isactive=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].isactive;
					if(workType=='N' && trainingInstitueTypeId==2 && isactive==true){
						$scope.institutionalPlanDetailsNBStateCEC[$scope.nbsindex]=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i];
						districtObj=find_district(dlc);
						$scope.institutionalPlanDetailsNBStateCEC[$scope.nbsindex].districtName=districtObj.districtNameEnglish;
						$scope.nbsindex++;
					}else if(workType=='N' && trainingInstitueTypeId==4 && isactive==true){
						$scope.institutionalPlanDetailsNBDistrictCEC[$scope.nbdindex]=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i];
						districtObj=find_district(dlc);
						$scope.institutionalPlanDetailsNBDistrictCEC[$scope.nbdindex].districtName=districtObj.districtNameEnglish;
						
						/*nbdistrictArr.set("fundProposed_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed);
						nbdistrictArr.set("remarks_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].remarks);
						nbdistrictArr.set("institutionalInfraActivityDetailsId"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraActivityDetailsId);*/
						
						$scope.nbdindex++;
					}else if(workType=='C' && trainingInstitueTypeId==2 && isactive==true){
						$scope.institutionalPlanDetailsCFStateCEC[$scope.cfsindex]=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i];
						districtObj=find_district(dlc);
						$scope.institutionalPlanDetailsCFStateCEC[$scope.cfsindex].districtName=districtObj.districtNameEnglish;
						$scope.cfsindex++;
					}else if(workType=='C' && trainingInstitueTypeId==4 && isactive==true){
						$scope.institutionalPlanDetailsCFDistrictCEC[$scope.cfdindex]=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i];
						districtObj=find_district(dlc);
						$scope.institutionalPlanDetailsCFDistrictCEC[$scope.cfdindex].districtName=districtObj.districtNameEnglish;
						
						/*cfdistrictArr.set("fundSanctioned_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundSanctioned);
						cfdistrictArr.set("fundReleased_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundReleased);
						cfdistrictArr.set("fundUtilized_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundUtilized);
						cfdistrictArr.set("fundRequired_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundRequired);
						cfdistrictArr.set("institutionalInfraActivityDetailsId"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraActivityDetailsId);*/
						
						$scope.cfdindex++;
					}
					
					
				}
			}
				
			
			
			
			
			for (var i = 0; i < $scope.institutionalInfraActivityPlanState.institutionalInfraActivityPlanDetailsState.length; i++) { 
				workType=$scope.institutionalInfraActivityPlanState.institutionalInfraActivityPlanDetailsState[i].workType;
				trainingInstitueTypeId=$scope.institutionalInfraActivityPlanState.institutionalInfraActivityPlanDetailsState[i].trainingInstitueType.trainingInstitueTypeId;
				dlc=$scope.institutionalInfraActivityPlanState.institutionalInfraActivityPlanDetailsState[i].institutionalInfraLocation;
				isactive=$scope.institutionalInfraActivityPlanState.institutionalInfraActivityPlanDetailsState[i].isactive;
				if(workType=='N' && trainingInstitueTypeId==2 && isactive==true){
					$scope.institutionalPlanDetailsNBState[$scope.nbsindexstate]=$scope.institutionalInfraActivityPlanState.institutionalInfraActivityPlanDetailsState[i];
					districtObj=find_district(dlc);
					$scope.institutionalPlanDetailsNBState[$scope.nbsindexstate].districtName=districtObj.districtNameEnglish;
					$scope.nbsindexstate++;
				}else if(workType=='N' && trainingInstitueTypeId==4 && isactive==true){
					$scope.institutionalPlanDetailsNBDistrict[$scope.nbdindexstate]=$scope.institutionalInfraActivityPlanState.institutionalInfraActivityPlanDetailsState[i];
					districtObj=find_district(dlc);
					$scope.institutionalPlanDetailsNBDistrict[$scope.nbdindexstate].districtName=districtObj.districtNameEnglish;
					
					/*nbdistrictArr.set("fundProposed_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed);
					nbdistrictArr.set("remarks_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].remarks);
					nbdistrictArr.set("institutionalInfraActivityDetailsId"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraActivityDetailsId);*/
					
					$scope.nbdindexstate++;
				}else if(workType=='C' && trainingInstitueTypeId==2 && isactive==true){
					$scope.institutionalPlanDetailsCFState[$scope.cfsindexstate]=$scope.institutionalInfraActivityPlanState.institutionalInfraActivityPlanDetailsState[i];
					districtObj=find_district(dlc);
					$scope.institutionalPlanDetailsCFState[$scope.cfsindexstate].districtName=districtObj.districtNameEnglish;
					$scope.cfsindexstate++;
				}else if(workType=='C' && trainingInstitueTypeId==4 && isactive==true){
					$scope.institutionalPlanDetailsCFDistrict[$scope.cfdindexstate]=$scope.institutionalInfraActivityPlanState.institutionalInfraActivityPlanDetailsState[i];
					districtObj=find_district(dlc);
					$scope.institutionalPlanDetailsCFDistrict[$scope.cfdindexstate].districtName=districtObj.districtNameEnglish;
					
					/*cfdistrictArr.set("fundSanctioned_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundSanctioned);
					cfdistrictArr.set("fundReleased_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundReleased);
					cfdistrictArr.set("fundUtilized_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundUtilized);
					cfdistrictArr.set("fundRequired_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundRequired);
					cfdistrictArr.set("institutionalInfraActivityDetailsId"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraActivityDetailsId);*/
					
					$scope.cfdindexstate++;
				}
				
				
			}
			
			
			$scope.institutionalInfraActivityPlanMOPR=response.data.institutionalInfraActivityPlanMOPR;
			$scope.institutionalInfraActivityPlanMOPR.institutionalInfraActivityPlanDetailsMOPR=response.data.institutionalInfraActivityPlanMOPR.institutionalInfraActivityPlanDetails;
			for (var i = 0; i < $scope.institutionalInfraActivityPlanMOPR.institutionalInfraActivityPlanDetailsMOPR.length; i++) { 
				workType=$scope.institutionalInfraActivityPlanMOPR.institutionalInfraActivityPlanDetailsMOPR[i].workType;
				trainingInstitueTypeId=$scope.institutionalInfraActivityPlanMOPR.institutionalInfraActivityPlanDetailsMOPR[i].trainingInstitueType.trainingInstitueTypeId;
				dlc=$scope.institutionalInfraActivityPlanMOPR.institutionalInfraActivityPlanDetailsMOPR[i].institutionalInfraLocation;
				isactive=$scope.institutionalInfraActivityPlanMOPR.institutionalInfraActivityPlanDetailsMOPR[i].isactive;
				if(workType=='N' && trainingInstitueTypeId==2 && isactive==true){
					$scope.institutionalPlanDetailsNBStateMOPR[$scope.nbsindexmopr]=$scope.institutionalInfraActivityPlanMOPR.institutionalInfraActivityPlanDetailsMOPR[i];
					districtObj=find_district(dlc);
					$scope.institutionalPlanDetailsNBStateMOPR[$scope.nbsindexmopr].districtName=districtObj.districtNameEnglish;
					$scope.nbsindexmopr++;
				}else if(workType=='N' && trainingInstitueTypeId==4 && isactive==true){
					$scope.institutionalPlanDetailsNBDistrictMOPR[$scope.nbdindexmopr]=$scope.institutionalInfraActivityPlanMOPR.institutionalInfraActivityPlanDetailsMOPR[i];
					districtObj=find_district(dlc);
					$scope.institutionalPlanDetailsNBDistrictMOPR[$scope.nbdindexmopr].districtName=districtObj.districtNameEnglish;
					
					/*nbdistrictArr.set("fundProposed_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed);
					nbdistrictArr.set("remarks_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].remarks);
					nbdistrictArr.set("institutionalInfraActivityDetailsId"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraActivityDetailsId);*/
					
					$scope.nbdindexmopr++;
				}else if(workType=='C' && trainingInstitueTypeId==2 && isactive==true){
					$scope.institutionalPlanDetailsCFStateMOPR[$scope.cfsindexmopr]=$scope.institutionalInfraActivityPlanMOPR.institutionalInfraActivityPlanDetailsMOPR[i];
					districtObj=find_district(dlc);
					$scope.institutionalPlanDetailsCFStateMOPR[$scope.cfsindexmopr].districtName=districtObj.districtNameEnglish;
					$scope.cfsindexmopr++;
				}else if(workType=='C' && trainingInstitueTypeId==4 && isactive==true){
					$scope.institutionalPlanDetailsCFDistrictMOPR[$scope.cfdindexmopr]=$scope.institutionalInfraActivityPlanMOPR.institutionalInfraActivityPlanDetailsMOPR[i];
					districtObj=find_district(dlc);
					$scope.institutionalPlanDetailsCFDistrictMOPR[$scope.cfdindexmopr].districtName=districtObj.districtNameEnglish;
					
					/*cfdistrictArr.set("fundSanctioned_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundSanctioned);
					cfdistrictArr.set("fundReleased_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundReleased);
					cfdistrictArr.set("fundUtilized_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundUtilized);
					cfdistrictArr.set("fundRequired_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundRequired);
					cfdistrictArr.set("institutionalInfraActivityDetailsId"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraActivityDetailsId);*/
					
					$scope.cfdindexmopr++;
				}
				
				
			}
			
			
			$scope.planstateAdditionalRequirementState=$scope.institutionalInfraActivityPlanState.additionalRequirement;
			$scope.plandistrictAdditionalRequirementState=$scope.institutionalInfraActivityPlanState.additionalRequirementDPRC;
			
			$scope.planstateAdditionalRequirementMOPR=$scope.institutionalInfraActivityPlanMOPR.additionalRequirement;
			$scope.plandistrictAdditionalRequirementMOPR=$scope.institutionalInfraActivityPlanMOPR.additionalRequirementDPRC;
			
			$scope.planstateAdditionalRequirementCEC=$scope.institutionalInfraActivityPlan.additionalRequirement;
			$scope.plandistrictAdditionalRequirementCEC=$scope.institutionalInfraActivityPlan.additionalRequirementDPRC;
			
			$scope.subTotalFundMOPRNBS=calculate_total_fund_other($scope.institutionalPlanDetailsNBStateMOPR,1);
			$scope.subTotalFundMOPRNBD=calculate_total_fund_other($scope.institutionalPlanDetailsNBDistrictMOPR,1);
			$scope.subTotalFundMOPRCFS=calculate_total_fund_other($scope.institutionalPlanDetailsCFStateMOPR,2);
			$scope.subTotalFundMOPRCFD=calculate_total_fund_other($scope.institutionalPlanDetailsCFDistrictMOPR,2);
			
			$scope.subTotalFundStateNBS=calculate_total_fund_other($scope.institutionalPlanDetailsNBState,1);
			$scope.subTotalFundStateNBD=calculate_total_fund_other($scope.institutionalPlanDetailsNBDistrict,1);
			$scope.subTotalFundStateCFS=calculate_total_fund_other($scope.institutionalPlanDetailsCFState,2);
			$scope.subTotalFundStateCFD=calculate_total_fund_other($scope.institutionalPlanDetailsCFDistrict,2);
			
			$scope.subTotalFundCECNBS=calculate_total_fund_other($scope.institutionalPlanDetailsNBStateCEC,1);
			$scope.subTotalFundCECNBD=calculate_total_fund_other($scope.institutionalPlanDetailsNBDistrictCEC,1);
			$scope.subTotalFundCECCFS=calculate_total_fund_other($scope.institutionalPlanDetailsCFStateCEC,2);
			$scope.subTotalFundCECCFD=calculate_total_fund_other($scope.institutionalPlanDetailsCFDistrictCEC,2);
			
			$scope.totalFundMOPRNBS=$scope.subTotalFundMOPRNBS+$scope.planstateAdditionalRequirementMOPR;
			$scope.totalFundMOPRNBD=$scope.subTotalFundMOPRNBD+$scope.plandistrictAdditionalRequirementMOPR;
			
			$scope.totalFundStateNBS=$scope.subTotalFundStateNBS+$scope.planstateAdditionalRequirementState;
			$scope.totalFundStateNBD=$scope.subTotalFundStateNBD+$scope.plandistrictAdditionalRequirementState;
			
			if($scope.institutionalInfraActivityPlan!=null){
				$scope.totalFundCECNBS=$scope.subTotalFundCECNBS+$scope.planstateAdditionalRequirementCEC;
				$scope.totalFundCECNBD=$scope.subTotalFundCECNBD+$scope.plandistrictAdditionalRequirementCEC;
					
				$scope.calculate_total_fund(1,null,null);
				$scope.calculate_total_fund(2,null,null);
				$scope.calculate_total_fund(3,null,null);
				$scope.calculate_total_fund(4,null,null);
			}else{
				$scope.planstateAdditionalRequirementCEC=null;
				$scope.plandistrictAdditionalRequirementCEC=null;
			}
			
		
			
			
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
	
	
	
	function calculate_total_fund_other(detailsList,type){
		if(type==1){
			var totalOfFunds = 0;
			for (var i = 0; i < detailsList.length; i++) {
				if(  detailsList[i].fundProposed!= null && detailsList[i].fundProposed!= undefined && detailsList[i].fundProposed!= ""){
					totalOfFunds = totalOfFunds + parseInt(detailsList[i].fundProposed);
				}
			}
			return totalOfFunds;
		}else{
			var totalReqFunds = 0;
			for (var i = 0; i < detailsList.length; i++) {
				if(  detailsList[i].fundRequired!= null && detailsList[i].fundRequired!= undefined && detailsList[i].fundRequired!= ""){
					totalReqFunds = totalReqFunds + parseInt(detailsList[i].fundRequired);
				}
			}
			return totalReqFunds;
		}
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
				for (var i = 0; i < $scope.institutionalPlanDetailsNBStateCEC.length; i++) {
					if(  $scope.institutionalPlanDetailsNBStateCEC[i].fundProposed!= null && $scope.institutionalPlanDetailsNBStateCEC[i].fundProposed!= undefined && $scope.institutionalPlanDetailsNBStateCEC[i].fundProposed!= ""){
						totalOfFunds = totalOfFunds + parseInt($scope.institutionalPlanDetailsNBStateCEC[i].fundProposed);
					}
				}
				
				if(index!=null && totalOfFunds>10000000){
					totalOfFunds=totalOfFunds-$scope.institutionalPlanDetailsNBStateCEC[index].fundProposed;
					$scope.institutionalPlanDetailsNBStateCEC[index].fundProposed=null;
					toastr.error("Fund proposed in case of SPRC should be less than or equal to 1 crore");
				}
				
			$scope.subTotalFundCECNBS = totalOfFunds;
			if($scope.planstateAdditionalRequirementCEC != null && $scope.planstateAdditionalRequirementCEC != undefined){
				addiReq=parseInt($scope.planstateAdditionalRequirementCEC);
			}
			if(addiReq>(totalOfFunds*25/100)){
				$scope.planstateAdditionalRequirementCEC=null;
				addiReq=0;
				toastr.error("Additional Requirement must be less then 25% of total Fund proposed");
			}
			$scope.totalFundCECNBS = parseInt($scope.subTotalFundCECNBS) + addiReq;
		}
		
		if(typeId==2){
			var totalOfFunds = 0;
			var totalOfFundsReq=0;
			var addiReq=0;
				for (var i = 0; i < $scope.institutionalPlanDetailsNBDistrictCEC.length; i++) {
					if(  $scope.institutionalPlanDetailsNBDistrictCEC[i].fundProposed!= null && $scope.institutionalPlanDetailsNBDistrictCEC[i].fundProposed!= undefined && $scope.institutionalPlanDetailsNBDistrictCEC[i].fundProposed!= ""){
						totalOfFunds = totalOfFunds + parseInt($scope.institutionalPlanDetailsNBDistrictCEC[i].fundProposed);
					}
				}
				
				if(index!=null && totalOfFunds>20000000){
					totalOfFunds=totalOfFunds-$scope.institutionalPlanDetailsNBDistrictCEC[index].fundProposed;
					$scope.institutionalPlanDetailsNBDistrictCEC[index].fundProposed=null;
					toastr.error("Fund proposed in case of DPRC should be less than or equal to 2 crore");
				}
			$scope.subTotalFundCECNBD = totalOfFunds;
			if($scope.plandistrictAdditionalRequirementCEC != null && $scope.plandistrictAdditionalRequirementCEC != undefined){
				addiReq=parseInt($scope.plandistrictAdditionalRequirementCEC);
			}
			
			if(addiReq>(totalOfFunds*25/100)){
				$scope.plandistrictAdditionalRequirementCEC=null;
				addiReq=0;
				toastr.error("Additional Requirement must be less then 25% of total Fund proposed");
			}
			$scope.grandTotalNBD = parseInt($scope.subTotalFundCECNBD) + addiReq;
		}	
		
		if(typeId==3){
			
			if(index!=null){
				var FREL=0,FUTI=0,FREQ=0,FSAN=0;
				var isError=false;
				if($scope.institutionalPlanDetailsCFStateCEC[index].fundSanctioned != null && $scope.institutionalPlanDetailsCFStateCEC[index].fundSanctioned != undefined){
						FSAN=parseInt($scope.institutionalPlanDetailsCFStateCEC[index].fundSanctioned);
				}
				if($scope.institutionalPlanDetailsCFStateCEC[index].fundReleased != null && $scope.institutionalPlanDetailsCFStateCEC[index].fundReleased!= undefined){
						FREL=parseInt($scope.institutionalPlanDetailsCFStateCEC[index].fundReleased);
				}
				if($scope.institutionalPlanDetailsCFStateCEC[index].fundUtilized != null && $scope.institutionalPlanDetailsCFStateCEC[index].fundUtilized != undefined){
						FUTI=parseInt($scope.institutionalPlanDetailsCFStateCEC[index].fundUtilized);
				}
					
					if(FREL>FSAN && id!='SAN'){
						toastr.error("Fund Sanctioned must be greater then Fund Released");
						isError=true;
					}else{
						if(id!='SAN'){
							if(FREL>FUTI){
								FREQ=FREL-FUTI;
								if(FSAN>FREQ){
									$scope.institutionalPlanDetailsCFStateCEC[index].fundRequired=FREQ;
									
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
							$scope.institutionalPlanDetailsCFStateCEC[index].fundRequired=null;
							$scope.institutionalPlanDetailsCFStateCEC[index].fundReleased=null;
							$scope.institutionalPlanDetailsCFStateCEC[index].fundUtilized=null;
						}
						
						
						}
				
					
					
					
					if(isError){
						if(id=='REL'){
							$scope.institutionalPlanDetailsCFStateCEC[index].fundReleased=null;
						}else if(id=='UTI')	{
							$scope.institutionalPlanDetailsCFStateCEC[index].fundUtilized=null;
						}else if(id=='SAN')	{
							$scope.institutionalPlanDetailsCFStateCEC[index].fundSanctioned=null;
						}
						$scope.institutionalPlanDetailsCFStateCEC[index].fundRequired=null;
					}
			}
			
				
				var totalOfFunds=0;
				for (var i = 0; i < $scope.institutionalPlanDetailsCFStateCEC.length; i++) {
					if(  $scope.institutionalPlanDetailsCFStateCEC[i].fundRequired!= null && $scope.institutionalPlanDetailsCFStateCEC[i].fundRequired!= undefined && $scope.institutionalPlanDetailsCFStateCEC[i].fundRequired!= ""){
						totalOfFunds = totalOfFunds + parseInt($scope.institutionalPlanDetailsCFStateCEC[i].fundRequired);
					}
				}
			$scope.subTotalFundCECCFS = totalOfFunds;
			
		}
		
		if(typeId==4){

			if(index!=null){
				var FREL=0,FUTI=0,FREQ=0,FSAN=0;
				var isError=false;
				if($scope.institutionalPlanDetailsCFDistrictCEC[index].fundSanctioned != null && $scope.institutionalPlanDetailsCFDistrictCEC[index].fundSanctioned != undefined){
						FSAN=parseInt($scope.institutionalPlanDetailsCFDistrictCEC[index].fundSanctioned);
				}
				if($scope.institutionalPlanDetailsCFDistrictCEC[index].fundReleased != null && $scope.institutionalPlanDetailsCFDistrictCEC[index].fundReleased!= undefined){
						FREL=parseInt($scope.institutionalPlanDetailsCFDistrictCEC[index].fundReleased);
				}
				if($scope.institutionalPlanDetailsCFDistrictCEC[index].fundUtilized != null && $scope.institutionalPlanDetailsCFDistrictCEC[index].fundUtilized != undefined){
						FUTI=parseInt($scope.institutionalPlanDetailsCFDistrictCEC[index].fundUtilized);
				}
					
					if(FREL>FSAN && id!='SAN'){
						toastr.error("Fund Sanctioned must be greater then Fund Released");
						isError=true;
					}else{
						if(id!='SAN'){
							if(FREL>FUTI){
								FREQ=FREL-FUTI;
								if(FSAN>FREQ){
									$scope.institutionalPlanDetailsCFDistrictCEC[index].fundRequired=FREQ;
									
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
							$scope.institutionalPlanDetailsCFDistrictCEC[index].fundRequired=null;
							$scope.institutionalPlanDetailsCFDistrictCEC[index].fundReleased=null;
							$scope.institutionalPlanDetailsCFDistrictCEC[index].fundUtilized=null;
						}
						
						
						}
				
					
					
					
					if(isError){
						if(id=='REL'){
							$scope.institutionalPlanDetailsCFDistrictCEC[index].fundReleased=null;
						}else if(id=='UTI')	{
							$scope.institutionalPlanDetailsCFDistrictCEC[index].fundUtilized=null;
						}else if(id=='SAN')	{
							$scope.institutionalPlanDetailsCFDistrictCEC[index].fundSanctioned=null;
						}
						$scope.institutionalPlanDetailsCFDistrictCEC[index].fundRequired=null;
					}
			}
			
			
				
				var totalOfFunds=0;
				for (var i = 0; i < $scope.institutionalPlanDetailsCFDistrictCEC.length; i++) {
					if(  $scope.institutionalPlanDetailsCFDistrictCEC[i].fundRequired!= null && $scope.institutionalPlanDetailsCFDistrictCEC[i].fundRequired!= undefined && $scope.institutionalPlanDetailsCFDistrictCEC[i].fundRequired!= ""){
						totalOfFunds = totalOfFunds + parseInt($scope.institutionalPlanDetailsCFDistrictCEC[i].fundRequired);
					}
				}
			$scope.subTotalFundCECCFD = totalOfFunds;
		}	
		
	}
	
	
	$scope.save_data=function(status){
		$scope.institutionalInfraActivityPlan={};
		$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails=[];
		index=0;
		$scope.institutionalInfraActivityPlan.additionalRequirement=$scope.planstateAdditionalRequirementCEC;
		$scope.institutionalInfraActivityPlan.additionalRequirementDPRC=$scope.plandistrictAdditionalRequirementCEC;
		for (var i = 0; i < $scope.institutionalPlanDetailsNBStateCEC.length; i++) { 
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index]=$scope.institutionalPlanDetailsNBStateCEC[i];
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].workType=$scope.institutionalPlanDetailsNBStateMOPR[i].workType;
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].institutionalInfraLocation=$scope.institutionalPlanDetailsNBStateMOPR[i].institutionalInfraLocation;
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].isactive=$scope.institutionalPlanDetailsNBStateMOPR[i].isactive;
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].trainingInstitueType=$scope.institutionalPlanDetailsNBStateMOPR[i].trainingInstitueType;
			index++;
		}
		
		for (var i = 0; i < $scope.institutionalPlanDetailsNBDistrictCEC.length; i++) { 
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index]=$scope.institutionalPlanDetailsNBDistrictCEC[i];
$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].workType=$scope.institutionalPlanDetailsNBDistrictMOPR[i].workType;
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].institutionalInfraLocation=$scope.institutionalPlanDetailsNBDistrictMOPR[i].institutionalInfraLocation;
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].isactive=$scope.institutionalPlanDetailsNBDistrictMOPR[i].isactive;
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].trainingInstitueType=$scope.institutionalPlanDetailsNBDistrictMOPR[i].trainingInstitueType;
			index++;
		}
		
		for (var i = 0; i < $scope.institutionalPlanDetailsCFStateCEC.length; i++) { 
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index]=$scope.institutionalPlanDetailsCFStateCEC[i];
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].workType=$scope.institutionalPlanDetailsCFStateMOPR[i].workType;
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].institutionalInfraLocation=$scope.institutionalPlanDetailsCFStateMOPR[i].institutionalInfraLocation;
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].isactive=$scope.institutionalPlanDetailsCFStateMOPR[i].isactive;
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].trainingInstitueType=$scope.institutionalPlanDetailsCFStateMOPR[i].trainingInstitueType;
			index++;
		}
		
		for (var i = 0; i < $scope.institutionalPlanDetailsCFDistrictCEC.length; i++) { 
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index]=$scope.institutionalPlanDetailsCFDistrictCEC[i];
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].workType=$scope.institutionalPlanDetailsCFDistrictMOPR[i].workType;
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].institutionalInfraLocation=$scope.institutionalPlanDetailsCFDistrictMOPR[i].institutionalInfraLocation;
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].isactive=$scope.institutionalPlanDetailsCFDistrictMOPR[i].isactive;
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].trainingInstitueType=$scope.institutionalPlanDetailsCFDistrictMOPR[i].trainingInstitueType;
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