<div class="side_bar">
	<cfif (Cookie.empTypeId is "MGR")>
		<cfquery name="showDeptShift"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  SELECT tbdept.dept, tbshift.shift
			FROM (tbdept INNER JOIN tbemp ON tbdept.dept_id = tbemp.dept_id) INNER JOIN tbshift ON tbemp.shift_id = tbshift.shift_id
			WHERE tbemp.num_los = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Cookie.los#">
		</cfquery>
		
		<cfquery name="showEmps"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  SELECT tbemp.dept_id, tbemp.shift_id, tbemp.num_los, tbemp.first_name, tbemp.last_name
			FROM tbemp
			WHERE tbemp.dept_id = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Cookie.deptId#"> 
			AND tbemp.shift_id =  <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Cookie.shiftId#"> AND tbemp.num_los <> <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Cookie.los#">
		</cfquery>


		<div class="nav22">
			<cfif showEmps.RecordCount GT 0>	
			<table>
				<tr>
					<td>
						<h3>
							<cfoutput query="showDeptShift">
								#dept#
							</cfoutput> Department</br>
							<cfoutput query="showDeptShift">
								#shift#
							</cfoutput> Shift
						</h3>
					</td>
				</tr>
				<tr>
					<td>
						<ul class="nav2">
							<cfoutput>
							<li><a href="dept_shift_vac_report.cfm?dept=#Cookie.deptId#&shift=#Cookie.shiftId#">All Employee Report</a>
							</li>
							</cfoutput>
						</ul>
					</td>
				</tr>
				<tr>
					<td><h4>Employee</h4></td>
				</tr>
				<cfoutput query="showEmps">
				<tr>
					<td>
						<ul class="nav2">
							<li><a href="emp_prof.cfm?los=#num_los#">#first_name# #last_name#</a>
							</li>
						</ul>
					</td>
				</tr>
				</cfoutput>
			</table>
			</cfif>

		</div>

	<cfelse>
		<cfquery name="showDepts"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  SELECT *
		  FROM tbdept
		</cfquery>

<div class="nav22">
	<table>
	<tr><th><h3>Department Reports</h3></th></tr>
	<tr>
		<td>
			<ul class="nav2">
				<li><a href="all_dept_shift_vac_report.cfm">All Departments Report</a>
				</li>
			</ul>
		</td>
	</tr>
		<cfoutput query="showDepts">
		
		<tr>

			<td>
				<h4>#dept#</h4>
				<ul class="nav2">
					<li><a href="dept_shift_vac_report.cfm?dept=#dept_id#&shift=1">First Shift</a></li>
					<li><a href="dept_shift_vac_report.cfm?dept=#dept_id#&shift=2">Second Shift</a></li>
					<li><a href="dept_shift_vac_report.cfm?dept=#dept_id#&shift=3">Third Shift</a></li>
				</ul>
			</td>
		</tr>
		</cfoutput>
	</table>
</div>
</cfif>
</div>