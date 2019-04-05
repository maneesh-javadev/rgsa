var publicModule = angular.module("publicModule", []);
publicModule.controller("institutionalInfraActivityPlanController", [ '$scope', "institutionalInfraActivityPlanService",
		function($scope, institutionalInfraActivityPlanService) {
	
	
	$scope.institutionalInfraActivityPlan={};
	$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails=[];
	$scope.fullDetails=[];//contains details about sprc and dprc both
	$scope.stackOfPreviousRecord=[];
	$scope.secondStackOfPreviousRecord=[];
	$scope.trainingInstituteTypeId=0;
	$scope.flag=false;
	let total_fund=0;
	let total=0;//sprc+dprc
	fetchInstitutionalInfraActivityPlanData();
	
	function fetchInstitutionalInfraActivityPlanData(){
		institutionalInfraActivityPlanService.fetchTrainingInstituteType().then(function(response){
			$scope.trainingInstituteType = response.data.TrainingInstituteType;
			$scope.userType=response.data.userType;
			if($scope.userType == "C"){
				$scope.initial_status=response.data.initial_status;
				$scope.institutionalInfraActivityPlanState=response.data.institutionalInfraActivityPlanState;
				$scope.grandTotalState=calGrandTotalCEC($scope.institutionalInfraActivityPlanState.institutionalInfraActivityPlanDetails) + $scope.institutionalInfraActivityPlanState.additionalRequirement;
				$scope.institutionalInfraActivityPlanMopr=response.data.institutionalInfraActivityPlanMopr;
				$scope.grandTotalMopr=calGrandTotalCEC($scope.institutionalInfraActivityPlanMopr.institutionalInfraActivityPlanDetails);
				if(response.data.institutionalInfraActivityPlanCEC === undefined || response.data.institutionalInfraActivityPlanCEC === null){
					$scope.institutionalInfraActivityPlan = JSON.parse(JSON.stringify($scope.institutionalInfraActivityPlanState));
					for(let i =0;i<$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length ; i++){
						$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed='';
						$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].totalFund='';
					}
					$scope.institutionalInfraActivityPlan.additionalRequirement='';
					$scope.dataOfState=true;
				}else{
					$scope.dataOfState=false;
					$scope.institutionalInfraActivityPlan = response.data.institutionalInfraActivityPlanCEC;
					calGrandTotal();
				}
				
			}
		},function(error){
			
		});
	}
	
	function calGrandTotalCEC(object){
		let total=0;
		for(let i=0;i<object.length;i++){
			total += object[i].totalFund;
		}
		return total;
	}
	
	$scope.fetchDistricts=function(){
		institutionalInfraActivityPlanService.fetchDistrictListBasedOnState().then(function(response){
			$scope.districtList = response.data;
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[0].locationName=null;
			$scope.flag=false;
			
		},function(error){
			
		});
	};
	
	$scope.validateDistrictSelection=function(trainingInstituteTypeId){
		if(trainingInstituteTypeId==2 && $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[0].locationName.length == 1){
			$scope.generatedRows(trainingInstituteTypeId);
			$scope.flag=true;
		}else if(trainingInstituteTypeId == 4){
			$scope.generatedRows(trainingInstituteTypeId);
			$scope.flag=true;
		}
		else{
			$scope.flag=false;
			trainingInstituteTypeId == 2 ? toastr.error("Please select single district in case of SPRC.") : toastr.error("You selected district in wrong way.");
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[0].locationName = null;
			$scope.trainingInstituteTypeId=0;
		}
		$scope.calculationDependentField(trainingInstituteTypeId);
	};
	
	$scope.generatedRows=function(trainingInstituteTypeId){
		$scope.selectedDistrictlist=[];
		$scope.list=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[0].locationName;
		$scope.createSelectedDistrictList(trainingInstituteTypeId);
		if($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length > 0){
			$scope.stackOfPreviousRecord=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.slice();
		}
		institutionalInfraActivityPlanService.fetchDataBasedOnInstituteType(trainingInstituteTypeId).then(function(response){
			if(response.data.institutionalInfraActivityPlanDetails.length > 0){
				$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails=response.data.institutionalInfraActivityPlanDetails;
				$scope.addField(trainingInstituteTypeId);
				$scope.secondStackOfPreviousRecord=$scope.stackOfPreviousRecord.slice();
				$scope.stackOfPreviousRecord=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.slice();
				$scope.deleteIrreleventField();
				$scope.flag=true;
				/*$scope.calculationDependentField(trainingInstituteTypeId);*/
			}else{
				$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails=[];
				for(let i=0;i<$scope.selectedDistrictlist.length;i++){
					$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i]={
							institutionalInfraActivityDetailsId :null,
							fundProposed :'',
							totalFund :'',
							remarks :'',
							institutionalInfraLocation : $scope.selectedDistrictlist[i].districtCode,
							isApproved :false,
							districtName : $scope.selectedDistrictlist[i].districtName,
							workType :"N",
							locationName : $scope.list,
							trainingInstitueType :{
								trainingInstitueTypeId : $scope.trainingInstituteTypeId,
								trainingInstitueTypeName : $scope.selectedDistrictlist[i].instituteType,
							}
					}
				}
			}
		});
	}
	
	$scope.addField=function(trainingInstituteTypeId){
		for(let i=0;i<$scope.selectedDistrictlist.length;i++){
			let found=false;
			let detailId=0;
			for(let j =0;j<$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length;j++){
				detailId=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[j].institutionalInfraActivityDetailsId;
				$scope.selectedDistrictlist[i].districtCode == $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[j].institutionalInfraLocation ? found = true : found =false;
				if(found){
					$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[j].districtName=$scope.selectedDistrictlist[i].districtName;
					detailId=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[j].institutionalInfraActivityDetailsId;
					break;
				}
			}
			if(found==false){
				$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.splice(i,0,{institutionalInfraActivityDetailsId : null , fundProposed : '' , totalFund : '' , remarks :'', institutionalInfraLocation : '', isApproved :false, districtName : '', workType :"N", locationName : '', trainingInstitueType :{},});
				if(trainingInstituteTypeId==2){
					$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraActivityDetailsId=detailId;
				}
				$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraLocation=$scope.selectedDistrictlist[i].districtCode;
				$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].districtName=$scope.selectedDistrictlist[i].districtName;
				$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].trainingInstitueType.trainingInstitueTypeId= $scope.trainingInstituteTypeId;
				$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].trainingInstitueType.trainingInstitueTypeName=$scope.selectedDistrictlist[i].instituteType;
				$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].locationName= $scope.list;
			}
		}
	}
	
	$scope.deleteIrreleventField=function(){
		for(let i=0;i<$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length;i++){
			let found=false;
			for(let j=0;j<$scope.selectedDistrictlist.length;j++){
				 $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraLocation==$scope.selectedDistrictlist[j].districtCode ? found = true : found =false;
				if(found){
					$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].locationName=$scope.list;
					break;
				}
			}
			if(found==false){
				delete $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i];
			}
		}
		$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.filter(function(el){
			return el != null;
		});
	}
	
	$scope.createSelectedDistrictList=function(instituteType){
		if(instituteType == 2){
			for(var i = 0;i < $scope.list.length;i++){
				for(var j = 0;j<$scope.districtList.length;j++){
					if($scope.list[i] == $scope.districtList[j].districtCode){
						$scope.selectedDistrictlist[i] = {	"districtCode" : $scope.districtList[j].districtCode,
															"districtName" : $scope.districtList[j].districtNameEnglish,
															"instituteType" : "State Panchayat Resource Center(SPRC)",};
					}
				}
			}
		}else{
			for(var n = 0;n < $scope.list.length;n++){
				for(var m = 0;m<$scope.districtList.length;m++){
					if($scope.list[n] == $scope.districtList[m].districtCode){
						$scope.selectedDistrictlist[n] = {	"districtCode" : $scope.districtList[m].districtCode,
															"districtName" : $scope.districtList[m].districtNameEnglish,
															"instituteType" : "District Panchayat Resource Center(DPRC)",};
					}
				}
				
			}
		}
		
	};
	
	
	
	$scope.saveInstitutionalInfraActivityPlanDetails=function(trainingInstituteTypeId,updateStatus){
		let saveStatus=false;
		for(let i=0;i<$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length;i++){
			($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed !== "" && $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed != 0) ? saveStatus = true : saveStatus =false;
		}
		if(saveStatus){
			institutionalInfraActivityPlanService.saveInstitutionalInfraActivityPlanDetails($scope.institutionalInfraActivityPlan,trainingInstituteTypeId,$scope.updateStatus).then(function(response){
				$scope.institutionalInfraActivityPlan = response.data;
				$scope.fetchData($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[0].trainingInstitueType.trainingInstitueTypeId);
					toastr.success("Plan Saved Successfully");
			},function(error){
				toastr.error("Something went wrong");
			});	
		}else{
			toastr.error("Fund value should not be blank or zero.");
		}
		
	};
	
	$scope.saveCec=function(){
		let saveStatus=false;
		for(let i=0;i<$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length;i++){
			($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed !== "" && $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed != 0) ? saveStatus = true : saveStatus =false;
		}
		if(saveStatus){
			institutionalInfraActivityPlanService.saveCec($scope.institutionalInfraActivityPlan).then(function(response){
				$scope.institutionalInfraActivityPlan = response.data;
				fetchInstitutionalInfraActivityPlanData();
					toastr.success("Plan Saved Successfully");
			},function(error){
				toastr.error("Something went wrong");
			});	
		}else{
			toastr.error("Fund value should not be blank or zero.");
		}
	}
	
	$scope.calculationDependentField=function(trainingInstituteTypeId){
		total_fund=0;
		if(trainingInstituteTypeId == 2){
			if($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length > 0){
				for(let i=0;i<$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length;i++){
					if($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed != "" || $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed != undefined){
						if($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed > 10000000){
							$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed=0;
							$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].totalFund =$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed;
							toastr.error("Fund proposed in case of SPRC should be less than or equal to 1 crore");
						}else{
							$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].totalFund =$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed;
							total_fund=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].totalFund;
						}
					}
				}
			}
		}else{
			if($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length > 0){
				for(let i=0;i<$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length;i++){
					if($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed != "" || $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed != undefined){
						if($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed > 20000000){
							$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed=0;
							toastr.error("Fund proposed in case of DPRC should be less than or equal to 2 crore");
						}else{
							$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].totalFund =$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed;
							total_fund +=parseInt($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].totalFund);
						}
					}
				}
			}
		}
		
		// setting value of sub total
		$scope.subTotal=total_fund;
		$scope.calculateTotalProposedFund();
		
	};
	
	$scope.validateAdditionalRequirement=function(){
		if($scope.institutionalInfraActivityPlan.additionalRequirement !== ""){
			if($scope.institutionalInfraActivityPlan.additionalRequirement > 0.25 * total){
				$scope.institutionalInfraActivityPlan.additionalRequirement = '';
				toastr.error("Additional Requirement should be less than or equal to 25% of Total Fund of SPRC & DPRC =" + (0.25*total));
			}
		}
		if($scope.institutionalInfraActivityPlan.additionalRequirement === ""){
			$scope.totalFundAdditional=parseInt(total) + 0;
		}else{
		$scope.totalFundAdditional=parseInt(total)+ parseInt($scope.institutionalInfraActivityPlan.additionalRequirement);
		}
	};
	
	$scope.fetchData=function(trainingInstituteTypeId){
		institutionalInfraActivityPlanService.fetchDataBasedOnInstituteType(trainingInstituteTypeId).then(function(response){
			if(response.data.institutionalInfraActivityPlan != undefined && response.data.institutionalInfraActivityPlan != null){
				$scope.institutionalInfraActivityPlan=response.data.institutionalInfraActivityPlan;
				$scope.fullDetails=response.data.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails;//contains full data 
				$scope.updateStatus=response.data.update_Status;
				$scope.userType=response.data.userType;
				if(response.data.institutionalInfraActivityPlanDetails.length !== 0){
					$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails=response.data.institutionalInfraActivityPlanDetails;
					$scope.generatedRows(trainingInstituteTypeId);
				}else{
					$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails=response.data.institutionalInfraActivityPlanDetails;
					/*$scope.institutionalInfraActivityPlan.additionalRequirement='';*/
				}
				$scope.calculationDependentField(trainingInstituteTypeId);
				$scope.calculateTotalProposedFund();
			}else{
				$scope.updateStatus=response.data.update_Status;
			}
		},function(error){
			
		});
		
	};
	
	$scope.calculateTotalProposedFund=function(){
		total=0;
		let dprcAmount=0;
		let sprcAmount=0;
		for(let i=0;i<$scope.fullDetails.length;i++){
			total += $scope.fullDetails[i].fundProposed;
			if($scope.fullDetails[i].trainingInstitueType.trainingInstitueTypeId == 2){
				sprcAmount=$scope.fullDetails[i].fundProposed;
			}
		}
		
		dprcAmount = total-sprcAmount;
		if($scope.trainingInstituteTypeId == 2){
			total = total + (total_fund - sprcAmount);
		}else{
			total = total + (total_fund - dprcAmount);
		}
		
		if($scope.institutionalInfraActivityPlan.additionalRequirement !== ""){
			if($scope.institutionalInfraActivityPlan.additionalRequirement > (0.25 * total)){
				$scope.institutionalInfraActivityPlan.additionalRequirement = 0;
			}
		}
		
		$scope.totalFundAdditional=0;
		if($scope.institutionalInfraActivityPlan.additionalRequirement === ""){
			$scope.totalFundAdditional=parseInt(total_fund) + 0;
		}else{
			$scope.totalFundAdditional=parseInt(total)+ parseInt($scope.institutionalInfraActivityPlan.additionalRequirement);
		}
	}
	
	$scope.freezUnFreezInstitutionalInfraActivityPlan=function(freezUnfreez){
		if(freezUnfreez == 'freez'){
			$scope.institutionalInfraActivityPlan.isFreeze = true;
		}else{
			$scope.institutionalInfraActivityPlan.isFreeze = false;
		}
		institutionalInfraActivityPlanService.freezUnFreezInstitutionalInfraActivityPlan($scope.institutionalInfraActivityPlan).then(function(response){
			$scope.institutionalInfraActivityPlan = response.data;
			if($scope.userType == 'C'){
				fetchInstitutionalInfraActivityPlanData();
			}else{
			$scope.fetchData($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[0].trainingInstitueType.trainingInstitueTypeId);
			}
			if(freezUnfreez == 'freez'){
				toastr.success("Plan Freezed Successfully");
			}else{
				toastr.success("Plan UnFreezed Successfully");
			}
		},function(error){
			alert(error);
		});
	};
	
	$scope.onClearField = function(){
		
		for(let i=0;i<$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length;i++){
			$scope.institutionalInfraActivityPlan.additionalRequirement = 0;
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed='';
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].totalFund='';
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].remarks='';
			$scope.totalFundAdditional='';
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].locationName ='';
			$scope.subTotal='';
			
		}
		
	};
	
	$scope.calTotalsCec=function(index){
		if($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].trainingInstitueType.trainingInstitueTypeId ==2){
			if($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].fundProposed > 10000000){
				$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].fundProposed=0;
				toastr.error("Fund proposed in case of SPRC should be less than or equal to 1 crore");
			}else{
				$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].totalFund=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].fundProposed;
			}
		}else{
			if($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].fundProposed > 20000000){
				$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].fundProposed=0;
				toastr.error("Fund proposed in case of DPRC should be less than or equal to 2 crore");
			}else{
				$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].totalFund=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[index].fundProposed;
			}
		}
		calGrandTotal();
	}
	
	function calGrandTotal(){
		var grandTotal=0;
		for(let i=0;i<$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length;i++){
			if($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed === ""){
				grandTotal += 0 ;
			}else{
				grandTotal += +$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed;
			}
			
		}
		total=0;
		total = grandTotal;
		if($scope.institutionalInfraActivityPlan.additionalRequirement === ""){
			$scope.totalFundAdditional=parseInt(grandTotal) + 0;
		}else{
			$scope.totalFundAdditional=parseInt(grandTotal)+ parseInt($scope.institutionalInfraActivityPlan.additionalRequirement);
		}
	}
	
}]);