@echo off
rem License key is PTS_PJF5G4DAZ5R3

set msgcount=0
set license_attempts=0

if not exist pts_configversion3.txt (
  cls
  color 0f
  title Configuring - Protectish Total Security
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo Thank you for downloading Protectish Total Security!
  echo It was detected that you either:
  echo - have outdated configuration files or
  echo - installed Protectish Total Security for the first time.
  echo Please wait until we finish configuring your Protectish.

  if not exist pts_configversion3.txt (
    aaaa > pts_configversion3.txt
    echo Protectish Total Security settings - DO NOT CHANGE THIS FILE > pts_configversion3.txt
    echo Version Of Configuration Files 3 >> pts_configversion3.txt
  )
  if not exist pts_lkused1.txt (
    aaaa > pts_lkused1.txt
    echo Protectish Total Security settings - DO NOT CHANGE THIS FILE > pts_lkused1.txt
    echo License Key not used >> pts_lkused1.txt
  )
  if not exist pts_autoaction2.txt (
    aaaa > pts_autoaction2.txt
    echo Protectish Total Security settings - DO NOT CHANGE THIS FILE > pts_autoaction2.txt
    echo Automatic Action >> pts_autoaction2.txt
    echo None >> pts_autoaction2.txt
  ) 
  if not exist pts_gendetect1.txt (
    aaaa > pts_gendetect1.txt
    echo Protectish Total Security settings - DO NOT CHANGE THIS FILE > pts_gendetect1.txt
    echo Piracy not detected >> pts_gendetect1.txt  
  )
  cls
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo Thank you for downloading Protectish Total Security!
  echo It was detected that you either:
  echo - have outdated configuration files or
  echo - installed Protectish Total Security for the first time.
  echo Please wait until we finish configuring your Protectish.
  echo Configuration complete. You can now continue.
  pause
)

if not exist pts_analytics1.txt (
  set /a msgcount=msgcount+1
)
find /i /c "License Key not used" pts_lkused1.txt >NUL
if %errorlevel% equ 1 goto start

:license_key
  cls
  color 0f
  title License Key - Protectish Total Security
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo It's time to insert your license key!
  echo.
  echo If you don't have a license key, close this window, contact Protectish 
  echo staff and pay 10 CZK to acquire a life-time license key to Protectish 
  echo Total Security.
  echo.
  set /p check_key="If you do, insert it here: "
  if "%check_key%" == "SetAdminModeOn" (
    echo Admin mode activated.
    pause
    goto start
  )
  aaaa > check_license_key.txt
  echo %check_key% > check_license_key.txt
  @CertUtil -hashfile check_license_key.txt MD5 > md5.txt
  for /f "tokens=1*delims=:" %%G in ('findstr /n "^" md5.txt') do if %%G equ 2 set check_key=%%H
  echo %check_key% > check_license_key.txt
  @CertUtil -hashfile check_license_key.txt MD5 > md5.txt
  for /f "tokens=1*delims=:" %%G in ('findstr /n "^" md5.txt') do if %%G equ 2 set check_key=%%H
  echo.%check_key%
  del md5.txt
  del check_license_key.txt
  cls
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo It's time to insert your license key!
  echo.
  echo If you don't have a license key, close this window, contact Protectish 
  echo staff and pay 10 CZK to acquire a life-time license key to Protectish 
  echo Total Security.
  echo.
  if "%check_key%" == "ca 2f a9 74 9b 7c 75 3d c0 cb a9 30 05 2d 13 da" (
    aaaa > pts_lkused1.txt
    echo Protectish Total Security settings - DO NOT CHANGE THIS FILE > pts_lkused1.txt
    echo License Key used >> pts_lkused1.txt
    aaaa > pts_lkinserted1.txt
    echo Protectish Total Security settings - DO NOT CHANGE THIS FILE > pts_lkinserted1.txt
    echo License Key inserted >> pts_lkinserted1.txt
    echo License key accepted. Thank you!
    pause
    goto start
  )
  set /a license_attempts=%license_attempts%+1
  echo This is not a valid license key.
  if "%license_attempts%" == "3" (
    echo You used three unsuccessful attempts.
    echo This may be done due to piracy.
    pause
    goto antipiracy
  )
  pause
  goto license_key
  
  tasklist > tasks.txt
  find /i /c "TJprojMain.exe" %file% > NUL
  if %errorlevel% == 0 (
    set suspicioustask="TJprojMain.exe"
    wmic process where "name='TJprojMain.exe'" get ExecutablePath > tasks.txt
    for /f "tokens=1*delims=:" %%G in ('findstr /n "^" tasks.txt') do if %%G equ 1 set suspiciousfile=%%H
    set suspicioustask=1
  )
  find /i /c "Synaptics.exe" %file% > NUL
  if %errorlevel% == 0 (
    set suspicioustask="Synaptics.exe"
    wmic process where "name='Synaptics.exe'" get ExecutablePath > tasks.txt
    for /f "tokens=1*delims=:" %%G in ('findstr /n "^" tasks.txt') do if %%G equ 1 set suspiciousfile=%%H
    set suspicioustask=1
  )
  del tasks.txt
  if "%suspicioustask%" == "1" goto suspicioustask

:start
  find /i /c "Piracy not detected" pts_gendetect1.txt > NUL
  if %errorlevel% equ 1 goto antipiracy
  find /i /c "License Key used" pts_lkused1.txt > NUL
  if %errorlevel% equ 0 (
    if not exist pts_lkinserted1.txt goto antipiracy
  )
  cls
  color 0f
  title Protectish Total Security
  set dirscan=false
  set ptsdir=%cd%
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo You're fully protected.
  echo You have %msgcount% messages.
  echo.
  echo (FILE) - scan file
  rem echo (DIR) - scan directory
  echo (QUARANTINE) - show quarantine settings
  echo (SETTINGS) - show Protectish settings
  echo (MESSAGES) - show messages
  echo (EXIT) - exit
  echo (QUIT) - exit
  echo (END) - exit
  echo (KONEC) - exit
  echo.
  set /p choice="Enter your choice: "

  if /i "%choice%" == "exit" exit
  if /i "%choice%" == "quit" exit
  if /i "%choice%" == "end" exit
  if /i "%choice%" == "konec" exit
  if /i "%choice%" == "file" goto file
  rem if /i "%choice%" == "dir" goto dir
  if /i "%choice%" == "quarantine" goto quarantine_menu
  if /i "%choice%" == "settings" goto settings
  if /i "%choice%" == "messages" goto messages
  echo.
  echo %choice% is not a valid choice.
  pause
  goto start
  
:suspicioustask
  cls
  color cf
  title Your action is required - Protectish Total Security
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo
  echo A file was found hosting a suspicious task.
  echo.
  echo.
  echo Task: %suspicioustask%
  echo.
  echo Hosting file: %suspiciousfile%
  echo.
  echo.
  echo Do you want to scan the hosting file for malware?
  echo.
  echo (YES) - scan the file
  echo (NO) - don't scan the file
  echo.
  set /p choice="Enter your choice: "
  if /i "%choice%" == "yes" (
    set file=%suspiciousfile%
    goto md5
  )
  if /i "%choice%" == "no" (
    echo.
    echo The file won't be scanned.
    pause
    goto start
  )
  echo.
  echo %choice% is not a valid choice.
  pause
  goto suspicioustask
  
:messages
  cls
  title Protectish Total Security
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo Messages: %msgcount%
  echo.
  rem if not exist pts_analytics1.txt (
  rem  echo Detection information sharing is turned off. Sharing
  rem  echo some detection information helps us to develop our
  rem  echo scans. To turn it on, navigate to Settings - Analytics.
  rem  echo.
  rem )
  echo (BACK) - back
  echo.
  set /p choice="Enter your choice: "

  if /i "%choice%" == "back" goto start
  echo.
  echo %choice% is not a valid choice.
  pause
  goto messages
  
:settings
  cls
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  rem echo (ACTION) - automatic actions done when a specific condition is true
  echo (ANALYTICS) - share information about some detections with Protectish
  echo (BACK) - back
  echo.
  set /p choice="Enter your choice: "
  
  rem if /i "%choice%" == "action" goto settings_action
  if /i "%choice%" == "analytics" goto settings_analytics
  if /i "%choice%" == "back" goto start
  echo.
  echo %choice% is not a valid choice.
  pause
  goto settings
  
:settings_action
  cls
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo Automatic action is an action done when a specific condition is true,
  echo for example "delete a file when detected by MD5 scan".
  echo.
  echo What to do?
  echo.
  echo (DELETE) - delete the file
  echo (QUARANTINE) - quarantine the file
  echo (NONE) - disable automatic action
  echo (BACK) - back
  echo.
  set /p choice="Enter your choice: "

  if /i "%choice%" == "delete" (
    aaaa > pts_autoaction2.txt
    echo Protectish Total Security settings - DO NOT CHANGE THIS FILE > pts_autoaction2.txt
    echo Automatic action >> pts_autoaction2.txt
    echo Delete >> pts_autoaction2.txt
    goto settings_action_when
  )
  if /i "%choice%" == "quarantine" (
    aaaa > pts_autoaction2.txt
    echo Protectish Total Security settings - DO NOT CHANGE THIS FILE > pts_autoaction2.txt
    echo Automatic action >> pts_autoaction2.txt
    echo Quarantine >> pts_autoaction2.txt
    goto settings_action_when
  )
  if /i "%choice%" == "none" (
    echo Protectish Total Security settings - DO NOT CHANGE THIS FILE > pts_autoaction2.txt
    echo Automatic action >> pts_autoaction2.txt
    echo None >> pts_autoaction2.txt
    echo Successfully setted.
    pause
    goto settings_action
  )
  if /i "%choice%" == "back" goto settings
  echo.
  echo %choice% is not a valid choice.
  pause
  goto settings_action

:settings_action_when
  cls
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo When to do?
  echo.
  echo (MD5) - when detected by MD5 scan
  echo (BEHAVIOR) - when detected by behavior scan
  echo (ALL) - when detected by any scan
  echo.
  set /p choice="Enter your choice: "

  if /i "%choice%" == "md5" (
    echo MD5 >> pts_autoaction2.txt
    echo Successfully setted.
    pause
    goto settings_action
  )
  if /i "%choice%" == "behavior" (
    echo Behavior >> pts_autoaction2.txt
    echo Successfully setted.
    pause
    goto settings_action
  )
  if /i "%choice%" == "all" (
    echo All >> pts_autoaction2.txt
    echo Successfully setted.
    pause
    goto settings_action
  )
  echo.
  echo %choice% is not a valid choice.
  pause
  goto settings_action_when
  
:settings_analytics
  cls
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo Notice: Detection information sharing uses your email address and
  echo SMTP server address. Blat software is needed.
  echo.
  echo (ON) - turn detection information sharing on
  echo (OFF) - turn detection information sharing off
  echo (BACK) - back
  echo.
  set /p choice="Enter your choice: "

  if /i "%choice%" == "on" goto settings_analytics_on
  if /i "%choice%" == "off" (
    del pts_analytics1.txt
    set /a msgcount=msgcount+1
    set msg_noanalytics=1
    echo Detection information sharing was turned off.
    pause
    goto settings_analytics
  )  
  if /i "%choice%" == "back" goto settings
  echo.
  echo %choice% is not a valid choice.
  pause
  goto settings_analytics  
  
