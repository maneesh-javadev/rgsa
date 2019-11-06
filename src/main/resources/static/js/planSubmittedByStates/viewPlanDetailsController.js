var publicModule = angular.module("publicModule", []);
publicModule.controller("adminTechSupportSaffController",['$scope','adminTechSupportSaffService','consolidatedReportService',function($scope,adminTechSupportSaffService,consolidatedReportService,$http) {
	
	
	$scope.adminTechStaffObject={};
	$scope.adminTechStaffObject.supportDetails=[];
	$scope.grandTotal=0;
	$scope.levels=[];
	$scope.hideRevertButton=false;
	
	fetchOnLoad();
	
	function fetchOnLoad(){
		adminTechSupportSaffService.getPostTypeMaster().then(function(response){
			$scope.postTypes = response.data.postType;
			$scope.levels = response.data.level;
			if(response.data.technicalSupport!=undefined){
				$scope.adminTechStaffObject=response.data.technicalSupport;
				$scope.adminTechStaffObject.supportDetails=response.data.details;
				
				
				angular.forEach($scope.adminTechStaffObject.supportDetails, function(item, key){
					$scope.grandTotal+=item.funds;
				});
				$scope.grandTotal+=$scope.adminTechStaffObject.additionalRequirement;
				
			}
		});
	}
	
	$scope.forwardPlan=function(plansAreFreezed){
		
			consolidatedReportService.forwardPlans().then(function(data){
				toastr.success("Plans Forwarded");
			})
		
	}
	
	$scope.revertPlan=function(stateCode){
		var flag = confirm('Do you want to revert plan?');
		if(flag){
			consolidatedReportService.revertPlan(stateCode).then(function(data){
				$scope.hideRevertButton=true;
				toastr.success("Plans reverted");
			},function(error){
				toastr.error("Something went wrong");
			});
		}
	}
	
	$scope.validateValue = function(index){
		console.log("inside validate value");
		if($scope.adminTechStaffObject.supportDetails[index].noOfUnits == 0){
			$scope.adminTechStaffObject.supportDetails[index].noOfUnits = '';
			toastr.error("Value should be greater then zero");
		}
		if($scope.adminTechStaffObject.supportDetails[index].unitCost == 0){
			$scope.adminTechStaffObject.supportDetails[index].unitCost = '';
			toastr.error("Value should be greater then zero");
		}
		if($scope.adminTechStaffObject.supportDetails[index].noOfMonths == 0){
			$scope.adminTechStaffObject.supportDetails[index].noOfMonths = '';
			toastr.error("Value should be greater then zero");
		}
	}
	
	$scope.saveData=function(status){
		$scope.adminTechStaffObject.status=status;
		adminTechSupportSaffService.saveData($scope.adminTechStaffObject).then(function(response){
			toastr.success("Data Save Sucessfully");
		});
	}
	
	$scope.calculateFunds=function(index){
		$scope.adminTechStaffObject.supportDetails[index].funds=
		$scope.adminTechStaffObject.supportDetails[index].noOfUnits*
		$scope.adminTechStaffObject.supportDetails[index].unitCost*
		$scope.adminTechStaffObject.supportDetails[index].noOfMonths;
		
		$scope.calculateGrandTotal();
	}
	
	$scope.calculateGrandTotal = function(){
		$scope.grandTotal=0;
		angular.forEach($scope.adminTechStaffObject.supportDetails, function(item, key){
			$scope.grandTotal+=item.funds;
		});
		$scope.grandTotal+=$scope.adminTechStaffObject.additionalRequirement;
	}
	
}]);


