<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="en">
	<head>
		<title>Search Employees</title>
		<link rel="stylesheet" type="text/css" 
      		href="../css/general.css" />
	</head>
	<body>
		<cfinclude template="../includes/header.cfm">
		<cfinclude template="../includes/check_rights.cfm">
		
		<cfparam name="msg" default="no" type="string">
		
		<cfif IsDefined("Form.search")>
			<cfquery name="searchEmp"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  			SELECT num_los,first_name,last_name
		  			FROM tbemp
					WHERE 
						LOWER(last_name) LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#LCase(Form.search_txt)#%">
				</cfquery>

		</cfif>
		
		<!-- Main Part of Page -->
		<div class="container">
			<div class="main">
				<div class="float_both">
					<cfif IsDefined("Form.search")>
						<cfif searchEmp.RecordCount GT 0>
							<p>Your Search Results</p>
							<table>
		          				<cfoutput query="searchEmp">
				          			<tr>
				          				<td>
				          					<a href="../private/add_mod_prof.cfm?mode=emp&los=#num_los#">#first_name# #last_name#</a>
				          				</td>
				          			</tr>
		          				</cfoutput>
	         				</table>
						<cfelse>
							<p>There are no employees that match that search.</p>
						</cfif>
					
					</cfif>		
        			
					<h3>Search for an Employee by last name</h3>		
					<cfform action="search.cfm" method="post">
						<cfinput name="search_txt" type="text" size="25" maxlength="50" required="yes" validate="required" validateAt = "onSubmit"  message="Please enter a last name for an employee."></cfinput>	
						<cfinput name="search" type="submit" value="Search"></cfinput>
					</cfform>
	          	</div>
			</div>
		</div>

		 	<cfinclude template="../includes/sidebar.cfm">

			<cfinclude template="../includes/footer.cfm">
	</body>
</html>
