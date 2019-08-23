<%@include file="../taglib/taglib.jsp"%>
<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>500 </title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/waves/css/waves.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core/style.css">
</head>
<section class="five-zero-zero" style="background-color: #f2f2f2; margin-top: 4%; padding: 2%">
    <div class="five-zero-zero-container">
    	<div><img src="${pageContext.request.contextPath}/resources/images/oops-error.jpg"> </div>
         <div class="error-message">Something went wrong</div>
        <div class="error-id">Error Id : ${ERROR_ID }</div>
        <div class="button-place">
        	<c:choose>
        		<c:when test="${!empty sessionScope['scopedTarget.userPreference'].userName}">
        			<a href="home.html" class="btn btn-primary btn-lg waves-effect">GO TO HOMEPAGE</a><br>
        		</c:when>
        		<c:otherwise>
					<a href="index.html" class="btn btn-primary btn-lg waves-effect">GO TO HOMEPAGE</a><br>        		
        		</c:otherwise>
        	</c:choose>
        </div>
    </div>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery.min.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/bootstrap/js/bootstrap.min.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/waves/js/waves.min.js"></script>
</section>

<footer style="margin-top: -5%;color: white;background-color: #3b1576;padding: 30px;">
	<div class="row clearfix">
		<div class="col-lg-8">
			<p class="text-left">
				Content on this website is updated by field level agencies and
				managed by the <a href="http://www.panchayat.gov.in/"
					target="_blank"> Ministry of Panchayati Raj (MoPR)</a>, Government
				of India <br>Site is technically designed, hosted and
				maintained by <a href="http://www.nic.in/" target="_blank">National
					Informatics Centre (NIC)</a> <br />
			</p>
		</div>
		<div class="col-lg-4 text-center">
			<a class="relatedLogo" href="http://india.gov.in"> <img
				src="${pageContext.request.contextPath}/resources/index/images/india-gov-logo.png"
				alt="India Portal" title="Click here"></a> <img
				src="${pageContext.request.contextPath}/resources/index/images/nic-small.png"
				alt="nic-logo"> <img
				src="${pageContext.request.contextPath}/resources/index/images/mopr.png"
				alt="MOPR"><img
				src="${pageContext.request.contextPath}/resources/index/images/swachh-bharat_white.png"
				alt="swachh-bharat-logo">

		</div>
	</div>
</footer>
