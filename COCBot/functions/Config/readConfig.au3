; #FUNCTION# ====================================================================================================================
; Name ..........: readConfig.au3
; Description ...: Reads config file and sets variables
; Syntax ........: readConfig()
; Parameters ....: NA
; Return values .: NA
; Author ........:
; Modified ......: CodeSlinger69 (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func readConfig($inputfile = $g_sProfileConfigPath) ;Reads config and sets it to the variables
   Static $iReadConfigCount = 0
   $iReadConfigCount += 1
   SetDebugLog("readConfig(), call number " & $iReadConfigCount)

    ; Read the stats files into arrays, will create the files if necessary
	$aWeakBaseStats = readWeakBaseStats()

	If FileExists($g_sProfileBuildingPath) Then ReadBuildingConfig()
	If FileExists($g_sProfileConfigPath) Then ReadRegularConfig()
EndFunc   ;==>readConfig

Func ReadBuildingConfig()
	 SetDebugLog("Read Building Config " & $g_sProfileBuildingPath)
	 Local $locationsInvalid = False
	 Local $buildingVersion = "0.0.0"
	 IniReadS($buildingVersion, $g_sProfileBuildingPath, "general", "version", $buildingVersion)
	 Local $_ver630 = GetVersionNormalized("6.3.0")
	 Local $_ver63u = GetVersionNormalized("6.3.u")
	 Local $_ver63u3 = GetVersionNormalized("6.3.u3")
	 If $buildingVersion < $_ver630 _
	 Or ($buildingVersion >= $_ver63u And $buildingVersion <= $_ver63u3) Then
		 SetLog("New MyBot.run version! Re-locate all buildings!", $COLOR_WARNING)
		 $locationsInvalid = True
	 EndIf

	 IniReadS($iTownHallLevel, $g_sProfileBuildingPath, "other", "LevelTownHall", 0, "int")

	 If $locationsInvalid = False Then
		 IniReadS($TownHallPos[0], $g_sProfileBuildingPath, "other", "xTownHall", -1, "int")
		 IniReadS($TownHallPos[1], $g_sProfileBuildingPath, "other", "yTownHall", -1, "int")

		 IniReadS($aCCPos[0], $g_sProfileBuildingPath, "other", "xCCPos", -1, "int")
		 IniReadS($aCCPos[1], $g_sProfileBuildingPath, "other", "yCCPos", -1, "int")

		 ;IniReadS($barrackPos[0][0], $g_sProfileBuildingPath, "other", "xBarrack1", -1, "int")
		 ;IniReadS($barrackPos[0][1], $g_sProfileBuildingPath, "other", "yBarrack1", -1, "int")

		 ;IniReadS($barrackPos[1][0], $g_sProfileBuildingPath, "other", "xBarrack2", -1, "int")
		 ;IniReadS($barrackPos[1][1], $g_sProfileBuildingPath, "other", "yBarrack2", -1, "int")

		 ;IniReadS($barrackPos[2][0], $g_sProfileBuildingPath, "other", "xBarrack3", -1, "int")
		 ;IniReadS($barrackPos[2][1], $g_sProfileBuildingPath, "other", "yBarrack3", -1, "int")

		 ;IniReadS($barrackPos[3][0], $g_sProfileBuildingPath, "other", "xBarrack4", -1, "int")
		 ;IniReadS($barrackPos[3][1], $g_sProfileBuildingPath, "other", "yBarrack4", -1, "int")

		 ;IniReadS($SFPos[0], $g_sProfileBuildingPath, "other", "xspellfactory", -1, "int")
		 ;IniReadS($SFPos[1], $g_sProfileBuildingPath, "other", "yspellfactory", -1, "int")

		 ;IniReadS($DSFPos[0], $g_sProfileBuildingPath, "other", "xDspellfactory", -1, "int")
		 ;IniReadS($DSFPos[1], $g_sProfileBuildingPath, "other", "yDspellfactory", -1, "int")

		 IniReadS($KingAltarPos[0], $g_sProfileBuildingPath, "other", "xKingAltarPos", -1, "int")
		 IniReadS($KingAltarPos[1], $g_sProfileBuildingPath, "other", "yKingAltarPos", -1, "int")

		 IniReadS($QueenAltarPos[0], $g_sProfileBuildingPath, "other", "xQueenAltarPos", -1, "int")
		 IniReadS($QueenAltarPos[1], $g_sProfileBuildingPath, "other", "yQueenAltarPos", -1, "int")

		 IniReadS($WardenAltarPos[0], $g_sProfileBuildingPath, "other", "xWardenAltarPos", -1, "int")
		 IniReadS($WardenAltarPos[1], $g_sProfileBuildingPath, "other", "yWardenAltarPos", -1, "int")

		 IniReadS($aLabPos[0], $g_sProfileBuildingPath, "upgrade", "LabPosX", -1, "int")
		 IniReadS($aLabPos[1], $g_sProfileBuildingPath, "upgrade", "LabPosY", -1, "int")
	 EndIf

	 IniReadS($TotalCamp, $g_sProfileBuildingPath, "other", "totalcamp", 0, "int")

	 For $iz = 0 To UBound($g_avBuildingUpgrades, 1) - 1 ; Reads Upgrade building data
		 $g_avBuildingUpgrades[$iz][0] = IniRead($g_sProfileBuildingPath, "upgrade", "xupgrade" & $iz, "-1")
		 $g_avBuildingUpgrades[$iz][1] = IniRead($g_sProfileBuildingPath, "upgrade", "yupgrade" & $iz, "-1")
		 $g_avBuildingUpgrades[$iz][2] = IniRead($g_sProfileBuildingPath, "upgrade", "upgradevalue" & $iz, "-1")
		 $g_avBuildingUpgrades[$iz][3] = IniRead($g_sProfileBuildingPath, "upgrade", "upgradetype" & $iz, "")
		 $g_avBuildingUpgrades[$iz][4] = IniRead($g_sProfileBuildingPath, "upgrade", "upgradename" & $iz, "")
		 $g_avBuildingUpgrades[$iz][5] = IniRead($g_sProfileBuildingPath, "upgrade", "upgradelevel" & $iz, "")
		 $g_avBuildingUpgrades[$iz][6] = IniRead($g_sProfileBuildingPath, "upgrade", "upgradetime" & $iz, "")
		 $g_avBuildingUpgrades[$iz][7] = IniRead($g_sProfileBuildingPath, "upgrade", "upgradeend" & $iz, "-1")
		 $g_abBuildingUpgradeEnable[$iz] = (IniRead($g_sProfileBuildingPath, "upgrade", "upgradechk" & $iz, 0) = "1")
		 $g_abUpgradeRepeatEnable[$iz] = (IniRead($g_sProfileBuildingPath, "upgrade", "upgraderepeat" & $iz, 0) = "1")
		 $g_aiPicUpgradeStatus[$iz] = IniRead($g_sProfileBuildingPath, "upgrade", "upgradestatusicon" & $iz, $eIcnTroops)

		 If $locationsInvalid = True Then
			 $g_avBuildingUpgrades[$iz][0] = -1
			 $g_avBuildingUpgrades[$iz][1] = -1
			 $g_abBuildingUpgradeEnable[$iz] = False
			 $g_abUpgradeRepeatEnable[$iz] = False
		 EndIf
	 Next
EndFunc

Func ReadRegularConfig()
   SetDebugLog("Read Config " & $g_sProfileConfigPath)

   IniReadS($g_iThreads, $g_sProfileConfigPath, "general", "threads", $g_iThreads, "int");

   ; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
   ; >>> CS69 These are referenced in CompareResources.au3, but never set or saved, thus they are always zero.  Needed?
   ; Delete the entry in MBR Global Variables too, if not needed
   IniReadS($iChkEnableAfter[$DB], $g_sProfileConfigPath, "search", "DBEnableAfter", 0, "int")
   IniReadS($iChkEnableAfter[$LB], $g_sProfileConfigPath, "search", "ABEnableAfter", 0, "int")
   ; CS69 These are referenced in CompareResources.au3, but never set or saved, thus they are always zero.  Needed? <<<
   ; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

   ; Window positions
   IniReadS($frmBotPosX, $g_sProfileConfigPath, "general", "frmBotPosX", -1, "int")
   IniReadS($frmBotPosY, $g_sProfileConfigPath, "general", "frmBotPosY", -1, "int")
   If $frmBotPosX < -30000 Or $frmBotPosY < -30000 Then
	  ; bot window was minimized, restore default position
	  $frmBotPosX = -1
	  $frmBotPosY = -1
   EndIf

   IniReadS($AndroidPosX, $g_sProfileConfigPath, "general", "AndroidPosX", -1, "int")
   IniReadS($AndroidPosY, $g_sProfileConfigPath, "general", "AndroidPosY", -1, "int")
   If $AndroidPosX < -30000 Or $AndroidPosY < -30000 Then
	  ; bot window was minimized, restore default position
	  $AndroidPosX = -1
	  $AndroidPosY = -1
   EndIf

   IniReadS($frmBotDockedPosX, $g_sProfileConfigPath, "general", "frmBotDockedPosX", -1, "int")
   IniReadS($frmBotDockedPosY, $g_sProfileConfigPath, "general", "frmBotDockedPosY", -1, "int")
   If $frmBotDockedPosX < -30000 Or $frmBotDockedPosY < -30000 Then
	  ; bot window was minimized, restore default position
	  $frmBotDockedPosX = -1
	  $frmBotDockedPosY = -1
   EndIf

   ; Redraw mode:  0 = disabled, 1 = Redraw always entire bot window, 2 = Redraw only required bot window area (or entire bot if control not specified)
   IniReadS($g_iRedrawBotWindowMode, $g_sProfileConfigPath, "general", "RedrawBotWindowMode", 2, "int")

	; <><><><> Bot / Android <><><><>
	ReadConfig_Android()
	; <><><><> Bot / Debug <><><><>
	ReadConfig_Debug()
	; <><><><> Log window <><><><>
	ReadConfig_600_1()
	; <><><><> Village / Misc <><><><>
	ReadConfig_600_6()
	; <><><><> Village / Achievements <><><><>
	ReadConfig_600_9()
	; <><><><> Village / Donate - Request <><><><>
	ReadConfig_600_11()
	; <><><><> Village / Donate - Donate <><><><>
	ReadConfig_600_12()
	; <><><><> Village / Donate - Schedule <><><><>
	ReadConfig_600_13()
	; <><><><> Village / Upgrade - Lab <><><><>
	ReadConfig_600_14()
	; <><><><> Village / Upgrade - Heroes <><><><>
	ReadConfig_600_15()
	; <><><><> Village / Upgrade - Buildings <><><><>
	ReadConfig_600_16()
	; <><><><> Village / Upgrade - Walls <><><><>
	ReadConfig_600_17()
	; <><><><> Village / Notify <><><><>
	ReadConfig_600_18()
	; <><><><> Village / Notify <><><><>
	ReadConfig_600_19()
	; <><><> Attack Plan / Train Army / Boost <><><>
	ReadConfig_600_22()
	; <><><><> Attack Plan / Search & Attack / Bully <><><><>
	ReadConfig_600_26()
	; <><><><> Attack Plan / Search & Attack / Options / Search <><><><>
	ReadConfig_600_28()
	; <><><><> Attack Plan / Search & Attack / Deadbase / Search <><><><>
	ReadConfig_600_28_DB()
	; <><><><> Attack Plan / Search & Attack / Activebase / Search <><><><>
	ReadConfig_600_28_LB()
	; <><><><> Attack Plan / Search & Attack / TH Snipe / Search <><><><>
	ReadConfig_600_28_TS()
	; <><><><> Attack Plan / Search & Attack / Options / Attack <><><><>
	ReadConfig_600_29()
	; <><><><> Attack Plan / Search & Attack / Deadbase / Attack <><><><>
	ReadConfig_600_29_DB()
	; <><><><> Attack Plan / Search & Attack / Activebase / Attack <><><><>
	ReadConfig_600_29_LB()
	; <><><><> Attack Plan / Search & Attack / TH Snipe / Attack <><><><>
	ReadConfig_600_29_TS()
	; <><><><> Attack Plan / Search & Attack / Options / End Battle <><><><>
	ReadConfig_600_30()
	; <><><><> Attack Plan / Search & Attack / Deadbase / End Battle <><><><>
	ReadConfig_600_30_DB()
	; <><><><> Attack Plan / Search & Attack / Activebase / End Battle <><><><>
	ReadConfig_600_30_LB()
	; <><><><> Attack Plan / Search & Attack / TH Snipe / End Battle <><><><>
	ReadConfig_600_30_TS()
	; <><><><> Attack Plan / Search & Attack / Deadbase / Collectors <><><><>
	ReadConfig_600_31()
	; <><><><> Attack Plan / Search & Attack / Options / Trophy Settings <><><><>
	ReadConfig_600_32()
	; <><><><> Bot / Options <><><><>
	ReadConfig_600_35()
	; <><><> Attack Plan / Train Army / Troops/Spells <><><>
	; Quick train
	ReadConfig_600_52_1()
	; troop/spell levels and counts
	ReadConfig_600_52_2()
	; <><><> Attack Plan / Train Army / Train Order <><><>
	ReadConfig_600_54()
	; <><><><> Attack Plan / Search & Attack / Options / SmartZap <><><><>
	ReadConfig_600_56()
	; <><><> Attack Plan / Train Army / Options <><><>
	ReadConfig_641_1()

   ; <><><><> Attack Plan / Strategies <><><><>
   ; <<< nothing here >>>

   ; <><><><> Bot / Android <><><><>
   ; <<< nothing here >>>

   ; <><><><> Bot / Debug <><><><>
   ; Settings at top of this function for easy access

   ; <><><><> Bot / Profiles <><><><>
   ; <<< nothing here >>>

   ; <><><><> Bot / Stats <><><><>
   ; <<< nothing here >>>
EndFunc

Func ReadConfig_Debug()
	; Debug settings
	$g_iDebugClick = BitOR($g_iDebugClick, Int(IniRead($g_sProfileConfigPath, "debug", "debugsetclick", 0)))
	If $g_bDevMode = True Then
		$g_iDebugSetlog = BitOR($g_iDebugSetlog, Int(IniRead($g_sProfileConfigPath, "debug", "debugsetlog", 0)))
		$g_iDebugDisableZoomout = BitOR($g_iDebugDisableZoomout, Int(IniRead($g_sProfileConfigPath, "debug", "disablezoomout", 0)))
		$g_iDebugDisableVillageCentering = BitOR($g_iDebugDisableVillageCentering, Int(IniRead($g_sProfileConfigPath, "debug", "disablevillagecentering", 0)))
		$g_iDebugDeadBaseImage = BitOR($g_iDebugDeadBaseImage, Int(IniRead($g_sProfileConfigPath, "debug", "debugdeadbaseimage", 0)))
		$g_iDebugOcr = BitOR($g_iDebugOcr, Int(IniRead($g_sProfileConfigPath, "debug", "debugocr", 0)))
		$g_iDebugImageSave = BitOR($g_iDebugImageSave, Int(IniRead($g_sProfileConfigPath, "debug", "debugimagesave", 0)))
		$g_iDebugBuildingPos = BitOR($g_iDebugBuildingPos, Int(IniRead($g_sProfileConfigPath, "debug", "debugbuildingpos", 0)))
		$g_iDebugSetlogTrain = BitOR($g_iDebugSetlogTrain, Int(IniRead($g_sProfileConfigPath, "debug", "debugtrain", 0)))
		$g_iDebugResourcesOffset = BitOR($g_iDebugResourcesOffset, Int(IniRead($g_sProfileConfigPath, "debug", "debugresourcesoffset", 0)))
		$g_iDebugContinueSearchElixir = BitOR($g_iDebugContinueSearchElixir, Int(IniRead($g_sProfileConfigPath, "debug", "continuesearchelixirdebug", 0)))
		$g_iDebugMilkingIMGmake = BitOR($g_iDebugMilkingIMGmake, Int(IniRead($g_sProfileConfigPath, "debug", "debugMilkingIMGmake", 0)))
		$g_iDebugOCRdonate = BitOR($g_iDebugOCRdonate, Int(IniRead($g_sProfileConfigPath, "debug", "debugOCRDonate", 0)))
		$g_iDebugAttackCSV = BitOR($g_iDebugAttackCSV, Int(IniRead($g_sProfileConfigPath, "debug", "debugAttackCSV", 0)))
		$g_iDebugMakeIMGCSV = BitOR($g_iDebugMakeIMGCSV, Int(IniRead($g_sProfileConfigPath, "debug", "debugmakeimgcsv", 0)))
	EndIf
EndFunc

Func ReadConfig_Android()
	; Android Configuration
	$g_sAndroidGameDistributor = IniRead($g_sProfileConfigPath, "android", "game.distributor", $g_sAndroidGameDistributor)
	$g_sAndroidGamePackage = IniRead($g_sProfileConfigPath, "android", "game.package", $g_sAndroidGamePackage)
	$g_sAndroidGameClass = IniRead($g_sProfileConfigPath, "android", "game.class", $g_sAndroidGameClass)
	$g_sUserGameDistributor = IniRead($g_sProfileConfigPath, "android", "user.distributor", $g_sUserGameDistributor)
	$g_sUserGamePackage = IniRead($g_sProfileConfigPath, "android", "user.package", $g_sUserGamePackage)
	$g_sUserGameClass = IniRead($g_sProfileConfigPath, "android", "user.class", $g_sUserGameClass)
	$g_bAndroidCheckTimeLagEnabled = Int(IniRead($g_sProfileConfigPath, "android", "check.time.lag.enabled", ($g_bAndroidCheckTimeLagEnabled ? 1 : 0))) = 1
	$g_iAndroidAdbScreencapTimeoutMin = Int(IniRead($g_sProfileConfigPath, "android", "adb.screencap.timeout.min", $g_iAndroidAdbScreencapTimeoutMin))
	$g_iAndroidAdbScreencapTimeoutMax = Int(IniRead($g_sProfileConfigPath, "android", "adb.screencap.timeout.max", $g_iAndroidAdbScreencapTimeoutMax))
	$g_iAndroidAdbScreencapTimeoutDynamic = Int(IniRead($g_sProfileConfigPath, "android", "adb.screencap.timeout.dynamic", $g_iAndroidAdbScreencapTimeoutDynamic))
	$g_bAndroidAdbInputEnabled = Int(IniRead($g_sProfileConfigPath, "android", "adb.input.enabled", ($g_bAndroidAdbInputEnabled ? 1 : 0))) = 1
	$g_bAndroidAdbClickEnabled = Int(IniRead($g_sProfileConfigPath, "android", "adb.click.enabled", ($g_bAndroidAdbClickEnabled ? 1 : 0))) = 1
	$g_iAndroidAdbClickGroup = Int(IniRead($g_sProfileConfigPath, "android", "adb.click.group", $g_iAndroidAdbClickGroup))
	$g_bAndroidAdbClicksEnabled = Int(IniRead($g_sProfileConfigPath, "android", "adb.clicks.enabled", ($g_bAndroidAdbClicksEnabled ? 1 : 0))) = 1
	$g_iAndroidAdbClicksTroopDeploySize = Int(IniRead($g_sProfileConfigPath, "android", "adb.clicks.troop.deploy.size", $g_iAndroidAdbClicksTroopDeploySize))
	$g_bNoFocusTampering = Int(IniRead($g_sProfileConfigPath, "android", "no.focus.tampering", ($g_bNoFocusTampering ? 1 : 0))) = 1
	$g_iAndroidShieldColor = Dec(IniRead($g_sProfileConfigPath, "android", "shield.color", Hex($g_iAndroidShieldColor, 6)))
	$g_iAndroidShieldTransparency = Int(IniRead($g_sProfileConfigPath, "android", "shield.transparency", $g_iAndroidShieldTransparency))
	$g_iAndroidActiveColor = Dec(IniRead($g_sProfileConfigPath, "android", "active.color", Hex($g_iAndroidActiveColor, 6)))
	$g_iAndroidActiveTransparency = Int(IniRead($g_sProfileConfigPath, "android", "active.transparency", $g_iAndroidActiveTransparency))
	$g_iAndroidInactiveColor = Dec(IniRead($g_sProfileConfigPath, "android", "inactive.color", Hex($g_iAndroidInactiveColor, 6)))
	$g_iAndroidInactiveTransparency = Int(IniRead($g_sProfileConfigPath, "android", "inactive.transparency", $g_iAndroidInactiveTransparency))

	If $g_bBotLaunchOption_Restart = True Then
		; for now only read when bot crashed and restarted through watchdog or nofify event
		Local $sAndroidEmulator = IniRead($g_sProfileConfigPath, "android", "emulator", "")
		Local $sAndroidInstance = IniRead($g_sProfileConfigPath, "android", "instance", "")
		If $sAndroidEmulator <> "" Then
			#cs Not required yet
			If $g_hFrmBot = 0 Then
				; early readConfig during bot launch: use command line if specified
				If $g_asCmdLine[0] > 1 Then
					If $g_asCmdLine[1] <> $sAndroidEmulator Then
						$sAndroidEmulator = $g_asCmdLine[1]
						SetDebugLog("Override Android Emulator by command line: " & $sAndroidEmulator)
					EndIf
					If $g_asCmdLine[0] > 2 Then
						If $g_asCmdLine[2] <> $sAndroidInstance Then
							$sAndroidInstance = $g_asCmdLine[2]
							SetDebugLog("Override Android Instance by command line: " & $sAndroidInstance)
						EndIf
					EndIf
				EndIf
			EndIf
			#ce

			If $sAndroidEmulator <> $g_sAndroidEmulator Or $sAndroidInstance <> $g_sAndroidInstance Then
				; check if Android Emulator or Instance changed, then invalidate Android Handle
				UpdateHWnD(0)
				UpdateAndroidConfig($sAndroidInstance, $sAndroidEmulator)
			EndIf
		Else
			; flag that detection must run
			$g_bBotLaunchOption_Restart = False
		EndIf
	EndIf

EndFunc

Func ReadConfig_600_1()
	; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
	; GUI Settings
	; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
	; <><><><> Log window <><><><>
	IniReadS($g_iCmbLogDividerOption, $g_sProfileConfigPath, "general", "logstyle", 0, "int")
	IniReadS($g_iLogDividerY, $g_sProfileConfigPath, "general", "LogDividerY", 243, "int")
	; <><><><> Bottom panel <><><><>
	IniReadS($g_bChkBackgroundMode, $g_sProfileConfigPath, "general", "Background", True, "Bool")
EndFunc

Func ReadConfig_600_6()
	; <><><><> Village / Misc <><><><>
	IniReadS($g_bChkBotStop, $g_sProfileConfigPath, "general", "BotStop", False, "Bool")
	IniReadS($g_iCmbBotCommand, $g_sProfileConfigPath, "general", "Command", 0, "int")
	IniReadS($g_iCmbBotCond, $g_sProfileConfigPath, "general", "Cond", 0, "int")
	IniReadS($g_iCmbHoursStop, $g_sProfileConfigPath, "general", "Hour", 0, "int")
	IniReadS($g_iTxtRestartGold, $g_sProfileConfigPath, "other", "minrestartgold", 50000, "int")
	IniReadS($g_iTxtRestartElixir, $g_sProfileConfigPath, "other", "minrestartelixir", 50000, "int")
	IniReadS($g_iTxtRestartDark, $g_sProfileConfigPath, "other", "minrestartdark", 500, "int")
	IniReadS($g_bChkTrap, $g_sProfileConfigPath, "other", "chkTrap", True, "Bool")
	IniReadS($g_bChkCollect, $g_sProfileConfigPath, "other", "chkCollect", True, "Bool")
	IniReadS($g_bChkTombstones, $g_sProfileConfigPath, "other", "chkTombstones", True, "Bool")
	IniReadS($g_bChkCleanYard, $g_sProfileConfigPath, "other", "chkCleanYard", False, "Bool")
	IniReadS($g_bChkGemsBox, $g_sProfileConfigPath, "other", "chkGemsBox", False, "Bool")
EndFunc

Func ReadConfig_600_9()
	; <><><><> Village / Achievements <><><><>
	IniReadS($g_iUnbrkMode, $g_sProfileConfigPath, "Unbreakable", "chkUnbreakable", 0, "int")
	IniReadS($g_iUnbrkWait, $g_sProfileConfigPath, "Unbreakable", "UnbreakableWait", 5, "int")
	IniReadS($g_iUnbrkMinGold, $g_sProfileConfigPath, "Unbreakable", "minUnBrkgold", 50000, "int")
	IniReadS($g_iUnbrkMaxGold, $g_sProfileConfigPath, "Unbreakable", "maxUnBrkgold", 600000, "int")
	IniReadS($g_iUnbrkMinElixir, $g_sProfileConfigPath, "Unbreakable", "minUnBrkelixir", 50000, "int")
	IniReadS($g_iUnbrkMaxElixir, $g_sProfileConfigPath, "Unbreakable", "maxUnBrkelixir", 600000, "int")
	IniReadS($g_iUnbrkMinDark, $g_sProfileConfigPath, "Unbreakable", "minUnBrkdark", 5000, "int")
	IniReadS($g_iUnbrkMaxDark, $g_sProfileConfigPath, "Unbreakable", "maxUnBrkdark", 10000, "int")
EndFunc

Func ReadConfig_600_11()
	; <><><><> Village / Donate - Request <><><><>
	$g_bRequestTroopsEnable = (IniRead($g_sProfileConfigPath, "planned", "RequestHoursEnable", 0) = "1")
	$g_sRequestTroopsText = IniRead($g_sProfileConfigPath, "donate", "txtRequest", "")
	$g_abRequestCCHours = StringSplit(IniRead($g_sProfileConfigPath, "planned", "RequestHours", "1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"), "|", $STR_NOCOUNT)
	For $i = 0 To 23
	   $g_abRequestCCHours[$i] = ($g_abRequestCCHours[$i] = "1")
    Next
EndFunc

Func ReadConfig_600_12()
	; <><><><> Village / Donate - Donate <><><><>
	$g_bChkDonate = (IniRead($g_sProfileConfigPath, "donate", "Doncheck", "1") = "1")
	For $i = 0 To $eTroopCount-1 + $g_iCustomDonateConfigs
		Local $sIniName = ""
		If $i >= $eTroopBarbarian And $i <= $eTroopBowler Then
		   $sIniName = StringReplace($g_asTroopNamesPlural[$i], " ", "")
	    ElseIf $i = $eCustomA Then
		   $sIniName = "CustomA"
	    ElseIf $i = $eCustomB Then
		   $sIniName = "CustomB"
	    EndIf

		$g_abChkDonateTroop[$i] = (IniRead($g_sProfileConfigPath, "donate", "chkDonate" & $sIniName, "0") = "1")
		$g_abChkDonateAllTroop[$i] = (IniRead($g_sProfileConfigPath, "donate", "chkDonateAll" & $sIniName, "0") = "1")
	Next

	$g_asTxtDonateTroop[$eTroopBarbarian] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateBarbarians", "barbarians|barbarian|barb"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopBarbarian] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistBarbarians", "no barbarians|no barb|barbarian no|barb no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopArcher] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateArchers", "archers|archer|arch"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopArcher] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistArchers", "no archers|no arch|archer no|arch no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopGiant] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateGiants", "giants|giant|any"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopGiant] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistGiants", "no giants|giants no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopGoblin] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateGoblins", "goblins|goblin"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopGoblin] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistGoblins", "no goblins|goblins no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopWallBreaker] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateWallBreakers", "wall breakers|wb"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopWallBreaker] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistWallBreakers", "no wallbreakers|wb no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopBalloon] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateBalloons", "balloons|balloon"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopBalloon] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistBalloons", "no balloon|balloons no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopWizard] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateWizards", "wizards|wizard|wiz"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopWizard] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistWizards", "no wizards|wizards no|no wizard|wizard no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopHealer] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateHealers", "healer"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopHealer] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistHealers", "no healer|healer no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopDragon] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateDragons", "dragon"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopDragon] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistDragons", "no dragon|dragon no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopPekka] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonatePekkas", "PEKKA|pekka"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopPekka] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistPekkas", "no PEKKA|pekka no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopBabyDragon] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateBabyDragons", "baby dragon|baby"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopBabyDragon] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistBabyDragons", "no baby dragon|baby dragon no|no baby|baby no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopMiner] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateMiners", "miner|mine"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopMiner] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistMiners", "no miner|miner no|no mine|mine no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopMinion] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateMinions", "minions|minion"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopMinion] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistMinions", "no minion|minions no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopHogRider] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateHogRiders", "hogriders|hogs|hog"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopHogRider] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistHogRiders", "no hogriders|hogriders no|no hog|hogs no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopValkyrie] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateValkyries", "valkyries|valkyrie|valk"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopValkyrie] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistValkyries", "no valkyrie|valkyries no|no valk|valk no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopGolem] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateGolems", "golem"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopGolem] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistGolems", "no golem|golem no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopWitch] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateWitches", "witches|witch"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopWitch] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistWitches", "no witches|witches no|no witch|witch no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopLavaHound] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateLavaHounds", "lavahounds|lava|hound"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopLavaHound] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistLavaHounds", "no lavahound|lavahound no|no lava|lava no|nohound|hound no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eTroopBowler] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateBowlers", "bowler|bowl"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eTroopBowler] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistBowlers", "no bowler|bowl no"), "|", @CRLF)

	$g_asTxtDonateTroop[$eCustomA] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateCustomA", "ground support|ground"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eCustomA] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistCustomA", "no ground|ground no|nonly"), "|", @CRLF)

	$g_asTxtDonateTroop[$eCustomB] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateCustomB", "air support|any air"), "|", @CRLF)
	$g_asTxtBlacklistTroop[$eCustomB] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistCustomB", "no air|air no|only|just"), "|", @CRLF)

    For $i = 0 To $eSpellCount - 1
		If $i <> $eSpellClone Then
			Local $sIniName = $g_asSpellNames[$i] & "Spells"
			$g_abChkDonateSpell[$i] = (IniRead($g_sProfileConfigPath, "donate", "chkDonate" & $sIniName, "0") = "1")
			$g_abChkDonateAllSpell[$i] = (IniRead($g_sProfileConfigPath, "donate", "chkDonateAll" & $sIniName, "0") = "1")
		EndIf
	Next

	$g_asTxtDonateSpell[$eSpellLightning] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateLightningSpells", "lightning"), "|", @CRLF)
	$g_asTxtBlacklistSpell[$eSpellLightning] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistLightningSpells", "no lightning|lightning no"), "|", @CRLF)

	$g_asTxtDonateSpell[$eSpellHeal] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateHealSpells", "heal"), "|", @CRLF)
	$g_asTxtBlacklistSpell[$eSpellHeal] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistHealSpells", "no heal|heal no"), "|", @CRLF)

	$g_asTxtDonateSpell[$eSpellRage] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateRageSpells", "rage"), "|", @CRLF)
	$g_asTxtBlacklistSpell[$eSpellRage] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistRageSpells", "no rage|rage no"), "|", @CRLF)

	$g_asTxtDonateSpell[$eSpellJump] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateJumpSpells", "jump"), "|", @CRLF)
	$g_asTxtBlacklistSpell[$eSpellJump] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistJumpSpells", "no jump|jump no"), "|", @CRLF)

	$g_asTxtDonateSpell[$eSpellFreeze] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateFreezeSpells", "freeze"), "|", @CRLF)
	$g_asTxtBlacklistSpell[$eSpellFreeze] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistFreezeSpells", "no freeze|freeze no"), "|", @CRLF)

	$g_asTxtDonateSpell[$eSpellPoison] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonatePoisonSpells", "poison"), "|", @CRLF)
	$g_asTxtBlacklistSpell[$eSpellPoison] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistPoisonSpells", "no poison|poison no"), "|", @CRLF)

	$g_asTxtDonateSpell[$eSpellEarthquake] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateEarthQuakeSpells", "earthquake|quake"), "|", @CRLF)
	$g_asTxtBlacklistSpell[$eSpellEarthquake] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistEarthQuakeSpells", "no earthquake|quake no"), "|", @CRLF)

	$g_asTxtDonateSpell[$eSpellHaste] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateHasteSpells", "haste"), "|", @CRLF)
	$g_asTxtBlacklistSpell[$eSpellHaste] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistHasteSpells", "no haste|haste no"), "|", @CRLF)

	$g_asTxtDonateSpell[$eSpellSkeleton] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtDonateSkeletonSpells", "skeleton"), "|", @CRLF)
	$g_asTxtBlacklistSpell[$eSpellSkeleton] = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklistSkeletonSpells", "no skeleton|skeleton no"), "|", @CRLF)

	$g_aiDonateCustomTrpNumA[0][0] = Int(IniRead($g_sProfileConfigPath, "donate", "cmbDonateCustomA1", 6))
	$g_aiDonateCustomTrpNumA[1][0] = Int(IniRead($g_sProfileConfigPath, "donate", "cmbDonateCustomA2", 1))
	$g_aiDonateCustomTrpNumA[2][0] = Int(IniRead($g_sProfileConfigPath, "donate", "cmbDonateCustomA3", 0))
	$g_aiDonateCustomTrpNumA[0][1] = Int(IniRead($g_sProfileConfigPath, "donate", "txtDonateCustomA1", 2))
	$g_aiDonateCustomTrpNumA[1][1] = Int(IniRead($g_sProfileConfigPath, "donate", "txtDonateCustomA2", 3))
	$g_aiDonateCustomTrpNumA[2][1] = Int(IniRead($g_sProfileConfigPath, "donate", "txtDonateCustomA3", 1))

	$g_aiDonateCustomTrpNumB[0][0] = Int(IniRead($g_sProfileConfigPath, "donate", "cmbDonateCustomB1", 11))
	$g_aiDonateCustomTrpNumB[1][0] = Int(IniRead($g_sProfileConfigPath, "donate", "cmbDonateCustomB2", 1))
	$g_aiDonateCustomTrpNumB[2][0] = Int(IniRead($g_sProfileConfigPath, "donate", "cmbDonateCustomB3", 6))
	$g_aiDonateCustomTrpNumB[0][1] = Int(IniRead($g_sProfileConfigPath, "donate", "txtDonateCustomB1", 3))
	$g_aiDonateCustomTrpNumB[1][1] = Int(IniRead($g_sProfileConfigPath, "donate", "txtDonateCustomB2", 13))
	$g_aiDonateCustomTrpNumB[2][1] = Int(IniRead($g_sProfileConfigPath, "donate", "txtDonateCustomB3", 5))

	$g_bChkExtraAlphabets = (IniRead($g_sProfileConfigPath, "donate", "chkExtraAlphabets", "0") = "1")
	$g_bChkExtraChinese = (IniRead($g_sProfileConfigPath, "donate", "chkExtraChinese", "0") = "1")
	$g_bChkExtraKorean = (IniRead($g_sProfileConfigPath, "donate", "chkExtraKorean", "0") = "1")

	$g_sTxtGeneralBlacklist = StringReplace(IniRead($g_sProfileConfigPath, "donate", "txtBlacklist", "clan war|war|cw"), "|", @CRLF)
