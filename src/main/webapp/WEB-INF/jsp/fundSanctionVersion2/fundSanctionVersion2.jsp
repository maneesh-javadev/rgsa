<%@include file="../taglib/taglib.jsp"%>
<script>
	function calTotalFund(index){
		$('#totalFund_'+index).val(+$('#unspent_'+index).val() + +$('#central_'+index).val());
	}
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2> Fund Sanction </h2>
					</div>
					<form:form method="post" id="FundSanctionVersion2Id"
						name="FundSanctionVersion2" modelAttribute="VIEW_REPORT_MODEL"
						action="fundSanction.html">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="fundSanction.html"/>" />
						<div class="body">
							<div class="row clearfix">
							<div class="form-group">
								<div class="col-lg-4">
									&nbsp;&nbsp;<label for="FinYear"><strong>Financial Year :</strong></label>
								</div>
								<div align="center" class="col-lg-4">
									<select class="form-control" id="finYearDropDownId">
										<option value="0">Select Financial Year</option>
										<c:forEach items="${sessionScope['scopedTarget.userPreference'].finYearList}" var="finYearList">
											<option value="${finYearList.yearId}">${finYearList.finYear}</option>										
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						
						<div class="row clearfix">
							<div class="form-group">
								<div class="col-lg-4">
									&nbsp;&nbsp;<label for="FinYear"><strong>Approved State :</strong></label>
								</div>
								<div align="center" class="col-lg-4">
									<select class="form-control" id="approvedStateId">
										<option value="0">Select State</option>
											<option value="1">Arunachal Pradesh</option>
											<option value="2">Andhra Pradesh</option>
											<option value="3">Assam</option>
											<option value="4">Bihar</option>
											<option value="5">Punjab</option>
											<option value="6">Haryana</option>
									</select>
								</div>
							</div>
						</div>
						
						<div class="table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th><div align="center"><strong>Installment</strong></div></th>
										<th><div align="center"><strong>Unspent Balance</strong></div></th>
										<th><div align="center"><strong>Central Share</strong></div></th>
										<th><div align="center"><strong>Total Fund</strong></div></th>
										<th><div align="center"><strong>File Upload</strong></div></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><div align="center"><strong>Installment 1.</strong></div></td>
										<td><input type="text" class="form-control Align-Right" id="unspent_0" onkeyup="calTotalFund('0')"/></td>
										<td><input type="text" class="form-control Align-Right" id="central_0" onkeyup="calTotalFund('0')"/></td>
										<td><input type="text" class="form-control Align-Right" id="totalFund_0" disabled="disabled" /></td>
										<td><input type="file" class="form-control" /></td>
									</tr>
									<tr>
										<td><div align="center"><strong>Installment 2.</strong></div></td>
										<td><input type="text" class="form-control Align-Right" id="unspent_1" onkeyup="calTotalFund('1')"/></td>
										<td><input type="text" class="form-control Align-Right" id="central_1" onkeyup="calTotalFund('1')"/></td>
										<td><input type="text" class="form-control Align-Right" id="totalFund_1" disabled="disabled" /></td>
										<td><input type="file" class="form-control" /></td>
									</tr>
								</tbody>
							</table>
						</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
<style>
.Align-Right{
			text-align: right;
}</style>
							