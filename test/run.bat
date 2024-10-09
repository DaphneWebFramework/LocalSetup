@ECHO OFF
REM Usage: run.bat [filter]

SET PHPDIR=C:\xampp\php
SET XDEBUG=%PHPDIR%\ext\php_xdebug.dll
SET CONFIG=phpunit.coverage.xml

IF "%1"=="" (
    SET FILTER_ARG=
) ELSE (
    SET FILTER_ARG=--filter %1
)

CLS
%PHPDIR%\php.exe ^
-d zend_extension=%XDEBUG% ^
-d xdebug.mode=coverage,debug ^
-d xdebug.idekey=VSCODE ^
-d xdebug.start_with_request=yes ^
phpunit.phar --configuration %CONFIG% %FILTER_ARG%
