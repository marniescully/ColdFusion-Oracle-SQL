<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="en">
	<head>
		<title>Employee Profile</title>
		<link rel="stylesheet" type="text/css" 
      		href="../css/general.css" />
	</head>
	<body>
		<cfinclude template="../includes/header.cfm">
		<cfinclude template="../includes/check_rights.cfm">
			
		<cfquery name="showDeptShift"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          SELECT tbdept.dept, tbshift.shift,tbemp.first_name, tbemp.last_name, tbemp.num_vac_days
			FROM (tbdept INNER JOIN tbemp ON tbdept.dept_id = tbemp.dept_id) INNER JOIN tbshift ON tbemp.shift_id = tbshift.shift_id
			WHERE tbemp.num_los = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#los#">
        </cfquery>
        <cfquery name="showEmpType"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          SELECT  tbemp_type.emp_type
			FROM tbemp_type INNER JOIN tbemp ON tbemp_type.emp_type_id = 	tbemp.emp_type_id
			WHERE tbemp.num_los=
 						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#los#">
        </cfquery>
		
		<!-- Main Part of Page -->
		<div class="container">
			<cfif (Cookie.empTypeId is "EMP")>
				<div class="main2">
			<cfelse>
				<div class="main">
			</cfif>
				<div class="float_left">
					<h2>
						<cfoutput query="showDeptShift">#first_name# #last_name#
						</cfoutput>
		          	</h2>

					<p>Employee Type:
						<cfoutput query="showEmpType">#emp_type#</cfoutput>
					</p>
					<p>
						<cfoutput  query="showDeptShift">#dept#</cfoutput> Department
					</p>
					<p><cfoutput query="showDeptShift">#shift#</cfoutput>
					 Shift
					</p>

		          	<p>Number of Vacation Days Available <cfoutput query="showDeptShift">#num_vac_days#</cfoutput></p>
          		</div>
          		<div class="float_right">
          			<cfoutput query="showDeptShift">
          			<p><a href="../private/add_mod_prof.cfm?mode=emp&amp;los=#los#">Modify Employee's Profile</a></p>
          			<p><a href="../private/add_mod_vac.cfm?mode=emp&amp;los=#los#">Modify Employee's Vacation Time</a></p>
          			</cfoutput>
	          	</div>
			</div>
		</div>

		 	<cfif (#Cookie.empTypeId# is "HR" or #Cookie.empTypeId# is "MGR" )>
		 	<cfinclude template="../includes/sidebar.cfm">
		 </cfif>

			<cfinclude template="../includes/footer.cfm">
	</body>
</html>
