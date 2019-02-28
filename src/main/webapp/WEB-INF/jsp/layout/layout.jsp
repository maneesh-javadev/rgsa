<%@include file="../taglib/taglib.jsp"%>
 <%@ taglib uri="http://esapi/tags-html" prefix="esapi"%> 
<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>RGSA</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/waves/css/waves.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/others/css/animate.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/admin/themes/all-themes.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/font-awesome/font-awesome-4.2.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/sweetalert/sweetalert.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/fonts/fonts.css">

<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/bootstrap-select/css/bootstrap-select.css"> --%>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery.min.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/bootstrap/js/bootstrap.min.js"></script>
</head>
 <!-- Start body -->
<body class="theme-blue ">
 <!-- Page Loader -->
    <div class="page-loader-wrapper">
        <div class="loader">
            <div class="preloader">
                <div class="spinner-layer pl-red">
                    <div class="circle-clipper left">
                        <div class="circle"></div>
                    </div>
                    <div class="circle-clipper right">
                        <div class="circle"></div>
                    </div>
                </div>
            </div>
            <p>Please wait...</p>
        </div>
    </div>
 <div class="overlay"></div>
 <tiles:insertAttribute name="sidebar" ignore="true" />
 <tiles:insertAttribute name="header" ignore="true" />
 
 <tiles:insertAttribute name="body" ignore="true" />	
 <!-- Include JS File -->
 <script  type="text/javascript" src="${pageContext.request.contextPath}/resources/js/core/admin.js"></script>
 <script  type="text/javascript" src="${pageContext.request.contextPath}/resources/js/core/demo.js"></script>
 <%-- <script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/bootstrap-select/js/bootstrap-select.js"></script> --%>
 <script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery.slimscroll.js"></script>
 <script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/waves/js/waves.min.js"></script>
 <script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/bootstrap-notify/bootstrap-notify.min.js"></script>
 <script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/sweetalert/sweetalert.min.js"></script>

<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/js/utils/common-utils.js"></script>

<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/others/js/tooltips-popovers.js"></script>
 
 <!-- #####################################Alert ############################### -->
 <c:if test="${not empty SUCCESS}">
 <script type="text/javascript">
$( document ).ready(function() {
	$.notify({
		message: "<i class='fa fa-check-circle fa-2x'></i>  <spring:message code="${SUCCESS}"/>"
	},{
		mouse_over: 'pause',
		type: 'success',
		animate: {
			enter: 'animated zoomInRight',
			exit: 'animated zoomOutRight'
		},
		placement: {
			from: "top",
			align: "center"
		},
		offset: {
			x: 100,
			y: 200
		},
	});
});
</script>
 </c:if>
 <c:if test="${not empty param.SUCCESS}">
<script type="text/javascript">
$( document ).ready(function() {
	$.notify({
		message: "<br/> <i class='fa fa-check-circle fa-2x'></i>  <spring:message code="${param.SUCCESS}"/>"
	},{
		mouse_over: 'pause',
		type: 'success',
		animate: {
			enter: 'animated zoomInRight',
			exit: 'animated zoomOutRight'
		},
		placement: {
			from: "top",
			align: "center"
		},
		offset: {
			x: 100,
			y: 200
		},
	});
});
</script>
</c:if>

<c:if test="${!empty ERROR}">
<script type="text/javascript">
$( document ).ready(function() {
	$.notify({
		message: "<spring:message code="${ERROR}"/>"
	},{
		mouse_over: 'pause',
		type: 'danger',
		animate: {
			enter: 'animated zoomInRight',
			exit: 'animated zoomOutRight'
		},
		placement: {
			from: "top",
			align: "center"
		},
	});
});
</script>
</c:if>

