<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="en">
	<head>
		<title>Access Violation</title>
		<link rel="stylesheet" type="text/css" 
      		href="../css/general.css" />
	</head>
	<body>
		
		<cfinclude template="../includes/header.cfm">
	
		<!-- Main Part of Page -->
		<div class="container">
			<cfif (Cookie.empTypeId is "EMP")>
				<div class="main2">
			<cfelse>
				<div class="main">
			</cfif>
				<h2 class="errorMsg">
					<cfoutput>#Cookie.firstName#&nbsp;#Cookie.lastName#!
					</cfoutput> Are you being naughty?
	          	</h2>
	          	<p>You've attempted to access information that you shouldn't based on your role in PharmacyChain.com. If you believe you are seeing this page by mistake, please contact HR or your function manager to gain the rights to view this information.</p>
          		
          		
			</div>
		</div>

		 <cfif (Cookie.empTypeId is "HR" or Cookie.empTypeId is "MGR" )>
		 	<cfinclude template="../includes/sidebar.cfm">
		 </cfif>

			<cfinclude template="../includes/footer.cfm">
	</body>
</html>
