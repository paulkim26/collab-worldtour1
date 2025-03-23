--[[
    Author: GG3L (@GGӡL)
    Script: Pressed Token
    Description: This script adds the ability to dynamically change the face of a custom token.

    Permission is granted to use this script in custom rooms for Escape Simulator, provided that:
    - Credit is given to the author.
    - Neither this header nor the code is modified.

    Unauthorized distribution or modification is prohibited.
    All rights reserved by the author.
]]
if callType == LuaCallType.Init then
    function switchToFaceIndex(token, faceIndex)
		local faces = token.transform.GetChild(0).GetChild(0).GetChild(0)
        for index = 0, faces.childCount - 1 do
            local child = faces.GetChild(index)
            if child.transform.name == 'TokenFace' .. faceIndex then
            	child.transform.localScale = Vector3.one
			else
				child.transform.localScale = Vector3.zero
			end
        end
    end
	function getSettings(context)
		local element = context.gameObject.GetComponent('Element')
        local token, face = string.match(element.elementName, "token:%s*(%d+);%s*face:%s*(%d+)")
        return tonumber(token), tonumber(face)
    end
	for index, token in pairs(pressedToken) do
		switchToFaceIndex(pressedToken[index], 0)
	end
		for _, token_pressed in pairs(pressedToken) do
		local element = token_pressed.gameObject.GetComponent('Element')

--Additions by ChazzyB for Collab World Tour Vol 2
--Add sound properties to tokens, make tokens stackable, reposition & parent tokens to Empty holder for use with Token Press
	element.soundPickup = 'event:/SFX/ADVENTURE/ADVENTURE01/SFX/COINS/coinPickup'
	element.soundPlace = 'event:/SFX/ADVENTURE/ADVENTURE01/SFX/COINS/coinPlace'
	element.soundOrbit = 'event:/SFX/ADVENTURE/ADVENTURE01/SFX/COINS/coinOrbit'
	element.soundHit = 'event:/SFX/ADVENTURE/ADVENTURE01/SFX/COINS/coinHit'
	element.collectionId = 1351
	element.groundEulerAngles = api.vector3(90, 0, 0)
	element.zoomScaleModifier = 0.66
	element.transform.position = api.vector3(pressedTokenHolder.transform.position.x, pressedTokenHolder.transform.position.y, pressedTokenHolder.transform.position.z)
	element.transform.parent = pressedTokenHolder.transform
--End Chazzy edits
end
end
if callType == LuaCallType.SwitchDone then
    if api.contains(showface, context) then
        local token, face = getSettings(context)
        switchToFaceIndex(pressedToken[token], face)
--ChazzyB: Also change face of prop token when being pressed
	switchToFaceIndex(pressedTokenProp, face)
--End Chazzy edits
    end
end
