:: Programmed by hXR16F
:: hXR16F.ar@gmail.com

@echo off
mode 90,25 & color 07 & setlocal EnableDelayedExpansion
if not "%1" EQU "" goto %1

for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
	set "DEL=%%a"
)

if exist "PortScanner.chr" (
		set line=1
		for /F "tokens=*" %%n in ('type PortScanner.chr') do (
			if !line! EQU 1 set "chr=%%n"
			set /A line+=1
		)
	) else (
		set "chr=[+]"
	)
)

set timer0=1
set timer1=1
set host=localhost
set timeout=250
echo | set /P "%random%=!chr! Hostname: " & set /P "host="
echo | set /P "%random%=!chr! Timeout: " & set /P "timeout="

start /B %~nx0 2

:1
	title hXR16F's Port Scanner : !host! : !timeout!
	for /F "tokens=1,2* delims=	" %%i in ('type PortScanner.lst') do (
		if !timer0! EQU 1 (
			set timer0=0
			PortScanner.dll --count 1 --timeout !timeout! --port %%i !host! > nul && (
				call :colorText 0A " %%i - %%j"
			) || (
				call :colorText 08 " %%i - %%j"
			)
		) else (
			set /A timer0+=1
		)
	)
	
	for /L %%n in (0,0,1) do pause > nul

:2
	title hXR16F's Port Scanner : !host! : !timeout!
	for /F "tokens=1,2* delims=	" %%i in ('type PortScanner.lst') do (
		if !timer1! EQU 2 (
			set timer1=1
			PortScanner.dll --count 1 --timeout !timeout! --port %%i !host! > nul && (
				call :colorText 0A " %%i - %%j"
			) || (
				call :colorText 08 " %%i - %%j"
			)
		) else (
			set /A timer1+=1
		)
	)
	
	for /L %%n in (0,0,1) do pause > nul

:colorText
	echo off
	<nul set /p ".=%DEL%" > "%~2"
	findstr /v /a:%1 /R "^$" "%~2" nul
	del "%~2" > nul 2>&1
	goto :eof
	