EndFunc

Func ReadConfig_600_13()
	; <><><><> Village / Donate - Schedule <><><><>
	$g_bDonateHoursEnable = (IniRead($g_sProfileConfigPath, "planned", "DonateHoursEnable", "0") = "1")
	$g_abDonateHours = StringSplit(IniRead($g_sProfileConfigPath, "planned", "DonateHours", "1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"), "|", $STR_NOCOUNT)
	For $i = 0 To 23
	   $g_abDonateHours[$i] = ($g_abDonateHours[$i] = "1")
    Next
	$g_iCmbDonateFilter = Int(IniRead($g_sProfileConfigPath, "donate", "cmbFilterDonationsCC", 0))
	$g_iDonateSkipNearFullPercent = Int(IniRead($g_sProfileConfigPath, "donate", "SkipDonateNearFulLTroopsPercentual", 90))
	$g_bDonateSkipNearFullEnable = (IniRead($g_sProfileConfigPath, "donate", "SkipDonateNearFulLTroopsEnable", "1") = "1")
EndFunc

Func ReadConfig_600_14()
	 InireadS($g_bAutoLabUpgradeEnable, $g_sProfileBuildingPath, "upgrade", "upgradetroops", False, "Bool")
	 InireadS($g_iCmbLaboratory, $g_sProfileBuildingPath, "upgrade", "upgradetroopname", 0, "int")
	 $sLabUpgradeTime = IniRead($g_sProfileBuildingPath, "upgrade", "upgradelabtime", "")
