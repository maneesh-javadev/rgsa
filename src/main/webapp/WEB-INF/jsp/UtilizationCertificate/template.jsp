<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<title>FORM GFR 12C</title>
		<style type="text/css">
		body {
		  font-size: 4mm;
		  margin: 0;
		  padding:0;
		}
		page {
		  background: #FFF;
		  display: block;
		}
		
		.ruled {
			margin-left: 2cm;
			margin-right: 2cm;
			/* width: 17cm; */
		}
		
		.main-header-div {
			width: 100%;
			display: flex;
			flex-flow: row wrap;
		}
		
		.left-header {
			background-color:#c6e672 !important;
			height: 3cm;
			/* width: 15cm; */
			width: 70%;
		}
		.left-header-cont {
			display: flex;
			margin-top: 0.5cm;
			flex-flow: row nowrap;
			margin-left: 2cm;
			justify-content: left;
		}
		.left-header-cont img {
			height: 2cm;
		}
		.left-header-cont .left-header-texts {
			display: flex;
			flex-flow: column nowrap;	
			justify-content: center;
			padding-left: 5mm;
		}
		.central-header {
			background-color: #6bc32f !important;
			height: 2cm;
			width: 5cm;
			margin-left: -1cm;
			text-align: center;
			
		}
		.central-header h1 {
			color: #FFF;
			font-size: 5mm;
			font-weight: 800;
			margin-top: 1cm;
		}
		.text-center {
			text-align: center;
		}
		.padded {
			padding: 2mm;
		}
		.no-bottom {
			line-height: 8mm;
			margin-bottom: 0;
		}
		
		table {
			border-collapse:collapse;
			border-spacing:0;
		}		
		table tr {
			padding: 2mm;
		}
		td p {
			padding: 1mm 5mm;
			line-height: 7mm;
		}
		.encroach-top {
			margin-top: -1.5cm;
		}
		.bordered {
			border:solid 0.5mm #000;
		}
		
		.bordered-upper {
			border-top: solid 0.5mm #000;
			border-right: solid 0.5mm #000;
		}
		
		.bordered-lower {
			border-bottom: solid 0.5mm #000;
			border-right: solid 0.5mm #000;
		}

		filled {
			border-bottom: dashed 0.2mm #333;
			font-weight: bold;
		}
		
		.right-pushed {
		    width: 100%;
		    display: flex;
		    flex-flow: row-reverse;		
		}
		.left-markers {
		    width: 40%;
		    display: flex;
		    flex-flow: column nowrap;		
		}
		.left-markers p {
			padding: 1mm 0mm;
			margin: 0;
		}
		@media print {
			body, page {
				margin: 0 0;
				background-color: #FFF;
				-webkit-print-color-adjust: exact;
				width:100%;
			}
			page.A4 {  
				min-width: 210mm;
				min-height: 296mm; 
			}
			.print-option {
				display:none;
			}
		}
		@media screen {
			body {			
				background: rgb(204,204,204);
			}
			page {
				margin: 0 auto;
				margin-bottom: 0.5cm;
				box-shadow: 0 0 0.5cm rgba(0,0,0,0.5);
			}
			page.A4 {  
			  width: 210mm;
			  height: 296mm; 
			}
			.print-option {
				display:block;
				position:absolute;
				top: 40%;
				right:0;
				width: 2cm;
				height: 2cm;
				background-color: #336699;
				color: white;
				border: 0;
				cursor:pointer;
			}
		}
		@page {
		    margin: 0;
		    padding: 0;
		}
		</style>
	</head>

	<body>
		<page class="A4">
			<div class="main-header-div">
			    <div class="left-header">
			    	<div class="left-header-cont">
				    	<img alt="Emblem" src="${pageContext.request.scheme}://${pageContext.request.localName}${pageContext.request.localPort == 80 ? "" : String.format(":%d", pageContext.request.localPort) }${pageContext.request.contextPath}/resources/images/Emblem_of_India.svg"/>
				    	
				    	<div class="left-header-texts">
				    		<span><b>GENERAL FINANCIAL RULES 2017</b></span>
				    		<span>Ministry of Finance</span>
				    		<span>Department of Expenditure</span>			    	
				    	</div>
				    </div>
			    </div>
			    <div class="central-header"><h1>FORM GFR 12C</h1></div>
			</div>
			<div class="text-center ruled padded">
				<h3 class="no-bottom">GFR 12 - C</h3>
				<span>[(See Rule 239)]</span>
				<h4 class="no-bottom">FORM OF UTILIZATION CERTIFICATE (FOR STATE GOVERNMENTS)</h4>
				<span>(Where expenditure incurred by Govt. bodies only)</span>
			</div>
			
			<div class="ruled">
				<p>1.</p>
				<table border="0">
					<tr class="bordered-upper">
						<th class="bordered">Sl no.</th>
						<th class="bordered">Letter No. and date</th>
						<th class="bordered">Amount</th>
						<th></th>
					</tr>
					<tr class="bordered-lower">
						<td class="bordered"></td>
						<td class="bordered"></td>
						<td class="bordered"></td>										
						<td>
							<p class="encroach-top">
							Certified that out of Rs <filled>${total_sanction}</filled> of grants sanctioned during 
							the year <filled>${financial_year}</filled> in favour of <filled>${payee}</filled> under the Ministry/Department 
							Letter No. given in the margin and Rs <filled>${past_unspent}</filled> on account of unspent balance of the previous 
							year, a sum of Rs <filled>${spent}</filled> has been utilized for the propose 
							of <filled>${purpose}</filled> for which it was sanctioned and that the balance of 
							Rs <filled>${not_utilized}</filled> remaining unutilized at the end of the year has been surrendered to 
							Government (vide No. <filled>${letter_number}</filled> dated <filled>${letter_date}</filled>) will be adjusted towards the 
							grants payable during the next year <filled>${next_fin_year}</filled> 
							</p>
						</td>
					</tr>
				</table>
				<div class="padded">
					<p>
					2. Certified that I have satisfied myself that the conditions on which the grants-in-aid was sanctioned have been 
					duly fulfilled/ are being fulfilled and that I have exercised the following checks to see that the money was 
					actually utilized for the propose for which it was sanctioned.
					</p>
					<p> Kinds of checks exercised.
						<ol>
							<li> </li>
							<li> </li>
						</ol>					
					</p>
				</div>
				<div class="right-pushed">
					<div class="left-markers">
						<p>Signature</p>
						<p>Designation</p>
						<p>Date</p>
					</div>
				</div>
				<div class="padded">
					<p><small><b>PS</b>: The UC shall disclose separately the actual expenditure incurred and loans and advances given to suppliers of 
					stores and assets, to construction agencies and like in accordance with scheme guidelines and in furtherance to the scheme 
					objectives, which do not constitute expenditure at the stage. These shall be treated as utilized grants but allowed to 
					be carried forward.
					</small></p>
				</div>
			</div>			
		</page>
		<button class="print-option" onclick="window.print();">Print this page</button>
	</body>

</html>
