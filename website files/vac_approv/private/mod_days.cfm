<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="en">
	<head>
		<title>Change Day Types</title>
		<link rel="stylesheet" type="text/css" 
      		href="../css/general.css" />
	</head>
	<body>
		<cfinclude template="../includes/header.cfm">
		<cfinclude template="../includes/check_rights_HR.cfm">
		<cfparam name="msg" default="no" type="string">
		
		<!-- Employee Type List -->	
		<cfquery name="showDayType"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  			SELECT * FROM tbday_type
		</cfquery>

		<cfquery name="showMinDay"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  			SELECT tbday_req.day_type_id
					FROM tbday_req
					WHERE  tbday_req.day_req in 
					(SELECT Min(tbday_req.day_req)
					 AS MinOfday_req
					FROM tbday_req) 
		</cfquery>

		<cfif IsDefined("Form.update")>
		
			<cfquery name="updateDay"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  			UPDATE tbday_req
					SET 						
						day_type_id = 
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.day_type_id#">
					WHERE 
						day_req = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.cal#">
				</cfquery>
				<cfoutput>
						<cflocation url="mod_days.cfm?msg=yes" addtoken="no">
					</cfoutput>
				
		</cfif>
		<!-- Main Part of Page -->
		<div class="container">
			<div class="main">
				<div class="float_left">
					 <cfif (#msg# is 'yes')>
          				<p class="errorMsg">Day updated.</p>
        			</cfif>

					<h3>Change Day Types</h3>
					<cfform action="mod_days.cfm" method="post">
						<p>Choose Day:
							<cfinput type="dateField" name="cal" label="Day:" width="100" value="01/01/2015" mask="DD-MMM-YYYY">
						</p>
					</br>
						<p>Day Type:
	         				<cfselect name="day_type_id">
	              				<cfoutput query="showDayType">
	                  				<option value="#day_type_id#">#day_type#</option>
	                  			</cfoutput>
	              			</cfselect>
						</p>
						<p>
	              			<cfinput name="update" type="submit" value="Update"></cfinput>
	              		</p>
	              		
					</cfform>
	          	</div>
	          	<div class="float_right">
	          		<p>There may be a time when a holiday is added or removed or weekend days become work days. It would be appropriate to edit the day type of that day.
					</p>
	          	</div>
			</div>
		</div>

		 	<cfinclude template="../includes/sidebar.cfm">

			<cfinclude template="../includes/footer.cfm">
	</body>
</html>
