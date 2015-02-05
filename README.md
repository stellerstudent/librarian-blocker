# Librarian Blocker
Very simple application for OSX that checks to see if vnc connection is established and do stuff when one is detected, very useful for fending off nosy librarians.

### What it will do...
The app will constantly monitor the connections on port 5900 (VNC) and if it notices that someone or something has established a connection, it executes an applescript module.

### Usage
###### GUI
**NOTE** 
- If using a shared computer and you aren't permitted to run the file, do the following: Instead of clicking the file(s), drag it into the terminal window and press enter

1. Click (or drag to terminal) LibraryBlocker.command
2. Select a module
3. Now the shell script will run in the background
4. To kill it, click (or drag to terminal) KillBlocker.command and it will read the pid from /tmp/lbpid

###### Command Line
- To launch:
```
./conncheck.sh <module> &
```
- To kill it:
```
kill $(cat /tmp/lbpid)
```