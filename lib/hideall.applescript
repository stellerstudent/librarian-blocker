tell application "Finder"
	set visible of every process whose visible is true and name is not "Finder" to false
	close every window
end tell