publicModule.controller("satcomController",['$scope','satcomService',function($scope,satcomService,$https){
	
	$scope.satcomActivityObject={};
	$scope.satcomActivityObject.activityDetails=[];
	
	$scope.save=true;
	$scope.freeze=true;
	$scope.unFreeze=false;
	$scope.clear=true;
	
	
//	fetchOnLoad();
	function fetchOnLoad(){
		satcomService.getActivityList().then(function(response){
			$scope.satComLevel=response.data.SATCOM_LEVEL;
			$scope.activityList=response.data.SATCOME_ACTIVITY;
			if(response.data.SATCOME_ACTIVITY_DETAILS!=undefined){
				$scope.satcomActivityObject=response.data.SATCOME_ACTIVITY_DETAILS;
				if($scope.satcomActivityObject.status == 'F'){
					$scope.save=false;
					$scope.freeze=false;
					$scope.unFreeze=true;
					$scope.clear=false;
				}
				
			}
		});
	}
	
	
	$scope.saveData=function(status){
		$scope.satcomActivityObject.status=status;
		satcomService.saveData($scope.satcomActivityObject).then(function(response){
			if(response.data.SATCOME_ACTIVITY_DETAILS!=undefined){
				$scope.satcomActivityObject=response.data.SATCOME_ACTIVITY_DETAILS;
				if($scope.satcomActivityObject.status == 'F'){
					$scope.save=false;
					$scope.freeze=false;
					$scope.unFreeze=true;
					$scope.clear=false;
					toastr.success("Data Freeze Sucessfully")
				}
				else{
					toastr.success("Data Save Sucessfully")
					$scope.save=true;
					$scope.freeze=true;
					$scope.unFreeze=false;
					$scope.clear=true;
				}
				
			}
		});
	}
	
	$scope.calculateFunds=function(index){
		$scope.satcomActivityObject.activityDetails[index].funds="";
		if($scope.satcomActivityObject.activityDetails[index].noOfUnits!=null && $scope.satcomActivityObject.activityDetails[index].unitCost!=null
			&& $scope.satcomActivityObject.activityDetails[index].noOfUnits!="" && 	$scope.satcomActivityObject.activityDetails[index].unitCost!=""){
			$scope.satcomActivityObject.activityDetails[index].funds=
				$scope.satcomActivityObject.activityDetails[index].noOfUnits*
				$scope.satcomActivityObject.activityDetails[index].unitCost;
		}
	}
	
	$scope.claerAll=function(){
		$scope.satcomActivityObject={};
		$scope.satcomActivityObject.activityDetails=[];
	}
	
}]);

