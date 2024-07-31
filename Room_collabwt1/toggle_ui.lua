--[[
    Author: GG3L (@GGӡL)
    Script: Toggle UI
    Description: This script adds the ability to turn off the UI for a certain amount of time.
    
    All rights reserved by the author. Unauthorized distribution or modification is prohibited.
]]
if callType==LuaCallType.Init then a=transform['\103\97\109\101\79\98\106\101\99\116'].FindGameObjectWithTag('\77\97\105\110\67\97\109\101\114\97')b=a['\116\114\97\110\115\102\111\114\109'].Find('\85\73\67\97\109\101\114\97')end if callType==LuaCallType.SwitchStarted then if context==toggleUI then b['\103\97\109\101\79\98\106\101\99\116'].SetActive(false)end end if callType==LuaCallType.SwitchDone then if context==toggleUI then b['\103\97\109\101\79\98\106\101\99\116'].SetActive(true)end end
