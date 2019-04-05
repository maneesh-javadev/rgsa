

var trainingDetail=angular.module("publicModule",[]);

trainingDetail.controller("trainingDetailMoprController",['$scope','trainingDetailService',function($scope,trainingDetailService ){
	
	
	
	
	$scope.training={};
	$scope.training.trainingDetailList=[];
	$scope.trainingDetails={};
	
	fetchOnLoad();
	
	function fetchOnLoad(){
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
		
		angular.forEach($scope.training.trainingDetailList,function(item){
			$scope.allTrainingFund=$scope.allTrainingFund+item.funds;
		});
		$scope.calculateMasterFund();
	}
	
	$scope.calculateMasterFund=function(){
		var additionalRequirement=0;
		if($scope.training.additionalRequirement != null && $scope.training.additionalRequirement != undefined){
			additionalRequirement=parseInt($scope.training.additionalRequirement);
		}else{
			$scope.training.additionalRequirement=0;
		}
		$scope.masterFunds=$scope.allTrainingFund+additionalRequirement;
	}
	
	calculateAllTrainingFundsMOPR=function(){
		$scope.allTrainingFundMOPR=0;
		angular.forEach($scope.fetchTrainingDetailsListMOPR,function(item){
			$scope.allTrainingFundMOPR=$scope.allTrainingFundMOPR+item.funds;
		});
		$scope.masterFundsMOPR=$scope.allTrainingFundMOPR+ parseInt($scope.fetchTrainingMOPR.additionalRequirement);
	}
	
	
	$scope.calculateFund=function(selObjType,index){
		var noOfDays=1;
		var noOfParticipants=1;
		var unitCost=1;
		var isNoofDays=false;
			
			if($scope.training.trainingDetailList[index].noOfParticipants != null && $scope.training.trainingDetailList[index].noOfParticipants != undefined){
				noOfParticipants=$scope.training.trainingDetailList[index].noOfParticipants;
			}
			if($scope.training.trainingDetailList[index].noOfDays != null && $scope.training.trainingDetailList[index].noOfDays != undefined){
				noOfDays=$scope.training.trainingDetailList[index].noOfDays;
				isNoofDays=true;
			}
			
			if($scope.training.trainingDetailList[index].unitCost != null && $scope.training.trainingDetailList[index].unitCost != undefined){
				unitCost=$scope.training.trainingDetailList[index].unitCost;
			}
			
			if(isNoofDays){
				venueId=parseInt($scope.fetchTrainingDetailsListState[index].trainingVenueLevelId);
				switch(venueId){
				case 1:limit= 1900;break;
				case 2:limit= 1100;break;
				case 3:limit= 800;break;
				}
				uperlimit=limit*noOfDays;
				actualval=noOfParticipants*noOfDays;
				if(actualval>uperlimit){
					toastr.error("Upper ceiling  limit  Rs. "+limit+" per participant per day");
					
					switch(selObjType){
					case 'P':$scope.training.trainingDetailList[index].noOfParticipants=null;noOfParticipants=1;break;
					case 'D':$scope.training.trainingDetailList[index].noOfDays=null;noOfDays=1;break;
					case 'U':$scope.training.trainingDetailList[index].unitCost=null;unitCost=1;break;
					case 'V':$scope.training.trainingDetailList[index].noOfParticipants=null;noOfParticipants=1;break;
					}
				}
				
			}
			
			$scope.training.trainingDetailList[index].funds=noOfDays*noOfParticipants*unitCost;	
			calculateAllTrainingFunds();
	}
	
	calculateAllTrainingFunds=function(){
		$scope.allTrainingFund=0;
		
		angular.forEach($scope.training.trainingDetailList,function(item){
			$scope.allTrainingFund=$scope.allTrainingFund+item.funds;
		});
		$scope.calculateMasterFund();
	}
	
	$scope.calculateMasterFund=function(){
		var additionalRequirement=0;
		if($scope.training.additionalRequirement != null && $scope.training.additionalRequirement != undefined){
			additionalRequirement=parseInt($scope.training.additionalRequirement);
		}else{
			$scope.training.additionalRequirement=0;
		}
		$scope.masterFunds=$scope.allTrainingFund+additionalRequirement;
	}
	
	$scope.saveTrainingDetails=function(status){
		//alert(validateData($scope.trainingDetails));
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