EndFunc

Func ReadConfig_600_15()
	; <><><><> Village / Upgrade - Heroes <><><><>
	IniReadS($g_bUpgradeKingEnable, $g_sProfileConfigPath, "upgrade", "UpgradeKing", False, "Bool")
	IniReadS($g_bUpgradeQueenEnable, $g_sProfileConfigPath, "upgrade", "UpgradeQueen", False, "Bool")
	IniReadS($g_bUpgradeWardenEnable, $g_sProfileConfigPath, "upgrade", "UpgradeWarden", False, "Bool")
EndFunc

Func ReadConfig_600_16()
	; <><><><> Village / Upgrade - Buildings <><><><>
	IniReadS($g_iUpgradeMinGold, $g_sProfileConfigPath, "upgrade", "minupgrgold", 100000, "int")
	IniReadS($g_iUpgradeMinElixir, $g_sProfileConfigPath, "upgrade", "minupgrelixir", 100000, "int")
	IniReadS($g_iUpgradeMinDark, $g_sProfileConfigPath, "upgrade", "minupgrdark", 2000, "int")
	; The other building settings are loaded in the ReadBuildingConfig() function
EndFunc

Func ReadConfig_600_17()
	; <><><><> Village / Upgrade - Walls <><><><>
	IniReadS($g_bAutoUpgradeWallsEnable, $g_sProfileConfigPath, "upgrade", "auto-wall", False, "Bool")
	IniReadS($g_iUpgradeWallMinGold, $g_sProfileConfigPath, "upgrade", "minwallgold", 0, "int")
	IniReadS($g_iUpgradeWallMinElixir, $g_sProfileConfigPath, "upgrade", "minwallelixir", 0, "int")
	IniReadS($g_iUpgradeWallLootType, $g_sProfileConfigPath, "upgrade", "use-storage", 0, "int")
	IniReadS($g_bUpgradeWallSaveBuilder, $g_sProfileConfigPath, "upgrade", "savebldr", False, "Bool")
	IniReadS($g_iCmbUpgradeWallsLevel, $g_sProfileConfigPath, "upgrade", "walllvl", 6, "int")
	For $i = 4 To 12
	  IniReadS($g_aiWallsCurrentCount[$i], $g_sProfileConfigPath, "Walls", "Wall" & StringFormat("%02d", $i), 0, "int")
    Next
	IniReadS($g_iWallCost, $g_sProfileConfigPath, "upgrade", "WallCost", 0, "int")
EndFunc

