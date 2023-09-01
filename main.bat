@echo off
:init
title init
chcp 65001 >nul
setlocal EnableDelayedExpansion
set r=set var=999
set level=!localappdata!\sayonline\apps\Catch-the-falling-ball

call :locale
title !locale0!
call :load
call :menu
exit

:locale
for /r %%i in (locale\*.txt) do (
    set /a locales+=1
    set locales!locales!=%%~ni
)
if not exist lang.txt call :selectlang
set /p lang=<lang.txt
if not exist "locale\!lang!.txt" call :selectlang

set locale=0
for /f "delims=" %%i in (locale\!lang!.txt) do (
    set locale!locale!=%%i
    set /a locale+=1
)
set /a locale-=1
goto :eof

:selectlang
!r!
cls
echo Select language
echo.
for /l %%i in (1,1,!locales!) do (
    echo %%i. !locales%%i!
)
echo.
set /p var=Type some number : 
if not "!locales%var%!"=="" if exist locale\!locales%var%!.txt (
    set lang=!locales%var%!
    echo !lang!>lang.txt
    goto :eof
)
goto selectlang

:load
set arr1=0
call :rmquote !level! level
if not exist "!level!\level.txt" (
    cls
    set /p level=!locale11! : 
    goto load
)
for /f %%i in (!level!\level.txt) do (
    set /a arr+=1
    set arr!arr!=%%i
)
goto :eof

:rmquote
set %2=%~1
goto :eof

:menu
!r!
cls
echo !locale0!
echo.
for /l %%i in (1,1,7) do (
    echo %%i. !locale%%i!: !arr%%i!
)
echo.
echo 8. !locale10!
echo 9. !locale12!
echo 0. !locale8!
set /p var=!locale9! : 
if "!var!"=="8" (
    call :restoredefaults
    goto menu
)
if "!var!"=="9" (
    call :about
    goto menu
)
if "!var!"=="0" (
    call :save
    goto menu
)
if /i !var! leq 7 call :edit
goto menu

:restoredefaults
set arr1=100000
set arr2=200
set arr3=150
set arr4=20
set arr5=10
set arr6=0,3
set arr7=0,1
goto :eof

:edit
cls
echo !locale0!
echo.
set /a tmp=!var!-1
for /l %%i in (1,1,!tmp!) do (
    echo %%i. !locale%%i!: !arr%%i!
)
set /p arr!var!=!var!. !locale%var%!: 
goto :eof

:save
del /q "!level!\level.txt"
for /l %%i in (1,1,7) do (
    1>>"!level!\level.txt" echo !arr%%i!
)
exit
goto :eof

:about
!r!
cls
echo !locale12!
echo.
echo !locale13!
echo !locale14!: SashaTalk
echo !locale15!: M.A.Production
echo.
echo 1. !locale16!
echo 2. !locale17!
echo 3. !locale18!
echo 0. !locale19!
set /p var=!locale9! : 
if "!var!"=="1" start https://github.com/m-a-prod/Catch-the-falling-ball
if "!var!"=="2" start https://github.com/SashaTalk/settings4ctfb
if "!var!"=="3" start https://sashatalk.github.io/
if "!var!"=="0" goto :eof
goto about
