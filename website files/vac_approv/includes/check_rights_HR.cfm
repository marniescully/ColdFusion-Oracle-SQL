<cfif not(Cookie.empTypeId is "HR")>
	<cflocation url="../private/no_access.cfm" addtoken="no">
</cfif>