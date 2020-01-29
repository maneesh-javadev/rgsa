<%@include file="../taglib/taglib.jsp"%>
<html>
<head>
</head>
	<section class="content">
		<div class="container-fluid">
	    	<div class="row clearfix">
	        	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
	            	<div class="card">
	                	<div class="header">
	                    	<h2>CB&T For Activity Paln</h2>
	                    </div>
	                    <div class="body">
		                     <div class="table-responsive">
			                    <table class="table table-bordered"  id="supportStaff">
			                    	<thead>
			                    	<tr>
			                    		<th rowspan="2">Category</th>
									  	<th rowspan="2">Training Subject</th>
									  	<th rowspan="2">Training Group</th>
									  	<th rowspan="2">Target Venue Level</th>
									 	<th rowspan="2">No. of participants<br>(A)</th>
									  	<th rowspan="2">No. of days proposed <br>(B)</th>
									  	<th rowspan="2">Unit Cost(in RS.) <br> (C)</th>
									  	<th rowspan="2">Fund Proposed(in RS.) <br> D=A*B*C</th>
			                    	</tr>
			                    	<tr></tr>
									</thead>
									<tbody>
									<tr>
									<td></td>
									<td></td>
									<td></td>
									<td><select>
		                            	<option value=""> Select </option>
                                         <option value="1">State</option>
                                         <option value="2">District</option>
                                         <option value="3">Block</option>
                                    </select></td>
									<td><input type="text" class="form-control"/></td>
									<td><input type="text" class="form-control"/></td>
									<td><input type="text" class="form-control"/></td>
									<td><input type="text" class="form-control"/></td>
									</tr>
									<tr>
									<td></td>
									<td></td>
									<td></td>
									<td><select>
		                            	<option value=""> Select </option>
                                         <option value="1">State</option>
                                         <option value="2">District</option>
                                         <option value="3">Block</option>
                                    </select></td>
									<td><input type="text" class="form-control"/></td>
									<td><input type="text" class="form-control"/></td>
									<td><input type="text" class="form-control"/></td>
									<td><input type="text" class="form-control"/></td>
									</tr>
									</tbody>
								</table>
							</div>
		  					<div class="form-group text-right">
								<button type="button" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
								 
								<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect"> <spring:message code="Label.CLOSE" htmlEscape="true" /></button>
							</div>
						</div>
	                </div>
	             </div>
	       </div>
	    </div>
	</section>
</html>