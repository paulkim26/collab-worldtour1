--[[
    Author: GG3L (@GGӡL)
    Script: Toggle UI
    Description: This script adds the ability to turn off the UI for a certain amount of time.
    
    All rights reserved by the author. Unauthorized distribution or modification is prohibited.
]]
if callType == LuaCallType.Init then
    mainCamera = transform.gameObject.FindGameObjectWithTag('MainCamera')
    uiCamera = mainCamera.transform.Find('UICamera')
end

if callType == LuaCallType.SwitchStarted then
    if api.contains(toggleUI, context) then
        uiCamera.gameObject.SetActive(false)
    end
end

if callType == LuaCallType.SwitchDone then
    if api.contains(toggleUI, context) then
        uiCamera.gameObject.SetActive(true)
    end
end
