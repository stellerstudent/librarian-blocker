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
	set decoybrowser to getconfarg("BROWSER", configfile)
	set link to getconfarg("URL", configfile)
	if initialize then
		set chooseargs to button returned of (display dialog "Currently application " & decoybrowser & " will open " & link & "
Would you like to use this, or select a different browser/URL?


***NOTE*** SET THE DECOY BROWSER TO A BROWSER THAT YOU WILL NOT BE USING!" with title "Use default decoy browser and URL?" buttons {"Open configuration file", "Use current options"})
		if chooseargs is equal to "Open configuration file" then
			do shell script "open -e -W " & configfile
		end if
		set decoybrowser to getconfarg("BROWSER", configfile)
		set link to getconfarg("URL", configfile)
		delay 0.75
		do shell script "open -a " & decoybrowser & " " & link
		delay 0.75
		tell application "System Events"
			set visible of process decoybrowser to false
		end tell
	else if go then
		do shell script "osascript " & workingdir & "hideall.applescript go"
		tell application "System Events"
			set visible of process decoybrowser to true
		end tell
	end if
end run