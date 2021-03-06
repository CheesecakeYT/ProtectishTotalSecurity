@echo off
rem License key is PTS_PJF5G4DAZ5R3

set ptsdir=%cd%
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

rem if not exist pts_analytics1.txt (
rem   set /a msgcount=msgcount+1
rem )
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
  rem echo You can also type "trial" to activate a 7-day free trial of Protectish
  rem echo Total Security, containing all of its functions, if you haven't already.
  rem echo This message will appear again in 7 days if you do so.
  rem echo.
  set /p check_key="If you do have a license key, insert it here: "
  if "%check_key%" == "SetAdminModeOn" (
    echo Admin mode activated.
    pause
    goto start
  )
  if /i "%check_key%" == "trial" (
    rem for /F "tokens=2" %%i in ('date /t') do set mydate=%%i
    rem echo %mydate%
    
    set day=%date:~4,5%
    set month=%date:~7,8%
    set year=%date:~10,13%
    echo.%day%
    echo.%month%
    echo.%year%
    
    pause
    echo.%DATE%
    pause
    exit

  )
  aaaa > check_license_key.txt
  echo %check_key% > check_license_key.txt
  @CertUtil -hashfile check_license_key.txt MD5 > md5.txt
  for /f "tokens=1*delims=:" %%G in ('findstr /n "^" md5.txt') do if %%G equ 2 set check_key=%%H
  echo %check_key% > check_license_key.txt
  @CertUtil -hashfile check_license_key.txt MD5 > md5.txt
  for /f "tokens=1*delims=:" %%G in ('findstr /n "^" md5.txt') do if %%G equ 2 set check_key=%%H
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
  rem echo You can also type "trial" to activate a 7-day free trial of Protectish
  rem echo Total Security, containing all of its functions, if you haven't already.
  rem echo This message will appear again in 7 days if you do so.
  rem echo.
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
  cd %ptsdir%
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
  echo Protectish Total Security
  echo.
  echo Making you safe
  echo.
  echo.
  echo You're fully protected.
  echo You have %msgcount% messages.
  echo.
  echo (FILE) - scan file
  echo (DIR) - scan directory
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
  if /i "%choice%" == "dir" goto dir
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
  for /f %%A in ('dir /a-d-s-h /b /s ^| find /v /c ""') do set cnt=%%A
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
  if "%dirscan%" == "true" (
    for /f "tokens=1*delims=:" %%G in ('findstr /n "^" files.txt') do if %%G equ %filenumber% set file=%%H
    @CertUtil -hashfile %file% MD5 > md5.txt

    for /f "tokens=1*delims=:" %%G in ('findstr /n "^" md5.txt') do if %%G equ 2 set filemd5=%%H
    del md5.txt

    if "%cnt%" lss "%filenumber%" (
      goto safe
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
  if "%filemd5%" == "19 bf d5 e8 67 e2 0c d7 a9 1a 17 f7 21 28 5e b8" set threat=VBS-BubbleBoy
  if "%filemd5%" == "25 01 5a e9 b5 9d bd f5 0b 74 5c 33 4e 15 66 3f" set threat=VBS-LoveLetter.A
  if "%filemd5%" == "6f 71 0c 4e 4b b8 14 ea fa d0 24 a8 54 be cd f9" set threat=VBS-LoveLetter.B
  if "%filemd5%" == "8e 2c 09 7c a6 23 ca 32 72 3d 57 96 8b 9d 25 25" set threat=VBS-LoveLetter.C
  if "%filemd5%" == "84 e4 51 0a ec 4d 76 c5 d4 31 ab 32 d7 45 8f 8c" set threat=VBS-LoveLetter.D
  if "%filemd5%" == "63 cb 86 f8 d5 a1 56 0d af aa 25 22 d9 f8 86 14" set threat=VBS-LoveLetter.E
  if "%filemd5%" == "54 5a 15 43 07 a9 0e 8e 33 c3 0b 7c 7d 00 8d 16" set threat=VBS-Melissa.A
  if "%filemd5%" == "82 3d b9 b3 27 57 a7 fa 05 45 2c b9 58 e9 6e 50" set threat=VBS-Melissa.B
  if "%filemd5%" == "3f 76 a6 9e 1f d9 bb 3f a2 52 a3 ce d1 5e ba 72" set threat=VBS-Melissa.C
  if "%filemd5%" == "9d 7f 91 6d f5 05 16 ac 67 05 eb 0c 00 78 38 20" set threat=VBS-Melissa.D
  if "%filemd5%" == "3a d9 58 ad d8 a0 7e a3 a0 77 ec 97 68 6c 67 d6" set threat=VBS-Trojan.Gansom
  if "%filemd5%" == "db 6d 18 71 03 bf 80 f7 3c 22 0e ea c3 bc b8 04" set threat=VBS-Worm.Bumerang
  if "%filemd5%" == "66 3c 9d 4d 45 cf 93 3c 60 76 3f 36 19 be 50 35" set threat=Win32-Adware.Adposhel
  if "%filemd5%" == "d5 de ce 3f 46 a6 b0 5b 6b d8 98 78 da be fb 63" set threat=Win32-Adware.Adstantinko
  if "%filemd5%" == "65 25 9c 11 e1 ff 8d 04 0f 9e c5 85 24 a4 7f 02" set threat=Win32-Adware.Bonzi.A
  if "%filemd5%" == "06 d8 7d 4c 89 c7 6c b1 bc b2 f5 a5 fc 40 97 d1" set threat=Win32-Adware.Bonzi.B
  if "%filemd5%" == "9f 8c 96 41 5f bf d3 d1 84 83 d1 df ad 62 26 38" set threat=Win32-Adware.BrowserAssistant.A
  if "%filemd5%" == "18 26 0d 74 0e 62 31 6f 68 2a 8c db e4 e9 4a 48" set threat=Win32-Adware.BrowserAssistant.B
  if "%filemd5%" == "88 f5 81 c1 cb 1d 63 4a 5b d3 a5 38 c8 47 e8 0f" set threat=Win32-Adware.ClientConnect
  if "%filemd5%" == "eb d2 a7 d3 ad 49 24 f4 c8 da 98 c5 e5 d6 8f 3b" set threat=Win32-Adware.Conduit.A
  if "%filemd5%" == "55 32 06 3c 46 5c e3 35 db 98 a2 69 0d e9 80 c8" set threat=Win32-Adware.Conduit.B
  if "%filemd5%" == "0b e1 4c 6f e4 bb 0b 2d ba f3 a8 61 91 72 64 80" set threat=Win32-Adware.Conduit.C
  if "%filemd5%" == "45 5e 61 a2 cf 37 f7 21 0d f6 85 e2 b7 7b fb e3" set threat=Win32-Adware.Conduit.D
  if "%filemd5%" == "9b b5 68 80 14 29 4b a8 1d 69 ad c9 a7 97 57 55" set threat=Win32-Adware.Conduit.E
  if "%filemd5%" == "2c 1a d7 84 12 69 40 d1 54 84 1d 33 45 a2 d0 6b" set threat=Win32-Adware.DealPly.A
  if "%filemd5%" == "57 f2 51 09 b2 55 d0 4c 05 fb 7f da d1 62 b5 ee" set threat=Win32-Adware.DealPly.A
  if "%filemd5%" == "e0 69 fd bd 26 84 a8 fa ef 23 a6 96 05 09 d9 93" set threat=Win32-Adware.DownloadAssistant
  if "%filemd5%" == "07 16 8b d3 7f 9c 1c 19 c9 61 65 b9 eb d5 c6 9c" set threat=Win32-Adware.DownloadHelper
  if "%filemd5%" == "96 a2 c3 0d 76 3d 41 0c 7c f5 f8 bd a7 7f 29 64" set threat=Win32-Adware.InstallCore.A
  if "%filemd5%" == "ab 1c 44 a2 f3 49 40 5a 46 9b 9d 3a 1c b5 35 90" set threat=Win32-Adware.InstallCore.B
  if "%filemd5%" == "79 e1 67 48 cc 1c 72 58 25 d5 c5 99 1a 82 fd 89" set threat=Win32-Adware.Machaer
  if "%filemd5%" == "b1 da c6 3a f1 39 bc f3 08 c9 1b e5 b9 dd 7b 0f" set threat=Win32-Adware.Mobogenie
  if "%filemd5%" == "86 b0 fa bb a4 6a 22 7a 96 fc 84 4c b1 02 70 d5" set threat=Win32-Adware.MyWebSearch.A
  if "%filemd5%" == "d0 7f 6d c1 22 fb 0e ca 6f b2 00 c9 9b 02 ad 1b" set threat=Win32-Adware.MyWebSearch.B
  if "%filemd5%" == "dc 87 a7 8a bc 76 5a 6d b5 0d 2c ec 91 7c b2 24" set threat=Win32-Adware.MyWebSearch.C
  if "%filemd5%" == "0e be b3 ed a3 e2 aa f5 02 4a a6 7b 7f 49 4c f1" set threat=Win32-Adware.OpenCandy.A
  if "%filemd5%" == "14 64 da b8 53 df ac 75 09 7e 6f 81 fa 06 0c 9a" set threat=Win32-Adware.OpenCandy.B
  if "%filemd5%" == "9e a3 4e e3 75 8a a9 41 5d cd 3b 16 d1 ea d8 5e" set threat=Win32-Adware.OpenCandy.C
  if "%filemd5%" == "d7 7a 5b f2 0c ca 45 5c 0c f9 13 2c 65 33 d6 43" set threat=Win32-Adware.PriceGong
  if "%filemd5%" == "98 2e 03 ae 76 af 8d f3 ed ef 04 43 d4 e4 81 f8" set threat=Win32-Adware.Rugo
  if "%filemd5%" == "fe 2c 6c 15 73 99 82 97 9a f0 de 3f c7 e3 4c 8d" set threat=Win32-Adware.StartSurf.A
  if "%filemd5%" == "9e 95 62 4d 2f 99 55 0c bf 77 cd ab 49 85 df 96" set threat=Win32-Adware.StartSurf.B
  if "%filemd5%" == "0a f5 b9 ca 01 e4 9e 09 fd be 43 8c 7a 50 42 db" set threat=Win32-Adware.Swizzor
  if "%filemd5%" == "73 c3 46 6b 67 79 34 46 52 ef 97 20 9a b4 db 1a" set threat=Win32-Anywork
  if "%filemd5%" == "28 65 6c 94 b4 80 ec 5f fa 40 40 68 25 96 52 c3" set threat=Win32-AutoRun
  if "%filemd5%" == "9e 28 4c 15 f0 31 ab 67 5b 1a 89 86 4f f3 d0 d5" set threat=Win32-Backdoor.Azbreg.A
  if "%filemd5%" == "08 4e d8 22 3b b9 e8 7f 72 99 ea 8a 40 e3 43 65" set threat=Win32-Backdoor.Azbreg.B
  if "%filemd5%" == "29 47 7e 36 de 37 42 7b 0d 40 1f 9f 37 b9 7a d5" set threat=Win32-Backdoor.Azbreg.C
  if "%filemd5%" == "df ae 62 b7 f1 1e eb 45 a6 90 99 eb 85 59 2d 92" set threat=Win32-Backdoor.Clampi.A
  if "%filemd5%" == "1e d9 8f 81 1f 3e 13 93 ad 17 1c 70 a7 5c c4 27" set threat=Win32-Backdoor.Clampi.B
  if "%filemd5%" == "63 c0 76 ed 73 97 2a 21 c3 54 63 3d 43 b9 38 65" set threat=Win32-Backdoor.Clampi.C
  if "%filemd5%" == "5f 93 8e c8 dc 3a e7 f1 9c 8a 97 0c 6b 95 05 9b" set threat=Win32-Backdoor.Daserf.A
  if "%filemd5%" == "d8 be 46 cc 46 42 fa ac 37 d8 16 7f ed 43 39 50" set threat=Win32-Backdoor.Daserf.B
  if "%filemd5%" == "ef 69 4b 89 ad 7a dd b9 a1 6b b6 f2 6f 1e fa f7" set threat=Win32-Backdoor.FakeCCleaner
  if "%filemd5%" == "0c d4 62 4c 95 bc c1 ff da 1a 63 6e be e4 0b 6b" set threat=Win32-Backdoor.Farfli
  if "%filemd5%" == "db c2 bd 34 6f f8 1a 0c 5f c1 6f a6 83 b2 6a 36" set threat=Win32-Backdoor.FedEx
  if "%filemd5%" == "24 b2 57 3e 59 e4 f1 6c 7b f3 54 48 bd 03 e5 a7" set threat=Win32-Backdoor.Hupigon.A
  if "%filemd5%" == "30 b2 9f d4 75 30 53 10 cd 14 8a cd 0f 17 4c 70" set threat=Win32-Backdoor.Hupigon.B
  if "%filemd5%" == "64 87 6d 5d e7 06 1e 92 5e 29 f6 a0 c8 7c ea 9b" set threat=Win32-Backdoor.Konus
  if "%filemd5%" == "3d af f5 90 29 8e f3 68 8d 43 a2 9b 9d ef 10 9a" set threat=Win32-Backdoor.NanoBot
  if "%filemd5%" == "6a 49 33 e4 a6 e9 88 81 1b 95 73 c5 43 79 f8 8d" set threat=Win32-Backdoor.NJRat
  if "%filemd5%" == "d4 07 55 9e 9d f5 43 20 e4 14 ff 6d 6c 5d cc b6" set threat=Win32-Backdoor.Prorat.A
  if "%filemd5%" == "27 0b a3 d7 c6 98 6a da e1 e3 da 12 99 39 ba 9d" set threat=Win32-Backdoor.Prorat.B
  if "%filemd5%" == "bf 30 21 3b 41 d8 1b 53 06 13 06 eb af 8c 16 ee" set threat=Win32-Backdoor.Sixer
  if "%filemd5%" == "00 fb 27 df d5 74 71 ab 32 77 01 f4 c2 3e 82 8f" set threat=Win32-Backdoor.Theef.A
  if "%filemd5%" == "d2 b5 5a 2d 03 ba ee fd 9b ac b2 7b 58 25 0b 35" set threat=Win32-Backdoor.Theef.B
  if "%filemd5%" == "ec 40 cc aa d6 3f 88 55 d8 de 31 a4 2b 7c 67 ac" set threat=Win32-Backdoor.Tofsee
  if "%filemd5%" == "53 5c dc a9 ac f5 2c 1c 46 fb 75 5a 38 5e c3 ec" set threat=Win32-Backdoor.Xtreme
  if "%filemd5%" == "db 19 1b ba 75 d9 ec a8 0f bb f4 fa 02 52 d2 4e" set threat=Win32-Blackbat
  if "%filemd5%" == "15 b8 93 9a 07 1e 23 c9 11 f9 17 d8 76 05 32 e3" set threat=Win32-BlastButton
  if "%filemd5%" == "86 76 21 0e 62 46 94 82 01 aa 01 4d b4 71 de 90" set threat=Win32-Blaster
  if "%filemd5%" == "f3 e4 fb 7f 22 3b ef 58 2c 63 e5 b8 7e 14 40 e7" set threat=Win32-Bloored
  if "%filemd5%" == "68 ab 07 e4 e7 79 ed 8b 5b 71 b7 c5 5f 33 b0 87" set threat=Win32-Blueballs
  if "%filemd5%" == "6a 48 53 cd 05 84 dc 90 06 7e 15 af b4 3c 49 62" set threat=Win32-ChilledWindows
  if "%filemd5%" == "da 4b da 83 ff f7 8e 29 44 19 7d 57 32 0d 4d 7c" set threat=Win32-ClassicVirus
  if "%filemd5%" == "3a 70 25 17 61 a4 ac c0 53 d3 9f 2c 5f 61 3b 42" set threat=Win32-CodecPack
  if "%filemd5%" == "c1 49 2e f9 be 34 a8 74 3b 52 4b 1a 0a 3e 07 7c" set threat=Win32-CoinMiner.Agent.A
  if "%filemd5%" == "92 ed 22 d3 89 26 26 ce 4b c0 50 cb 5f a7 e5 2d" set threat=Win32-CoinMiner.Agent.B
  if "%filemd5%" == "ab a2 d8 6e d1 7f 58 7e b6 d5 7e 6c 75 f6 4f 05" set threat=Win32-CoinMiner.Agent.C
  if "%filemd5%" == "02 72 f4 4a 25 a1 46 90 5c 26 34 bd 2e 7c 90 b7" set threat=Win32-CoinMiner.Agent.D
  if "%filemd5%" == "fc 72 4e b2 89 4f 34 a3 ac a4 b9 52 d2 f8 16 cd" set threat=Win32-CoinMiner.UAParser
  if "%filemd5%" == "1c d6 3b c5 4f 81 7b 94 fe fe 44 d5 ce 02 26 27" set threat=Win32-CoinMiner.XMRig
  if "%filemd5%" == "a7 79 70 08 8c 74 75 1c 25 a5 6e 33 81 80 b2 92" set threat=Win32-Colors.A
  if "%filemd5%" == "24 e2 14 09 ef 6b 38 2d 72 51 0c 3a 1e e2 f3 04" set threat=Win32-Colors.B
  if "%filemd5%" == "3a fe b8 e9 af 02 a3 3f f7 1b f2 f6 75 1c ae 3a" set threat=Win32-CPUMiner
  if "%filemd5%" == "3a f2 98 63 3c c2 f3 c3 f3 5a f9 6e 93 0c 98 44" set threat=Win32-Dabber
  if "%filemd5%" == "de 8b 54 a9 38 ac 18 f1 5c ad 80 4d 79 a0 e1 9d" set threat=Win32-Danabot
  if "%filemd5%" == "fa ff 81 02 d2 b2 13 8e 78 89 6d 8f 00 7d 0f 3f" set threat=Win32-DAZLoader.A
  if "%filemd5%" == "3a ac a5 72 5b e3 78 5d b6 c0 b6 25 a9 30 8e cf" set threat=Win32-DAZLoader.B
  if "%filemd5%" == "03 fb de 8b 89 9a f8 07 6d 64 2d 38 05 87 2a 9d" set threat=Win32-Floxif.A
  if "%filemd5%" == "75 74 cf 2c 64 f3 51 61 ab 12 92 e2 f5 32 aa bf" set threat=Win32-Floxif.B
  if "%filemd5%" == "2a b0 e1 a6 f9 ef 53 a9 73 20 ed 07 99 44 b4 28" set threat=Win32-Floxif.C
  if "%filemd5%" == "44 51 20 7a a3 fe 02 1d c2 bf c6 83 d5 7b a5 a1" set threat=Win32-Gogo
  if "%filemd5%" == "e2 55 12 40 5a cd fa 4e 2d 71 7a 56 69 d3 0d 54" set threat=Win32-Gullible
  if "%filemd5%" == "66 92 96 d7 ec b1 56 52 5c 56 ba b3 e2 42 50 90" set threat=Win32-Hacktool.Agent.A
  if "%filemd5%" == "93 0d 50 48 55 61 ca 56 be 84 a5 63 0c 71 52 84" set threat=Win32-Hacktool.Agent.B
  if "%filemd5%" == "0f fa 32 0f bb f7 5c 9c bf c0 87 5f ac 20 95 c7" set threat=Win32-Hacktool.Binder
  if "%filemd5%" == "40 67 ae a4 c2 12 5d 2d 0a 80 aa eb be c6 86 b6" set threat=Win32-IceIX
  if "%filemd5%" == "bc 5e 27 7b 6d 94 36 3d dc 11 19 7f 71 43 e9 4b" set threat=Win32-ICLoader
  if "%filemd5%" == "01 29 da b7 29 15 cc 20 bf 10 4c 09 08 85 47 c4" set threat=Win32-Ipamor.A
  if "%filemd5%" == "41 dd 2b f0 50 ce 71 95 ad 59 4a eb d3 f3 af c4" set threat=Win32-Ipamor.B
  if "%filemd5%" == "28 a9 3d ff 57 ed 7b 94 ef 51 a3 ad 2f 1a 9a 41" set threat=Win32-Ipamor.C
  if "%filemd5%" == "36 94 6f af c9 15 38 84 60 0a 6f bb 4e 8e 09 a1" set threat=Win32-Joke.Auge
  if "%filemd5%" == "df d1 74 1b 9d 4c 16 a5 4f 3d 61 04 d4 66 3f c8" set threat=Win32-Joke.Disco
  if "%filemd5%" == "d9 ba ac 37 4c c9 6e 41 c9 f8 6c 66 9e 53 f6 1c" set threat=Win32-Joke.Melter
  if "%filemd5%" == "47 84 e4 2c 3b 15 d1 a1 41 a5 e0 c8 ab c1 20 5c" set threat=Win32-Joke.Melting
  if "%filemd5%" == "4e 33 66 78 55 87 2e cd a9 5a 11 71 b4 0a ae 9a" set threat=Win32-Klez.A
  if "%filemd5%" == "f9 59 81 82 9c a6 60 e8 4f 1d 33 bd fa 9e 2a 28" set threat=Win32-Klez.B
  if "%filemd5%" == "a5 a4 8f bc 21 18 03 db 3d cc 9b 91 7d 5d 32 0f" set threat=Win32-Kolabc
  if "%filemd5%" == "03 ba eb a6 b4 22 43 71 cc a7 fa 6f 95 ae 61 c0" set threat=Win32-Krap
  if "%filemd5%" == "f2 cc 60 64 3a cd 7c 5b 2b ef a8 62 94 5c 99 cb" set threat=Win32-Kriz.A
  if "%filemd5%" == "fb 23 aa e4 12 65 0b 84 f6 a3 70 81 e3 9c 68 79" set threat=Win32-Kriz.B
  if "%filemd5%" == "cc a7 de f7 19 45 4d d2 2e c3 51 99 12 97 88 5b" set threat=Win32-Lmir
  if "%filemd5%" == "98 90 34 9f e3 c6 8f 59 23 b2 93 47 bb a0 21 a4" set threat=Win32-Magistr.A
  if "%filemd5%" == "8b 7c 9a 4c 20 df 8a 4b eb f5 89 a6 d0 d4 f7 18" set threat=Win32-Magistr.B
  if "%filemd5%" == "ee db 0f 58 db e2 22 53 26 fd f2 4b ff ed e4 32" set threat=Win32-Magistr.C
  if "%filemd5%" == "c1 e8 72 9b 5e bc cf d2 bc 35 bf 7f a6 01 c0 21" set threat=Win32-Magistr.D
  if "%filemd5%" == "c1 8a b9 29 d2 aa d5 77 40 73 70 c8 bb d9 55 b1" set threat=Win32-Magistr.E
  if "%filemd5%" == "97 cb fe 43 c1 80 40 79 3c 33 90 90 4b 7a 4f 70" set threat=Win32-Magistr.F
  if "%filemd5%" == "39 2d 04 0d 33 bf 55 66 d2 c0 9e 36 bb d9 52 19" set threat=Win32-Magistr.G
  if "%filemd5%" == "27 0a 18 65 23 24 45 51 41 ef 0a 49 9c 40 03 3c" set threat=Win32-Magistr.H
  if "%filemd5%" == "ff 34 7a 45 0c 28 20 67 ab bf 92 8f 59 2e 2c 07" set threat=Win32-Magistr.I
  if "%filemd5%" == "a3 80 4d 2c df dd 2d 44 a6 f3 46 4d 64 57 b9 ca" set threat=Win32-Magistr.J
  if "%filemd5%" == "74 d5 64 ab 7f d4 4e 7d fc 41 11 24 32 e6 43 14" set threat=Win32-Magistr.Corrupt
  if "%filemd5%" == "01 99 ae 48 b0 97 cf e3 ae 92 4c 60 5a e9 8f 41" set threat=Win32-Microjoin
  if "%filemd5%" == "46 85 ee e7 10 ce 45 e5 34 02 77 87 54 6e 0a 56" set threat=Win32-Mofksys.A
  if "%filemd5%" == "6f 19 a3 ab bc fd 79 4a 9c 17 65 79 90 27 d5 52" set threat=Win32-Mofksys.B
  if "%filemd5%" == "7a 96 3a 73 6a 1c 21 5e 9a b3 52 af c4 be 0a 85" set threat=Win32-Mofksys.C
  if "%filemd5%" == "ae 9f c2 81 2c 2a 6d 55 c9 f6 6b 62 69 63 63 9f" set threat=Win32-MSILZilla
  if "%filemd5%" == "6b 78 82 e1 97 90 13 ae 92 ee 1b 8c ea 9f bd 10" set threat=Win32-MyDoom.A
  if "%filemd5%" == "53 df 39 09 23 94 74 15 14 bc 05 0f 3d 6a 06 a9" set threat=Win32-MyDoom.B
  if "%filemd5%" == "0d e0 8e 8f a1 36 9b 15 ef 29 2f 93 7a 8e e1 de" set threat=Win32-MyDoom.C
  if "%filemd5%" == "5b f4 59 42 4c 81 03 f7 5b 17 65 92 0a 6d ac 0c" set threat=Win32-MyDoom.D
  if "%filemd5%" == "9f 31 84 31 d8 2b 39 9e f8 b1 6f bf ec e9 c4 a6" set threat=Win32-MyDoom.E
  if "%filemd5%" == "26 15 70 17 f5 a8 8d 38 73 9f 98 11 04 c5 77 f7" set threat=Win32-MyDoom.F
  if "%filemd5%" == "07 86 6c 5c 66 56 4d 1f 01 6d c5 28 bf b8 8d 3c" set threat=Win32-MyDoom.G
  if "%filemd5%" == "29 fa 8a 13 f3 b0 eb c8 fb 40 de 2f c6 86 cc 17" set threat=Win32-MyDoom.H
  if "%filemd5%" == "ee c0 03 d5 97 e1 0e 93 ee 10 da 2d 9e a4 eb 49" set threat=Win32-MyDoom.I
  if "%filemd5%" == "b0 fe 74 71 9b 1b 64 7e 20 56 64 19 31 90 7f 4a" set threat=Win32-MyDoom.J
  if "%filemd5%" == "c9 08 bb d9 26 25 5c 4e 47 bd cb 14 dd b4 e5 7e" set threat=Win32-MyDoom.K
  if "%filemd5%" == "db 86 34 6e 2d 68 88 81 b2 de df 5a 7a 4a 29 07" set threat=Win32-MyDoom.L
  if "%filemd5%" == "b7 e5 a5 fa ce 2f 5c 64 94 e0 4b 1e db 48 d2 ef" set threat=Win32-MyDoom.M
  if "%filemd5%" == "50 52 a2 4d 8f 3e 90 fc bb 3b c4 42 c0 53 ca d4" set threat=Win32-MyDoom.N
  if "%filemd5%" == "61 5e 48 2d 9f c7 61 97 48 38 bf 6b 66 26 6a 67" set threat=Win32-MyDoom.O
  if "%filemd5%" == "56 25 07 35 12 10 ad 0a f3 66 21 ad fb 69 a0 32" set threat=Win32-MyDoom.P
  if "%filemd5%" == "9c 87 6d e6 17 41 80 7a 07 7f 84 2a 11 1c 25 f1" set threat=Win32-MyDoom.Q
  if "%filemd5%" == "f9 bb 63 a2 55 a4 43 ad f4 4a fe 6f b8 5f 80 f6" set threat=Win32-MyDoom.R
  if "%filemd5%" == "41 9e 93 7e 1f b9 2f 1b a0 6e aa fe 3a e5 39 cd" set threat=Win32-MyDoom.S
  if "%filemd5%" == "fb 15 69 b5 a3 26 64 44 d6 76 e5 f8 2d 6b ac 85" set threat=Win32-MyDoom.Doomjuice.A
  if "%filemd5%" == "6f 51 0e 97 91 43 a5 63 71 a4 f8 02 c8 ff d2 0d" set threat=Win32-MyDoom.Doomjuice.B
  if "%filemd5%" == "b7 84 72 31 7b ae 5e 4f 97 9f f4 78 0e 3c 44 eb" set threat=Win32-MyDoom.Doomjuice.C
  if "%filemd5%" == "32 d2 4e 64 2e 87 af fc 9e b6 92 ef 4b f9 77 72" set threat=Win32-MyDoom.Doomjuice.D
  if "%filemd5%" == "01 6b 56 35 43 fe 2a d1 00 f4 54 f3 9c 77 94 5b" set threat=Win32-MyDoom.Doomjuice.E
  if "%filemd5%" == "8e 2f 86 e3 6f a9 e5 e6 54 93 5e c0 b9 52 64 ce" set threat=Win32-MyDoom.Doomjuice.F
  if "%filemd5%" == "94 ec 47 42 8d ab b4 92 af 96 75 6e 7c 95 c6 44" set threat=Win32-MyPics
  if "%filemd5%" == "0e 8f 2e 37 c1 66 e3 c4 01 7e 7a eb 1b 5b f1 9f" set threat=Win32-Necurs
  if "%filemd5%" == "c9 67 9e 89 c8 2e 02 5b 98 55 18 98 76 f9 27 61" set threat=Win32-Neshta.A
  if "%filemd5%" == "bf bc 3b 53 3d 55 ae 5a 53 ad 27 78 5a 95 3a 53" set threat=Win32-Neshta.B
  if "%filemd5%" == "18 bf a3 66 cb 42 5f aa dd 39 3a e1 76 13 0c ae" set threat=Win32-Neshta.C
  if "%filemd5%" == "11 79 08 a0 e6 3d a0 e9 ce 13 a3 8e b1 2f b4 0f" set threat=Win32-Neshta.D
  if "%filemd5%" == "f0 86 4b 70 31 04 57 87 2e 55 8f c5 d8 96 7f 01" set threat=Win32-Neshta.E
  if "%filemd5%" == "85 52 e2 f0 bb cd 7a ba 9d 0d f3 3a b8 65 93 f3" set threat=Win32-Neshta.F
  if "%filemd5%" == "44 6c 1e 5f 0b 5e 9d a0 df 06 b6 a3 49 53 9d 38" set threat=Win32-Neshta.G
  if "%filemd5%" == "5f 45 97 5d 56 43 3a c8 34 b6 53 45 49 12 7e 0d" set threat=Win32-Neshta.H
  if "%filemd5%" == "d5 e6 ad d0 3e ba 06 4b 4f b9 0e a5 82 72 de 32" set threat=Win32-Neshta.I
  if "%filemd5%" == "42 9b 58 65 69 91 5e d5 21 2a 26 09 4a 7f 60 c1" set threat=Win32-Neshta.J
  if "%filemd5%" == "64 2a 39 3a 5c 65 d2 02 18 0d f5 af 06 f2 9c 5a" set threat=Win32-Nimda.A
  if "%filemd5%" == "08 3d 59 7f 4b 8d e7 c2 a7 88 8d f0 e5 e3 9a 8a" set threat=Win32-Nimda.B
  if "%filemd5%" == "aa 9e ca 49 c7 22 ec 1b ab bc 21 55 f1 a9 10 39" set threat=Win32-Nimda.C
  if "%filemd5%" == "ef 4f df 65 fc 90 bf da 8d 1d 2a e6 d2 0a ff 60" set threat=Win32-NoEscape
  if "%filemd5%" == "ef df df 6d 3e c3 86 4b 47 fa 80 8f c8 00 65 78" set threat=Win32-Odious
  if "%filemd5%" == "19 65 6c 44 0d 11 46 e0 79 50 e5 e3 28 0a 0e 82" set threat=Win32-OpenInstall
  if "%filemd5%" == "2f 9a f2 30 d0 36 ba 31 09 49 94 5a e4 b1 a2 f4" set threat=Win32-Parite.A
  if "%filemd5%" == "68 5f 1c bd 4a f3 0a 1d 0c 25 f2 52 d3 99 a6 66" set threat=Win32-Parite.B
  if "%filemd5%" == "3e c0 23 c1 37 6f 3b 59 ec 56 ff 41 db 98 51 ec" set threat=Win32-Parite.C
  if "%filemd5%" == "53 66 c2 a6 62 cd dd 60 0d 93 e3 99 2b 8e d1 cd" set threat=Win32-Parite.D
  if "%filemd5%" == "73 d3 54 51 db fb ba 5a c0 51 d3 6f 09 5a 62 9f" set threat=Win32-Parrot.A
  if "%filemd5%" == "6c 1c fe 55 c4 c2 6f cf b8 3e 2d cb b9 a4 2e 89" set threat=Win32-Parrot.B
  if "%filemd5%" == "37 7c fd 5b 9a ad 24 73 d1 65 9a 5d ba d0 1d 90" set threat=Win32-Phishing.Agent.A
  if "%filemd5%" == "96 5e df d8 ee 48 b6 f7 40 4e 28 5c 36 4a 3b 76" set threat=Win32-Phishing.Agent.B
  if "%filemd5%" == "38 fa 31 3a f7 1c 68 fa d9 c1 9d 76 de 62 9d 8a" set threat=Win32-Phishing.Agent.C
  if "%filemd5%" == "aa 6e f4 ce 83 67 5c 8b 50 75 5f a1 7e 20 2e 70" set threat=Win32-Phishing.Agent.D
  if "%filemd5%" == "88 46 dd 18 f0 36 af 29 5c af 91 39 4e 98 82 10" set threat=Win32-Phishing.Agent.E
  if "%filemd5%" == "19 5a fd 53 c5 3b b4 69 f1 b4 03 5d 10 d9 72 9e" set threat=Win32-Phishing.Agent.F
  if "%filemd5%" == "19 be 34 76 08 20 78 ba c6 ef e8 32 e6 d7 fd d3" set threat=Win32-Phishing.Agent.G
  if "%filemd5%" == "2b d9 5b 73 8a 9a c6 b5 ef 48 23 fd 5f 8a 6a 0d" set threat=Win32-Phishing.Agent.H
  if "%filemd5%" == "8d ca af 93 83 aa 82 fa 30 1b 9f 01 46 29 01 c6" set threat=Win32-Phishing.Agent.I
  if "%filemd5%" == "ab 1b 92 e5 a9 39 4e 9a ab 2c a1 07 b7 5a cf 2b" set threat=Win32-Phishing.Agent.J
  if "%filemd5%" == "f3 0a a9 0e 04 99 8d d3 5a 78 2c a4 05 1b 3d b9" set threat=Win32-Phishing.Agent.K
  if "%filemd5%" == "c9 99 41 91 3a 3f 64 cf 34 04 4e cb 9c d0 4a 46" set threat=Win32-Phishing.Agent.L
  if "%filemd5%" == "6c 60 06 d7 46 71 ee 7d f1 55 8b d5 08 ee 32 41" set threat=Win32-Phishing.Agent.M
  if "%filemd5%" == "56 4b 3e 4a c5 81 0f 34 e5 05 03 cc c1 e1 ee e6" set threat=Win32-Phishing.Agent.N
  if "%filemd5%" == "bb f3 51 ba 5c 4c 37 6e 8e 4a 68 1b 25 40 18 dc" set threat=Win32-Phishing.Agent.O
  if "%filemd5%" == "0d e2 52 2f 90 ba b4 b3 d2 41 e3 83 7a de 94 1b" set threat=Win32-Phishing.Agent.P
  if "%filemd5%" == "2d 8c 68 2a 4f 0c d6 8f ac b8 e8 a9 c6 66 24 44" set threat=Win32-Phishing.Agent.Q
  if "%filemd5%" == "bd ab 23 98 3c 1b 12 ed e8 fc 14 25 5f b8 f8 02" set threat=Win32-Phishing.Agent.R
  if "%filemd5%" == "ff 1f 9b 02 ca 43 94 c1 d4 da e9 cd 4b 0a 0a 2d" set threat=Win32-Phishing.Agent.S
  if "%filemd5%" == "01 b0 47 29 51 cc 40 1f 91 24 6f e4 04 4e e6 44" set threat=Win32-Phishing.Agent.T
  if "%filemd5%" == "77 a2 e4 de 74 37 05 55 b4 58 62 79 15 1c a1 a0" set threat=Win32-Phishing.Agent.U
  if "%filemd5%" == "e7 34 ca 81 9d b7 f1 ec 25 b5 9d 5c da 95 23 44" set threat=Win32-Phishing.Agent.V
  if "%filemd5%" == "8e de 96 d4 0c 66 2d 6b ba 00 ec 4c fe 50 19 8d" set threat=Win32-Phishing.Agent.W
  if "%filemd5%" == "5f 61 df 28 25 67 13 e4 dc 37 9d e7 aa 40 50 c3" set threat=Win32-Phishing.Agent.X
  if "%filemd5%" == "36 1a 31 85 13 8d a9 09 8c 39 b9 7f 18 8b 82 56" set threat=Win32-Phishing.Agent.Y
  if "%filemd5%" == "7d f9 89 f6 1a fe f4 5a e1 e1 2e c5 d4 6d ee c9" set threat=Win32-Phishing.Agent.Z
  if "%filemd5%" == "fd c9 b4 a6 c5 07 52 54 ed 90 c9 48 7a 4d 5f de" set threat=Win32-Phishing.Agent.AA
  if "%filemd5%" == "1e ad 86 42 7f c0 76 f7 7f 21 cc b7 51 2d c8 b2" set threat=Win32-Picsys.A
  if "%filemd5%" == "06 ec be a1 47 d7 c1 3a b2 5b 9b 65 db 33 01 17" set threat=Win32-Picsys.B
  if "%filemd5%" == "71 56 14 e0 92 61 b3 9d fa 43 9f a1 32 6c 0c ec" set threat=Win32-Pikachu
  if "%filemd5%" == "6e 98 32 23 29 91 02 88 97 bf fc 65 eb ec ff da" set threat=Win32-PUP.FusionCore
  if "%filemd5%" == "7f a5 bf bd 35 19 49 db 2d d6 56 c2 be 73 dc 66" set threat=Win32-PUP.KMSPico
  if "%filemd5%" == "4a a5 0b ef 4c 3b 2a e1 4f 20 77 66 35 65 5b 50" set threat=Win32-Ramnit.A
  if "%filemd5%" == "ff 5e 1f 27 19 3c e5 1e ec 31 87 14 ef 03 8b ef" set threat=Win32-Ramnit.B
  if "%filemd5%" == "3d 67 d7 7d 4c 0f 38 6c 7b e6 a9 2f 41 50 c0 15" set threat=Win32-Ramnit.C
  if "%filemd5%" == "c5 c9 99 88 72 8c 55 02 82 ae 76 27 0b 64 9e a1" set threat=Win32-Ramnit.D
  if "%filemd5%" == "30 1e ca 91 f4 f3 d1 38 61 28 9f d8 27 38 96 67" set threat=Win32-Ramnit.E
  if "%filemd5%" == "23 cd ec f6 52 d3 99 15 fe 9e 2a 3f b5 7e 15 17" set threat=Win32-Ramnit.F
  if "%filemd5%" == "1c 12 64 41 d4 63 5b af 74 e6 fd 62 8b aa 67 14" set threat=Win32-Ransom.1337Locker
  if "%filemd5%" == "d4 45 2a df c4 1a 70 75 f5 e5 79 61 72 77 58 98" set threat=Win32-Ransom.AdamLocker
  if "%filemd5%" == "0e 61 e4 96 fc 21 8c 1c 6d c1 f5 64 0a 3a c7 e5" set threat=Win32-Ransom.Agent.A
  if "%filemd5%" == "af 4f d8 23 5d 26 56 40 1c 5a 95 2d ef 4f 99 0c" set threat=Win32-Ransom.Agent.B
  if "%filemd5%" == "58 a8 51 c3 5a 99 9c 9c f0 f5 77 d7 c5 de 3c 5c" set threat=Win32-Ransom.Agent.C
  if "%filemd5%" == "f7 18 65 97 30 8a db 3a 78 d3 56 e1 59 ce 18 b0" set threat=Win32-Ransom.Ako
  if "%filemd5%" == "98 c0 c4 e5 8a 97 cf 92 f9 c6 99 2e e6 5e 3f 0f" set threat=Win32-Ransom.Amnesia
  if "%filemd5%" == "ca 11 71 33 82 3c 73 bd b4 ad 3f 52 93 72 ea ae" set threat=Win32-Ransom.AnDROid
  if "%filemd5%" == "7a b9 1e 57 a1 e2 75 2c d8 ab ee 3d b1 08 53 c5" set threat=Win32-Ransom.AngryDuck
  if "%filemd5%" == "0f 74 32 87 c9 91 1b 4b 1c 72 6c 7c 7e dc af 7d" set threat=Win32-Ransom.Annabelle
  if "%filemd5%" == "bb ac d7 e5 e7 be 9d e0 18 1e 41 8d e9 c2 6c 5a" set threat=Win32-Ransom.Armage
  if "%filemd5%" == "ab f0 75 e0 8b 7f 97 02 c7 10 05 ae 30 99 ed 3e" set threat=Win32-Ransom.AvastVirusInfo
  if "%filemd5%" == "24 81 44 f9 24 d4 9b 37 31 2d a1 71 f1 4f 41 31" set threat=Win32-Ransom.AVCrypt
  if "%filemd5%" == "4f 3f 27 3a 71 70 e6 2f 7d 31 17 9c 4a ed 7a ab" set threat=Win32-Ransom.AWT.A
  if "%filemd5%" == "3f aa fd 23 f8 d4 b8 6d fb 35 29 d0 a1 5c 88 d5" set threat=Win32-Ransom.AWT.B
  if "%filemd5%" == "85 6b 19 af f2 37 ac e0 dd a3 ec fc 71 c0 97 67" set threat=Win32-Ransom.BadBlock
  if "%filemd5%" == "f1 94 25 31 86 f9 43 fc 2a e3 fc 7c 54 70 7c 00" set threat=Win32-Ransom.BadRabbit.A
  if "%filemd5%" == "2f e3 2d 2a 6b fc 72 d2 15 49 6b 05 5e 5a 53 ad" set threat=Win32-Ransom.BadRabbit.B
  if "%filemd5%" == "d9 fe 38 12 2b b0 8d 96 ef 0d e6 10 76 aa 49 45" set threat=Win32-Ransom.Bart
  if "%filemd5%" == "e2 fc 56 51 08 1c a5 3e bb 20 82 02 fa 4d 73 3a" set threat=Win32-Ransom.BigBossHorse
  if "%filemd5%" == "7a 25 24 df eb c6 86 de 23 9c 5f 73 4e 6b f8 28" set threat=Win32-Ransom.Birbware
  if "%filemd5%" == "50 a7 db 13 62 f5 53 4a 1b 6a db f9 cc be 9d 5b" set threat=Win32-Ransom.Bisquilla
  if "%filemd5%" == "8f db b5 54 51 ff b4 4d 0b ce f3 7e 13 23 4f 66" set threat=Win32-Ransom.BitPaymer
  if "%filemd5%" == "94 90 da d9 0c fc 13 6a 0a 30 44 3d f8 33 9e 02" set threat=Win32-Ransom.BlackClaw
  if "%filemd5%" == "50 c4 97 00 03 a8 4c ab 1b f2 63 46 31 fe 39 d7" set threat=Win32-Ransom.BlackMatter
  if "%filemd5%" == "3e ba b7 1c b7 1c a5 c4 75 20 2f 40 1d e0 08 c8" set threat=Win32-Ransom.BlackSun
  if "%filemd5%" == "75 04 e4 c1 94 81 c1 0a 67 a8 f4 c3 c1 09 ae 47" set threat=Win32-Ransom.BloodJaws.A
  if "%filemd5%" == "b2 dd 12 b7 17 a2 cf cc b2 7a e2 e8 39 df f9 f7" set threat=Win32-Ransom.BloodJaws.B
  if "%filemd5%" == "0f 55 c5 a3 c4 2d 6d 6c cf c2 95 7d 74 ff 6e b2" set threat=Win32-Ransom.BloodJaws.C
  if "%filemd5%" == "13 26 34 0d 8a 1b 99 2e a7 1b f4 84 05 50 d9 17" set threat=Win32-Ransom.BloodJaws.D
  if "%filemd5%" == "e6 42 55 6c bb 20 a9 7d 6c 4f 9d c2 5e a9 68 7f" set threat=Win32-Ransom.BloodJaws.E
  if "%filemd5%" == "16 ad a5 1d c0 a0 62 f8 60 8d a8 92 2b 0f c9 f8" set threat=Win32-Ransom.Blooper
  if "%filemd5%" == "92 66 05 0f 3c e5 ba 99 53 35 31 68 9e ae 7e 2f" set threat=Win32-Ransom.Bluerose
  if "%filemd5%" == "0f 74 3c 34 61 a9 fa 3e 60 f6 0d e8 44 3d a4 09" set threat=Win32-Ransom.Bot
  if "%filemd5%" == "ab 07 5e b2 ad 67 2b fa 36 99 62 c1 be 15 66 9a" set threat=Win32-Ransom.Braincrypt
  if "%filemd5%" == "27 14 58 8f b8 93 30 40 93 88 5c 23 f5 41 69 ee" set threat=Win32-Ransom.BrainLag
  if "%filemd5%" == "e6 0e 76 7e 33 ac f4 9c 02 56 8a 79 d9 cb da dd" set threat=Win32-Ransom.Buran
  if "%filemd5%" == "cf d2 d6 f1 89 b0 4d 42 61 80 07 fc 9c 54 03 52" set threat=Win32-Ransom.Cerber.A
  if "%filemd5%" == "db 9e ef 8a d5 41 98 59 c6 76 ac b4 ef 4a 5b 13" set threat=Win32-Ransom.Cerber.B
  if "%filemd5%" == "24 8c 96 0c 1a e5 41 03 de a5 bf ae 92 4f 28 e2" set threat=Win32-Ransom.ChaCha
  if "%filemd5%" == "e6 92 2a 68 fc a9 00 16 58 4a c4 8f c7 72 2e f8" set threat=Win32-Ransom.Chimera
  if "%filemd5%" == "84 f3 c3 7f db 67 23 84 a0 e0 82 84 ee ff 44 e4" set threat=Win32-Ransom.Cockblocker
  if "%filemd5%" == "88 d9 52 ef 3e 00 e2 5d e1 10 c7 c7 8f cc 57 99" set threat=Win32-Ransom.Comrade
  if "%filemd5%" == "c1 9c 2a d1 c0 b8 c1 35 e3 c9 f3 82 0c d8 87 ba" set threat=Win32-Ransom.ComradeCircle
  if "%filemd5%" == "9b 66 67 a8 51 11 d6 b3 85 71 db d7 0d d4 02 bb" set threat=Win32-Ransom.CLE
  if "%filemd5%" == "4f 41 35 fc 5b 67 6c 4d 40 7e a9 0d 89 08 e8 14" set threat=Win32-Ransom.Clown
  if "%filemd5%" == "02 d9 97 a8 98 31 b6 54 7a 28 4b aa 75 75 25 f2" set threat=Win32-Ransom.Cry9
  if "%filemd5%" == "10 99 19 9d c2 27 a8 a2 14 ff 9f 57 6c fd ec 1e" set threat=Win32-Ransom.CryForMe
  if "%filemd5%" == "7e 90 26 a1 de e0 80 ad 62 02 55 3f 79 73 d0 56" set threat=Win32-Ransom.Cryp70n1c
  if "%filemd5%" == "1b ba 89 d7 a8 b8 7f b7 5b 6a e5 95 85 f7 17 b6" set threat=Win32-Ransom.CryptoFinancial
  if "%filemd5%" == "86 24 f1 f4 e0 80 db 65 fd 5c 92 9d b2 51 e5 c2" set threat=Win32-Ransom.CryptoJacky
  if "%filemd5%" == "63 cc 40 d1 2e 49 ff b5 07 d9 1a f8 f7 a6 f0 82" set threat=Win32-Ransom.CryptoKill
  if "%filemd5%" == "bc 11 c9 3f 1b 6d c7 4b f4 80 4a 35 b3 4d 92 67" set threat=Win32-Ransom.Cryptolocker.A
  if "%filemd5%" == "12 7b 80 31 1e 32 0f ff a2 44 61 f7 35 66 d4 80" set threat=Win32-Ransom.Cryptolocker.B
  if "%filemd5%" == "48 18 2d 1c 42 a3 7c e2 49 25 bc c7 9d 14 7b f2" set threat=Win32-Ransom.CryptoMix
  if "%filemd5%" == "b1 8c 5a f6 96 e8 84 72 41 e4 c1 72 30 db 36 c9" set threat=Win32-Ransom.CryptoSpider
  if "%filemd5%" == "0c ff ee 26 6a 8f 14 10 31 58 46 5e 2e cd d2 c1" set threat=Win32-Ransom.CryptoWall.A
  if "%filemd5%" == "a6 cc dc 33 3a 50 5d 02 2f 13 49 a9 42 7d 26 a8" set threat=Win32-Ransom.CryptoWall.B
  if "%filemd5%" == "41 d4 ab 0d e7 f5 6c 1d 4b 38 fc 10 c2 55 18 f9" set threat=Win32-Ransom.CryptoWire
  if "%filemd5%" == "0a aa d9 fd 6d 9d e6 a1 89 e8 97 09 e0 52 f0 6b" set threat=Win32-Ransom.CrySiS
  if "%filemd5%" == "cd 4b 86 4a 78 da 9f d6 74 f0 99 ec 17 03 db b9" set threat=Win32-Ransom.Dablio
  if "%filemd5%" == "fb 75 bb 3d 76 e6 cb 60 0f 38 45 1b 67 2a 9e 4b" set threat=Win32-Ransom.Daddycrypt
  if "%filemd5%" == "5d 2a 7e 18 9d ef 04 ff 14 8e ee 04 e4 37 34 8d" set threat=Win32-Ransom.Damage
  if "%filemd5%" == "d5 f1 64 9c dd df 19 2d 4e d3 c2 89 bc 1e 95 f0" set threat=Win32-Ransom.Dangerous
  if "%filemd5%" == "fb 60 32 12 ae 67 78 9d e5 ce 5f 41 a6 d0 70 5e" set threat=Win32-Ransom.Danielthai
  if "%filemd5%" == "97 96 92 cd 7f c6 38 be ea 6e 9d 68 c7 52 f3 60" set threat=Win32-Ransom.Darkside
  if "%filemd5%" == "85 b9 39 4c ca 22 14 8e 3f c1 1d 2f 12 b4 8f 69" set threat=Win32-Ransom.Deadly
  if "%filemd5%" == "5d cc 44 9d 51 c8 64 ee b6 57 c5 46 79 eb 9d 20" set threat=Win32-Ransom.Defender
  if "%filemd5%" == "d1 3f 89 00 34 a6 8c cb 4a f4 e0 bf 51 e2 b5 ec" set threat=Win32-Ransom.Defray
  if "%filemd5%" == "fc 3d 3e 54 3a ef 4b 09 79 9c f7 8d 12 04 50 06" set threat=Win32-Ransom.Delphimorix
  if "%filemd5%" == "0a 7b 70 ef ba 0a a9 3d 4b c0 85 7b 87 ac 2f cb" set threat=Win32-Ransom.DeriaLock
  if "%filemd5%" == "7e 17 9d 06 4b 2d 20 b4 ea 5e 6d 49 2a bf 8f 2b" set threat=Win32-Ransom.DexLocker
  if "%filemd5%" == "d3 2e 4d 8b 42 38 cf cc 79 3e c3 b3 7c c9 a8 75" set threat=Win32-Ransom.Dharma
  if "%filemd5%" == "90 9e 45 aa d6 12 10 17 36 7d 4e 1b 32 d4 25 24" set threat=Win32-Ransom.DirtyDecrypt.A
  if "%filemd5%" == "d3 84 63 0e 47 60 a9 a2 61 b7 e6 0d 58 30 35 63" set threat=Win32-Ransom.DirtyDecrypt.B
  if "%filemd5%" == "58 48 b2 f7 a6 16 ad 1a 50 51 0c 55 fe 1a d2 be" set threat=Win32-Ransom.DirtyDecrypt.C
  if "%filemd5%" == "b0 4b e9 f4 97 16 1c 44 df 09 ec f3 cc 99 5a d6" set threat=Win32-Ransom.DirtyDecrypt.D
  if "%filemd5%" == "a6 0e 18 2d f1 97 6b 83 ad 71 17 d1 60 b3 dd 1d" set threat=Win32-Ransom.DirtyDecrypt.E
  if "%filemd5%" == "a7 0e 7e 7f aa 72 9c ed a6 28 0c 34 8d e7 17 31" set threat=Win32-Ransom.DirtyDecrypt.F
  if "%filemd5%" == "2f fc d2 d6 2a 57 32 93 c8 67 9b fd 60 66 77 b5" set threat=Win32-Ransom.DiscordNitro
  if "%filemd5%" == "8f 03 15 e9 0a 70 73 f1 5f 1d 56 3e 9b 16 44 80" set threat=Win32-Ransom.Dogge
  if "%filemd5%" == "76 16 57 30 83 eb 07 45 d8 50 f9 9b da 0c fa 5c" set threat=Win32-Ransom.Domino.A
  if "%filemd5%" == "78 96 94 07 38 9f d3 75 9f 54 00 fa f3 be 7f f3" set threat=Win32-Ransom.Domino.B
  if "%filemd5%" == "e7 6e ca 2f 7d 04 50 c8 44 17 a8 ac 24 2b 42 4c" set threat=Win32-Ransom.Donut.A
  if "%filemd5%" == "f5 28 9f 5e 2b 26 35 6e 63 f9 0a 07 05 5d 33 94" set threat=Win32-Ransom.Donut.B
  if "%filemd5%" == "13 c1 c6 8c 14 10 df 27 7f c3 7d 68 55 7b b4 3b" set threat=Win32-Ransom.DriedSister
  if "%filemd5%" == "14 41 b0 70 4b 07 d6 e8 f7 98 f6 68 4f af 0f 79" set threat=Win32-Ransom.EDA2.A
  if "%filemd5%" == "67 00 a8 20 40 81 a1 cc 2f 27 d3 71 e9 21 98 3d" set threat=Win32-Ransom.EDA2.B
  if "%filemd5%" == "99 c2 8c cc 3a d7 1f 20 9a ea b1 65 26 5d 78 63" set threat=Win32-Ransom.EdgeLocker
  if "%filemd5%" == "61 2b a5 a5 20 38 14 1d d5 c5 71 a4 b0 dc 6b 86" set threat=Win32-Ransom.EggLocker
  if "%filemd5%" == "3d 1c c4 ef 33 ba d0 e3 9c 75 7f ce 31 7e f8 2a" set threat=Win32-Ransom.Ekans.A
  if "%filemd5%" == "57 13 49 81 fb 5f 6d b5 db 8d 7f 30 51 50 3d c1" set threat=Win32-Ransom.Ekans.B
  if "%filemd5%" == "ed 3c 05 bd e9 f0 ea 0f 13 21 35 5b 03 ac 42 d0" set threat=Win32-Ransom.Ekans.C
  if "%filemd5%" == "64 9d e3 98 d8 d5 ad 64 d0 6c dc 98 2f 0e f2 5e" set threat=Win32-Ransom.Ekans.D
  if "%filemd5%" == "00 d1 e1 f6 af 06 d6 6c 81 73 b7 bf ea 7b b0 b5" set threat=Win32-Ransom.Exotic
  if "%filemd5%" == "a7 4b 25 0b 40 28 d5 39 7c c0 9f 62 7b b5 89 ab" set threat=Win32-Ransom.Explorer
  if "%filemd5%" == "a1 c5 80 2e 32 04 4c cd 39 f4 d7 b6 bd 68 6a 2a" set threat=Win32-Ransom.Extractor
  if "%filemd5%" == "ee 95 7c ff d7 8f db 40 6c 8c 87 da 0d 33 b1 6a" set threat=Win32-Ransom.Facebook
  if "%filemd5%" == "24 f3 2d a2 58 b8 c4 2c 71 ab fb 75 77 fb 35 a8" set threat=Win32-Ransom.FakeWannaCryptor.A
  if "%filemd5%" == "98 4a ac b6 8d bc 13 c0 e9 cb 3a a4 41 f6 97 44" set threat=Win32-Ransom.FakeWannaCryptor.B
  if "%filemd5%" == "94 32 8c a2 cb 87 23 0a 5b 0c 73 4e 23 21 e9 93" set threat=Win32-Ransom.Fantom
  if "%filemd5%" == "67 d5 ab da 3b e6 29 b8 20 34 1d 1b aa d6 68 e3" set threat=Win32-Ransom.FileSpider.A
  if "%filemd5%" == "fd d4 65 86 3a 4c 44 aa 67 85 54 33 2d 20 ae e3" set threat=Win32-Ransom.FileSpider.B
  if "%filemd5%" == "41 93 cb 08 82 4d be 0a b8 fc 90 eb 85 76 b8 19" set threat=Win32-Ransom.FireCrypt
  if "%filemd5%" == "14 a8 68 8c 52 7f 1a 12 db b0 4b 0d 45 81 35 67" set threat=Win32-Ransom.Flotera
  if "%filemd5%" == "3a 99 3d 38 ca 54 5c 2b 45 bb b4 9d fb 3d c2 46" set threat=Win32-Ransom.Foxxy
  if "%filemd5%" == "fa fa 32 c5 26 86 14 82 da 1b 49 49 32 69 f8 75" set threat=Win32-Ransom.FSociety
  if "%filemd5%" == "d3 87 09 92 ca 34 b0 dc 5c 3b cf c2 a1 9e 39 85" set threat=Win32-Ransom.GandCrab
  if "%filemd5%" == "82 40 1e ba de c1 06 50 cf 02 4b 0e a4 8e a6 94" set threat=Win32-Ransom.Good
  if "%filemd5%" == "5a 22 ab 88 6f 3f a7 c0 58 7c 4b 3d 7a e7 71 fb" set threat=Win32-Ransom.GoRansomPOC
  if "%filemd5%" == "bf 58 71 48 38 ed fc c1 35 a6 48 18 d3 66 75 47" set threat=Win32-Ransom.GPAA
  if "%filemd5%" == "92 b2 c0 3f 09 a0 7b 6c 12 23 3c 4c 21 32 c7 10" set threat=Win32-Ransom.GPCode.A
  if "%filemd5%" == "ec 71 b9 79 f8 e2 28 3c 1f 04 5e ea 42 2c 44 df" set threat=Win32-Ransom.GPCode.B
  if "%filemd5%" == "f9 da 7d cf 28 c9 e0 6e f9 b2 d3 94 67 c8 2f 70" set threat=Win32-Ransom.GX40
  if "%filemd5%" == "ea 7c 80 1a 66 b7 73 0c 67 7a f5 cb 5d f2 05 4b" set threat=Win32-Ransom.HappyNewYear
  if "%filemd5%" == "6e 1e 70 fa 33 4c eb c3 7a 3a 88 48 59 cf 2d d0" set threat=Win32-Ransom.Help50
  if "%filemd5%" == "88 f9 46 0b 8e d5 e6 30 0e ef d0 3e 40 79 0b ef" set threat=Win32-Ransom.Hese
  if "%filemd5%" == "61 07 5f ab a2 22 f9 7d 33 67 86 67 93 f0 90 7b" set threat=Win32-Ransom.Hermes
  if "%filemd5%" == "d9 d3 38 1b 79 fb 6e 35 ba 99 5b 4a 7a b5 8b 4f" set threat=Win32-Ransom.HiddenTearConficker
  if "%filemd5%" == "43 13 fd 0a 3d 2c be dd 45 70 23 09 31 83 3f e1" set threat=Win32-Ransom.HolyCrypt
  if "%filemd5%" == "4e 25 9c 5a 7a fe 86 eb 08 b4 5e ea d1 2d 4a f3" set threat=Win32-Ransom.Homework
  if "%filemd5%" == "3e 7b d2 12 6a d2 d0 56 b1 2a 90 6e c7 4f 4e 75" set threat=Win32-Ransom.Ims00ry
  if "%filemd5%" == "f9 a2 f3 e4 32 e3 53 88 4e e7 7e a6 d7 ef 3f f4" set threat=Win32-Ransom.InfoDot
  if "%filemd5%" == "2d c2 18 b4 3c b1 3d e2 78 f4 f0 68 c5 03 a6 e3" set threat=Win32-Ransom.Jamper
  if "%filemd5%" == "f7 ad ed 1f e8 38 c4 57 5a 9c 79 ed d4 c1 7c 6d" set threat=Win32-Ransom.Janelle.A
  if "%filemd5%" == "a4 3e e3 03 f6 e4 e6 87 00 36 da d6 66 6c bb d0" set threat=Win32-Ransom.Janelle.B
  if "%filemd5%" == "70 39 c0 de 73 72 92 11 9e ee a1 44 12 f7 8b cc" set threat=Win32-Ransom.JCrypt.A
  if "%filemd5%" == "24 1c 8c 8c 80 9f e6 70 f1 f6 ef 0f 7c 93 58 15" set threat=Win32-Ransom.JCrypt.B
  if "%filemd5%" == "58 4a ca a6 04 ae 63 3f 16 6b 77 bd 6a 25 88 8d" set threat=Win32-Ransom.JCrypt.C
  if "%filemd5%" == "70 11 7c fb 0d 65 26 21 da 77 c4 7c 95 2f b8 1a" set threat=Win32-Ransom.JCrypt.D
  if "%filemd5%" == "4b 1f 9f e1 13 d1 48 ff 80 10 d1 fa e5 6e 47 58" set threat=Win32-Ransom.JCrypt.E
  if "%filemd5%" == "e1 ff 64 f0 91 0b 1e 31 a1 2a 17 ec c9 17 32 50" set threat=Win32-Ransom.JCrypt.F
  if "%filemd5%" == "c5 50 05 fc ae 09 17 46 21 ec 4f 07 14 ff 0c 66" set threat=Win32-Ransom.JCrypt.G
  if "%filemd5%" == "fe ca cb cf 4a 61 34 7a 32 ac 24 ee da a1 0b 75" set threat=Win32-Ransom.JCrypt.H
  if "%filemd5%" == "fe f3 09 8a 47 48 6b 96 8d d4 73 7d d7 66 7c f0" set threat=Win32-Ransom.JCrypt.I
  if "%filemd5%" == "10 33 b7 e4 aa 5f 53 ec 26 a4 dd 89 f8 6f 3c d3" set threat=Win32-Ransom.JCrypt.J
  if "%filemd5%" == "1c ce f1 fb 6b 24 7f fd 5d 2a ae 21 06 d4 ed 7b" set threat=Win32-Ransom.JCrypt.K
  if "%filemd5%" == "15 4b 74 33 56 d5 1d ea c0 da 4e be 5f c1 fb 71" set threat=Win32-Ransom.Jigsaw.A
  if "%filemd5%" == "4e 89 0b a5 a4 f6 fd 63 72 7c 00 05 da a6 54 dd" set threat=Win32-Ransom.Jigsaw.B
  if "%filemd5%" == "a4 bb 3a 5c b6 83 5c 08 9d 76 91 00 d5 46 16 62" set threat=Win32-Ransom.Jigsaw.C
  if "%filemd5%" == "35 f0 50 c3 84 15 4c 4a e2 3e 02 b3 fc e7 98 47" set threat=Win32-Ransom.JNEC
  if "%filemd5%" == "4d e7 61 98 ea 44 88 ea e1 92 d0 ca 4e 4b d6 6b" set threat=Win32-Ransom.JobCrypter
  if "%filemd5%" == "f9 94 75 91 81 fb 96 4a f1 7f ab 2f 79 94 b9 ca" set threat=Win32-Ransom.JollyRoger
  if "%filemd5%" == "f5 4c 9a fc 52 02 9f d4 3b fb e6 dd 3c a2 f6 16" set threat=Win32-Ransom.JSterling
  if "%filemd5%" == "c6 69 32 0b 97 f2 c1 24 30 7c 3e 8a e2 e9 20 6d" set threat=Win32-Ransom.JSWorm
  if "%filemd5%" == "5e b7 d1 79 ad 6a 50 61 b4 ac 21 9d 58 4d 8e f8" set threat=Win32-Ransom.Kangaroo
  if "%filemd5%" == "56 f3 d3 d6 82 d6 11 2e 4d 6f 9f 31 6b e5 8d f4" set threat=Win32-Ransom.Karma
  if "%filemd5%" == "05 42 7e d1 c4 77 cc 01 91 0e b9 ad bf 35 06 8d" set threat=Win32-Ransom.Karmen
  if "%filemd5%" == "7f 87 db 33 98 0c 00 99 73 9d e4 0d 1b 72 55 00" set threat=Win32-Ransom.Katyusha
  if "%filemd5%" == "12 e2 ef f0 9c 11 4c 18 46 28 94 a4 89 11 ce 8a" set threat=Win32-Ransom.KesLan
  if "%filemd5%" == "e8 9e 40 9c 91 84 cc 61 3e 0b 69 6b a5 be 95 41" set threat=Win32-Ransom.Kostya
  if "%filemd5%" == "8e 0e 91 fd 7e e9 ff 25 d8 0c ab 51 b1 a3 ca 4d" set threat=Win32-Ransom.Krakatowis
  if "%filemd5%" == "b2 14 a9 cd 3c 2f c0 cc ec c8 d1 e5 2b 4f 50 20" set threat=Win32-Ransom.Kraken.A
  if "%filemd5%" == "c1 3d 28 dd 3d 19 f5 e0 1e f7 08 fc db b5 e3 b2" set threat=Win32-Ransom.Kraken.B
  if "%filemd5%" == "0a 74 35 67 c9 fa 72 e0 8c a6 c1 0a d6 20 01 76" set threat=Win32-Ransom.KRider
  if "%filemd5%" == "78 9d dc a4 99 7c 12 65 9f 23 93 6c 4f 91 e0 e5" set threat=Win32-Ransom.Kryptonite
  if "%filemd5%" == "bd ab a3 8e df 29 e3 0f e8 2f 0c 2e 46 ce ef 07" set threat=Win32-Ransom.LightningCrypt
  if "%filemd5%" == "b3 17 53 31 ae 74 ee 27 7e 94 d3 e0 bc 98 2b f4" set threat=Win32-Ransom.Lockbit
  if "%filemd5%" == "b2 69 85 00 c9 c9 0d 9c fb 5a a9 0f e2 81 ee 51" set threat=Win32-Ransom.LockerGoga
  if "%filemd5%" == "8b 4a cf ac e9 6f c4 ec 54 37 44 15 78 cc a1 03" set threat=Win32-Ransom.Lockon
  if "%filemd5%" == "77 1d eb 8b 72 0d bd 78 4d 67 15 40 3a 41 bd cc" set threat=Win32-Ransom.Locky
  if "%filemd5%" == "f1 06 73 72 c8 be 0f 15 e7 bf 83 6a 65 7a 34 a4" set threat=Win32-Ransom.Loki
  if "%filemd5%" == "b5 94 41 2c 00 33 1c 12 d1 5d 9e 18 c0 2a 77 8a" set threat=Win32-Ransom.LostFiles.A
  if "%filemd5%" == "a5 ed 29 35 a9 f8 5c 27 9f ce 7d de 74 25 24 34" set threat=Win32-Ransom.LostFiles.B
  if "%filemd5%" == "bf 21 af 86 7a 4a 41 79 5b cb ad c6 b4 18 5f 8b" set threat=Win32-Ransom.LTML
  if "%filemd5%" == "da 23 c8 a7 be 5d 83 ae 3e 6b 7b 32 91 fd b8 80" set threat=Win32-Ransom.Mafia
  if "%filemd5%" == "62 2b 76 9c 58 66 36 5c c3 cc 08 aa db fa 03 df" set threat=Win32-Ransom.Major
  if "%filemd5%" == "c3 55 fb 5b bb 6b dd aa b0 f4 60 6b c2 a8 05 5f" set threat=Win32-Ransom.Mamba
  if "%filemd5%" == "9a b7 55 b3 0d 22 f8 fc 26 c9 c8 5e eb 46 c1 c9" set threat=Win32-Ransom.Mancros
  if "%filemd5%" == "f8 3f b9 ce 6a 83 da 58 b2 06 85 c1 d7 e1 e5 46" set threat=Win32-Ransom.Maze
  if "%filemd5%" == "66 96 02 e6 f1 ac d4 03 d7 92 60 31 98 5e bb cc" set threat=Win32-Ransom.MemeLocker
  if "%filemd5%" == "75 0c 2c c9 1b 6c e6 97 aa 6a 5f c8 61 08 40 1f" set threat=Win32-Ransom.MindSystem
  if "%filemd5%" == "85 e1 f7 3e 4f 30 7e 8e a2 f5 46 e3 85 eb a3 55" set threat=Win32-Ransom.Mischa
  if "%filemd5%" == "2d 71 a6 ce f2 f5 f7 25 a7 bc f8 6a 4a a7 60 22" set threat=Win32-Ransom.Mole
  if "%filemd5%" == "53 13 e9 99 2e f0 78 a5 e5 8f 9f 41 6c e9 96 45" set threat=Win32-Ransom.Ncovid
  if "%filemd5%" == "0e 0b 7b 23 8a 06 a2 a3 7a 4d e0 6a 5a b5 e6 15" set threat=Win32-Ransom.Nemty
  if "%filemd5%" == "b6 0e b1 59 04 79 a2 7a d9 e2 d6 4d 81 fa 4a 4c" set threat=Win32-Ransom.NETCrypton
  if "%filemd5%" == "17 c2 5c 8a 7c 14 11 95 ee 88 7d e9 05 f3 3d 7b" set threat=Win32-Ransom.NotPetya
  if "%filemd5%" == "9a 60 89 0f c0 62 d1 0d 82 6c 31 d0 49 70 6a b7" set threat=Win32-Ransom.NRansom.A
  if "%filemd5%" == "f1 e6 c3 e0 f6 39 82 07 94 0d 1b 61 3a 7e 27 10" set threat=Win32-Ransom.NRansom.B
  if "%filemd5%" == "8f d4 fb 15 0c 5f 89 30 e3 4c 14 7d 87 d7 d8 df" set threat=Win32-Ransom.NRansom.C
  if "%filemd5%" == "c0 c6 a8 41 97 65 3d 9e aa 2c 81 f3 71 3f 85 87" set threat=Win32-Ransom.NRansom.D
  if "%filemd5%" == "6c 88 08 51 76 ab af 07 c9 7b 76 22 28 4f 4d d0" set threat=Win32-Ransom.NRansom.E
  if "%filemd5%" == "cd a2 20 a1 4b 0a 40 27 08 f8 9c cc 24 97 d9 65" set threat=Win32-Ransom.NRansom.F
  if "%filemd5%" == "77 37 76 26 37 62 56 8e d1 99 22 85 79 fe 4a 54" set threat=Win32-Ransom.NRansom.G
  if "%filemd5%" == "09 f2 c2 f3 81 e6 19 89 47 cb 1b 9b c1 22 8a a8" set threat=Win32-Ransom.NTKCryptolocker
  if "%filemd5%" == "c0 28 e2 74 29 34 8c 73 3b f0 81 12 ae a1 b9 06" set threat=Win32-Ransom.OhNo
  if "%filemd5%" == "34 fd 2c b9 95 83 3c ce e1 3d fb 2b 0e 32 37 46" set threat=Win32-Ransom.Omero
  if "%filemd5%" == "c8 0b fe f0 85 0d 3f 26 b2 46 89 df dd 82 b5 a7" set threat=Win32-Ransom.OnyxLocker
  if "%filemd5%" == "74 25 7f 66 ac 9e 43 b1 5b 98 ee 71 66 f8 bd c7" set threat=Win32-Ransom.Oops
  if "%filemd5%" == "b5 f9 36 35 8b 65 59 ac 3c 71 fd 53 c0 f0 9f 0e" set threat=Win32-Ransom.Orion
  if "%filemd5%" == "40 1c 7d ef d9 81 57 01 93 17 65 c4 e8 b8 d8 f9" set threat=Win32-Ransom.Paradise
  if "%filemd5%" == "59 7d ea cb e8 a1 d7 cf 84 1e 1f 41 e9 10 89 8f" set threat=Win32-Ransom.Petya.A
  if "%filemd5%" == "af 23 79 cc 4d 60 7a 45 ac 44 d6 21 35 fb 70 15" set threat=Win32-Ransom.Petya.B
  if "%filemd5%" == "fa 5d 96 64 4f e5 89 77 b4 97 65 f2 3b 3a 7e e5" set threat=Win32-Ransom.Phobos
  if "%filemd5%" == "91 98 29 30 fe 63 1d 3f cc b2 96 4a 7b 56 36 06" set threat=Win32-Ransom.PhobosImposter
  if "%filemd5%" == "39 19 ab d7 0a 26 63 82 1b 08 55 83 92 0c ad 54" set threat=Win32-Ransom.PoliceNationale
  if "%filemd5%" == "91 a0 75 50 e5 ca 2c 97 7f 50 40 6f 07 12 6a c8" set threat=Win32-Ransom.Polski
  if "%filemd5%" == "9c ce 98 a7 0c 25 36 06 33 ce 79 1e af 9f ba 18" set threat=Win32-Ransom.PolyRansom
  if "%filemd5%" == "38 3c 36 8a e3 3c 53 0d a3 6f fa e0 bc ee c8 0e" set threat=Win32-Ransom.PopcornTime
  if "%filemd5%" == "b7 5d 9c cd fe 58 0f fc d5 3f 98 74 52 be 4d ac" set threat=Win32-Ransom.PrincessEvolution.A
  if "%filemd5%" == "ac ae af 1e 1f f0 b0 43 a3 7d 2a 3e 3f 9f 3f be" set threat=Win32-Ransom.PrincessEvolution.B
  if "%filemd5%" == "66 c7 2c 0c 05 8b de e8 b2 6c 13 d9 de c0 72 f3" set threat=Win32-Ransom.PTP
  if "%filemd5%" == "40 d2 9a ce 41 27 9f 3d f8 db f7 a0 96 09 b2 44" set threat=Win32-Ransom.PUBG
  if "%filemd5%" == "52 74 68 a4 05 3d c1 42 dd 47 96 59 cf 2f c9 4c" set threat=Win32-Ransom.PureLocker
  if "%filemd5%" == "53 54 94 aa 6c e3 cc ef 73 46 b5 48 da 50 61 a9" set threat=Win32-Ransom.RAA
  if "%filemd5%" == "e7 e2 36 6f 75 f0 1f 46 39 b5 7b 77 b1 50 4d 83" set threat=Win32-Ransom.Radiation
  if "%filemd5%" == "48 45 2d d2 50 68 31 d0 b3 40 e4 5b 08 79 96 23" set threat=Win32-Ransom.Ragnarok
  if "%filemd5%" == "e2 86 49 b8 d9 8c 0c bf 61 fc 8f 61 54 56 22 57" set threat=Win32-Ransom.Rapid
  if "%filemd5%" == "e0 34 0f 45 6f 76 99 3f c0 47 bc 71 5d fd ae 6a" set threat=Win32-Ransom.RedBoot
  if "%filemd5%" == "e1 33 8c 42 da 2d 23 63 af bb d0 ee ab ad 1c a9" set threat=Win32-Ransom.Redeemer
  if "%filemd5%" == "ab 77 01 82 13 21 0e a8 8f c4 b9 cd 71 f9 56 68" set threat=Win32-Ransom.Rijndael
  if "%filemd5%" == "3c 76 75 48 d8 a7 4b 96 e8 51 a5 8b cc 4c 44 bc" set threat=Win32-Ransom.Rogue
  if "%filemd5%" == "db 63 b9 73 12 15 79 bc ad 7c 99 52 80 ca 4d 03" set threat=Win32-Ransom.RollSafe
  if "%filemd5%" == "6c dc b9 f8 69 72 ef c4 cf ce 4b 06 b6 be 05 3a" set threat=Win32-Ransom.Ryuk.A
  if "%filemd5%" == "5a c0 f0 50 f9 3f 86 e6 90 26 fa ea 1f bb 44 50" set threat=Win32-Ransom.Ryuk.B
  if "%filemd5%" == "93 5a 75 e0 c7 70 22 40 cb 53 0b 31 a8 3b 7c bc" set threat=Win32-Ransom.SadComputer
  if "%filemd5%" == "de 88 2f 60 ce 2a 09 98 99 c3 c4 e4 be 16 c5 e4" set threat=Win32-Ransom.Satana
  if "%filemd5%" == "cd af 85 2a 6a 3f 60 7c 20 cb e9 de ac b7 96 49" set threat=Win32-Ransom.Scarab
  if "%filemd5%" == "59 2b 12 b5 a4 d9 be ec 0c 89 14 fc b3 6a 8f 30" set threat=Win32-Ransom.Shade
  if "%filemd5%" == "ab a8 57 58 35 1d 76 2f fd ef 5f a9 61 08 36 07" set threat=Win32-Ransom.ShellLocker.A
  if "%filemd5%" == "2b e6 38 5e 51 59 21 07 16 68 1f 59 b6 4a ef 1e" set threat=Win32-Ransom.ShellLocker.B
  if "%filemd5%" == "04 d5 42 64 62 db c0 2b be c3 81 45 ab c7 49 c5" set threat=Win32-Ransom.ShutUpAndDance
  if "%filemd5%" == "5a 9a e5 f5 1c 41 f2 de 4f 3e ca 94 dd b4 cc fd" set threat=Win32-Ransom.Snatch.A
  if "%filemd5%" == "ed 52 77 5f d3 3e 70 ad 76 58 ec 35 c8 2d 29 92" set threat=Win32-Ransom.Snatch.B
  if "%filemd5%" == "b7 da 21 0b 88 5c 66 36 de 70 c0 12 9d a4 8a 66" set threat=Win32-Ransom.Snatch.C
  if "%filemd5%" == "1e 4f 2f 69 1d 03 7c a3 f9 82 21 dc 93 17 d1 cc" set threat=Win32-Ransom.SNSLocker
  if "%filemd5%" == "be d6 fc 04 ae b7 85 81 57 44 70 62 39 a1 f2 43" set threat=Win32-Ransom.Sodinokibi.A
  if "%filemd5%" == "56 1c ff ba ba 71 a6 e8 cc 1c dc ed a9 90 ea d4" set threat=Win32-Ransom.Sodinokibi.B
  if "%filemd5%" == "61 c0 03 ba c2 28 85 7c b0 db 62 07 eb 5a 7f 3e" set threat=Win32-Ransom.StalinLocker
  if "%filemd5%" == "2d e1 f1 4d 07 37 0b 98 67 f2 52 c0 76 37 ab 40" set threat=Win32-Ransom.Stolich
  if "%filemd5%" == "60 db b9 23 24 25 b9 dd c3 5c 9c d0 65 3a c5 cd" set threat=Win32-Ransom.STOP.A
  if "%filemd5%" == "58 6d 9e 5d 8a 90 30 1b 49 4e 83 3d 36 30 23 83" set threat=Win32-Ransom.STOP.B
  if "%filemd5%" == "be 42 07 0f d1 68 10 7d d2 ac 6e d9 12 72 35 72" set threat=Win32-Ransom.SuchSecurity
  if "%filemd5%" == "63 d4 e4 da c5 7b d7 d2 05 95 87 eb a4 16 26 52" set threat=Win32-Ransom.SureRansom.A
  if "%filemd5%" == "bf e4 d2 62 5d c2 0d ac 51 6c 52 c2 43 54 f1 62" set threat=Win32-Ransom.TeslaWare
  if "%filemd5%" == "8e 5f f6 0b f6 66 5c 57 93 8a b5 66 46 72 6e 1c" set threat=Win32-Ransom.Thanos.A
  if "%filemd5%" == "b0 c6 15 c0 a4 f4 85 b2 03 0d 6e 1a b9 83 75 f0" set threat=Win32-Ransom.Thanos.B
  if "%filemd5%" == "79 db a7 d5 7c 7e 9b aa 79 7e e2 b1 b0 81 68 ad" set threat=Win32-Ransom.TripleM
  if "%filemd5%" == "6c aa f5 00 c2 48 de 17 b1 90 72 93 70 00 7d da" set threat=Win32-Ransom.Tyrant
  if "%filemd5%" == "bb 46 b9 28 c3 2e c9 63 06 42 89 d2 1b d1 6d da" set threat=Win32-Ransom.Unlock92
  if "%filemd5%" == "57 7b e8 c5 b7 3e 59 fb 71 57 0f 63 23 49 e5 fe" set threat=Win32-Ransom.UselessDisk
  if "%filemd5%" == "c1 ec be ab 43 18 39 ba ed ca 41 69 3c e5 c2 0d" set threat=Win32-Ransom.Vanguard
  if "%filemd5%" == "77 48 7c 27 f5 47 6f 7b cb 09 21 06 f4 84 5b 4f" set threat=Win32-Ransom.VegaLocker
  if "%filemd5%" == "6d 12 54 77 72 b5 7a 6d a2 b2 5d 21 88 45 19 83" set threat=Win32-Ransom.VHD.A
  if "%filemd5%" == "d0 80 6c 9d 8b ce a0 bd 47 d8 0f a0 04 74 4d 7d" set threat=Win32-Ransom.VHD.B
  if "%filemd5%" == "dd 00 a8 61 0b b8 4b 54 e9 9a e8 09 9d b1 fc 20" set threat=Win32-Ransom.VHD.C
  if "%filemd5%" == "cc c6 02 6a cf 7e ad ad a9 ad ac ca b7 0c a4 d6" set threat=Win32-Ransom.VHD.D
  if "%filemd5%" == "ef d4 a8 7e 7c 5d cb b6 4b 73 13 a1 3b 4b 10 12" set threat=Win32-Ransom.VHD.E
  if "%filemd5%" == "68 2f 91 e3 ce 76 9a 68 65 ec d9 f2 b2 36 e8 3a" set threat=Win32-Ransom.VindowsLocker
  if "%filemd5%" == "3b 16 8e 96 79 ad 44 50 65 9b 29 2e 99 d1 42 6d" set threat=Win32-Ransom.WannaBitcoin
  if "%filemd5%" == "74 d6 e7 09 98 32 b4 d0 6f 45 39 80 aa 71 5b 05" set threat=Win32-Ransom.WannaCryptor.A
  if "%filemd5%" == "53 d0 74 70 d6 de 22 c7 f2 63 3f bb 84 d1 98 67" set threat=Win32-Ransom.WannaCryptor.B
  if "%filemd5%" == "c8 87 22 ef 42 a6 ee 08 cb ed 91 40 6e a5 c0 e5" set threat=Win32-Ransom.WannaCryptor.C
  if "%filemd5%" == "e4 b6 23 3a e4 6e 8a 64 f0 58 aa c3 c3 78 b0 17" set threat=Win32-Ransom.WannaCryptor.D
  if "%filemd5%" == "27 2d 02 d9 69 4b 61 08 ce 0c b9 3b e8 af 8f 16" set threat=Win32-Ransom.WannaCryptor.E
  if "%filemd5%" == "c4 f0 bb 8b aa 5f a8 f6 59 05 d1 13 d0 6c 89 15" set threat=Win32-Ransom.WannaCryptor.F
  if "%filemd5%" == "bc 80 1d 8d c0 9e a6 6b 39 fd f8 20 d7 76 23 97" set threat=Win32-Ransom.WannaCryptor.G
  if "%filemd5%" == "13 c3 de 53 41 b9 cf 48 60 cb fe 2e 7a 4e a7 97" set threat=Win32-Ransom.WannaCryptor.H
  if "%filemd5%" == "95 2a 32 24 1b 94 1e c5 85 04 67 23 f3 59 30 6a" set threat=Win32-Ransom.WannaCryptor.I
  if "%filemd5%" == "6b e6 d3 af d3 6d 78 c1 49 55 da 55 4e 12 2c 11" set threat=Win32-Ransom.WannaCryptor.J
  if "%filemd5%" == "84 c8 28 35 a5 d2 1b bc f7 5a 61 70 6d 8a b5 49" set threat=Win32-Ransom.WannaCryptor.K
  if "%filemd5%" == "ef a8 cd a6 aa 18 8e f8 56 4c 94 a5 8b 75 63 9f" set threat=Win32-Ransom.WannaCryptor.L
  if "%filemd5%" == "f5 39 ff 91 1a 60 79 16 45 86 05 4e 03 1e d4 e9" set threat=Win32-Ransom.WannaCryptor.M
  if "%filemd5%" == "e3 33 60 4e 0d 21 4d 03 32 8a 85 4d f1 30 37 7f" set threat=Win32-Ransom.WannaCryptor.N
  if "%filemd5%" == "db 34 9b 97 c3 7d 22 f5 ea 1d 18 41 e3 c8 9e b4" set threat=Win32-Ransom.WannaCryptor.O
  if "%filemd5%" == "83 cb 5b 87 a7 86 fb 13 5a 11 bc 13 3f b4 d4 d6" set threat=Win32-Ransom.WannaOof
  if "%filemd5%" == "13 e6 23 cd fb 75 d9 9e a7 e0 4c 61 57 ca 8a e6" set threat=Win32-Ransom.WastedLocker
  if "%filemd5%" == "98 89 2a 91 cb d8 1b cc 99 71 08 49 b5 db c7 d3" set threat=Win32-Ransom.WeAreFriends
  if "%filemd5%" == "9d e4 34 f0 af ed 54 dc 53 e1 dc b1 1b c6 9f b7" set threat=Win32-Ransom.Wesker
  if "%filemd5%" == "c5 c5 18 34 c6 f8 d5 f5 3f ec 67 1d ba 61 8a 6e" set threat=Win32-Ransom.Widia
  if "%filemd5%" == "e0 b9 18 8e cd ad 1b 89 13 1f ec ed cd 8e a4 db" set threat=Win32-Ransom.WIN
  if "%filemd5%" == "d6 4b f6 3b 70 47 1f 51 cc 5a 65 7b 67 c3 2f 6c" set threat=Win32-Ransom.XDLocker.A
  if "%filemd5%" == "34 b5 4e d3 e0 66 1b 6b bf ca c3 20 a6 13 dc dc" set threat=Win32-Ransom.XDLocker.B
  if "%filemd5%" == "44 a7 8e 41 f2 d6 db d3 75 d2 86 cc dc 5e 0e 16" set threat=Win32-Ransom.XDLocker.C
  if "%filemd5%" == "40 e7 40 3b 6b 86 d5 f8 a5 3a 35 e3 bd cd f2 b6" set threat=Win32-Ransom.XeroWare
  if "%filemd5%" == "3d ab 2a 29 b7 92 6a b9 92 29 9f 5b 3f 41 66 55" set threat=Win32-Ransom.Xorist
  if "%filemd5%" == "45 3a 78 91 0a 83 4a d8 83 0a b9 de e7 c1 83 e3" set threat=Win32-Ransom.XiaoBa
  if "%filemd5%" == "38 51 45 99 93 a1 b8 13 77 5a 7d c9 ba a2 ff 6c" set threat=Win32-Ransom.YamiCat
  if "%filemd5%" == "d0 e8 7f d3 56 97 9a ff 2a 42 09 57 ec 07 0d 54" set threat=Win32-Ransom.Zeoticus.A
  if "%filemd5%" == "b1 90 29 68 92 d3 44 14 1a ec c5 38 f6 e4 40 01" set threat=Win32-Ransom.Zeoticus.B
  if "%filemd5%" == "f8 18 93 8b 98 72 36 cd d4 11 95 79 6b 4c 1f b5" set threat=Win32-Ransom.Zeppelin.A
  if "%filemd5%" == "dc ef 20 8f cd ac 33 45 c6 89 9a 47 8d 16 98 0f" set threat=Win32-Ransom.Zeppelin.B
  if "%filemd5%" == "ef 57 2e 2c 7b 1b bd 57 65 4b 36 e8 dc fd c3 7a" set threat=Win32-Ransom.Zeppelin.C
  if "%filemd5%" == "07 a0 72 28 93 0e 25 8e 85 ff 34 85 f6 da 75 a7" set threat=Win32-Ransom.ZeroRansom
  if "%filemd5%" == "6b e6 53 cd 2f 91 72 54 37 36 e3 f5 3a ef cd 54" set threat=Win32-Ransom.Ziggy
  if "%filemd5%" == "48 0c 56 47 da fb 9e b2 26 f7 40 25 b7 83 17 70" set threat=Win32-RAT.Adwind
  if "%filemd5%" == "db a6 df b2 73 3a a1 c9 2e 7e e7 62 ea 66 66 65" set threat=Win32-RAT.Agent
  if "%filemd5%" == "85 2c f7 6a b9 2c 6a a9 03 c5 fc 9a 78 b6 0d 9c" set threat=Win32-RAT.DarkKomet.A
  if "%filemd5%" == "12 39 1c 17 7d 21 5e f0 1f 65 e3 43 39 e5 4b f9" set threat=Win32-RAT.DarkKomet.B
  if "%filemd5%" == "96 30 5f 55 42 86 f7 84 d9 92 8c 49 90 45 c3 d6" set threat=Win32-RAT.NanoCore.A
  if "%filemd5%" == "6d 17 bd f6 1e 8c ec 2f 59 e8 39 a0 f1 8e e5 1c" set threat=Win32-RAT.NanoCore.B
  if "%filemd5%" == "0e fa 8a 4d c0 7c b2 c1 8f a2 40 35 bf 93 88 cf" set threat=Win32-RAT.NetWire
  if "%filemd5%" == "68 30 88 4f b2 9c b5 12 d2 5a cb 4c 82 b5 cd af" set threat=Win32-RAT.PoisonIvy.A
  if "%filemd5%" == "a9 2e 0b e7 1c ed 2d 13 69 5b 75 55 28 0d df 51" set threat=Win32-RAT.PoisonIvy.B
  if "%filemd5%" == "c1 7c ad 86 80 51 b0 7e 56 1f 08 d9 de 11 b6 70" set threat=Win32-RAT.Quasar.A
  if "%filemd5%" == "0f 79 b4 eb 14 c3 c2 ab 88 76 37 26 2d e8 1e 5d" set threat=Win32-RAT.Quasar.B
  if "%filemd5%" == "e4 22 8a aa b5 f4 97 2f 88 1d 79 3b 93 47 1a 91" set threat=Win32-RAT.Quasar.C
  if "%filemd5%" == "e9 50 81 4f 0a 29 f9 59 37 50 f7 ea 42 06 e2 dd" set threat=Win32-RBot
  if "%filemd5%" == "7a 34 80 d2 f4 e1 00 1f 14 89 3b e6 b8 49 ec 93" set threat=Win32-Rogue.AntiVirGear
  if "%filemd5%" == "51 b3 30 e6 b3 04 76 5f 3a b6 17 8a 99 ea 87 f4" set threat=Win32-Rogue.AntivirusBEST
  if "%filemd5%" == "a8 f0 1f df 7b 09 78 11 f7 c6 40 55 cb 04 1b 88" set threat=Win32-Rogue.AntiVirusGold
  if "%filemd5%" == "1f 13 39 6f a5 9d 38 eb e7 6c cc 58 7c cb 11 bb" set threat=Win32-Rogue.NavaShield
  if "%filemd5%" == "d7 f9 9e 8f 3b d8 a9 1c d7 65 93 ac d9 9f fe 89" set threat=Win32-Rogue.Paladin.A
  if "%filemd5%" == "d2 cf 8c 85 cd a2 d1 89 ae 31 10 73 e4 2a f6 09" set threat=Win32-Rogue.Paladin.B
  if "%filemd5%" == "b1 7f bd 42 af cf 74 2f c4 cb 58 51 b9 51 82 67" set threat=Win32-Rogue.Paladin.C
  if "%filemd5%" == "0b f2 ab 80 9f c3 7e 37 6b 11 a2 1a 13 0c 3a d7" set threat=Win32-Rogue.PCKeeper
  if "%filemd5%" == "cb c1 5c a3 4a 62 d4 09 b9 97 26 b6 a2 c4 7a 93" set threat=Win32-Rogue.Rango
  if "%filemd5%" == "3c 05 5b ec e3 a6 d7 14 5b 51 bb a9 3b 05 ec 8c" set threat=Win32-Rogue.SpyAxe
  if "%filemd5%" == "c8 99 f9 3e 8b 75 3f ed d0 68 ef 3f e2 ed b0 fd" set threat=Win32-Rogue.SpySheriff
  if "%filemd5%" == "7e 56 ea 2b a6 6f 0b a2 db 65 91 c4 28 92 38 72" set threat=Win32-Rogue.SpywareQuake
  if "%filemd5%" == "04 86 6e cb 33 e4 49 6a 8c fd cd ad 6c 80 10 81" set threat=Win32-Rogue.SystemSecurity
  if "%filemd5%" == "bd 08 8f 4e 45 8d 31 49 31 e6 94 de f6 f6 91 71" set threat=Win32-Rogue.SystemTool
  if "%filemd5%" == "8a fa d0 4b bd 53 80 d6 67 45 e2 5e 30 c0 a8 9f" set threat=Win32-Rogue.VirBytes.A
  if "%filemd5%" == "ab 27 c3 cc 0a b7 6a d0 6f 5c 02 b0 88 01 4c c8" set threat=Win32-Rogue.VirBytes.B
  if "%filemd5%" == "db c9 d1 c4 75 e3 a4 1f fc b8 e7 ac 78 02 af 21" set threat=Win32-Rogue.VirusProtectPro
  if "%filemd5%" == "e0 33 88 af 3a 89 9c 09 32 23 0d 06 1e 31 af 16" set threat=Win32-Rogue.WindowsPolicePro
  if "%filemd5%" == "49 69 3f a1 51 55 b8 b0 b4 ee 5b b8 13 5f d0 b9" set threat=Win32-Rogue.Winhound
  if "%filemd5%" == "ba 37 11 89 ab 70 09 0c 29 8d 92 d5 02 e1 30 e5" set threat=Win32-Rogue.WolframAntivirus
  if "%filemd5%" == "3e dd 49 00 66 ea 4a 31 2e 6f a6 dc 42 0a f6 c6" set threat=Win32-Rootkit.TDSS.A
  if "%filemd5%" == "55 85 c4 da 24 fc f7 24 c8 bc 3e ed e4 a4 d8 13" set threat=Win32-Rootkit.TDSS.B
  if "%filemd5%" == "f6 57 02 65 92 e2 ae 04 54 5f 8a b1 f4 64 1a 97" set threat=Win32-Rootkit.ZeroAccess
  if "%filemd5%" == "ce 69 a4 70 25 27 e0 fc 32 38 73 e0 8f 99 b2 af" set threat=Win32-Sality.A
  if "%filemd5%" == "f3 16 be c0 84 81 f4 5d f9 93 70 2b 64 71 43 de" set threat=Win32-Sality.B
  if "%filemd5%" == "9d ec 49 c9 ca f3 6f 68 f2 2b 39 77 8e c9 3f 18" set threat=Win32-Sality.C
  if "%filemd5%" == "25 aa 9b b5 49 ec c7 bb 61 00 f8 d1 79 45 25 08" set threat=Win32-Sality.D
  if "%filemd5%" == "14 50 d3 b0 6b 90 85 6d db a1 fc 58 a7 bf bb fc" set threat=Win32-Sality.E
  if "%filemd5%" == "ab e4 33 21 24 b4 37 00 a0 9d d8 68 ac 4d 11 a1" set threat=Win32-Sality.F
  if "%filemd5%" == "a2 ee 24 0d 9a 49 79 e2 ff 9f 64 6c 1f c2 98 9a" set threat=Win32-Sality.G
  if "%filemd5%" == "86 d9 d5 ac 58 b8 a4 80 11 62 80 aa f2 ed d3 d9" set threat=Win32-Sality.H
  if "%filemd5%" == "a0 19 17 a2 ca f1 34 8a 0b 5b ab f0 a5 e0 ee 2c" set threat=Win32-Sality.I
  if "%filemd5%" == "f4 37 65 38 ec bb 95 8a a6 71 a9 70 8e b4 af 66" set threat=Win32-Sality.J
  if "%filemd5%" == "a7 3c 16 cc d0 b9 c4 f2 0b c7 84 2e dd 90 fc 20" set threat=Win32-Sasser.A
  if "%filemd5%" == "1a 2c 0e 61 30 85 0f 8f d9 b9 b5 30 94 13 cd 00" set threat=Win32-Sasser.B
  if "%filemd5%" == "0e 97 3c ba 35 97 e3 39 d1 d8 48 1d 9a 35 8b 87" set threat=Win32-Sasser.C
  if "%filemd5%" == "32 a9 f7 ad 4b ed a3 79 5f 16 40 04 db 3c ff f8" set threat=Win32-Sasser.D
  if "%filemd5%" == "86 bb 42 89 d3 4f 9c 26 c9 32 36 84 f6 9e 49 b1" set threat=Win32-Sasser.E
  if "%filemd5%" == "14 70 fb c9 9d 7c 75 ce 94 40 ef 89 e1 d9 01 f3" set threat=Win32-Scam.Agent.A
  if "%filemd5%" == "f2 57 a5 f1 9f 61 6f 63 78 50 52 cb 3b 31 69 27" set threat=Win32-Shoerec
  if "%filemd5%" == "5d 82 00 d6 99 e5 7e d8 ce 75 ad 22 fe 9f 59 8f" set threat=Win32-SnakeKeylogger
  if "%filemd5%" == "fd b0 57 61 a7 ed a3 f1 82 48 50 3f 2c 97 d6 97" set threat=Win32-Sobig.A
  if "%filemd5%" == "d3 a8 b3 dc de 44 b8 1c 0e 69 cc 2a 8a 36 e8 44" set threat=Win32-Sobig.B
  if "%filemd5%" == "ca 22 1b 0f e0 3c 1f 0a 75 6a aa dd 55 e1 cc 43" set threat=Win32-SonicGatherBattle.A
  if "%filemd5%" == "90 34 87 42 41 6a 9c 62 19 57 e6 84 0a 17 c0 8d" set threat=Win32-SonicGatherBattle.B
  if "%filemd5%" == "31 f1 d2 08 ee 74 0e 1f df 96 67 b2 e5 25 f3 d7" set threat=Win32-Spyware.FinSpy.A
  if "%filemd5%" == "49 94 95 20 20 da 28 bb 0a a0 23 d2 36 a6 bf 3b" set threat=Win32-Spyware.FinSpy.B
  if "%filemd5%" == "4c 70 5a 8a 0a 21 e1 32 6f 40 94 7b 62 17 1e 85" set threat=Win32-Spyware.Hakey.A
  if "%filemd5%" == "16 43 4c 8d 22 51 c3 bc 02 3f 50 a4 80 18 4a 0d" set threat=Win32-Spyware.Hakey.B
  if "%filemd5%" == "0f 55 ad da c0 cc 58 93 04 6e ec 75 77 72 d4 16" set threat=Win32-Spyware.RedLine.A
  if "%filemd5%" == "e6 3a da 8c 3c 27 e5 00 21 b5 18 41 3c 31 3e c8" set threat=Win32-Spyware.RedLine.B
  if "%filemd5%" == "3e c9 a5 59 d4 ba 30 55 79 16 e9 db cb a6 da a9" set threat=Win32-Spyware.RedLine.C
  if "%filemd5%" == "5c 8d f4 e2 f2 ea 5b 69 f1 c6 b6 5f 7b 6f 73 c0" set threat=Win32-Spyware.Zbot.A
  if "%filemd5%" == "38 61 55 80 0f 4c 16 9a 6b 81 19 43 0c e7 88 1f" set threat=Win32-Spyware.Zbot.B
  if "%filemd5%" == "aa b2 e7 79 4e ec af 39 d2 f1 5c 3d e4 36 48 8d" set threat=Win32-StartPage
  if "%filemd5%" == "b4 42 9d 77 58 67 98 06 4b 56 b0 09 9f 0c cd 49" set threat=Win32-Stuxnet
  if "%filemd5%" == "70 b5 a2 41 74 c9 2e 90 33 a6 11 c4 6d 03 de a8" set threat=Win32-Supern0va
  if "%filemd5%" == "9b 7e d8 1c a4 80 5c 49 cf 2a fe bf b5 11 d4 a2" set threat=Win32-SweetKiller
  if "%filemd5%" == "ae 29 c7 d7 bb 35 dd c6 12 0f 2b 1b 71 3a 73 d7" set threat=Win32-Trojan.Absturz.A
  if "%filemd5%" == "ce c3 b0 0e 68 a1 35 02 e4 44 67 9c af b3 ce 5b" set threat=Win32-Trojan.Absturz.B
  if "%filemd5%" == "5a a0 cd a7 43 e5 fb d1 d0 31 5b 68 6e 5e 60 24" set threat=Win32-Trojan.AdShield.A
  if "%filemd5%" == "81 bc 96 5e 07 a0 d6 c9 e3 eb 01 24 cd f9 7a a2" set threat=Win32-Trojan.AdShield.B
  if "%filemd5%" == "ac 9e 74 ef 5c ca b1 d5 c2 bd d9 c7 4b b7 98 cc" set threat=Win32-Trojan.AdShield.C
  if "%filemd5%" == "bd d0 e5 6f 94 00 36 b7 18 55 16 17 c4 96 fc d0" set threat=Win32-Trojan.Agensla.A
  if "%filemd5%" == "db 98 bd f5 f5 26 0a 10 86 4d 34 9e 9e 63 7f 1f" set threat=Win32-Trojan.Agensla.B
  if "%filemd5%" == "db de 77 5a 11 a2 9f d8 f6 6d fc 19 61 95 b4 1f" set threat=Win32-Trojan.Agensla.C
  if "%filemd5%" == "06 8e 06 ae 07 fd 6f 5d e1 b7 fa a4 61 fd f3 f7" set threat=Win32-Trojan.Agent.A
  if "%filemd5%" == "9d 0d e6 7a 5c 84 1f fc 67 ef a7 a1 72 3f 41 dd" set threat=Win32-Trojan.Agent.B
  if "%filemd5%" == "7f ae ac 65 e9 cb 2f df 40 d1 70 bb 50 8e fd 83" set threat=Win32-Trojan.Agent.C
  if "%filemd5%" == "f0 fe 0b 13 b1 5e fa 14 72 ae de 79 fb 5d 90 96" set threat=Win32-Trojan.Agent.D
  if "%filemd5%" == "62 05 27 ce 57 7a f7 8e 34 cb e9 c4 a0 7c 9f 97" set threat=Win32-Trojan.Agent.E
  if "%filemd5%" == "7a ab e4 1a e2 77 ab f2 9e df 0c 3d d2 06 69 b6" set threat=Win32-Trojan.Agent.F
  if "%filemd5%" == "78 2a 7e 6a a7 07 d9 8c 7c df 9e 41 8e 4a 7f ae" set threat=Win32-Trojan.Agent.G
  if "%filemd5%" == "47 ed ec c9 f8 30 c2 29 f1 75 22 02 87 bf 91 f0" set threat=Win32-Trojan.Agent.H
  if "%filemd5%" == "a1 a7 6c 17 03 03 0b 3b 3b cd 1d 15 e3 2f b7 a6" set threat=Win32-Trojan.Agent.I
  if "%filemd5%" == "b5 52 c5 4b f0 04 7a 43 0a 28 54 58 cf a6 0a 43" set threat=Win32-Trojan.Agent.J
  if "%filemd5%" == "00 8a 0b 7f cf bc 65 f0 14 fa 85 ec 01 33 2a 76" set threat=Win32-Trojan.Agent.K
  if "%filemd5%" == "c0 9c f4 31 21 67 fa 96 83 d8 e8 73 30 04 b7 e6" set threat=Win32-Trojan.Agent.L
  if "%filemd5%" == "03 f6 9c 46 00 2a e2 77 22 2c 0c 32 b9 28 c4 c0" set threat=Win32-Trojan.Agent.M
  if "%filemd5%" == "85 f3 04 84 98 9c 9f b2 40 e7 ad 0d 3d bd 5b 25" set threat=Win32-Trojan.Agent.N
  if "%filemd5%" == "30 58 85 26 80 b6 13 ec b1 35 8c 0f 35 50 68 27" set threat=Win32-Trojan.Agent.O
  if "%filemd5%" == "1a 66 a0 29 72 8c 19 25 4d 52 13 53 4e e5 92 5d" set threat=Win32-Trojan.Agent.P
  if "%filemd5%" == "f8 76 b8 ce 91 d5 72 54 7e a7 91 04 f3 f2 4f 48" set threat=Win32-Trojan.Agent.Q
  if "%filemd5%" == "09 ae 2b 5f ce 9b 03 1c 78 42 d8 84 02 c4 7c 27" set threat=Win32-Trojan.Agent.R
  if "%filemd5%" == "aa f5 08 bc 68 b8 4d 5d a0 b4 b4 c0 7f 14 93 39" set threat=Win32-Trojan.Agent.S
  if "%filemd5%" == "19 b7 3d 5e 0a c6 eb 01 f9 ff 8d 3e e6 16 2e d6" set threat=Win32-Trojan.Agent.T
  if "%filemd5%" == "5b 21 34 34 2c 7d 99 a4 00 5a 61 0e e8 8f 2c e1" set threat=Win32-Trojan.Agent.U
  if "%filemd5%" == "ea 7f d2 5c f7 8e bd d5 9e 76 a0 8f 83 6c ea c4" set threat=Win32-Trojan.Agent.V
  if "%filemd5%" == "98 6e 32 12 e0 05 46 7b f4 71 41 df 1e 1e dc b1" set threat=Win32-Trojan.Agent.W
  if "%filemd5%" == "5d 98 24 25 8e 50 75 21 9f c1 a8 05 93 72 84 af" set threat=Win32-Trojan.Agent.X
  if "%filemd5%" == "cb d8 a2 3f 30 7d 22 f3 7f 72 a7 a0 65 56 69 09" set threat=Win32-Trojan.Agent.Y
  if "%filemd5%" == "67 42 f4 4d d3 2b 4c 95 c3 03 4c c3 b0 b0 06 95" set threat=Win32-Trojan.Agent.Z
  if "%filemd5%" == "ce a1 9c 96 db 10 02 0f 0d 6e 5a e5 73 2b 15 cd" set threat=Win32-Trojan.Agent.AA
  if "%filemd5%" == "04 3f dd 20 3a 73 05 5b 78 c1 4d 82 25 75 0a d8" set threat=Win32-Trojan.Agent.AB
  if "%filemd5%" == "d1 f6 8e ab 4c a1 b2 b9 2f 27 85 95 84 8e 7e 21" set threat=Win32-Trojan.Agent.AC
  if "%filemd5%" == "84 52 cc 1e 8c c7 a0 3d c6 33 27 44 5f b8 6c 6a" set threat=Win32-Trojan.Agent.AD
  if "%filemd5%" == "1f a9 a5 c5 b1 43 d1 fc aa 3c 62 93 e4 3f b1 58" set threat=Win32-Trojan.Agent.AE
  if "%filemd5%" == "21 72 d5 39 df c3 1f 78 f8 73 63 c9 83 7f c7 88" set threat=Win32-Trojan.Agent.AF
  if "%filemd5%" == "14 65 bc 78 65 de ee e6 74 13 56 44 6d 2c 0f 20" set threat=Win32-Trojan.Agent.AG
  if "%filemd5%" == "2e c1 62 99 0e ff 01 ca ed bc 35 88 fe 76 82 fc" set threat=Win32-Trojan.Agent.AH
  if "%filemd5%" == "11 a1 95 a4 c8 83 62 b9 5c 9a e9 cd 95 18 bc f3" set threat=Win32-Trojan.Agent.AI
  if "%filemd5%" == "81 53 45 85 cf 4e 9d 9d 7a 08 9b 3f 42 27 43 86" set threat=Win32-Trojan.Agent.AJ
  if "%filemd5%" == "03 65 6d 45 70 5a d0 50 a9 32 40 58 5b f3 24 98" set threat=Win32-Trojan.Agent.AK
  if "%filemd5%" == "98 99 df 18 a9 ba 76 d4 0f e9 65 de 82 9d 0c 06" set threat=Win32-Trojan.Agent.AL
  if "%filemd5%" == "26 38 15 99 c3 0d e2 8f b0 5b bf 19 cc 89 d8 c3" set threat=Win32-Trojan.Agent.AM
  if "%filemd5%" == "a9 d2 a4 02 69 51 58 fc c2 ec 3a 97 5e 86 03 12" set threat=Win32-Trojan.Agent.AN
  if "%filemd5%" == "7a af de 59 d7 ff ce 82 a2 91 32 3c cf 65 1f a7" set threat=Win32-Trojan.Agent.AO
  if "%filemd5%" == "52 eb 48 c0 d3 99 fd 85 0e 4b 66 ae 72 d2 42 c0" set threat=Win32-Trojan.Agent.AP
  if "%filemd5%" == "60 19 22 c6 50 e6 06 05 51 50 04 a2 4b c7 94 c8" set threat=Win32-Trojan.Agent.AQ
  if "%filemd5%" == "0a af 18 f8 cf b0 7f 7f bc a9 11 0a a9 44 2e 57" set threat=Win32-Trojan.Agent.AR
  if "%filemd5%" == "30 f9 28 5e a7 96 fb 00 40 ec 61 33 81 60 04 a5" set threat=Win32-Trojan.Agent.AS
  if "%filemd5%" == "c4 49 4a 46 e8 b4 be 7c 58 ad 9c 06 bf 6b 26 80" set threat=Win32-Trojan.Agent.AT
  if "%filemd5%" == "bc fe 8b f8 94 83 d4 28 36 0b f3 d7 7c dc 88 24" set threat=Win32-Trojan.Agent.AU
  if "%filemd5%" == "19 6e be 02 8b e8 7e 34 36 e9 9e c7 4b 82 ba e7" set threat=Win32-Trojan.Agent.AV
  if "%filemd5%" == "92 d6 7b a8 ea b9 63 c7 43 d3 79 4f 42 5f 55 54" set threat=Win32-Trojan.Agent.AW
  if "%filemd5%" == "16 10 21 0d 22 6c 8b ec d2 e5 79 a6 54 a6 a5 45" set threat=Win32-Trojan.Agent.AX
  if "%filemd5%" == "b4 60 b6 c6 73 60 14 d2 e9 9c 49 ed 5f 7a 9f 3a" set threat=Win32-Trojan.Agent.AY
  if "%filemd5%" == "01 51 2d 5f b2 0b 0c 69 9f 55 4b 18 e2 31 9a 95" set threat=Win32-Trojan.Agent.AZ
  if "%filemd5%" == "48 5a 29 9d f8 7d 2f 90 9d 2b 90 be e8 a5 4e f2" set threat=Win32-Trojan.Agent.BA
  if "%filemd5%" == "f0 5a 92 28 39 ec cf 66 f6 b7 e7 8c 3b 91 c2 cf" set threat=Win32-Trojan.Agent.BB
  if "%filemd5%" == "6b 42 55 1e cd 25 e8 b7 bb 66 6f 79 6d 1e ed ea" set threat=Win32-Trojan.Agent.BC
  if "%filemd5%" == "4b db 64 68 4d fb b0 06 43 4c ac e8 d2 5c 9c 70" set threat=Win32-Trojan.Agent.BD
  if "%filemd5%" == "79 0e d2 fc 9c ce a1 90 ae 74 23 90 a9 73 f6 24" set threat=Win32-Trojan.Agent.BE
  if "%filemd5%" == "70 c8 55 74 b4 9d ad 4b a0 15 f1 58 45 fe a2 92" set threat=Win32-Trojan.Agent.BF
  if "%filemd5%" == "d9 f6 81 21 db 28 45 64 2c 1d 17 da 12 6a 66 74" set threat=Win32-Trojan.Agent.BG
  if "%filemd5%" == "d2 d6 34 30 3c a9 31 2a 24 ba b1 37 92 8b 72 fa" set threat=Win32-Trojan.Agent.BH
  if "%filemd5%" == "c9 3a 80 04 97 46 65 32 89 db 05 79 b2 53 a5 9d" set threat=Win32-Trojan.Agent.BI
  if "%filemd5%" == "16 1c ea 30 a2 9b 54 e7 43 6e 43 7b c5 c3 45 27" set threat=Win32-Trojan.Agent.BJ
  if "%filemd5%" == "99 4a 67 d5 d6 34 11 73 ad 95 bc 6f 5d 79 5f d0" set threat=Win32-Trojan.Agent.BK
  if "%filemd5%" == "65 cb 82 f6 85 3b f1 6f 92 59 42 c7 e0 01 19 d6" set threat=Win32-Trojan.Agent.BL
  if "%filemd5%" == "1a df 20 d2 a5 2c aa bc 01 e6 5a 0e 54 ef c5 11" set threat=Win32-Trojan.Agent.BM
  if "%filemd5%" == "06 b1 84 4d d4 e3 64 24 84 41 ef 47 1d 4e f9 2e" set threat=Win32-Trojan.Agent.BN
  if "%filemd5%" == "0a 81 62 18 d3 7f b8 2d 40 fd 75 a3 4e d6 4c de" set threat=Win32-Trojan.Agent.BO
  if "%filemd5%" == "71 3c 25 ef b3 4e 8b 4b e1 08 77 ee 1f 8c 64 64" set threat=Win32-Trojan.Agent.BP
  if "%filemd5%" == "d3 52 71 29 7f b0 01 27 72 10 91 ff 93 46 fa 4c" set threat=Win32-Trojan.Agent.BQ
  if "%filemd5%" == "b6 5b 4d dc 48 5e ee fd 8d f4 8d 48 c8 eb 4f 40" set threat=Win32-Trojan.Agent.BR
  if "%filemd5%" == "db 80 bc 33 b2 de c3 76 25 34 fa 6f 00 75 50 0c" set threat=Win32-Trojan.Agent.BS
  if "%filemd5%" == "ec f5 3b 19 82 03 bb 27 d4 ce 00 8d 56 bc ce a7" set threat=Win32-Trojan.Agent.BT
  if "%filemd5%" == "f0 a2 64 5c 05 b4 00 b1 15 43 77 6b ec 19 76 9a" set threat=Win32-Trojan.Agent.BU
  if "%filemd5%" == "d1 47 5a c6 8e 0e dd cc f7 a7 6e 38 24 fb c4 18" set threat=Win32-Trojan.Agent.BV
  if "%filemd5%" == "97 f4 99 6d 22 3f 1e bb 5e c7 a3 f5 25 6a b3 1e" set threat=Win32-Trojan.Agent.BW
  if "%filemd5%" == "71 1a 3c 28 e1 bf 2f 5e f0 58 9a 54 b9 b1 6c bf" set threat=Win32-Trojan.Agent.BX
  if "%filemd5%" == "fe 68 99 7d 3f 16 af 3b 1a 35 ac e6 7a ce 81 b7" set threat=Win32-Trojan.Agent.BY
  if "%filemd5%" == "23 a6 9b b4 16 53 77 b6 9a 1b 32 65 35 33 e2 c9" set threat=Win32-Trojan.Agent.BZ
  if "%filemd5%" == "c9 16 0a 76 ce 50 e7 1a ac 16 e1 3a dc 88 b0 02" set threat=Win32-Trojan.Agent.CA
  if "%filemd5%" == "ff 37 e2 2b 26 cf 2f 90 0a f6 a8 97 4d c4 45 3d" set threat=Win32-Trojan.Agent.CB
  if "%filemd5%" == "96 1f 16 8e ac 11 1a 4e 2a 85 c0 86 0d ef 3e ff" set threat=Win32-Trojan.Agent.CC
  if "%filemd5%" == "2b c6 5e 64 dd c2 63 6d 52 47 1f 41 e3 50 a6 4c" set threat=Win32-Trojan.Agent.CD
  if "%filemd5%" == "fc 1c 48 88 dd 61 55 27 24 0d 18 c1 45 ea be d0" set threat=Win32-Trojan.Agent.CE
  if "%filemd5%" == "4b d1 2f 2e af 0f 8d f6 31 cb c9 2f 66 ea b0 46" set threat=Win32-Trojan.Agent.CF
  if "%filemd5%" == "47 f5 00 2a 0b 9d 31 2f 28 82 2d 92 a3 96 2c 81" set threat=Win32-Trojan.Agent.CG
  if "%filemd5%" == "49 a7 c3 9e 2d bf b9 a9 c1 99 3a d7 4e eb d7 a8" set threat=Win32-Trojan.Agent.CH
  if "%filemd5%" == "41 99 08 d5 d0 7c 67 b2 63 4d bf 03 5a 5f 6b 02" set threat=Win32-Trojan.Agent.CI
  if "%filemd5%" == "49 de 2a 62 b0 ae 82 24 85 27 40 58 06 0c 97 c7" set threat=Win32-Trojan.Agent.CJ
  if "%filemd5%" == "aa 92 38 bc 0e 7f 6e d7 58 c8 84 22 7b 44 58 28" set threat=Win32-Trojan.Agent.CK
  if "%filemd5%" == "41 40 5c 63 c8 58 a9 fb 19 6b e6 85 10 c5 bc 87" set threat=Win32-Trojan.Agent.CL
  if "%filemd5%" == "62 35 6a 97 dd ad c7 d8 87 bd 66 de c1 8b 9b 4c" set threat=Win32-Trojan.Agent.CM
  if "%filemd5%" == "ee 73 6c 4c 68 37 83 0c c6 7e ed 7e ea 57 17 37" set threat=Win32-Trojan.Agent.CN
  if "%filemd5%" == "74 d0 2d b9 10 e9 dc 7c a1 f3 b0 20 65 46 dd 8c" set threat=Win32-Trojan.Agent.CO
  if "%filemd5%" == "b0 02 b2 4d 91 37 22 2c 1e 76 32 54 2d 6e ef 8f" set threat=Win32-Trojan.Agent.CP
  if "%filemd5%" == "0d 30 1e c1 07 5f 45 0d 37 ff ad 7e 30 dc ee 4e" set threat=Win32-Trojan.Agent.CQ
  if "%filemd5%" == "1f c4 4e bc 73 61 a3 22 f5 a1 c3 90 0c f3 0f 94" set threat=Win32-Trojan.Agent.CR
  if "%filemd5%" == "fb c2 07 43 41 f6 e8 19 e3 cc cd 71 3f 5b 94 a3" set threat=Win32-Trojan.Agent.CS
  if "%filemd5%" == "4a 8b 42 61 85 9c 70 bf bd 8a b1 7b b4 f7 d9 8b" set threat=Win32-Trojan.Agent.CT
  if "%filemd5%" == "e9 59 d9 23 34 d5 4b 44 f7 ab da b3 5f b3 d6 10" set threat=Win32-Trojan.Agent.CU
  if "%filemd5%" == "f1 00 a2 69 6a a5 52 5e e1 86 99 e4 8c 28 48 ab" set threat=Win32-Trojan.Agent.CV
  if "%filemd5%" == "ce a1 9c 96 db 10 02 0f 0d 6e 5a e5 73 2b 15 cd" set threat=Win32-Trojan.Agent2dmdi
  if "%filemd5%" == "de 90 eb bd 62 0c b9 1d 30 9a 78 3a 3c 8b 8c 32" set threat=Win32-Trojan.Alerta.A
  if "%filemd5%" == "e8 ed 8a af 35 e6 05 9b a2 85 04 c1 9f f5 0b ab" set threat=Win32-Trojan.Alerta.B
  if "%filemd5%" == "67 d6 df 03 ea 6e 3b 62 91 98 91 a8 19 f2 d5 4a" set threat=Win32-Trojan.Alien
  if "%filemd5%" == "97 b7 c8 7d d6 d2 ef 46 54 64 8d 6e 22 1d 50 9a" set threat=Win32-Trojan.Assault
  if "%filemd5%" == "e2 3e 0f 1c b2 9e 46 bf b9 25 ef 8a 8e 5d e6 e2" set threat=Win32-Trojan.Bayrob.A
  if "%filemd5%" == "5f 1a 23 08 e9 77 30 b5 fe d0 76 69 ee 9f bd 11" set threat=Win32-Trojan.Bayrob.B
  if "%filemd5%" == "c0 3b f4 d4 c2 25 2a f5 ff 99 ee a0 06 35 14 f9" set threat=Win32-Trojan.Berok
  if "%filemd5%" == "a0 83 d5 ff 97 63 47 f1 cd 5b a1 d9 e3 a7 a4 b3" set threat=Win32-Trojan.Bizarro.A
  if "%filemd5%" == "e6 c3 37 d5 04 b2 d7 d8 0d 70 68 99 d9 64 ab 45" set threat=Win32-Trojan.Bizarro.B
  if "%filemd5%" == "da f0 28 dd ae 0e db d3 d7 94 6b b2 6c f0 5f bf" set threat=Win32-Trojan.Bizarro.C
  if "%filemd5%" == "73 47 26 98 fe 41 df 73 06 82 97 7c 8e 75 1a 3e" set threat=Win32-Trojan.Bizarro.D
  if "%filemd5%" == "51 84 77 6f 72 96 28 59 b7 04 f7 cc 37 04 60 ea" set threat=Win32-Trojan.Bizarro.E
  if "%filemd5%" == "ba 56 19 95 5e a6 31 ec f2 d8 f3 aa 82 fc e7 04" set threat=Win32-Trojan.Bizarro.F
  if "%filemd5%" == "7a 1c e2 f8 f7 14 36 7f 92 a3 1d a1 51 9a 3d e3" set threat=Win32-Trojan.Bizarro.G
  if "%filemd5%" == "04 03 d6 05 e6 41 8c bd f8 e9 46 73 6d 14 97 ad" set threat=Win32-Trojan.Bizarro.H
  if "%filemd5%" == "d6 e4 23 6a aa de 8c 90 36 69 66 d5 9e 73 55 68" set threat=Win32-Trojan.Bizarro.I
  if "%filemd5%" == "b0 d0 99 0b ee fa 11 c9 a7 8c 70 1e 2a a4 6f 87" set threat=Win32-Trojan.Bizarro.J
  if "%filemd5%" == "38 00 36 77 bf aa 1c 67 29 f7 fa 00 da 5c 91 09" set threat=Win32-Trojan.Bizarro.K
  if "%filemd5%" == "82 75 25 d6 97 cc 14 59 d9 da 0a 7d 84 0e db b6" set threat=Win32-Trojan.Bizarro.L
  if "%filemd5%" == "ad 5e 1e 4a c6 b4 43 94 b1 8d 6e 82 d5 4e 2d e1" set threat=Win32-Trojan.Blackshades
  if "%filemd5%" == "1b 9c 95 2b ca e2 ba 7f 44 c2 bf 09 4d 01 7f f8" set threat=Win32-Trojan.Bohmini
  if "%filemd5%" == "67 75 d2 02 e6 8f ec 88 26 97 27 a7 b0 6a 8c 63" set threat=Win32-Trojan.BSOD
  if "%filemd5%" == "72 dc fe ec b3 56 6f 9f 86 26 20 eb fd b5 f5 f9" set threat=Win32-Trojan.Cacogen
  if "%filemd5%" == "e1 7b d8 b5 28 5d 5d 2f ae f2 dc 17 24 24 0f 97" set threat=Win32-Trojan.CDEject.A
  if "%filemd5%" == "21 45 00 72 12 75 9f 55 aa 21 f2 60 15 ba 73 10" set threat=Win32-Trojan.CDEject.B
  if "%filemd5%" == "06 67 05 f4 bd cc 1b 77 73 4e 93 d2 33 cc 8a 91" set threat=Win32-Trojan.CDEject.C
  if "%filemd5%" == "df cc b6 de 7a c3 45 42 a7 1d fa 57 09 dc 07 66" set threat=Win32-Trojan.CDEject.D
  if "%filemd5%" == "2b b7 28 10 f2 66 b9 ea d7 57 dc 63 f0 de 31 36" set threat=Win32-Trojan.CDEject.E
  if "%filemd5%" == "3b 0e 7b 46 3f 74 98 75 14 85 ce 5d 04 4b 3f 95" set threat=Win32-Trojan.CDEject.F
  if "%filemd5%" == "4f dc 35 aa 37 d4 df 3f 9f 17 d4 4a 33 40 71 38" set threat=Win32-Trojan.Chapak
  if "%filemd5%" == "02 9c e2 e5 32 fe 5c 70 d3 34 2f 97 8f 54 63 d0" set threat=Win32-Trojan.ClipBanker
  if "%filemd5%" == "ca bf 56 ad b1 c6 3c 09 b2 48 85 62 cf 28 1b 0b" set threat=Win32-Trojan.Coins
  if "%filemd5%" == "f7 bb 82 b0 e6 65 b4 94 bc eb ef c7 35 1f 46 c5" set threat=Win32-Trojan.ComRAT
  if "%filemd5%" == "bd 76 41 92 e9 51 b5 af d5 68 70 d2 08 4b cc fd" set threat=Win32-Trojan.DarkHydrusScripter.A
  if "%filemd5%" == "95 3a 75 3d d4 94 4c 9a 2b 98 76 b0 90 bf 7c 00" set threat=Win32-Trojan.DarkHydrusScripter.B
  if "%filemd5%" == "c7 32 3e 63 58 41 98 0e 38 12 9b 3a 5a 90 b0 da" set threat=Win32-Trojan.Datper
  if "%filemd5%" == "84 69 43 dc 3e b9 e8 7e 1b 89 ac 9a 80 cd 82 7a" set threat=Win32-Trojan.DelTree
  if "%filemd5%" == "d5 40 ca 29 e9 ea 33 f1 31 e4 ce 46 74 d1 08 5f" set threat=Win32-Trojan.Denes.A
  if "%filemd5%" == "6e db fc c6 44 5a f5 82 63 0f a2 4d a5 f9 03 35" set threat=Win32-Trojan.Denes.B
  if "%filemd5%" == "bf ad 33 8c f7 bc f5 d8 cb a2 60 d1 66 b1 be 28" set threat=Win32-Trojan.Denes.C
  if "%filemd5%" == "2f 8f 6e 90 ca 21 1d 7e f5 f6 cf 3c 99 5a 40 e7" set threat=Win32-Trojan.DesktopPuzzle
  if "%filemd5%" == "25 84 fd c9 30 66 7c 94 2b 2c d0 31 9d 68 51 07" set threat=Win32-Trojan.DoS.A
  if "%filemd5%" == "26 a7 81 f1 b4 d7 a9 ba 04 1a 4d a1 cf 90 e2 c7" set threat=Win32-Trojan.DoS.B
  if "%filemd5%" == "51 8e 19 33 ec e4 d9 57 eb e0 50 64 57 50 bf 40" set threat=Win32-Trojan.Dridex.A
  if "%filemd5%" == "97 30 d0 9c 41 f2 5f 63 f4 50 8d ee 90 a7 4c 61" set threat=Win32-Trojan.Dridex.B
  if "%filemd5%" == "f5 97 17 fb 8f 2a 9a d3 e5 f7 16 40 94 0f 1c 08" set threat=Win32-Trojan.Emotet.A
  if "%filemd5%" == "d3 ff 42 73 09 6c 13 af a8 8c 71 31 c4 14 f9 3b" set threat=Win32-Trojan.Emotet.B
  if "%filemd5%" == "8d 7e a5 5f f7 f8 74 c0 98 b2 3c a2 ad f4 0b 71" set threat=Win32-Trojan.Emotet.C
  if "%filemd5%" == "ac 54 76 ae 5a 15 a0 98 1e 7e 56 f9 51 60 1c 82" set threat=Win32-Trojan.Icefog
  if "%filemd5%" == "b4 47 22 b1 97 ec 49 5c ee 00 bf f3 73 b2 a3 f7" set threat=Win32-Trojan.Invader
  if "%filemd5%" == "9e 28 4c 15 f0 31 ab 67 5b 1a 89 86 4f f3 d0 d5" set threat=Win32-Trojan.KillWin
  if "%filemd5%" == "07 18 75 df 86 3f 4a ea 3c 89 fb e4 1b 52 d1 9c" set threat=Win32-Trojan.Klone
  if "%filemd5%" == "b5 96 e7 ca cb ad 1e 81 4b 0c d0 53 08 6c 49 00" set threat=Win32-Trojan.LOIC
  if "%filemd5%" == "31 42 02 27 14 1a de 98 a5 a5 22 8b f8 e6 a9 7d" set threat=Win32-Trojan.LoveYou
  if "%filemd5%" == "bd b7 72 d1 de 76 75 ef 71 d9 22 75 cb ea 8f ad" set threat=Win32-Trojan.MakeDirs.A
  if "%filemd5%" == "5a f2 32 cf da f5 1d 4d 63 b2 48 d6 70 18 6b 6a" set threat=Win32-Trojan.MakeDirs.B
  if "%filemd5%" == "72 46 a7 52 86 49 33 3d c6 4b 03 e4 6d 84 c9 f0" set threat=Win32-Trojan.McRat.A
  if "%filemd5%" == "95 5a 22 87 fb 56 0b 1b 9f 98 ae 13 1a 13 55 8b" set threat=Win32-Trojan.McRat.B
  if "%filemd5%" == "a7 bc f7 ea 8e 9f 3f 36 eb fb 85 b8 23 e3 9d 91" set threat=Win32-Trojan.MEMZ.A
  if "%filemd5%" == "19 db ec 50 73 5b 5f 2a 72 d4 19 9c 4e 18 49 60" set threat=Win32-Trojan.MEMZ.B
  if "%filemd5%" == "73 c7 9f 84 36 1f c8 d7 4e c5 3c 36 e0 7b 39 e6" set threat=Win32-Trojan.Minzen.A
  if "%filemd5%" == "c5 d1 62 6c a6 73 76 53 2a f2 53 c9 67 3b 11 01" set threat=Win32-Trojan.Minzen.B
  if "%filemd5%" == "38 ff 71 c1 de e2 a9 ad d6 7f 1e db 1a 30 ff 8c" set threat=Win32-Trojan.MrsMajor.A
  if "%filemd5%" == "83 c5 20 4b ac b4 9b 83 af ec ea 31 be af 1f 63" set threat=Win32-Trojan.MrsMajor.B
  if "%filemd5%" == "45 0f 49 42 6b 45 19 ec aa c8 cd 04 81 4c 03 a4" set threat=Win32-Trojan.MrsMajor.C
  if "%filemd5%" == "8f 1b 40 26 4a 0e df 5a 95 88 d4 3a 8d 67 df e7" set threat=Win32-Trojan.MuddyWater
  if "%filemd5%" == "6b 31 16 58 0d 29 02 0b 9c 25 98 77 ac 18 a7 fd" set threat=Win32-Trojan.Nazar.A
  if "%filemd5%" == "c1 ab 32 af b0 e2 d7 b7 b1 ca d3 fb 83 1e 93 73" set threat=Win32-Trojan.Nazar.B
  if "%filemd5%" == "9e 98 9e f2 a8 d4 bc 5b a1 42 11 43 aa d5 9a 47" set threat=Win32-Trojan.NetShield
  if "%filemd5%" == "21 56 f6 e4 df 94 16 00 fe 3f 44 d0 71 09 35 4e" set threat=Win32-Trojan.OpenDNS
  if "%filemd5%" == "04 25 1a 49 a2 40 db f6 09 75 ac 26 2f c6 ae b7" set threat=Win32-Trojan.PCToaster
  if "%filemd5%" == "18 1d 4f 01 c8 d6 d1 ab ae 08 47 ce 74 e2 42 68" set threat=Win32-Trojan.Plugax
  if "%filemd5%" == "01 81 85 02 39 cd 26 b8 fb 8b 72 af b0 e9 5e ac" set threat=Win32-Trojan.Poweliks
  if "%filemd5%" == "f0 b6 d1 4e b0 b4 e1 24 81 2f db 9a 87 0a bc 43" set threat=Win32-Trojan.Qakbot
  if "%filemd5%" == "77 ad 29 1b 0b 88 a7 31 4c 1d d8 11 d6 69 e0 77" set threat=Win32-Trojan.RandomMusic
  if "%filemd5%" == "de 51 6f bb c0 9f ca dd 95 39 c2 80 9c f4 ff 9b" set threat=Win32-Trojan.Reconyc
  if "%filemd5%" == "33 6e ff e8 44 da ab 0e f3 88 fe 60 02 81 17 de" set threat=Win32-Trojan.Remtasu
  if "%filemd5%" == "a9 c6 7b 0f c1 c8 16 32 f1 34 f2 bd f4 67 8e 21" set threat=Win32-Trojan.Resonate.A
  if "%filemd5%" == "ad 4d 5e da b2 ce 61 e9 22 44 dc ec c0 49 b8 66" set threat=Win32-Trojan.Resonate.B
  if "%filemd5%" == "c4 65 0a d4 38 3f cb e1 ae 27 b2 69 d4 12 01 ba" set threat=Win32-Trojan.SpBit
  if "%filemd5%" == "8e 90 ad 82 52 86 72 49 cc 5c be e3 19 9d ef 2f" set threat=Win32-Trojan.SpyAnyTime
  if "%filemd5%" == "66 87 03 e9 82 3d d3 8b e6 9f d0 ff 6b c1 0b 6a" set threat=Win32-Trojan.Stihat.A
  if "%filemd5%" == "a0 b3 f2 bc a9 90 f8 ed e2 e7 70 10 61 d2 69 fb" set threat=Win32-Trojan.Stihat.B
  if "%filemd5%" == "da e3 5a a5 b7 74 6f 65 d9 a2 56 61 d7 5f c3 23" set threat=Win32-Trojan.Stihat.C
  if "%filemd5%" == "93 29 0c 14 35 c6 0b e7 87 ca 00 51 30 ab ad 34" set threat=Win32-Trojan.Stihat.D
  if "%filemd5%" == "04 43 36 3e 99 a6 0a 5f 48 c1 18 8d 2a 94 d8 f9" set threat=Win32-Trojan.Stihat.E
  if "%filemd5%" == "06 dd 7f e0 68 5d 9f d9 d1 a3 0f 6c 72 0b 6a f9" set threat=Win32-Trojan.Stihat.F
  if "%filemd5%" == "b9 70 9a 07 05 9b b0 80 57 34 39 80 e9 79 de 2f" set threat=Win32-Trojan.Tremp
  if "%filemd5%" == "3d 3e 08 ad 3a 8f 3b 35 b9 a1 0a a6 c5 7b 29 0f" set threat=Win32-Trojan.Trickbot
  if "%filemd5%" == "2e 03 d0 10 bb 51 43 16 df b9 cf 2d 87 a6 63 21" set threat=Win32-Trojan.Updane
  if "%filemd5%" == "79 9b 57 22 75 61 23 8a 7d 7a 28 4c 55 68 c1 ad" set threat=Win32-Trojan.Whiter
  if "%filemd5%" == "d3 77 21 bf 26 96 24 84 72 99 47 a7 2b bc 9b ad" set threat=Win32-Trojan.WindowBomb.A
  if "%filemd5%" == "bf 13 f3 b2 b0 a2 73 b9 c7 15 12 2e 01 57 19 35" set threat=Win32-Trojan.WindowBomb.B
  if "%filemd5%" == "14 79 76 57 9c 32 2b a4 1d 10 eb 85 b0 ad 64 dd" set threat=Win32-Trojan.WindowBomb.C
  if "%filemd5%" == "75 d8 97 12 72 1a 4d d3 2b 2c 0b b5 99 9f 8c ab" set threat=Win32-Trojan.WindowBomb.D
  if "%filemd5%" == "79 44 94 70 a3 57 7f 17 09 c8 f7 bc 71 5e 98 85" set threat=Win32-Trojan.WindowBomb.E
  if "%filemd5%" == "4c 79 7c 53 7f 29 b4 15 d0 94 e9 c4 21 b4 15 e0" set threat=Win32-Trojan.WindowBomb.F
  if "%filemd5%" == "40 22 84 58 ca 45 5d 28 e3 39 51 a2 f3 84 42 09" set threat=Win32-Trojan.Zika
  if "%filemd5%" == "b7 65 3a 04 9d 31 3c e5 52 09 8f 49 b5 f8 82 f5" set threat=Win32-Trojan.Zlob
  if "%filemd5%" == "13 23 8b f4 b2 8c a4 f1 31 dd 4a 53 23 69 9f 68" set threat=Win32-Unruy
  if "%filemd5%" == "e5 e7 96 89 db e8 3e 59 ee 5b 6a 22 5d e9 be d8" set threat=Win32-Virlock.A
  if "%filemd5%" == "cf de f9 29 1b e8 bf e8 42 3e c5 2d 6f b3 b8 cb" set threat=Win32-Virlock.B
  if "%filemd5%" == "89 0f 9b d0 04 6e ef 19 ed 81 32 2d 19 65 f6 42" set threat=Win32-Virlock.C
  if "%filemd5%" == "a6 60 c8 17 17 65 9f 5b 2d d4 fe 7a 8a fb 54 2d" set threat=Win32-Virlock.D
  if "%filemd5%" == "da b8 55 a4 40 4d d5 57 54 54 ba 74 1f 65 b1 32" set threat=Win32-Virlock.E
  if "%filemd5%" == "00 df 6b 2a 7c 3b 3f d4 28 8f 29 ae 80 9e 0f 53" set threat=Win32-Virlock.F
  if "%filemd5%" == "fd 5d 3c 1a de 28 5f 3b 54 9e 80 27 8a b9 07 19" set threat=Win32-Virlock.G
  if "%filemd5%" == "f8 e1 94 06 c9 d1 b6 9e 13 8b e8 cd 35 1d 36 62" set threat=Win32-VirusPack3
  if "%filemd5%" == "a8 51 a9 68 f7 17 ed 30 a9 da ea 4d 88 fd d8 df" set threat=Win32-Virut.A
  if "%filemd5%" == "84 b9 6a 3d 44 c0 8a 22 1d 13 93 1c e8 e3 fd 4e" set threat=Win32-Virut.B
  if "%filemd5%" == "ec 2b 6e cf c8 ca 67 f9 35 7b 65 50 16 6a 08 38" set threat=Win32-Virut.C
  if "%filemd5%" == "49 26 80 07 ac 21 21 aa e8 1f 72 91 03 ec 8f 81" set threat=Win32-Virut.D
  if "%filemd5%" == "bd 32 86 68 71 75 82 be b0 e1 32 d3 12 83 0c 3a" set threat=Win32-Virut.E
  if "%filemd5%" == "76 93 0e 7b a5 d6 11 cd ea 2a f9 3a 78 3c 80 ca" set threat=Win32-Virut.F
  if "%filemd5%" == "53 29 50 cd 94 48 93 c7 36 71 9f de 46 3a 10 31" set threat=Win32-Vtflooder
  if "%filemd5%" == "25 27 29 b2 30 4c dc 2e 91 24 8c ea 56 72 41 eb" set threat=Win32-Wallpaper
  if "%filemd5%" == "c8 2b 6d 5a 84 96 06 4a bb 5e 66 a2 6a a6 71 7b" set threat=Win32-Winfig
  if "%filemd5%" == "02 73 ed 44 d5 87 4d c3 03 90 15 16 3b c8 91 32" set threat=Win32-Worm.Agent.A
  if "%filemd5%" == "e8 4f a2 88 8b 01 e3 98 cc 13 90 36 fe 5b 92 21" set threat=Win32-Worm.Agent.B
  if "%filemd5%" == "d7 4c f2 ca 99 82 e4 77 d2 2c f3 2f e5 da 49 dc" set threat=Win32-Worm.Alcaul
  if "%filemd5%" == "97 4a dd e7 ad 94 76 3c 18 fe 24 8f a4 83 9f 1e" set threat=Win32-Worm.Allaple
  if "%filemd5%" == "39 c8 5a 0d 84 7a a2 1c 7d ed d6 9d ca 7a e9 bc" set threat=Win32-Worm.Badtrans
  if "%filemd5%" == "70 f5 49 ae 7f af c4 25 a4 c5 44 72 93 f0 4f db" set threat=Win32-Worm.Bugsoft.A
  if "%filemd5%" == "a7 25 af 7c 07 b5 25 49 02 3b e7 33 28 e5 58 09" set threat=Win32-Worm.Bugsoft.B
  if "%filemd5%" == "2b f4 8d 55 d1 70 79 dd 33 de 99 83 81 53 ed a9" set threat=Win32-Worm.Bugsoft.C
  if "%filemd5%" == "1b 9f 35 3d cb 52 81 3c 85 43 65 79 d5 9a 9e f8" set threat=Win32-Worm.Bugsoft.D
  if "%filemd5%" == "49 2c b4 7d 84 43 68 06 38 28 cd 74 c5 18 5a 1f" set threat=Win32-Worm.Calposa
  if "%filemd5%" == "ae 51 f8 6d 67 41 6f e3 1b 8b 78 1e c6 67 6c 98" set threat=Win32-Worm.Codegreen
  if "%filemd5%" == "6f 57 67 ec 5a 9c c6 f7 d1 95 dd e3 c3 93 91 20" set threat=Win32-Worm.CodeRed.A
  if "%filemd5%" == "0b ba 28 8e 55 ed 34 b5 eb c7 6f 86 5a 53 2c bf" set threat=Win32-Worm.CodeRed.B
  if "%filemd5%" == "2e 8d a5 a5 58 65 a0 91 86 4a 43 38 ef 4d 2e 44" set threat=Win32-Worm.Conficker.A
  if "%filemd5%" == "57 4c f0 06 29 11 c8 c4 ec a2 15 61 87 b8 20 7d" set threat=Win32-Worm.Conficker.B
  if "%filemd5%" == "55 b1 d7 5a bc 52 55 21 ae 50 fd b4 b3 29 c2 a7" set threat=Win32-Worm.Conficker.C
  if "%filemd5%" == "ff bf b0 11 0a b6 37 e6 7e 9a b3 8c 8d 0b 9c 41" set threat=Win32-Worm.Daprosy
  if "%filemd5%" == "fd cd a5 5b 16 42 6a 6f ed 53 d9 19 e3 1b 3d 23" set threat=Win32-Worm.Dumaru
  if "%filemd5%" == "2c 36 69 9a bc 71 f6 d2 0c 1c 5f 77 83 9a 23 4a" set threat=Win32-Worm.Duqu
  if "%filemd5%" == "05 5f cc cc ba 60 2b 81 cf 14 49 59 7a 20 74 31" set threat=Win32-Worm.ExploreZip
  if "%filemd5%" == "d2 a5 f4 b7 69 de 0f 89 d5 91 fd 05 05 b6 e5 84" set threat=Win32-Worm.Fix2001
  if "%filemd5%" == "a8 9c 0e d6 ef 75 17 9a db 6f 52 24 01 02 b9 b2" set threat=Win32-Worm.Fizzer
  if "%filemd5%" == "a1 3a 4d b8 60 d7 43 a0 88 ef 7a b9 ba cb 4d da" set threat=Win32-Worm.Funsoul
  if "%filemd5%" == "b0 fe cc dd d7 80 39 ae d7 f1 d6 8d ae 4d 73 d3" set threat=Win32-Worm.Gruel.A
  if "%filemd5%" == "7c a3 67 ec a8 a0 c8 1d 6a ac 58 62 bf c3 32 e5" set threat=Win32-Worm.Gruel.B
  if "%filemd5%" == "7b e1 1e 47 68 97 5c 53 df c8 b8 b6 dc 26 7e 5c" set threat=Win32-Worm.Gruel.C
  if "%filemd5%" == "02 dd 0e aa 96 49 a1 1e 55 fa 54 67 fa 4b 8e f8" set threat=Win32-Worm.Happy99
  if "%filemd5%" == "c8 f7 94 fe 1e 95 64 24 df a1 68 67 91 fa ec ba" set threat=Win32-Worm.Lentin
  if "%filemd5%" == "ff f3 d0 4d ee a4 79 e4 b2 03 26 e2 f0 64 c5 d9" set threat=Win32-Worm.Mabezat.A
  if "%filemd5%" == "90 d1 e1 2a b8 09 05 8a 0a 17 01 74 90 b7 8c 3c" set threat=Win32-Worm.Mabezat.B
  if "%filemd5%" == "05 c7 19 82 6c 0a f2 06 b3 b4 b7 45 cb f8 8d 6a" set threat=Win32-Worm.Mabezat.C
  if "%filemd5%" == "98 2f 02 f6 1d d9 ce a1 ad 96 2a f2 fe 90 42 73" set threat=Win32-Worm.Merkur
  if "%filemd5%" == "bd 86 e7 62 7d 29 10 d6 7b f3 d9 49 86 27 54 5a" set threat=Win32-Worm.Mimail.A
  if "%filemd5%" == "b6 ab 9c 65 81 7e 91 43 76 82 2e aa b8 e0 3e 36" set threat=Win32-Worm.Mimail.B
  if "%filemd5%" == "db 5f 43 0b df d6 ba cc e9 66 4a c2 6e 75 7f 65" set threat=Win32-Worm.Mimail.C
  if "%filemd5%" == "2e df 96 05 26 13 c6 34 a3 41 2f bf 88 ad db 0e" set threat=Win32-Worm.Mimail.D
  if "%filemd5%" == "d8 0d 93 1c 28 48 bf c0 cc 6d cb 47 90 ed 34 3a" set threat=Win32-Worm.Mimail.E
  if "%filemd5%" == "79 2b 09 82 c2 3c fe d0 d6 5c a8 ed 2e ed fc 28" set threat=Win32-Worm.Mimail.F
  if "%filemd5%" == "0e 93 79 e3 57 ab a9 5f 8b 98 83 af 9b 67 67 5e" set threat=Win32-Worm.Mimail.G
  if "%filemd5%" == "7b 7c 04 22 88 8e f1 0f 88 27 ab 6c 18 5f 99 d1" set threat=Win32-Worm.Mimail.H
  if "%filemd5%" == "d6 a3 6c 90 17 a9 29 c2 1e 13 97 a5 27 27 9f 34" set threat=Win32-Worm.MTX.A
  if "%filemd5%" == "db 8b e5 21 c3 3d 7c 88 2a db 27 6c 1b 78 09 40" set threat=Win32-Worm.MTX.B
  if "%filemd5%" == "7c a3 9f 54 a3 f7 1a 38 31 e6 0f 5a 38 3f 6a 49" set threat=Win32-Worm.Myparty.A
  if "%filemd5%" == "28 33 dd 60 6c ce 95 cc 8f cf b4 45 11 01 87 58" set threat=Win32-Worm.Myparty.B
  if "%filemd5%" == "79 06 fc aa 6a 8c 84 49 f7 66 dd 46 c6 60 61 5d" set threat=Win32-Worm.Myparty.C
  if "%filemd5%" == "cd 3c 9f 54 8d dc b2 98 95 fb 50 33 aa 0e aa ff" set threat=Win32-Worm.Mytob.A
  if "%filemd5%" == "60 ec da 54 ce f0 a5 a6 ef d7 99 aa 35 63 94 f5" set threat=Win32-Worm.Mytob.A
  if "%filemd5%" == "da 9d ba 70 de 70 dc 43 d6 53 5f 29 75 ce c6 8d" set threat=Win32-Worm.Naked
  if "%filemd5%" == "1c 66 90 4e cb 84 6d a5 b1 fb 20 72 f9 ea 6e 0e" set threat=Win32-Worm.Nyxem
  if "%filemd5%" == "71 c9 81 d4 f5 31 6c 3a d1 de ef e4 8f dd b9 4a" set threat=Win32-Worm.Opaserv
  if "%filemd5%" == "d2 92 f1 40 08 64 81 fc 51 d2 a6 04 50 f9 0d 1b" set threat=Win32-Worm.Oror
  if "%filemd5%" == "2d 89 84 8d 03 6a 54 8a 61 3a 36 1e 4c 1d 66 b0" set threat=Win32-Worm.Runouce
  if "%filemd5%" == "63 db 72 35 16 db 09 bf 83 79 38 25 4e 8c b1 d3" set threat=Win32-Worm.Silver
  if "%filemd5%" == "55 0f cf 53 23 7d 4d 3d 1f 13 cf 32 eb 18 23 2e" set threat=Win32-Worm.Sircam
  if "%filemd5%" == "7a 3b c4 d1 3b 83 c9 6f 5b f1 3b 17 d8 5d 28 95" set threat=Win32-Worm.Swen.A
  if "%filemd5%" == "b0 9e 26 c2 92 75 9d 65 46 33 d3 c8 ed 00 d1 8d" set threat=Win32-Worm.Swen.B
  if "%filemd5%" == "d5 d1 77 de 6c 4d 68 87 3b 7a 1f de 30 9b d7 2c" set threat=Win32-Worm.Swen.C
  if "%filemd5%" == "1a d3 27 5a c6 60 aa 26 76 92 01 86 1e 29 99 70" set threat=Win32-Worm.Swen.D
  if "%filemd5%" == "ba 6b d0 ba 81 12 a7 5e b7 0e b3 01 71 7a a9 bc" set threat=Win32-Worm.Totilix
  if "%filemd5%" == "e7 9d 0b 1a 34 27 12 ea 9b 96 10 40 86 14 9d 65" set threat=Win32-Worm.Winevar
  if "%filemd5%" == "7b c3 22 d9 59 51 df e1 6e 8c f4 7e e5 86 e9 09" set threat=Win95-CIH.A
  if "%filemd5%" == "dc 40 29 6f 43 5a 8b 3a c6 c0 24 d6 dc ee cd df" set threat=Win95-CIH.B
  if "%filemd5%" == "99 d3 fd 29 85 01 2d 43 c3 d5 32 cf 1f 70 b3 42" set threat=Win95-CIH.C

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
  echo (DECRYPT) - if ransomware was detected, finds a way to decrypt encrypted files
  echo (DELETE) - deletes the file
  echo (QUARANTINE) - quarantines the file
  echo (TERMINATE) - forcibly terminates all tasks provided by the threat, then returns to this point
  echo (IGNORE) - ignores the threat
  echo.
  find /i /c "Behavior" pts_autoaction2.txt >NUL
  if %errorlevel% equ 0 (
    set /p choice="Enter your choice: "
    if /i "%choice%" == "decrypt" goto decrypt
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
  
:decrypt
  echo.
  %threat% > threat.txt
  find /i /c "Dharma" threat.txt > NUL
  if %errorlevel% == 0 start /max https://media.kaspersky.com/utilities/VirusUtilities/EN/RakhniDecryptor.zip
  del threat.txt
  echo If nothing happened, Protectish Total Security doesn't know how to decrypt your files.
  pause
  goto md5_threat

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

  find /i /c "67.231.149.140" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "96.47.72.85" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "184.168.221.67" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "14.17.102.104" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "35.186.238.101" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "120.79.208.189" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "151.139.128.14" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "198.181.163.103" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "173.232.146.37" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "winoxior.tk" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "lywja.healthsvsolu.com" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "krjregh.sacreeflame.com" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "news.softfix.co.kr" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "bbs.gokickes.com" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "www.gokickes.com" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "arinas.tk" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "bedrost.com" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "branter.tk" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "bronerg.tk" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "celestyna.tk" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "crusider.tk" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "davilta.tk" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
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
  find /i /c "xmrig.exe" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-CoinMiner.XMRig
  find /i /c "xmrig.com" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-CoinMiner.XMRig
  find /i /c "777777d" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Malware.Generic  
  find /i /c "zincite" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-MyDoom
  find /i /c "! Best regards 2 Tommy Salo. [Nov-2005] yours [Dziadulja Apanas]" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Neshta
  find /i /c "e-mailer.cf" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Phishing.Generic
  find /i /c "e-mailer.ga" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Phishing.Generic
  find /i /c "nwa-oma2.ml" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Phishing.Generic
  find /i /c "routermanager.ga" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Phishing.Generic
  find /i /c "routermanager.gq" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Phishing.Generic
  find /i /c "routermanagers.ga" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Phishing.Generic
  find /i /c "routermanagers.gq" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Phishing.Generic
  find /i /c "Visit our web service at caforssztxqzf2nm.onion" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.BadRabbit
  find /i /c "encrypter@tuta.io" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.CryptoJoker
  find /i /c "I am NocryCrypt0r" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.CryptoJoker
  find /i /c "DANGEROUS_RANSOM" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Dangerous
  find /i /c "ox0ku!" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Darkside
  find /i /c "NitroRansomware.exe" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.DiscordNitro
  find /i /c "bapcocrypt@ctemplar.com" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Ekans
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
  find /i /c "Decrypt.txt" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic 
  find /i /c "DecryptFiles.txt" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic 
  find /i /c "Decrypt-Files.txt" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic 
  find /i /c "DecryptFilesHere.txt" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic 
  find /i /c "DECRYPT_INSTRUCTION.TXT" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic 
  find /i /c "FILES ENCRYPTED.txt" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "DECRYPT MY FILES" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic 
  find /i /c "DECRYPT-MY-FILES" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic 
  find /i /c "DECRYPT_MY_FILES" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic 
  find /i /c "DECRYPT YOUR FILES" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic 
  find /i /c "DECRYPT-YOUR-FILES" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic 
  find /i /c "DECRYPT_YOUR_FILES" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic 
  find /i /c "DECRYPT FILES.txt" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "HowToDecrypt.txt" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "how to decrypt my files.txt" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "DecryptGuide.txt" %file% > NUL
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
  find /i /c "www.tempinfo.96.lt" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "bcdedit /set {default} bootstatuspolicy ignoreallfailures" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "bcdedit /set {default} recoveryenabled no" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "wbadmin delete catalog" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "wbadmin delete systemstatebackup" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "wbadmin delete backup" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "wmic shadowcopy delete" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "vssadmin delete shadows" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Generic
  find /i /c "janelle2021@protonmail.com" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Janelle
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
  find /i /c "6+7T7g7w7" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Maze
  find /i /c "MindSystemNotRansomWare" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.MindSystem
  find /i /c "aes_key_rand" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Ragnarok
  find /i /c "helpdecryptmyfiles@yandex.com" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Redeemer
  find /i /c "ShellLocker.My.Resources" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.ShellLocker
  find /i /c "Brouillettebusiness@outlook.com" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Sodinokibi
  find /i /c "steriok@mail2tor.com" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Thanos
  find /i /c "proper12132@tutanota.com" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Thanos
  find /i /c "miclejaps@msgden.net" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.VHD
  find /i /c "stevenjoker@msgden.net" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.VHD
  find /i /c "CulibDoett@gmail.com" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.VHD
  find /i /c "ha7medtit@tutanota.com" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.VHD
  find /i /c "araujosantos@protonmail.com" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.VHD
  find /i /c "www.iuqerfsodp9ifjaposdfjhgosurijfaewrwergwea.com" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.WannaCryptor
  find /i /c "mssecsvc.exe" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.WannaCryptor
  find /i /c "tasksche.exe" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.WannaCryptor
  find /i /c "taskdl.exe" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.WannaCryptor
  find /i /c "WNcry@2ol7" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.WannaCryptor
  find /i /c "PE hP(" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Ransom.Zeppelin
  find /i /c "Injecting into process" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-RAT.Generic
  find /i /c "Opening process..." %file% > NUL
  if %errorlevel% == 0 set threat=Win32-RAT.Generic
  find /i /c "Failed to inject" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-RAT.Generic
  find /i /c "XL-FORCE ApS" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-RAT.NetWire
  find /i /c "j.maxmind.com" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Rootkit.ZeroAccess
  find /i /c "\SnakeKeylogger\" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-SnakeKeylogger
  find /i /c "-------- Snake Keylogger --------" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-SnakeKeylogger
  find /i /c "Amcert LLC" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Spyware.RedLine
  find /i /c "adshield.pro" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Trojan.AdShield
  find /i /c "WOODTALE TECHNOLOGY INC" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Trojan.Generic
  find /i /c "Flyingbird Technology Limited" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Trojan.Generic
  find /i /c "Neoact Co., Ltd." %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Trojan.Generic
  find /i /c "AmazGame Age Internet Technology Co., Ltd" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Trojan.Generic
  find /i /c "EMG Technology Limited" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Trojan.Generic
  find /i /c "Zemi Interactive Co., Ltd" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Trojan.Generic
  find /i /c "337 Technology Limited" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Trojan.Generic
  find /i /c "Runewaker Entertainment0" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Trojan.Generic
  find /i /c "vboxsvr.ovh.net" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Trojan.Generic
  find /i /c "The software you just executed is considered malware. This malware will harm your computer and makes it unusable. If you are seeing this message without knowing what you just executed, simply press" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Trojan.MEMZ
  find /i /c "visit our friendly site www.blackgate.us" %file% > NUL
  if %errorlevel% == 0 set threat=Win32-Worm.Mimail


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
