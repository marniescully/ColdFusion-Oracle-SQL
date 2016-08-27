<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Pharmacy Chain Vacation Database Login Page</title>
    <link rel="stylesheet" type="text/css" 
          href="../css/general.css" />
  </head>

  <body>
    <cfinclude template="header.cfm">

    <cfparam name="Form.userLogin" default="  " type="string">
    <cfparam name="Form.userPassword" default="   " type="string">
    <cfparam name="bad" default="" type="string">
    <cfparam name="msg" default="" type="string">

    <cfif IsDefined ("Form.login")>

    <!-- ### Action Code Starts Here -->

        <cfquery name="isValidLogin"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          select num_los,dept_id,shift_id,emp_type_id,first_name,last_name,num_vac_days
             from tbemp
			 where email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.userLogin#">
             and password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.userPassword#">
        </cfquery>

        <cfif isValidLogin.RecordCount IS 0>
           <cflocation url="login.cfm?bad=true" addtoken="no">
        <cfelse>
          <cfcookie name="loggedIn" value="YES">
          <cfcookie name="los" value="#isValidLogin.num_los#">
          <cfcookie name="deptId" value="#isValidLogin.dept_id#">
          <cfcookie name="shiftId" value="#isValidLogin.shift_id#">
          <cfcookie name="empTypeId" value="#isValidLogin.emp_type_id#">
          <cfcookie name="firstName" value="#isValidLogin.first_name#">
          <cfcookie name="lastName" value="#isValidLogin.last_name#">
          <cfcookie name="numVacDays" value="#isValidLogin.num_vac_days#">

          <cflocation url="../private/index.cfm" addtoken="no">
        </cfif>

    <cfelse>

    <!-- ### Form Code Starts Here -->
<div class="container">
    <div class="main2">
      <div class="float_left">
        <cfif (#bad# is 'true')>
          <p class="errorMsg">There was not a match for that email address and password combination. Please try again. </p>
        </cfif>
        <cfif (#msg# is 'reset')>
          <p class="errorMsg">You were logged out because you changed your email or password. </p>
        </cfif>

          <form action="login.cfm" method="post">
            <table>
			       <tr>
              <th colspan="2" class="highlight">Log In is Required</th>
               </tr>
             <tr>
              <td>Email:</td>
              <td>
               <input type="text" name="userLogin" /><br />
               <input type="hidden" name="userLogin_required" value="Please enter your EMAIL." />
              </td>
             </tr>
             <tr>
              <td>Password:</td>
              <td>
               <input type="password" name="userPassword" /><br />
               <input type="hidden" name="userPassword_required" value="Please enter your PASSWORD." />
              </td>
             </tr>
             <tr>
              <td>&nbsp;</td>
              <td>
               <input type="submit" name="login" value="Login" />
              </td>
            </tr>
           </table>
          </form>
        </div>
          <div class="float_right">
            <p >Welcome to your vacation time management application! All employees have the ability to view and edit their employee profiles and vacation days. Managers have this ability, as well as viewing and managing their employees. Human Resource personnel can view and manage all employee profiles and vacations.</p>
            <p >All employees should be aware that vacation approval is made <em>strictly</em> on the basis of seniority, as well as the number of employees that may be out at one time for your particular department. The number of vacation days you are allowed depends on your length of service. If you have any questions feel free to contact Human Resources or your Function Manager. </p>
          </div>
      </div>

     
  
</div>
    </cfif>  
    <!--- ### cfif IsDefined ("Form.login") --->
    


    <cfinclude template = "../includes/footer.cfm">

    </body>
</html>

