<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/dataTables/css/dataTables.bootstrap.min.css">
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/jquery.dataTables.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/dataTables.bootstrap.min.js"></script>

<script>

$(function () {
    $('.js-basic-example').DataTable({
        responsive: true
    });
});

</script>

<%@include file="../taglib/taglib.jsp"%>
    <section class="content">
        <div class="container-fluid">
            <div class="block-header">
            </div>
            <div class="row clearfix">
                <!-- Task Info -->
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="card">
                        <div class="header">
                           <!--  <h2><i class="fa fa-info-circle view-color" aria-hidden="true"></i> </h2> -->
                        </div>
                        <div class="body">
                            <div class="row">
                              <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                              		<p class="text-center font-40"> <i class='fa fa-frown-o fa-3x delete-color'></i></p>
                              </div>
                            </div>
                            <div class="row">
                              <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                              	<p class="font-bold text-center delete-color">
                              		Under development please try after some time.
                              	</p>
                              </div>
                            </div>
						  </div>
                    </div>
                </div>
            </div>
        </div>
    </section>