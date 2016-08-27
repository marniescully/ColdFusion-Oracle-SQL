<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="en">
	<head>
		<title>Add or Modify an Employee</title>
		<link rel="stylesheet" type="text/css" 
			href="../css/general.css" />
	</head>


	<body>
		<cfinclude template="../includes/header.cfm">
		
		<cfparam name="los" default="m" type="string">
		<cfparam name="mode" default="mine" type="string">

		<cfif (#mode# is 'emp') and not(#los# is #Cookie.los#)>
			<cfquery name="checkLos"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  			SELECT num_los FROM tbemp WHERE num_los = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#los#">
				</cfquery>
				<cfif checkLos.RecordCount EQ 0>
					<cfoutput>
						<cflocation url="no_emp.cfm" addtoken="no">
					</cfoutput>
				</cfif>
		</cfif>

		<cfif (#mode# is 'emp' and #Cookie.empTypeId# is 'MGR')>
			<cfif not(#Cookie.los# is #los#)>
				<cfquery name="checkEmployees"
					 datasource="#Request.DSN#"
					 username="#Request.username#"
					 password="#Request.password#">
			  			SELECT dept_id,shift_id FROM tbemp WHERE num_los =
			  			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#los#">
				</cfquery>

				<cfif not(#Cookie.deptId# is #checkEmployees.dept_id#) or not(#Cookie.shiftId# is #checkEmployees.shift_id#)>
					<cflocation url="../private/no_access.cfm" addtoken="no">
				</cfif>
			</cfif>
		</cfif>

		<cfif IsDefined("Form.add")>
			<!-- Add Employee -->	
			<cfquery name="addEmp"
					 datasource="#Request.DSN#"
					 username="#Request.username#"
					 password="#Request.password#">
						  INSERT INTO tbemp
				   			VALUES (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.num_los#">,<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.dept_id#">,<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.shift_id#">,<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.emp_type_id#">,<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.first_name#">,<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.last_name#">,<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.num_vac_days#">,<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.email#">,<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.password#">)
			</cfquery>
			<cfoutput>
        		<cflocation url="index.cfm" addtoken="no">
     		</cfoutput>
		</cfif>
		
		<cfif IsDefined("Form.update")>
			<cfquery name="currCred"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  			SELECT email,password FROM tbemp WHERE num_los = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Cookie.los#">
				</cfquery>

			<cfif (#mode# is 'emp')>
				<cfif (#Cookie.empTypeId# is 'MGR' or (#Cookie.empTypeId# is 'HR' and #Cookie.los# is #los#))>
					<!-- Managers can only update the fields for 
					another employee that they can for themselves. -->
					<cfquery name="updateEmp"
				          datasource="#Request.DSN#"
				          username="#Request.username#"
				          password="#Request.password#">
							UPDATE tbemp
								SET 						
									first_name = 
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.first_name#">,
									last_name = 
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.last_name#">,
									email = 
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.email#">,
									password = 
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.password#">
								WHERE 
									num_los = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#los#">
					</cfquery>

					<cfoutput>					
						<cflocation url="emp_prof.cfm?los=#los#" addtoken="no">
	     			</cfoutput>

				<cfelse>
					<!-- HR Employee can update all fields for an employee that isn't themselves -->
				   	<cfquery name="updateEmpHR"
				          datasource="#Request.DSN#"
				          username="#Request.username#"
				          password="#Request.password#">
							UPDATE tbemp
								SET 
									dept_id = 
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.dept_id#">,
									shift_id = 
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.shift_id#">,
									emp_type_id = 
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.emp_type_id#">,
									first_name = 
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.first_name#">,
									last_name = 
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.last_name#">,
									num_vac_days = 
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.num_vac_days#">,
									email = 
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.email#">,
									password = 
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.password#">
								WHERE 
									num_los = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#los#">
						</cfquery>
					
						<cfoutput>
							<cflocation url="emp_prof.cfm?los=#los#" addtoken="no">
	     				</cfoutput>

		</cfif>

			<cfelse>
				<!-- Employees can only update basic info fields for themselves. -->
				<cfquery name="currCred"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  			SELECT email,password FROM tbemp WHERE num_los = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Cookie.los#">
				</cfquery>

				<cfquery name="updateMine"
			          datasource="#Request.DSN#"
			          username="#Request.username#"
			          password="#Request.password#">
						UPDATE tbemp
							SET 
								first_name = 
								<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.first_name#">,
								last_name = 
								<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.last_name#">,
								email = 
								<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.email#">,
								password = 
								<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.password#">
							WHERE 
								num_los = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#los#">
				</cfquery>
				<cfoutput>
					<cfif not(#currCred.email# is #Form.email#)>
						<cflocation url="../login/login.cfm?msg=reset" addtoken="no">
					</cfif>
					<cfif not(#currCred.password# is #Form.password#)>
						<cflocation url="../login/login.cfm?msg=reset" addtoken="no">
					<cfelse>
						<cflocation url="index.cfm" addtoken="no">
					</cfif>
     			</cfoutput>
			</cfif>
		<cfelse>
			<!-- Employee -->	
		<cfquery name="showEmp"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  			SELECT * FROM tbemp WHERE num_los =
		  			 <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#los#">
		</cfquery>	
		
			<cfcookie name="emp_dept_id" value="#showEmp.dept_id#">
			<cfcookie name="emp_shift_id" value="#showEmp.shift_id#">
			<cfcookie name="emp_emp_type_id" value="#showEmp.emp_type_id#">
			<cfcookie name="emp_num_vac_days" value="#showEmp.num_vac_days#">
		</cfif>

		<cfif IsDefined("Form.delete")>
			<!-- Delete Employee -->	
			<cfquery name="delEmp"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		 			DELETE FROM tbemp WHERE num_los =
		 			 <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#los#">
			</cfquery>
			<cfoutput>
        		<cflocation url="index.cfm" addtoken="no">
     		</cfoutput>
		</cfif>

		<cfif IsDefined("Form.cancel")>
			<cfif (#Form.mode# is 'emp') and not(#Cookie.los# is #los#)>
				<cfoutput>
        			<cflocation url="emp_prof.cfm?los=#Form.los#" addtoken="no">
     			</cfoutput>
     		<cfelse>
     			<cflocation url="index.cfm" addtoken="no">
			</cfif>
		</cfif>


		<!-- Dept List -->	
		<cfquery name="showDept"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  			SELECT * FROM tbdept
		</cfquery>

		<!-- Shift List -->	
		<cfquery name="showShift"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  			SELECT * FROM tbshift
		</cfquery>

		<!-- Employee Type List -->	
		<cfquery name="showEmpType"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  			SELECT * FROM tbemp_type
		</cfquery>
		
		<!-- Employee Type List -->	
		<cfquery name="shownumVacDays"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  			SELECT DISTINCT num_vac_days FROM tbemp
		</cfquery>
		

		<!-- Main Part of Page -->
		<div class="container">
			<div class="main">
				<cfform action="add_mod_prof.cfm" method="post"  preserveData="yes">
					<div class="float_left">
						<!-- Set up hidden fields for form processing -->
						<cfif (#mode# is 'add')>
          					<cfinput name="mode" type="hidden" value="add"></cfinput>
						<cfelseif (#mode# is 'mine')>
							<cfinput name="mode" type="hidden" value="mine"></cfinput>
						<cfelseif (#mode# is 'emp')>
							<cfinput name="mode" type="hidden" value="emp"></cfinput>
							<cfinput name="los" type="hidden" value="#los#"></cfinput>
        				</cfif>

						<!-- If Add Mode is Selected-->        				
        				<cfif (#mode# is 'add')>
        					<cfinclude template="../includes/check_rights_HR.cfm">
        					<h2>Add an Employee</h2>	
        					<p>LOS#:<cfinput name="num_los" type="text" value="" size="5" maxlength="4" required="yes" validateAt = "onBlur"  message="Please enter a length of service number for this new employee.">
        					</cfinput></p>
        					<p>First Name:<cfinput name="first_name" type="text" size="25" value="" maxlength="50" required="yes" validateAt = "onBlur"  message="Please enter a first name for this new employee."></cfinput></p>

	        				<p>Last Name:<cfinput name="last_name" type="text" value="" size="25" maxlength="50" required="yes" validateAt = "onBlur"  message="Please enter a last name for this new employee."></p>
	        				</cfinput>

	        				<p>Email:<cfinput name="email" type="text" value="" size="25" maxlength="50" required="yes" validate="email" validateAt = "onBlur"  message="Please enter a pharmchain.com email address for this new employee.">
	        				</cfinput></p>

	        				<p>Password#:<cfinput name="password" type="password" value="" size="25" maxlength="20" required="yes" validateAt = "onBlur"  message="Please enter password for this new employee.">
	        				</cfinput></p>
		        				<cfif (#mode# is 'add')>
									<cfinput name="add" type="submit" value="Add"></cfinput>
								<cfelse>
									<cfinput name="update" type="submit" value="Update"></cfinput>
		        						<cfif (#Cookie.empTypeId# is 'HR')>
		        							<cfinput name="delete" type="submit" value="Delete"></cfinput>
		        						</cfif>
	        					</cfif>
	        					<cfinput name="cancel" type="submit" value="Cancel"></cfinput>
        					</div>

        					<div class="float_right">
	    						<p>Dept:<cfselect name="dept_id">
		    						<cfoutput query="showDept"  >
		              					<option value="#dept_id#">#dept#</option>
		         					</cfoutput>
	          					</cfselect></p>
	              				
	              				<p>Shift:<cfselect name="shift_id">
	              					<cfoutput query="showShift">
	                  					<option value="#shift_id#">#shift#</option>
	                  				</cfoutput>
	              				</cfselect></p>
			
	              				<p>Employee Type:
	              					<cfselect name="emp_type_id">
	              					<cfoutput query="showEmpType">
	                  					<option value="#emp_type_id#">#emp_type#</option>
	                  				</cfoutput>
	              				</cfselect></p>
	              				<p>Number of Vacation Days:
	              					<cfselect name="num_vac_days">
	              						<cfoutput query="shownumVacDays">
	                  				<option value="#num_vac_days#">#num_vac_days#</option>
	                  				</cfoutput>
	              				</cfselect></p>
              				</div>

        				<cfelse>

        				<!-- If Mine or Emp Mode is Selected--> 
        				<cfif (#mode# is 'mine')>
        					<h2>Modify Your Profile</h2>
        				<cfelse>
        					<h2>Modify Employee's Profile</h2>
        				</cfif>

        				<cfoutput query="showEmp">	

	        				<p>First Name:<cfinput name="first_name" type="text" size="25" value="#first_name#" maxlength="50" required="yes" validateAt = "onBlur"  message="Please enter a first name for this new employee.">
	        				</cfinput></p>

	        				<p>Last Name:<cfinput name="last_name" type="text" value="#last_name#" size="25" maxlength="50" required="yes" validateAt = "onBlur"  message="Please enter a last name for this new employee.">
	        				</cfinput></p>

	        				<p>Email:<cfinput name="email" type="text" value="#email#" size="25" maxlength="50" required="yes" validate="email" validateAt = "onBlur"  message="Please enter a pharmchain.com email address for this new employee.">
	        				</cfinput></p>

	        				<p>Password:<cfinput name="password" type="password" value="#password#" size="25" maxlength="20" required="yes" validateAt = "onBlur"  message="Please enter password for this new employee.">
	        				</cfinput></p>

	        				<cfif (#mode# is 'add')>
								<cfinput name="add" type="submit" value="Add"></cfinput>
							<cfelse>
								<cfinput name="update" type="submit" value="Update"></cfinput>
		        					<cfif (#Cookie.empTypeId# is 'HR')>
		        						<cfif not (#Cookie.los# is '#los#')>
		        						<cfinput name="delete" type="submit" value="Delete"></cfinput>
		        					</cfif>
		        					</cfif>
	        				</cfif>

	        				<cfinput name="cancel" type="submit" value="Cancel"></cfinput>
						</cfoutput>

			        		<!-- Only HR can edit this as long as they aren't editing themself-->
			        		<cfif not (#Cookie.los# is '#los#')>
		        				<cfif (#mode# is 'emp' AND #Cookie.empTypeId# is 'HR')>
		        				</div>	

        							<div class="float_right">
				    					<p>Dept:
				    						<cfselect name="dept_id" >
				    							<cfoutput query="showDept">
				    								<cfif (#dept_id# is #Cookie.emp_dept_id#)>
					              						<option value="#dept_id#" selected="selected">#dept#</option>
					              					<cfelse>
					              						<option value="#dept_id#">#dept#</option>
					              					</cfif>
					              				</cfoutput>
				          					</cfselect>
				          				</p>
		              				
			              				<p>Shift:
			              					<cfselect name="shift_id" >
				    							<cfoutput query="showShift">
				    								<cfif (#shift_id# is #Cookie.emp_shift_id#)>
					              						<option value="#shift_id#" selected="selected">#shift#</option>
					              					<cfelse>
					              						<option value="#shift_id#">#shift#</option>
					              					</cfif>
					              				</cfoutput>
				          					</cfselect>
				
			              				<p>Employee Type
			              					<cfselect name="emp_type_id" >
				    							<cfoutput query="showEmpType">
				    								<cfif (#emp_type_id# is #Cookie.emp_emp_type_id#)>
					              						<option value="#emp_type_id#" selected="selected">#emp_type#</option>
					              					<cfelse>
					              						<option value="#emp_type_id#">#emp_type#</option>
					              					</cfif>
					              				</cfoutput>
				          					</cfselect></p>

			              				<p>Number of Vacation Days:
			              					<cfselect name="num_vac_days" >
				    							<cfoutput query="shownumVacDays">
				    								<cfif (#num_vac_days# is #Cookie.emp_num_vac_days#)>
					              						<option value="#num_vac_days#" selected="selected">#num_vac_days#</option>
					              					<cfelse>
					              						<option value="#num_vac_days#">#num_vac_days#</option>
					              					</cfif>
					              				</cfoutput>
				          					</cfselect>
			              				</p>
			              			</div>
		        				</cfif>
		        			</cfif>
        			

        			</cfif>
        				
					</div>
					
				</cfform>
			</div>
		</div>

		<cfif (#Cookie.empTypeId# is "HR" or #Cookie.empTypeId# is "MGR" )>
		 	<cfinclude template="../includes/sidebar.cfm">
		 </cfif>

		<cfinclude template="../includes/footer.cfm">
	</body>
</html>