Func ReadConfig_600_18()
	; <><><><> Village / Notify <><><><>
	;PushBullet/Telegram
	IniReadS($g_bNotifyPBEnable, $g_sProfileConfigPath, "notify", "PBEnabled", False, "Bool")
	IniReadS($g_bNotifyTGEnable, $g_sProfileConfigPath, "notify", "TGEnabled", False, "Bool")
	IniReadS($g_sNotifyPBToken, $g_sProfileConfigPath, "notify", "PBToken", "")
	IniReadS($g_sNotifyTGToken, $g_sProfileConfigPath, "notify", "TGToken", "")
	;Remote Control
	IniReadS($g_bNotifyRemoteEnable, $g_sProfileConfigPath, "notify", "PBRemote", False, "Bool")
	IniReadS($g_sNotifyOrigin, $g_sProfileConfigPath, "notify", "Origin", $g_sProfileCurrentName)
	IniReadS($g_bNotifyDeleteAllPushesOnStart, $g_sProfileConfigPath, "notify", "DeleteAllPBPushes", False, "Bool")
	IniReadS($g_bNotifyDeletePushesOlderThan, $g_sProfileConfigPath, "notify", "DeleteOldPBPushes", False, "Bool")
	IniReadS($g_iNotifyDeletePushesOlderThanHours, $g_sProfileConfigPath, "notify", "HoursPushBullet", 4, "int")
	;Alerts
	IniReadS($g_bNotifyAlertMatchFound, $g_sProfileConfigPath, "notify", "AlertPBVMFound", False, "Bool")
	IniReadS($g_bNotifyAlerLastRaidIMG, $g_sProfileConfigPath, "notify", "AlertPBLastRaid", False, "Bool")
	IniReadS($g_bNotifyAlerLastRaidTXT, $g_sProfileConfigPath, "notify", "AlertPBLastRaidTxt", False, "Bool")
	IniReadS($g_bNotifyAlertCampFull, $g_sProfileConfigPath, "notify", "AlertPBCampFull", False, "Bool")
	IniReadS($g_bNotifyAlertUpgradeWalls, $g_sProfileConfigPath, "notify", "AlertPBWallUpgrade", False, "Bool")
	IniReadS($g_bNotifyAlertOutOfSync, $g_sProfileConfigPath, "notify", "AlertPBOOS", False, "Bool")
	IniReadS($g_bNotifyAlertTakeBreak, $g_sProfileConfigPath, "notify", "AlertPBVBreak", False, "Bool")
	IniReadS($g_bNotifyAlertBulderIdle, $g_sProfileConfigPath, "notify", "AlertBuilderIdle", False, "Bool")
	IniReadS($g_bNotifyAlertVillageReport, $g_sProfileConfigPath, "notify", "AlertPBVillage", False, "Bool")
	IniReadS($g_bNotifyAlertLastAttack, $g_sProfileConfigPath, "notify", "AlertPBLastAttack", False, "Bool")
	IniReadS($g_bNotifyAlertAnotherDevice, $g_sProfileConfigPath, "notify", "AlertPBOtherDevice", False, "Bool")
	IniReadS($g_bNotifyAlertMaintenance, $g_sProfileConfigPath, "notify", "AlertPBMaintenance", False, "Bool")
	IniReadS($g_bNotifyAlertBAN, $g_sProfileConfigPath, "notify", "AlertPBBAN", False, "Bool")
	IniReadS($g_bNotifyAlertBOTUpdate, $g_sProfileConfigPath, "notify", "AlertPBUpdate", False, "Bool")
EndFunc

Func ReadConfig_600_19()
	; <><><><> Village / Notify <><><><>
	;Schedule
	$g_bNotifyScheduleHoursEnable = (IniRead($g_sProfileConfigPath, "notify", "NotifyHoursEnable", "0") = "1")
	$g_abNotifyScheduleHours = StringSplit(IniRead($g_sProfileConfigPath, "notify", "NotifyHours", "1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"),"|", $STR_NOCOUNT)
	For $i = 0 To 23
	   $g_abNotifyScheduleHours[$i] = ($g_abNotifyScheduleHours[$i] = "1")
    Next
	$g_bNotifyScheduleWeekDaysEnable = (IniRead($g_sProfileConfigPath, "notify", "NotifyWeekDaysEnable", "0") = "1")
	$g_abNotifyScheduleWeekDays = StringSplit(IniRead($g_sProfileConfigPath, "notify", "NotifyWeekDays", "1|1|1|1|1|1|1"),"|", $STR_NOCOUNT)
	For $i = 0 To 6
	   $g_abNotifyScheduleWeekDays[$i] = ($g_abNotifyScheduleWeekDays[$i] = "1")
    Next
EndFunc

Func ReadConfig_600_22()
	; <><><><> Attack Plan / Train Army / Boost <><><><>
	$g_abBoostBarracksHours = StringSplit(IniRead($g_sProfileConfigPath, "planned", "BoostBarracksHours", "1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"), "|", $STR_NOCOUNT)
	For $i = 0 To 23
	   $g_abBoostBarracksHours[$i] = ($g_abBoostBarracksHours[$i] = "1")
    Next
    ; Note: These global variables are not stored to the ini file, to prevent automatic boosting (and spending of gems) when the bot is started:
	; $g_iCmbBoostBarracks, $g_iCmbBoostSpellFactory, $g_iCmbBoostBarbarianKing, $g_iCmbBoostArcherQueen, $g_iCmbBoostWarden
EndFunc

Func ReadConfig_600_26()
	; <><><><> Attack Plan / Search & Attack / Bully <><><><>
	IniReadS($g_abAttackTypeEnable[$TB], $g_sProfileConfigPath, "search", "BullyMode", False, "Bool")
	IniReadS($g_iAtkTBEnableCount, $g_sProfileConfigPath, "search", "ATBullyMode", 0, "int")
	IniReadS($g_iAtkTBMaxTHLevel, $g_sProfileConfigPath, "search", "YourTH", 0, "int")
	IniReadS($g_iAtkTBMode, $g_sProfileConfigPath, "search", "THBullyAttackMode", 0, "int")
EndFunc

Func ReadConfig_600_28()
	; <><><><> Attack Plan / Search & Attack / Options / Search <><><><>
	IniReadS($g_bSearchReductionEnable, $g_sProfileConfigPath, "search", "reduction", False, "Bool")
	IniReadS($g_iSearchReductionCount, $g_sProfileConfigPath, "search", "reduceCount", 20, "int")
	IniReadS($g_iSearchReductionGold, $g_sProfileConfigPath, "search", "reduceGold", 2000, "int")
	IniReadS($g_iSearchReductionElixir, $g_sProfileConfigPath, "search", "reduceElixir", 2000, "int")
	IniReadS($g_iSearchReductionGoldPlusElixir, $g_sProfileConfigPath, "search", "reduceGoldPlusElixir", 4000, "int")
	IniReadS($g_iSearchReductionDark, $g_sProfileConfigPath, "search", "reduceDark", 100, "int")
	IniReadS($g_iSearchReductionTrophy, $g_sProfileConfigPath, "search", "reduceTrophy", 2, "int")
	IniReadS($g_iSearchDelayMin, $g_sProfileConfigPath, "other", "VSDelay", 0, "Int")
	IniReadS($g_iSearchDelayMax, $g_sProfileConfigPath, "other", "MaxVSDelay", 4, "Int")
	IniReadS($g_bSearchAttackNowEnable, $g_sProfileConfigPath, "general", "AttackNow", False, "Bool")
	IniReadS($g_iSearchAttackNowDelay, $g_sProfileConfigPath, "general", "attacknowdelay", 3, "int")
	IniReadS($g_bSearchRestartEnable, $g_sProfileConfigPath, "search", "ChkRestartSearchLimit", True, "Bool")
	IniReadS($g_iSearchRestartLimit, $g_sProfileConfigPath, "search", "RestartSearchLimit", 50, "int")
	IniReadS($g_bSearchAlertMe, $g_sProfileConfigPath, "general", "AlertSearch", False, "Bool")
EndFunc

Func ReadConfig_600_28_DB()
	; <><><><> Attack Plan / Search & Attack / Deadbase / Search <><><><>
	IniReadS($g_abAttackTypeEnable[$DB], $g_sProfileConfigPath, "search", "DBcheck", True, "Bool")
	; Search - Start Search If
	IniReadS($g_abSearchSearchesEnable[$DB], $g_sProfileConfigPath, "search", "ChkDBSearchSearches", True, "Bool")
	IniReadS($g_aiSearchSearchesMin[$DB], $g_sProfileConfigPath, "search", "DBEnableAfterCount", 1, "int")
	IniReadS($g_aiSearchSearchesMax[$DB], $g_sProfileConfigPath, "search", "DBEnableBeforeCount", 9999, "int")
	IniReadS($g_abSearchTropiesEnable[$DB], $g_sProfileConfigPath, "search", "ChkDBSearchTropies", False, "Bool")
	IniReadS($g_aiSearchTrophiesMin[$DB], $g_sProfileConfigPath, "search", "DBEnableAfterTropies", 100, "int")
	IniReadS($g_aiSearchTrophiesMax[$DB], $g_sProfileConfigPath, "search", "DBEnableBeforeTropies", 6000, "int")
	IniReadS($g_abSearchCampsEnable[$DB], $g_sProfileConfigPath, "search", "ChkDBSearchCamps", False, "Bool")
	IniReadS($g_aiSearchCampsPct[$DB], $g_sProfileConfigPath, "search", "DBEnableAfterArmyCamps", 100, "int")
	Local $temp1, $temp2, $temp3
	IniReadS($temp1, $g_sProfileConfigPath, "attack", "DBKingWait", $eHeroNone)
	IniReadS($temp2, $g_sProfileConfigPath, "attack", "DBQueenWait", $eHeroNone)
	IniReadS($temp3, $g_sProfileConfigPath, "attack", "DBWardenWait", $eHeroNone)
	$g_aiSearchHeroWaitEnable[$DB] = BitOR(Int($temp1), Int($temp2), Int($temp3))
	$iHeroWaitAttackNoBit[$DB][0] = ($temp1 > $eHeroNone) ? 1 : 0
	$iHeroWaitAttackNoBit[$DB][1] = ($temp2 > $eHeroNone) ? 1 : 0
	$iHeroWaitAttackNoBit[$DB][2] = ($temp3 > $eHeroNone) ? 1 : 0
	IniReadS($g_abSearchSpellsWaitEnable[$DB], $g_sProfileConfigPath, "search", "ChkDBSpellsWait", False, "Bool")
	IniReadS($g_abSearchCastleSpellsWaitEnable[$DB], $g_sProfileConfigPath, "search", "ChkDBCastleSpellWait", False, "Bool")
	IniReadS($g_abSearchCastleTroopsWaitEnable[$DB], $g_sProfileConfigPath, "search", "ChkDBCastleTroopsWait", False, "Bool")
	IniReadS($g_aiSearchCastleSpellsWaitRegular[$DB], $g_sProfileConfigPath, "search", "cmbDBWaitForCastleSpell", 0, "int")
	IniReadS($g_aiSearchCastleSpellsWaitDark[$DB], $g_sProfileConfigPath, "search", "cmbDBWaitForCastleSpell2", 0, "int")
	; Search - Filters
	IniReadS($g_aiFilterMeetGE[$DB], $g_sProfileConfigPath, "search", "DBMeetGE", 1, "int")
	IniReadS($g_aiFilterMinGold[$DB], $g_sProfileConfigPath, "search", "DBsearchGold", 80000, "int")
	IniReadS($g_aiFilterMinElixir[$DB], $g_sProfileConfigPath, "search", "DBsearchElixir", 80000, "int")
	IniReadS($g_aiFilterMinGoldPlusElixir[$DB], $g_sProfileConfigPath, "search", "DBsearchGoldPlusElixir", 160000, "int")
	IniReadS($g_abFilterMeetDEEnable[$DB], $g_sProfileConfigPath, "search", "DBMeetDE", False, "Bool")
	IniReadS($g_aiFilterMeetDEMin[$DB], $g_sProfileConfigPath, "search", "DBsearchDark", 0, "int")
	IniReadS($g_abFilterMeetTrophyEnable[$DB], $g_sProfileConfigPath, "search", "DBMeetTrophy", False, "Bool")
	IniReadS($g_aiFilterMeetTrophyMin[$DB], $g_sProfileConfigPath, "search", "DBsearchTrophy", 0, "int")
	IniReadS($g_abFilterMeetTH[$DB], $g_sProfileConfigPath, "search", "DBMeetTH", False, "Bool")
	IniReadS($g_aiFilterMeetTHMin[$DB], $g_sProfileConfigPath, "search", "DBTHLevel", 0, "int")
	IniReadS($g_abFilterMeetTHOutsideEnable[$DB], $g_sProfileConfigPath, "search", "DBMeetTHO", False, "Bool")
	IniReadS($g_abFilterMaxMortarEnable[$DB], $g_sProfileConfigPath, "search", "DBCheckMortar", False, "Bool")
	IniReadS($g_abFilterMaxWizTowerEnable[$DB], $g_sProfileConfigPath, "search", "DBCheckWizTower", False, "Bool")
	IniReadS($g_abFilterMaxAirDefenseEnable[$DB], $g_sProfileConfigPath, "search", "DBCheckAirDefense", False, "Bool")
	IniReadS($g_abFilterMaxXBowEnable[$DB], $g_sProfileConfigPath, "search", "DBCheckXBow",False, "Bool")
	IniReadS($g_abFilterMaxInfernoEnable[$DB], $g_sProfileConfigPath, "search", "DBCheckInferno", False, "Bool")
	IniReadS($g_abFilterMaxEagleEnable[$DB], $g_sProfileConfigPath, "search", "DBCheckEagle", False, "Bool")
	IniReadS($g_aiFilterMaxMortarLevel[$DB], $g_sProfileConfigPath, "search", "DBWeakMortar", 5, "int")
	IniReadS($g_aiFilterMaxWizTowerLevel[$DB], $g_sProfileConfigPath, "search", "DBWeakWizTower", 4, "int")
	IniReadS($g_aiFilterMaxAirDefenseLevel[$DB], $g_sProfileConfigPath, "search", "DBWeakAirDefense", 7, "int")
	IniReadS($g_aiFilterMaxXBowLevel[$DB], $g_sProfileConfigPath, "search", "DBWeakXBow", 4, "int")
	IniReadS($g_aiFilterMaxInfernoLevel[$DB], $g_sProfileConfigPath, "search", "DBWeakInferno", 1, "int")
	IniReadS($g_aiFilterMaxEagleLevel[$DB], $g_sProfileConfigPath, "search", "DBWeakEagle", 2, "int")
	IniReadS($g_abFilterMeetOneConditionEnable[$DB], $g_sProfileConfigPath, "search", "DBMeetOne", False, "Bool")
EndFunc

