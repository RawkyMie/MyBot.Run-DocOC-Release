; #FUNCTION# ====================================================================================================================
; Name ..........: AttackReport
; Description ...: This function will report the loot from the last Attack: gold, elixir, dark elixir and trophies.
;                  It will also update the statistics to the GUI (Last Attack).
; Syntax ........: AttackReport()
; Parameters ....: None
; Return values .: None
; Author ........: Hervidero (2015-feb-10), Sardo (may-2015), Hervidero (2015-12)
; Modified ......: Sardo (may-2015), Hervidero (may-2015), Knowjack (July 2015)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func AttackReport()
    Static $iBonusLast = 0 ; last attack Bonus percentage
    Local $LeagueShort = ""
	Local $iCount

	$iCount = 0 ; Reset loop counter
	While _CheckPixel($aEndFightSceneAvl, True) = False ; check for light gold pixle in the Gold ribbon in End of Attack Scene before reading values
		$iCount += 1
		If _Sleep($iDelayAttackReport1) Then Return
		If $g_iDebugSetlog = 1 Then Setlog("Waiting Attack Report Ready, " & ($iCount / 2) & " Seconds.", $COLOR_DEBUG)
		If $iCount > 30 Then ExitLoop ; wait 30*500ms = 15 seconds max for the window to render
	WEnd
	If $iCount > 30 Then Setlog("End of Attack scene slow to appear, attack values my not be correct", $COLOR_INFO)

	$iCount = 0 ; reset loop counter
	While getResourcesLoot(333, 289 + $g_iMidOffsetY) = "" ; check for gold value to be non-zero before reading other values as a secondary timer to make sure all values are available
		$iCount += 1
		If _Sleep($iDelayAttackReport1) Then Return
		If $g_iDebugSetlog = 1 Then Setlog("Waiting Attack Report Ready, " & ($iCount / 2) & " Seconds.", $COLOR_DEBUG)
		If $iCount > 20 Then ExitLoop ; wait 20*500ms = 10 seconds max before we have call the OCR read an error
	WEnd
	If $iCount > 20 Then Setlog("End of Attack scene read gold error, attack values my not be correct", $COLOR_INFO)

	If _ColorCheck(_GetPixelColor($aAtkRprtDECheck[0], $aAtkRprtDECheck[1], True), Hex($aAtkRprtDECheck[2], 6), $aAtkRprtDECheck[3]) Then ; if the color of the DE drop detected
		$g_iStatsLastAttack[$eLootGold] = getResourcesLoot(333, 289 + $g_iMidOffsetY)
		If _Sleep($iDelayAttackReport2) Then Return
		$g_iStatsLastAttack[$eLootElixir] = getResourcesLoot(333, 328 + $g_iMidOffsetY)
		If _Sleep($iDelayAttackReport2) Then Return
		$g_iStatsLastAttack[$eLootDarkElixir] = getResourcesLootDE(365, 365 + $g_iMidOffsetY)
		If _Sleep($iDelayAttackReport2) Then Return
		$g_iStatsLastAttack[$eLootTrophy] = getResourcesLootT(403, 402 + $g_iMidOffsetY)
		If _ColorCheck(_GetPixelColor($aAtkRprtTrophyCheck[0], $aAtkRprtTrophyCheck[1], True), Hex($aAtkRprtTrophyCheck[2], 6), $aAtkRprtTrophyCheck[3]) Then
			$g_iStatsLastAttack[$eLootTrophy] = -$g_iStatsLastAttack[$eLootTrophy]
		EndIf
		SetLog("Loot: [G]: " & _NumberFormat($g_iStatsLastAttack[$eLootGold]) & " [E]: " & _NumberFormat($g_iStatsLastAttack[$eLootElixir]) & " [DE]: " & _NumberFormat($g_iStatsLastAttack[$eLootDarkElixir]) & " [T]: " & $g_iStatsLastAttack[$eLootTrophy], $COLOR_SUCCESS)
	Else
		$g_iStatsLastAttack[$eLootGold] = getResourcesLoot(333, 289 + $g_iMidOffsetY)
		If _Sleep($iDelayAttackReport2) Then Return
		$g_iStatsLastAttack[$eLootElixir] = getResourcesLoot(333, 328 + $g_iMidOffsetY)
		If _Sleep($iDelayAttackReport2) Then Return
		$g_iStatsLastAttack[$eLootTrophy] = getResourcesLootT(403, 365 + $g_iMidOffsetY)
		If _ColorCheck(_GetPixelColor($aAtkRprtTrophyCheck[0], $aAtkRprtTrophyCheck[1], True), Hex($aAtkRprtTrophyCheck[2], 6), $aAtkRprtTrophyCheck[3]) Then
			$g_iStatsLastAttack[$eLootTrophy] = -$g_iStatsLastAttack[$eLootTrophy]
		EndIf
		$g_iStatsLastAttack[$eLootDarkElixir] = ""
		SetLog("Loot: [G]: " & _NumberFormat($g_iStatsLastAttack[$eLootGold]) & " [E]: " & _NumberFormat($g_iStatsLastAttack[$eLootElixir]) & " [T]: " & $g_iStatsLastAttack[$eLootTrophy], $COLOR_SUCCESS)
	EndIf

	If $g_iStatsLastAttack[$eLootTrophy] >= 0 Then
		$iBonusLast = Number(getResourcesBonusPerc(570, 309 + $g_iMidOffsetY))
		If $iBonusLast > 0 Then
			SetLog("Bonus Percentage: " & $iBonusLast & "%")
			Local $iCalcMaxBonus = 0, $iCalcMaxBonusDark = 0

			If _ColorCheck(_GetPixelColor($aAtkRprtDECheck2[0], $aAtkRprtDECheck2[1], True), Hex($aAtkRprtDECheck2[2], 6), $aAtkRprtDECheck2[3]) Then
				If _Sleep($iDelayAttackReport2) Then Return
				$g_iStatsBonusLast[$eLootGold] = getResourcesBonus(590, 340 + $g_iMidOffsetY)
				$g_iStatsBonusLast[$eLootGold] = StringReplace($g_iStatsBonusLast[$eLootGold], "+", "")
				If _Sleep($iDelayAttackReport2) Then Return
				$g_iStatsBonusLast[$eLootElixir] = getResourcesBonus(590, 371 + $g_iMidOffsetY)
				$g_iStatsBonusLast[$eLootElixir] = StringReplace($g_iStatsBonusLast[$eLootElixir], "+", "")
				If _Sleep($iDelayAttackReport2) Then Return
				$g_iStatsBonusLast[$eLootDarkElixir] = getResourcesBonus(621, 402 + $g_iMidOffsetY)
				$g_iStatsBonusLast[$eLootDarkElixir] = StringReplace($g_iStatsBonusLast[$eLootDarkElixir], "+", "")

				If $iBonusLast = 100 Then
					$iCalcMaxBonus = $g_iStatsBonusLast[$eLootGold]
					SetLog("Bonus [G]: " & _NumberFormat($g_iStatsBonusLast[$eLootGold]) & " [E]: " & _NumberFormat($g_iStatsBonusLast[$eLootElixir]) & " [DE]: " & _NumberFormat($g_iStatsBonusLast[$eLootDarkElixir]), $COLOR_SUCCESS)
				Else
					$iCalcMaxBonus = Number($g_iStatsBonusLast[$eLootGold] / ($iBonusLast / 100))
					$iCalcMaxBonusDark = Number($g_iStatsBonusLast[$eLootDarkElixir] / ($iBonusLast / 100))

					SetLog("Bonus [G]: " & _NumberFormat($g_iStatsBonusLast[$eLootGold]) & " out of " & _NumberFormat($iCalcMaxBonus) & " [E]: " & _NumberFormat($g_iStatsBonusLast[$eLootElixir]) & " out of " & _NumberFormat($iCalcMaxBonus) & " [DE]: " & _NumberFormat($g_iStatsBonusLast[$eLootDarkElixir]) & " out of " & _NumberFormat($iCalcMaxBonusDark), $COLOR_SUCCESS)
				EndIf
			Else
				If _Sleep($iDelayAttackReport2) Then Return
				$g_iStatsBonusLast[$eLootGold] = getResourcesBonus(590, 340 + $g_iMidOffsetY)
				$g_iStatsBonusLast[$eLootGold] = StringReplace($g_iStatsBonusLast[$eLootGold], "+", "")
				If _Sleep($iDelayAttackReport2) Then Return
				$g_iStatsBonusLast[$eLootElixir] = getResourcesBonus(590, 371 + $g_iMidOffsetY)
				$g_iStatsBonusLast[$eLootElixir] = StringReplace($g_iStatsBonusLast[$eLootElixir], "+", "")
				$g_iStatsBonusLast[$eLootDarkElixir] = 0

				If $iBonusLast = 100 Then
					$iCalcMaxBonus = $g_iStatsBonusLast[$eLootGold]
					SetLog("Bonus [G]: " & _NumberFormat($g_iStatsBonusLast[$eLootGold]) & " [E]: " & _NumberFormat($g_iStatsBonusLast[$eLootElixir]), $COLOR_SUCCESS)
				Else
					$iCalcMaxBonus = Number($g_iStatsBonusLast[$eLootGold] / ($iBonusLast / 100))
					SetLog("Bonus [G]: " & _NumberFormat($g_iStatsBonusLast[$eLootGold]) & " out of " & _NumberFormat($iCalcMaxBonus) & " [E]: " & _NumberFormat($g_iStatsBonusLast[$eLootElixir]) & " out of " & _NumberFormat($iCalcMaxBonus), $COLOR_SUCCESS)
				EndIf
			EndIf

			$LeagueShort = "--"
			For $i = 1 To 21 ; skip 0 = Bronze III, see "No Bonus" else section below
				If _Sleep($iDelayAttackReport2) Then Return
				If $League[$i][0] = $iCalcMaxBonus Then
					SetLog("Your league level is: " & $League[$i][1])
					$LeagueShort = $League[$i][3]
					ExitLoop
				EndIf
			Next
		Else
			SetLog("No Bonus")

			$LeagueShort = "--"
			If $iTrophyCurrent + $g_iStatsLastAttack[$eLootTrophy] >= 400 And $iTrophyCurrent + $g_iStatsLastAttack[$eLootTrophy] < 500 Then ; Bronze III has no League bonus
				SetLog("Your league level is: " & $League[0][1])
				$LeagueShort = $League[0][3]
			EndIf
		EndIf
		;Display League in Stats ==>
		GUICtrlSetData($g_hLblLeague, "")

		If StringInStr($LeagueShort, "1") > 1 Then
			GUICtrlSetData($g_hLblLeague, "1")
		ElseIf StringInStr($LeagueShort, "2") > 1 Then
			GUICtrlSetData($g_hLblLeague, "2")
		ElseIf StringInStr($LeagueShort, "3") > 1 Then
			GUICtrlSetData($g_hLblLeague, "3")
		EndIf
		_GUI_Value_STATE("HIDE", $groupLeague)
		If StringInStr($LeagueShort, "B") > 0 Then
			GUICtrlSetState($g_ahPicLeague[$eLeagueBronze], $GUI_SHOW)
		ElseIf StringInStr($LeagueShort, "S") > 0 Then
			GUICtrlSetState($g_ahPicLeague[$eLeagueSilver], $GUI_SHOW)
		ElseIf StringInStr($LeagueShort, "G") > 0 Then
			GUICtrlSetState($g_ahPicLeague[$eLeagueGold], $GUI_SHOW)
		ElseIf StringInStr($LeagueShort, "c", $STR_CASESENSE) > 0 Then
			GUICtrlSetState($g_ahPicLeague[$eLeagueCrystal], $GUI_SHOW)
		ElseIf StringInStr($LeagueShort, "M") > 0 Then
			GUICtrlSetState($g_ahPicLeague[$eLeagueMaster], $GUI_SHOW)
		ElseIf StringInStr($LeagueShort, "C", $STR_CASESENSE) > 0 Then
			GUICtrlSetState($g_ahPicLeague[$eLeagueChampion], $GUI_SHOW)
		ElseIf StringInStr($LeagueShort, "T") > 0 Then
			GUICtrlSetState($g_ahPicLeague[$eLeagueTitan], $GUI_SHOW)
		ElseIf StringInStr($LeagueShort, "LE") > 0 Then
			GUICtrlSetState($g_ahPicLeague[$eLeagueLegend], $GUI_SHOW)
		Else
			GUICtrlSetState($g_ahPicLeague[$eLeagueUnranked],$GUI_SHOW)
		EndIf
		;==> Display League in Stats
	Else
		$g_iStatsBonusLast[$eLootGold] = 0
		$g_iStatsBonusLast[$eLootElixir] = 0
		$g_iStatsBonusLast[$eLootDarkElixir] = 0
		$LeagueShort = "--"
	EndIf

	; check stars earned
	Local $starsearned = 0
	If _ColorCheck(_GetPixelColor($aWonOneStarAtkRprt[0], $aWonOneStarAtkRprt[1], True), Hex($aWonOneStarAtkRprt[2], 6), $aWonOneStarAtkRprt[3]) Then $starsearned += 1
	If _ColorCheck(_GetPixelColor($aWonTwoStarAtkRprt[0], $aWonTwoStarAtkRprt[1], True), Hex($aWonTwoStarAtkRprt[2], 6), $aWonTwoStarAtkRprt[3]) Then $starsearned += 1
	If _ColorCheck(_GetPixelColor($aWonThreeStarAtkRprt[0], $aWonThreeStarAtkRprt[1], True), Hex($aWonThreeStarAtkRprt[2], 6), $aWonThreeStarAtkRprt[3]) Then $starsearned += 1
	SetLog("Stars earned: " & $starsearned)

	Local $AtkLogTxt
	$AtkLogTxt = "" & _NowTime(4) & "|"
	$AtkLogTxt &= StringFormat("%5d", $iTrophyCurrent) & "|"
	$AtkLogTxt &= StringFormat("%6d", $SearchCount) & "|"
	$AtkLogTxt &= StringFormat("%7d", $g_iStatsLastAttack[$eLootGold]) & "|"
	$AtkLogTxt &= StringFormat("%7d", $g_iStatsLastAttack[$eLootElixir]) & "|"
	$AtkLogTxt &= StringFormat("%7d", $g_iStatsLastAttack[$eLootDarkElixir]) & "|"
	$AtkLogTxt &= StringFormat("%3d", $g_iStatsLastAttack[$eLootTrophy]) & "|"
	$AtkLogTxt &= StringFormat("%1d", $starsearned) & "|"
	$AtkLogTxt &= StringFormat("%6d", $g_iStatsBonusLast[$eLootGold]) & "|"
	$AtkLogTxt &= StringFormat("%6d", $g_iStatsBonusLast[$eLootElixir]) & "|"
	$AtkLogTxt &= StringFormat("%4d", $g_iStatsBonusLast[$eLootDarkElixir]) & "|"
	$AtkLogTxt &= $LeagueShort & "|"

	Local $AtkLogTxtExtend
	$AtkLogTxtExtend = "|"
	$AtkLogTxtExtend &= $CurCamp & "/" & $TotalCamp & "|"
	If Int($g_iStatsLastAttack[$eLootTrophy]) >= 0 Then
		SetAtkLog($AtkLogTxt, $AtkLogTxtExtend, $COLOR_BLACK)
	Else
		SetAtkLog($AtkLogTxt, $AtkLogTxtExtend, $COLOR_ERROR)
	EndIf

	; rename or delete zombie
	If $g_iDebugDeadBaseImage = 1 Then
		setZombie($g_iStatsLastAttack[$eLootElixir])
	EndIf

	; Share Replay
	If $iShareAttack = 1 Then
		If (Number($g_iStatsLastAttack[$eLootGold]) >= Number($iShareminGold)) And (Number($g_iStatsLastAttack[$eLootElixir]) >= Number($iShareminElixir)) And (Number($g_iStatsLastAttack[$eLootDarkElixir]) >= Number($iSharemindark)) Then
			SetLog("Reached miminum Loot values... Share Replay")
			$iShareAttackNow = 1
		Else
			SetLog("Below miminum Loot values... No Share Replay")
			$iShareAttackNow = 0
		EndIf
	EndIf

	If $g_iFirstAttack = 0 Then $g_iFirstAttack = 1
	$g_iStatsTotalGain[$eLootGold] += $g_iStatsLastAttack[$eLootGold] + $g_iStatsBonusLast[$eLootGold]
	$iTotalGoldGain[$g_iMatchMode] += $g_iStatsLastAttack[$eLootGold] + $g_iStatsBonusLast[$eLootGold]
	$g_iStatsTotalGain[$eLootElixir] += $g_iStatsLastAttack[$eLootElixir] + $g_iStatsBonusLast[$eLootElixir]
	$iTotalElixirGain[$g_iMatchMode] += $g_iStatsLastAttack[$eLootElixir] + $g_iStatsBonusLast[$eLootElixir]
	If $g_iStatsStartedWith[$eLootDarkElixir] <> "" Then
		$g_iStatsTotalGain[$eLootDarkElixir] += $g_iStatsLastAttack[$eLootDarkElixir] + $g_iStatsBonusLast[$eLootDarkElixir]
		$iTotalDarkGain[$g_iMatchMode] += $g_iStatsLastAttack[$eLootDarkElixir] + $g_iStatsBonusLast[$eLootDarkElixir]
	EndIf
	$g_iStatsTotalGain[$eLootTrophy] += $g_iStatsLastAttack[$eLootTrophy]
	$iTotalTrophyGain[$g_iMatchMode] += $g_iStatsLastAttack[$eLootTrophy]
	If $g_iMatchMode = $TS Then
		If $starsearned > 0 Then
			$iNbrOfTHSnipeSuccess += 1
		Else
			$iNbrOfTHSnipeFails += 1
		EndIf
	EndIf
	$iAttackedVillageCount[$g_iMatchMode] += 1
	UpdateStats()
	$actual_train_skip = 0 ;

EndFunc   ;==>AttackReport