:settings_analytics_on
  cls
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo To turn on detection information sharing, please insert your email address
  echo to send emails from, and your website's SMTP server address.
  echo.
  set /p email="Email address: "
  set /p smtp="SMTP server address: "
  echo Protectish Total Security settings - DO NOT CHANGE THIS FILE > pts_analytics1.txt
  echo Analytics On >> pts_analytics1.txt
  echo %email% >> pts_analytics1.txt
  echo %smtp% >> pts_analytics1.txt
  set msg_noanalytics=0
  set /a msgcount=msgcount-1
  echo Detection information sharing was turned on.
  pause
  goto settings_analytics

:quarantine_menu
  cls
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  cd %ptsdir%
  if not exist quarant\ mkdir quarant
  dir quarant\
  echo.
  echo (DEL) - delete all files
  echo (BACK) - back
  echo.
  set /p choice="Enter your choice: "

  if /i "%choice%" == "del" (
    dir /A /B "quarant\" | findstr /R ".">NUL && goto quarantine_del
    echo Quarantine is already empty.
    pause
    goto quarantine_menu
  )
  if /i "%choice%" == "back" goto start
  echo.
  echo %choice% is not a valid choice.
  pause
  goto quarantine_menu

:quarantine_del
  echo.
  set /p choice="Are you sure? (Y/N): "
  if /i "%choice%" == "y" (
    del quarant\
    mkdir quarant\
    echo Files were deleted.
    pause
    goto quarantine_menu
  )
  if /i "%choice%" == "n" (
    goto quarantine_menu
  )
  echo.
  echo %choice% is not a valid choice.
  pause
  goto quarantine_menu
  
