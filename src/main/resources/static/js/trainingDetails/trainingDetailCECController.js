

var trainingDetail=angular.module("publicModule",[]);

trainingDetail.controller("trainingDetailMoprController",['$scope','trainingDetailService',function($scope,trainingDetailService ){
	
	
	$scope.training={};
	$scope.training.trainingDetailList=[];
	$scope.trainingDetails={};
	
	$(document).ready(function() {
		fetchOnLoad();
      });
	
	function fetchOnLoad(){
		$scope.btn_disabled=false;
		trainingDetailService.fetchTrainingDetailsMOPRCEC().then(function(response){
			
			$scope.fetchTrainingDetailsListState=response.data.fetchTrainingDetailsListState;
			$scope.fetchTrainingState=response.data.fetchTrainingState;
			$scope.fetchTrainingDetailsListMOPR=response.data.fetchTrainingDetailsListMOPR;
			$scope.fetchTrainingMOPR=response.data.fetchTrainingMOPR;
			$scope.fetchTrainingDetailsListCEC=response.data.fetchTrainingDetailsListCEC;
			$scope.fetchTrainingCEC=response.data.fetchTrainingCEC
			$scope.training = $scope.fetchTrainingCEC;	
			$scope.training.trainingDetailList = $scope.fetchTrainingDetailsListCEC;
			if(!$scope.fetchTrainingDetailsListCEC.length>0){
				
				$scope.training.preTrainingActivityId=$scope.fetchTrainingState.trainingActivityId;
			
				
			}
			calculateAllTrainingFunds();
			calculateAllTrainingFundsMOPR();
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
	
	calculateAllTrainingFundsMOPR=function(){
		
		$scope.allTrainingFundMOPR=0;
		$scope.allNoOfParticipantsMOPR=0;
		angular.forEach($scope.fetchTrainingDetailsListMOPR,function(item){
			$scope.allTrainingFundMOPR=$scope.allTrainingFundMOPR+parseInt(item.funds);
			$scope.allNoOfParticipantsMOPR=$scope.allNoOfParticipantsMOPR+parseInt(item.noOfParticipants);
		});
		$scope.masterFundsMOPR=$scope.allTrainingFundMOPR+ parseInt($scope.fetchTrainingMOPR.additionalRequirement);
		
		$scope.allTrainingFundState=0;
		$scope.allNoOfParticipantsState=0;
		
		angular.forEach($scope.fetchTrainingDetailsListState,function(item){
			$scope.allTrainingFundState=$scope.allTrainingFundState+parseInt(item.funds);
			$scope.allNoOfParticipantsState=$scope.allNoOfParticipantsState+parseInt(item.noOfParticipants);
		});
		
		$scope.masterFundsState=$scope.allNoOfParticipantsState+ parseInt($scope.fetchTrainingState.additionalRequirement);
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
			if($scope.training.trainingDetailList[index].noOfDays != null && $scope.training.trainingDetailList[index].noOfDays != undefined){
				noOfDays=$scope.training.trainingDetailList[index].noOfDays;
				
			}
			
			if($scope.training.trainingDetailList[index].unitCost != null && $scope.training.trainingDetailList[index].unitCost != undefined){
				unitCost=$scope.training.trainingDetailList[index].unitCost;
				isUnitCost=true;
			}
			
			if(isUnitCost){
				venueId=parseInt($scope.fetchTrainingDetailsListMOPR[index].trainingVenueLevelId);
				/*venueId=parseInt($scope.fetchTrainingDetailsListState[index].trainingVenueLevelId); commented by Rajeev on 22-12-2019*/
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
		//alert(validateData($scope.trainingDetails));
		$scope.btn_disabled=true;
		if(validateData($scope.training.trainingDetailList)){
			
			if(status=='F'){
				$scope.training.isFreeze=true;
				
			}else {
				$scope.training.isFreeze=false;
				$scope.fetchTrainingMOPR.isFreeze=false;
			}
			
			trainingDetailService.savetrainingDetailMOPRCEC($scope.training).then(function(response){
		    	if(response!=null && response.status==200){
		    		toastr.success(response.data.responseMessage);
		    	}else{
		    		toastr.error(response.data.responseMessage);
		    	}
		    	fetchOnLoad();
		    	
		    });
		}
		
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