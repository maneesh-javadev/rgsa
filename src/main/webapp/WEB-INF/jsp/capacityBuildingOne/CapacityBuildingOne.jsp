<%@include file="../taglib/taglib.jsp"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/capacityBuilding/capacityBuildingController.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/capacityBuilding/capacityBuildingService.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/directives.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
<script type="text/javascript">

  function exportToPdf(id) {
	 var header = 'Training Activities';
	 var sTable =$('#'+id).html();
	 var style = "<style>";
	 
	 	 style = style + "table,th,td{border: solid 1px black;border-collapse: collapse;}";
        style = style + "thead {color : black; background-color: #e87b7b;";
        style = style + "</style>";
	 
   var win = window.open('', '', 'height=1000,width=1000');
    win.document.write('<html><head>');
    win.document.write('<title>'+header+'</title>');  
    win.document.write(style); 
    win.document.write('</head>');
    win.document.write('<body>');
    win.document.write(sTable);         
    win.document.write('</body></html>');
  	 win.document.close(); 	
  	 win.print();    
}  

function fnExcelReport(val)
{
    var tab_text="<table border='2px'><tr bgcolor='#87AFC6'>";
    var textRange; var j=0;
    tab = document.getElementById(val); // id of table

    for(j = 0 ; j < tab.rows.length ; j++) 
    {     
        tab_text=tab_text+tab.rows[j].innerHTML+"</tr>";
        //tab_text=tab_text+"</tr>";
    }

    tab_text=tab_text+"</table>";
    tab_text= tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
    tab_text= tab_text.replace(/<img[^>]*>/gi,""); // remove if u want images in your table
    tab_text= tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params

    var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE "); 

    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
    {
        txtArea1.document.open("txt/html","replace");
        txtArea1.document.write(tab_text);
        txtArea1.document.close();
        txtArea1.focus(); 
        sa=txtArea1.document.execCommand("SaveAs",true,"Say Thanks to Sumit.xls");
    }  
    else                 //other browser not tested on IE 11
        sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));  

    return (sa);
}
        
        
        
        
//table export
/* function fnExcelReport(val)
{   
    var currentdate = new Date();
    var datetime = val+"_" + currentdate.getDay() + "_"+currentdate.getMonth()+1 
    + "_" + currentdate.getFullYear() + "_" 
    + currentdate.getHours() + ":" 
    + currentdate.getMinutes() + ".xls";
    
    var tab_text="<table border='2px'><tr bgcolor='#87AFC6'>";
    var textRange; var j=0; var k=0;
    var tab = document.getElementById(val); // id of table
   
    for(j = 0 ; j < tab.rows.length ; j++) 
    {     
        tab_text=tab_text+tab.rows[j].innerHTML+"</tr>";
        //tab_text=tab_text+"</tr>";
    }
    tab_text=tab_text+"</table>";
    tab_text= tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
    tab_text= tab_text.replace(/<img[^>]*>/gi,""); // remove if u want images in your table
    tab_text= tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params

    
    var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE "); 

    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
    {
        txtArea1.document.open("txt/html","replace");
        txtArea1.document.write(tab_text);
        txtArea1.document.close();
        txtArea1.focus(); 
        txtArea1.document.execCommand("SaveAs",true,datetime);
    }
    else 
    {
        //other browser not tested on IE 11
        var bba = document.createElement('a');
        var data_type = 'data:application/vnd.ms-excel';
        var table_div = tab_text;    //Your tab_text   
        var table_html = table_div.replace(/ /g, '%20');
        bba.href = data_type + ', ' + table_html;
        //setting the file name
        bba.download = datetime;
        //triggering the function
        bba.click();
    }
        //sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));  
}

 var xport = {
      _fallbacktoCSV: true,  
      toXLS: function(tableId, filename) {   
        this._filename = (typeof filename == 'undefined') ? tableId : filename;
     
        if ((this._getMsieVersion() || this._isFirefox()) && this._fallbacktoCSV) {
          return this.toCSV(tableId);
        } else if (this._getMsieVersion() || this._isFirefox()) {
          alert("Not supported browser");
        }
        //Other Browser can download xls
        var htmltable = document.getElementById(tableId);
        var html = htmltable.outerHTML;
        this._downloadAnchor("data:application/vnd.ms-excel" + encodeURIComponent(html),'xls'); 
      },
      toCSV: function(tableId, filename) {
        this._filename = (typeof filename === 'undefined') ? tableId : filename;
        // Generate our CSV string from out HTML Table
        
        var tab_text="<table border='2px'><tr bgcolor='#87AFC6'>";
        var textRange; var j=0; var k=0;
        var tab = document.getElementById(tableId); // id of table
        for(j = 0 ; j < tab.rows.length ; j++) 
        {     
            tab_text=tab_text+tab.rows[j].innerHTML+"</tr>";
            //tab_text=tab_text+"</tr>";
        }
       
        tab_text=tab_text+"</table>";
     
        var blob = new Blob([tab_text], { type: "text/csv" });
 
        if (navigator.msSaveOrOpenBlob) {
           
          navigator.msSaveOrOpenBlob(blob, $("#tabName").val() + ".xls");
        } else {      
          this._downloadAnchor(URL.createObjectURL(blob), 'xls');      
        }
      },
      _getMsieVersion: function() {
        var ua = window.navigator.userAgent;

        var msie = ua.indexOf("MSIE ");
        if (msie > 0) {
          // IE 10 or older => return version number
          return parseInt(ua.substring(msie + 5, ua.indexOf(".", msie)), 10);
        }

        var trident = ua.indexOf("Trident/");
        if (trident > 0) {
          // IE 11 => return version number
          var rv = ua.indexOf("rv:");
          return parseInt(ua.substring(rv + 3, ua.indexOf(".", rv)), 10);
        }

        var edge = ua.indexOf("Edge/");
        if (edge > 0) {
          // Edge (IE 12+) => return version number
          return parseInt(ua.substring(edge + 5, ua.indexOf(".", edge)), 10);
        }
        // other browser
        return false;
      },
      _isFirefox: function(){
        if (navigator.userAgent.indexOf("Firefox") > 0) {
          return 1;
        }
        return 0;
      },
      _downloadAnchor: function(content, ext) {
          var anchor = document.createElement("a");
          anchor.style = "display:none !important";
          anchor.id = "downloadanchor";
          document.body.appendChild(anchor);

          // If the [download] attribute is supported, try to use it
          
          if ("download" in anchor) {
            anchor.download = this._filename + "." + ext;
          }
          anchor.href = content;
          anchor.click();
          anchor.remove();
      },
      _tableToCSV: function(table) {
        // We'll be co-opting `slice` to create arrays
        var slice = Array.prototype.slice;
        
        return slice
          .call(table.rows)
          .map(function(row) {
            return slice
              .call(row.cells)
              .map(function(cell) {
                return '"t"'.replace("t", cell.textContent);
              })
              .join(",");
          })
          .join("\r\n");
      }
    };  */

