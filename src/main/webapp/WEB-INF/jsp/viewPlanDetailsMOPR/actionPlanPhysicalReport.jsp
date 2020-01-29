<%@include file="../taglib/taglib.jsp"%>
<link
	href="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.css"
	rel="stylesheet">

<script
	src="https://unpkg.com/tableexport.jquery.plugin/tableExport.min.js"></script>
<script
	src="https://unpkg.com/tableexport.jquery.plugin/libs/jsPDF/jspdf.min.js"></script>
<script
	src="https://unpkg.com/tableexport.jquery.plugin/libs/jsPDF-AutoTable/jspdf.plugin.autotable.js"></script>
<script
	src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.js"></script>
<script
	src="https://unpkg.com/bootstrap-table@1.15.5/dist/extensions/export/bootstrap-table-export.min.js"></script>
<%-- <script
	src="${pageContext.request.contextPath}/resources/bootstrap-table/extensions/export/bootstrap-table-export.min.js"></script>
 --%>
<script>
	function collapseDetails(val){
		
		alert(val);
		
		  $.ajax({
			   type : "POST",
			   contentType : "application/json",
			   url : "actionPlanPhysicalReport.html?<csrf:token uri='actionPlanPhysicalReport.html'/>&component="+val,
			   dataType : 'json',
			   cache : false,
			   timeout : 100000,
			   success : function(data) {
				/* $("#basicOrientationTrainingofERId").html(data[0]);
				$("#refreshertraningtoERId").html(data[1]);
				$("#shg_pri_convergenceID").html(data[2]);
				$("#eSPMUId").html(data[3]);
				$("#eDPMUId").html(data[4]);
				$("#eComputerizationId").html(data[5]);
				$("#bhawansConstructedId").html(data[6]);
				$("#bhawansRepairedId").html(data[7]);
				$("#CSCsId").html(data[8]);
				$("#withinStateId").html(data[9]);
				$("#OutsideStateId").html(data[10]);
				$("#panchyatStakeholderId").html(data[11]);
				$("#technicalsupporttoGPsId").html(data[12]); */
			   },
			   error : function(e) {
			    console.log(e);
			   }
			  });
		
	}
</script>



