<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="en">
	<head>
		<title>Department Shift Vacation Time Report</title>
		<link rel="stylesheet" type="text/css" 
      		href="../css/general.css" />
	</head>
	<body>
		<cfinclude template="../includes/header.cfm">
		<cfinclude template="../includes/check_rights.cfm">

		<cfparam name="dept" default="" type="string">
		<cfparam name="shift" default="" type="string">

		<cfquery name="showDeptShiftVac"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
           SELECT tbemp_day_req.day_req, tbemp_day_req.num_los, tbemp.first_name, tbemp.last_name, tbemp.dept_id, tbemp.shift_id, tbemp_type.emp_type
			FROM tbemp_type INNER JOIN (tbemp INNER JOIN tbemp_day_req ON tbemp.num_los = tbemp_day_req.num_los) ON tbemp_type.emp_type_id = tbemp.emp_type_id
			WHERE tbemp.dept_id =
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#dept#"> AND tbemp.shift_id
					=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#shift#">
			ORDER BY 4
        </cfquery>
    

        <cfquery name="showDeptShift"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          SELECT tbdept.dept_id, tbshift.shift_id, tbdept.dept, tbshift.shift
			FROM tbdept, tbshift
			WHERE (((tbdept.dept_id)='#Cookie.deptId#') AND ((tbshift.shift_id)='#Cookie.shiftId#'))
        </cfquery>

        
       
		
		<!-- Main Part of Page -->
		<div class="container">
			<div class="main">
				
					<h2>
					<cfoutput>#dept#&nbsp; Shift #shift#
					</cfoutput>
					
	          		</h2>
	          		<cfif showDeptShiftVac.RecordCount GT 0>
						<table class="report">
							<tr><th>Employee</th><th>Day</th></tr>
							<cfoutput query ="showDeptShiftVac">
							<tr><td>#first_name# #last_name#</td><td>#DateFormat(day_req,'DD-MMM-YYYY')#</td></tr> 
							</cfoutput> 

						</table>
				<cfelse>
					<p> There are no vacation days selected yet.</p>
				</cfif>
          		
			</div>
		</div>

		 	<cfinclude template="../includes/sidebar.cfm">

			<cfinclude template="../includes/footer.cfm">
	</body>
</html>
