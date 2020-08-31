/**
 * 
 */

var app = angular.module('qGovProgressApp', ['ngMessages']);
app.controller('qGovProgressCtrl', qGovProgressCtrlImp); 
        
function qGovProgressCtrlImp($scope, $http) {
    $scope.selectedQuarterId = "0";
    $scope.formObj = null;
    $scope._formObj = null;
    $scope.actionDisable=false;

    function actionObject(action, newPageData){
        this.action = action;
        this.quarterId = newPageData.quarterId;
        this.egovSupportActivityId = newPageData.egovSupportActivityId;
        this.qprEGovId = newPageData.qprEGovId;
        this.addReqSpmu = toNumber(newPageData.addReqSpmu, 0);
        this.addReqDpmu = toNumber(newPageData.addReqDpmu, 0);
        this.isNew = newPageData.isNew;
        this.expenditures = [];
        for(var i=0; i < newPageData.expenditures.length; ++i){
            var expObj = newPageData.expenditures[i];
            var insertObj = {};
            insertObj['egovSupportActivityDetailsId'] = expObj.egovSupportActivityDetailsId;
            insertObj['qprEGovDetailsId'] = expObj.qprEGovDetailsId;
            insertObj['egovPostLevelId'] = expObj.egovPostLevelId;
            insertObj['egovPostId'] = expObj.egovPostId;
            insertObj['postFilled'] = toNumber(expObj.postFilled);
            insertObj['incurred'] = toNumber(expObj.incurred, 0);
            this.expenditures.push(insertObj);
        }
    }

    function load(gObj) {
        $scope.formObj = angular.copy(gObj);
        $scope.spmu=  $scope.formObj.subcomponentwiseQuaterBalanceList[0].balanceAmount;
        $scope.dpmu=  $scope.formObj.subcomponentwiseQuaterBalanceList[1].balanceAmount;
        $scope._formObj = gObj;
        resetForm();
    }

    function startLoad(quarterId) {
        if(quarterId == 0){
            load(null);
            return;
        }
        $http.get("getPostApproveReport.html?qid="+ quarterId +"&<csrf:token uri=getPostApproveReport.htm/>").then(
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
        $http.post("postPostApproveReport.html?<csrf:token uri=postPostApproveReport.htm/>", postable).then(
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
        if($scope.pageForm.$invalid){
            return toastr.error("There are errors in form, please correct.");
        }
        
        if(validate_data()){
        	performPost(new actionObject("save", $scope.formObj), "Form saved");
        }
        
    }

    function clear() {
        if(!$scope.pageForm.$dirty)
            return swal("No changes");
        $scope.formObj = angular.copy($scope._formObj);
        resetForm();
    }

    function freezeUnfreeze() { 
    	  if(validate_data()){
    		  freezUnfreez = $scope.formObj.isFreeze ? 'unfreeze' : 'freeze' ;       
    	        performPost(new actionObject(freezUnfreez, $scope.formObj), "Form " + freezUnfreez + "d");
    	  }
       
    }

    function toNumber(val, def){
        def = angular.isUndefined(def) ? 0: def;
        if(angular.isString(val)){
            newVal = parseInt(val, 10);
            if(isFinite(newVal))
                return newVal;
            return def;
        }
        if( angular.isUndefined(val) || val == null)
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
            total += $scope.formObj.expenditures[i].incurred;
        return total;
    }
    
    function getTotalExpenditure(){
        var total = 0;
        if($scope.formObj == null){
            return total;
        }
        total += getExpenditure();
        total += toNumber($scope.formObj.addReqSpmu) + toNumber($scope.formObj.addReqDpmu);
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
    
    $scope.validate_expenditureIncurred = function (index){
    	
		for(var i=0; i < $scope.formObj.expenditures.length; ++i){
			$("#error_incurred_"+i).text("");
			$("#error_incurred_"+i).removeClass('errormsg show');
        }
		
        var totalSMPU = 0;
        var totalDMPU = 0;
        if($scope.formObj == null){
            return total;
        }
        for(var i=0; i < $scope.formObj.expenditures.length; ++i){
        	if(i<4){
        		totalSMPU += $scope.formObj.expenditures[i].incurred;	
        	}else if(i<8){
        		totalDMPU+= $scope.formObj.expenditures[i].incurred;	
        	}
        }
        total=index<4?totalSMPU:totalDMPU;
        bal=index<4?$scope.spmu:$scope.dpmu;
        if(total>bal){
        	$("#error_incurred_"+index).text("expenditure Incurred must be less then balance amount");
			$("#error_incurred_"+index).addClass('errormsg show');
			$( "#incurred_"+index ).val('');
			$("#incurred_"+index).focus();
			
        }
            
        
    }
    
 validate_data = function (){
	 
	 for(var i=0; i < $scope.formObj.expenditures.length; ++i){
			$("#error_incurred_"+i).text("");
			$("#error_incurred_"+i).removeClass('errormsg show');
			$("#error_postFilled_"+i).text("");
			$("#error_postFilled_"+i).removeClass('errormsg show');
     }
    	
	 var flag=true;
	  var totalSMPU = 0;
      var totalDMPU = 0;
        for(var i=0; i < $scope.formObj.expenditures.length; ++i){
        	if(i<4){
        		totalSMPU += $scope.formObj.expenditures[i].incurred;	
        	}else if(i<8){
        		totalDMPU+= $scope.formObj.expenditures[i].incurred;	
        	}
        	
        	if($scope.formObj.expenditures[i].incurred>0){
        		if($scope.formObj.expenditures[i].postFilled<=0){
        			flag=false;
        			$("#error_postFilled_"+i).text("No of Post not filled, so please fill No of Post");
        			$("#error_postFilled_"+i).addClass('errormsg show');
        		}
        	}
        	
        }
        if(totalSMPU>$scope.spmu){
        	flag=false;
        	alert("expenditure Incurred SPMU must be less then balance amount SPMU");
        }
        if(totalDMPU>$scope.dpmu){
        	flag=false;
        	alert("expenditure Incurred DPMU must be less then balance amount DPMU");
        }
       
        return flag;    
        
    }

    $scope.save = save;
    $scope.clear = clear;
    $scope.freezeUnfreeze = freezeUnfreeze;
    $scope.close = close;
    
    $scope.getExpenditure = getExpenditure;
    $scope.getTotalExpenditure = getTotalExpenditure;
}

qGovProgressCtrlImp.$inject = ['$scope', '$http'];