publicModule.controller("pesaPlanController", [ '$scope', "pesaPlanService",
                                        		function($scope, pesaPlanService) {
                                        	
                                        	$scope.pesaPlan={};
                                        	$scope.pesaPlan.pesaPlanDetails=[];
                                        	$scope.pesaPlan.additionalRequirement;
                                        	
                                        	$scope.totalWithoutAddRequirements = 0;

                                        	$scope.maxLengthOfMonth = 12;
                                        	
                                        	fetchDesignations();
                                        	
                                        	function fetchDesignations(){
                                        		console.log("inside pesaController");
                                        		pesaPlanService.fetchDesignations().then(function(response) {
                                        			$scope.designationArray = response.data.pesaPosts;
                                        			$scope.pesaPlan.isFreez =false;
                                        			if(response.data.pesaPlanResponseMap != undefined ){
                                        				$scope.pesaPlan = response.data.pesaPlanResponseMap;
                                        				$scope.pesaPlan.pesaPlanId = $scope.pesaPlan.pesaPlanId;
                                        				$scope.pesaPlan.isFreez = $scope.pesaPlan.isFreez;
                                        				$scope.pesaPlan.additionalRequirement = $scope.pesaPlan.additionalRequirement;
                                        				$scope.pesaPlan.pesaPlanDetails = response.data.pesaPlanDetails;
                                        				
                                        				$scope.postToPesaDetails = new Map();
                                        				
                                        				for (var i = 0; i < $scope.pesaPlan.pesaPlanDetails.length; i++) {
                                        					var obj={};
                                        					for (var j = 0; j < $scope.designationArray.length; j++) {
                                        						if($scope.pesaPlan.pesaPlanDetails[i].pesaPostId == $scope.designationArray[j].pesaPostId){
                                        							$scope.postToPesaDetails.set($scope.designationArray[j].pesaPostId , $scope.pesaPlan.pesaPlanDetails[i]);
                                        							continue;
                                        						}
                                        					}
                                        				}
                                        				
                                        				$scope.pesaPlan.pesaPlanDetails = [];
                                        				for (var i = 0; i < $scope.designationArray.length; i++) {
                                        					var obj =[];
                                        					if($scope.postToPesaDetails.get($scope.designationArray[i].pesaPostId) == null){
                                        						obj.noOfUnits ='';
                                        						obj.unitCostPerMonth ='';
                                        						obj.noOfMonths ='';
                                        						obj.funds ='';
                                        						obj.remarks ='';
                                        						obj.pesaPostId = $scope.designationArray[i].pesaPostId;
                                        						$scope.pesaPlan.pesaPlanDetails.push(obj);
                                        					}else{
                                        						$scope.pesaPlan.pesaPlanDetails.push($scope.postToPesaDetails.get($scope.designationArray[i].pesaPostId))
                                        					}
                                        				}
                                        				
                                        			}
                                        			var designationArray = $scope.designationArray;
                                        			$scope.designationIdToCellingValueMap = new Map();
                                        			
                                        			for (var i = 0; i < $scope.designationArray.length; i++) {
                                        				var obj = {}
                                        				obj.id = $scope.designationArray[i].pesaPostId;
                                        				obj.value = $scope.designationArray[i].ceilingValue;
                                        				$scope.designationIdToCellingValueMap.set(obj.id,obj.value);
                                        			}
                                        			
                                        			if($scope.pesaPlan.pesaPlanDetails != undefined)
                                        				$scope.calculateTotal();
                                        		},function(error){
                                        			alert(error);
                                        		});
                                        	}
                                        	
                                        	$scope.calculateTotal=function(){
                                        		var totalOfFunds = 0;
                                        			for (var i = 0; i < $scope.pesaPlan.pesaPlanDetails.length; i++) {
                                        				if($scope.pesaPlan.pesaPlanDetails[i] != undefined){
                                        					totalOfFunds = totalOfFunds + $scope.pesaPlan.pesaPlanDetails[i].funds;
                                        				}
                                        			}
                                        		$scope.totalWithoutAddRequirements = totalOfFunds;
                                        		$scope.grandTotal = $scope.totalWithoutAddRequirements + $scope.pesaPlan.additionalRequirement;
                                        	}
                                        	
                                        	$scope.calculateFundsAndTotalWithoutAdditionaRequirement=function(index){
                                        		if($scope.pesaPlan.pesaPlanDetails[index].unitCostPerMonth == 0){
                                        			$scope.pesaPlan.pesaPlanDetails[index].unitCostPerMonth ='';
                                        			return false;
                                        		}
                                        		
                                        		if($scope.pesaPlan.pesaPlanDetails[index].unitCostPerMonth > $scope.designationArray[index].ceilingValue){
                                        			$scope.pesaPlan.pesaPlanDetails[index].unitCostPerMonth='';
                                        			toastr.error("Unit Cost per month for " + $scope.designationArray[index].pesaPostName + " should not be greater than " + $scope.designationArray[index].ceilingValue);
                                        		}
                                        		
                                        		if($scope.pesaPlan.pesaPlanDetails[index].noOfUnits == 0){
                                        			$scope.pesaPlan.pesaPlanDetails[index].noOfUnits ='';
                                        			return false;
                                        		}
                                        		
                                        		if($scope.pesaPlan.pesaPlanDetails[index].noOfMonths == 0){
                                        			$scope.pesaPlan.pesaPlanDetails[index].noOfMonths ='';
                                        			return false;
                                        		}
                                        		
                                        		$scope.pesaPlan.pesaPlanDetails[index].funds = $scope.pesaPlan.pesaPlanDetails[index].noOfUnits * $scope.pesaPlan.pesaPlanDetails[index].unitCostPerMonth * $scope.pesaPlan.pesaPlanDetails[index].noOfMonths
                                        		var totalOfFunds = 0;
                                        		for (var i = 0; i < $scope.pesaPlan.pesaPlanDetails.length; i++) {
                                        			if($scope.pesaPlan.pesaPlanDetails[i]!=undefined){
                                        				if($scope.pesaPlan.pesaPlanDetails[i].funds != undefined && !isNaN($scope.pesaPlan.pesaPlanDetails[i].funds) ){
                                        					totalOfFunds = $scope.pesaPlan.pesaPlanDetails[i].funds + totalOfFunds;
                                        				}
                                        			}
                                        		}
                                        		$scope.totalWithoutAddRequirements = totalOfFunds;
                                        		$scope.calculateGrandTotal();
                                        	}
                                        	
                                        	$scope.calculateTotalWithoutAddRequirements=function(){
                                        		colsole.log("inside calculateTotalWithoutAddRequirements");
                                        	}
                                        	
                                        	$scope.calculateGrandTotal=function(){
                                        		
                                        		$scope.allowedAdditionalRequirement = (25/100)*$scope.totalWithoutAddRequirements
                                        		
                                        		if($scope.pesaPlan.additionalRequirement > $scope.allowedAdditionalRequirement){
                                        			toastr.error("Additional requirement should not be greater than " + $scope.allowedAdditionalRequirement);
                                        			$scope.pesaPlan.additionalRequirement = undefined;
                                        			$scope.grandTotal = '';
                                        			return false;
                                        		}
                                        		
                                        		$scope.grandTotal = $scope.totalWithoutAddRequirements + $scope.pesaPlan.additionalRequirement;
                                        	}
                                        	
                                        	$scope.savePesaPlan=function(){
                                        		console.log("inside savePesaPlan");
                                        		console.log($scope.pesaPlan);
                                        		for (var i = 0; i < $scope.pesaPlan.pesaPlanDetails.length; i++) {
                                        			if($scope.pesaPlan.pesaPlanDetails[i] != undefined){
                                        				if($scope.pesaPlan.pesaPlanDetails[i].unitCostPerMonth > $scope.designationArray[i].ceilingValue){
                                        					toastr.error("Unit Cost per month for " + $scope.designationArray[i].pesaPostName + " should not be greater than " + $scope.designationArray[i].ceilingValue);
                                        					$scope.pesaPlan.pesaPlanDetails[i].unitCostPerMonth = '';
                                        				}
                                        			}
                                        		}
                                        		
                                        		if($scope.validateFields()){
                                        			pesaPlanService.savePesaPlan($scope.pesaPlan).then(function(response){
                                        				toastr.success("Plan Saved Successfully");
                                        			},function(error){
                                        				toastr.error("Something went wrong");
                                        			});
                                        		}
                                        	}
                                        	
                                        	$scope.validateFields=function(){
                                        		for (var i = 0; i < $scope.pesaPlan.pesaPlanDetails.length; i++) {
                                        			if($scope.pesaPlan.pesaPlanDetails[i] != undefined){
                                        				if(isNaN($scope.pesaPlan.pesaPlanDetails[i].funds)){
                                        					toastr.error("Fund is required");
                                        					return false;
                                        				}
                                        				if($scope.pesaPlan.pesaPlanDetails[i].noOfUnits == undefined){
                                        					toastr.error("Number of units is required");
                                        					return false;
                                        				}
                                        				if($scope.pesaPlan.pesaPlanDetails[i].unitCostPerMonth == ""){
                                        					toastr.error("Unit Cost Per Month is required");
                                        					return false;
                                        				}
                                        			}
                                        		}
                                        		return true;
                                        	}
                                        	
                                        	$scope.onClear = function(){
                                        		$scope.pesaPlan.additionalRequirement = 0;
                                        		for (var i = 0; i < $scope.pesaPlan.pesaPlanDetails.length; i++) {
                                        			if($scope.pesaPlan.pesaPlanDetails[i] != undefined){
                                        				$scope.pesaPlan.pesaPlanDetails[i].noOfUnits='';
                                        				$scope.pesaPlan.pesaPlanDetails[i].unitCostPerMonth='';
                                        				$scope.pesaPlan.pesaPlanDetails[i].noOfMonths='';
                                        				$scope.pesaPlan.pesaPlanDetails[i].funds='';
                                        				$scope.pesaPlan.pesaPlanDetails[i].remarks = '';
                                        				$scope.grandTotal = 0;
                                        				$scope.totalWithoutAddRequirements = 0;
                                        			}
                                        		}
                                        	}
                                        	
                                        	$scope.freezUnFreezPesaPlan=function(freezUnfreez){
                                        		if(freezUnfreez == 'freez'){
                                        			$scope.pesaPlan.isFreez = true;
                                        		}else{
                                        			$scope.pesaPlan.isFreez = false;
                                        		}
                                        		pesaPlanService.freezUnFreezPesaPlan($scope.pesaPlan).then(function(response){
                                        			$scope.pesaPlan = response.data;
                                        			if(freezUnfreez == 'freez'){
                                        				toastr.success("Plan Freezed Successfully");
                                        			}else{
                                        				toastr.success("Plan UnFreezed Successfully");
                                        			}
                                        		},function(error){
                                        			alert(error);
                                        		});
                                        	}
                                        }]);