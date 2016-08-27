<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="en">
	<head>
		<title>HR Vacation Approval Database</title>
		<link rel="stylesheet" type="text/css" 
      		href="../css/general.css" />
	</head>
	<body>
		<cfinclude template="../includes/header.cfm">
			
		<cfquery name="showEmpInfo"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          SELECT tbdept.dept, tbshift.shift,tbemp.first_name,tbemp.last_name
			FROM (tbdept INNER JOIN tbemp ON tbdept.dept_id = tbemp.dept_id) INNER JOIN tbshift ON tbemp.shift_id = tbshift.shift_id
			WHERE tbemp.num_los = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Cookie.los#">
        </cfquery>
        <cfquery name="showEmpType"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          SELECT emp_type
			FROM tbemp_type
			WHERE tbemp_type.emp_type_id = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Cookie.empTypeId#">
        </cfquery>
			
		<cfquery name="showVacDays"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          		SELECT tbemp_day_req.day_req, tbemp_day_req.num_los
				FROM tbemp_day_req
				WHERE tbemp_day_req.num_los = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Cookie.los#">

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
					<cfoutput>#showEmpInfo.first_name#&nbsp;#showEmpInfo.last_name#
					</cfoutput>
	          	</h2>

				<p>Employee Type:
					<cfoutput query="showEmpType">#emp_type#</cfoutput>
				</p>
				<p>
					<cfoutput  query="showEmpInfo">#dept#</cfoutput> Department
				</p>
				<p><cfoutput query="showEmpInfo">#shift#</cfoutput>
				 Shift
				</p>

	          	<p># of Vacation Days Available <cfoutput>#Cookie.numVacDays#</cfoutput></p>
	          </div>
	          <div class="float_right">
	          	<cfif showVacDays.RecordCount GT 0>
	          	</br>
		          	<table>
		          		<tr><th>Chosen Vacation Days</th></tr>
		          	<cfoutput query="showVacDays">	
		          		<tr><td>#DateFormat(day_req,'DD-MMM-YYYY')#</td></tr>
		          	</cfoutput>
		          	</table>
	          	<cfelse>
	          		<p>You haven't chosen any vacation days yet.</p>
	          	</cfif>

	          	
	          	<p><a href="../private/add_mod_prof.cfm">Modify Your Profile</a>
	          	</p>
          		<p><a href="../private/add_mod_vac.cfm">Modify Your Vacation Time</a>
          		</p>
	          </div>
			</div>
		</div>
		 <cfif (#Cookie.empTypeId# is "HR" or #Cookie.empTypeId# is "MGR" )>
		 	<cfinclude template="../includes/sidebar.cfm">
		 </cfif>

		<cfinclude template="../includes/footer.cfm">
	</body>
</html>
