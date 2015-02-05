set modulelist to {"hideall.applescript", "decoy.applescript", "cut-wifi.applescript", "quitall.applescript"}
set module to {choose from list modulelist default items {"hideall.applescript"} with title "Module-Select" with prompt "Choose module to run on connection."}
return module
