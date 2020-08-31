

var trainingDetail=angular.module("publicModule",[]);

trainingDetail.controller("trainingDetailMoprController",['$scope','trainingDetailService',function($scope,trainingDetailService ){
	
	
	
	
	$scope.training={};
	$scope.training.trainingDetailList=[];
	$scope.trainingDetails={};
	
	$( document ).ready(function() {
		fetchOnLoad();
	});
	
	$scope.resetLoading=function(){
		fetchOnLoad();
	}
	
	function fetchOnLoad(){
		$scope.btn_disabled=false;
		trainingDetailService.fetchTrainingDetailsMOPRCEC().then(function(response){
			
			$scope.fetchTrainingDetailsListState=response.data.fetchTrainingDetailsListState;
			$scope.fetchTrainingState=response.data.fetchTrainingState
			$scope.fetchTrainingDetailsListMOPR=response.data.fetchTrainingDetailsListMOPR;
			$scope.fetchTrainingMOPR=response.data.fetchTrainingMOPR;
			$scope.training = $scope.fetchTrainingMOPR;	
			$scope.training.trainingDetailList = $scope.fetchTrainingDetailsListMOPR;
			$scope.statePreComments=response.data.STATE_PRE_COMMENTS;
			$scope.moprPreComments=response.data.MOPR_PRE_COMMENTS;
			if(!$scope.fetchTrainingDetailsListMOPR.length>0){
				$scope.training = $scope.fetchTrainingState;
				$scope.training.preTrainingActivityId=$scope.fetchTrainingState.trainingActivityId;
				$scope.training.trainingActivityId=null;
				$scope.training.trainingDetailList = $scope.fetchTrainingDetailsListState;
				for (var i = 0; i < $scope.training.trainingDetailList.length; i++) {
					$scope.training.trainingDetailList[i].preLevelTrainActivityId=$scope.training.trainingDetailList[i].trainingId;
					$scope.training.trainingDetailList[i].trainingId=null;
					$scope.training.trainingDetailList[i].trainingActivityId=null;
					
				}
			}
			calculateAllTrainingFunds();
			
		});
		
	}
	
	calculateAllTrainingFunds=function(){
		$scope.allTrainingFund=0;
		$scope.allNoOfParticipants=0;
		angular.forEach($scope.training.trainingDetailList,function(item){
				if(item.funds != null && item.funds != undefined){
				$scope.allTrainingFund=$scope.allTrainingFund+parseInt(item.funds);
				}
				if(item.noOfParticipants != null && item.noOfParticipants != undefined){
				$scope.allNoOfParticipants=$scope.allNoOfParticipants+parseInt(item.noOfParticipants);
				}
		});
		$scope.calculateMasterFund();
	}
	
	$scope.calculateMasterFund=function(){
		var additionalRequirement=0;
		if($scope.training.additionalRequirement != null && $scope.training.additionalRequirement != undefined){
			if($scope.training.additionalRequirement>($scope.allTrainingFund*.25)){
				$scope.training.additionalRequirement=0;
				toastr.error("Additional Requirement must be less then ("+$scope.allTrainingFund*.25+") 25% of total Fund proposed");
			}else{
				additionalRequirement=parseInt($scope.training.additionalRequirement);
			}
		}else{
			$scope.training.additionalRequirement=0;
		}
		$scope.masterFunds=$scope.allTrainingFund+additionalRequirement;
	}
	
	$scope.calculateFund=function(selObjType,index){
		var noOfDays=1;
		var noOfParticipants=1;
		var unitCost=1;
		var isUnitCost=false;
		var isError=false;	
			if($scope.training.trainingDetailList[index].noOfParticipants != null && $scope.training.trainingDetailList[index].noOfParticipants != undefined){
				noOfParticipants=$scope.training.trainingDetailList[index].noOfParticipants;
			}
			else{noOfParticipants=0;}
			if($scope.training.trainingDetailList[index].noOfDays != null && $scope.training.trainingDetailList[index].noOfDays != undefined){
				noOfDays=$scope.training.trainingDetailList[index].noOfDays;
			}
			else{noOfDays=0;}
			
			if($scope.training.trainingDetailList[index].unitCost != null && $scope.training.trainingDetailList[index].unitCost != undefined){
				unitCost=$scope.training.trainingDetailList[index].unitCost;
				isUnitCost=true;
			}
			else{unitCost=0;}
			//console.log(noOfParticipants+"    "+noOfDays+"   "+unitCost)
			if(isUnitCost){
				venueId=	parseInt($scope.training.trainingDetailList[index].trainingVenueLevelId);
				switch(venueId){
				case 1:limit= 1900;break;
				case 2:limit= 1100;break;
				case 3:limit= 800;break;
				}
				if(unitCost>limit){
					toastr.error("Upper ceiling  limit  Rs. "+limit+" unit cost according venue");
					$scope.training.trainingDetailList[index].unitCost=null;
					$scope.training.trainingDetailList[index].funds=null;
					isError=true;
				}
			}

			if(!isError){
				$scope.training.trainingDetailList[index].funds=noOfDays*noOfParticipants*unitCost;	
				
			}
			calculateAllTrainingFunds();
	}
	
	
	
	
	

	$scope.saveTrainingDetails=function(status){
			//if(validateData($scope.training.trainingDetailList)){
			$scope.btn_disabled=true;
				if(status=='F'){
					if($scope.allTrainingFund!=0 && $scope.allTrainingFund!=null && $scope.allTrainingFund!=undefined){
						$scope.training.isFreeze=true;
					}
					else{
						$scope.btn_disabled=false;
						
						toastr.error("Fund can not be 0 or blank");
					}
					
				}else {
					$scope.training.isFreeze=false;
					$scope.btn_disabled=true;
					$scope.fetchTrainingMOPR.isFreeze=false;
				}
			
				if($scope.allTrainingFund!=0 && $scope.allTrainingFund!=null && $scope.allTrainingFund!=undefined){
				trainingDetailService.savetrainingDetailMOPRCEC($scope.training).then(function(response){
			    	if(response!=null && response.status==200){
			    		if(status == 'F'){
		     				toastr.success("Freeze Sucessfully");
		     			}
			    		else if(status=='U')
			    			{
		     				toastr.success("Unfreeze Sucessfully");
			    			}
		     			else{
			     				toastr.success(response.data.responseMessage);
			     			}
			    		
			    	}else{
			    		toastr.error(response.data.responseMessage);
			    	}
			    	fetchOnLoad();
			    	
			    });
				}
				else
					{
					$scope.btn_disabled=false;
					$scope.training.isFreeze=false;
					toastr.error("Fund can not be 0 or blank");
					}
			//}
		}
	
validateData=function(trainingDetailsList){
	angular.forEach($scope.training.trainingDetailList,function(item){
		if(!(item.noOfParticipants!=null && item.noOfParticipants!=undefined)){
			toastr.error("Please enter No. of Participants");
			return false;
		}
		
		else if(!(item.noOfDays!=null && item.noOfDays!=undefined)){
			toastr.error("Please enter No. of noOfDays");
			return false;
		}
		
		else if(!(item.unitCost!=null && item.unitCost!=undefined)){
			toastr.error("Please enter No. of unitCost");
			return false;
		}
	});
		
	return true;
	}
	
	
}]);