set iface to "en1"
do shell script "networksetup -setairportpower " & iface & " off"
