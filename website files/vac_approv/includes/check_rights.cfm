<cfif not(Cookie.empTypeId is "HR" or Cookie.empTypeId is "MGR" )>
	<cflocation url="../private/no_access.cfm" addtoken="no">
</cfif>