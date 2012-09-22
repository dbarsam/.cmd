profile.reg
===========

Here's a registry hack that will automatically run the profile.cmd file (or whatever you want) when you get a command prompt. Note that there is a similar article out there advocating the use of the "/k" option to run the file. I don't use that; instead, I use the "AutoRun" registry key so regardless of how you access the command prompt - even if you do a Start -> Run and type "cmd" and click OK - you'll always get a custom command prompt. (It'll even fix it so if you have the Command Prompt Here power toy installed, that command prompt is a custom command prompt, too.)

    1. Modify the profile.cmd file to run the custom environment.
    2. Modify the registry using profile.reg.
    3. Enjoy!

Source: http://www.paraesthesia.com/archive/2004/06/28/net-command-prompt-here-and-everywhere-else.aspx



