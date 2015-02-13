on getconfarg(param, configfile)
	set value to do shell script "grep -v '^#' " & configfile & " | grep " & param & "= | cut -d'=' -f 2"
	return value
end getconfarg
on run argv
	set initialize to false
	set go to false
	if (count of argv) > 0 then
		if item 1 of argv is equal to "initialize" then
			set initialize to true
		else if item 1 of argv is equal to "go" then
			set go to true
		end if
	end if
	set workingdir to POSIX path of ((path to me as text) & "::")
	set configfile to workingdir & "lb.conf"
	
	#####################################################
	
	if go then
		set iface to getconfarg("WIRELESS_INTERFACE", configfile)
		do shell script "networksetup -setairportpower " & iface & " off"
	end if
end run