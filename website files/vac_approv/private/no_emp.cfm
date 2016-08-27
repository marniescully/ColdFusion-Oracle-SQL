<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="en">
	<head>
		<title>No Employee Found</title>
		<link rel="stylesheet" type="text/css" 
      		href="../css/general.css" />
	</head>
	<body>
		<cfinclude template="../includes/header.cfm">
		<cfinclude template="../includes/check_rights.cfm">	
		
       
		
		<!-- Main Part of Page -->
		<div class="container">
			<cfif (Cookie.empTypeId is "EMP")>
				<div class="main2">
			<cfelse>
				<div class="main">
			</cfif>
				<div class="float_left">
					<h2>
						No Employee Found
	          		</h2>

				<p><a href="search.cfm">Search for another employee</a>
				</p>
				
          		</div>
          		
			</div>
		</div>

		 	<cfinclude template="../includes/sidebar.cfm">

			<cfinclude template="../includes/footer.cfm">
	</body>
</html>
