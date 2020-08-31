var publicModule = angular.module("publicModule", ['ngMessages']);
publicModule.controller("pesaPlanQController", [ '$scope', '$http',
		function($scope, $http) {

	$scope.selectedQuarterId = "0";
    $scope.formObj = null;
    $scope._formObj = null;
    $scope.actionDisable=false;
	
	function actionObject(action, newPageData){
		this.action = action;
		this.pesaPlanId = newPageData.pesaPlanId;
		this.qprPesaId = newPageData.qprPesaId;
		this.additionalRequirement = toNumber(newPageData.additional, 0);
		this.isDirty = newPageData._isdirty;  // If form changed
		this.quarterId = newPageData.quarterId;
		this.expenditure = [];
		for(var i=0; i < newPageData.expenditures.length; ++i){
			var expObj = newPageData.expenditures[i];
			var insertObj = {};
			insertObj['expenditure'] = toNumber(expObj.expenditure);
			insertObj['unitCompleted'] = expObj.unitCompleted;
			insertObj['designationId'] = expObj.designationId;
			insertObj['qprPesaDetailsId'] = expObj.qprPesaDetailsId;
			insertObj['pesaPlanDetailsId'] = expObj.pesaPlanDetailsId;
			this.expenditure.push(insertObj);
		}
		return this;
	}

    function load(gObj) {
        $scope.formObj = angular.copy(gObj);
        $scope._formObj = gObj;
        resetForm();
    }

    function startLoad(quarterId) {
       
        $http.get("fetchQuartExp.html?qid="+ quarterId +"&<csrf:token uri=fetchQuartExp.htm/>").then(
            function(response){
                if (!response.data.success){
                    toastr.error(response.data.message);
                    return;
                }
                var receivedData = response.data.data;
                if(!receivedData){
                    receivedData = null;
                }
                if(!receivedData.qtrOneAndTwoNotPresent){
                	load(receivedData);
                }else{
                	toastr.error('Please fill progress report of quater 1 and 2 first.');
                }
            }, function(error){
                toastr.error(JSON.stringify(error, "\t"));
            }
        );
    }

    function performPost(postable, message, successCallback) {
    	$scope.actionDisable=true;
        $http.post("postQuartExp.html?<csrf:token uri=postQuartExp.html/>", postable).then(
            function(response){
            	$scope.actionDisable=false;
                if (!response.data.success){
                    toastr.error(response.data.message);
                    return;
                }
                var receivedData = response.data.data;
                if(!receivedData){
                    receivedData = null;
                }
                load(receivedData);
                toastr.success(message);
                if(typeof(successCallback) === "function"){
                    successCallback();
                }
            }, function(error){
            	$scope.actionDisable=false;
                toastr.error(JSON.stringify(error, "\t"));
            }
        );
    }

    function save() {
    	let fund_allocated = ['fundAllocatedCurrentInstallment'] in $scope._formObj ? $scope._formObj.fundAllocatedCurrentInstallment : 0;
    	let total_expenditure = getExpenditure();
        if($scope.pageForm.$invalid){
            return toastr.error("There are errors in form, please correct.");
        }
        if(total_expenditure<=fund_allocated)
        	{
         performPost(new actionObject("save", $scope.formObj), "Form saved");
        	}
        else
        	{
        	 return toastr.error("Total Expenditure should be less then Total Allocated Fund."+fund_allocated);
        	}
    }

    function clear() {
        if(!$scope.pageForm.$dirty)
            return swal("No changes");
        $scope.formObj = angular.copy($scope._formObj);
        resetForm();
    }

    function freezeUnfreeze() { 
        freezUnfreez = $scope.formObj.isFreeze ? 'unfreeze' : 'freeze' ;       
        performPost(new actionObject(freezUnfreez, $scope.formObj), "Form " + freezUnfreez + "d");
    }

    function toNumber(val, def){
        def = angular.isUndefined(def) ? 0: def;
        if(angular.isString(val)){
            newVal = parseInt(val, 10);
            if(isFinite(newVal))
                return newVal;
            return def;
        }
        if( angular.isUndefined(val))
            return def;
        return val;		
    }

    function resetForm(argument) {        	
        $scope.pageForm.$setPristine();
        $scope.pageForm.$setUntouched();
    }
    
    function getExpenditure(){
        var total = 0;
        if($scope.formObj == null){
            return total;
        }
        for(var i=0; i < $scope.formObj.expenditures.length; ++i)
            total += $scope.formObj.expenditures[i].expenditure;
        return total;
    }
    
    function getTotalExpenditure(){
        var total = 0;
        if($scope.formObj == null){
            return total;
        }
        total += getExpenditure();
        total += $scope.formObj.additional;
        return total;
    }
    
    $scope.fetchData = function(quarterId, oldVal){
        
      return startLoad(quarterId);
    };

    $scope.getClass = function (val) {
        if(val===false)
            return 'danger';
        if(val === true)
            return 'success';
        return '';
    };


    $scope.save = save;
    $scope.clear = clear;
    $scope.freezeUnfreeze = freezeUnfreeze;
    $scope.close = close;
    
    $scope.getExpenditure = getExpenditure;
    $scope.getTotalExpenditure = getTotalExpenditure;

    //added by aashish barua
    $scope.validatingExpenditureOnNoOfUnit=function(obj){
    	let noOfUnit=$scope.formObj.expenditures[obj].unitCompleted;
    	let expenditureIncurred=$scope.formObj.expenditures[obj].expenditure;
    	if((noOfUnit == '' || noOfUnit == null) && expenditureIncurred != ''){
    		toastr.error("Please fill no of unit first.");
    		$scope.formObj.expenditures[obj].expenditure='';
    	}
    }

    $scope.validateAdditionalReq=function(){
    	if(+$scope.formObj.additional + +$scope._formObj.addReqUsed > $scope._formObj.additionalState){
    		toastr.error("Additional requirement should not exceed : "+(+$scope._formObj.additionalState - +$scope._formObj.addReqUsed) );
    		$scope.formObj.additional='';
    	}
    }

    $scope.valWithCorrespondingFund=function(index){
    	if($scope._formObj.expenditures[index].funds < +$scope._formObj.expenditures[index].spent + +$scope.formObj.expenditures[index].expenditure){
    		toastr.error("Expenditure incurrred should not exceed : "+(+$scope._formObj.expenditures[index].funds - +$scope._formObj.expenditures[index].spent) );
    		$scope.formObj.expenditures[index].expenditure='';
    	}
    }

    $scope.validateWithFundAllocated=function(index){
    	let total_expenditure = getExpenditure();
    	let fund_allocated = ['fundAllocatedCurrentInstallment'] in $scope._formObj ? $scope._formObj.fundAllocatedCurrentInstallment : 0;
    	if($scope._formObj.quarterId > 2){
    		let fund_remaining_in_first_installment = +$scope._formObj.fundAllocatedFirstInstallment - +$scope._formObj.fundUsedInQtr1_2;
    		fund_allocated += +fund_remaining_in_first_installment;
    	}
    		if(fund_allocated != 0 && fund_allocated != undefined){
    			if(fund_allocated < total_expenditure){
        			toastr.error("Expenditure incurrred should not exceed : "+(total_expenditure - +$scope._formObj.expenditures[index].expenditure) +" as per fund allocated in plan alloccation.");
        			$scope._formObj.expenditures[index].expenditure='';
        		}
    		}else{
    			toastr.error("Either fund is not allocated or fund is finished.");
    		}
    }




    /*
	
	function loadDetails(qid) {
		var self=this;
		if(qid === 0)
			return;
		$http.get("fetchQuartExp.html?qid="+ qid +"&<csrf:token uri=fetchQuartExp.htm/>").then(
			function(response){
				var receivedData = response.data;
				if(!receivedData){
					receivedData = null;
				}else{
					receivedData['_isdirty'] = false;
				}
				$scope.pageData = angular.copy(receivedData);
				$scope.pageDataCache = angular.copy(receivedData);
				evaluateTotal($scope.pageData);
			}, function(error){
				toastr.error(JSON.stringify(error, "    "));
			});
	}
	
	$scope.fetchData = function(quarterId, oldVal){
		if($scope.pageData !== null && $scope.pageData['_isdirty']){
			// Warn user
			if(!confirm("Changes Pending continue without save?")){
				$scope.selectedQuarterId = oldVal;
				return false;
			}
		}
		loadDetails(quarterId);
		return true;
	}
	
	$scope.$watch('pageData', function(newPageData, oldPageData){
	    console.log('changed');
	    if(newPageData == null)
	    	return;
	    if(!newPageData['_isdirty'])
	    	newPageData['_isdirty'] = evalIsDirty(newPageData, oldPageData);
	    evaluateTotal(newPageData);
	}, true);
	
	function evaluateTotal(newPageData){
		var newTotal = toNumber(newPageData.additional, 0);
		for(var i=0; i < newPageData.expenditures.length; ++i){
			newTotal += toNumber(newPageData.expenditures[i].expenditure, 0);
		}
		$scope.grandTotal = newTotal;
	}
	
	function toNumber(val, def){
		def = angular.isUndefined(def) ? 0: def;
		if(angular.isString(val)){
			newVal = parseInt(val, 10);
			if(isFinite(newVal))
				return newVal;
			return def;
		}
		if( angular.isUndefined(val))
			return def;
		return val;		
	}
	
	function evalIsDirty(newPageData, oldPageData){
		if(oldPageData == null)
			return false;
		if(toNumber(newPageData.additional, 0) !== toNumber(oldPageData.additional, 0))
			return true;
		for(var i=0; i < newPageData.expenditures.length; ++i){
			if(toNumber(newPageData.expenditures[i].expenditure, 0) !== toNumber(oldPageData.expenditures[i].expenditure, 0))
				return true;
			if(toNumber(newPageData.expenditures[i].unitCompleted, 0) !== toNumber(oldPageData.expenditures[i].unitCompleted, 0))
				return true;
		}
		return false;
	}
	
	function actionObject(action, newPageData){
		this.action = action;
		this.pesaPlanId = newPageData.pesaPlanId;
		this.qprPesaId = newPageData.qprPesaId;
		this.additionalRequirement = toNumber(newPageData.additional, 0);
		this.isDirty = newPageData._isdirty;  // If form changed
		this.quarterId = newPageData.quarterId;
		this.expenditure = [];
		for(var i=0; i < newPageData.expenditures.length; ++i){
			var expObj = newPageData.expenditures[i];
			var insertObj = {};
			insertObj['expenditure'] = toNumber(expObj.expenditure);
			insertObj['unitCompleted'] = expObj.unitCompleted;
			insertObj['designationId'] = expObj.designationId;
			insertObj['qprPesaDetailsId'] = expObj.qprPesaDetailsId;
			insertObj['pesaPlanDetailsId'] = expObj.pesaPlanDetailsId;
			this.expenditure.push(insertObj);
		}
	}
	
	function performPost(postable, message){
		$http.post("postQuartExp.html?<csrf:token uri=postQuartExp.html/>", postable).then(
				function(response){
					if (!response.data.success){
						toastr.error(response.data.message);
					}else{
						var receivedData = response.data.data;
						if(!receivedData){
							receivedData = null;
						}else{
							receivedData['_isdirty'] = false;
						}
						$scope.pageData = angular.copy(receivedData);
						$scope.pageDataCache = angular.copy(receivedData);
						evaluateTotal($scope.pageData);
                        toastr.success(message);
                        $scope.qprPesa.$setPristine();
					}
				}, function(error){
					toastr.error(JSON.stringify(error, "\t"));
				}
			);
	}
	
	$scope.save = function (){
		evalIsDirty($scope.pageData, $scope.pageDataCache);
		if(!$scope.pageData['_isdirty']){
			toastr.error("No Changes");
			return;
		}
		for(var i=0; i < $scope.pageData.expenditures.length; ++i){
			var expenditure = $scope.pageData.expenditures[i];
			if(toNumber(expenditure.expenditure, -1) == -1){
				toastr.error("Expenditure is above approved limit please fix: " + 
						toNumber(expenditure.expenditure) + " > " + toNumber(expenditure.unitCompleted)*toNumber(expenditure.costApproved));
				return;
			}
		}
		
		performPost(new actionObject("save", $scope.pageData), "Form saved");	
	}

	
	$scope.onClear = function(){
		$scope.pageData = angular.copy($scope.pageDataCache);
		$scope.pageData['_isdirty'] = false;
	}
	
	$scope.freezUnFreezPesaPlan=function(freezUnfreez){
		if($scope.pageData['_isdirty']){
			toastr.error("Changes pending, either save or clear the form.");
			return;
		}
		performPost(new actionObject(freezUnfreez, $scope.pageData), "Form " + freezUnfreez + "ed");	
	}
	*/
    
    $scope.fetchData(0,0);
}]);