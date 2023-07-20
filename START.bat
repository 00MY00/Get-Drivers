@echo off
chcp 65001
mode con cols=60 lines=30
title Verification integraliter
set back=%~dp0
title Installation Git-Drivers

runas /user:Administrator ".\Install.bat"
if %errorlevel% == 0 (echo Execution réusit !) esle (echo Erreur ! & pause & exit)
powershell -ExecutionPolicy Bypass -Command ".\get-drivers.ps1"
if %errorlevel% == 0 (echo Execution réusit ! & del START.bat) esle (echo Erreur ! & pause & exit)


