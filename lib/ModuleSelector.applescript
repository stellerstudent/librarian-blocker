set modulelist to {"quitall.applescript", "hideall.applescript", "cut-wifi.applescript"}
set module to {choose from list modulelist with prompt "Choose module to run on connection."}
return module