<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h3 style="padding-top: 25px;">&nbsp;&nbsp; Action Plan Physical Report</h3>
					</div>
					<br />
					<form:form method="post" name="" action="">
						<div class="row">
							
							
						<div class="container">
  
  <main>
    <article class="panel-group bs-accordion" id="accordion" role="tablist" aria-multiselectable="true">
      <section class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading1" onclick="collapseDetails('TDS');">
          <h4 class="panel-title">
            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse1" aria-expanded="false" aria-controls="collapse1">
              Training Details
              <span class="glyphicon glyphicon-chevron-right pull-right" aria-hidden="true"></span>
            </a>
          </h4>
        </div>
        <div id="collapse1" class="panel-collapse collapse " role="tabpanel" " aria-labelledby="heading1">
          <div class="panel-body">
            <ul>
              <li><a href="#" id="link01-01">Link 1</a> | <a href="#" aria-describedby="link01-01">View Transcript</a></li>
              <li><a href="#" id="link01-02">Link 2</a> | <a href="#" aria-describedby="link01-02">View Transcript</a></li>
              <li><a href="#" id="link01-03">Link 3</a> | <a href="#" aria-describedby="link01-03">View Transcript</a></li>
            </ul>
          </div>
        </div>
      </section>
      <section class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading2" onclick="collapseDetails('TRA');">
          <h4 class="panel-title">
            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse2" aria-expanded="false" aria-controls="collapse2">
             Training Related Activities 
              <span class="glyphicon glyphicon-chevron-right pull-right" aria-hidden="true"></span>
            </a>
          </h4>
        </div>
        <div id="collapse2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading2">
          <div class="panel-body">
            <ul>
              <li><a href="#" id="link02-01">Link 1</a> | <a href="#" aria-describedby="link02-01">View Transcript</a></li>
              <li><a href="#" id="link02-02">Link 2</a> | <a href="#" aria-describedby="link02-02">View Transcript</a></li>
              <li><a href="#" id="link02-03">Link 3</a> | <a href="#" aria-describedby="link02-03">View Transcript</a></li>
            </ul>
          </div>
        </div>
      </section>
      <section class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading3" onclick="collapseDetails('II');">
          <h4 class="panel-title">
            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse3" aria-expanded="false" aria-controls="collapse3">
              Institutional Infrastructure
              <span class="glyphicon glyphicon-chevron-right pull-right" aria-hidden="true"></span>
            </a>
          </h4>
        </div>
        <div id="collapse3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading3">
          <div class="panel-body">
            <ul>
              <li><a href="#" id="link03-01">Link 1</a> | <a href="#" aria-describedby="link03-01">View Transcript</a></li>
              <li><a href="#" id="link03-02">Link 2</a> | <a href="#" aria-describedby="link03-02">View Transcript</a></li>
              <li><a href="#" id="link03-03">Link 3</a> | <a href="#" aria-describedby="link03-03">View Transcript</a></li>
            </ul>
          </div>
        </div>
      </section>
      <section class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading4" onclick="collapseDetails('PB');">
          <h4 class="panel-title">
            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse4" aria-expanded="false" aria-controls="collapse4">
              Support for Panchayat Bhawan
              <span class="glyphicon glyphicon-chevron-right pull-right" aria-hidden="true"></span>
            </a>
          </h4>
        </div>
        <div id="collapse4" class="panel-collapse collapse " role="tabpanel" aria-labelledby="heading4">
          <div class="panel-body">
            <ul>
              <li><a href="#" id="link01-01">Link 1</a> | <a href="#" aria-describedby="link01-01">View Transcript</a></li>
              <li><a href="#" id="link01-02">Link 2</a> | <a href="#" aria-describedby="link01-02">View Transcript</a></li>
              <li><a href="#" id="link01-03">Link 3</a> | <a href="#" aria-describedby="link01-03">View Transcript</a></li>
            </ul>
          </div>
        </div>
      </section>
      <section class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading5" onclick="collapseDetails('ATA');">
          <h4 class="panel-title">
            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse5" aria-expanded="false" aria-controls="collapse5">
             Administrative and Technical Activity 
              <span class="glyphicon glyphicon-chevron-right pull-right" aria-hidden="true"></span>
            </a>
          </h4>
        </div>
        <div id="collapse5" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading5">
          <div class="panel-body">
            <ul>
              <li><a href="#" id="link02-01">Link 1</a> | <a href="#" aria-describedby="link02-01">View Transcript</a></li>
              <li><a href="#" id="link02-02">Link 2</a> | <a href="#" aria-describedby="link02-02">View Transcript</a></li>
              <li><a href="#" id="link02-03">Link 3</a> | <a href="#" aria-describedby="link02-03">View Transcript</a></li>
            </ul>
          </div>
        </div>
      </section>
      <section class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading6" onclick="collapseDetails('EE');">
          <h4 class="panel-title">
            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse6" aria-expanded="false" aria-controls="collapse6">
             E-enablement
              <span class="glyphicon glyphicon-chevron-right pull-right" aria-hidden="true"></span>
            </a>
          </h4>
        </div>
        <div id="collapse6" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading6">
          <div class="panel-body">
            <ul>
              <li><a href="#" id="link03-01">Link 1</a> | <a href="#" aria-describedby="link03-01">View Transcript</a></li>
              <li><a href="#" id="link03-02">Link 2</a> | <a href="#" aria-describedby="link03-02">View Transcript</a></li>
              <li><a href="#" id="link03-03">Link 3</a> | <a href="#" aria-describedby="link03-03">View Transcript</a></li>
            </ul>
          </div>
        </div>
      </section>
      <section class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading7" onclick="collapseDetails('EG');">
          <h4 class="panel-title">
            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse7" aria-expanded="false" aria-controls="collapse7">
              E-Governance
              <span class="glyphicon glyphicon-chevron-right pull-right" aria-hidden="true"></span>
            </a>
          </h4>
        </div>
        <div id="collapse7" class="panel-collapse collapse " role="tabpanel" aria-labelledby="heading7">
          <div class="panel-body">
            <ul>
              <li><a href="#" id="link01-01">Link 1</a> | <a href="#" aria-describedby="link01-01">View Transcript</a></li>
              <li><a href="#" id="link01-02">Link 2</a> | <a href="#" aria-describedby="link01-02">View Transcript</a></li>
              <li><a href="#" id="link01-03">Link 3</a> | <a href="#" aria-describedby="link01-03">View Transcript</a></li>
            </ul>
          </div>
        </div>
      </section>
      <section class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading8" onclick="collapseDetails('PP');">
          <h4 class="panel-title">
            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse8" aria-expanded="false" aria-controls="collapse8">
              Pesa Plan
              <span class="glyphicon glyphicon-chevron-right pull-right" aria-hidden="true"></span>
            </a>
          </h4>
        </div>
        <div id="collapse8" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading8">
          <div class="panel-body">
            <ul>
              <li><a href="#" id="link02-01">Link 1</a> | <a href="#" aria-describedby="link02-01">View Transcript</a></li>
              <li><a href="#" id="link02-02">Link 2</a> | <a href="#" aria-describedby="link02-02">View Transcript</a></li>
              <li><a href="#" id="link02-03">Link 3</a> | <a href="#" aria-describedby="link02-03">View Transcript</a></li>
            </ul>
          </div>
        </div>
      </section>
      <section class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading9" onclick="collapseDetails('DL');">
          <h4 class="panel-title">
            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse9" aria-expanded="false" aria-controls="collapse9">
              Distance Learning Facility through SATCOM/IP
              <span class="glyphicon glyphicon-chevron-right pull-right" aria-hidden="true"></span>
            </a>
          </h4>
        </div>
        <div id="collapse9" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading9">
          <div class="panel-body">
            <ul>
              <li><a href="#" id="link03-01">Link 1</a> | <a href="#" aria-describedby="link03-01">View Transcript</a></li>
              <li><a href="#" id="link03-02">Link 2</a> | <a href="#" aria-describedby="link03-02">View Transcript</a></li>
              <li><a href="#" id="link03-03">Link 3</a> | <a href="#" aria-describedby="link03-03">View Transcript</a></li>
            </ul>
          </div>
        </div>
      </section>
      <section class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading10" onclick="collapseDetails('AFD');">
          <h4 class="panel-title">
            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse10" aria-expanded="false" aria-controls="collapse10">
             Administrative and Financial Data Analysis and Planning Cell
              <span class="glyphicon glyphicon-chevron-right pull-right" aria-hidden="true"></span>
            </a>
          </h4>
        </div>
        <div id="collapse10" class="panel-collapse collapse " role="tabpanel" aria-labelledby="heading10">
          <div class="panel-body">
            <ul>
              <li><a href="#" id="link01-01">Link 1</a> | <a href="#" aria-describedby="link01-01">View Transcript</a></li>
              <li><a href="#" id="link01-02">Link 2</a> | <a href="#" aria-describedby="link01-02">View Transcript</a></li>
              <li><a href="#" id="link01-03">Link 3</a> | <a href="#" aria-describedby="link01-03">View Transcript</a></li>
            </ul>
          </div>
        </div>
      </section>
      <section class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading11" onclick="collapseDetails('IA');">
          <h4 class="panel-title">
            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse11" aria-expanded="false" aria-controls="collapse11">
              Innovative Activities 
              <span class="glyphicon glyphicon-chevron-right pull-right" aria-hidden="true"></span>
            </a>
          </h4>
        </div>
        <div id="collapse11" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading11">
          <div class="panel-body">
            <ul>
              <li><a href="#" id="link02-01">Link 1</a> | <a href="#" aria-describedby="link02-01">View Transcript</a></li>
              <li><a href="#" id="link02-02">Link 2</a> | <a href="#" aria-describedby="link02-02">View Transcript</a></li>
              <li><a href="#" id="link02-03">Link 3</a> | <a href="#" aria-describedby="link02-03">View Transcript</a></li>
            </ul>
          </div>
        </div>
      </section>
      <section class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading12" onclick="collapseDetails('HSSD');">
          <h4 class="panel-title">
            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse12" aria-expanded="false" aria-controls="collapse12">
             HR Support SPRC and DPRC
              <span class="glyphicon glyphicon-chevron-right pull-right" aria-hidden="true"></span>
            </a>
          </h4>
        </div>
        <div id="collapse12" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading12">
          <div class="panel-body">
            <ul>
              <li><a href="#" id="link03-01">Link 1</a> | <a href="#" aria-describedby="link03-01">View Transcript</a></li>
              <li><a href="#" id="link03-02">Link 2</a> | <a href="#" aria-describedby="link03-02">View Transcript</a></li>
              <li><a href="#" id="link03-03">Link 3</a> | <a href="#" aria-describedby="link03-03">View Transcript</a></li>
            </ul>
          </div>
        </div>
      </section>
      <section class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading13" onclick="collapseDetails('PBSI');">
          <h4 class="panel-title">
            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse13" aria-expanded="false" aria-controls="collapse13">
              Project Based Support for Income Development and Income Enhancement 
              <span class="glyphicon glyphicon-chevron-right pull-right" aria-hidden="true"></span>
            </a>
          </h4>
        </div>
        <div id="collapse13" class="panel-collapse collapse " role="tabpanel" aria-labelledby="heading13">
          <div class="panel-body">
            <ul>
              <li><a href="#" id="link01-01">Link 1</a> | <a href="#" aria-describedby="link01-01">View Transcript</a></li>
              <li><a href="#" id="link01-02">Link 2</a> | <a href="#" aria-describedby="link01-02">View Transcript</a></li>
              <li><a href="#" id="link01-03">Link 3</a> | <a href="#" aria-describedby="link01-03">View Transcript</a></li>
            </ul>
          </div>
        </div>
      </section>
      <section class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading14" onclick="collapseDetails('IEC');">
          <h4 class="panel-title">
            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse14" aria-expanded="false" aria-controls="collapse14">
              IEC
              <span class="glyphicon glyphicon-chevron-right pull-right" aria-hidden="true"></span>
            </a>
          </h4>
        </div>
        <div id="collapse14" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading14">
          <div class="panel-body">
            <ul>
              <li><a href="#" id="link02-01">Link 1</a> | <a href="#" aria-describedby="link02-01">View Transcript</a></li>
              <li><a href="#" id="link02-02">Link 2</a> | <a href="#" aria-describedby="link02-02">View Transcript</a></li>
              <li><a href="#" id="link02-03">Link 3</a> | <a href="#" aria-describedby="link02-03">View Transcript</a></li>
            </ul>
          </div>
        </div>
      </section>
      <section class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading15" onclick="collapseDetails('PMU');">
          <h4 class="panel-title">
            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapse15">
              PMU
              <span class="glyphicon glyphicon-chevron-right pull-right" aria-hidden="true"></span>
            </a>
          </h4>
        </div>
        <div id="collapse15" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading15">
          <div class="panel-body">
            <ul>
              <li><a href="#" id="link03-01">Link 1</a> | <a href="#" aria-describedby="link03-01">View Transcript</a></li>
              <li><a href="#" id="link03-02">Link 2</a> | <a href="#" aria-describedby="link03-02">View Transcript</a></li>
              <li><a href="#" id="link03-03">Link 3</a> | <a href="#" aria-describedby="link03-03">View Transcript</a></li>
            </ul>
          </div>
        </div>
      </section>
    </article>
  </main>
</div>
</div>

					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
<style>
.bs-accordion {
  .panel-heading {
    // remove the padding on the heading so we can increase the click area of the anchor
    padding: 0;
    a {
      // increase the click area of the anchor trigger to match the original .panel-heading
      display: block;
      padding: 10px 15px;
      
      // spin the chevron!
      &[aria-expanded=true] {
        .glyphicon.glyphicon-chevron-right {
          transform: rotate(90deg);
          transition: transform 350ms cubic-bezier(0.645, 0.045, 0.355, 1);
        }
      }
      .glyphicon.glyphicon-chevron-right {
        transition: transform 350ms cubic-bezier(0.645, 0.045, 0.355, 1);
      }
    }
  }
}
</style>