Func ReadConfig_600_28_LB()
	; <><><><> Attack Plan / Search & Attack / Activebase / Search <><><><>
	IniReadS($g_abAttackTypeEnable[$LB], $g_sProfileConfigPath, "search", "ABcheck", False, "Bool")
	; Search - Start Search If
	IniReadS($g_abSearchSearchesEnable[$LB], $g_sProfileConfigPath, "search", "ChkABSearchSearches", False, "Bool")
	IniReadS($g_aiSearchSearchesMin[$LB], $g_sProfileConfigPath, "search", "ABEnableAfterCount", 1, "int")
	IniReadS($g_aiSearchSearchesMax[$LB], $g_sProfileConfigPath, "search", "ABEnableBeforeCount", 9999, "int")
	IniReadS($g_abSearchTropiesEnable[$LB], $g_sProfileConfigPath, "search", "ChkABSearchTropies", False, "Bool")
	IniReadS($g_aiSearchTrophiesMin[$LB], $g_sProfileConfigPath, "search", "ABEnableAfterTropies", 100, "int")
	IniReadS($g_aiSearchTrophiesMax[$LB], $g_sProfileConfigPath, "search", "ABEnableBeforeTropies", 6000, "int")
	IniReadS($g_abSearchCampsEnable[$LB], $g_sProfileConfigPath, "search", "ChkABSearchCamps", False, "Bool")
	IniReadS($g_aiSearchCampsPct[$LB], $g_sProfileConfigPath, "search", "ABEnableAfterArmyCamps", 100, "int")
	Local $temp1, $temp2, $temp3
	IniReadS($temp1, $g_sProfileConfigPath, "attack", "ABKingWait", $eHeroNone)
	IniReadS($temp2, $g_sProfileConfigPath, "attack", "ABQueenWait", $eHeroNone)
	IniReadS($temp3, $g_sProfileConfigPath, "attack", "ABWardenWait", $eHeroNone)
	$g_aiSearchHeroWaitEnable[$LB] = BitOR(Int($temp1), Int($temp2), Int($temp3))
	$iHeroWaitAttackNoBit[$LB][0] = ($temp1 > $eHeroNone) ? 1 : 0
	$iHeroWaitAttackNoBit[$LB][1] = ($temp2 > $eHeroNone) ? 1 : 0
	$iHeroWaitAttackNoBit[$LB][2] = ($temp3 > $eHeroNone) ? 1 : 0
	IniReadS($g_abSearchSpellsWaitEnable[$LB], $g_sProfileConfigPath, "search", "ChkABSpellsWait", False, "Bool")
	IniReadS($g_abSearchCastleSpellsWaitEnable[$LB], $g_sProfileConfigPath, "search", "ChkABCastleSpellWait", False, "Bool")
	IniReadS($g_abSearchCastleTroopsWaitEnable[$LB], $g_sProfileConfigPath, "search", "ChkABCastleTroopsWait", False, "Bool")
	IniReadS($g_aiSearchCastleSpellsWaitRegular[$LB], $g_sProfileConfigPath, "search", "cmbABWaitForCastleSpell", 0, "int")
	IniReadS($g_aiSearchCastleSpellsWaitDark[$LB], $g_sProfileConfigPath, "search", "cmbABWaitForCastleSpell2", 0, "int")
	; Search - Filters
	IniReadS($g_aiFilterMeetGE[$LB], $g_sProfileConfigPath, "search", "ABMeetGE", 2, "int")
	IniReadS($g_aiFilterMinGold[$LB], $g_sProfileConfigPath, "search", "ABsearchGold", 80000, "int")
	IniReadS($g_aiFilterMinElixir[$LB], $g_sProfileConfigPath, "search", "ABsearchElixir", 80000, "int")
	IniReadS($g_aiFilterMinGoldPlusElixir[$LB], $g_sProfileConfigPath, "search", "ABsearchGoldPlusElixir", 160000, "int")
	IniReadS($g_abFilterMeetDEEnable[$LB], $g_sProfileConfigPath, "search", "ABMeetDE", False, "Bool")
	IniReadS($g_aiFilterMeetDEMin[$LB], $g_sProfileConfigPath, "search", "ABsearchDark", 0, "int")
	IniReadS($g_abFilterMeetTrophyEnable[$LB], $g_sProfileConfigPath, "search", "ABMeetTrophy", False, "Bool")
	IniReadS($g_aiFilterMeetTrophyMin[$LB], $g_sProfileConfigPath, "search", "ABsearchTrophy", 0, "int")
	IniReadS($g_abFilterMeetTH[$LB], $g_sProfileConfigPath, "search", "ABMeetTH", False, "Bool")
	IniReadS($g_aiFilterMeetTHMin[$LB], $g_sProfileConfigPath, "search", "ABTHLevel", 0, "int")
	IniReadS($g_abFilterMeetTHOutsideEnable[$LB], $g_sProfileConfigPath, "search", "ABMeetTHO", False, "Bool")
	IniReadS($g_abFilterMaxMortarEnable[$LB], $g_sProfileConfigPath, "search", "ABCheckMortar", False, "Bool")
	IniReadS($g_abFilterMaxWizTowerEnable[$LB], $g_sProfileConfigPath, "search", "ABCheckWizTower", False, "Bool")
	IniReadS($g_abFilterMaxAirDefenseEnable[$LB], $g_sProfileConfigPath, "search", "ABCheckAirDefense", False, "Bool")
	IniReadS($g_abFilterMaxXBowEnable[$LB], $g_sProfileConfigPath, "search", "ABCheckXBow", False, "Bool")
	IniReadS($g_abFilterMaxInfernoEnable[$LB], $g_sProfileConfigPath, "search", "ABCheckInferno", False, "Bool")
	IniReadS($g_abFilterMaxEagleEnable[$LB], $g_sProfileConfigPath, "search", "ABCheckEagle", False, "Bool")
	IniReadS($g_aiFilterMaxMortarLevel[$LB], $g_sProfileConfigPath, "search", "ABWeakMortar", 5, "int")
	IniReadS($g_aiFilterMaxWizTowerLevel[$LB], $g_sProfileConfigPath, "search", "ABWeakWizTower", 4, "int")
	IniReadS($g_aiFilterMaxAirDefenseLevel[$LB], $g_sProfileConfigPath, "search", "ABWeakAirDefense", 7, "int")
	IniReadS($g_aiFilterMaxXBowLevel[$LB], $g_sProfileConfigPath, "search", "ABWeakXBow", 4, "int")
	IniReadS($g_aiFilterMaxInfernoLevel[$LB], $g_sProfileConfigPath, "search", "ABWeakInferno", 1, "int")
	IniReadS($g_aiFilterMaxEagleLevel[$LB], $g_sProfileConfigPath, "search", "ABWeakEagle", 2, "int")
	IniReadS($g_abFilterMeetOneConditionEnable[$LB], $g_sProfileConfigPath, "search", "ABMeetOne", False, "Bool")
EndFunc

Func ReadConfig_600_28_TS()
	; <><><><> Attack Plan / Search & Attack / TH Snipe / Search <><><><>
	IniReadS($g_abAttackTypeEnable[$TS], $g_sProfileConfigPath, "search", "TScheck", False, "Bool")
	; Search - Start Search If
	IniReadS($g_abSearchSearchesEnable[$TS], $g_sProfileConfigPath, "search", "ChkTSSearchSearches", False, "Bool")
	IniReadS($g_aiSearchSearchesMin[$TS], $g_sProfileConfigPath, "search", "TSEnableAfterCount", 1, "int")
	IniReadS($g_aiSearchSearchesMax[$TS], $g_sProfileConfigPath, "search", "TSEnableBeforeCount", 9999, "int")
	IniReadS($g_abSearchTropiesEnable[$TS], $g_sProfileConfigPath, "search", "ChkTSSearchTropies", False, "Bool")
	IniReadS($g_aiSearchTrophiesMin[$TS], $g_sProfileConfigPath, "search", "TSEnableAfterTropies", 100, "int")
	IniReadS($g_aiSearchTrophiesMax[$TS], $g_sProfileConfigPath, "search", "TSEnableBeforeTropies", 6000, "int")
	IniReadS($g_abSearchCampsEnable[$TS], $g_sProfileConfigPath, "search", "ChkTSSearchCamps", False, "Bool")
	IniReadS($g_aiSearchCampsPct[$TS], $g_sProfileConfigPath, "search", "TSEnableAfterArmyCamps", 100, "int")
	; Search - Filters
	IniReadS($g_aiFilterMeetGE[$TS], $g_sProfileConfigPath, "search", "TSMeetGE", 1, "int")
	IniReadS($g_aiFilterMinGold[$TS], $g_sProfileConfigPath, "search", "TSsearchGold", 80000, "int")
	IniReadS($g_aiFilterMinElixir[$TS], $g_sProfileConfigPath, "search", "TSsearchElixir", 80000, "int")
	IniReadS($g_aiFilterMinGoldPlusElixir[$TS], $g_sProfileConfigPath, "search", "TSsearchGoldPlusElixir", 160000, "int")
	IniReadS($g_abFilterMeetDEEnable[$TS], $g_sProfileConfigPath, "search", "TSMeetDE", False, "Bool")
	IniReadS($g_aiFilterMeetDEMin[$TS], $g_sProfileConfigPath, "search", "TSsearchDark", 600, "int")
	IniReadS($g_iAtkTSAddTilesWhileTrain, $g_sProfileConfigPath, "search", "SWTtiles", 1, "int")
	IniReadS($g_iAtkTSAddTilesFullTroops, $g_sProfileConfigPath, "search", "THaddTiles", 2, "int")
EndFunc

Func ReadConfig_600_29()
	; <><><><> Attack Plan / Search & Attack / Options / Attack <><><><>
	IniReadS($iActivateKQCondition, $g_sProfileConfigPath, "attack", "ActivateKQ", "Auto")
	IniReadS($delayActivateKQ, $g_sProfileConfigPath, "attack", "delayActivateKQ", 9, "int")
	IniReadS($iActivateWardenCondition, $g_sProfileConfigPath, "attack", "ActivateWarden", 1, "int")
	IniReadS($delayActivateW, $g_sProfileConfigPath, "attack", "delayActivateW", 9, "int")
	$ichkAttackPlannerEnable = Int(IniRead($g_sProfileConfigPath, "planned", "chkAttackPlannerEnable", 0))
	$ichkAttackPlannerCloseCoC = Int(IniRead($g_sProfileConfigPath, "planned", "chkAttackPlannerCloseCoC", 0))
	$ichkAttackPlannerCloseAll = Int(IniRead($g_sProfileConfigPath, "planned", "chkAttackPlannerCloseAll", 0))
	$ichkAttackPlannerRandom = Int(IniRead($g_sProfileConfigPath, "planned", "chkAttackPlannerRandom", 0))
	$icmbAttackPlannerRandom = Int(IniRead($g_sProfileConfigPath, "planned", "cmbAttackPlannerRandom", 4))
	$ichkAttackPlannerDayLimit = Int(IniRead($g_sProfileConfigPath, "planned", "chkAttackPlannerDayLimit", 0))
	$icmbAttackPlannerDayMin = Int(IniRead($g_sProfileConfigPath, "planned", "cmbAttackPlannerDayMin", 12))
	$icmbAttackPlannerDayMax = Int(IniRead($g_sProfileConfigPath, "planned", "cmbAttackPlannerDayMax", 15))
	$iPlannedAttackWeekDays = StringSplit(IniRead($g_sProfileConfigPath, "planned", "attackDays", "1|1|1|1|1|1|1"), "|", $STR_NOCOUNT)
	$iPlannedattackHours = StringSplit(IniRead($g_sProfileConfigPath, "planned", "attackHours", "1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"), "|", $STR_NOCOUNT)
	$iPlannedDropCCHoursEnable = Int(IniRead($g_sProfileConfigPath, "planned", "DropCCEnable", 0))
	$iPlannedDropCCHours = StringSplit(IniRead($g_sProfileConfigPath, "planned", "DropCCHours", "1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"), "|", $STR_NOCOUNT)
	IniReadS($iChkUseCCBalanced, $g_sProfileConfigPath, "ClanClastle", "BalanceCC", 0, "int")
	IniReadS($iCmbCCDonated, $g_sProfileConfigPath, "ClanClastle", "BalanceCCDonated", 1, "int")
	IniReadS($iCmbCCReceived, $g_sProfileConfigPath, "ClanClastle", "BalanceCCReceived", 1, "int")
EndFunc

