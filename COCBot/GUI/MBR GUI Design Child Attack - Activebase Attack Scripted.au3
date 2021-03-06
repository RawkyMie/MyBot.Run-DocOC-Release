; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file creates the "Scripted Attack" tab under the "Attack" tab under the "ActiveBase" tab under the "Search & Attack" tab under the "Attack Plan" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......: CodeSlinger69 (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_hGUI_ACTIVEBASE_ATTACK_SCRIPTED = 0
Global $g_hCmbScriptNameAB = 0, $g_hCmbScriptRedlineImplAB = 0, $g_hCmbScriptDroplineAB = 0
Global $g_hLblNotesScriptAB = 0

Func CreateAttackSearchActiveBaseScripted()
   $g_hGUI_ACTIVEBASE_ATTACK_SCRIPTED = GUICreate("", $_GUI_MAIN_WIDTH - 195, $_GUI_MAIN_HEIGHT - 344, 150, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_ACTIVEBASE)
   ;GUISetBkColor($COLOR_WHITE, $g_hGUI_ACTIVEBASE_ATTACK_SCRIPTED)

   Local $x = 25, $y = 20
	   GUICtrlCreateGroup(GetTranslated(607,1, -1), $x - 20, $y - 20, 270, 306)
   ;	$x -= 15
   ;	    $chkmakeIMGCSVAB = GUICtrlCreateCheckbox(GetTranslated(607,2, -1), $x + 150, $y, -1, -1)
   ;			GUICtrlSetState(-1, $GUI_UNCHECKED)
   ;			GUICtrlSetState(-1, $GUI_HIDE)
   ;			_GUICtrlSetTip(-1, GetTranslated(607,3, -1))

		   $y +=15
		   $g_hCmbScriptNameAB = GUICtrlCreateCombo("", $x , $y, 200, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL, $WS_VSCROLL))
			   _GUICtrlSetTip(-1, GetTranslated(607,4, -1))
			   GUICtrlSetState(-1, $GUI_UNCHECKED)
			   GUICtrlSetOnEvent(-1, "cmbScriptNameAB")
		   GUICtrlCreateIcon($g_sLibIconPath, $eIcnReload, $x + 210, $y + 2, 16, 16)
			   _GUICtrlSetTip(-1, GetTranslated(607,5, -1))
			   GUICtrlSetOnEvent(-1, 'UpdateComboScriptNameAB') ; Run this function when the secondary GUI [X] is clicked

		   $y +=25
		   $g_hLblNotesScriptAB =  GUICtrlCreateLabel("", $x, $y + 5, 200, 180)
		   $g_hCmbScriptRedlineImplAB = GUICtrlCreateCombo("", $x, $y + 195, 230, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			   GUICtrlSetData(-1, GetTranslated(607,9, "ImgLoc Raw Redline (default)|ImgLoc Redline Drop Points|Original Redline|External Edges"))
			   _GUICtrlComboBox_SetCurSel(-1, $g_aiAttackScrRedlineRoutine[$LB])
			   _GUICtrlSetTip(-1, GetTranslated(607,10, "Choose the Redline implementation. ImgLoc Redline is default and best."))
			   GUICtrlSetState(-1, $GUI_UNCHECKED)
			   GUICtrlSetOnEvent(-1, "cmbScriptRedlineImplAB")
		   $g_hCmbScriptDroplineAB = GUICtrlCreateCombo("", $x, $y + 220, 230, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			   GUICtrlSetData(-1, GetTranslated(607,11, "Drop line fix outer corner|Drop line fist Redline point|Full Drop line fix outer corner|Full Drop line fist Redline point|No Drop line"))
			   _GUICtrlComboBox_SetCurSel(-1, $g_aiAttackScrDroplineEdge[$LB])
			   _GUICtrlSetTip(-1, GetTranslated(607,12, "Choose the drop line edges. Default is outer corner and safer. First Redline point can improve attack."))
			   GUICtrlSetState(-1, $GUI_UNCHECKED)
			   GUICtrlSetOnEvent(-1, "cmbScriptDroplineAB")
		   GUICtrlCreateIcon($g_sLibIconPath, $eIcnEdit, $x + 210, $y + 2, 16, 16)
			   _GUICtrlSetTip(-1, GetTranslated(607,6, -1))
			   GUICtrlSetOnEvent(-1, "EditScriptAB")

		   $y +=25
		   GUICtrlCreateIcon($g_sLibIconPath, $eIcnAddcvs, $x + 210, $y + 2, 16, 16)
			   _GUICtrlSetTip(-1, GetTranslated(607,7, -1))
			   GUICtrlSetOnEvent(-1, "NewScriptAB")

		   $y +=25
		   GUICtrlCreateIcon($g_sLibIconPath, $eIcnCopy, $x + 210, $y + 2, 16, 16)
			   _GUICtrlSetTip(-1, GetTranslated(607,8, -1))
			   GUICtrlSetOnEvent(-1, "DuplicateScriptAB")
	   GUICtrlCreateGroup("", -99, -99, 1, 1)

   ;GUISetState()

   ;------------------------------------------------------------------------------------------
   ;----- populate list of script and assign the default value if no exist profile -----------
   UpdateComboScriptNameAB()
   Local $tempindex = _GUICtrlComboBox_FindStringExact($g_hCmbScriptNameAB, $g_sAttackScrScriptName[$LB])
   If $tempindex = -1 Then 	$tempindex = 0
   _GUICtrlComboBox_SetCurSel($g_hCmbScriptNameAB, $tempindex)
   ;------------------------------------------------------------------------------------------
EndFunc
