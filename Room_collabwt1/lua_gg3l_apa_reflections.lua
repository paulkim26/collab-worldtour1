--[[
This script has been written by GG3L and modified by apa-games. You are not allowed to use this script for your own rooms unless you ask for permission.
You can also download a generalized version from GG3L's public LUA collection
--]]

if callType == LuaCallType.Init then
	logicProps = {
		['Base/ActivatorComponent'] = true,
		['Base/ColliderComponent'] = true,
		['Base/EditorDisplay'] = true,
		['Base/EditorLight'] = true,
		['Base/EditorPostProcessing'] = true,
		['Base/EditorPuzzleNeo'] = true,
		['Base/EditorWater'] = true,
		['Base/Empty'] = true,
		['Base/Finish'] = true,
		['Base/Fog'] = true,
		['Base/Lock'] = true,
		['Base/Mirror'] = true,
		['Base/Obstacle'] = true,
		['Base/OpenLink'] = true,
		['Base/Roulette'] = true,
		['Base/Script'] = true,
		['Base/Skybox'] = true,
		['Base/Slot'] = true,
		['Base/Sound'] = true,
		['Base/SpawnPoint'] = true,
		['Base/Teleport'] = true,
		['Base/Trigger'] = true
	}

	function isEffect(name)
		local nameLower = string.lower(name)
		if string.sub(nameLower, 1, 8) == 'effects/' then
			return true
		end
		return false
	end

	function setLayer(transform, layer, strictMode)
		if strictMode and (logicProps[transform.name] or isEffect(transform.name)) then
			return
		end
		transform.gameObject.layer = layer
		local childCount = transform.gameObject.transform.childCount
		for index = 0, childCount - 1 do
			local childTransform = transform.gameObject.transform.GetChild(index)
			if childTransform then
				setLayer(childTransform, layer, true)
			end
		end
	end

	setLayer(reflection.transform, 28)
end
