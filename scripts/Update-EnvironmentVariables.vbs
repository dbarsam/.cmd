' ===================================================================
'    Updates the Environment Variables within the Current Session
' ===================================================================
' Source: http://stackoverflow.com/questions/171588/is-there-a-command-to-refresh-environment-variables-from-the-command-prompt-in-w
' ===================================================================
Set oShell = WScript.CreateObject("WScript.Shell")
' ============
' System Variables and Path
' ============
set oEnv=oShell.Environment("System")
for each sitem in oEnv 
    Wscript.echo "SET " & sitem
next
spath = oEnv("PATH")

' ============
' User Variables and Path
' ============
set oEnv=oShell.Environment("User")
for each sitem in oEnv 
    Wscript.echo "SET " & sitem
next
upath = oEnv("PATH")

' ============
' System and User Mergers
' ============
Wscript.echo "SET PATH=" & spath & ";" & upath

