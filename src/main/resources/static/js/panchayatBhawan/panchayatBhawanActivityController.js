/**
 * Monty
 */
var panchayatBhawanApp=angular.module("panchayatBhawanApp",['ui.bootstrap']);

panchayatBhawanApp.controller("panchayatBhawanActivityCntrl",['$scope','panchayatBhawanActivityService','$modal',function($scope,panchayatBhawanActivityService,$modal,$compile,$https){
	
fetchOnLoad();

$scope.panchayatBhawanActivity={};
$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails=[];
$scope.activityList=[];
$scope.perposedInfo=[];
$scope.panchayatWithoutBhawan = null;
$scope.userType = null;


   
	
	function fetchOnLoad(){
		$scope.btn_disabled=false;
		panchayatBhawanActivityService.getPanchayatBhawanActivity().then(function(response){
			$scope.activityList=response.data.PANCHAYAT_ACTIVITY;
			$scope.districtList=response.data.DISTRICT_LIST;
			$scope.panchayatWithoutBhawan = response.data.panchayatWithoutBhawan;
			$scope.panchayatWithBhawan= response.data.panchayatWithBhawan;
			$scope.userType = response.data.userType;
			if(response.data.PANCHAYAT_BHAWAN_ACTIVITY!=null && response.data.PANCHAYAT_BHAWAN_ACTIVITY!=undefined){
				$scope.panchayatBhawanActivity=response.data.PANCHAYAT_BHAWAN_ACTIVITY;
				$scope.panchatayBhawanActivityDetails=response.data.PANCHAYAT_BHAWAN_ACTIVITY.panchatayBhawanActivityDetails;
				$scope.panchatayBhawanActivityDetailsSort=[];
				for(var i=0;i<$scope.panchatayBhawanActivityDetails.length;++i){
					activityId=$scope.panchatayBhawanActivityDetails[i].activity.activityId;
					$scope.panchatayBhawanActivityDetailsSort[activityId-1]=$scope.panchatayBhawanActivityDetails[i];
					
				}
				$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails=$scope.panchatayBhawanActivityDetailsSort;
				$scope.initial_status=false;
			}else{
				$scope.initial_status=true;
				/*for(var i=0;i<$scope.activityList.length;++i){
					$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].activity=$scope.activityList[i];
				}*/
			}
			if($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails != undefined)
				$scope.calculateTotal();
			if($scope.userType == "C"){
				$scope.panchayatBhawanActivityState=response.data.PANCHAYAT_BHAWAN_ACTIVITY_STATE;
				$scope.calTotalForCEC($scope.panchayatBhawanActivityState,'S');
				$scope.panchayatBhawanActivityMOPR=response.data.PANCHAYAT_BHAWAN_ACTIVITY_MOPR;
				$scope.calTotalForCEC($scope.panchayatBhawanActivityMOPR,'M');
			}
			
		});
	}
	

		$scope.calTotalForCEC = function(object,userType) {
			var totalOfFunds = 0;
			var totalOfFundsReq=0;
			for (var i = 0; i < object.panchatayBhawanActivityDetails.length; i++) {
				id=object.panchatayBhawanActivityDetails[i].activity.activityId;
				if( (id==1 || id==2 || id==3 ) && object.panchatayBhawanActivityDetails[i].funds!= null && object.panchatayBhawanActivityDetails[i].funds!= undefined){
					totalOfFunds = totalOfFunds + parseInt(object.panchatayBhawanActivityDetails[i].funds);
				}
				if( (id==4 || id==5 || id==6 ) && object.panchatayBhawanActivityDetails[i].funds!= null && object.panchatayBhawanActivityDetails[i].funds!= undefined){
					totalOfFundsReq = totalOfFundsReq +parseInt(object.panchatayBhawanActivityDetails[i].funds);
				}
				
			}	
			if(userType=='M'){
				$scope.totalMOPR=totalOfFunds;
				$scope.totalOfFundsReqMOPR=totalOfFundsReq;
			}else if(userType=='S'){
				$scope.totalState=totalOfFunds;
				$scope.totalOfFundsReqState=totalOfFundsReq;
			}
		
		
	}
	
	$scope.calculateTotal=function(){
		var totalOfFunds = 0;
		var totalOfFundsReq=0;
		var addiReq=0;
			for (var i = 0; i < $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails.length; i++) {
				id=$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].activity.activityId;
				if( (id==1 || id==2 || id==3 ) && $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds!= null && $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds!= undefined){
					totalOfFunds = totalOfFunds + parseInt($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds);
				}
				if( (id==4 || id==5 || id==6 ) && $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds!= null && $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds!= undefined){
					totalOfFundsReq = totalOfFundsReq +parseInt( $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds);
				}
			}
		$scope.totalWithoutAddRequirements = totalOfFunds;
		$scope.totalFundReq=totalOfFundsReq;
		if($scope.panchayatBhawanActivity.additionalRequirement != null && $scope.panchayatBhawanActivity.additionalRequirement != undefined){
			addiReq=parseInt($scope.panchayatBhawanActivity.additionalRequirement);
		}
		
		
		$scope.grandTotal = parseInt($scope.totalWithoutAddRequirements) + addiReq+parseInt($scope.totalFundReq);
	}
	
	$scope.calculateAspirationalGps = function(index){
		
		if(+$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].aspirationalGps > $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].noOfGPs){
			$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].aspirationalGps='';
			toastr.error("Aspirational GPs should not be greater than no. of entered GPs. ") ;
		}
	}
	
	$scope.calculateFundsAndTotalWithoutAdditionaRequirement=function(index){
		
		if($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[0].noOfGPs >  +$scope.panchayatWithoutBhawan){
			$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[0].noOfGPs ='';
			toastr.error("Number of GPs should not be greater than " + $scope.panchayatWithoutBhawan + " i.e. panchayat without bhawan");
			$scope.calculateAspirationalGps(0);
		}
		
		if($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[1].noOfGPs >  +$scope.panchayatWithBhawan){
			$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[1].noOfGPs ='';
			toastr.error("Number of GPs should not be greater than " + $scope.panchayatWithBhawan + " i.e. panchayat with bhawan");
			$scope.calculateAspirationalGps(1);
		}
		
		if($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[2].noOfGPs >  +$scope.panchayatWithBhawan){
			$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[2].noOfGPs ='';
			toastr.error("Number of GPs should not be greater than " + $scope.panchayatWithBhawan + " i.e. panchayat with bhawan");
			$scope.calculateAspirationalGps(2);
		}
		
		if($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].unitCost > $scope.activityList[index].ceilingValue){
			$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].unitCost='';
			toastr.error("Unit Cost for " + $scope.activityList[index].activityName + " should not be greater than " + $scope.activityList[index].ceilingValue);
		}
		
		
		
		/*if($scope.pesaPlan.pesaPlanDetails[index].noOfUnits == 0){
			$scope.pesaPlan.pesaPlanDetails[index].noOfUnits ='';
			return false;
		}*/
		
		/*if($scope.pesaPlan.pesaPlanDetails[index].noOfMonths == 0){
			$scope.pesaPlan.pesaPlanDetails[index].noOfMonths ='';
			return false;
		}*/
		
		$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].funds = $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].unitCost * $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].noOfGPs;
		
		var totalOfFunds = 0;
		var totalOfFundsReq=0;
		
			for (var i = 0; i < $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails.length; i++) {
				id=$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].activity.activityId;
				if( (id==1 || id==2 || id==3 ) && $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds!= null && $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds!= undefined){
					totalOfFunds = totalOfFunds + $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds;
				}
				if( (id==4 || id==5 || id==6 ) && $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds!= null && $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds!= undefined){
					totalOfFundsReq = totalOfFundsReq + $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds;
				}
			}
		$scope.totalWithoutAddRequirements = totalOfFunds;
		$scope.totalFundReq=totalOfFundsReq;
		
		$scope.calculateGrandTotal();
	}
	
	
     $scope.calculateGrandTotal=function(){
		
    	 
    		if($scope.panchayatBhawanActivity.additionalRequirement != null && $scope.panchayatBhawanActivity.additionalRequirement != undefined){
    			$scope.allowedAdditionalRequirement = (25/100)*$scope.totalWithoutAddRequirements;
    			if($scope.panchayatBhawanActivity.additionalRequirement > $scope.allowedAdditionalRequirement){
    				toastr.error("Additional requirement should not be greater than " + $scope.allowedAdditionalRequirement);
    				$scope.panchayatBhawanActivity.additionalRequirement = undefined;
    				$scope.grandTotal = '';
    				return false;
    			}
    			$scope.grandTotal = parseInt($scope.totalWithoutAddRequirements)+parseInt($scope.totalFundReq) +parseInt($scope.panchayatBhawanActivity.additionalRequirement);
    			
    		}else{
    			$scope.grandTotal = parseInt($scope.totalWithoutAddRequirements)+parseInt($scope.totalFundReq) ;
    		}
    	 
    	}
	
	$scope.saveData=function(status){
		$scope.btn_disabled=true;
		$scope.panchayatBhawanActivity.status=status;
		panchayatBhawanActivityService.saveData($scope.panchayatBhawanActivity).then(function(response){
			if($scope.panchayatBhawanActivity.status == 'S'){
			toastr.success("Data Save Sucessfully");
			}
			else if($scope.panchayatBhawanActivity.status == 'F'){
				toastr.success("Freeze Sucessfully");
			}
			else{
				toastr.success("Unfreeze Sucessfully");
			}
			fetchOnLoad();
		});
	}
	
	$scope.claerAll=function(){
		$scope.panchayatBhawanActivity={};
		$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails=[];
		$scope.grandTotal = '';
		$scope.totalWithoutAddRequirements = '';
	}
	
	$scope.selectPanchayats=function(districtCode,activityId){
		var modalInstance = $modal.open({
			templateUrl:'resources/js/panchayatBhawan/createPanchayat.htm', 
			controller:'panchayatController',
			windowClass: 'app-modal-window',
			resolve: {	
				activityId: function () {
                    return activityId;
                },
                districtCode: function () {
		            return districtCode;
		        },
                perposedInfo: function () {
                	return $scope.perposedInfo;
                }
			}
		});
		
		 modalInstance.result.then(function (selectedItem) {
		        $scope.perposedInfo=selectedItem.panchayatBhawanGPs;
		        $scope.activityId=selectedItem.currActivityId;
		        angular.forEach($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails, function(item) {
		        	if(item.activity.activityId == parseInt($scope.activityId)){
		        		item.proposedInfo=$scope.perposedInfo;
		        		
						console.log(item);
		        	}
				});
		    }, function () {
		        $log.info('Modal dismissed at: ' + new Date());
		    });
		
	}
	
	$scope.calculateFundRequired=function(index,id){
		var FREL=0,FUTI=0,FREQ=0,FSAN=0;
		var isError=false;
		if($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].noOfGPs != null && $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].noOfGPs != undefined){
				FSAN=parseInt($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].noOfGPs);
		}
		if($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].aspirationalGps != null && $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].aspirationalGps!= undefined){
				FREL=parseInt($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].aspirationalGps);
		}
		if($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].unitCost != null && $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].unitCost != undefined){
				FUTI=parseInt($scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].unitCost);
		}
			
			if(FREL>FSAN && id!='SAN'){
				toastr.error("Fund Sanctioned must be greater then Fund Released");
				isError=true;
			}else{
				if(id!='SAN'){
					if(FSAN>=FUTI){
						FREQ=FSAN-FUTI;
						if(FSAN>=FREQ){
							$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].funds=FREQ;
							
						}
						else{
							toastr.error("Fund Required must be less then Fund Sanctioned");
							isError=true;
						}
						
						if(FREL<FUTI){
							toastr.error("Fund Utilize must be less then Fund Released ");
							isError=true;
						}
					}else{
						toastr.error("Fund Released must be greater then Fund Sanctioned");
						isError=true;
					}
				}else{
					$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].funds=null;
					$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].aspirationalGps=null;
					$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].unitCost=null;
				}
				
				
				}
		
			
			
			
			if(isError){
				if(id=='REL'){
					$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].aspirationalGps=null;
				}else if(id=='UTI')	{
					$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].unitCost=null;
				}else if(id=='SAN')	{
					$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].noOfGPs=null;
				}
				$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[index].funds=null;
			}
			
		
			$scope.calculateTotal();
	
	}
	
	function calaculateTotalFundRequirment(){
		var totalOfFunds = 0;
		for (var i = 0; i < $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails.length; i++) {
			id=$scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].activity.activityId;
			if( (id==4 || id==5 || id==6 ) && $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds!= null && $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds!= undefined){
				totalOfFunds = totalOfFunds + $scope.panchayatBhawanActivity.panchatayBhawanActivityDetails[i].funds;
			}
		}
		$scope.totalFundReq=totalOfFunds;
	}
	
	$scope.debug=function(ele, ret, msg){
		console.log(msg?msg:"DEBUG", ele);
		return ret;
	}
	
	
	
	
}]);