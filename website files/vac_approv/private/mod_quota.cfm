<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="en">
	<head>
		<title>Change Department Quotas</title>
		<link rel="stylesheet" type="text/css" 
      		href="../css/general.css" />
	</head>
	<body>
		<cfinclude template="../includes/header.cfm">
		<cfinclude template="../includes/check_rights_HR.cfm">
		<cfparam name="msg" default="no" type="string">
		
		<!-- Employee Type List -->	
		<cfquery name="showDeptShiftNum"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  			SELECT tbdept.dept, tbshift.shift, tbdept_shift.num_emp_out,tbdept_shift.dept_id,tbdept_shift.shift_id
					FROM tbshift INNER JOIN (tbdept INNER JOIN tbdept_shift ON tbdept.dept_id = tbdept_shift.dept_id) ON tbshift.shift_id = tbdept_shift.shift_id
					ORDER BY 1,2
		</cfquery>

		

		<cfif IsDefined("Form.update")>
		
			<cfquery name="updateDeptShiftNum"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  			UPDATE tbdept_shift
					SET 						
						num_emp_out  = 
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.num_emp_out#">
					WHERE 
						dept_id = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.dept_id#"> AND
						shift_id = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.shift_id#">
				</cfquery>
				<cfoutput>
						<cflocation url="mod_quota.cfm?msg=yes" addtoken="no">
					</cfoutput>
				
		</cfif>
		<!-- Main Part of Page -->
		<div class="container">
			<div class="main">
				<p>There may be a time when a department needs to change the amount of employees that can be off at one time on a work day. It would be appropriate to edit the department quota of that department and shift.
				</p>
				<div class="float_both">
					 <cfif (#msg# is 'yes')>
          				<p class="errorMsg">Department Quota updated.</p>
        			</cfif>
					<h3>Change Department Quotas</h3>
						<table>
							<tr><th>Department</th><th>Shift</th><th>Employee Out Quota</th><th>&nbsp;</th></tr>
							<cfoutput query="showDeptShiftNum">
								<cfform action="mod_quota.cfm" method="post">
									<cfinput name="dept_id" type="hidden" value="#dept_id#">
									</cfinput>
									<cfinput name="shift_id" type="hidden" value="#shift_id#">
									</cfinput>
									<tr>
										<td>#dept#</td>
										<td>#shift#</td>
										<td>
											<cfinput name="num_emp_out" type="text" value="#num_emp_out#" size="25" maxlength="2" required="yes" validate="integer"validateAt = "onSubmit" range="1,10" message="Please enter a number.">
											</cfinput>
										</td>
										<td>
											<cfinput name="update" type="submit" value="Update"></cfinput>
										</td>
									</tr>
								</cfform>
							</cfoutput>
						</table>
	              			
	              		</p>
	              		
					
	          	</div>
	          	
			</div>
		</div>

		 	<cfinclude template="../includes/sidebar.cfm">

			<cfinclude template="../includes/footer.cfm">
	</body>
</html>
