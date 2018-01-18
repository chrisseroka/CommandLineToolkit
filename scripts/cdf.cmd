@echo off
powershell %~dp0\cdf\cdf.ps1 %1
call %~dp0\cdf\cdf_tmp.bat