</script>

<html data-ng-app="publicModule">
	<section class="content" data-ng-controller="capacityBuildingController">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Training Activities
							<!-- <span class="glyphicon glyphicon-download-alt" onclick="fnExcelReport('mytable')"></span>
						 <span class="glyphicon glyphicon-print" onclick="exportToPdf('home_with_icon_title')"></span> -->
							</h2>
							
						</div>
						
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane fade in active"
								id="home_with_icon_title">
								<div class="table-responsive">
								
									<table class="table table-hover dashboard-task-infos" id="mytable" >
									<iframe id="txtArea1" style="display:none"></iframe>
										<thead>
											<tr>
												<th rowspan="2">
													<div align="center">
														<strong>S.No.</strong> 
													</div>
												</th>
												<th rowspan="2">
													<div align="center">
														<strong>Activity
														</strong>
													</div>
												</th>
												
												<th rowspan="2">
													<div align="center">
														<strong>No. of Days
														</strong>
													</div>
												</th>
												<th rowspan="2">
													<div align="center">
														<strong>No. of Units
														</strong>
													</div>
												</th>
												<th rowspan="2">
													<div align="center">
														<strong>Unit Cost(In Rs) </strong>
													</div>
												</th>
												
												<th rowspan="2">
													<div align="center">
														<strong>Funds Proposed(In Rs) </strong>
													</div>
												</th>
													
												<!-- <th>
													<div align="center">
														<strong>State </strong>
													</div>
												</th>
													
												<th>
													<div align="center">
														<strong>GP </strong>
													</div>
												</th> -->
													
												<th rowspan="2"><div align="center">
														<strong>Collaboration with Institute</strong>
													</div></th>
												<th rowspan="2" data-ng-if="userType == 'M'">
													<div align="center">
														<strong>Recommended</strong>
													</div>
												</th>
												<th rowspan="2" data-ng-if="userType == 'C'">
													<div align="center">
														<strong>Recommended</strong>
													</div>
												</th>
												<th rowspan="2" data-ng-if="userType == 'S'" style="display: none">
													<div align="center" >
														<strong>Recommended</strong>
													</div>
												</th>	
												<th rowspan="2">
													<div align="center">
														<strong>Remarks</strong>
													</div>
												</th>

												<c:if
													test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
													<th colspan="2" rowspan="1">
														<div align="center">
															<strong>Previous comment history</strong>
														</div>
													</th>
												</c:if>
										</tr>
										<tr>
											<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
												<th >
													<div align="center">
														<strong>State Previous Comments <span style="color: #396721;">&nbsp;<i class="fa fa-circle"></i></span></strong>
													</div>
												</th>
												<th>
													<div align="center">
														<strong>MOPR's Feedback <span style="color: #bc6317;">&nbsp;<i class="fa fa-circle"></i></span></strong>
													</div>
												</th>
											</c:if>
										</tr>
										</thead>
										
										<tbody>
											<tr data-ng-repeat="cbMaster in cbmasters" data-ng-init="outerIndex = $index">
	
												<td>
													{{$index+1}}
												</td>
												<td>
													{{cbMaster.cbName}}
													<input type="hidden" id="cbMaster_{{$index}}" class="form-control" data-ng-value="cbMaster.cbMasterId" 
																ng-model="capacityBuilding.capacityBuildingActivityDetails[index].cbMaster" style="text-align:right;" />
												</td>
												
												<td>
													<input style="background: #dddddd; text-align:right;" ng-show="!{{$index+1 == 5 || $index+1 == 6 }}" ng-disabled="!{{$index+1 == 5 || $index+1 == 6 }}" data-ng-disabled="capacityBuilding.isFreeze" type="text" 
														data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].noOfDays" class="form-control" placeholder="1" />
													
													<input data-ng-keyup="calculateFunds($index)" maxlength="5" restrict-input="{type: 'numberGreaterThanZero',index: $index}" ng-show="{{$index+1 == 5 || $index+1 == 6 }}" data-ng-change="insertCBMasterInScope($index)" data-ng-disabled="capacityBuilding.isFreeze" type="text" 
														data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].noOfDays" class="form-control" placeholder="" style="text-align:right;"/>
													
												</td>
												<td>
													<input data-ng-disabled="capacityBuilding.isFreeze" data-ng-change="insertCBMasterInScope($index)" maxlength="5" restrict-input="{type: 'numberGreaterThanZero',index: $index}" data-ng-keyup="calculateFunds($index)" type="text" data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].noOfUnits" class="form-control" placeholder=" " style="text-align:right;"/>
												</td>
												<td>
													<input data-ng-disabled="capacityBuilding.isFreeze" data-ng-change="insertCBMasterInScope($index)" maxlength="10" restrict-input="{type: 'numberGreaterThanZero',index: $index}" min="1" data-ng-keyup="calculateFunds($index);checkForCellingValue($index)" type="text" data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].unitCost" class="form-control" style="text-align:right;" placeholder="" />
												</td>
												<td>
													<input data-ng-disabled="true" style="background: #dddddd; text-align:right;" data-ng-change="insertCBMasterInScope($index)" type="text" data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].funds" class="form-control" placeholder=" " />
												</td>
												<!-- <td>
													<input type="text" data-ng-disabled="capacityBuilding.isFreeze" class="form-control" placeholder=" " />
												</td>
												<td>
													<input type="text" data-ng-disabled="capacityBuilding.isFreeze" class="form-control" placeholder=" " />
												</td> -->
												<td>
													<input type="text" data-ng-if="cbMaster.cbMasterId!=5 && cbMaster.cbMasterId!=6" data-ng-disabled="capacityBuilding.isFreeze" class="form-control" data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].collabInstitute" placeholder=" " style="text-align:right;"/>
													<input type="text" data-ng-if="cbMaster.cbMasterId==5 || cbMaster.cbMasterId==6" data-ng-disabled="true" class="form-control" style="background: #dddddd;"/>
												</td>
												<td  ng-if="userType == 'M' || userType == 'C'" align="center">
													<input type="checkbox" data-ng-disabled="capacityBuilding.isFreeze"  data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].isApproved"  />
												</td>
												<td ng-if="userType == 'M' || userType == 'C'" style="display: none">
													<input type="checkbox" data-ng-disabled="capacityBuilding.isFreeze" class="form-control" data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].isApproved" class="form-control" />
												</td>
												<td>
													<input data-ng-disabled="capacityBuilding.isFreeze" data-ng-change="insertCBMasterInScope($index)" type="text" data-ng-model="capacityBuilding.capacityBuildingActivityDetails[$index].remarks" class="form-control" placeholder="Remarks" style="text-align:right;" />
												</td>
												<c:if test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
													<td>
														<ol>
																<li data-ng-repeat="stateComments in preStateComments[outerIndex] track by $index" style="color: #396721; font-weight: bold;">
																	{{stateComments}}
																	</li>
														</ol>
													</td>
		
													<td>
														<ol>
															<li data-ng-repeat="moprComments in preMoprComments[outerIndex] track by $index" style="color: #bc6317; font-weight: bold;">
															{{moprComments}}</li>
														</ol>
													</td>
											 </c:if>
											</tr>
											<tr>
											<th colspan="5" align="center" >Total Funds</th>
											<td><input type="text" maxlength="5" data-ng-disabled="true" data-ng-model="subTotal" class="form-control" style="text-align:right;" /></td>											
											<td></td>
											<td></td>
											</tr>
											<tr>
											<th colspan="5">Additional Requirement</th>
											<td ><input type="text" restrict-input="{type: 'digitsOnly',index: $index}" data-ng-keyUp="validateAmount()" ng-min="1"
														data-ng-model="capacityBuilding.additionalRequirement" data-ng-disabled="capacityBuilding.isFreeze" class="form-control" placeholder="25% of Total Cost " style="text-align:right;" /></td>
											<td></td>
											<td></td>
											</tr>
											<tr>
											<th colspan="5">
											Total Proposed Fund
											</th>
											<td ><input type="text" data-ng-disabled="true" data-ng-model="grandTotal" maxlength="5"  class=" " style="text-align:right;" /></td>
											<td></td>
											<td></td>
											</tr>
										</tbody>
									</table>
		 							</div>
									
									 
									
							</div>
							
							
							<div class="row clearfix">
							<div class="col-md-12 text-right ex1" data-ng-show="userType =='S'">
							 <c:if test="${Plan_Status eq true}">
							<button ng-click="saveCapacityBuildingActivityAndDetails()" ng-disabled="capacityBuilding.isFreeze || btn_disabled"  type="button" class="btn bg-green waves-effect">
									<spring:message code="Label.SAVE" htmlEscape="true" />
								</button>
								<button ng-show="capacityBuilding.isFreeze" type="button" data-ng-click="freezUnFreezCapacityBuilding('unfreeze')" class="btn bg-orange waves-effect">
									<spring:message code="UNFREEZE" htmlEscape="true" />
								</button>
								
								<button ng-show=" capacityBuilding.isFreeze != undefined && !capacityBuilding.isFreeze" type="button" data-ng-click="freezUnFreezCapacityBuilding('freeze')" class="btn bg-orange waves-effect">
									<spring:message code="FREEZE" htmlEscape="true" />
								</button>
								
								<%-- <button type="button" ng-show="capacityBuilding.isFreeze != undefined && !capacityBuilding.isFreeze" data-ng-click="onClear()" data-ng-disabled="capacityBuilding.isFreeze"  class="btn bg-light-blue waves-effect">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</button> --%>
								</c:if>
								<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-red waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
							</div>
							
							
							<div class="col-md-4  text-left" data-ng-show="userType !='S'" style="margin-bottom: 5px">
								&nbsp;&nbsp;<button type="button"
									onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
									class="btn bg-orange waves-effect">
									<i class="fa fa-arrow-left" aria-hidden="true"></i>
									<spring:message code="Label.BACK" htmlEscape="true" />
								</button><br>
							</div>
							
							<div class="col-md-8 text-right ex1" data-ng-show="userType !='S'">
							 <c:if test="${Plan_Status eq true}">
							<button ng-click="saveCapacityBuildingActivityAndDetails()" ng-disabled="capacityBuilding.isFreeze || btn_disabled"  type="button" class="btn bg-green waves-effect">
									<spring:message code="Label.SAVE" htmlEscape="true" />
								</button>
								
								
								<button ng-show="capacityBuilding.isFreeze" type="button" data-ng-click="freezUnFreezCapacityBuilding('unfreeze')" class="btn bg-orange waves-effect">
									<spring:message code="UNFREEZE" htmlEscape="true" />
								</button>
								
								<button ng-show="capacityBuilding.isFreeze != undefined && !capacityBuilding.isFreeze" type="button" data-ng-click="freezUnFreezCapacityBuilding('freeze')" class="btn bg-orange waves-effect">
									<spring:message code="FREEZE" htmlEscape="true" />
								</button>
								
								<%-- <button type="button" data-ng-click="onClear()" ng-disabled="capacityBuilding.isFreeze"  class="btn bg-light-blue waves-effect">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</button> --%>
								</c:if>
								<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-red waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
							</div>
							
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</html>
<style>
.ex1 {
  margin-left: -26px;
  margin-bottom: 10px;
  padding-right: 0px;
}
</style>