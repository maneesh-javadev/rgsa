

var trainingDetail=angular.module("publicModule",[]);

trainingDetail.controller("trainingDetailController",['$scope','trainingDetailService',function($scope,trainingDetailService ){
	
	
	
	$scope.isShowRecodVisible=false;
	$scope.isModifyRecodVisible=false;
	$scope.training={};
	$scope.training.trainingDetailList=[];
	$scope.trainingDetails={};

	fetchOnLoad();
	
	function fetchOnLoad(){
		trainingDetailService.fetchtrainingDetailData().then(function(response){
			$scope.training = response.data.fetchTraining;	
			$scope.planStateStatus=response.data.planStateStatus;
			
			$scope.training.trainingDetailList = response.data.fetchTrainingDetailsList;
			calculateAllTrainingFunds();
			$scope.targetGrpMstrList=response.data.targetGrpMstrList;
			$scope.subjectsList=response.data.subjectsList;
			$scope.trngVenueList=response.data.trngVenueList;
			$scope.modeOfTraining=response.data.modeOfTraining;
			$scope.trainingCatgryList=response.data.trainingCatgryList;
			$scope.trainingDetails.trainingActivityId=$scope.training.trainingActivityId;
			$scope.isbtnAddTraining=true;
			if($scope.training.trainingDetailList.length>0){
				$scope.isShowRecodVisible=true;
				$scope.isModifyRecodVisible=false;
				$scope.addNew=false;
			}
			
			if(!$scope.planStateStatus){
				$scope.training.isFreeze=true;
			}
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
	
	$scope.toModify=function(trainingId){
		angular.forEach($scope.training.trainingDetailList,function(item){
		  	if(item.trainingId == trainingId){
		  		$scope.curObject = item;
		  		$scope.isShowRecodVisible=false;
		  		$scope.isModifyRecodVisible=true;
		  		$scope.isbtnAddTraining=false;
		  		$scope.addNew=false;
		  		
		  		
		  		trainingDetailService.fetchtrainingOtherbyTrainingId(trainingId).then(function(response){
		  			$scope.trainingDetails.targetGrptArr=response.data.targetGroupMasterIds;
		  			$scope.trainingDetails.trainingSubjectArr=response.data.trainingSubjectsIds;
		  			$scope.trainingDetails.trainingVenueLevelId=$scope.curObject.trainingVenueLevelId.toString();
		  			$scope.trainingDetails.noOfParticipants=$scope.curObject.noOfParticipants;
		  			$scope.trainingDetails.noOfDays=$scope.curObject.noOfDays;
		  			$scope.trainingDetails.unitCost=$scope.curObject.unitCost;
		  			$scope.trainingDetails.funds=$scope.curObject.funds;
		  			$scope.trainingDetails.trainingMode=$scope.curObject.trainingMode.toString();
		  			$scope.trainingDetails.remarks=$scope.curObject.remarks;
		  			$scope.trainingDetails.trainingId=$scope.curObject.trainingId;
		  			$scope.trainingDetails.trainingCategoryId=$scope.curObject.trainingCategoryId;
		  		});
		  	}
		  		
		  		
		  		
		  });
		  
		  
	}
	
	$scope.toAddNew=function(){
		$scope.isShowRecodVisible=false;
  		$scope.isModifyRecodVisible=true;
  		$scope.isbtnAddTraining=false;
  		$scope.addNew=true;
	}
	
	$scope.toShowRecord=function(){
		$scope.isShowRecodVisible=true;
  		$scope.isModifyRecodVisible=false;
  		$scope.isbtnAddTraining=true;
  		$scope.addNew=false;
	}
	
	$scope.updateTrainingDetails=function(){
		//alert(validateData($scope.trainingDetails));
		if(validateData($scope.trainingDetails)){
			$scope.trainingDetails.targetGrptArr=$scope.trainingDetails.targetGrptArr.toString();
			$scope.trainingDetails.trainingSubjectArr=$scope.trainingDetails.trainingSubjectArr.toString();
			trainingDetailService.savetrainingDetailData($scope.trainingDetails).then(function(response){
		    	if(response!=null && response.status==200){
		    		toastr.success(response.data.responseMessage);
		    	}else{
		    		toastr.error(response.data.responseMessage);
		    	}
		    	fetchOnLoad();
		    	
		    });
		}
		
	}
	
	validateData=function(trainingDetails){
		
		if(!trainingDetails.targetGrptArr.length>0){
			toastr.error("Please select Traget group ");
			return false;
		}else if(!trainingDetails.trainingSubjectArr.length>0){
			toastr.error("Please select Training Subject ");
			return false;
		}else if(!trainingDetails.trainingVenueLevelId.length>0){
			toastr.error("Please select Training Venue Level");
			return false;
		}
		else if(!(trainingDetails.noOfParticipants!=null && trainingDetails.noOfParticipants!=undefined)){
			toastr.error("Please enter No. of Participants");
			return false;
		}
		
		else if(!(trainingDetails.noOfDays!=null && trainingDetails.noOfDays!=undefined)){
			toastr.error("Please enter No. of noOfDays");
			return false;
		}
		
		else if(!(trainingDetails.unitCost!=null && trainingDetails.unitCost!=undefined)){
			toastr.error("Please enter No. of unitCost");
			return false;
		}
		
		else if(!(trainingDetails.trainingMode!=null && trainingDetails.trainingMode!=undefined)){
			toastr.error("Please select Mode of Training");
			return false;
		}
		
		return true;
	}
	
	$scope.calculateFund=function(selObjType){
		var noOfDays=1;
		var noOfParticipants=1;
		var unitCost=1;
		var isUnitCost=false;
		
		if($scope.trainingDetails.trainingVenueLevelId!= null && $scope.trainingDetails.trainingVenueLevelId != undefined){
			
			if($scope.trainingDetails.noOfParticipants != null && $scope.trainingDetails.noOfParticipants != undefined){
				noOfParticipants=$scope.trainingDetails.noOfParticipants;
			}
			if($scope.trainingDetails.noOfDays != null && $scope.trainingDetails.noOfDays != undefined){
				noOfDays=$scope.trainingDetails.noOfDays;
				isNoofDays=true;
			}
			
			if($scope.trainingDetails.unitCost != null && $scope.trainingDetails.unitCost != undefined){
				unitCost=$scope.trainingDetails.unitCost;
				isUnitCost=true;
			}
			
			if(isUnitCost){
				venueId=	parseInt($scope.trainingDetails.trainingVenueLevelId);
				switch(venueId){
				case 1:limit= 1900;break;
				case 2:limit= 1100;break;
				case 3:limit= 800;break;
				}
				
				if(unitCost>limit){
					toastr.error("Upper ceiling  limit  Rs. "+limit+" unit cost accodring venue");
					
					switch(selObjType){
					case 'P':$scope.trainingDetails.noOfParticipants=null;noOfParticipants=1;break;
					case 'D':$scope.trainingDetails.noOfDays=null;noOfDays=1;break;
					case 'U':$scope.trainingDetails.unitCost=null;unitCost=1;break;
					case 'V':$scope.trainingDetails.noOfParticipants=null;noOfParticipants=1;break;
					}
				}
				
			}
			
				$scope.trainingDetails.funds=noOfDays*noOfParticipants*unitCost;	
				
			
			
				
		}else{
			toastr.error("Please select Training Venue Level");
			switch(selObjType){
			case 'P':$scope.trainingDetails.noOfParticipants=null;noOfParticipants=1;break;
			case 'D':$scope.trainingDetails.noOfDays=null;noOfDays=1;break;
			case 'U':$scope.trainingDetails.unitCost=null;unitCost=1;break;
			case 'V':$scope.trainingDetails.noOfParticipants=null;noOfParticipants=1;break;
			}
		}
	}
	
	
	$scope.fetchSubjectListbyCategory=function(trainingCategoryId){
		trainingDetailService.fetchSubjectsListData(trainingCategoryId).then(function(response){
			$scope.subjectsList=response.data;
  		});
		
	}
	
	$scope.saveTrainingDetails=function(status){
		if($scope.training.additionalRequirement != null && $scope.training.additionalRequirement!= undefined){
			if(status=='F'){
				$scope.training.isFreeze=true;
				
			}else {
				$scope.training.isFreeze=false;
			}
			
			trainingDetailService.updateTrainingActivityData($scope.training).then(function(response){
		    	if(response!=null && response.status==200){
		    		toastr.success(response.data.responseMessage);
		    	}else{
		    		toastr.error(response.data.responseMessage);
		    	}
		    	fetchOnLoad();
		    	
		    });
			
		}else{
			toastr.error("Please enter Additional Requirements");
		}
		
		
		
	}
	
}]);