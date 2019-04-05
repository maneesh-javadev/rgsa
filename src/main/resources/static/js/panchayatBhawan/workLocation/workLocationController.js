
	var lbCodes1=[];
	var selactivity1 =new Map();
	var lbCodes2=[];
	var selactivity2 =new Map();
	var lbCodes3=[];
	var selactivity3 =new Map();
	var panchatayBhawanidList=new Map();
	

var workLocation=angular.module("publicModule",[]);

workLocation.controller("workLocationController",['$scope','workLocationService',function($scope,workLocationService){
	
	
	
	var selActivityId=null;
	
	fetchOnLoad();
	
	$scope.clearPage=function(){
		fetchOnLoad();
	}
	
	function fetchOnLoad(){
		
		$scope.selGPs1=0;
		$scope.selGPs2=0;
		$scope.selGPs3=0;
		$scope.totGPS1=0;
		$scope.totGPS2=0;
		$scope.totGPS3=0;
		
		lbCodes1=[];
		selactivity1 =new Map();
		lbCodes2=[];
		selactivity2 =new Map();
		lbCodes3=[];
		selactivity3 =new Map();
		panchatayBhawanidList=new Map();	
		
	workLocationService.getPanchayatBhawanActivity().then(function(response){
		if(response.data.PANCHAYAT_BHAWAN_ACTIVITY!=null && response.data.PANCHAYAT_BHAWAN_ACTIVITY.panchatayBhawanActivityDetails.length>0){
			$('#errorMessage').addClass('hide');
			$('#errorMessage').html('');
			$scope.isSaveVisible=true;
			$scope.activityList=response.data.PANCHAYAT_ACTIVITY;
			$scope.districtCodes=response.data.DISTRICT_LIST;
			if(response.data.PANCHAYAT_BHAWAN_ACTIVITY!=undefined){
				$scope.panchayatBhawanActivity=response.data.PANCHAYAT_BHAWAN_ACTIVITY.panchatayBhawanActivityDetails;
				angular.forEach($scope.panchayatBhawanActivity,function(item){
					if(item.activity.activityId==1){
						$scope.totGPS1=item.noOfGPs;
					}else if(item.activity.activityId==2){
						$scope.totGPS2=item.noOfGPs;
					}else  if(item.activity.activityId==3){
						$scope.totGPS3=item.noOfGPs;
					}
					if(!panchatayBhawanidList.has(item.activity.activityId)){
						panchatayBhawanidList.set(item.activity.activityId,item.id);
						if(panchatayBhawanidList.has(1) && panchatayBhawanidList.has(2) && panchatayBhawanidList.has(3)){
							loadinit_data();
						}
					}
				});
			}
		}
		else{
			$('#errorMessage').addClass('show');
			$('#errorMessage').html('Plan has been not Approved by CEC.');
			$scope.isSaveVisible=false;
			}
		});
	
	
		
			
			
	}
	
	
	function loadinit_data(){
		workLocationService.getactivityGPs(panchatayBhawanidList.get(1)).then(function(response){
			if(response.data.length >0){
				angular.forEach(response.data,function(item){
					$scope.selGPs1=$scope.selGPs1+1;
					lbCodes1.push(item.localBodyCode);
					
					if(!selactivity1.has("dlc_"+item.localBodyCode)){
						selactivity1.set("dlc_"+item.localBodyCode,item.districtCode);
					}
					
					id="remark_"+item.districtCode+"_"+item.localBodyCode;
					if(!selactivity1.has(id) && item.remarks!=null && item.remarks.length>0){
						selactivity1.set(id,item.remarks);
			
					}
					
					if(item.landIdentified && !selactivity1.has("landIdentified_"+item.localBodyCode)){
						setEntity("landIdentified",item.districtCode,item.localBodyCode,1);
					}
					if(item.approvedMap && !selactivity1.has("approvedMap_"+item.localBodyCode)){
						setEntity("approvedMap",item.districtCode,item.localBodyCode,1);
					}
					if(item.separateToilet && !selactivity1.has("separateToilet_"+item.localBodyCode)){
						setEntity("separateToilet",item.districtCode,item.localBodyCode,1);
					}
					if(item.barrierFreeAccess && !selactivity1.has("barrierFreeAccess_"+item.localBodyCode)){
						setEntity("barrierFreeAccess",item.districtCode,item.localBodyCode,1);
					}
					if(item.waterFacility && !selactivity1.has("waterFacility_"+item.localBodyCode)){
						setEntity("waterFacility",item.districtCode,item.localBodyCode,1);
					}
					if(item.internetFacility && !selactivity1.has("internetFacility_"+item.localBodyCode)){
						setEntity("internetFacility",item.districtCode,item.localBodyCode,1);
					}
					
					if(item.electricity && !selactivity1.has("electricity_"+item.localBodyCode)){
						setEntity("electricity",item.districtCode,item.localBodyCode,1);
					}
					
					
				});
			}
			
		});
		
		workLocationService.getactivityGPs(panchatayBhawanidList.get(2)).then(function(response){
			if(response.data.length >0){
				angular.forEach(response.data,function(item){
					$scope.selGPs2=$scope.selGPs2+1;
					lbCodes2.push(item.localBodyCode);
				
					if(!selactivity2.has("dlc_"+item.localBodyCode)){
						selactivity2.set("dlc_"+item.localBodyCode,item.districtCode);
					}
					
					id="remark_"+item.districtCode+"_"+item.localBodyCode;
					if(!selactivity2.has(id) && item.remarks!=null && item.remarks.length>0){
						selactivity2.set(id,item.remarks);
					}
					
					if(item.landIdentified && !selactivity2.has("landIdentified_"+item.localBodyCode)){
						setEntity("landIdentified",item.districtCode,item.localBodyCode,2);
					}
					if(item.approvedMap && !selactivity2.has("approvedMap_"+item.localBodyCode)){
						setEntity("approvedMap",item.districtCode,item.localBodyCode,2);
					}
					if(item.separateToilet && !selactivity2.has("separateToilet_"+item.localBodyCode)){
						setEntity("separateToilet",item.districtCode,item.localBodyCode,2);
					}
					if(item.barrierFreeAccess && !selactivity2.has("barrierFreeAccess_"+item.localBodyCode)){
						setEntity("barrierFreeAccess",item.districtCode,item.localBodyCode,2);
					}
					if(item.waterFacility && !selactivity2.has("waterFacility_"+item.localBodyCode)){
						setEntity("waterFacility",item.districtCode,item.localBodyCode,2);
					}
					if(item.internetFacility && !selactivity2.has("internetFacility_"+item.localBodyCode)){
						setEntity("internetFacility",item.districtCode,item.localBodyCode,2);
					}
					
					if(item.electricity && !selactivity2.has("electricity_"+item.localBodyCode)){
						setEntity("electricity",item.districtCode,item.localBodyCode,2);
					}
					
					
				});
			}
			
		});
		
		
		workLocationService.getactivityGPs(panchatayBhawanidList.get(3)).then(function(response){
			if(response.data.length >0){
				angular.forEach(response.data,function(item){
					lbCodes3.push(item.localBodyCode);
					$scope.selGPs3=$scope.selGPs3+1;
					if(!selactivity3.has("dlc_"+item.localBodyCode)){
						selactivity3.set("dlc_"+item.localBodyCode,item.districtCode);
					}
					
					id="remark_"+item.districtCode+"_"+item.localBodyCode;
					if(!selactivity3.has(id) && item.remarks!=null && item.remarks.length>0){
						selactivity3.set(id,item.remarks);
					}
					
					if(item.landIdentified && !selactivity3.has("landIdentified_"+item.localBodyCode)){
						setEntity("landIdentified",item.districtCode,item.localBodyCode,3);
					}
					if(item.approvedMap && !selactivity3.has("approvedMap_"+item.localBodyCode)){
						setEntity("approvedMap",item.districtCode,item.localBodyCode,3);
					}
					if(item.separateToilet && !selactivity3.has("separateToilet_"+item.localBodyCode)){
						setEntity("separateToilet",item.districtCode,item.localBodyCode,3);
					}
					if(item.barrierFreeAccess && !selactivity3.has("barrierFreeAccess_"+item.localBodyCode)){
						setEntity("barrierFreeAccess",item.districtCode,item.localBodyCode,3);
					}
					if(item.waterFacility && !selactivity3.has("waterFacility_"+item.localBodyCode)){
						setEntity("waterFacility",item.districtCode,item.localBodyCode,3);
					}
					if(item.internetFacility && !selactivity3.has("internetFacility_"+item.localBodyCode)){
						setEntity("internetFacility",item.districtCode,item.localBodyCode,3);
					}
					
					if(item.electricity && !selactivity3.has("electricity_"+item.localBodyCode)){
						setEntity("electricity",item.districtCode,item.localBodyCode,3);
					}
					
					
				});
			}
			
		});
	}
	
	function setEntity(entityName,dlc,lbcode,selId){
	
		
		if(selId==1 && !selactivity1.has(entityName+"_"+lbcode)){
			selactivity1.set(entityName+"_"+lbcode,"chk_"+dlc+"_"+lbcode+"_"+entityName);
		}else if(selId==2 && !selactivity2.has(entityName+"_"+lbcode)){
			selactivity2.set(entityName+"_"+lbcode,"chk_"+dlc+"_"+lbcode+"_"+entityName);
		}else if(selId==3 && !selactivity3.has(entityName+"_"+lbcode)){
			selactivity3.set(entityName+"_"+lbcode,"chk_"+dlc+"_"+lbcode+"_"+entityName);
		}
		
		
		
	}
	
	
	$scope.showGaramPanchayatModal = function(selected,activityId){
		console.log("inside showGaramPanchayatModal fn");
		if(!selected){
			toastr.error("Please select district");
			
		}else{
			selActivityId=activityId;
			
			angular.forEach($scope.districtCodes,function(item){
			  	if(item.districtCode == selected)
			  		$scope.selectDistrictCode = item;
			});
			
			workLocationService.getAllGramPanchayat(selected).then(function(response){
				$scope.lbCodes = response.data;
				$scope.createContentGPModal();
			});
		}
	}
	
	$scope.filterLbCodes=[];
	
	
	$scope.filterLbCodesFn = function(){
		$scope.filterLbCodes=[];
		if(selActivityId==1){
			angular.forEach($scope.lbCodes,function(item){
				if(!(lbCodes2.includes(item[0]) || lbCodes3.includes(item[0]))){
					$scope.filterLbCodes.push(item);
				}
			  		
			});
		}else if(selActivityId==2){
			angular.forEach($scope.lbCodes,function(item){
				if(!(lbCodes1.includes(item[0]) || lbCodes3.includes(item[0]))){
					$scope.filterLbCodes.push(item);
				}
			  		
			});
		}else if(selActivityId==3){
			angular.forEach($scope.lbCodes,function(item){
				if(!(lbCodes1.includes(item[0]) || lbCodes2.includes(item[0]))){
					$scope.filterLbCodes.push(item);
				}
			  		
			});
		}
		
	}
	
	$scope.createContentGPModal = function(){
		$scope.filterLbCodesFn();
		 $("#garamPanchayatBody").empty();
		 var divTemplate = $("#garamPanchayatBody");
		 activityName=null;
		 if(selActivityId==1){
			 activityName="Construction of new Panchayat Bhawan";
		 }else if(selActivityId==2){
			 activityName="Repair of Panchayat Bhawan";
		 }else if(selActivityId==3){
			 activityName="Co-location of CSC with Panchayat Bhawan";
		 }
		 $("#garamPanchayatHead").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");
		 
		 table=$("<table/>");
		 table.attr("id", "example");
		 table.addClass("table table-hover dashboard-task-infos");
		
		 thead=$("<thead/>");
		 
		 tr=$("<TR/>");
		 
		 th=createLabel("Select Panchayat");
		 tr.append(th);
		 
		 th=createLabel("Panchayat Name");
		 tr.append(th);
		 
		 th=createLabel("Land Identified");
		 tr.append(th);
		
		 th=createLabel("Design/ Layout/ Map Approved");
		 tr.append(th);
		 
		 th=createLabel("Provision for Separate Toilet");
		 tr.append(th);
		 
		 th=createLabel("Provision for Barrier free Access");
		 tr.append(th);
		
		 th=createLabel("Provision for Water Facility");
		 tr.append(th);
		 
		 th=createLabel("Provision for Internet Facility");
		 tr.append(th);
		 
		 th=createLabel("Provision for Electricity");
		 tr.append(th);
		 
		 th=createLabel("Remarks");
		 tr.append(th);
		 
		 thead.append(tr);
		 
		 table.append(thead);
		 
		 tbody=$("<tbody/>");
		 
		 angular.forEach($scope.filterLbCodes,function(item){
			
			
			 tr=$("<TR/>");
			 
			 td=$("<TD/>");
			 templateInput = $("<input/>");
			 templateInput.attr("type", "checkbox");
			 templateInput.attr("name", "chkEntity");
			 if(selActivityId==1 && lbCodes1.includes(item[0])){
				 $( templateInput ).prop('checked', true);		 
			 }else if(selActivityId==2 && lbCodes2.includes(item[0])){
				 $( templateInput ).prop('checked', true);		 
			 }else if(selActivityId==3 && lbCodes3.includes(item[0])){
				 $( templateInput ).prop('checked', true);		 
			 }
			 templateInput.attr("id", "chkEntity_"+$scope.selectDistrictCode.districtCode+"_"+item[0]);
			 td.append(templateInput);
			 tr.append(td);
			 
			 td=createLabel(item[1]);
			 tr.append(td);
			 
			 td=createCheckbox("landIdentified",$scope.selectDistrictCode.districtCode,item[0]);
			 tr.append(td);
			 
			 td=createCheckbox("approvedMap",$scope.selectDistrictCode.districtCode,item[0]);
			 tr.append(td);
			 
			 td=createCheckbox("separateToilet",$scope.selectDistrictCode.districtCode,item[0]);
			 tr.append(td);
			 
			 td=createCheckbox("barrierFreeAccess",$scope.selectDistrictCode.districtCode,item[0]);
			 tr.append(td);
			 
			 td=createCheckbox("waterFacility",$scope.selectDistrictCode.districtCode,item[0]);
			 tr.append(td);
			 
			 td=createCheckbox("internetFacility",$scope.selectDistrictCode.districtCode,item[0]);
			 tr.append(td);
			 
			 td=createCheckbox("electricity",$scope.selectDistrictCode.districtCode,item[0]);
			 tr.append(td);
			 
			 td=$("<TD/>");
			 templateInput = $("<input/>");
			 templateInput.attr("type", "text");
			 
			 var remarkval=null;
			 templateInput.attr("id", "remark_"+$scope.selectDistrictCode.districtCode+"_"+item[0]);
			 templateInput.attr("name", "remark");
			 templateInput.attr("disabled", true);
			 if(selActivityId==1 && lbCodes1.includes(item[0])){
				 templateInput.attr("disabled", false);
				 if( selactivity1.has("remark_"+$scope.selectDistrictCode.districtCode+"_"+item[0])){
					 remarkval=selactivity1.get("remark_"+$scope.selectDistrictCode.districtCode+"_"+item[0]);
				 }
			 }else if(selActivityId==2 && lbCodes2.includes(item[0])){
				 templateInput.attr("disabled", false);
				 if( selactivity2.has("remark_"+$scope.selectDistrictCode.districtCode+"_"+item[0])){
						remarkval=selactivity2.get("remark_"+$scope.selectDistrictCode.districtCode+"_"+item[0]);
					}
			 }else if(selActivityId==3 && lbCodes3.includes(item[0])){
				 if(selactivity3.has("remark_"+$scope.selectDistrictCode.districtCode+"_"+item[0])){
					 remarkval=selactivity3.get("remark_"+$scope.selectDistrictCode.districtCode+"_"+item[0]); 
				}
				 templateInput.attr("disabled", false);
			 }
			 
			 templateInput.attr("value",remarkval);
			 
			 td.append(templateInput);
			 tr.append(td);
			 tbody.append(tr);
			 table.append(tbody);
			 
			 
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
	
	var createCheckbox=function (labelName,districtCode,lbCode){
		 td=$("<TD/>");
		 templateInput = $("<input/>");
		 templateInput.attr("type", "checkbox");
		 templateInput.attr("name", "activityItem");
		 if(lbCodes1.includes(lbCode) || lbCodes2.includes(lbCode) || lbCodes3.includes(lbCode)){
			 if(selActivityId==1 && selactivity1.has(labelName+"_"+lbCode)){
				 $( templateInput ).prop('checked', true);	
			 }else if(selActivityId==2 && selactivity2.has(labelName+"_"+lbCode)){
				 $( templateInput ).prop('checked', true);	
			 }else if(selActivityId==3 && selactivity3.has(labelName+"_"+lbCode)){
				 $( templateInput ).prop('checked', true);	
			 }
		 }
		 else{
		 templateInput.attr("disabled",true);
		}
		 
		 
		 templateInput.attr("id", "chk_"+districtCode+"_"+lbCode+"_"+labelName);
		 td.append(templateInput);
		 return td;
	};
	
	
	
	$scope.SaveData = function(){
		
			
		/*$.each($("input[name='chkEntity']"), function(){            
			idArr=$(this).attr('id').split("_");
			
			if($(this).is(':checked')){
				id="remark_"+idArr[1]+"_"+idArr[2];
				idval=$("#"+id).val();
				if(selActivityId==1 && idval!="" && idval.trim().length>0){
				selactivity1.set(id,idval);

				}
				else if(selActivityId==2 && idval!="" && idval.trim().length>0){
					selactivity2.set(id,idval);
				}else if(selActivityId==3 && idval!="" && idval.trim().length>0){
					selactivity3.set(id,idval);
				}
			}
			
			if(selActivityId==1){
				temp=idArr[2];
				if(!lbCodes1.includes(temp)){
					if($(this).is(':checked')){
						lbCodes1.push(parseInt(temp));
						selactivity1.set("dlc_"+idArr[2],idArr[1]);
					}else{
						 var index = lbCodes1.indexOf(parseInt(temp));
						 	if (index > -1) {
						    	lbCodes1.splice(index, 1);
						   }
						 	
						 	if(selactivity1.has("dlc"+idArr[2])){
						 		selactivity1.delete("dlc"+idArr[2]);
						 	}
					}
					
				}
				
			}else if(selActivityId==2){
				temp=idArr[2]
				if(!lbCodes2.includes(temp)){
					if($(this).is(':checked')){
						lbCodes2.push(parseInt(temp));
						
					}else{
						 var index = lbCodes2.indexOf(parseInt(temp));
						 	if (index > -1) {
						 		lbCodes2.splice(index, 1);
						   }
					
					}
				}
				
			}else if(selActivityId==3){
				temp=idArr[2]
				if(!lbCodes3.includes(temp)){
					if($(this).is(':checked')){
						lbCodes3.push(parseInt(temp));
					}else{
						 var index = lbCodes3.indexOf(parseInt(temp));
						 	if (index > -1) {
						 		lbCodes3.splice(index, 1);
						   }
					}
				}
				
			}
			id="chk_"+idArr[1]+"_"+idArr[2];
			saveEntity(id,idArr[2]);
			
	    });*/
		
		 $('#garamPanchayatModal').modal('hide');
	}
	
	
	
	function saveEntity(id,lb){
		obj=$("#"+id+"_landIdentified"); 
		if($(obj).is(':checked')){
			if(selActivityId==1 && !selactivity1.has("landIdentified_"+lb)){
				selactivity1.set("landIdentified_"+lb,$(obj).attr('id'));
			}else if(selActivityId==2 && !selactivity2.has("landIdentified_"+lb)){
				selactivity2.set("landIdentified_"+lb,$(obj).attr('id'));
			}else if(selActivityId==3 && !selactivity3.has("landIdentified_"+lb)){
				selactivity3.set("landIdentified_"+lb,$(obj).attr('id'));
			}
			
		}else{
			if(selActivityId==1 && selactivity1.has("landIdentified_"+lb)){
				selactivity1.delete("landIdentified_"+lb);
			}else if(selActivityId==2 && selactivity2.has("landIdentified_"+lb)){
				selactivity2.delete("landIdentified_"+lb);
			}else if(selActivityId==3 && !selactivity3.has("landIdentified_"+lb)){
				selactivity3.delete("landIdentified_"+lb);
			}
		}
		
		obj=$("#"+id+"_approvedMap"); 
		if($(obj).is(':checked')){
			
			if(selActivityId==1 && !selactivity1.has("approvedMap_"+lb)){
				selactivity1.set("approvedMap_"+lb,$(obj).attr('id'));
			}else if(selActivityId==2 && !selactivity2.has("approvedMap_"+lb)){
				selactivity2.set("approvedMap_"+lb,$(obj).attr('id'));
			}else if(selActivityId==3 && !selactivity3.has("approvedMap_"+lb)){
				selactivity3.set("approvedMap_"+lb,$(obj).attr('id'));
			}
		}else{
			if(selActivityId==1 && selactivity1.has("approvedMap_"+lb)){
				selactivity1.delete("approvedMap_"+lb);
			}else if(selActivityId==2 && selactivity2.has("approvedMap_"+lb)){
				selactivity2.delete("approvedMap_"+lb);
			}else if(selActivityId==3 && selactivity3.has("approvedMap_"+lb)){
				selactivity3.delete("approvedMap_"+lb);
			}
		}
		
		obj=$("#"+id+"_separateToilet"); 
		if($(obj).is(':checked')){
			if(selActivityId==1 && !selactivity1.has("separateToilet_"+lb)){
				selactivity1.set("separateToilet_"+lb,$(obj).attr('id'));
			}else if(selActivityId==2 && !selactivity2.has("separateToilet_"+lb)){
				selactivity2.set("separateToilet_"+lb,$(obj).attr('id'));
			}else if(selActivityId==3 && !selactivity3.has("separateToilet_"+lb)){
				selactivity3.set("separateToilet_"+lb,$(obj).attr('id'));
			}
			
		}else{
			if(selActivityId==1 && selactivity1.has("separateToilet_"+lb)){
				selactivity1.delete("separateToilet_"+lb);
			}else if(selActivityId==2 && selactivity2.has("separateToilet_"+lb)){
				selactivity2.delete("separateToilet_"+lb);
			}else if(selActivityId==3 && selactivity3.has("separateToilet_"+lb)){
				selactivity3.delete("separateToilet_"+lb);
			}
		}
		
		
		obj=$("#"+id+"_barrierFreeAccess"); 
		if($(obj).is(':checked')){
			if(selActivityId==1 && !selactivity1.has("barrierFreeAccess_"+lb)){
				selactivity1.set("barrierFreeAccess_"+lb,$(obj).attr('id'));
			}else if(selActivityId==2 && !selactivity2.has("barrierFreeAccess_"+lb)){
				selactivity2.set("barrierFreeAccess_"+lb,$(obj).attr('id'));
			}else if(selActivityId==3 && !selactivity3.has("barrierFreeAccess_"+lb)){
				selactivity3.set("barrierFreeAccess_"+lb,$(obj).attr('id'));
			}
			
		}else{
			if(selActivityId==1 && selactivity1.has("barrierFreeAccess_"+lb)){
				selactivity1.delete("barrierFreeAccess_"+lb);
			}else if(selActivityId==2 && selactivity2.has("barrierFreeAccess_"+lb)){
				selactivity2.delete("barrierFreeAccess_"+lb);
			}else if(selActivityId==3 && selactivity3.has("barrierFreeAccess_"+lb)){
				selactivity3.delete("barrierFreeAccess_"+lb);
			}
			
		}
		
		obj=$("#"+id+"_waterFacility"); 
		if($(obj).is(':checked')){
			if(selActivityId==1 && !selactivity1.has("waterFacility_"+lb)){
				selactivity1.set("waterFacility_"+lb,$(obj).attr('id'));
			}else if(selActivityId==2 && !selactivity2.has("waterFacility_"+lb)){
				selactivity2.set("waterFacility_"+lb,$(obj).attr('id'));
			}else if(selActivityId==3 && !selactivity3.has("waterFacility_"+lb)){
				selactivity3.set("waterFacility_"+lb,$(obj).attr('id'));
			}
			
		}else{
			if(selActivityId==1 && selactivity1.has("waterFacility_"+lb)){
				selactivity1.delete("waterFacility_"+lb);
			}else if(selActivityId==2 && selactivity2.has("waterFacility_"+lb)){
				selactivity2.delete("waterFacility_"+lb);
			}else if(selActivityId==3 && selactivity3.has("waterFacility_"+lb)){
				selactivity3.delete("waterFacility_"+lb);
			}
		}
		
		obj=$("#"+id+"_internetFacility"); 
		if($(obj).is(':checked')){
					
			if(selActivityId==1 && !selactivity1.has("internetFacility_"+lb)){
				selactivity1.set("internetFacility_"+lb,$(obj).attr('id'));
			}else if(selActivityId==2 && !selactivity2.has("internetFacility_"+lb)){
				selactivity2.set("internetFacility_"+lb,$(obj).attr('id'));
			}else if(selActivityId==3 && !selactivity3.has("internetFacility_"+lb)){
				selactivity3.set("internetFacility_"+lb,$(obj).attr('id'));
			}
		}else{
			if(selActivityId==1 && selactivity1.has("internetFacility_"+lb)){
				selactivity1.delete("internetFacility_"+lb);
			}else if(selActivityId==2 && selactivity2.has("internetFacility_"+lb)){
				selactivity2.delete("internetFacility_"+lb);
			}else if(selActivityId==3 && selactivity3.has("internetFacility_"+lb)){
				selactivity3.delete("internetFacility_"+lb);
			}
		}
		
		obj=$("#"+id+"_electricity"); 
		if($(obj).is(':checked')){
			if(selActivityId==1 && !selactivity1.has("electricity_"+lb)){
				selactivity1.set("electricity_"+lb,$(obj).attr('id'));
			}else if(selActivityId==2 && !selactivity2.has("electricity_"+lb)){
				selactivity2.set("electricity_"+lb,$(obj).attr('id'));
			}else if(selActivityId==3 && !selactivity3.has("electricity_"+lb)){
				selactivity3.set("electricity_"+lb,$(obj).attr('id'));
			}
		}else{
			if(selActivityId==1 && selactivity1.has("electricity_"+lb)){
				selactivity1.delete("electricity_"+lb);
			}else if(selActivityId==2 && selactivity2.has("electricity_"+lb)){
				selactivity2.delete("electricity_"+lb);
			}else if(selActivityId==3 && selactivity3.has("electricity_"+lb)){
				selactivity3.delete("electricity_"+lb);
			}
		}
		
		
		
	}
	
	
	function callPagination(){
		$('INPUT[name=activityItem]').change(function(){
			idArr=$(this).attr('id').split("_");
			id=idArr[0]+"_"+idArr[1]+"_"+idArr[2];
			saveEntity(id,idArr[2]);
		});
		
		$('INPUT[name=remark]').blur(function(){
			
			idArr=$(this).attr('id').split("_");
			id=$(this).attr('id');
			idval=$(this).val();
			if(selActivityId==1 && idval!="" && idval.trim().length>0 ){
			selactivity1.set(id,idval);
			}
			else if(selActivityId==2 && idval!="" && idval.trim().length>0 ){
				selactivity2.set(id,idval);
				}
			else if(selActivityId==3 && idval!="" && idval.trim().length>0 ){
			selactivity3.set(id,idval);
			}
			});
		
		$('INPUT[name=chkEntity]').change(function(){
			
			
			idArr=$(this).attr('id').split("_");
			
			if($(this).is(':checked')){
				
				id="remark_"+idArr[1]+"_"+idArr[2];
				idval=$("#"+id).val();
				if(selActivityId==1 && idval!="" && idval.trim().length>0){
				selactivity1.set(id,idval);

				}
				else if(selActivityId==2 && idval!="" && idval.trim().length>0){
					selactivity2.set(id,idval);
				}else if(selActivityId==3 && idval!="" && idval.trim().length>0){
					selactivity3.set(id,idval);
				}
			}
			
			
			if(selActivityId==1){
				temp=idArr[2];
				if(!lbCodes1.includes(temp)){
					if($(this).is(':checked') ){
						if( $scope.totGPS1>$scope.selGPs1){
							$scope.selGPs1=$scope.selGPs1+1;
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
						 	
						 	if(selactivity1.has("dlc_"+idArr[2])){
						 		selactivity1.delete("dlc_"+idArr[2]);
						 	}
						 	if($scope.selGPs1>0){
						 		$scope.selGPs1=$scope.selGPs1-1
						 	}
						 	
					}
					
				}
				
			}else if(selActivityId==2 ){
				temp=idArr[2]
				if(!lbCodes2.includes(temp)){
					if($(this).is(':checked') ){
						if( $scope.totGPS2>$scope.selGPs2){
							$scope.selGPs2=$scope.selGPs2+1
							lbCodes2.push(parseInt(temp));
							selactivity2.set("dlc_"+idArr[2],idArr[1]);
						}else{
							$(this).prop('checked', false);
							toastr.error("You are select maximum GPS of activity");
						}
						
						
					}else{
						if($scope.selGPs2>0){
							$scope.selGPs2=$scope.selGPs2-1
					 	}
						 var index = lbCodes2.indexOf(parseInt(temp));
						 	if (index > -1) {
						 		lbCodes2.splice(index, 1);
						   }
					
					}
				}
				
			}else if(selActivityId==3){
				temp=idArr[2]
				if(!lbCodes3.includes(temp)){
					if($(this).is(':checked') ){
						if( $scope.totGPS3>$scope.selGPs3){
							$scope.selGPs3=$scope.selGPs3+1
							lbCodes3.push(parseInt(temp));
							selactivity3.set("dlc_"+idArr[2],idArr[1]);
						}else{
							$(this).prop('checked', false);
							toastr.error("You are select maximum GPS of activity");
						}
						
						
					}else{
						if($scope.selGPs3>0){
							$scope.selGPs3=$scope.selGPs3-1
					 	}
						 var index = lbCodes3.indexOf(parseInt(temp));
						 	if (index > -1) {
						 		lbCodes3.splice(index, 1);
						   }
					
					}
				}
				
			}
			id="chk_"+idArr[1]+"_"+idArr[2];
			saveEntity(id,idArr[2]);
			
			
			
			
			idArr=$(this).attr('id').split("_");
			id="chk_"+idArr[1]+"_"+idArr[2];
			if($(this).is(':checked')){
				enabledDisabledActivity(id,false);
			}else{
				enabledDisabledActivity(id,true);
			}
			
		});
	}
	function callDatatable(){
		$('#example').dataTable({
	        "lengthMenu": [[ 25,50,100, -1], [25, 50,100, "All"]],
	         
	    });	
		
		$('#example').on( 'page.dt', function () {
			callPagination();
			} );
		
		callPagination();
	} 
	
	
	function enabledDisabledActivity(id,flag){
		$( "#"+id+"_landIdentified" ).prop( "disabled", flag );	
		$( "#"+id+"_approvedMap" ).prop( "disabled", flag );	
		$( "#"+id+"_separateToilet" ).prop( "disabled", flag );	
		$( "#"+id+"_barrierFreeAccess" ).prop( "disabled", flag );	
		$( "#"+id+"_waterFacility" ).prop( "disabled", flag );	
		$( "#"+id+"_internetFacility" ).prop( "disabled", flag );	
		$( "#"+id+"_electricity" ).prop( "disabled", flag );
		$( "#remark_"+id.split("_")[1]+"_"+id.split("_")[2]).prop( "disabled", flag );
		if(flag){
			
			$( "#"+id+"_landIdentified" ).prop('checked', false);	
			$( "#"+id+"_approvedMap" ).prop('checked', false);	
			$( "#"+id+"_separateToilet" ).prop('checked', false);	
			$( "#"+id+"_barrierFreeAccess" ).prop('checked', false);	
			$( "#"+id+"_waterFacility" ).prop('checked', false);	
			$( "#"+id+"_internetFacility" ).prop('checked', false);	
			$( "#"+id+"_electricity" ).prop('checked', false);
			$( "#remark_"+id.split("_")[1]+"_"+id.split("_")[2]).val('');
		
		}
	}
	
	$scope.savePanchayatBhawanData = function(){
		var pbProposedInfo=[];
		
		$.each( lbCodes1, function( index, value ) {
	    landIdentified=false;
	    approvedMap=false;	
	    separateToilet=false;	
	    barrierFreeAccess=false;	
	    waterFacility=false;	
	    internetFacility=false;	
	    electricity=false;	
	    districtCode=	parseInt(selactivity1.get("dlc_"+value));
	    remarks=null;
		
	    if(selactivity1.has("landIdentified_"+value)){
	    	landIdentified=true;
	    }
	    if(selactivity1.has("approvedMap_"+value)){
	    	approvedMap=true;
	    }
	    if(selactivity1.has("separateToilet_"+value)){
	    	separateToilet=true;
	    }
	    if(selactivity1.has("barrierFreeAccess_"+value)){
	    	barrierFreeAccess=true;
	    }
	    if(selactivity1.has("waterFacility_"+value)){
	    	waterFacility=true;
	    }
	    if(selactivity1.has("internetFacility_"+value)){
	    	internetFacility=true;
	    }
	    if(selactivity1.has("electricity_"+value)){
	    	electricity=true;
	    }
	    
	    if(selactivity1.has("remark_"+districtCode+"_"+value)) {
	    	remarks=selactivity1.get("remark_"+districtCode+"_"+value);
	    }
	    	
	    
	    	
	    	mySubObj={
	    			"id":panchatayBhawanidList.get(1)
	    	}
	    	myObj= {
				    "localBodyCode" : value,    //your artist variable
				    "districtCode" : districtCode ,  //your title variable
				    "landIdentified" : landIdentified,  
				    "approvedMap" : approvedMap,
				    "separateToilet" : separateToilet ,
				    "barrierFreeAccess" : barrierFreeAccess ,
				    "waterFacility" : waterFacility ,
				    "internetFacility" : internetFacility ,
				    "electricity" : electricity ,
				    "remarks":remarks,
				    "activityDetails":mySubObj
				};
	    	
	    	
	    	
	    	pbProposedInfo.push( myObj );
		});
		
		$.each( lbCodes2, function( index, value ) {
		    landIdentified=false;
		    approvedMap=false;	
		    separateToilet=false;	
		    barrierFreeAccess=false;	
		    waterFacility=false;	
		    internetFacility=false;	
		    electricity=false;	
		    districtCode=	parseInt(selactivity2.get("dlc_"+value));
		    remarks=null;
			
		    if(selactivity2.has("landIdentified_"+value)){
		    	landIdentified=true;
		    }
		    if(selactivity2.has("approvedMap_"+value)){
		    	approvedMap=true;
		    }
		    if(selactivity2.has("separateToilet_"+value)){
		    	separateToilet=true;
		    }
		    if(selactivity2.has("barrierFreeAccess_"+value)){
		    	barrierFreeAccess=true;
		    }
		    if(selactivity2.has("waterFacility_"+value)){
		    	waterFacility=true;
		    }
		    if(selactivity2.has("internetFacility_"+value)){
		    	internetFacility=true;
		    }
		    if(selactivity2.has("electricity_"+value)){
		    	electricity=true;
		    }
		    
		    if(selactivity2.has("remark_"+districtCode+"_"+value)) {
		    	remarks=selactivity2.get("remark_"+districtCode+"_"+value);
		    }
		    	
		    
		    	
		    	mySubObj={
		    			"id":panchatayBhawanidList.get(2)
		    	}
		    	myObj= {
					    "localBodyCode" : value,    //your artist variable
					    "districtCode" : districtCode ,  //your title variable
					    "landIdentified" : landIdentified,  
					    "approvedMap" : approvedMap,
					    "separateToilet" : separateToilet ,
					    "barrierFreeAccess" : barrierFreeAccess ,
					    "waterFacility" : waterFacility ,
					    "internetFacility" : internetFacility ,
					    "electricity" : electricity ,
					    "remarks":remarks,
					    "activityDetails":mySubObj
					};
		    	
		    	
		    	
		    	pbProposedInfo.push( myObj );
			});
	    
	    
		$.each( lbCodes3, function( index, value ) {
		    landIdentified=false;
		    approvedMap=false;	
		    separateToilet=false;	
		    barrierFreeAccess=false;	
		    waterFacility=false;	
		    internetFacility=false;	
		    electricity=false;	
		    districtCode=	parseInt(selactivity3.get("dlc_"+value));
		    remarks=null;
			
		    if(selactivity3.has("landIdentified_"+value)){
		    	landIdentified=true;
		    }
		    if(selactivity3.has("approvedMap_"+value)){
		    	approvedMap=true;
		    }
		    if(selactivity3.has("separateToilet_"+value)){
		    	separateToilet=true;
		    }
		    if(selactivity3.has("barrierFreeAccess_"+value)){
		    	barrierFreeAccess=true;
		    }
		    if(selactivity3.has("waterFacility_"+value)){
		    	waterFacility=true;
		    }
		    if(selactivity3.has("internetFacility_"+value)){
		    	internetFacility=true;
		    }
		    if(selactivity3.has("electricity_"+value)){
		    	electricity=true;
		    }
		    
		    if(selactivity3.has("remark_"+districtCode+"_"+value)) {
		    	remarks=selactivity3.get("remark_"+districtCode+"_"+value);
		    }
		    	
		    
		    	
		    	mySubObj={
		    			"id":panchatayBhawanidList.get(3)
		    	}
		    	myObj= {
					    "localBodyCode" : value,    //your artist variable
					    "districtCode" : districtCode ,  //your title variable
					    "landIdentified" : landIdentified,  
					    "approvedMap" : approvedMap,
					    "separateToilet" : separateToilet ,
					    "barrierFreeAccess" : barrierFreeAccess ,
					    "waterFacility" : waterFacility ,
					    "internetFacility" : internetFacility ,
					    "electricity" : electricity ,
					    "remarks":remarks,
					    "activityDetails":mySubObj
					};
		    	
		    	
		    	
		    	pbProposedInfo.push( myObj );
			});
	    
	    if(pbProposedInfo.length>0){
	    	workLocationService.savefFinalizeWorkLocation(pbProposedInfo).then(function(response){
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