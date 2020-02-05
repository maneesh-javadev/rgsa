<%@include file="../taglib/taglib.jsp"%>
<script>

$(document).ready(function()
		{
		    $("#selectSLC").change(function()
		    {
		        var id=$(this).val();
		        var dataString = 'id='+ id;
		        alert(id); return false;
		    });
		});
</script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Action Plan
							Physical Report</h2>
					</div>
					<div class="body">
				<!-- <div class="col-sm-2">
								<label for="finYear">&nbsp;&nbsp; State year : </label>
							</div> -->
							<div class="body">
							<div class="row clearfix">
								<div class="form-group">
									<div class="col-lg-2">
										<label for="QuaterId1"><strong>Select State :</strong></label>
									</div>
									<div align="center" class="col-lg-4">
										<select name="" id="selectSLC" 
											
											class="form-control">
											<option value="0">Select State</option>
											<c:forEach items="${stateList}" var="slc">
												<option value="${slc.stateCode}">${slc.stateNameEnglish}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
						</div>
						
							
						</div>
					
				</div>
			</div>
		</div>
	</div>
</section>
<style>
.Align-Right{
			text-align: right;
}</style>
