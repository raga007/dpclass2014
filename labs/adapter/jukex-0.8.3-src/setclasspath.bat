@echo off
echo.

FOR /F "usebackq delims==" %%i IN (`cd`) DO set JUKEXBASE=%%i

echo JukeX Magic Classpath Wizard
echo Your JukeX base directory is %JUKEXBASE%

echo.
echo Setting up your classpath...

if exist lib goto libpresent

:liberror

echo.
echo No lib directory found.  Please refer to the README for instructions
echo on obtaining the correct libraries

goto exit

:libpresent

if exist __tmp.bat del __tmp.bat
FOR /F "usebackq delims==" %%i IN (`dir /b lib\*.jar`) DO echo set CLASSPATH=%%JUKEXBASE%%\lib\%%i;%%CLASSPATH%%>> __tmp.bat
call __tmp.bat
del __tmp.bat

set CLASSPATH=%CLASSPATH%;%JUKEXBASE%\build\classes

echo ...done!

:exit
