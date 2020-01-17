#SingleInstance force


Gui, Add, ListView, vMainLV h400 w300 HScroll, |Value
Gui, Show,, ListView with shades

;<-----------------------------setup------------------------------->
SCALE_IMAGE_LIST := GetScaleImageList()
LV_SetImageList(SCALE_IMAGE_LIST)
;<-----------------------------setup------------------------------->

LV_Add("Icon" . GetScaleIndex(0.0), "", 0.0)
LV_Add("Icon" . GetScaleIndex(0.3), "", 0.3)
LV_Add("Icon" . GetScaleIndex(0.5), "", 0.5)
LV_Add("Icon" . GetScaleIndex(0.7), "", 0.7)
LV_Add("Icon" . GetScaleIndex(1.0), "", 1.0)
Return

GuiClose:
GuiEscape:
ExitApp



;<------------------------------Lib-------------------------------->
GetScaleIndex(v) {
  if (v < 0.5)
    return v < 0.1 ? 1 : (v < 0.3 ? 2 : 3)
  else
    return v < 0.7 ? 4 : (v < 0.9 ? 5 : 6)
}

GetScaleImageList(aFilepath:="") {
  if (not aFilepath)
    aFilepath := A_ScriptDir . "\scale.icl"
  _il := IL_Create(6)
  Loop 6
    IL_Add(_il, aFilepath, A_Index)
  return _il
}