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
	if go then
		tell application "System Events" to set quitapps to name of every application process whose visible is true and name is not "Finder"
		repeat with closeall in quitapps
			quit application closeall
		end repeat
	end if
end run