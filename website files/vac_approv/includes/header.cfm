<!--- ########## Heading ########## --->
<cfif NOT IsDefined ("Cookie.loggedIn")>
   <cflocation url="../login/login.cfm" addtoken="no">
<cfelseif Cookie.loggedIn IS "No">
   <cflocation url="../login/login.cfm" addtoken="no">
</cfif>

<div class="header">
<div>
  <cfoutput>
    <p class="fl"> Setting up your vacation time in no time! </br>
    #Cookie.firstName# #Cookie.lastName# logged in
    </p>
 </cfoutput>
    <h1>
      <cfif (Cookie.loggedIn is "YES")>
            <a href="index.cfm" class="none">
      <cfelse>
            <a href="login.cfm" class="none">
      </cfif>
             Pharmacy Chain Vacation Database</a>
    </h1>
  
</div>
	<div class="nav">
    <ul id="nav">
     
        <cfif (Cookie.loggedIn is "YES")>
            <li><a href="../private/index.cfm">My Info</a></li>
            
    <cfif (Cookie.empTypeId is "HR" or Cookie.empTypeId is "MGR" )>
      <li><a href="../private/search.cfm">Search Employees</a></li>
    </cfif>
    
        <cfif (Cookie.empTypeId is "HR")>
          <li><a href="../private/add_mod_prof.cfm?mode=add">Add Employee</a></li>
          <li><a href="../private/mod_days.cfm">Change Days Off</a></li>
          <li><a href="../private/mod_quota.cfm">Change Dept.Quota</a></li>         
               
        </cfif>
        <li><a href="../login/logout.cfm" addtoken="no">Logout</a></li>
      </ul>
 </cfif>
    </div>
</div>