<!--- ########## Oracle Variables ########## --->

<cfparam name="Request.DSN" default="cscie60">
<cfparam name="Request.username" default="mscully">
<cfparam name="Request.password" default="3203">

<!--- ########## Application Variables ########## --->

<cfapplication name="Pharmacy Chain Vacation Database"
               clientmanagement="no"
               sessionmanagement="yes"
               loginStorage="Session"
               setclientcookies="yes"
               setdomaincookies="no"
               sessiontimeout="#CreateTimeSpan(0,0,1,0)#"
               applicationtimeout="#CreateTimeSpan(0,0,2,0)#">

<!--- ########## Login Test ########## --->




