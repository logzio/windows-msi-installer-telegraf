@echo off

setlocal enabledelayedexpansion
set INTEXTFILE=telegraf.conf
set OUTTEXTFILE=telegraf_tmp.conf
set SEARCHTOKEN={param1}
set REPLACETOKEN=%1
set SEARCHURL={param2}
set REPLACEURL=%2
set OUTPUTLINE=

for /f "tokens=1,* delims=¶" %%A in ( '"findstr /n ^^ %INTEXTFILE%"') do (
   SET string=%%A
   for /f "delims=: tokens=1,*" %%a in ("!string!") do set "string=%%b"
   if  "!string!" == "" (
       echo.>>%OUTTEXTFILE%
   ) else (
   	  if  "!string!"=="!string:{param1}=!" (
		CALL SET "modified=!string:%SEARCHURL%=%REPLACEURL%!"
	    @echo !modified! >> %OUTTEXTFILE%
      ) else (
	   	CALL SET "modified=!string:%SEARCHTOKEN%=%REPLACETOKEN%!"
		@echo !modified! >> %OUTTEXTFILE%
      )

    )
)
del %INTEXTFILE%
rename %OUTTEXTFILE% %INTEXTFILE%