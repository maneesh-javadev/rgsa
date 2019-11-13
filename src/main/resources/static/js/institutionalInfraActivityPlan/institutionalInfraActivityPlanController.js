var publicModule = angular.module("publicModule", []);
publicModule.controller("institutionalInfraActivityPlanController", [ '$scope', "institutionalInfraActivityPlanService",
		function($scope, institutionalInfraActivityPlanService) {
	
	
	
	init();
	initialMsg();
	
	function initialMsg(){
		alert('Incase of SPRC you can fill only 1 section. It could be either New building or Carry forward.');
	};
	
	function init(){
		$scope.institutionalInfraActivityPlan={};
		$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails=[];
		//$scope.institutionalInfraActivityPlan.additionalRequirementNBS='';
		//$scope.institutionalInfraActivityPlan.additionalRequirementNBD='';
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
		$scope.stateSprcComments=[];
		$scope.stateDprcComments=[];
		$scope.moprSprcComments = [];
		$scope.moprDprcComments = [];
		
		institutionalInfraActivityPlanService.fetchDistrictListBasedOnState().then(function(response){
			$scope.districtList = response.data;
			$scope.districtListNewDprc = $scope.districtList;
			$scope.districtListCarryDprc = $scope.districtList;
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
		$scope.btn_disabled=false;
		$scope.nbsindex=0;
		$scope.nbdindex=0;
		$scope.cfsindex=0;
		$scope.cfdindex=0;
		
		institutionalInfraActivityPlanService.fetchInstitutionalInfraDataForStateAndMOPRNew().then(function(response){
			$scope.haveSprcNewRecord=false;
			$scope.haveDprcNewRecord=false;
			$scope.haveSprcCarryRecord=false;
			$scope.haveDprcCarryRecord=false;
			$scope.institutionalInfraActivityPlan=response.data;
			if($scope.institutionalInfraActivityPlan != '' && $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length > 0){
				$('#sprcCarryBlock').hide();
				$('#sprcNewBlock').hide();
				$('#newBuildingCheck').hide();
				$('#carryForwardCheck').hide();
			}
			if($scope.institutionalInfraActivityPlan!=null  && $scope.institutionalInfraActivityPlan!=""){
				$scope.stateSprcComments = $scope.institutionalInfraActivityPlan.detailsForStateSprcComments;
				$scope.stateDprcComments = $scope.institutionalInfraActivityPlan.detailsForStateDprcComments;
				$scope.moprSprcComments = $scope.institutionalInfraActivityPlan.detailsForMoprSprcComments;
				$scope.moprDprcComments = $scope.institutionalInfraActivityPlan.detailsForMoprDprcComments;
				$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails=response.data.institutionalInfraActivityPlanDetails;
				for (var i = 0; i < $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length; i++) { 
					workType=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].workType;
					trainingInstitueTypeId=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].trainingInstitueType.trainingInstitueTypeId;
					dlc=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraLocation;
					isactive=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].isactive;
					if(workType=='N' && trainingInstitueTypeId==2 && isactive==true){
						$scope.haveSprcNewRecord=true;
						$('#sprcNewBlock').show();
						$scope.institutionalInfraActivityPlanDetailsNBState[$scope.nbsindex]=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i];
						districtObj=find_district(dlc);
						nbsArr.push(dlc);
						$scope.institutionalInfraActivityPlanDetailsNBState[$scope.nbsindex].districtName=districtObj.districtNameEnglish;
						$scope.nbsindex++;
					}else if(workType=='N' && trainingInstitueTypeId==4 && isactive==true){
						$scope.haveDprcNewRecord=true;
						$scope.institutionalInfraActivityPlanDetailsNBDistrict[$scope.nbdindex]=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i];
						districtObj=find_district(dlc);
						nbdArr.push(dlc.toString());
						$scope.institutionalInfraActivityPlanDetailsNBDistrict[$scope.nbdindex].districtName=districtObj.districtNameEnglish;
						
						/*nbdistrictArr.set("fundProposed_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed);
						nbdistrictArr.set("remarks_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].remarks);
						nbdistrictArr.set("institutionalInfraActivityDetailsId"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraActivityDetailsId);*/
						
						$scope.nbdindex++;
					}else if(workType=='C' && trainingInstitueTypeId==2 && isactive==true){
						$scope.haveSprcCarryRecord=true;
						$('#sprcCarryBlock').show();
						$scope.institutionalInfraActivityPlanDetailsCFState[$scope.cfsindex]=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i];
						districtObj=find_district(dlc);
						cfsArr.push(dlc);
						$scope.institutionalInfraActivityPlanDetailsCFState[$scope.cfsindex].districtName=districtObj.districtNameEnglish;
						$scope.cfsindex++;
					}else if(workType=='C' && trainingInstitueTypeId==4 && isactive==true){
						$scope.haveDprcCarryRecord=true;
						$scope.institutionalInfraActivityPlanDetailsCFDistrict[$scope.cfdindex]=$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i];
						districtObj=find_district(dlc);
						cfdArr.push(dlc.toString());
						$scope.institutionalInfraActivityPlanDetailsCFDistrict[$scope.cfdindex].districtName=districtObj.districtNameEnglish;
						
						/*cfdistrictArr.set("fundSanctioned_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundSanctioned);
						cfdistrictArr.set("fundReleased_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundReleased);
						cfdistrictArr.set("fundUtilized_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundUtilized);
						cfdistrictArr.set("fundRequired_"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundRequired);
						cfdistrictArr.set("institutionalInfraActivityDetailsId"+dlc,$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].institutionalInfraActivityDetailsId);*/
						
						$scope.cfdindex++;
					}
					
					
				}
				
				if($scope.haveSprcNewRecord){
					$scope.institutionalInfraActivityPlan.additionalRequirementNBS=$scope.institutionalInfraActivityPlan.additionalRequirement;
					if(nbsArr.length>0){
						$scope.sprcDistrictNB=nbsArr.toString();
					}
				}else{
					$scope.sprcDistrictNB='';
					$scope.institutionalInfraActivityPlan.additionalRequirementNBS='';
				}
				
				if(!$scope.haveDprcNewRecord){
					$scope.institutionalInfraActivityPlan.additionalRequirementNBD='';
					$scope.dprcDistrictNB=[];
				}else{
					$scope.institutionalInfraActivityPlan.additionalRequirementNBD=$scope.institutionalInfraActivityPlan.additionalRequirementDPRC;
					if(nbdArr.length>0){
						$scope.dprcDistrictNB=nbdArr;
					}
				}
				
				if($scope.haveSprcCarryRecord){
					if(cfsArr.length>0){
						$scope.sprcDistrictCF=cfsArr.toString() ;
					}
				}else{
					$scope.sprcDistrictCF='';
				}
				
				if($scope.haveDprcCarryRecord){
					if(cfdArr.length>0){
						$scope.dprcDistrictCF=cfdArr;
					}
				}else{
					$scope.dprcDistrictCF=[];
				}
				
				if(!$scope.haveSprcNewRecord && !$scope.haveSprcCarryRecord){
					$('#sprcCarryBlock').show();
					$('#sprcNewBlock').show();
				}
				
				$scope.manageDprcDistrictListInNewAndCarry('N');
				$scope.manageDprcDistrictListInNewAndCarry('C');
				$scope.calculate_total_fund(1,null,null);
				$scope.calculate_total_fund(2,null,null);
				$scope.calculate_total_fund(3,null,null);
				$scope.calculate_total_fund(4,null,null);
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
	
	$scope.add_row_nb=function(trainingType){
		
	 if(trainingType==2){
		 	$scope.institutionalInfraActivityPlanDetailsNBState=[];
		 	$scope.calculate_total_fund(1,null,null);
		 	/*if($scope.nbsindex!=null && $scope.nbsindex!=undefined){
			   $scope.nbsindex=$scope.nbsindex+1;
		 	}else{
				  $scope.nbsindex=0;
		 	}*/
		 
		 create_state_row_NB($scope.nbsindex,'State Panchayat Resource Center(SPRC)',2);
	 }else if(trainingType==4){
		 /*if($scope.nbdindex!=null && $scope.nbdindex!=undefined){
			   $scope.nbdindex=$scope.nbdindex+1;
		 	}else{
				  $scope.nbdindex=0;
		 	}*/
		 	
		 	
		 	$scope.calculate_total_fund(2,null,null);
		 create_district_row_NB($scope.nbdindex,'District Panchayat Resource Center(DPRC)',4);
	 }
			
	}
	
	
	
	function create_state_row_NB(rindex,name,id){
		
		
		//clear_new_building(2);
		//clear_carry_froward(2);
		
		rindex=0;
		angular.forEach($scope.districtList,function(item){
		  	if(item.districtCode == $scope.sprcDistrictNB){
		  		$scope.currentObject = item;
		  	}
		  })
		
		create_new_building_state_object(rindex,name,id,$scope.currentObject);
		//create_carry_froward_object(rindex,name,id,$scope.currentObject);
		$scope.rindex=(--rindex);
	}
	
	function create_district_row_NB(rindex,name,id){
		
		for (var i = 0; i < $scope.institutionalInfraActivityPlanDetailsNBDistrict.length; i++) { 
			nbdistrictArr.set("fundProposed_"+$scope.institutionalInfraActivityPlanDetailsNBDistrict[i].institutionalInfraLocation,$scope.institutionalInfraActivityPlanDetailsNBDistrict[i].fundProposed);
			nbdistrictArr.set("remarks_"+$scope.institutionalInfraActivityPlanDetailsNBDistrict[i].institutionalInfraLocation,$scope.institutionalInfraActivityPlanDetailsNBDistrict[i].remarks);
			nbdistrictArr.set("institutionalInfraActivityDetailsId_"+$scope.institutionalInfraActivityPlanDetailsNBDistrict[i].institutionalInfraLocation,$scope.institutionalInfraActivityPlanDetailsNBDistrict[i].institutionalInfraActivityDetailsId);
		}
		
		
		$scope.institutionalInfraActivityPlanDetailsNBDistrict=[];
		//clear_new_building(4);
		//clear_carry_froward(4);
		rindex=0;
		angular.forEach($scope.districtList,function(item){
			fundProposed='';
			remarks='';
			institutionalInfraActivityDetailsId=null;
		  	if($scope.dprcDistrictNB.includes(item.districtCode.toString())){
		  		if(nbdistrictArr.has("fundProposed_"+item.districtCode)){
		  			fundProposed=nbdistrictArr.get("fundProposed_"+item.districtCode)
		  		}
		  		if(nbdistrictArr.has("remarks_"+item.districtCode)){
		  			remarks=nbdistrictArr.get("remarks_"+item.districtCode)
		  		}
		  		
		  		if(nbdistrictArr.has("institutionalInfraActivityDetailsId_"+item.districtCode)){
		  			institutionalInfraActivityDetailsId=nbdistrictArr.get("institutionalInfraActivityDetailsId_"+item.districtCode);
		  		}
		  		create_new_building_district_object(rindex,name,id,item,fundProposed,remarks,institutionalInfraActivityDetailsId);
		  		
		  		//create_carry_froward_object(rindex,name,id,item);
				rindex++;
		  	}else{
		  		
		  	}
		  });
		$scope.calculate_total_fund(2,null,null,null)
		$scope.rindex=(--rindex);
		
		}
	
	
	function create_new_building_state_object(rindex,name,id,object)
	{
			$scope.institutionalInfraActivityPlanDetailsNBState[rindex]={
				institutionalInfraActivityDetailsId :null,
				fundProposed :'',
				totalFund :'',
				remarks :'',
				institutionalInfraLocation : object.districtCode,
				isApproved :false,
				districtName : object.districtNameEnglish,
				workType :"N",
				locationName : $scope.list,
				fundSanctioned:'',
				fundReleased:'',
				fundUtilized:'',
				fundRequired:'',
				trainingInstitueType :{
					trainingInstitueTypeId : id,
					trainingInstitueTypeName : name,
				}
		}
	}
	
	function create_new_building_district_object(rindex,name,id,object,fundProposed,remarks,institutionalInfraActivityDetailsId)
	{
			$scope.institutionalInfraActivityPlanDetailsNBDistrict[rindex]={
				institutionalInfraActivityDetailsId :institutionalInfraActivityDetailsId,
				fundProposed :fundProposed,
				totalFund :'',
				remarks :remarks,
				institutionalInfraLocation : object.districtCode,
				isApproved :false,
				districtName : object.districtNameEnglish,
				workType :"N",
				locationName : $scope.list,
				fundSanctioned:'',
				fundReleased:'',
				fundUtilized:'',
				fundRequired:'',
				trainingInstitueType :{
					trainingInstitueTypeId : id,
					trainingInstitueTypeName : name,
				}
		}
	}
	
	
	$scope.add_row_cf=function(trainingType){
		
	 if(trainingType==2){
		 $scope.institutionalInfraActivityPlanDetailsCFState=[];
		 
		/* if($scope.cfsindex!=null && $scope.cfsindex!=undefined){
			   $scope.cfsindex=$scope.cfsindex+1;
		 	}else{
				  $scope.cfsindex=0;
		 	}*/
		 create_state_row_CF(0,'State Panchayat Resource Center(SPRC)',2);
	 }else if(trainingType==4){
		
		 
		 create_district_row_CF($scope.cfdindex,'District Panchayat Resource Center(DPRC)',4);
	 }
			
	}
	
	
function create_state_row_CF(rindex,name,id){
		
		
		//clear_new_building(2);
		//clear_carry_froward(2);
		angular.forEach($scope.districtList,function(item){
		  	if(item.districtCode == $scope.sprcDistrictCF){
		  		$scope.currentObject = item;
		  	}
		  })
		  
		  $scope.institutionalInfraActivityPlanDetailsCFState=[];
		
		create_carry_froward_state_object(0,name,id,$scope.currentObject);
		//create_carry_froward_object(rindex,name,id,$scope.currentObject);
		$scope.rindex=(--rindex);
	}
	
	function create_district_row_CF(rindex,name,id){
		
		
		for (var i = 0; i < $scope.institutionalInfraActivityPlanDetailsCFDistrict.length; i++) { 
			cfdistrictArr.set("fundSanctioned_"+$scope.institutionalInfraActivityPlanDetailsCFDistrict[i].institutionalInfraLocation,$scope.institutionalInfraActivityPlanDetailsCFDistrict[i].fundSanctioned);
			cfdistrictArr.set("fundReleased_"+$scope.institutionalInfraActivityPlanDetailsCFDistrict[i].institutionalInfraLocation,$scope.institutionalInfraActivityPlanDetailsCFDistrict[i].fundReleased);
			cfdistrictArr.set("fundUtilized_"+$scope.institutionalInfraActivityPlanDetailsCFDistrict[i].institutionalInfraLocation,$scope.institutionalInfraActivityPlanDetailsCFDistrict[i].fundUtilized);
			cfdistrictArr.set("fundRequired_"+$scope.institutionalInfraActivityPlanDetailsCFDistrict[i].institutionalInfraLocation,$scope.institutionalInfraActivityPlanDetailsCFDistrict[i].fundRequired);
			cfdistrictArr.set("institutionalInfraActivityDetailsId_"+$scope.institutionalInfraActivityPlanDetailsCFDistrict[i].institutionalInfraLocation,$scope.institutionalInfraActivityPlanDetailsCFDistrict[i].institutionalInfraActivityDetailsId);
		}
		
		$scope.institutionalInfraActivityPlanDetailsCFDistrict=[];
		rindex=0;
		//clear_new_building(4);
		//clear_carry_froward(4);
		angular.forEach($scope.districtList,function(item){
		  	if($scope.dprcDistrictCF.includes(item.districtCode.toString())){
		  		fundSanctioned='';
		  		fundReleased='';
		  		fundUtilized='';
		  		fundRequired='';
		  		institutionalInfraActivityDetailsId=null;
		  		if(cfdistrictArr.has("fundSanctioned_"+item.districtCode)){
		  			fundSanctioned=cfdistrictArr.get("fundSanctioned_"+item.districtCode)
		  		}
		  		if(cfdistrictArr.has("fundReleased_"+item.districtCode)){
		  			fundReleased=cfdistrictArr.get("fundReleased_"+item.districtCode)
		  		}
		  		if(cfdistrictArr.has("fundUtilized_"+item.districtCode)){
		  			fundUtilized=cfdistrictArr.get("fundUtilized_"+item.districtCode)
		  		}
		  		if(cfdistrictArr.has("fundRequired_"+item.districtCode)){
		  			fundRequired=cfdistrictArr.get("fundRequired_"+item.districtCode)
		  		}
		  		
		  		if(cfdistrictArr.has("institutionalInfraActivityDetailsId_"+item.districtCode)){
		  			institutionalInfraActivityDetailsId=cfdistrictArr.get("institutionalInfraActivityDetailsId_"+item.districtCode)
		  		}
		  		
		  		create_carry_froward_district_object(rindex,name,id,item,fundSanctioned,fundReleased,fundUtilized,fundRequired,institutionalInfraActivityDetailsId);
		  		//create_carry_froward_object(rindex,name,id,item);
				rindex++;
		  	}
		  });
		$scope.calculate_total_fund(4,null,null,null)
		$scope.rindex=(--rindex);
		
		}
	
	
	function create_carry_froward_state_object(rindex,name,id,object)
	{
			$scope.institutionalInfraActivityPlanDetailsCFState[rindex]={
				institutionalInfraActivityDetailsId :null,
				fundProposed :'',
				totalFund :'',
				remarks :'',
				institutionalInfraLocation : object.districtCode,
				isApproved :false,
				districtName : object.districtNameEnglish,
				workType :"C",
				locationName : $scope.list,
				fundSanctioned:'',
				fundReleased:'',
				fundUtilized:'',
				fundRequired:'',
				isactive:true,
				trainingInstitueType :{
					trainingInstitueTypeId : id,
					trainingInstitueTypeName : name,
				}
		}
	}
	
	function create_carry_froward_district_object(rindex,name,id,object,fundSanctioned,fundReleased,fundUtilized,fundRequired,institutionalInfraActivityDetailsId)
	{
			$scope.institutionalInfraActivityPlanDetailsCFDistrict[rindex]={
				institutionalInfraActivityDetailsId :institutionalInfraActivityDetailsId,
				fundProposed :'',
				totalFund :'',
				remarks :'',
				institutionalInfraLocation : object.districtCode,
				isApproved :false,
				districtName : object.districtNameEnglish,
				workType :"C",
				locationName : $scope.list,
				fundSanctioned:fundSanctioned,
				fundReleased:fundReleased,
				fundUtilized:fundUtilized,
				fundRequired:fundRequired,
				trainingInstitueType :{
					trainingInstitueTypeId : id,
					trainingInstitueTypeName : name,
				}
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
				toastr.error("Additional Requirement must be less then("+(totalOfFunds*25/100)+") 25% of total Fund proposed");
			}
			$scope.grandTotalNBS = parseInt($scope.totalWithoutAddRequirementsNBS) + addiReq;
		}
		
		if(typeId==2){
			var totalOfFunds = 0;
			var totalOfFundsReq=0;
			//var totalDistrictSelected = $scope.dprcDistrictNB.length;
			var addiReq=0;
				for (var i = 0; i < $scope.institutionalInfraActivityPlanDetailsNBDistrict.length; i++) {
					if(  $scope.institutionalInfraActivityPlanDetailsNBDistrict[i].fundProposed!= null && $scope.institutionalInfraActivityPlanDetailsNBDistrict[i].fundProposed!= undefined && $scope.institutionalInfraActivityPlanDetailsNBDistrict[i].fundProposed!= ""){
						totalOfFunds = totalOfFunds + parseInt($scope.institutionalInfraActivityPlanDetailsNBDistrict[i].fundProposed);
					}
				}
				
				/*if(index!=null && totalOfFunds>20000000 * totalDistrictSelected){
					totalOfFunds=totalOfFunds-$scope.institutionalInfraActivityPlanDetailsNBDistrict[index].fundProposed;
					$scope.institutionalInfraActivityPlanDetailsNBDistrict[index].fundProposed=null;
					toastr.error("Fund proposed in case of DPRC should be less than or equal to " + (20000000 * totalDistrictSelected));
				}*/
				
				if(index!=null && $scope.institutionalInfraActivityPlanDetailsNBDistrict[index].fundProposed > 20000000){
					totalOfFunds=totalOfFunds-$scope.institutionalInfraActivityPlanDetailsNBDistrict[index].fundProposed;
					$scope.institutionalInfraActivityPlanDetailsNBDistrict[index].fundProposed=null;
					toastr.error("Fund proposed for single DPRC should be less than or equal to 20000000");
				}
			$scope.totalWithoutAddRequirementsNBD = totalOfFunds;
			if($scope.institutionalInfraActivityPlan.additionalRequirementNBD != null && $scope.institutionalInfraActivityPlan.additionalRequirementNBD != undefined){
				addiReq=parseInt($scope.institutionalInfraActivityPlan.additionalRequirementNBD);
			}
			
			if(addiReq>(totalOfFunds*25/100)){
				$scope.institutionalInfraActivityPlan.additionalRequirementNBD=null;
				addiReq=0;
				toastr.error("Additional Requirement must be less then("+(totalOfFunds*25/100)+") 25% of total Fund proposed");
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
						FUTI=+$scope.institutionalInfraActivityPlanDetailsCFState[index].fundUtilized;
				}
					
					if(FREL>FSAN && id!='SAN'){
						toastr.error("Fund Sanctioned must be greater then Fund Released");
						isError=true;
					}else{
						if(id!='SAN'){
							if(FSAN>=FREL){
								FREQ=FSAN-FREL;
								if(FSAN>=FREQ ){
									$scope.institutionalInfraActivityPlanDetailsCFState[index].fundRequired=FREQ;
									
								}
								else{
									toastr.error("Fund Required must be less then Fund Sanctioned");
									isError=true;
								}
								
								if(FSAN<FUTI){
									toastr.error("Fund Utilize must be less then Fund Sanctioned ");
									isError=true;
								}
								
							}else{
								toastr.error("Fund Released must not be greater then Fund Sanctioned");
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
						if(FSAN>=FREL){
							FREQ=FSAN-FREL;
							if(FSAN>=FREQ ){
								$scope.institutionalInfraActivityPlanDetailsCFDistrict[index].fundRequired=FREQ;
								
							}
							else{
								toastr.error("Fund Required must be less then Fund Sanctioned");
								isError=true;
							}
							
							if(FSAN<FUTI){
								toastr.error("Fund Utilize must be less then Fund Sanctioned");
								isError=true;
							}
							
						}else{
							toastr.error("Fund Released must be greater then Fund Sanctioned");
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
		var totalNBS=$scope.grandTotalNBS!=null && $scope.grandTotalNBS!=undefined?$scope.grandTotalNBS:0;
		var totalNBD=$scope.grandTotalNBD!=null && $scope.grandTotalNBD!=undefined?$scope.grandTotalNBD:0;
		var totalCFS=$scope.totalWithoutAddRequirementsCFS!=null && $scope.totalWithoutAddRequirementsCFS!=undefined?$scope.totalWithoutAddRequirementsCFS:0;
		var totalCFD=$scope.totalWithoutAddRequirementsCFD!=null && $scope.totalWithoutAddRequirementsCFD!=undefined?$scope.totalWithoutAddRequirementsCFD:0;
		
		$scope.grandTotal = +((!Number.isNaN(totalNBS )) ? totalNBS : 0) + +((!Number.isNaN(totalNBD )) ? totalNBD : 0) + +((!Number.isNaN(totalCFS )) ? totalCFS : 0) + +((!Number.isNaN(totalCFD )) ? totalCFD : 0);
		
	}
	
	
	$scope.save_data=function(status){
		$scope.btn_disabled=true;
		
		if($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails == undefined){
			$scope.institutionalInfraActivityPlan = {
					institutionalInfraActivityPlanDetails : []
			};
		}
		index=0;
		if($scope.institutionalInfraActivityPlan.additionalRequirementNBS != undefined){
			$scope.institutionalInfraActivityPlan.additionalRequirement=$scope.institutionalInfraActivityPlan.additionalRequirementNBS;
		}
		if($scope.institutionalInfraActivityPlan.additionalRequirementNBD != undefined){
			$scope.institutionalInfraActivityPlan.additionalRequirementDPRC=$scope.institutionalInfraActivityPlan.additionalRequirementNBD;
		}
		
		for (var i = 0; i < $scope.institutionalInfraActivityPlanDetailsNBState.length; i++) { 
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.push($scope.institutionalInfraActivityPlanDetailsNBState[i]);
			index++;
		}
		
		for (var i = 0; i < $scope.institutionalInfraActivityPlanDetailsNBDistrict.length; i++) { 
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.push($scope.institutionalInfraActivityPlanDetailsNBDistrict[i]);
			index++;
		}
		
		for (var i = 0; i < $scope.institutionalInfraActivityPlanDetailsCFState.length; i++) { 
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.push($scope.institutionalInfraActivityPlanDetailsCFState[i]);
			index++;
		}
		
		for (var i = 0; i < $scope.institutionalInfraActivityPlanDetailsCFDistrict.length; i++) { 
			$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.push($scope.institutionalInfraActivityPlanDetailsCFDistrict[i]);
			index++;
		}
		
		/*var  saveStatus =false;
		if($scope.institutionalInfraActivityPlan!=null && $scope.institutionalInfraActivityPlan!=""){
			for(let i=0;i<$scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails.length;i++){
				(($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed !== "" && $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundProposed != 0)
				|| ($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundRequired!== "" && $scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[i].fundRequired != 0)) 
				? saveStatus = true : saveStatus =false;
			}
		}*/
		
		/*if(saveStatus){*/
			$scope.institutionalInfraActivityPlan.isFreeze=false;
			if(status=='F'){
				$scope.institutionalInfraActivityPlan.isFreeze=true;
			}
			institutionalInfraActivityPlanService.saveInstitutionalInfraActivityPlanDetails($scope.institutionalInfraActivityPlan,$scope.updateStatus).then(function(response){
				//$scope.institutionalInfraActivityPlan = response.data;
				//$scope.fetchData($scope.institutionalInfraActivityPlan.institutionalInfraActivityPlanDetails[0].trainingInstitueType.trainingInstitueTypeId);
					toastr.success("Plan Saved Successfully");
					init();
			},function(error){
				toastr.error("Something went wrong");
			});
		/*}else{
			toastr.error("Fund value should not be blank or zero.");
			init();
		}*/
	}
	
	 $scope.hideSectionsInSprc=function(section){
		if(section == 'new'){
			if($scope.institutionalInfraActivityPlanDetailsCFState.length > 0){
				$scope.grandTotal -= $scope.institutionalInfraActivityPlanDetailsCFState[0].fundRequired;
				$scope.institutionalInfraActivityPlanDetailsCFState.pop();
			}
			$('#sprcCarryBlock').hide();
			$('#sprcNewBlock').show();
			$('#newBuildingCheck').show();
			$('#checkboxCarry').attr("checked", false);
		}else{
			if($scope.institutionalInfraActivityPlanDetailsNBState.length > 0){
				$scope.grandTotal -= (+$scope.institutionalInfraActivityPlanDetailsNBState[0].fundProposed + +$scope.institutionalInfraActivityPlan.additionalRequirementNBS)
				$scope.institutionalInfraActivityPlanDetailsNBState.pop();
				$scope.institutionalInfraActivityPlan.additionalRequirementNBS='';
				$scope.grandTotalNBS = '';
			}
			
			$('#sprcNewBlock').hide();
			$('#sprcCarryBlock').show();
			$('#carryForwardCheck').show();
			$('#checkboxNew').attr("checked", false);
		}
	}
	 
	 
	$scope.deleteRecord = function(detailId) {
		institutionalInfraActivityPlanService.deleteRecord(detailId).then(function(response){
				toastr.success("Record deleted");
				init();
		},function(error){
			toastr.error("Something went wrong");
		});
	}
	
	$scope.manageDprcDistrictListInNewAndCarry=function(msg){
		if(msg=='N'){
			if($scope.institutionalInfraActivityPlanDetailsNBDistrict.length > 0){
				var newDistList=[];
				for(key in $scope.institutionalInfraActivityPlanDetailsNBDistrict){
						newDistList.push($scope.institutionalInfraActivityPlanDetailsNBDistrict[key].institutionalInfraLocation);
				}
				$scope.districtListCarryDprc = generateNewDistrictList($scope.districtListCarryDprc,newDistList);
			}
		}else{
			if($scope.institutionalInfraActivityPlanDetailsCFDistrict.length > 0){
				var carryDistList=[];
				for(key in $scope.institutionalInfraActivityPlanDetailsCFDistrict){
						carryDistList.push($scope.institutionalInfraActivityPlanDetailsCFDistrict[key].institutionalInfraLocation);
				}
				$scope.districtListNewDprc = generateNewDistrictList($scope.districtListNewDprc,carryDistList);;
			}
		}
	}
	
	function generateNewDistrictList(originalDistrictList , selectedOppositeDistricts){
		var carryList=originalDistrictList;
		originalDistrictList=[];
		for(key in carryList){
			var status = false;
			for(index in selectedOppositeDistricts){
				if(carryList[key].districtCode == selectedOppositeDistricts[index]){
					status = true;
				}
			}
			if(!status)
				originalDistrictList.push(carryList[key]); 
		}
		return originalDistrictList;
	}
}]);