Func ReadConfig_600_29_DB()
	; <><><><> Attack Plan / Search & Attack / Deadbase / Attack <><><><>
	IniReadS($g_aiAttackAlgorithm[$DB], $g_sProfileConfigPath, "attack", "DBAtkAlgorithm", 0, "int")
	IniReadS($g_aiAttackTroopSelection[$DB], $g_sProfileConfigPath, "attack", "DBSelectTroop", 0, "int")
	Local $temp1, $temp2, $temp3
	IniReadS($temp1, $g_sProfileConfigPath, "attack", "DBKingAtk", $eHeroNone)
	IniReadS($temp2, $g_sProfileConfigPath, "attack", "DBQueenAtk", $eHeroNone)
	IniReadS($temp3, $g_sProfileConfigPath, "attack", "DBWardenAtk", $eHeroNone)
	$g_aiAttackUseHeroes[$DB] = BitOR(Int($temp1), Int($temp2), Int($temp3))
	IniReadS($g_abAttackDropCC[$DB], $g_sProfileConfigPath, "attack", "DBDropCC", False, "Bool")
	IniReadS($g_abAttackUseLightSpell[$DB], $g_sProfileConfigPath, "attack", "DBLightSpell", False, "Bool")
	IniReadS($g_abAttackUseHealSpell[$DB], $g_sProfileConfigPath, "attack", "DBHealSpell", False, "Bool")
	IniReadS($g_abAttackUseRageSpell[$DB], $g_sProfileConfigPath, "attack", "DBRageSpell", False, "Bool")
	IniReadS($g_abAttackUseJumpSpell[$DB], $g_sProfileConfigPath, "attack", "DBJumpSpell", False, "Bool")
	IniReadS($g_abAttackUseFreezeSpell[$DB], $g_sProfileConfigPath, "attack", "DBFreezeSpell", False, "Bool")
	IniReadS($g_abAttackUsePoisonSpell[$DB], $g_sProfileConfigPath, "attack", "DBPoisonSpell", False, "Bool")
	IniReadS($g_abAttackUseEarthquakeSpell[$DB], $g_sProfileConfigPath, "attack", "DBEarthquakeSpell", False, "Bool")
	IniReadS($g_abAttackUseHasteSpell[$DB], $g_sProfileConfigPath, "attack", "DBHasteSpell", False, "Bool")
	IniReadS($g_abAttackUseCloneSpell[$DB], $g_sProfileConfigPath, "attack", "DBCloneSpell", False, "Bool")
	IniReadS($g_abAttackUseSkeletonSpell[$DB], $g_sProfileConfigPath, "attack", "DBSkeletonSpell", False, "Bool")
	IniReadS($g_bTHSnipeBeforeEnable[$DB], $g_sProfileConfigPath, "attack", "THSnipeBeforeDBEnable", False, "Bool")
	IniReadS($g_iTHSnipeBeforeTiles[$DB], $g_sProfileConfigPath, "attack", "THSnipeBeforeDBTiles", 0, "int")
	IniReadS($g_iTHSnipeBeforeScript[$DB], $g_sProfileConfigPath, "attack", "THSnipeBeforeDBScript", "bam")
	; <><><><> Attack Plan / Search & Attack / Deadbase / Attack / Standard <><><><>
	IniReadS($g_aiAttackStdDropOrder[$DB], $g_sProfileConfigPath, "attack", "DBStandardAlgorithm", 0, "int")
	IniReadS($g_aiAttackStdDropSides[$DB], $g_sProfileConfigPath, "attack", "DBDeploy", 3, "int")
	IniReadS($g_aiAttackStdUnitDelay[$DB], $g_sProfileConfigPath, "attack", "DBUnitD", 4, "int")
	IniReadS($g_aiAttackStdWaveDelay[$DB], $g_sProfileConfigPath, "attack", "DBWaveD", 4, "int")
	IniReadS($g_abAttackStdRandomizeDelay[$DB], $g_sProfileConfigPath, "attack", "DBRandomSpeedAtk", True, "Bool")
	IniReadS($g_abAttackStdSmartAttack[$DB], $g_sProfileConfigPath, "attack", "DBSmartAttackRedArea", True, "Bool")
	IniReadS($g_aiAttackStdSmartDeploy[$DB], $g_sProfileConfigPath, "attack", "DBSmartAttackDeploy", 0, "int")
	IniReadS($g_abAttackStdSmartNearCollectors[$DB][0], $g_sProfileConfigPath, "attack", "DBSmartAttackGoldMine", False, "Bool")
	IniReadS($g_abAttackStdSmartNearCollectors[$DB][1], $g_sProfileConfigPath, "attack", "DBSmartAttackElixirCollector", False, "Bool")
	IniReadS($g_abAttackStdSmartNearCollectors[$DB][2], $g_sProfileConfigPath, "attack", "DBSmartAttackDarkElixirDrill", False, "Bool")
	; <><><><> Attack Plan / Search & Attack / Deadbase / Attack / Scripted <><><><>
	IniReadS($g_aiAttackScrRedlineRoutine[$DB], $g_sProfileConfigPath, "attack", "RedlineRoutineDB", $g_aiAttackScrRedlineRoutine[$DB], "Int")
	IniReadS($g_aiAttackScrDroplineEdge[$DB], $g_sProfileConfigPath, "attack", "DroplineEdgeDB", $g_aiAttackScrDroplineEdge[$DB], "Int")
	IniReadS($g_sAttackScrScriptName[$DB], $g_sProfileConfigPath, "attack", "ScriptDB", "Barch four fingers")
	; <><><><> Attack Plan / Search & Attack / Deadbase / Attack / Milking <><><><>
	IniReadS($g_iMilkAttackType, $g_sProfileConfigPath, "MilkingAttack", "MilkAttackType", 0, "int")
	IniReadS($g_aiMilkFarmElixirParam, $g_sProfileConfigPath, "MilkingAttack", "LocateElixirLevel", "-1|-1|-1|-1|-1|-1|2|2|2")
	$g_aiMilkFarmElixirParam = StringSplit($g_aiMilkFarmElixirParam, "|", 2)
	IniReadS($g_bMilkFarmLocateElixir, $g_sProfileConfigPath, "MilkingAttack", "LocateElixir", True, "Bool")
	IniReadS($g_bMilkFarmLocateMine, $g_sProfileConfigPath, "MilkingAttack", "LocateMine", True, "Bool")
	IniReadS($g_bMilkFarmLocateDrill, $g_sProfileConfigPath, "MilkingAttack", "LocateDrill", True, "Bool")
	IniReadS($g_iMilkFarmMineParam, $g_sProfileConfigPath, "MilkingAttack", "MineParam", 5, "int")
	IniReadS($g_iMilkFarmDrillParam, $g_sProfileConfigPath, "MilkingAttack", "DrillParam", 1, "int")
	IniReadS($g_iMilkFarmResMaxTilesFromBorder, $g_sProfileConfigPath, "MilkingAttack", "MaxTiles", 1, "int")
	IniReadS($g_bMilkFarmAttackGoldMines, $g_sProfileConfigPath, "MilkingAttack", "AttackMine", True, "Bool")
	IniReadS($g_bMilkFarmAttackElixirExtractors, $g_sProfileConfigPath, "MilkingAttack", "AttackElixir", True, "Bool")
	IniReadS($g_bMilkFarmAttackDarkDrills, $g_sProfileConfigPath, "MilkingAttack", "AttackDrill", True, "Bool")
	IniReadS($g_iMilkFarmLimitGold, $g_sProfileConfigPath, "MilkingAttack", "LimitGold", 9950000, "int")
	IniReadS($g_iMilkFarmLimitElixir, $g_sProfileConfigPath, "MilkingAttack", "LimitElixir", 9950000, "int")
	IniReadS($g_iMilkFarmLimitDark, $g_sProfileConfigPath, "MilkingAttack", "LimitDark", 200000, "int")
	IniReadS($g_iMilkFarmTroopForWaveMin, $g_sProfileConfigPath, "MilkingAttack", "TroopForWaveMin", 4, "int")
	IniReadS($g_iMilkFarmTroopForWaveMax, $g_sProfileConfigPath, "MilkingAttack", "TroopForWaveMax", 6, "int")
	IniReadS($g_iMilkFarmTroopMaxWaves, $g_sProfileConfigPath, "MilkingAttack", "MaxWaves", 4, "int")
	IniReadS($g_iMilkFarmDelayFromWavesMin, $g_sProfileConfigPath, "MilkingAttack", "DelayBetweenWavesMin", 3000, "int")
	IniReadS($g_iMilkFarmDelayFromWavesMax, $g_sProfileConfigPath, "MilkingAttack", "DelayBetweenWavesMax", 5000, "int")
	IniReadS($g_iMilkingAttackDropGoblinAlgorithm, $g_sProfileConfigPath, "MilkingAttack", "DropRandomPlace", 0, "int")
	IniReadS($g_iMilkingAttackStructureOrder, $g_sProfileConfigPath, "MilkingAttack", "StructureOrder", 1, "int")
	IniReadS($g_bMilkingAttackCheckStructureDestroyedBeforeAttack, $g_sProfileConfigPath, "MilkingAttack", "CheckStructureDestroyedBeforeAttack", False, "Bool")
	IniReadS($g_bMilkingAttackCheckStructureDestroyedAfterAttack, $g_sProfileConfigPath, "MilkingAttack", "CheckStructureDestroyedAfterAttack", False, "Bool")
	IniReadS($g_bMilkAttackAfterTHSnipeEnable, $g_sProfileConfigPath, "MilkingAttack", "MilkAttackAfterTHSnipe", False, "Bool")
	IniReadS($g_iMilkFarmTHMaxTilesFromBorder, $g_sProfileConfigPath, "MilkingAttack", "TownhallTiles", 0, "int")
	IniReadS($g_sMilkFarmAlgorithmTh, $g_sProfileConfigPath, "MilkingAttack", "TownHallAlgorithm", "Bam")
	IniReadS($g_bMilkFarmSnipeEvenIfNoExtractorsFound, $g_sProfileConfigPath, "MilkingAttack", "TownHallHitAnyway", False, "Bool")
	IniReadS($g_bMilkAttackAfterScriptedAtkEnable, $g_sProfileConfigPath, "MilkingAttack", "MilkAttackAfterScriptedAtk", False, "Bool")
	IniReadS($g_sMilkAttackCSVscript, $g_sProfileConfigPath, "MilkingAttack", "MilkAttackCSVscript", "0")
	IniReadS($g_bMilkFarmForceToleranceEnable, $g_sProfileConfigPath, "MilkingAttack", "MilkFarmForceTolerance", False, "Bool")
	IniReadS($g_iMilkFarmForceToleranceNormal, $g_sProfileConfigPath, "MilkingAttack", "MilkFarmForcetolerancenormal", 60, "int")
	IniReadS($g_iMilkFarmForceToleranceBoosted, $g_sProfileConfigPath, "MilkingAttack", "MilkFarmForcetoleranceboosted", 60, "int")
	IniReadS($g_iMilkFarmForceToleranceDestroyed, $g_sProfileConfigPath, "MilkingAttack", "MilkFarmForcetolerancedestroyed", 60, "int")
EndFunc

Func ReadConfig_600_29_LB()
	; <><><><> Attack Plan / Search & Attack / Activebase / Attack <><><><>
	IniReadS($g_aiAttackAlgorithm[$LB], $g_sProfileConfigPath, "attack", "ABAtkAlgorithm", 0, "int")
	IniReadS($g_aiAttackTroopSelection[$LB], $g_sProfileConfigPath, "attack", "ABSelectTroop", 0, "int")
	Local $temp1, $temp2, $temp3
	IniReadS($temp1, $g_sProfileConfigPath, "attack", "ABKingAtk", $eHeroNone)
	IniReadS($temp2, $g_sProfileConfigPath, "attack", "ABQueenAtk", $eHeroNone)
	IniReadS($temp3, $g_sProfileConfigPath, "attack", "ABWardenAtk", $eHeroNone)
	$g_aiAttackUseHeroes[$LB] = BitOR(Int($temp1), Int($temp2), Int($temp3))
	IniReadS($g_abAttackDropCC[$LB], $g_sProfileConfigPath, "attack", "ABDropCC", False, "Bool")
	IniReadS($g_abAttackUseLightSpell[$LB], $g_sProfileConfigPath, "attack", "ABLightSpell", False, "Bool")
	IniReadS($g_abAttackUseHealSpell[$LB], $g_sProfileConfigPath, "attack", "ABHealSpell", False, "Bool")
	IniReadS($g_abAttackUseRageSpell[$LB], $g_sProfileConfigPath, "attack", "ABRageSpell", False, "Bool")
	IniReadS($g_abAttackUseJumpSpell[$LB], $g_sProfileConfigPath, "attack", "ABJumpSpell", False, "Bool")
	IniReadS($g_abAttackUseFreezeSpell[$LB], $g_sProfileConfigPath, "attack", "ABFreezeSpell", False, "Bool")
	IniReadS($g_abAttackUsePoisonSpell[$LB], $g_sProfileConfigPath, "attack", "ABPoisonSpell", False, "Bool")
	IniReadS($g_abAttackUseEarthquakeSpell[$LB], $g_sProfileConfigPath, "attack", "ABEarthquakeSpell", False, "Bool")
	IniReadS($g_abAttackUseHasteSpell[$LB], $g_sProfileConfigPath, "attack", "ABHasteSpell", False, "Bool")
	IniReadS($g_abAttackUseCloneSpell[$LB], $g_sProfileConfigPath, "attack", "ABCloneSpell", False, "Bool")
	IniReadS($g_abAttackUseSkeletonSpell[$LB], $g_sProfileConfigPath, "attack", "ABSkeletonSpell", False, "Bool")
	IniReadS($g_bTHSnipeBeforeEnable[$LB], $g_sProfileConfigPath, "attack", "THSnipeBeforeLBEnable", False, "Bool")
	IniReadS($g_iTHSnipeBeforeTiles[$LB], $g_sProfileConfigPath, "attack", "THSnipeBeforeLBTiles", 0, "int")
	IniReadS($g_iTHSnipeBeforeScript[$LB], $g_sProfileConfigPath, "attack", "THSnipeBeforeLBScript", "bam")
	; <><><><> Attack Plan / Search & Attack / Activebase / Attack / Standard <><><><>
	IniReadS($g_aiAttackStdDropOrder[$LB], $g_sProfileConfigPath, "attack", "LBStandardAlgorithm", 0, "int")
	IniReadS($g_aiAttackStdDropSides[$LB], $g_sProfileConfigPath, "attack", "ABDeploy", 0, "int")
	IniReadS($g_aiAttackStdUnitDelay[$LB], $g_sProfileConfigPath, "attack", "ABUnitD", 4, "int")
	IniReadS($g_aiAttackStdWaveDelay[$LB], $g_sProfileConfigPath, "attack", "ABWaveD", 4, "int")
	IniReadS($g_abAttackStdRandomizeDelay[$LB], $g_sProfileConfigPath, "attack", "ABRandomSpeedAtk", True, "Bool")
	IniReadS($g_abAttackStdSmartAttack[$LB], $g_sProfileConfigPath, "attack", "ABSmartAttackRedArea", True, "Bool")
	IniReadS($g_aiAttackStdSmartDeploy[$LB], $g_sProfileConfigPath, "attack", "ABSmartAttackDeploy", 1, "int")
	IniReadS($g_abAttackStdSmartNearCollectors[$LB][0], $g_sProfileConfigPath, "attack", "ABSmartAttackGoldMine", False, "Bool")
	IniReadS($g_abAttackStdSmartNearCollectors[$LB][1], $g_sProfileConfigPath, "attack", "ABSmartAttackElixirCollector", False, "Bool")
	IniReadS($g_abAttackStdSmartNearCollectors[$LB][2], $g_sProfileConfigPath, "attack", "ABSmartAttackDarkElixirDrill", False, "Bool")
	; <><><><> Attack Plan / Search & Attack / Activebase / Attack / Scripted <><><><>
	IniReadS($g_aiAttackScrRedlineRoutine[$LB], $g_sProfileConfigPath, "attack", "RedlineRoutineAB", $g_aiAttackScrRedlineRoutine[$LB], "Int")
	IniReadS($g_aiAttackScrDroplineEdge[$LB], $g_sProfileConfigPath, "attack", "DroplineEdgeAB", $g_aiAttackScrDroplineEdge[$LB], "Int")
	IniReadS($g_sAttackScrScriptName[$LB], $g_sProfileConfigPath, "attack", "ScriptAB", "Barch four fingers")
