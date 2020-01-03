/**
 * By Abhishek Singh dated 12-2-19
 */
var trgModuleCEC=angular.module("trainingActivityModuleCEC",[]);

trgModuleCEC.controller("trainingActivityCEC",['$scope','trgActivityCecService',function($scope,trgActivityCecService,$https){
	$scope.userType = null;
	$scope.stateData;
	$scope.totalFund=0;
	$scope.additionalReq;
	$scope.grandTotal;
	$scope.isFreezeOrUnfreeze;
	$scope.status="";
	$scope.stateAdditionalReq;
	$scope.stateTotalFund;
	$scope.stateGrandTotal;
	
	$scope.cecData={};
	$scope.cecData.capacityBuildingActivityDetails=[];
	
	$( document ).ready(function() {
		fetchOnLoad();
	});
	function fetchOnLoad(){
		$scope.btn_disabled=false;
		trgActivityCecService.getActivityList().then(function(response){
			//console.log(">>>><<="+response.data.cbMasters);
			//For MOPR
			$scope.cbmasters = response.data.cbMasters;
			$scope.userType =  response.data.userType;
			$scope.moprData= response.data.trg_activity_mopr;
			$scope.additionalReq=$scope.moprData.additionalRequirement;
			$scope.calculateFundTotalMOPR($scope.moprData.capacityBuildingActivityDetails);
			//For State
			$scope.stateData=response.data.trg_activity_state;
			$scope.stateFundTotalInCEC=calGrandTotalCEC($scope.stateData.capacityBuildingActivityDetails);
			$scope.stateAdditionalReq=$scope.stateData.additionalRequirement;
			$scope.stateGrandTotalInCEC=$scope.stateData.additionalRequirement + $scope.stateFundTotalInCEC;
			//For Change Data for CEC that has to be saved
			
			if(response.data.capacityBuildingDetails!=undefined ){
				$scope.cecData=response.data.capacityBuildingDetails;
				$scope.calculateFundTotal($scope.cecData.capacityBuildingActivityDetails);
				if($scope.cecData.isFreeze == true){
					$scope.status="U";
					$scope.isFreezeOrUnfreeze=true;
					$("#btnfreezeUnfreeze").html("Unfreeze")

				}else{
					$scope.status="F";
					$scope.isFreezeOrUnfreeze=false;
					$("#btnfreezeUnfreeze").html("Freeze")
				}
				/*$scope.initial_status=false;
				$scope.isFreezeOrUnfreeze=$scope.cecData.isFreeze;
				calculateOther($scope.cecData);
				console.log("cec  isfreeze ="+$scope.cecData.isFreeze);
				if($scope.isFreezeOrUnfreeze == true){
					$scope.status="U";
				}else{
					$scope.status="F";
				}*/
			}else{
				
				$scope.status="F";
			}
		});
	}
	
	function calGrandTotalCEC(object){
		let total=0;
		for(let i=0;i<object.length;i++){
			if(object[i].funds != null && object[i].funds != undefined) 
			total += object[i].funds;
		}
		return total;
	}
	
	
	//jsp local function handling here
	$scope.calculateFundTotalMOPR=function(capacityBuildingActivityDetails){
		var totalFundVal = 0;
		for (var i = 0; i < capacityBuildingActivityDetails.length; i++) {
		if(capacityBuildingActivityDetails[i].funds != null && capacityBuildingActivityDetails[i].funds != undefined)
		totalFundVal = totalFundVal + capacityBuildingActivityDetails[i].funds;
		}
		$scope.totalFund=totalFundVal;
		//console.log("totalFundVal ="+ totalFundVal);
		$scope.calculateGrandTotalMOPR();
	}
	//jsp local function handling here
	$scope.calculateGrandTotalMOPR=function(){
		var total = 0;
		if($scope.additionalReq == undefined || $scope.additionalReq == ""){
			total = 0 + parseInt($scope.totalFund);
		}else{
			total = parseInt($scope.additionalReq) + parseInt($scope.totalFund);
		}
		$scope.grandTotal=total;
	}
	
	
	//jsp local function handling here
	$scope.calculateFundTotal=function(capacityBuildingActivityDetails){
		var totalFundVal = 0;
		for (var i = 0; i < capacityBuildingActivityDetails.length; i++) {
		if(capacityBuildingActivityDetails[i].funds != null && capacityBuildingActivityDetails[i].funds != undefined)
		totalFundVal = totalFundVal + capacityBuildingActivityDetails[i].funds;
		}
		$scope.stateTotalFund=totalFundVal;
		//console.log("totalFundVal ="+ totalFundVal);
		$scope.calculateGrandTotal();
	}
	//jsp local function handling here
	$scope.calculateGrandTotal=function(){
		var total = 0;
		if($scope.cecData.additionalRequirement == undefined || $scope.cecData.additionalRequirement == ""){
			total = 0 + parseInt($scope.stateTotalFund);
		}else{
			total = parseInt($scope.cecData.additionalRequirement) + parseInt($scope.stateTotalFund);
		}
		$scope.stateGrandTotal=total;
	}
	//jsp local function handling here
	$scope.calculateNewFund=function(index){
		var noOfDays=1;
		var noOfUnits=1;
		if($scope.stateData.capacityBuildingActivityDetails[index].noOfDays != null && $scope.stateData.capacityBuildingActivityDetails[index].noOfDays != undefined){
			noOfDays=$scope.stateData.capacityBuildingActivityDetails[index].noOfDays;
		}
		if($scope.cecData.capacityBuildingActivityDetails[index].noOfUnits != null && $scope.cecData.capacityBuildingActivityDetails[index].noOfUnits != undefined){
			noOfUnits=$scope.cecData.capacityBuildingActivityDetails[index].noOfUnits;
		}
		if($scope.cecData.capacityBuildingActivityDetails[index].unitCost === undefined){
			$scope.cecData.capacityBuildingActivityDetails[index].funds=0;
		}else{
			$scope.cecData.capacityBuildingActivityDetails[index].funds=$scope.cecData.capacityBuildingActivityDetails[index].unitCost*noOfDays*noOfUnits;
			if((index ==0 || index ==1 || index ==3 ||index ==7) && $scope.cecData.capacityBuildingActivityDetails[index].unitCost > 500000){
				toastr.error("total fund for this activity should less than or equal to 5 lakhs.");
				$scope.cecData.capacityBuildingActivityDetails[index].unitCost='';
			}else if(index == 2 && $scope.cecData.capacityBuildingActivityDetails[index].unitCost > 1000000){
				toastr.error("total fund for this activity should less than or equal to 10 lakhs.");
				$scope.cecData.capacityBuildingActivityDetails[index].unitCost='';
			}else if(index == 4 && $scope.cecData.capacityBuildingActivityDetails[index].unitCost > 2500){
				toastr.error("total fund for this activity should less than or equal to 2500.");
				$scope.cecData.capacityBuildingActivityDetails[index].unitCost='';
			}else if(index == 5 && $scope.cecData.capacityBuildingActivityDetails[index].unitCost > 4000){
				toastr.error("total fund for this activity should less than or equal to 4000.");
				$scope.cecData.capacityBuildingActivityDetails[index].unitCost='';
			}else if(index == 6 && $scope.cecData.capacityBuildingActivityDetails[index].unitCost  > 10000){
				toastr.error("total fund for this activity should less than or equal to 10000.");
				$scope.cecData.capacityBuildingActivityDetails[index].unitCost='';
			}
		}
		
		//$scope.cecData.capacityBuildingActivityDetails[index].unitCost=parseInt($scope.cecData.capacityBuildingActivityDetails[index].unitCost);
		//For total change in fund calculation		
		calculateOther($scope.cecData);
	}
	calculateOther=function(object){
		//For total change in fund calculation	
		var totalFundVal = 0;
		if(object!=null){
			angular.forEach(object.capacityBuildingActivityDetails,function(item){
				if(item.funds != null && item.funds != undefined){
					totalFundVal = totalFundVal + item.funds;
				}
			});
		}
		
		if($scope.cecData.additionalRequirement == undefined ||$scope.cecData.additionalRequirement == ""){
			cecadreq = 0 ;
		}else{
			cecadreq = parseInt($scope.cecData.additionalRequirement) ;
		}
		$scope.stateTotalFund = totalFundVal;
		$scope.stateGrandTotal = totalFundVal +cecadreq;
	}
	
	$scope.calculateAdditionalRequirment=function(){
		
		if($scope.cecData.additionalRequirement == undefined ||$scope.cecData.additionalRequirement == ""){
			cecadreq = 0 ;
		}else{
			if($scope.cecData.additionalRequirement > ($scope.stateTotalFund * .25)){
				toastr.error("Additional requirement should not exceed : " +  ($scope.stateTotalFund * .25));
				$scope.cecData.additionalRequirement='';
			}
			cecadreq = parseInt($scope.cecData.additionalRequirement) ;
		}
		$scope.stateGrandTotal = $scope.stateTotalFund +cecadreq;
	}
	//saving details
	$scope.saveTrainingActivityCecDetails=function(){
		$scope.btn_disabled=true;
		$scope.cecData.isFreeze=false;
		trgActivityCecService.saveCapacityBuildingCEC($scope.cecData).then(function(response){
			fetchOnLoad();
			toastr.success("Data Saved Successfully");
		},function(error){
			toastr.error("Something is wrong");
		});
	}
	$scope.freezeUnfreezeTrainingActivityCecDetails=function(e){
		//console.log();
		//var status=$(e.target).data('legend');
		var status=$scope.status;
		if(status != null && status != undefined){
			if(status == 'F'){
				$scope.isFreezeOrUnfreeze = true;
				$scope.cecData.isFreeze=true;
				//$(e.target).data('legend','U');
				//$scope.status="U";
			}else{
				$scope.isFreezeOrUnfreeze = false;
				$scope.cecData.isFreeze=false;
				//$(e.target).data('legend','F')
				//$scope.status="F"
			}
			//$scope.$digest();
			trgActivityCecService.saveCapacityBuildingCEC($scope.cecData).then(function(response){
				//$scope.cecData = response.data;
				fetchOnLoad();
				if(status == 'F'){
					$(e.target).html("Unfreeze")
					fetchOnLoad();
					toastr.success("CEC data freezed successfully");
				}else{
					fetchOnLoad();
					$(e.target).html("Freeze")
					toastr.success("CEC data unFreezed successfully");
				}
			},function(error){
				alert(error);
			});
		}else{
			alert("Please set your status first");
		}	
	}
}]);
