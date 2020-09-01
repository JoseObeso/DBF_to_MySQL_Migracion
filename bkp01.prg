lcEx = '"C:\Archivos de programa\mysql\MySQL Server 5.5\bin\mysqldump.exe" "-uroot" "-p123456" "MyDB" "-rd:\test.sql"'
oShell = createobject("WScript.Shell")
oShell.Run(lcEx,0,.t.)