EndFunc

Func ReadConfig_600_29_TS()
	; <><><><> Attack Plan / Search & Attack / TH Snipe / Attack <><><><>
	IniReadS($g_aiAttackTroopSelection[$TS], $g_sProfileConfigPath, "attack", "TSSelectTroop", 0, "int")
	Local $temp1, $temp2, $temp3
	IniReadS($temp1, $g_sProfileConfigPath, "attack", "TSKingAtk", $eHeroNone)
	IniReadS($temp2, $g_sProfileConfigPath, "attack", "TSQueenAtk", $eHeroNone)
	IniReadS($temp3, $g_sProfileConfigPath, "attack", "TSWardenAtk", $eHeroNone)
	$g_aiAttackUseHeroes[$TS] = BitOR(Int($temp1), Int($temp2), Int($temp3))
	IniReadS($g_abAttackDropCC[$TS], $g_sProfileConfigPath, "attack", "TSDropCC", False, "Bool")
	IniReadS($g_abAttackUseHealSpell[$TS], $g_sProfileConfigPath, "attack", "TSHealSpell",False, "Bool")
	IniReadS($g_abAttackUseLightSpell[$TS], $g_sProfileConfigPath, "attack", "TSLightSpell", False, "Bool")
	IniReadS($g_abAttackUseRageSpell[$TS], $g_sProfileConfigPath, "attack", "TSRageSpell", False, "Bool")
	IniReadS($g_abAttackUseJumpSpell[$TS], $g_sProfileConfigPath, "attack", "TSJumpSpell", False, "Bool")
	IniReadS($g_abAttackUseFreezeSpell[$TS], $g_sProfileConfigPath, "attack", "TSFreezeSpell", False, "Bool")
	IniReadS($g_abAttackUsePoisonSpell[$TS], $g_sProfileConfigPath, "attack", "TSPoisonSpell", False, "Bool")
	IniReadS($g_abAttackUseEarthquakeSpell[$TS], $g_sProfileConfigPath, "attack", "TSEarthquakeSpell", False, "Bool")
	IniReadS($g_abAttackUseHasteSpell[$TS], $g_sProfileConfigPath, "attack", "TSHasteSpell", False, "Bool")
	IniReadS($g_sAtkTSType, $g_sProfileConfigPath, "attack", "AttackTHType", "bam")
EndFunc

Func ReadConfig_600_30()
	; <><><><> Attack Plan / Search & Attack / Options / End Battle <><><><>
	$iShareAttack = Int(IniRead($g_sProfileConfigPath, "shareattack", "ShareAttack", 0))
	$iShareminGold = Int(IniRead($g_sProfileConfigPath, "shareattack", "minGold", 200000))
	$iShareminElixir = Int(IniRead($g_sProfileConfigPath, "shareattack", "minElixir", 200000))
	$iSharemindark = Int(IniRead($g_sProfileConfigPath, "shareattack", "minDark", 100))
	$sShareMessage = StringReplace(IniRead($g_sProfileConfigPath, "shareattack", "Message", "Nice|Good|Thanks|Wowwww"), "|", @CRLF)
	IniReadS($TakeLootSnapShot, $g_sProfileConfigPath, "attack", "TakeLootSnapShot", 0, "int")
	IniReadS($ScreenshotLootInfo, $g_sProfileConfigPath, "attack", "ScreenshotLootInfo", 0, "int")
EndFunc

Func ReadConfig_600_30_DB()
	; <><><><> Attack Plan / Search & Attack / Deadbase / End Battle <><><><>
	IniReadS($g_abStopAtkNoLoot1Enable[$DB], $g_sProfileConfigPath, "endbattle", "chkDBTimeStopAtk", True, "Bool")
	IniReadS($g_aiStopAtkNoLoot1Time[$DB], $g_sProfileConfigPath, "endbattle", "txtDBTimeStopAtk", 15, "int")
	IniReadS($g_abStopAtkNoLoot2Enable[$DB], $g_sProfileConfigPath, "endbattle", "chkDBTimeStopAtk2", False, "Bool")
	IniReadS($g_aiStopAtkNoLoot2Time[$DB], $g_sProfileConfigPath, "endbattle", "txtDBTimeStopAtk2", 7, "int")
	IniReadS($g_aiStopAtkNoLoot2MinGold[$DB], $g_sProfileConfigPath, "endbattle", "txtDBMinGoldStopAtk2", 1000, "int")
	IniReadS($g_aiStopAtkNoLoot2MinElixir[$DB], $g_sProfileConfigPath, "endbattle", "txtDBMinElixirStopAtk2", 1000, "int")
	IniReadS($g_aiStopAtkNoLoot2MinDark[$DB], $g_sProfileConfigPath, "endbattle", "txtDBMinDarkElixirStopAtk2", 50, "int")
	IniReadS($g_abStopAtkNoResources[$DB], $g_sProfileConfigPath, "endbattle", "chkDBEndNoResources", False, "Bool")
	IniReadS($g_abStopAtkOneStar[$DB], $g_sProfileConfigPath, "endbattle", "chkDBEndOneStar", False, "Bool")
	IniReadS($g_abStopAtkTwoStars[$DB], $g_sProfileConfigPath, "endbattle", "chkDBEndTwoStars", False, "Bool")
	IniReadS($g_abStopAtkPctHigherEnable[$DB], $g_sProfileConfigPath, "endbattle", "chkDBPercentageHigher", False, "Bool")
	IniReadS($g_aiStopAtkPctHigherAmt[$DB], $g_sProfileConfigPath, "endbattle", "txtDBPercentageHigher", 50, "int")
	IniReadS($g_abStopAtkPctNoChangeEnable[$DB], $g_sProfileConfigPath, "endbattle", "chkDBPercentageChange", False, "Bool")
	IniReadS($g_aiStopAtkPctNoChangeTime[$DB], $g_sProfileConfigPath, "endbattle", "txtDBPercentageChange", 15, "int")
EndFunc

Func ReadConfig_600_30_LB()
	; <><><><> Attack Plan / Search & Attack / Activebase / End Battle <><><><>

	IniReadS($g_abStopAtkNoLoot1Enable[$LB], $g_sProfileConfigPath, "endbattle", "chkABTimeStopAtk", True, "Bool")
	IniReadS($g_aiStopAtkNoLoot1Time[$LB], $g_sProfileConfigPath, "endbattle", "txtABTimeStopAtk", 20, "int")
	IniReadS($g_abStopAtkNoLoot2Enable[$LB], $g_sProfileConfigPath, "endbattle", "chkABTimeStopAtk2", False, "Bool")
	IniReadS($g_aiStopAtkNoLoot2Time[$LB], $g_sProfileConfigPath, "endbattle", "txtABTimeStopAtk2", 7, "int")
	IniReadS($g_aiStopAtkNoLoot2MinGold[$LB], $g_sProfileConfigPath, "endbattle", "txtABMinGoldStopAtk2", 1000, "int")
	IniReadS($g_aiStopAtkNoLoot2MinElixir[$LB], $g_sProfileConfigPath, "endbattle", "txtABMinElixirStopAtk2", 1000, "int")
	IniReadS($g_aiStopAtkNoLoot2MinDark[$LB], $g_sProfileConfigPath, "endbattle", "txtABMinDarkElixirStopAtk2", 50, "int")
	IniReadS($g_abStopAtkNoResources[$LB], $g_sProfileConfigPath, "endbattle", "chkABEndNoResources", False, "Bool")
	IniReadS($g_abStopAtkOneStar[$LB], $g_sProfileConfigPath, "endbattle", "chkABEndOneStar", False, "Bool")
	IniReadS($g_abStopAtkTwoStars[$LB], $g_sProfileConfigPath, "endbattle", "chkABEndTwoStars", False, "Bool")
	IniReadS($g_bDESideEndEnable, $g_sProfileConfigPath, "endbattle", "chkDESideEB", False, "Bool")
	IniReadS($g_iDESideEndMin, $g_sProfileConfigPath, "endbattle", "txtDELowEndMin", 25, "int")
	IniReadS($g_bDESideDisableOther, $g_sProfileConfigPath, "endbattle", "chkDisableOtherEBO", False, "Bool")
	IniReadS($g_bDESideEndBKWeak, $g_sProfileConfigPath, "endbattle", "chkDEEndBk", False, "Bool")
	IniReadS($g_bDESideEndAQWeak, $g_sProfileConfigPath, "endbattle", "chkDEEndAq", False, "Bool")
	IniReadS($g_bDESideEndOneStar, $g_sProfileConfigPath, "endbattle", "chkDEEndOneStar", False, "Bool")
	IniReadS($g_abStopAtkPctHigherEnable[$LB], $g_sProfileConfigPath, "endbattle", "chkABPercentageHigher", False, "Bool")
	IniReadS($g_aiStopAtkPctHigherAmt[$LB], $g_sProfileConfigPath, "endbattle", "txtABPercentageHigher", 50, "int")
	IniReadS($g_abStopAtkPctNoChangeEnable[$LB], $g_sProfileConfigPath, "endbattle", "chkABPercentageChange", False, "Bool")
	IniReadS($g_aiStopAtkPctNoChangeTime[$LB], $g_sProfileConfigPath, "endbattle", "txtABPercentageChange", 15, "int")
EndFunc

Func ReadConfig_600_30_TS()
	; <><><><> Attack Plan / Search & Attack / TH Snipe / End Battle <><><><>
	IniReadS($g_bEndTSCampsEnable, $g_sProfileConfigPath, "search", "ChkTSSearchCamps2", False, "Bool")
	IniReadS($g_iEndTSCampsPct, $g_sProfileConfigPath, "search", "TSEnableAfterArmyCamps2", 100, "int")
EndFunc

Func ReadConfig_600_31()
	; <><><><> Attack Plan / Search & Attack / Deadbase / Collectors <><><><>
	$g_abCollectorLevelEnabled[6] = 0
	For $i = 7 To 12
	  IniReadS($g_abCollectorLevelEnabled[$i], $g_sProfileConfigPath, "collectors", "lvl" & $i & "Enabled", True, "Bool")
    Next
	For $i = 6 To 12
	   IniReadS($g_aiCollectorLevelFill[$i], $g_sProfileConfigPath, "collectors", "lvl" & $i & "fill", 0, "int")
	   If $g_aiCollectorLevelFill[$i] > 1 Then $g_aiCollectorLevelFill[$i] = 1
    Next
	IniReadS($g_bCollectorFilterDisable, $g_sProfileConfigPath, "search", "chkDisableCollectorsFilter", False, "Bool")
	InireadS($g_iCollectorMatchesMin, $g_sProfileConfigPath, "collectors", "minmatches", $g_iCollectorMatchesMin) ; 1-6 collectors
	If $g_iCollectorMatchesMin < 1 Or $g_iCollectorMatchesMin > 6 Then $g_iCollectorMatchesMin = 3
	IniReadS($g_iCollectorToleranceOffset, $g_sProfileConfigPath, "collectors", "tolerance", 0, "int")
EndFunc

Func ReadConfig_600_32()
	; <><><><> Attack Plan / Search & Attack / Options / Trophy Settings <><><><>
	IniReadS($iChkTrophyRange, $g_sProfileConfigPath, "search", "TrophyRange", 0, "int")
	IniReadS($itxtdropTrophy, $g_sProfileConfigPath, "search", "MinTrophy", 5000, "int")
	IniReadS($itxtMaxTrophy, $g_sProfileConfigPath, "search", "MaxTrophy", 5000, "int")
	IniReadS($iChkTrophyHeroes, $g_sProfileConfigPath, "search", "chkTrophyHeroes", 0, "int")
	IniReadS($iCmbTrophyHeroesPriority, $g_sProfileConfigPath, "search", "cmbTrophyHeroesPriority", 0, "int")
	IniReadS($iChkTrophyAtkDead, $g_sProfileConfigPath, "search", "chkTrophyAtkDead", 0, "int")
	IniReadS($itxtDTArmyMin, $g_sProfileConfigPath, "search", "DTArmyMin", 70, "int")
