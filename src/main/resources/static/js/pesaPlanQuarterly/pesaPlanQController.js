var publicModule = angular.module("publicModule", ['ngMessages']);
publicModule.controller("pesaPlanQController", [ '$scope', '$http',
		function($scope, $http) {

	$scope.selectedQuarterId = 0;
    $scope.formObj = null;
    $scope._formObj = null;
	
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
        if(quarterId == 0){
            load(null);
            return;
        }
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
                load(receivedData);
            }, function(error){
                toastr.error(JSON.stringify(error, "\t"));
            }
        );
    }

    function performPost(postable, message, successCallback) {
        $http.post("postQuartExp.html?<csrf:token uri=postQuartExp.html/>", postable).then(
            function(response){
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
                toastr.error(JSON.stringify(error, "\t"));
            }
        );
    }

    function save() {
        if($scope.pageForm.$invalid){
            return toastr.error("There are errors in form, please correct.");
        }
        performPost(new actionObject("save", $scope.formObj), "Form saved");
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
        if($scope.pageForm.$dirty){

            swal({
                title: "Are you sure?",
                text: "You have unsaved changes, Once navigated, your changes will be lost. Either save or clear the form before proceeding",
                type: "warning",
                showCancelButton: true,
                confirmButtonText: "Proceed",
                cancelButtonText: "Stay",
                closeOnConfirm: true,
                closeOnCancel: true
            }, function (isConfirm) {
                if (isConfirm) {
                    startLoad(quarterId);
                }else{
                    $scope.selectedQuarterId = oldVal;
                }
                $scope.$digest();
                return false;
            });
            return true;
        }
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
}]);