
	var lbCodes1=[];
	var selactivity1 =new Map();
	
	var panchatayBhawanidList=new Map();
	

var enablement=angular.module("publicModule",[]);

enablement.controller("enablementController",['$scope','enablementService', function($scope,enablementService){
	
	$scope.selGPs=0;
	$scope.totGPS=0;
	$scope.asSelGPs=0;
	$scope.asTotGPS=0;
	
	
	
	$( document ).ready(function() {
		fetchOnLoad();
	});
	
	
	
	$scope.clearPage=function(){
		fetchOnLoad();
	}
	
	function fetchOnLoad(){
		lbCodes1=[];
		selactivity1 =new Map();
		$scope.selGPs=0;
		$scope.totGPS=0;
		$scope.asSelGPs=0;
		$scope.asTotGPS=0;
		$scope.IsVisible=true;
		enablementService.getEEnablementMaster().then(function(response){
			if(response.data.length>0){
				$('#errorMessage').addClass('hide');
				$('#errorMessage').html('');
				$scope.eEnablementMasterList=response.data;
				angular.forEach($scope.eEnablementMasterList,function(item){
					if(item.eMasterId==1){
						$scope.totGPS=item.noofGPs;
						$scope.asTotGPS=item.aspirationalGPs;
						selactivity1.set("eEnablementDetailId"+item.eMasterId,item.eEnablementDetailId);
						$scope.isDisabled5 = false;
						cbActivityDetailsId=selactivity1.get("eEnablementDetailId"+1);
						enablementService.getactivityGPs(cbActivityDetailsId).then(function(response){
							if(response.data.length >0){
								angular.forEach(response.data,function(item){
									$scope.selGPs=$scope.selGPs+1;
									if(!selactivity1.has("dlc_"+item.localBodyCode)){
										selactivity1.set("dlc_"+item.localBodyCode,item.districtCode)
									}
									
									lbCodes1.push(item.localBodyCode);
									selactivity1.set("eEnablementGpsId"+item.localBodyCode,item.eEnablementGpsId);
									if(item.aspirationalGps==true &&  !selactivity1.has("AspirationalGPs_"+item.localBodyCode)){
										selactivity1.set("AspirationalGPs_"+item.localBodyCode,item.localBodyCode);
										$scope.asSelGPs=$scope.asSelGPs+1;
									}
								});
							}
							
						});
						
					}
					
				});
			}else{
				$('#errorMessage').addClass('show');
				$('#errorMessage').html('Plan has been not Approved by CEC.');
				$scope.IsVisible=false;
			}
	
			
		});
		enablementService.getAllDistrict().then(function(response){
			$scope.districtCodes=response.data;
		});
		
		
	
	}
	
	
	
	
	$scope.showGaramPanchayatModal = function(selected,activityId,eMasterId,eName){
		console.log("inside showGaramPanchayatModal fn");
		if(!selected){
			toastr.error("Please select district");
			
		}else{
			selActivityId=eMasterId;
			
			angular.forEach($scope.districtCodes,function(item){
			  	if(item.districtCode == selected)
			  		$scope.selectDistrictCode = item;
			});
			
			enablementService.getAllGramPanchayat(selected).then(function(response){
				$scope.lbCodes = response.data;
				$scope.createContentGPModal(eName);
			});
		}
	}
	
	
	$scope.createContentGPModal = function(eName){
		
		 $("#garamPanchayatBody").empty();
		 var divTemplate = $("#garamPanchayatBody");
		 activityName=null;
		 
		 $("#garamPanchayatHead").text(eName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");
		 
		 table=$("<table/>");
		 table.attr("id", "example");
		 table.addClass("table table-hover dashboard-task-infos");
		
		 thead=$("<thead/>");
		 
		 tr=$("<TR/>");
		 
		 th=createLabel("Select Panchayat");
		 tr.append(th);
		 
		 th=createLabel("IS Aspirational GPs");
		 tr.append(th);
		 
		 th=createLabel("Select Panchayat");
		 tr.append(th);
		 
		 th=createLabel("IS Aspirational GPs");
		 tr.append(th);
		 
		 th=createLabel("Select Panchayat");
		 tr.append(th);
		 
		 th=createLabel("IS Aspirational GPs");
		 tr.append(th);
		 
		
		 tr.append(th);
		 
		
		 thead.append(tr);
		 
		 table.append(thead);
		 
		 tbody=$("<tbody/>");
		 
		 angular.forEach($scope.lbCodes,function(item,key){
		
			 if(key>0 && key%3==0){
				 tbody.append(tr);
				 table.append(tbody);
				}
			 
			if(key==0 || key%3==0){
				tr=$("<TR/>");
			}
			 
			 
			 td=createFirstTD(item[1],item[0]);
			 tr.append(td);
			 
			 td=createCheckbox("AspirationalGPs",$scope.selectDistrictCode.districtCode,item[0]);
			 tr.append(td);
			 
		});
		
		 divTemplate.append(table); 
		 callDatatable();
		 //$('#example').DataTable();
		 
		
		 
		 $('#garamPanchayatModal').modal('show');
	}
	
	var createLabel=function (labelName){
		 th=$("<TH/>");
		 templateLabel = $("<label/>");
		 templateLabel.html(labelName);
		 th.append(templateLabel);
		 return th;
	};
	
	var createFirstTD=function (labelName,gpCode){
		 td=$("<TD/>");
		 
		 templateInput = $("<input/>");
		 templateInput.attr("type", "checkbox");
		 templateInput.attr("name", "chkEntity");
		 if(selActivityId==1 && lbCodes1.includes(gpCode)){
			 $( templateInput ).prop('checked', true);		 
		 }
		 templateInput.attr("id", "chkEntity_"+$scope.selectDistrictCode.districtCode+"_"+gpCode);
		 td.append(templateInput);
		 
		 templateLabel = $("<label/>");
		 templateLabel.html(labelName);
		 td.append(templateLabel);
		 return td;
	};
	
	var createCheckbox=function (labelName,districtCode,lbCode){
		 td=$("<TD/>");
		 templateInput = $("<input/>");
		 templateInput.attr("type", "checkbox");
		 templateInput.attr("name", "activityItem");
		 if(lbCodes1.includes(lbCode)){
			 if(selActivityId==1 && selactivity1.has(labelName+"_"+lbCode)){
				 $( templateInput ).prop('checked', true);	
			 }
		 }
		 else{
		 templateInput.attr("disabled", "true");
		}
		 
		 
		 templateInput.attr("id", "chk_"+districtCode+"_"+lbCode+"_"+labelName);
		 td.append(templateInput);
		 return td;
	};
	
	
	
	$scope.SaveData = function(){
		$('#garamPanchayatModal').modal('hide');
	}
	
	function callDatatable(){
		$('#example').dataTable({
	        "lengthMenu": [[ 25,50,100, -1], [25, 50,100, "All"]],
	         
	    });	
		
		
		$('INPUT[name=activityItem]').change(function(){
			saveEntity(this);
		});
		
		$('INPUT[name=chkEntity]').change(function(){
			
			
			idArr=$(this).attr('id').split("_");
				
			if(selActivityId==1){
				temp=idArr[2];
				if(!lbCodes1.includes(temp)){
					if($(this).is(':checked') ){
						if( $scope.totGPS>$scope.selGPs){
							$scope.selGPs=$scope.selGPs+1;
							lbCodes1.push(parseInt(temp));
							selactivity1.set("dlc_"+idArr[2],idArr[1]);
						}else{
							$(this).prop('checked', false);
							toastr.error("You are select maximum GPS of activity");
						}
						
					}else{
						 var index = lbCodes1.indexOf(parseInt(temp));
						 	if (index > -1) {
						    	lbCodes1.splice(index, 1);
						   }
						 	
						 	if(selactivity1.has("dlc"+idArr[2])){
						 		selactivity1.delete("dlc"+idArr[2]);
						 	}
						 	if($scope.selGPs>0){
						 		$scope.selGPs=$scope.selGPs-1
						 	}
						 	
					}
					
				}
				
			}
		
			
			idArr=$(this).attr('id').split("_");
			id="chk_"+idArr[1]+"_"+idArr[2];
			if($(this).is(':checked')){
				enabledDisabledActivity(id,false);
			}else{
				enabledDisabledActivity(id,true);
			}
			
		});
	} 
	
	function saveEntity(obj){	
		lb=$(obj).attr('id').split("_")[2]
		if($(obj).is(':checked')){
			if( $scope.asTotGPS>$scope.asSelGPs){
				if(selActivityId==1 && !selactivity1.has("AspirationalGPs_"+lb)){
					selactivity1.set("AspirationalGPs_"+lb,$(obj).attr('id'));
				}
				$scope.asSelGPs=$scope.asSelGPs+1;
			}else{
				$(this).prop('checked', false);
				toastr.error("You are select maximum Aspirational GPS of activity");
			}
			
			
		}else{
			if($scope.asSelGPs>0){
		 		$scope.asSelGPs=$scope.asSelGPs-1
		 	}
			if(selActivityId==1 && selactivity1.has("AspirationalGPs_"+lb)){
				selactivity1.delete("AspirationalGPs_"+lb);
			}
		}
	}
	
	function enabledDisabledActivity(id,flag){
		$( "#"+id+"_AspirationalGPs" ).prop( "disabled", flag );	
		if(flag){
			$( "#"+id+"_AspirationalGPs" ).prop('checked', false);	
		}
	}
	
	$scope.savePanchayatBhawanData = function(){
		var pbProposedInfo=[];
		
		$.each( lbCodes1, function( index, value ) {
			AspirationalGPs=false;
			eEnablementGpsId=null;
			if(selactivity1.has("eEnablementGpsId"+value)){
				eEnablementGpsId=selactivity1.get("eEnablementGpsId"+value);
			}
			districtCode=	parseInt(selactivity1.get("dlc_"+value));
	   
	    if(selactivity1.has("AspirationalGPs_"+value)){
	    	AspirationalGPs=true;
	    }
	    
		
	    	
		myObj= {
				    "localBodyCode" : value,    //your artist variable
				    "districtCode" : districtCode ,  //your title variable
				    "eEnablementDetailsId":selactivity1.get("eEnablementDetailId"+1),
				    "eEnablementGpsId" : eEnablementGpsId,  
				    "aspirationalGps" : AspirationalGPs,
				 
				};
	    	
	    	
	    	
	    	pbProposedInfo.push( myObj );
		});
		
		if(pbProposedInfo.length>0){
			enablementService.savefFinalizeWorkLocation(pbProposedInfo).then(function(response){
		    	if(response!=null && response.status==200){
		    		toastr.success(response.data.responseMessage);
		    	}else{
		    		toastr.error(response.data.responseMessage);
		    	}
		    	fetchOnLoad();
		    });
	    }else{
	    	toastr.error("please select at lease one GPs");
	    }
	 
	}
	
	
	
	
}]);