--[[
    Author: GG3L (@GGӡL)
    Script: Scary Mirror
    Description: This script adds the ability to make certain objects only visible in mirrors.

    Permission is granted to use this script in custom rooms for Escape Simulator, provided that:
    - Credit is given to the author.
    - Neither this header nor the code is modified.

    Unauthorized distribution or modification is prohibited.
    All rights reserved by the author.
]]
if callType == LuaCallType.Init then
    logicProps = {
        ['Base/ActivatorComponent'] = true,
        ['Base/ColliderComponent'] = true,
        ['Base/EditorDisplay'] = true,
        ['Base/EditorLight'] = true,
        ['Base/EditorPostProcessing'] = true,
        ['Base/EditorPuzzleNeo'] = true,
        ['Base/EditorWater'] = true,
        ['Base/EditorSetup'] = true,
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

    function isEffect(transform)
        if string.sub(string.lower(transform.parent.name), 1, 8) == 'effects/' then
            return string.sub(string.lower(transform.name), 1, 4) == "cube"
        end
        return false
    end

    function setLayer(transform, layer)
        if not logicProps[transform.name] and not isEffect(transform) then
            transform.gameObject.layer = layer
        end
        
        local childCount = transform.gameObject.transform.childCount
        for index = 0, childCount - 1 do
            local childTransform = transform.gameObject.transform.GetChild(index)
            if childTransform then
                setLayer(childTransform, layer)
            end
        end
    end

    setLayer(reflection.transform, 28)
end