:antipiracy
  title BEING A CRIMINAL IS NO GOOD
  aaaa > pts_gendetect1.txt
  echo Protectish Total Security settings - DO NOT CHANGE THIS FILE > pts_gendetect1.txt
  echo Piracy detected >> pts_gendetect1.txt 
  cls
  color cf
  echo.
  echo WAIT A MINUTE...
  echo.
  echo :(
  echo.
  echo PIRACY IS A CRIME.
  echo.
  echo Software piracy was detected.
  echo Copying software without permission is illegal and the consequences
  echo can result in a fine or even imprisoning. If you are not the author
  echo of this pirated copy of Protectish Total Security, report this copy
  echo to Protectish.
  echo.
  echo If you think this is an error, ask Protectish support.
  echo.
  echo CLOSE THE PROGRAM OR PRESS ANY KEY TO CLOSE IT.
  pause >NUL
  exit

:dir
  cls
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo (BACK) - back
  echo.
  set /p dir="Enter a directory to scan: "

  if "%dir%" == "back" goto start

  cd %dir%
  dir /s /b > files.txt
  set filenumber=1

  title MD5 Scan Pending - Protectish Total Security
  set dirscan=true
  goto scan

:file
  cls
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo (BACK) - back
  echo.
  set /p file="Enter a filename to scan: "

  if "%file%" == "back" goto start
  
:md5
  title MD5 Scan Pending - Protectish Total Security
  @CertUtil -hashfile %file% MD5 > md5.txt

  for /f "tokens=1*delims=:" %%G in ('findstr /n "^" md5.txt') do if %%G equ 2 set filemd5=%%H
  del md5.txt
 
  cls
  echo Protectish Total Security
  echo.
  echo The detected file MD5 hash is equal to:
  echo %filemd5%
  echo.
  echo We're about to compare this MD5 hash with our database.
  pause
  goto scan

:scan
  cls
  color 9f
  set oldfile=null

  if "%dirscan%" == "true" (
    for /f "tokens=1*delims=:" %%G in ('findstr /n "^" files.txt') do if %%G equ %filenumber% set file=%%H
    @CertUtil -hashfile %file% MD5 > md5.txt

    for /f "tokens=1*delims=:" %%G in ('findstr /n "^" md5.txt') do if %%G equ 2 set filemd5=%%H
    del md5.txt

    if "%oldfile%" == "%file%" (
      goto safe
    ) else (
      set oldfile=%file%
    )
  )

  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  if "%dirscan%" == "true" (
    echo Now scanning: %file%
    echo.
  )
  echo MD5 Scan: Pending
  echo Behavior Scan: Waiting
  echo Suspicious Actions Scan: Waiting

  set threat=""

  if "%filemd5%" == "88 5d 47 2c 1f 1f fc 43 e8 b6 ce 28 51 9a 10 84" set threat=Android-Dendroid
  if "%filemd5%" == "44 d8 86 12 fe a8 a8 f3 6d e8 2e 12 78 ab b0 2f" set threat=NotAVirus-EICAR.Test.File
  if "%filemd5%" == "94 11 b1 68 b9 10 1c 7b 48 52 a3 c7 94 9a 09 84" set threat=NotAVirus-PTS.Test.File
  if "%filemd5%" == "c9 d7 17 2a 90 bf 56 74 eb df bc 44 7e 4c d7 cf" set threat=VBS-AnnaKournikova
  if "%filemd5%" == "25 01 5a e9 b5 9d bd f5 0b 74 5c 33 4e 15 66 3f" set threat=VBS-LoveLetter
  if "%filemd5%" == "6f 71 0c 4e 4b b8 14 ea fa d0 24 a8 54 be cd f9" set threat=VBS-LoveLetter
  if "%filemd5%" == "8e 2c 09 7c a6 23 ca 32 72 3d 57 96 8b 9d 25 25" set threat=VBS-LoveLetter
  if "%filemd5%" == "84 e4 51 0a ec 4d 76 c5 d4 31 ab 32 d7 45 8f 8c" set threat=VBS-LoveLetter
  if "%filemd5%" == "63 cb 86 f8 d5 a1 56 0d af aa 25 22 d9 f8 86 14" set threat=VBS-LoveLetter
  if "%filemd5%" == "54 5a 15 43 07 a9 0e 8e 33 c3 0b 7c 7d 00 8d 16" set threat=VBS-Melissa.A
  if "%filemd5%" == "82 3d b9 b3 27 57 a7 fa 05 45 2c b9 58 e9 6e 50" set threat=VBS-Melissa.C
  if "%filemd5%" == "3f 76 a6 9e 1f d9 bb 3f a2 52 a3 ce d1 5e ba 72" set threat=VBS-Melissa.C
  if "%filemd5%" == "9d 7f 91 6d f5 05 16 ac 67 05 eb 0c 00 78 38 20" set threat=VBS-Melissa.Z
  if "%filemd5%" == "3a d9 58 ad d8 a0 7e a3 a0 77 ec 97 68 6c 67 d6" set threat=VBS-Trojan.Gansom
  if "%filemd5%" == "65 25 9c 11 e1 ff 8d 04 0f 9e c5 85 24 a4 7f 02" set threat=Win32-Adware.Bonzi
  if "%filemd5%" == "06 d8 7d 4c 89 c7 6c b1 bc b2 f5 a5 fc 40 97 d1" set threat=Win32-Adware.Bonzi
  if "%filemd5%" == "9f 8c 96 41 5f bf d3 d1 84 83 d1 df ad 62 26 38" set threat=Win32-Adware.BrowserAssistant
  if "%filemd5%" == "18 26 0d 74 0e 62 31 6f 68 2a 8c db e4 e9 4a 48" set threat=Win32-Adware.BrowserAssistant
  if "%filemd5%" == "88 f5 81 c1 cb 1d 63 4a 5b d3 a5 38 c8 47 e8 0f" set threat=Win32-Adware.ClientConnect
  if "%filemd5%" == "eb d2 a7 d3 ad 49 24 f4 c8 da 98 c5 e5 d6 8f 3b" set threat=Win32-Adware.Conduit.B
  if "%filemd5%" == "55 32 06 3c 46 5c e3 35 db 98 a2 69 0d e9 80 c8" set threat=Win32-Adware.Conduit.B
  if "%filemd5%" == "0b e1 4c 6f e4 bb 0b 2d ba f3 a8 61 91 72 64 80" set threat=Win32-Adware.Conduit.B
  if "%filemd5%" == "45 5e 61 a2 cf 37 f7 21 0d f6 85 e2 b7 7b fb e3" set threat=Win32-Adware.Conduit.B
  if "%filemd5%" == "9b b5 68 80 14 29 4b a8 1d 69 ad c9 a7 97 57 55" set threat=Win32-Adware.Conduit.Y
  if "%filemd5%" == "2c 1a d7 84 12 69 40 d1 54 84 1d 33 45 a2 d0 6b" set threat=Win32-Adware.DealPly
  if "%filemd5%" == "57 f2 51 09 b2 55 d0 4c 05 fb 7f da d1 62 b5 ee" set threat=Win32-Adware.DealPly
  if "%filemd5%" == "e0 69 fd bd 26 84 a8 fa ef 23 a6 96 05 09 d9 93" set threat=Win32-Adware.DownloadAssistant
  if "%filemd5%" == "07 16 8b d3 7f 9c 1c 19 c9 61 65 b9 eb d5 c6 9c" set threat=Win32-Adware.DownloadHelper
  if "%filemd5%" == "79 e1 67 48 cc 1c 72 58 25 d5 c5 99 1a 82 fd 89" set threat=Win32-Adware.Machaer
  if "%filemd5%" == "0e be b3 ed a3 e2 aa f5 02 4a a6 7b 7f 49 4c f1" set threat=Win32-Adware.OpenCandy
  if "%filemd5%" == "14 64 da b8 53 df ac 75 09 7e 6f 81 fa 06 0c 9a" set threat=Win32-Adware.OpenCandy
  if "%filemd5%" == "98 2e 03 ae 76 af 8d f3 ed ef 04 43 d4 e4 81 f8" set threat=Win32-Adware.Rugo
  if "%filemd5%" == "0a f5 b9 ca 01 e4 9e 09 fd be 43 8c 7a 50 42 db" set threat=Win32-Adware.Swizzor
  if "%filemd5%" == "73 c3 46 6b 67 79 34 46 52 ef 97 20 9a b4 db 1a" set threat=Win32-Anywork
  if "%filemd5%" == "28 65 6c 94 b4 80 ec 5f fa 40 40 68 25 96 52 c3" set threat=Win32-AutoRun
  if "%filemd5%" == "df ae 62 b7 f1 1e eb 45 a6 90 99 eb 85 59 2d 92" set threat=Win32-Backdoor.Clampi
  if "%filemd5%" == "1e d9 8f 81 1f 3e 13 93 ad 17 1c 70 a7 5c c4 27" set threat=Win32-Backdoor.Clampi
  if "%filemd5%" == "63 c0 76 ed 73 97 2a 21 c3 54 63 3d 43 b9 38 65" set threat=Win32-Backdoor.Clampi
  if "%filemd5%" == "ef 69 4b 89 ad 7a dd b9 a1 6b b6 f2 6f 1e fa f7" set threat=Win32-Backdoor.FakeCCleaner
  if "%filemd5%" == "db c2 bd 34 6f f8 1a 0c 5f c1 6f a6 83 b2 6a 36" set threat=Win32-Backdoor.FedEx
  if "%filemd5%" == "64 87 6d 5d e7 06 1e 92 5e 29 f6 a0 c8 7c ea 9b" set threat=Win32-Backdoor.Konus
  if "%filemd5%" == "d4 07 55 9e 9d f5 43 20 e4 14 ff 6d 6c 5d cc b6" set threat=Win32-Backdoor.Prorat
  if "%filemd5%" == "27 0b a3 d7 c6 98 6a da e1 e3 da 12 99 39 ba 9d" set threat=Win32-Backdoor.Prorat
  if "%filemd5%" == "bf 30 21 3b 41 d8 1b 53 06 13 06 eb af 8c 16 ee" set threat=Win32-Backdoor.Sixer
  if "%filemd5%" == "00 fb 27 df d5 74 71 ab 32 77 01 f4 c2 3e 82 8f" set threat=Win32-Backdoor.Theef.EM
  if "%filemd5%" == "d2 b5 5a 2d 03 ba ee fd 9b ac b2 7b 58 25 0b 35" set threat=Win32-Backdoor.Theef.EM
  if "%filemd5%" == "ec 40 cc aa d6 3f 88 55 d8 de 31 a4 2b 7c 67 ac" set threat=Win32-Backdoor.Tofsee
  if "%filemd5%" == "db 19 1b ba 75 d9 ec a8 0f bb f4 fa 02 52 d2 4e" set threat=Win32-Blackbat
  if "%filemd5%" == "15 b8 93 9a 07 1e 23 c9 11 f9 17 d8 76 05 32 e3" set threat=Win32-BlastButton
  if "%filemd5%" == "86 76 21 0e 62 46 94 82 01 aa 01 4d b4 71 de 90" set threat=Win32-Blaster
  if "%filemd5%" == "f3 e4 fb 7f 22 3b ef 58 2c 63 e5 b8 7e 14 40 e7" set threat=Win32-Bloored
  if "%filemd5%" == "68 ab 07 e4 e7 79 ed 8b 5b 71 b7 c5 5f 33 b0 87" set threat=Win32-Blueballs
  if "%filemd5%" == "6a 48 53 cd 05 84 dc 90 06 7e 15 af b4 3c 49 62" set threat=Win32-ChilledWindows
  if "%filemd5%" == "3a 70 25 17 61 a4 ac c0 53 d3 9f 2c 5f 61 3b 42" set threat=Win32-CodecPack
  if "%filemd5%" == "c1 49 2e f9 be 34 a8 74 3b 52 4b 1a 0a 3e 07 7c" set threat=Win32-CoinMiner.Agent
  if "%filemd5%" == "92 ed 22 d3 89 26 26 ce 4b c0 50 cb 5f a7 e5 2d" set threat=Win32-CoinMiner.Agent
  if "%filemd5%" == "ab a2 d8 6e d1 7f 58 7e b6 d5 7e 6c 75 f6 4f 05" set threat=Win32-CoinMiner.Agent
  if "%filemd5%" == "1c d6 3b c5 4f 81 7b 94 fe fe 44 d5 ce 02 26 27" set threat=Win32-CoinMiner.XMRig
  if "%filemd5%" == "2e 8d a5 a5 58 65 a0 91 86 4a 43 38 ef 4d 2e 44" set threat=Win32-Conficker
  if "%filemd5%" == "3a fe b8 e9 af 02 a3 3f f7 1b f2 f6 75 1c ae 3a" set threat=Win32-CPUMiner
  if "%filemd5%" == "3a f2 98 63 3c c2 f3 c3 f3 5a f9 6e 93 0c 98 44" set threat=Win32-Dabber
  if "%filemd5%" == "44 51 20 7a a3 fe 02 1d c2 bf c6 83 d5 7b a5 a1" set threat=Win32-Gogo
  if "%filemd5%" == "e2 55 12 40 5a cd fa 4e 2d 71 7a 56 69 d3 0d 54" set threat=Win32-Gullible
  if "%filemd5%" == "40 67 ae a4 c2 12 5d 2d 0a 80 aa eb be c6 86 b6" set threat=Win32-IceIX
  if "%filemd5%" == "bc 5e 27 7b 6d 94 36 3d dc 11 19 7f 71 43 e9 4b" set threat=Win32-ICLoader
  if "%filemd5%" == "01 29 da b7 29 15 cc 20 bf 10 4c 09 08 85 47 c4" set threat=Win32-Ipamor
  if "%filemd5%" == "41 dd 2b f0 50 ce 71 95 ad 59 4a eb d3 f3 af c4" set threat=Win32-Ipamor
  if "%filemd5%" == "28 a9 3d ff 57 ed 7b 94 ef 51 a3 ad 2f 1a 9a 41" set threat=Win32-Ipamor
  if "%filemd5%" == "df d1 74 1b 9d 4c 16 a5 4f 3d 61 04 d4 66 3f c8" set threat=Win32-Joke.Disco
  if "%filemd5%" == "4e 33 66 78 55 87 2e cd a9 5a 11 71 b4 0a ae 9a" set threat=Win32-Klez.A
  if "%filemd5%" == "f9 59 81 82 9c a6 60 e8 4f 1d 33 bd fa 9e 2a 28" set threat=Win32-Klez.A
  if "%filemd5%" == "a5 a4 8f bc 21 18 03 db 3d cc 9b 91 7d 5d 32 0f" set threat=Win32-Kolabc
  if "%filemd5%" == "03 ba eb a6 b4 22 43 71 cc a7 fa 6f 95 ae 61 c0" set threat=Win32-Krap
  if "%filemd5%" == "f2 cc 60 64 3a cd 7c 5b 2b ef a8 62 94 5c 99 cb" set threat=Win32-Kriz
  if "%filemd5%" == "fb 23 aa e4 12 65 0b 84 f6 a3 70 81 e3 9c 68 79" set threat=Win32-Kriz
  if "%filemd5%" == "cc a7 de f7 19 45 4d d2 2e c3 51 99 12 97 88 5b" set threat=Win32-Lmir
  if "%filemd5%" == "98 90 34 9f e3 c6 8f 59 23 b2 93 47 bb a0 21 a4" set threat=Win32-Magistr.A
  if "%filemd5%" == "47 84 e4 2c 3b 15 d1 a1 41 a5 e0 c8 ab c1 20 5c" set threat=Win32-Melting
  if "%filemd5%" == "01 99 ae 48 b0 97 cf e3 ae 92 4c 60 5a e9 8f 41" set threat=Win32-Microjoin
  if "%filemd5%" == "46 85 ee e7 10 ce 45 e5 34 02 77 87 54 6e 0a 56" set threat=Win32-Mofksys
  if "%filemd5%" == "6f 19 a3 ab bc fd 79 4a 9c 17 65 79 90 27 d5 52" set threat=Win32-Mofksys
  if "%filemd5%" == "7a 96 3a 73 6a 1c 21 5e 9a b3 52 af c4 be 0a 85" set threat=Win32-Mofksys
  if "%filemd5%" == "ae 9f c2 81 2c 2a 6d 55 c9 f6 6b 62 69 63 63 9f" set threat=Win32-MSILZilla
  if "%filemd5%" == "6b 78 82 e1 97 90 13 ae 92 ee 1b 8c ea 9f bd 10" set threat=Win32-MyDoom
  if "%filemd5%" == "0d e0 8e 8f a1 36 9b 15 ef 29 2f 93 7a 8e e1 de" set threat=Win32-MyDoom
  if "%filemd5%" == "5b f4 59 42 4c 81 03 f7 5b 17 65 92 0a 6d ac 0c" set threat=Win32-MyDoom
  if "%filemd5%" == "9f 31 84 31 d8 2b 39 9e f8 b1 6f bf ec e9 c4 a6" set threat=Win32-MyDoom
  if "%filemd5%" == "26 15 70 17 f5 a8 8d 38 73 9f 98 11 04 c5 77 f7" set threat=Win32-MyDoom
  if "%filemd5%" == "07 86 6c 5c 66 56 4d 1f 01 6d c5 28 bf b8 8d 3c" set threat=Win32-MyDoom
  if "%filemd5%" == "29 fa 8a 13 f3 b0 eb c8 fb 40 de 2f c6 86 cc 17" set threat=Win32-MyDoom
  if "%filemd5%" == "ee c0 03 d5 97 e1 0e 93 ee 10 da 2d 9e a4 eb 49" set threat=Win32-MyDoom
  if "%filemd5%" == "b0 fe 74 71 9b 1b 64 7e 20 56 64 19 31 90 7f 4a" set threat=Win32-MyDoom
  if "%filemd5%" == "94 ec 47 42 8d ab b4 92 af 96 75 6e 7c 95 c6 44" set threat=Win32-MyPics.A
  if "%filemd5%" == "0e 8f 2e 37 c1 66 e3 c4 01 7e 7a eb 1b 5b f1 9f" set threat=Win32-Necurs
  if "%filemd5%" == "c9 67 9e 89 c8 2e 02 5b 98 55 18 98 76 f9 27 61" set threat=Win32-Neshta.A
  if "%filemd5%" == "bf bc 3b 53 3d 55 ae 5a 53 ad 27 78 5a 95 3a 53" set threat=Win32-Neshta.A
  if "%filemd5%" == "64 2a 39 3a 5c 65 d2 02 18 0d f5 af 06 f2 9c 5a" set threat=Win32-Nimda.A
  if "%filemd5%" == "08 3d 59 7f 4b 8d e7 c2 a7 88 8d f0 e5 e3 9a 8a" set threat=Win32-Nimda.A
  if "%filemd5%" == "aa 9e ca 49 c7 22 ec 1b ab bc 21 55 f1 a9 10 39" set threat=Win32-Nimda.T
  if "%filemd5%" == "ef 4f df 65 fc 90 bf da 8d 1d 2a e6 d2 0a ff 60" set threat=Win32-NoEscape
  if "%filemd5%" == "19 65 6c 44 0d 11 46 e0 79 50 e5 e3 28 0a 0e 82" set threat=Win32-OpenInstall
  if "%filemd5%" == "2f 9a f2 30 d0 36 ba 31 09 49 94 5a e4 b1 a2 f4" set threat=Win32-Parite.B
  if "%filemd5%" == "68 5f 1c bd 4a f3 0a 1d 0c 25 f2 52 d3 99 a6 66" set threat=Win32-Parite.B
  if "%filemd5%" == "3e c0 23 c1 37 6f 3b 59 ec 56 ff 41 db 98 51 ec" set threat=Win32-Parite.B
  if "%filemd5%" == "53 66 c2 a6 62 cd dd 60 0d 93 e3 99 2b 8e d1 cd" set threat=Win32-Parite.B
  if "%filemd5%" == "73 d3 54 51 db fb ba 5a c0 51 d3 6f 09 5a 62 9f" set threat=Win32-Parrot.A
  if "%filemd5%" == "6c 1c fe 55 c4 c2 6f cf b8 3e 2d cb b9 a4 2e 89" set threat=Win32-Parrot.B
  if "%filemd5%" == "96 5e df d8 ee 48 b6 f7 40 4e 28 5c 36 4a 3b 76" set threat=Win32-Phishing.FedX
  if "%filemd5%" == "1e ad 86 42 7f c0 76 f7 7f 21 cc b7 51 2d c8 b2" set threat=Win32-Picsys.C
  if "%filemd5%" == "71 56 14 e0 92 61 b3 9d fa 43 9f a1 32 6c 0c ec" set threat=Win32-Pikachu
  if "%filemd5%" == "68 30 88 4f b2 9c b5 12 d2 5a cb 4c 82 b5 cd af" set threat=Win32-PoisonIvy
  if "%filemd5%" == "a9 2e 0b e7 1c ed 2d 13 69 5b 75 55 28 0d df 51" set threat=Win32-PoisonIvy
  if "%filemd5%" == "4a a5 0b ef 4c 3b 2a e1 4f 20 77 66 35 65 5b 50" set threat=Win32-Ramnit
  if "%filemd5%" == "ff 5e 1f 27 19 3c e5 1e ec 31 87 14 ef 03 8b ef" set threat=Win32-Ramnit
  if "%filemd5%" == "1c 12 64 41 d4 63 5b af 74 e6 fd 62 8b aa 67 14" set threat=Win32-Ransom.1337Locker
  if "%filemd5%" == "0e 61 e4 96 fc 21 8c 1c 6d c1 f5 64 0a 3a c7 e5" set threat=Win32-Ransom.Agent
  if "%filemd5%" == "f7 18 65 97 30 8a db 3a 78 d3 56 e1 59 ce 18 b0" set threat=Win32-Ransom.Ako
  if "%filemd5%" == "98 c0 c4 e5 8a 97 cf 92 f9 c6 99 2e e6 5e 3f 0f" set threat=Win32-Ransom.Amnesia
  if "%filemd5%" == "ca 11 71 33 82 3c 73 bd b4 ad 3f 52 93 72 ea ae" set threat=Win32-Ransom.AnDROid
  if "%filemd5%" == "7a b9 1e 57 a1 e2 75 2c d8 ab ee 3d b1 08 53 c5" set threat=Win32-Ransom.AngryDuck
  if "%filemd5%" == "0f 74 32 87 c9 91 1b 4b 1c 72 6c 7c 7e dc af 7d" set threat=Win32-Ransom.Annabelle
  if "%filemd5%" == "bb ac d7 e5 e7 be 9d e0 18 1e 41 8d e9 c2 6c 5a" set threat=Win32-Ransom.Armage
  if "%filemd5%" == "85 6b 19 af f2 37 ac e0 dd a3 ec fc 71 c0 97 67" set threat=Win32-Ransom.BadBlock
  if "%filemd5%" == "f1 94 25 31 86 f9 43 fc 2a e3 fc 7c 54 70 7c 00" set threat=Win32-Ransom.BadRabbit
  if "%filemd5%" == "2f e3 2d 2a 6b fc 72 d2 15 49 6b 05 5e 5a 53 ad" set threat=Win32-Ransom.BadRabbit
  if "%filemd5%" == "50 a7 db 13 62 f5 53 4a 1b 6a db f9 cc be 9d 5b" set threat=Win32-Ransom.Bisquilla
  if "%filemd5%" == "8f db b5 54 51 ff b4 4d 0b ce f3 7e 13 23 4f 66" set threat=Win32-Ransom.BitPaymer
  if "%filemd5%" == "50 c4 97 00 03 a8 4c ab 1b f2 63 46 31 fe 39 d7" set threat=Win32-Ransom.BlackMatter
  if "%filemd5%" == "75 04 e4 c1 94 81 c1 0a 67 a8 f4 c3 c1 09 ae 47" set threat=Win32-Ransom.BloodJaws
  if "%filemd5%" == "b2 dd 12 b7 17 a2 cf cc b2 7a e2 e8 39 df f9 f7" set threat=Win32-Ransom.BloodJaws
  if "%filemd5%" == "0f 55 c5 a3 c4 2d 6d 6c cf c2 95 7d 74 ff 6e b2" set threat=Win32-Ransom.BloodJaws
  if "%filemd5%" == "13 26 34 0d 8a 1b 99 2e a7 1b f4 84 05 50 d9 17" set threat=Win32-Ransom.BloodJaws
  if "%filemd5%" == "e6 42 55 6c bb 20 a9 7d 6c 4f 9d c2 5e a9 68 7f" set threat=Win32-Ransom.BloodJaws
  if "%filemd5%" == "16 ad a5 1d c0 a0 62 f8 60 8d a8 92 2b 0f c9 f8" set threat=Win32-Ransom.Blooper
  if "%filemd5%" == "92 66 05 0f 3c e5 ba 99 53 35 31 68 9e ae 7e 2f" set threat=Win32-Ransom.Bluerose
  if "%filemd5%" == "ab 07 5e b2 ad 67 2b fa 36 99 62 c1 be 15 66 9a" set threat=Win32-Ransom.Braincrypt
  if "%filemd5%" == "27 14 58 8f b8 93 30 40 93 88 5c 23 f5 41 69 ee" set threat=Win32-Ransom.BrainLag
  if "%filemd5%" == "e6 0e 76 7e 33 ac f4 9c 02 56 8a 79 d9 cb da dd" set threat=Win32-Ransom.Buran
  if "%filemd5%" == "cf d2 d6 f1 89 b0 4d 42 61 80 07 fc 9c 54 03 52" set threat=Win32-Ransom.Cerber
  if "%filemd5%" == "db 9e ef 8a d5 41 98 59 c6 76 ac b4 ef 4a 5b 13" set threat=Win32-Ransom.Cerber
  if "%filemd5%" == "e6 92 2a 68 fc a9 00 16 58 4a c4 8f c7 72 2e f8" set threat=Win32-Ransom.Chimera
  if "%filemd5%" == "84 f3 c3 7f db 67 23 84 a0 e0 82 84 ee ff 44 e4" set threat=Win32-Ransom.Cockblocker
  if "%filemd5%" == "4f 41 35 fc 5b 67 6c 4d 40 7e a9 0d 89 08 e8 14" set threat=Win32-Ransom.Clown
  if "%filemd5%" == "02 d9 97 a8 98 31 b6 54 7a 28 4b aa 75 75 25 f2" set threat=Win32-Ransom.Cry9
  if "%filemd5%" == "10 99 19 9d c2 27 a8 a2 14 ff 9f 57 6c fd ec 1e" set threat=Win32-Ransom.CryForMe
  if "%filemd5%" == "1b ba 89 d7 a8 b8 7f b7 5b 6a e5 95 85 f7 17 b6" set threat=Win32-Ransom.CryptoFinancial
  if "%filemd5%" == "63 cc 40 d1 2e 49 ff b5 07 d9 1a f8 f7 a6 f0 82" set threat=Win32-Ransom.CryptoKill
  if "%filemd5%" == "bc 11 c9 3f 1b 6d c7 4b f4 80 4a 35 b3 4d 92 67" set threat=Win32-Ransom.Cryptolocker
  if "%filemd5%" == "12 7b 80 31 1e 32 0f ff a2 44 61 f7 35 66 d4 80" set threat=Win32-Ransom.Cryptolocker
  if "%filemd5%" == "b1 8c 5a f6 96 e8 84 72 41 e4 c1 72 30 db 36 c9" set threat=Win32-Ransom.CryptoSpider
  if "%filemd5%" == "41 d4 ab 0d e7 f5 6c 1d 4b 38 fc 10 c2 55 18 f9" set threat=Win32-Ransom.CryptoWire
  if "%filemd5%" == "0a aa d9 fd 6d 9d e6 a1 89 e8 97 09 e0 52 f0 6b" set threat=Win32-Ransom.CrySiS
  if "%filemd5%" == "5d 2a 7e 18 9d ef 04 ff 14 8e ee 04 e4 37 34 8d" set threat=Win32-Ransom.Damage
  if "%filemd5%" == "d5 f1 64 9c dd df 19 2d 4e d3 c2 89 bc 1e 95 f0" set threat=Win32-Ransom.Dangerous
  if "%filemd5%" == "fc 3d 3e 54 3a ef 4b 09 79 9c f7 8d 12 04 50 06" set threat=Win32-Ransom.Delphimorix
  if "%filemd5%" == "7e 17 9d 06 4b 2d 20 b4 ea 5e 6d 49 2a bf 8f 2b" set threat=Win32-Ransom.DexLocker
  if "%filemd5%" == "d3 2e 4d 8b 42 38 cf cc 79 3e c3 b3 7c c9 a8 75" set threat=Win32-Ransom.Dharma
  if "%filemd5%" == "2f fc d2 d6 2a 57 32 93 c8 67 9b fd 60 66 77 b5" set threat=Win32-Ransom.DiscordNitro
  if "%filemd5%" == "8f 03 15 e9 0a 70 73 f1 5f 1d 56 3e 9b 16 44 80" set threat=Win32-Ransom.Dogge
  if "%filemd5%" == "13 c1 c6 8c 14 10 df 27 7f c3 7d 68 55 7b b4 3b" set threat=Win32-Ransom.DriedSister
  if "%filemd5%" == "14 41 b0 70 4b 07 d6 e8 f7 98 f6 68 4f af 0f 79" set threat=Win32-Ransom.EDA2
  if "%filemd5%" == "61 2b a5 a5 20 38 14 1d d5 c5 71 a4 b0 dc 6b 86" set threat=Win32-Ransom.EggLocker
  if "%filemd5%" == "a7 4b 25 0b 40 28 d5 39 7c c0 9f 62 7b b5 89 ab" set threat=Win32-Ransom.Explorer
  if "%filemd5%" == "24 f3 2d a2 58 b8 c4 2c 71 ab fb 75 77 fb 35 a8" set threat=Win32-Ransom.FakeWannaCryptor
  if "%filemd5%" == "98 4a ac b6 8d bc 13 c0 e9 cb 3a a4 41 f6 97 44" set threat=Win32-Ransom.FakeWannaCryptor
  if "%filemd5%" == "94 32 8c a2 cb 87 23 0a 5b 0c 73 4e 23 21 e9 93" set threat=Win32-Ransom.Fantom
  if "%filemd5%" == "fa fa 32 c5 26 86 14 82 da 1b 49 49 32 69 f8 75" set threat=Win32-Ransom.FSociety
  if "%filemd5%" == "d3 87 09 92 ca 34 b0 dc 5c 3b cf c2 a1 9e 39 85" set threat=Win32-Ransom.GandCrab
  if "%filemd5%" == "bf 58 71 48 38 ed fc c1 35 a6 48 18 d3 66 75 47" set threat=Win32-Ransom.GPAA
  if "%filemd5%" == "f9 da 7d cf 28 c9 e0 6e f9 b2 d3 94 67 c8 2f 70" set threat=Win32-Ransom.GX40
  if "%filemd5%" == "43 13 fd 0a 3d 2c be dd 45 70 23 09 31 83 3f e1" set threat=Win32-Ransom.HolyCrypt
  if "%filemd5%" == "3e 7b d2 12 6a d2 d0 56 b1 2a 90 6e c7 4f 4e 75" set threat=Win32-Ransom.Ims00ry
  if "%filemd5%" == "2d c2 18 b4 3c b1 3d e2 78 f4 f0 68 c5 03 a6 e3" set threat=Win32-Ransom.Jamper
  if "%filemd5%" == "15 4b 74 33 56 d5 1d ea c0 da 4e be 5f c1 fb 71" set threat=Win32-Ransom.Jigsaw
  if "%filemd5%" == "4e 89 0b a5 a4 f6 fd 63 72 7c 00 05 da a6 54 dd" set threat=Win32-Ransom.Jigsaw
  if "%filemd5%" == "a4 bb 3a 5c b6 83 5c 08 9d 76 91 00 d5 46 16 62" set threat=Win32-Ransom.Jigsaw
  if "%filemd5%" == "35 f0 50 c3 84 15 4c 4a e2 3e 02 b3 fc e7 98 47" set threat=Win32-Ransom.JNEC.A
  if "%filemd5%" == "f5 4c 9a fc 52 02 9f d4 3b fb e6 dd 3c a2 f6 16" set threat=Win32-Ransom.JSterling
  if "%filemd5%" == "5e b7 d1 79 ad 6a 50 61 b4 ac 21 9d 58 4d 8e f8" set threat=Win32-Ransom.Kangaroo
  if "%filemd5%" == "56 f3 d3 d6 82 d6 11 2e 4d 6f 9f 31 6b e5 8d f4" set threat=Win32-Ransom.Karma
  if "%filemd5%" == "05 42 7e d1 c4 77 cc 01 91 0e b9 ad bf 35 06 8d" set threat=Win32-Ransom.Karmen
  if "%filemd5%" == "7f 87 db 33 98 0c 00 99 73 9d e4 0d 1b 72 55 00" set threat=Win32-Ransom.Katyusha
  if "%filemd5%" == "12 e2 ef f0 9c 11 4c 18 46 28 94 a4 89 11 ce 8a" set threat=Win32-Ransom.KesLan
  if "%filemd5%" == "e8 9e 40 9c 91 84 cc 61 3e 0b 69 6b a5 be 95 41" set threat=Win32-Ransom.Kostya
  if "%filemd5%" == "b2 14 a9 cd 3c 2f c0 cc ec c8 d1 e5 2b 4f 50 20" set threat=Win32-Ransom.Kraken
  if "%filemd5%" == "c1 3d 28 dd 3d 19 f5 e0 1e f7 08 fc db b5 e3 b2" set threat=Win32-Ransom.Kraken
  if "%filemd5%" == "0a 74 35 67 c9 fa 72 e0 8c a6 c1 0a d6 20 01 76" set threat=Win32-Ransom.KRider
  if "%filemd5%" == "78 9d dc a4 99 7c 12 65 9f 23 93 6c 4f 91 e0 e5" set threat=Win32-Ransom.Kryptonite
  if "%filemd5%" == "b3 17 53 31 ae 74 ee 27 7e 94 d3 e0 bc 98 2b f4" set threat=Win32-Ransom.Lockbit
  if "%filemd5%" == "b2 69 85 00 c9 c9 0d 9c fb 5a a9 0f e2 81 ee 51" set threat=Win32-Ransom.LockerGoga
  if "%filemd5%" == "77 1d eb 8b 72 0d bd 78 4d 67 15 40 3a 41 bd cc" set threat=Win32-Ransom.Locky
  if "%filemd5%" == "b5 94 41 2c 00 33 1c 12 d1 5d 9e 18 c0 2a 77 8a" set threat=Win32-Ransom.LostFiles
  if "%filemd5%" == "a5 ed 29 35 a9 f8 5c 27 9f ce 7d de 74 25 24 34" set threat=Win32-Ransom.LostFiles
  if "%filemd5%" == "75 0c 2c c9 1b 6c e6 97 aa 6a 5f c8 61 08 40 1f" set threat=Win32-Ransom.MindSystem
  if "%filemd5%" == "2d 71 a6 ce f2 f5 f7 25 a7 bc f8 6a 4a a7 60 22" set threat=Win32-Ransom.Mole
  if "%filemd5%" == "0e 0b 7b 23 8a 06 a2 a3 7a 4d e0 6a 5a b5 e6 15" set threat=Win32-Ransom.Nemty
  if "%filemd5%" == "17 c2 5c 8a 7c 14 11 95 ee 88 7d e9 05 f3 3d 7b" set threat=Win32-Ransom.NotPetya
  if "%filemd5%" == "09 f2 c2 f3 81 e6 19 89 47 cb 1b 9b c1 22 8a a8" set threat=Win32-Ransom.NTKCryptolocker
  if "%filemd5%" == "c0 28 e2 74 29 34 8c 73 3b f0 81 12 ae a1 b9 06" set threat=Win32-Ransom.OhNo
  if "%filemd5%" == "74 25 7f 66 ac 9e 43 b1 5b 98 ee 71 66 f8 bd c7" set threat=Win32-Ransom.Oops
  if "%filemd5%" == "b5 f9 36 35 8b 65 59 ac 3c 71 fd 53 c0 f0 9f 0e" set threat=Win32-Ransom.Orion
  if "%filemd5%" == "40 1c 7d ef d9 81 57 01 93 17 65 c4 e8 b8 d8 f9" set threat=Win32-Ransom.Paradise
  if "%filemd5%" == "59 7d ea cb e8 a1 d7 cf 84 1e 1f 41 e9 10 89 8f" set threat=Win32-Ransom.Petya.A
  if "%filemd5%" == "af 23 79 cc 4d 60 7a 45 ac 44 d6 21 35 fb 70 15" set threat=Win32-Ransom.Petya.A
  if "%filemd5%" == "fa 5d 96 64 4f e5 89 77 b4 97 65 f2 3b 3a 7e e5" set threat=Win32-Ransom.Phobos
  if "%filemd5%" == "91 98 29 30 fe 63 1d 3f cc b2 96 4a 7b 56 36 06" set threat=Win32-Ransom.PhobosImposter
  if "%filemd5%" == "39 19 ab d7 0a 26 63 82 1b 08 55 83 92 0c ad 54" set threat=Win32-Ransom.PoliceNationale
  if "%filemd5%" == "91 a0 75 50 e5 ca 2c 97 7f 50 40 6f 07 12 6a c8" set threat=Win32-Ransom.Polski
  if "%filemd5%" == "9c ce 98 a7 0c 25 36 06 33 ce 79 1e af 9f ba 18" set threat=Win32-Ransom.PolyRansom
  if "%filemd5%" == "38 3c 36 8a e3 3c 53 0d a3 6f fa e0 bc ee c8 0e" set threat=Win32-Ransom.PopcornTime
  if "%filemd5%" == "b7 5d 9c cd fe 58 0f fc d5 3f 98 74 52 be 4d ac" set threat=Win32-Ransom.PrincessEvolution
  if "%filemd5%" == "ac ae af 1e 1f f0 b0 43 a3 7d 2a 3e 3f 9f 3f be" set threat=Win32-Ransom.PrincessEvolution
  if "%filemd5%" == "40 d2 9a ce 41 27 9f 3d f8 db f7 a0 96 09 b2 44" set threat=Win32-Ransom.PUBG
  if "%filemd5%" == "48 45 2d d2 50 68 31 d0 b3 40 e4 5b 08 79 96 23" set threat=Win32-Ransom.Ragnarok
  if "%filemd5%" == "e0 34 0f 45 6f 76 99 3f c0 47 bc 71 5d fd ae 6a" set threat=Win32-Ransom.RedBoot
  if "%filemd5%" == "3c 76 75 48 d8 a7 4b 96 e8 51 a5 8b cc 4c 44 bc" set threat=Win32-Ransom.Rogue
  if "%filemd5%" == "db 63 b9 73 12 15 79 bc ad 7c 99 52 80 ca 4d 03" set threat=Win32-Ransom.RollSafe
  if "%filemd5%" == "6c dc b9 f8 69 72 ef c4 cf ce 4b 06 b6 be 05 3a" set threat=Win32-Ransom.Ryuk
  if "%filemd5%" == "5a c0 f0 50 f9 3f 86 e6 90 26 fa ea 1f bb 44 50" set threat=Win32-Ransom.Ryuk
  if "%filemd5%" == "93 5a 75 e0 c7 70 22 40 cb 53 0b 31 a8 3b 7c bc" set threat=Win32-Ransom.SadComputer
  if "%filemd5%" == "de 88 2f 60 ce 2a 09 98 99 c3 c4 e4 be 16 c5 e4" set threat=Win32-Ransom.Satana
  if "%filemd5%" == "cd af 85 2a 6a 3f 60 7c 20 cb e9 de ac b7 96 49" set threat=Win32-Ransom.Scarab
  if "%filemd5%" == "59 2b 12 b5 a4 d9 be ec 0c 89 14 fc b3 6a 8f 30" set threat=Win32-Ransom.Shade
  if "%filemd5%" == "ab a8 57 58 35 1d 76 2f fd ef 5f a9 61 08 36 07" set threat=Win32-Ransom.ShellLocker
  if "%filemd5%" == "2b e6 38 5e 51 59 21 07 16 68 1f 59 b6 4a ef 1e" set threat=Win32-Ransom.ShellLocker
  if "%filemd5%" == "04 d5 42 64 62 db c0 2b be c3 81 45 ab c7 49 c5" set threat=Win32-Ransom.ShutUpAndDance
  if "%filemd5%" == "5a 9a e5 f5 1c 41 f2 de 4f 3e ca 94 dd b4 cc fd" set threat=Win32-Ransom.Snatch
  if "%filemd5%" == "ed 52 77 5f d3 3e 70 ad 76 58 ec 35 c8 2d 29 92" set threat=Win32-Ransom.Snatch
  if "%filemd5%" == "b7 da 21 0b 88 5c 66 36 de 70 c0 12 9d a4 8a 66" set threat=Win32-Ransom.Snatch
  if "%filemd5%" == "be d6 fc 04 ae b7 85 81 57 44 70 62 39 a1 f2 43" set threat=Win32-Ransom.Sodinokibi
  if "%filemd5%" == "56 1c ff ba ba 71 a6 e8 cc 1c dc ed a9 90 ea d4" set threat=Win32-Ransom.Sodinokibi
  if "%filemd5%" == "61 c0 03 ba c2 28 85 7c b0 db 62 07 eb 5a 7f 3e" set threat=Win32-Ransom.StalinLocker
  if "%filemd5%" == "2d e1 f1 4d 07 37 0b 98 67 f2 52 c0 76 37 ab 40" set threat=Win32-Ransom.Stolich
  if "%filemd5%" == "60 db b9 23 24 25 b9 dd c3 5c 9c d0 65 3a c5 cd" set threat=Win32-Ransom.STOP
  if "%filemd5%" == "58 6d 9e 5d 8a 90 30 1b 49 4e 83 3d 36 30 23 83" set threat=Win32-Ransom.STOP
  if "%filemd5%" == "be 42 07 0f d1 68 10 7d d2 ac 6e d9 12 72 35 72" set threat=Win32-Ransom.SuchSecurity
  if "%filemd5%" == "63 d4 e4 da c5 7b d7 d2 05 95 87 eb a4 16 26 52" set threat=Win32-Ransom.SureRansom.A
  if "%filemd5%" == "8e 5f f6 0b f6 66 5c 57 93 8a b5 66 46 72 6e 1c" set threat=Win32-Ransom.Thanos
  if "%filemd5%" == "6c aa f5 00 c2 48 de 17 b1 90 72 93 70 00 7d da" set threat=Win32-Ransom.Tyrant
  if "%filemd5%" == "bb 46 b9 28 c3 2e c9 63 06 42 89 d2 1b d1 6d da" set threat=Win32-Ransom.Unlock92
  if "%filemd5%" == "57 7b e8 c5 b7 3e 59 fb 71 57 0f 63 23 49 e5 fe" set threat=Win32-Ransom.UselessDisk
  if "%filemd5%" == "77 48 7c 27 f5 47 6f 7b cb 09 21 06 f4 84 5b 4f" set threat=Win32-Ransom.VegaLocker
  if "%filemd5%" == "68 2f 91 e3 ce 76 9a 68 65 ec d9 f2 b2 36 e8 3a" set threat=Win32-Ransom.VindowsLocker
  if "%filemd5%" == "74 d6 e7 09 98 32 b4 d0 6f 45 39 80 aa 71 5b 05" set threat=Win32-Ransom.WannaCryptor
  if "%filemd5%" == "53 d0 74 70 d6 de 22 c7 f2 63 3f bb 84 d1 98 67" set threat=Win32-Ransom.WannaCryptor
  if "%filemd5%" == "c8 87 22 ef 42 a6 ee 08 cb ed 91 40 6e a5 c0 e5" set threat=Win32-Ransom.WannaCryptor
  if "%filemd5%" == "e4 b6 23 3a e4 6e 8a 64 f0 58 aa c3 c3 78 b0 17" set threat=Win32-Ransom.WannaCryptor
  if "%filemd5%" == "27 2d 02 d9 69 4b 61 08 ce 0c b9 3b e8 af 8f 16" set threat=Win32-Ransom.WannaCryptor
  if "%filemd5%" == "c4 f0 bb 8b aa 5f a8 f6 59 05 d1 13 d0 6c 89 15" set threat=Win32-Ransom.WannaCryptor
  if "%filemd5%" == "83 cb 5b 87 a7 86 fb 13 5a 11 bc 13 3f b4 d4 d6" set threat=Win32-Ransom.WannaOof
  if "%filemd5%" == "9d e4 34 f0 af ed 54 dc 53 e1 dc b1 1b c6 9f b7" set threat=Win32-Ransom.Wesker
  if "%filemd5%" == "e0 b9 18 8e cd ad 1b 89 13 1f ec ed cd 8e a4 db" set threat=Win32-Ransom.WIN
  if "%filemd5%" == "40 e7 40 3b 6b 86 d5 f8 a5 3a 35 e3 bd cd f2 b6" set threat=Win32-Ransom.XeroWare
  if "%filemd5%" == "45 3a 78 91 0a 83 4a d8 83 0a b9 de e7 c1 83 e3" set threat=Win32-Ransom.XiaoBa
  if "%filemd5%" == "d0 e8 7f d3 56 97 9a ff 2a 42 09 57 ec 07 0d 54" set threat=Win32-Ransom.Zeoticus
  if "%filemd5%" == "b1 90 29 68 92 d3 44 14 1a ec c5 38 f6 e4 40 01" set threat=Win32-Ransom.Zeoticus
  if "%filemd5%" == "6b e6 53 cd 2f 91 72 54 37 36 e3 f5 3a ef cd 54" set threat=Win32-Ransom.Ziggy
  if "%filemd5%" == "db a6 df b2 73 3a a1 c9 2e 7e e7 62 ea 66 66 65" set threat=Win32-RAT.Agent
  if "%filemd5%" == "85 2c f7 6a b9 2c 6a a9 03 c5 fc 9a 78 b6 0d 9c" set threat=Win32-RAT.DarkKomet
  if "%filemd5%" == "96 30 5f 55 42 86 f7 84 d9 92 8c 49 90 45 c3 d6" set threat=Win32-RAT.NanoCore
  if "%filemd5%" == "c1 7c ad 86 80 51 b0 7e 56 1f 08 d9 de 11 b6 70" set threat=Win32-RAT.Quasar
  if "%filemd5%" == "e9 50 81 4f 0a 29 f9 59 37 50 f7 ea 42 06 e2 dd" set threat=Win32-RBot
  if "%filemd5%" == "51 b3 30 e6 b3 04 76 5f 3a b6 17 8a 99 ea 87 f4" set threat=Win32-Rogue.AntivirusBEST
  if "%filemd5%" == "a8 f0 1f df 7b 09 78 11 f7 c6 40 55 cb 04 1b 88" set threat=Win32-Rogue.AntiVirusGold
  if "%filemd5%" == "1f 13 39 6f a5 9d 38 eb e7 6c cc 58 7c cb 11 bb" set threat=Win32-Rogue.NavaShield
  if "%filemd5%" == "0b f2 ab 80 9f c3 7e 37 6b 11 a2 1a 13 0c 3a d7" set threat=Win32-Rogue.PCKeeper
  if "%filemd5%" == "3c 05 5b ec e3 a6 d7 14 5b 51 bb a9 3b 05 ec 8c" set threat=Win32-Rogue.SpyAxe
  if "%filemd5%" == "c8 99 f9 3e 8b 75 3f ed d0 68 ef 3f e2 ed b0 fd" set threat=Win32-Rogue.SpySheriff
  if "%filemd5%" == "7e 56 ea 2b a6 6f 0b a2 db 65 91 c4 28 92 38 72" set threat=Win32-Rogue.SpywareQuake
  if "%filemd5%" == "04 86 6e cb 33 e4 49 6a 8c fd cd ad 6c 80 10 81" set threat=Win32-Rogue.SystemSecurity
  if "%filemd5%" == "8a fa d0 4b bd 53 80 d6 67 45 e2 5e 30 c0 a8 9f" set threat=Win32-Rogue.VirBytes
  if "%filemd5%" == "ab 27 c3 cc 0a b7 6a d0 6f 5c 02 b0 88 01 4c c8" set threat=Win32-Rogue.VirBytes
  if "%filemd5%" == "db c9 d1 c4 75 e3 a4 1f fc b8 e7 ac 78 02 af 21" set threat=Win32-Rogue.VirusProtectPro
  if "%filemd5%" == "e0 33 88 af 3a 89 9c 09 32 23 0d 06 1e 31 af 16" set threat=Win32-Rogue.WindowsPolicePro
  if "%filemd5%" == "49 69 3f a1 51 55 b8 b0 b4 ee 5b b8 13 5f d0 b9" set threat=Win32-Rogue.Winhound
  if "%filemd5%" == "ba 37 11 89 ab 70 09 0c 29 8d 92 d5 02 e1 30 e5" set threat=Win32-Rogue.WolframAntivirus
  if "%filemd5%" == "3e dd 49 00 66 ea 4a 31 2e 6f a6 dc 42 0a f6 c6" set threat=Win32-Rootkit.TDSS
  if "%filemd5%" == "f6 57 02 65 92 e2 ae 04 54 5f 8a b1 f4 64 1a 97" set threat=Win32-Rootkit.ZeroAccess
  if "%filemd5%" == "ce 69 a4 70 25 27 e0 fc 32 38 73 e0 8f 99 b2 af" set threat=Win32-Sality
  if "%filemd5%" == "f3 16 be c0 84 81 f4 5d f9 93 70 2b 64 71 43 de" set threat=Win32-Sality
  if "%filemd5%" == "9d ec 49 c9 ca f3 6f 68 f2 2b 39 77 8e c9 3f 18" set threat=Win32-Sality
  if "%filemd5%" == "25 aa 9b b5 49 ec c7 bb 61 00 f8 d1 79 45 25 08" set threat=Win32-Sality
  if "%filemd5%" == "14 50 d3 b0 6b 90 85 6d db a1 fc 58 a7 bf bb fc" set threat=Win32-Sality
  if "%filemd5%" == "ab e4 33 21 24 b4 37 00 a0 9d d8 68 ac 4d 11 a1" set threat=Win32-Sality
  if "%filemd5%" == "a7 3c 16 cc d0 b9 c4 f2 0b c7 84 2e dd 90 fc 20" set threat=Win32-Sasser.A
  if "%filemd5%" == "1a 2c 0e 61 30 85 0f 8f d9 b9 b5 30 94 13 cd 00" set threat=Win32-Sasser.B
  if "%filemd5%" == "0e 97 3c ba 35 97 e3 39 d1 d8 48 1d 9a 35 8b 87" set threat=Win32-Sasser.B
  if "%filemd5%" == "32 a9 f7 ad 4b ed a3 79 5f 16 40 04 db 3c ff f8" set threat=Win32-Sasser.C
  if "%filemd5%" == "86 bb 42 89 d3 4f 9c 26 c9 32 36 84 f6 9e 49 b1" set threat=Win32-Sasser.G
  if "%filemd5%" == "f2 57 a5 f1 9f 61 6f 63 78 50 52 cb 3b 31 69 27" set threat=Win32-Shoerec
  if "%filemd5%" == "5d 82 00 d6 99 e5 7e d8 ce 75 ad 22 fe 9f 59 8f" set threat=Win32-SnakeKeylogger
  if "%filemd5%" == "fd b0 57 61 a7 ed a3 f1 82 48 50 3f 2c 97 d6 97" set threat=Win32-Sobig.E
  if "%filemd5%" == "d3 a8 b3 dc de 44 b8 1c 0e 69 cc 2a 8a 36 e8 44" set threat=Win32-Sobig.E
  if "%filemd5%" == "ca 22 1b 0f e0 3c 1f 0a 75 6a aa dd 55 e1 cc 43" set threat=Win32-SonicGatherBattle
  if "%filemd5%" == "5c 8d f4 e2 f2 ea 5b 69 f1 c6 b6 5f 7b 6f 73 c0" set threat=Win32-Spyware.Zbot
  if "%filemd5%" == "38 61 55 80 0f 4c 16 9a 6b 81 19 43 0c e7 88 1f" set threat=Win32-Spyware.Zbot
  if "%filemd5%" == "aa b2 e7 79 4e ec af 39 d2 f1 5c 3d e4 36 48 8d" set threat=Win32-StartPage
  if "%filemd5%" == "b4 42 9d 77 58 67 98 06 4b 56 b0 09 9f 0c cd 49" set threat=Win32-Stuxnet.A
  if "%filemd5%" == "70 b5 a2 41 74 c9 2e 90 33 a6 11 c4 6d 03 de a8" set threat=Win32-Supern0va
  if "%filemd5%" == "06 8e 06 ae 07 fd 6f 5d e1 b7 fa a4 61 fd f3 f7" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "9d 0d e6 7a 5c 84 1f fc 67 ef a7 a1 72 3f 41 dd" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "7f ae ac 65 e9 cb 2f df 40 d1 70 bb 50 8e fd 83" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "f0 fe 0b 13 b1 5e fa 14 72 ae de 79 fb 5d 90 96" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "62 05 27 ce 57 7a f7 8e 34 cb e9 c4 a0 7c 9f 97" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "7a ab e4 1a e2 77 ab f2 9e df 0c 3d d2 06 69 b6" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "78 2a 7e 6a a7 07 d9 8c 7c df 9e 41 8e 4a 7f ae" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "47 ed ec c9 f8 30 c2 29 f1 75 22 02 87 bf 91 f0" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "a1 a7 6c 17 03 03 0b 3b 3b cd 1d 15 e3 2f b7 a6" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "b5 52 c5 4b f0 04 7a 43 0a 28 54 58 cf a6 0a 43" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "00 8a 0b 7f cf bc 65 f0 14 fa 85 ec 01 33 2a 76" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "c0 9c f4 31 21 67 fa 96 83 d8 e8 73 30 04 b7 e6" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "03 f6 9c 46 00 2a e2 77 22 2c 0c 32 b9 28 c4 c0" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "85 f3 04 84 98 9c 9f b2 40 e7 ad 0d 3d bd 5b 25" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "30 58 85 26 80 b6 13 ec b1 35 8c 0f 35 50 68 27" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "1a 66 a0 29 72 8c 19 25 4d 52 13 53 4e e5 92 5d" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "f8 76 b8 ce 91 d5 72 54 7e a7 91 04 f3 f2 4f 48" set threat=Win32-Trojan.Agent
  if "%filemd5%" == "de 90 eb bd 62 0c b9 1d 30 9a 78 3a 3c 8b 8c 32" set threat=Win32-Trojan.Alerta
  if "%filemd5%" == "e8 ed 8a af 35 e6 05 9b a2 85 04 c1 9f f5 0b ab" set threat=Win32-Trojan.Alerta
  if "%filemd5%" == "d5 40 ca 29 e9 ea 33 f1 31 e4 ce 46 74 d1 08 5f" set threat=Win32-Trojan.Denes
  if "%filemd5%" == "6e db fc c6 44 5a f5 82 63 0f a2 4d a5 f9 03 35" set threat=Win32-Trojan.Denes
  if "%filemd5%" == "f5 97 17 fb 8f 2a 9a d3 e5 f7 16 40 94 0f 1c 08" set threat=Win32-Trojan.Emotet
  if "%filemd5%" == "d3 ff 42 73 09 6c 13 af a8 8c 71 31 c4 14 f9 3b" set threat=Win32-Trojan.Emotet
  if "%filemd5%" == "8d 7e a5 5f f7 f8 74 c0 98 b2 3c a2 ad f4 0b 71" set threat=Win32-Trojan.Emotet
  if "%filemd5%" == "ac 54 76 ae 5a 15 a0 98 1e 7e 56 f9 51 60 1c 82" set threat=Win32-Trojan.Icefog
  if "%filemd5%" == "07 18 75 df 86 3f 4a ea 3c 89 fb e4 1b 52 d1 9c" set threat=Win32-Trojan.Klone
  if "%filemd5%" == "a7 bc f7 ea 8e 9f 3f 36 eb fb 85 b8 23 e3 9d 91" set threat=Win32-Trojan.MEMZ
  if "%filemd5%" == "19 db ec 50 73 5b 5f 2a 72 d4 19 9c 4e 18 49 60" set threat=Win32-Trojan.MEMZ
  if "%filemd5%" == "38 ff 71 c1 de e2 a9 ad d6 7f 1e db 1a 30 ff 8c" set threat=Win32-Trojan.MrsMajor
  if "%filemd5%" == "83 c5 20 4b ac b4 9b 83 af ec ea 31 be af 1f 63" set threat=Win32-Trojan.MrsMajor
  if "%filemd5%" == "45 0f 49 42 6b 45 19 ec aa c8 cd 04 81 4c 03 a4" set threat=Win32-Trojan.MrsMajor
  if "%filemd5%" == "8f 1b 40 26 4a 0e df 5a 95 88 d4 3a 8d 67 df e7" set threat=Win32-Trojan.MuddyWater
  if "%filemd5%" == "04 25 1a 49 a2 40 db f6 09 75 ac 26 2f c6 ae b7" set threat=Win32-Trojan.PCToaster
  if "%filemd5%" == "01 81 85 02 39 cd 26 b8 fb 8b 72 af b0 e9 5e ac" set threat=Win32-Trojan.Poweliks
  if "%filemd5%" == "de 51 6f bb c0 9f ca dd 95 39 c2 80 9c f4 ff 9b" set threat=Win32-Trojan.Reconyc
  if "%filemd5%" == "33 6e ff e8 44 da ab 0e f3 88 fe 60 02 81 17 de" set threat=Win32-Trojan.Remtasu
  if "%filemd5%" == "a9 c6 7b 0f c1 c8 16 32 f1 34 f2 bd f4 67 8e 21" set threat=Win32-Trojan.Resonate
  if "%filemd5%" == "ad 4d 5e da b2 ce 61 e9 22 44 dc ec c0 49 b8 66" set threat=Win32-Trojan.Resonate
  if "%filemd5%" == "8e 90 ad 82 52 86 72 49 cc 5c be e3 19 9d ef 2f" set threat=Win32-Trojan.SpyAnyTime.D
  if "%filemd5%" == "b9 70 9a 07 05 9b b0 80 57 34 39 80 e9 79 de 2f" set threat=Win32-Trojan.Tremp
  if "%filemd5%" == "3d 3e 08 ad 3a 8f 3b 35 b9 a1 0a a6 c5 7b 29 0f" set threat=Win32-Trojan.Trickbot
  if "%filemd5%" == "40 22 84 58 ca 45 5d 28 e3 39 51 a2 f3 84 42 09" set threat=Win32-Trojan.Zika
  if "%filemd5%" == "13 23 8b f4 b2 8c a4 f1 31 dd 4a 53 23 69 9f 68" set threat=Win32-Unruy
  if "%filemd5%" == "e5 e7 96 89 db e8 3e 59 ee 5b 6a 22 5d e9 be d8" set threat=Win32-Virlock
  if "%filemd5%" == "cf de f9 29 1b e8 bf e8 42 3e c5 2d 6f b3 b8 cb" set threat=Win32-Virlock
  if "%filemd5%" == "89 0f 9b d0 04 6e ef 19 ed 81 32 2d 19 65 f6 42" set threat=Win32-Virlock
  if "%filemd5%" == "a6 60 c8 17 17 65 9f 5b 2d d4 fe 7a 8a fb 54 2d" set threat=Win32-Virlock
  if "%filemd5%" == "da b8 55 a4 40 4d d5 57 54 54 ba 74 1f 65 b1 32" set threat=Win32-Virlock
  if "%filemd5%" == "00 df 6b 2a 7c 3b 3f d4 28 8f 29 ae 80 9e 0f 53" set threat=Win32-Virlock
  if "%filemd5%" == "fd 5d 3c 1a de 28 5f 3b 54 9e 80 27 8a b9 07 19" set threat=Win32-Virlock
  if "%filemd5%" == "a8 51 a9 68 f7 17 ed 30 a9 da ea 4d 88 fd d8 df" set threat=Win32-Virut
  if "%filemd5%" == "84 b9 6a 3d 44 c0 8a 22 1d 13 93 1c e8 e3 fd 4e" set threat=Win32-Virut
  if "%filemd5%" == "53 29 50 cd 94 48 93 c7 36 71 9f de 46 3a 10 31" set threat=Win32-Vtflooder
  if "%filemd5%" == "25 27 29 b2 30 4c dc 2e 91 24 8c ea 56 72 41 eb" set threat=Win32-Wallpaper
  if "%filemd5%" == "e7 9d 0b 1a 34 27 12 ea 9b 96 10 40 86 14 9d 65" set threat=Win32-Winevar
  if "%filemd5%" == "02 73 ed 44 d5 87 4d c3 03 90 15 16 3b c8 91 32" set threat=Win32-Worm.Agent
  if "%filemd5%" == "39 c8 5a 0d 84 7a a2 1c 7d ed d6 9d ca 7a e9 bc" set threat=Win32-Worm.Badtrans
  if "%filemd5%" == "6f 57 67 ec 5a 9c c6 f7 d1 95 dd e3 c3 93 91 20" set threat=Win32-Worm.CodeRed.A
  if "%filemd5%" == "0b ba 28 8e 55 ed 34 b5 eb c7 6f 86 5a 53 2c bf" set threat=Win32-Worm.CodeRed.A
  if "%filemd5%" == "fd cd a5 5b 16 42 6a 6f ed 53 d9 19 e3 1b 3d 23" set threat=Win32-Worm.Dumaru.A
  if "%filemd5%" == "a8 9c 0e d6 ef 75 17 9a db 6f 52 24 01 02 b9 b2" set threat=Win32-Worm.Fizzer.A
  if "%filemd5%" == "02 dd 0e aa 96 49 a1 1e 55 fa 54 67 fa 4b 8e f8" set threat=Win32-Worm.Happy99
  if "%filemd5%" == "c8 f7 94 fe 1e 95 64 24 df a1 68 67 91 fa ec ba" set threat=Win32-Worm.Lentin
  if "%filemd5%" == "bd 86 e7 62 7d 29 10 d6 7b f3 d9 49 86 27 54 5a" set threat=Win32-Worm.Mimail
  if "%filemd5%" == "da 9d ba 70 de 70 dc 43 d6 53 5f 29 75 ce c6 8d" set threat=Win32-Worm.Naked
  if "%filemd5%" == "71 c9 81 d4 f5 31 6c 3a d1 de ef e4 8f dd b9 4a" set threat=Win32-Worm.Opaserv
  if "%filemd5%" == "63 db 72 35 16 db 09 bf 83 79 38 25 4e 8c b1 d3" set threat=Win32-Worm.Silver
  if "%filemd5%" == "ba 6b d0 ba 81 12 a7 5e b7 0e b3 01 71 7a a9 bc" set threat=Win32-Worm.Totilix
  if "%filemd5%" == "7b c3 22 d9 59 51 df e1 6e 8c f4 7e e5 86 e9 09" set threat=Win95-CIH
  if "%filemd5%" == "dc 40 29 6f 43 5a 8b 3a c6 c0 24 d6 dc ee cd df" set threat=Win95-CIH
  if "%filemd5%" == "99 d3 fd 29 85 01 2d 43 c3 d5 32 cf 1f 70 b3 42" set threat=Win95-CIH

  if "%threat%" == """" goto md5_safe

:md5_threat
  cls
  color cf
  title Your action is required - Protectish Total Security
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo Warning! Malware was found inside this file.
  echo.
  echo Reported by: MD5 Scan
  echo.
  echo Threat: %threat%
  echo.
  echo Path: %file%
  echo.
  echo (DELETE) - deletes the file
  echo (QUARANTINE) - quarantines the file
  echo (TERMINATE) - forcibly terminates all tasks provided by the threat, then returns to this point
  echo (IGNORE) - ignores the threat
  echo.
  find /i /c "Behavior" pts_autoaction2.txt >NUL
  if %errorlevel% equ 0 (
    set /p choice="Enter your choice: "
    if /i "%choice%" == "delete" goto delete
    if /i "%choice%" == "ignore" goto ignore
    if /i "%choice%" == "quarantine" goto quarantine
    if /i "%choice%" == "terminate" goto terminate
    echo.
    echo %choice% is not a valid choice.
    pause
    goto md5_threat
  )
  find /i /c "None" pts_autoaction2.txt >NUL
  if %errorlevel% equ 0 (
    set /p choice="Enter your choice: "
    if /i "%choice%" == "delete" goto delete
    if /i "%choice%" == "ignore" goto ignore
    if /i "%choice%" == "quarantine" goto quarantine
    if /i "%choice%" == "terminate" goto terminate
    echo.
    echo %choice% is not a valid choice.
    pause
    goto md5_threat
  )
  find /i /c "Delete" pts_autoaction2.txt >NUL
  if %errorlevel% equ 0 (
    del %file%
    echo Threat deleted. (Automatic action)
    pause
    if "%dirscan%" == "true" (
      set threat=""""
      set /a filenumber=%filenumber%+1
      goto scan
    )
    goto start
  )
  find /i /c "Quarantine" pts_autoaction2.txt >NUL
  if %errorlevel% equ 0 (
    cd %ptsdir%
    if not exist quarant\ mkdir quarant
    move /Y %file% quarant\%threat%.protquarant
    cipher /e quarant\%threat%.protquarant
    echo Threat quarantined. (Automatic action)
    pause
    if "%dirscan%" == "true" (
      set threat=""""
      set /a filenumber=%filenumber%+1
      goto scan
    )
    goto start
  )
  echo An error occured at pts_autoaction2.txt.
  echo Contact Protectish support.
  pause
  exit

:delete
  echo.
  del %file%
  echo Threat deleted.
  pause
  if "%dirscan%" == "true" (
    set threat=""""
    set /a filenumber=%filenumber%+1
    goto scan
  )
  goto start

:quarantine
  echo.
  cd %ptsdir%
  if not exist quarant\ mkdir quarant
  move /Y %file% quarant\%threat%.protquarant
  cipher /e quarant\%threat%.protquarant
  echo Threat quarantined.
  pause
  if "%dirscan%" == "true" (
    set threat=""""
    set /a filenumber=%filenumber%+1
    goto scan
  )
  goto start

:terminate
  echo.
  taskkill /f /im %file%
  echo Tasks killed.
  goto md5_threat

:ignore
  echo.
  echo Threat ignored.
  pause
  if "%dirscan%" == "true" (
    set threat=""""
    set /a filenumber=%filenumber%+1
    goto scan
  )
  goto start

:md5_safe
  cls
  title Behavior Scan Pending - Protectish Total Security
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  if "%dirscan%" == "true" (
    echo Now scanning: %file%
    echo.
  )
  echo MD5 Scan: Successful
  echo Behavior Scan: Pending
  echo Suspicious Actions Scan: Waiting

  find /i /c "EICAR-STANDARD-ANTIVIRUS-TEST-FILE" %file% > NUL
  if %errorlevel% == 0 set threat=NotAVirus-EICAR.Test.File
  find /i /c "PROTECTISH-TOTAL-SECURITY-TEST-FILE!-HOORAY!" %file% > NUL
  if %errorlevel% == 0 set threat=NotAVirus-PTS.Test.File
  find /i /c "BrowserAssistant.Init-3-5" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Adware.BrowserAssistant
  find /i /c "Init7.dll" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Adware.BrowserAssistant
  find /i /c "TImageMargins8vI" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Adware.DealPly
  find /i /c "http://megadowl.com/terms-ru.html" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-ICLoader
  find /i /c "zincite" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-MyDoom
  find /i /c "! Best regards 2 Tommy Salo. [Nov-2005] yours [Dziadulja Apanas]" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Neshta
  find /i /c "Visit our web service at caforssztxqzf2nm.onion" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.BadRabbit
  find /i /c "DANGEROUS_RANSOM" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Dangerous
  find /i /c "NitroRansomware.exe" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.DiscordNitro
  find /i /c "decrypter.files@mail.ru" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Explorer
  find /i /c "set_encrypted_key" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "get_encrypted_key" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "chromeKey" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "FileEncryptor" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic  
  find /i /c "KillCtrlAltDelete" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "MaxFilesizeToEncryptInBytes" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "I made a payment, now give me back my files!" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "Download Tor browser - https://www.torproject.org/" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "hidden tear" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "It starts out slowly then increases rapidly." %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Jigsaw
  find /i /c "Now, let's start and enjoy our little game together!" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Jigsaw
  find /i /c "If you turn off your computer or try to close me, when I start next time" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Jigsaw
  find /i /c "Local\Kangaroo_Ransomware" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Kangaroo
  find /i /c "KRAKEN ENCRYPTED UNIQUE KEY" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Kraken
  find /i /c "MindSystemNotRansomWare" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.MindSystem
  find /i /c "aes_key_rand" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Ragnarok
  find /i /c "http://wannadie.altervista.org/" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Rogue
  find /i /c "ShellLocker.My.Resources" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.ShellLocker
  find /i /c "Brouillettebusiness@outlook.com" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Sodinokibi
  find /i /c "Injecting into process" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-RAT.Generic
  find /i /c "Opening process..." %file% > NUL
  if %errorlevel% == 0 set threat=Win32-RAT.Generic
  find /i /c "Failed to inject" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-RAT.Generic
  find /i /c "j.maxmind.com" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Rootkit.ZeroAccess
  find /i /c "\SnakeKeylogger\" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-SnakeKeylogger
  find /i /c "-------- Snake Keylogger --------" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-SnakeKeylogger
  find /i /c "The software you just executed is considered malware. This malware will harm your computer and makes it unusable. If you are seeing this message without knowing what you just executed, simply press" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Trojan.MEMZ


  if "%threat%" == """" (
    if "%dirscan%" == "true" (
      set /a filenumber=filenumber+1
      goto scan
    ) else (
      goto behavior_safe
    )
  )

:behavior_threat
 rem if exist pts_analytics1.txt (
 rem   for /f "tokens=1*delims=:" %%G in ('findstr /n "^" pts_analytics1.txt') do if %%G equ 3 set email=%%H
 rem   rem for /f "tokens=1*delims=:" %%G in ('findstr /n "^" pts_analytics1.txt') do if %%G equ 4 set smtp=%%H
 rem   Malware %threat% found inside %filemd5% by Behavior Scan. > blatmsg.txt
 rem   blat -f %email% -to martinekmatej@gmail.com -s "Protectish: Malware was found" -body "%filemd5% was classified as %threat% by Behavior Scan."
 rem )
  cls
  color cf
  title Your action is required - Protectish Total Security
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo Warning! Malware was found inside this file.
  echo We recommend you to report %filemd5% to Protectish staff.
  echo.
  echo Reported by: Behavior Scan
  echo Note: Behavior Scan doesn't always have to be accurate.
  echo.
  echo Threat: %threat%
  echo.
  echo Path: %file%
  echo.
  echo (DELETE) - deletes the file
  echo (QUARANTINE) - quarantines the file
  echo (TERMINATE) - forcibly terminates all tasks provided by the threat, then returns to this point
  echo (IGNORE) - ignores the threat
  echo.
  set /p choice="Enter your choice: "
  if /i "%choice%" == "delete" goto delete
  if /i "%choice%" == "ignore" goto ignore
  if /i "%choice%" == "quarantine" goto quarantine
  if /i "%choice%" == "terminate" goto terminate_behavior
  echo.
  echo %choice% is not a valid choice.
  pause
  goto behavior_threat
  rem find /i /c "MD5" pts_autoaction2.txt >NUL
  rem if %errorlevel% equ 0 (
  rem  set /p choice="Enter your choice: "
  rem  if /i "%choice%" == "delete" goto delete
  rem  if /i "%choice%" == "ignore" goto ignore
  rem  if /i "%choice%" == "quarantine" goto quarantine
  rem  if /i "%choice%" == "terminate" goto terminate
  rem  echo.
  rem  echo %choice% is not a valid choice.
  rem  pause
  rem  goto md5_threat
  rem )
  rem find /i /c "None" pts_autoaction2.txt
  rem if %errorlevel% equ 0 (
  rem   set /p choice="Enter your choice: "
  rem   if /i "%choice%" == "delete" goto delete
  rem   if /i "%choice%" == "ignore" goto ignore
  rem   if /i "%choice%" == "quarantine" goto quarantine
  rem   if /i "%choice%" == "terminate" goto terminate
  rem  echo.
  rem  echo %choice% is not a valid choice.
  rem  pause
  rem  goto md5_threat
  rem )
  rem find /i /c "Delete" pts_autoaction2.txt
  rem if %errorlevel% equ 0 (
  rem  del %file%
  rem  echo Threat deleted. (Automatic action)
  rem  pause
  rem  if "%dirscan%" == "true" (
  rem    set threat=""""
  rem    set /a filenumber=%filenumber%+1
  rem    goto scan
  rem  )
  rem  goto start
  rem )
  rem find /i /c "Quarantine" pts_autoaction2.txt
  rem if %errorlevel% equ 0 (
  rem  cd %ptsdir%
  rem  if not exist quarant\ mkdir quarant
  rem  move /Y %file% quarant\%threat%.protquarant
  rem  cipher /e quarant\%threat%.protquarant
  rem  echo Threat quarantined. (Automatic action)
  rem  pause
  rem  if "%dirscan%" == "true" (
  rem    set threat=""""
  rem    set /a filenumber=%filenumber%+1
  rem    goto scan
  rem  )
  rem  goto start
  rem )
  rem echo An error occured at pts_autoaction2.txt.
  rem echo Contact Protectish support.
  rem pause
  rem exit

:terminate_behavior
  echo.
  taskkill /f /im %file%
  echo Tasks killed.
  goto behavior_threat
  
:behavior_safe
  cls
  title Behavior Scan Pending - Protectish Total Security
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  if "%dirscan%" == "true" (
    echo Now scanning: %file%
    echo.
  )
  echo MD5 Scan: Successful
  echo Behavior Scan: Successful
  echo Suspicious Actions Scan: Pending

  find /i /c "git clone http" %file% > NUL
  if %errorlevel% == 0 set threat=Exploitation-Of-CVE-2017-9800
  find /i /c "git clone ssh" %file% > NUL
  if %errorlevel% == 0 set threat=Exploitation-Of-CVE-2017-9800

  if "%threat%" == """" (
    if "%dirscan%" == "true" (
      set /a filenumber=filenumber+1
      goto scan
    ) else (
      goto safe
    )
  )

:action_threat
  rem if exist pts_analytics1.txt (
    rem for /f "tokens=1*delims=:" %%G in ('findstr /n "^" pts_analytics1.txt') do if %%G equ 3 set email=%%H
    rem echo Set objEmail = CreateObject("CDO.Message") > pts_analytics1.vbs
    rem echo objEmail.From = "%email%" >> pts_analytics1.vbs
    rem echo objEmail.To = "martinekmatej@gmail.com" >> pts_analytics1.vbs
    rem echo objEmail.Subject = "Protectish Automated Message - New malware hash was found" >> pts_analytics1.vbs
    rem echo objEmail.Textbody = "Hash %filemd5% contains suspicious content classified as %threat% by suspicious actions scan." >> pts_analytics1.vbs
    rem echo objEmail.Send >> pts_analytics1.vbs
    rem pause
    rem pts_analytics1.vbs
    rem del pts_analytics1.vbs
  rem )
  cls
  color cf
  title Your action is required - Protectish Total Security
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo Warning! Malware was found inside this file.
  echo We recommend you to report %filemd5% to Protectish staff.
  echo.
  echo Reported by: Suspicious Actions Scan
  echo Note: Suspicious Actions Scan doesn't always have to be accurate.
  echo.
  echo Action: %threat%
  echo.
  echo Path: %file%
  echo.
  echo (DELETE) - deletes the file
  echo (QUARANTINE) - quarantines the file
  echo (TERMINATE) - forcibly terminates all tasks provided by the threat, then returns to this point
  echo (IGNORE) - ignores the threat
  echo.
  set /p choice="Enter your choice: "
  if /i "%choice%" == "delete" goto delete
  if /i "%choice%" == "ignore" goto ignore
  if /i "%choice%" == "quarantine" goto quarantine
  if /i "%choice%" == "terminate" goto terminate_action
  echo.
  echo %choice% is not a valid choice.
  pause
  goto action_threat
  rem find /i /c "MD5" pts_autoaction2.txt >NUL
  rem if %errorlevel% equ 0 (
  rem  set /p choice="Enter your choice: "
  rem  if /i "%choice%" == "delete" goto delete
  rem  if /i "%choice%" == "ignore" goto ignore
  rem  if /i "%choice%" == "quarantine" goto quarantine
  rem  if /i "%choice%" == "terminate" goto terminate
  rem  echo.
  rem  echo %choice% is not a valid choice.
  rem  pause
  rem  goto md5_threat
  rem )
  rem find /i /c "None" pts_autoaction2.txt
  rem if %errorlevel% equ 0 (
  rem   set /p choice="Enter your choice: "
  rem   if /i "%choice%" == "delete" goto delete
  rem   if /i "%choice%" == "ignore" goto ignore
  rem   if /i "%choice%" == "quarantine" goto quarantine
  rem   if /i "%choice%" == "terminate" goto terminate
  rem  echo.
  rem  echo %choice% is not a valid choice.
  rem  pause
  rem  goto md5_threat
  rem )
  rem find /i /c "Delete" pts_autoaction2.txt
  rem if %errorlevel% equ 0 (
  rem  del %file%
  rem  echo Threat deleted. (Automatic action)
  rem  pause
  rem  if "%dirscan%" == "true" (
  rem    set threat=""""
  rem    set /a filenumber=%filenumber%+1
  rem    goto scan
  rem  )
  rem  goto start
  rem )
  rem find /i /c "Quarantine" pts_autoaction2.txt
  rem if %errorlevel% equ 0 (
  rem  cd %ptsdir%
  rem  if not exist quarant\ mkdir quarant
  rem  move /Y %file% quarant\%threat%.protquarant
  rem  cipher /e quarant\%threat%.protquarant
  rem  echo Threat quarantined. (Automatic action)
  rem  pause
  rem  if "%dirscan%" == "true" (
  rem    set threat=""""
  rem    set /a filenumber=%filenumber%+1
  rem    goto scan
  rem  )
  rem  goto start
  rem )
  rem echo An error occured at pts_autoaction2.txt.
  rem echo Contact Protectish support.
  rem pause
  rem exit

:terminate_action
  echo.
  taskkill /f /im %file%
  echo Tasks killed.
  goto action_threat

:safe
  cls
  color af
  title Scan finished - Protectish Total Security
  if "%dirscan%" == "true" del files.txt
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo No virus detected. That's perfect! :)
  pause
  goto start
