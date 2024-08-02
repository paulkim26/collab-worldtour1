--[[
    Author: GG3L (@GGӡL)
    Script: Tokens
    Description: This script is a custom implementation of the token collecting from the base game.

    Permission is granted to use this script in custom rooms for Escape Simulator, provided that:
    - Credit is given to the author.
    - Neither this header nor the code is modified.

    Unauthorized distribution or modification is prohibited.
    All rights reserved by the author.
]]
if callType==LuaCallType.Init then a=0 for _,b in pairs(token)do c=api["\103\101\116\69\108\101\109\101\110\116"](b)c["\99\111\108\108\101\99\116\105\111\110\73\100"]=1350 end function d(e)e["\103\97\109\101\79\98\106\101\99\116"]["\83\101\116\65\99\116\105\118\101"](false)a=a+1 f=string.char(9688)g=string.char(0x24D8)if a==#token then api["\108\101\118\101\108\78\111\116\101"]('\65\108\108\32\116\111\107\101\110\115\32\102\111\117\110\100\33\10\67\111\110\103\114\97\116\117\108\97\116\105\111\110\115\44\32\121\111\117\32\102\111\117\110\100\32\97\108\108\32\116\104\101\32\116\111\107\101\110\115\33\10'..f..'\32'..a..'\47'..#token)api["\108\101\118\101\108\78\111\116\101"]('')api["\108\101\118\101\108\78\111\116\101"](g..'\32\65\32\115\101\99\114\101\116\32\114\111\111\109\32\104\97\115\32\98\101\101\110\32\117\110\108\111\99\107\101\100\46\32\72\101\97\100\32\98\97\99\107\32\104\111\109\101\32\116\111\32\100\105\115\99\111\118\101\114\32\119\104\97\116\32\97\119\97\105\116\115\32\121\111\117\33\32')else api["\108\101\118\101\108\78\111\116\101"]('\84\111\107\101\110\32\102\111\117\110\100\33\10\89\111\117\32\102\111\117\110\100\32\97\32\115\101\99\114\101\116\32\116\111\107\101\110\33\32\76\111\111\107\32\97\114\111\117\110\100\32\116\111\32\102\105\110\100\32\109\111\114\101\33\10'..f..'\32'..a..'\47'..#token)end end end if callType==LuaCallType.SwitchDone then if api["\99\111\110\116\97\105\110\115"](token,context)and context["\105\115\79\110"]then d(context)end end if callType==LuaCallType.TriggerExit then if api["\99\111\110\116\97\105\110\115"](tokenTrigger,context)then d(context)end end
