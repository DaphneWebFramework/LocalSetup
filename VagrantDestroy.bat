@ECHO OFF

SETLOCAL
SET /P answer="Are you sure (y/N)? "
IF /I "%answer%" NEQ "Y" GOTO End

ECHO Please wait...
vagrant destroy --force
vagrant box remove ubuntu/jammy64
RMDIR /Q /S .vagrant

:End
ENDLOCAL
