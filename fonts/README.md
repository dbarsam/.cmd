cmdfonts
========

Here's a registry hack that will demonstrate how to add fonts to the cmd window:

    The fonts must meet the following criteria to be available in a command session window: 
        The font must be a fixed-pitch font.
        The font cannot be an italic font.
        The font cannot have a negative A or C space.
        If it is a TrueType font, it must be FF_MODERN.
        If it is not a TrueType font, it must be OEM_CHARSET.

    Additional criteria for Asian installations: 
        If it is not a TrueType font, the face name must be "Terminal."
        If it is an Asian TrueType font, it must also be an Asian character set.

    In Windows 2000, the installation of Console Fonts is no longer automated. This was done to give the console window greater stability in multilanguage environments. An unsupported work around is available by adding the following font specific entry: 
        Add a String Value
        Name=00
        Data= "Font Name" (without "") 

    Into the following registry: 
        HKLM\Software\Microsoft\WindowsNT\CurrentVersion\Console\TrueTypeFont 

    The name needs to be incrimented with "0" for each additional font. The Data entry needs to match the font's entry in the following registry location: 
        HKLM\Software\Microsoft\WindowsNT\CurrentVersion\Fonts 

Source: http://support.microsoft.com/default.aspx?scid=kb;EN-US;Q247815
