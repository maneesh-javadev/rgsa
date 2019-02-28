<%@include file="../taglib/taglib.jsp"%>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Faculty and Maintenance at PMU</h2>
					</div>
					<div class="body">
						<div class="card">

							<table class="table table-bordered" id="mytable">
								<button type="button" onclick="addNewRow()"
									class="btn btn-success waves-effect">
									<i class="fa fa-plus"></i> Add New Row
								</button>

								<button type="button" onclick="removeRow()"
									class="btn btn-danger waves-effect ">
									<i class="fa fa-minus" aria-hidden="true"></i> Remove Row
								</button>
								
								<thead>
									<tr>
										<th><div align="center">
												<strong>Type of Center</strong>
											</div></th>
										<th><div align="center">
												<strong>DomainName </strong>
											</div></th>
										<th><div align="center">
												<strong>No. of faculty/ Domain expert <br> A
												</strong>
											</div></th>
										<th><div align="center">
												<strong>No. of Administrative staff<br> B
												</strong>
											</div></th>
										<th><div align="center">
												<strong>Unit Cost (in Rs)<br> C
												</strong>
											</div></th>

										<th><div align="center">
												<strong>No. of Months<br> D
												</strong>
											</div></th>
										<th><div align="center">
												<strong>Funds (in Rs)<br> E = (A+B) *C * D
												</strong>
											</div></th>
										<th><div align="center">
												<strong>Others<br> F
												</strong>
											</div></th>
										<th><div align="center">
												<strong>Total Cost (in Rs)<br>G = E + F
												</strong>
											</div></th>
										<th><div align="center">
												<strong>Remarks<br>
												</strong>
											</div></th>


									</tr>
								</thead>
								<tbody>

									<tr>
										<td><strong>PMU</strong></td>

										<td><input type="text" class="form-control"
											placeholder="Enter Domain expert " /></td>
										<td><input type="text" class="form-control"
											placeholder=" Enter Administrative staff" /></td>
										<td><input type="text" class="form-control"
											placeholder="<= 1 Cr" /></td>
										<td><input type="text" class="form-control"
											placeholder=" Enter no. of Months " /></td>
										<td><input type="text" class="form-control"
											placeholder="Enter Funds" /></td>
										<td><input type="text" class="form-control"
											placeholder="Enter Others" /></td>
										<td><input type="text" class="form-control"
											placeholder="Enter Total Cost " /></td>
										<td><input type="text" class="form-control"
											placeholder="Enter Remarks"></td>
										<td><input type="text" class="form-control"
											placeholder="Enter Remarks" /></td>
									</tr>



								</tbody>
							</table>

						</div>
						<div class="form-group text-right">
							<button type="button" class="btn bg-green waves-effect">
								<spring:message code="Label.SAVE" htmlEscape="true" />
							</button>
							<button type="button" onclick="onClear(this)"
								class="btn bg-light-blue waves-effect">
								<spring:message code="Label.CLEAR" htmlEscape="true" />
							</button>
							<button type="button"
								onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
								class="btn bg-orange waves-effect">
								<spring:message code="Label.CLOSE" htmlEscape="true" />
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<script>
function addNewRow(){
    $("#mytable").each(function () {
        var tds = '<tr>';
        jQuery.each($('tr:nth-child(1) td', this), function () {
            tds += '<td>' + $(this).html() + '</td>';
        });
        tds += '</tr>';
        if ($('tbody', this).length > 0) {
            $('tbody', this).append(tds);
         
        } 
    });
}
function removeRow(){
	if($('#mytable tr').length>2){
    $('#mytable tr:last').remove();
}
} 

</script>