EndFunc

Func ReadConfig_600_35()
	; <><><><> Bot / Options <><><><>
	;Global $sLanguage = "English"
	$ichkDisableSplash = IniRead($g_sProfileConfigPath, "General", "ChkDisableSplash", $ichkDisableSplash)
	$ichkVersion = Int(IniRead($g_sProfileConfigPath, "General", "ChkVersion", 1))
	IniReadS($ichkDeleteLogs, $g_sProfileConfigPath, "deletefiles", "DeleteLogs", 1, "int")
	IniReadS($iDeleteLogsDays, $g_sProfileConfigPath, "deletefiles", "DeleteLogsDays", 2, "int")
	IniReadS($ichkDeleteTemp, $g_sProfileConfigPath, "deletefiles", "DeleteTemp", 1, "int")
	IniReadS($iDeleteTempDays, $g_sProfileConfigPath, "deletefiles", "DeleteTempDays", 2, "int")
	IniReadS($ichkDeleteLoots, $g_sProfileConfigPath, "deletefiles", "DeleteLoots", 1, "int")
	IniReadS($iDeleteLootsDays, $g_sProfileConfigPath, "deletefiles", "DeleteLootsDays", 2, "int")
	IniReadS($ichkAutoStart, $g_sProfileConfigPath, "general", "AutoStart", 0, "int")
	IniReadS($ichkAutoStartDelay, $g_sProfileConfigPath, "general", "AutoStartDelay", 10, "int")
	IniReadS($g_bRestarted, $g_sProfileConfigPath, "general", "Restarted", $g_bRestarted, "int")
	If $g_bBotLaunchOption_Autostart = True Then $g_bRestarted = True
	$ichkLanguage = Int(IniRead($g_sProfileConfigPath, "General", "ChkLanguage", 1))
	IniReadS($iDisposeWindows, $g_sProfileConfigPath, "general", "DisposeWindows", 0, "int")
	IniReadS($icmbDisposeWindowsPos, $g_sProfileConfigPath, "general", "DisposeWindowsPos", "SNAP-TR")
	IniReadS($iWAOffsetX, $g_sProfileConfigPath, "other", "WAOffsetX", "")
	IniReadS($iWAOffsetY, $g_sProfileConfigPath, "other", "WAOffsetY", "")
   ;$iUpdatingWhenMinimized must be always enabled
   ;IniReadS($iUpdatingWhenMinimized, $g_sProfileConfigPath, "general", "UpdatingWhenMinimized", $iUpdatingWhenMinimized)
	IniReadS($iHideWhenMinimized, $g_sProfileConfigPath, "general", "HideWhenMinimized", $iHideWhenMinimized)
	$iUseRandomClick = Int(IniRead($g_sProfileConfigPath, "other", "UseRandomClick", 0))
	$iScreenshotType = Int(IniRead($g_sProfileConfigPath, "other", "ScreenshotType", 0)) ;screenshot type: 0 JPG   1 PNG
	$ichkScreenshotHideName = Int(IniRead($g_sProfileConfigPath, "other", "ScreenshotHideName", 1))
	IniReadS($sTimeWakeUp, $g_sProfileConfigPath, "other", "txtTimeWakeUp", 0, "int")
	$ichkSinglePBTForced = Int(IniRead($g_sProfileConfigPath, "other", "chkSinglePBTForced", 0))
	$iValueSinglePBTimeForced = Int(IniRead($g_sProfileConfigPath, "other", "ValueSinglePBTimeForced", 18))
	$iValuePBTimeForcedExit = Int(IniRead($g_sProfileConfigPath, "other", "ValuePBTimeForcedExit", 15))
	$iChkAutoResume = Int(IniRead($g_sProfileConfigPath, "other", "ChkAutoResume", 0))
	$iAutoResumeTime = Int(IniRead($g_sProfileConfigPath, "other", "AutoResumeTime", 5))
	$ichkFixClanCastle = Int(IniRead($g_sProfileConfigPath, "other", "ChkFixClanCastle", 0))
EndFunc

Func ReadConfig_600_52_1()
	; <><><><> Attack Plan / Train Army / Troops/Spells <><><><>
	$g_bQuickTrainEnable = (IniRead($g_sProfileConfigPath, "other", "ChkUseQTrain", "0") = "1")
    IniReadS($g_iQuickTrainArmyNum, $g_sProfileConfigPath, "troop", "QuickTrainArmyNum", -1, "int")
	If $g_iQuickTrainArmyNum = -1 Then ; Convert 6.5.3 style to 6.5.4+ style for this ini key
	   Local $iQTArmy[3] = [0,0,0]
	   IniReadS($iQTArmy[0], $g_sProfileConfigPath, "troop", "QuickTrain1", 1, "int")
	   IniReadS($iQTArmy[1], $g_sProfileConfigPath, "troop", "QuickTrain2", 0, "int")
	   IniReadS($iQTArmy[2], $g_sProfileConfigPath, "troop", "QuickTrain3", 0, "int")
	   $g_iQuickTrainArmyNum = 1
	   For $i = 0 To 2
		  If $iQTArmy[$i] = 1 Then
			 $g_iQuickTrainArmyNum = $i+1
			 ExitLoop
		  EndIf
	   Next
    EndIf
EndFunc

Func ReadConfig_600_52_2()
	For $T = 0 To $eTroopCount - 1
		Local $tempTroopCount, $tempTroopLevel
		Switch $T
			Case $eTroopBarbarian
				IniReadS($tempTroopCount, $g_sProfileConfigPath, "troop", $g_asTroopShortNames[$T], 58, "int")
				IniReadS($tempTroopLevel, $g_sProfileConfigPath, "LevelTroop", $g_asTroopShortNames[$T], 1, "int")
			Case $eTroopArcher
				IniReadS($tempTroopCount, $g_sProfileConfigPath, "troop", $g_asTroopShortNames[$T], 115, "int")
				IniReadS($tempTroopLevel, $g_sProfileConfigPath, "LevelTroop", $g_asTroopShortNames[$T], 1, "int")
			Case $eTroopGoblin
				IniReadS($tempTroopCount, $g_sProfileConfigPath, "troop", $g_asTroopShortNames[$T], 19, "int")
				IniReadS($tempTroopLevel, $g_sProfileConfigPath, "LevelTroop", $g_asTroopShortNames[$T], 1, "int")
			Case $eTroopGiant
				IniReadS($tempTroopCount, $g_sProfileConfigPath, "troop", $g_asTroopShortNames[$T], 4, "int")
				IniReadS($tempTroopLevel, $g_sProfileConfigPath, "LevelTroop", $g_asTroopShortNames[$T], 1, "int")
			Case $eTroopWallBreaker
				IniReadS($tempTroopCount, $g_sProfileConfigPath, "troop", $g_asTroopShortNames[$T], 4, "int")
				IniReadS($tempTroopLevel, $g_sProfileConfigPath, "LevelTroop", $g_asTroopShortNames[$T], 1, "int")
			Case Else
				IniReadS($tempTroopCount, $g_sProfileConfigPath, "troop", $g_asTroopShortNames[$T], 0, "int")
				IniReadS($tempTroopLevel, $g_sProfileConfigPath, "LevelTroop", $g_asTroopShortNames[$T], 0, "int")
		EndSwitch
		$g_aiArmyCompTroops[$T] = $tempTroopCount
		$g_aiTrainArmyTroopLevel[$T] = $tempTroopLevel
	Next
	For $S = 0 To $eSpellCount - 1
		IniReadS($g_aiArmyCompSpells[$S], $g_sProfileConfigPath, "Spells", $g_asSpellShortNames[$S], 0, "int")
		IniReadS($g_aiTrainArmySpellLevel[$S], $g_sProfileConfigPath, "LevelSpell", $g_asSpellShortNames[$S], 0, "int")
	Next
	IniReadS($g_iTrainArmyFullTroopPct, $g_sProfileConfigPath, "troop", "fullTroop", 100, "int")
	$g_bTotalCampForced = (IniRead($g_sProfileConfigPath, "other", "ChkTotalCampForced", "1") = "1")
	$g_iTotalCampForcedValue = Int(IniRead($g_sProfileConfigPath, "other", "ValueTotalCampForced", 220))
	$g_bForceBrewSpells = (IniRead($g_sProfileConfigPath, "other", "ChkForceBrewBeforeAttack", "0") = "1")
	IniReadS($g_iTotalSpellValue, $g_sProfileConfigPath, "Spells", "SpellFactory", 0, "int")
	$g_iTotalSpellValue = Int($g_iTotalSpellValue)
EndFunc

Func ReadConfig_600_54()
	; <><><><> Attack Plan / Train Army / Train Order <><><><>
	 IniReadS($g_bCustomTrainOrderEnable, $g_sProfileConfigPath, "troop", "chkTroopOrder", False, "Bool")
	 For $z = 0 To UBound($g_aiCmbCustomTrainOrder) -1
		 IniReadS($g_aiCmbCustomTrainOrder[$z], $g_sProfileConfigPath, "troop", "cmbTroopOrder" & $z, -1)
	 Next
EndFunc

Func ReadConfig_600_56()
	; <><><><> Attack Plan / Search & Attack / Options / SmartZap <><><><>
	$ichkSmartZap = Int(IniRead($g_sProfileConfigPath, "SmartZap", "UseSmartZap", 0))
	$ichkEarthQuakeZap = Int(IniRead($g_sProfileConfigPath, "SmartZap", "UseEarthQuakeZap", 0))
	$ichkNoobZap = Int(IniRead($g_sProfileConfigPath, "SmartZap", "UseNoobZap", 0))
	$ichkSmartZapDB = Int(IniRead($g_sProfileConfigPath, "SmartZap", "ZapDBOnly", 1))
	$ichkSmartZapSaveHeroes = Int(IniRead($g_sProfileConfigPath, "SmartZap", "THSnipeSaveHeroes", 1))
	$itxtMinDE = Int(IniRead($g_sProfileConfigPath, "SmartZap", "MinDE", 350))
	$itxtExpectedDE = Int(IniRead($g_sProfileConfigPath, "SmartZap", "ExpectedDE", 320))
	$DebugSmartZap = Int(IniRead($g_sProfileConfigPath, "SmartZap", "DebugSmartZap", 0))
EndFunc

Func ReadConfig_641_1()
	; <><><><> Attack Plan / Train Army / Options <><><><>
	IniReadS($g_bCloseWhileTrainingEnable, $g_sProfileConfigPath, "other", "chkCloseWaitEnable", True, "Bool")
	IniReadS($g_bCloseWithoutShield, $g_sProfileConfigPath, "other", "chkCloseWaitTrain", False, "Bool")
	IniReadS($g_bCloseEmulator, $g_sProfileConfigPath, "other", "btnCloseWaitStop", False, "Bool")
	IniReadS($g_bCloseRandom, $g_sProfileConfigPath, "other", "btnCloseWaitStopRandom", False, "Bool")
	IniReadS($g_bCloseExactTime, $g_sProfileConfigPath, "other", "btnCloseWaitExact", False, "Bool")
	IniReadS($g_bCloseRandomTime, $g_sProfileConfigPath, "other", "btnCloseWaitRandom", True, "Bool")
	IniReadS($g_iCloseRandomTimePercent, $g_sProfileConfigPath, "other", "CloseWaitRdmPercent", 10, "int")
	IniReadS($g_iCloseMinimumTime, $g_sProfileConfigPath, "other", "MinimumTimeToClose", 2, "int")
	IniReadS($g_iTrainClickDelay, $g_sProfileConfigPath, "other", "TrainITDelay", 40, "int")
	IniReadS($g_bTrainAddRandomDelayEnable, $g_sProfileConfigPath, "other", "chkAddIdleTime", $g_bTrainAddRandomDelayEnable, "Bool")
	IniReadS($g_iTrainAddRandomDelayMin, $g_sProfileConfigPath, "other", "txtAddDelayIdlePhaseTimeMin", $g_iTrainAddRandomDelayMin, "Int")
	IniReadS($g_iTrainAddRandomDelayMax, $g_sProfileConfigPath, "other", "txtAddDelayIdlePhaseTimeMax", $g_iTrainAddRandomDelayMax, "Int")
EndFunc

Func IniReadS(ByRef $variable, $PrimaryInputFile, $section, $key, $defaultvalue, $valueType = Default)
	;read from standard config ini file but, if variable $g_sProfileSecondaryInputFileName <>"" (valorized by button read strategy), if exists
	;section->key override values from ini files with values in $g_sProfileSecondaryInputFileName
	Local $defaultvalueTest = "?"
	Local $readValue = IniRead($g_sProfileSecondaryInputFileName, $section, $key, $defaultvalueTest)
    If $readValue = $defaultvalueTest Then
		$readValue = IniRead($PrimaryInputFile, $section, $key, $defaultvalue)
	EndIf
	Switch $valueType
		Case Default
			; no conversion
			$variable = $readValue
		Case "Int"
			; convert to Int
			$variable = Int($readValue)
	    Case "Bool"
			; convert to boolean type
		    If $readValue = "True" Or $readValue = "1" Then
			   $variable = True
			Else
			   $variable = False
			EndIf
		Case Else
			; Unsupported type
			$variable = $readValue
    EndSwitch

EndFunc   ;==>IniReadS