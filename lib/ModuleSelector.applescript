#!/usr/bin/osascript
set workingdir to POSIX path of ((path to me as text) & "::")
set modulelist to paragraphs of (do shell script "ls " & workingdir & " | grep -v 'lb.conf' | grep -v 'ModuleSelector.applescript' | grep -v 'template.applescript'")
set module to {choose from list modulelist default items {"hideall.applescript"} with title "Module-Select" with prompt "Choose module to run on connection."}
return module