<c:if test="${!empty param.ERROR}">
<script type="text/javascript">
$( document ).ready(function() {
	$.notify({
		message: "<spring:message code="${param.ERROR}"/>"
	},{
		mouse_over: 'pause',
		type: 'danger',
		animate: {
			enter: 'animated zoomInRight',
			exit: 'animated zoomOutRight'
		},
		placement: {
			from: "top",
			align: "center"
		},
	});
});
</script>
</c:if>
<c:if test="${!empty ALERT}">
<script type="text/javascript">
$( document ).ready(function() {
	$.notify({
		message: "<i class='fa fa-exclamation-triangle fa-2x'></i>  <spring:message code="${ALERT}"/>"
	},{
		mouse_over: 'pause',
		type: 'warning',
		animate: {
			enter: 'animated zoomInRight',
			exit: 'animated zoomOutRight'
		},
		placement: {
			from: "top",
			align: "center"
		},
		offset: {
			x: 100,
			y: 200
		},
	});
});
</script>

</c:if>
 <c:if test="${!empty param.ALERT}">
 <script type="text/javascript">
$( document ).ready(function() {
	$.notify({
		message: "<i class='fa fa-exclamation-triangle fa-2x'></i>  <spring:message code="${param.ALERT}"/>"
	},{
		mouse_over: 'pause',
		type: 'warning',
		animate: {
			enter: 'animated zoomInRight',
			exit: 'animated zoomOutRight'
		},
		placement: {
			from: "top",
			align: "center"
		},
		offset: {
			x: 100,
			y: 200
		},
	});
});
</script>
 </c:if>
 
<c:if test="${!empty UPDATE}">
<script type="text/javascript">
$( document ).ready(function() {
	$.notify({
		message: "<i class='fa fa-pencil-square-o fa-2x'></i>  <spring:message code="${UPDATE}"/>"
	},{
		mouse_over: 'pause',
		type: 'success',
		animate: {
			enter: 'animated zoomInRight',
			exit: 'animated zoomOutRight'
		},
		placement: {
			from: "top",
			align: "center"
		},
		offset: {
			x: 100,
			y: 200
		},
	});
});
</script>
</c:if>
<c:if test="${!empty param.UPDATE}">
<script type="text/javascript">
$( document ).ready(function() {
	$.notify({
		message: "<i class='fa fa-pencil-square-o fa-2x'></i>  <spring:message code="${param.UPDATE}"/>"
	},{
		mouse_over: 'pause',
		type: 'success',
		animate: {
			enter: 'animated zoomInRight',
			exit: 'animated zoomOutRight'
		},
		placement: {
			from: "top",
			align: "center"
		},
		offset: {
			x: 100,
			y: 200
		},
	});
});
</script>
</c:if>
<c:if test="${!empty DELETE}">
<script type="text/javascript">
$( document ).ready(function() {
	$.notify({
		message: "<i class='fa fa-trash fa-2x'></i> <spring:message code="${DELETE}"/>"
	},{
		mouse_over: 'pause',
		type: 'success',
		animate: {
			enter: 'animated zoomInRight',
			exit: 'animated zoomOutRight'
		},
		placement: {
			from: "top",
			align: "center"
		},
		offset: {
			x: 100,
			y: 200
		},
	});
});
</script>
</c:if>


 <c:if test="${!empty param.DELETE}"> 
<script type="text/javascript">
$( document ).ready(function() {
	$.notify({
		message: "<i class='fa fa-trash fa-2x'></i>  <spring:message code="${param.DELETE}"/>"
	},{
		mouse_over: 'pause',
		type: 'success',
		animate: {
			enter: 'animated zoomInRight',
			exit: 'animated zoomOutRight'
		},
		placement: {
			from: "top",
			align: "center"
		},
		offset: {
			x: 100,
			y: 200
		},
	});
});
</script>
</c:if>

<c:if test="${not empty EXCEPTION}">  
<script type="text/javascript">
$( document ).ready(function() {
	$.notify({
		message: "<i class='fa fa-exclamation-triangle '></i> <spring:message code="${EXCEPTION}"/> ",
	},{
		mouse_over: 'pause',
		type: 'danger',
		animate: {
			enter: 'animated zoomInRight',
			exit: 'animated zoomOutRight'
		},
		placement: {
			from: "top",
			align: "center"
		},
		offset: {
			x: 100,
			y: 200
		},
	});
});
</script>
</c:if>  
 
</body>

 <!-- End body -->
</html>