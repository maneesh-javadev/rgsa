<%@include file="../taglib/taglib.jsp"%>

<html>
<head>
<script type="text/javascript">
	function show(val){

		if (val == 1 ) {
			$("#eSPMUid").css("display","block")
			$("#eDPMUid").css("display","none")
			$("#default").css("display","none")
		}
		if(val == 2) {
			$("#eDPMUid").css("display","block")
			$("#eSPMUid").css("display","none")
			$("#default").css("display","none")
			}
		}
	
		</script>
</head>


<%@include file="../taglib/taglib.jsp"%>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Status of e-Governance Support Group in State</h2>
					</div>

					<input type="hidden" name="<csrf:token-name/>"
						value="<csrf:token-value uri="categorySubcategory.html"/>" />
					<div class="body">
						<div class="row clearfix">
							<div class="col-sm-6">
								<label for="Select_Category">Level </label>
								<div class="form-group">
									<div class="form-line">
										<select onchange="disrtict(this.value),show(this.value)">
											<option value="0">Select</option>
											<option value="1">e-SPMU</option>
											<option value="2">e-DPMU</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-6">
								<label>District </label>
								<div class="form-group" id="s">ARARIA</div>
								<div class="form-group" style="display: none;" id="dis">
									<div class="form-line">
										<select id="label1" name="label1" class="combofield error_fld"
											onfocus="validateOnFocus('label1');helpMessage(this,'label1msg');"
											onblur="vlidateOnblur('label1','1','75','m'); hideHelp();"
											onchange="getChildLocalBodies('label1')">
											<option value="">select</option>
											<option value="179">ARARIA</option>
											<option value="561">ARWAL</option>
											<option value="180">AURANGABAD</option>
											<option value="181">BANKA</option>
											<option value="182">BEGUSARAI</option>
											<option value="183">BHAGALPUR</option>
											<option value="184">BHOJPUR</option>
											<option value="185">BUXAR</option>
											<option value="186">DARBHANGA</option>
											<option value="187">GAYA</option>
											<option value="188">GOPALGANJ</option>
											<option value="189">JAMUI</option>
											<option value="190">JEHANABAD</option>
											<option value="191">KAIMUR (BHABUA)</option>
											<option value="192">KATIHAR</option>
											<option value="193">KHAGARIA</option>
											<option value="194">KISHANGANJ</option>
											<option value="195">LAKHISARAI</option>
											<option value="196">MADHEPURA</option>
											<option value="197">MADHUBANI</option>
											<option value="198">MUNGER</option>
											<option value="199">MUZAFFARPUR</option>
											<option value="200">NALANDA</option>
											<option value="201">NAWADA</option>
											<option value="202">PASHCHIM CHAMPARAN</option>
											<option value="203">PATNA</option>
											<option value="204">PURBI CHAMPARAN</option>
											<option value="205">PURNIA</option>
											<option value="206">ROHTAS</option>
											<option value="207">SAHARSA</option>
											<option value="208">SAMASTIPUR</option>
											<option value="209">SARAN</option>
											<option value="210">SHEIKHPURA</option>
											<option value="211">SHEOHAR</option>
											<option value="212">SITAMARHI</option>
											<option value="213">SIWAN</option>
											<option value="214">SUPAUL</option>
											<option value="215">VAISHALI</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="row clearfix">

							<div class="col-sm-12">
								<label>Post Name </label>
								<div class="form-group" style="display: none;" id="eSPMUid">
									<div class="form-line">
										<select>
											<option value="0">Select</option>
											<option value="1">Project Manager</option>
											<option value="2">Accounts Expert</option>
											<option value="2">Technical Assistant</option>
											<option value="2">Others</option>
										</select>
									</div>
								</div>

								<div class="form-group" style="display: none;" id="eDPMUid">
									<div class="form-line">
										<select>
											<option value="0">Select</option>
											<option value="1">District Project Manager</option>
											<option value="2">Technical Assistant</option>
											<option value="3">Others</option>
										</select>
									</div>
								</div>

								<div class="form-group" id="default">
									<div class="form-line">
										<select>
											<option value="0">Select</option>
										</select>
									</div>
								</div>

							</div>
						</div>
						<div class="row clearfix">
							<div class="col-sm-4">
								<label>No of Staff positioned </label>
								<div class="form-group">
									<div class="form-line">
										<input type="text" class="form-control"
											placeholder="No of Staff positioned" />
									</div>
								</div>
							</div>
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
function disrtict(val){
	
	if(val==2){
		$("#dis").show();
		$("#s").hide();
	}else{
		$("#dis").hide();
		$("#s").show();
	}
	
}
</script>