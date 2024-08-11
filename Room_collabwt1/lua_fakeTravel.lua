if callType == LuaCallType.Init then
	langIndex = 1
    language = {
		[1] = 'Waiting for Host', -- English
		[2] = "En attente de l'hôte", -- French
		[3] = 'Warten auf den Host', -- German
		[4] = "In attesa dell'host", -- Italian
		[5] = 'Esperando al anfitrión', -- Spanish
		[6] = 'Aguardando o anfitrião', -- Portuguese
		[7] = 'Ev sahibini bekliyor', -- Turkish
		[8] = '等待主持人', -- Chinese,
		[9] = 'ホストを待っています', -- Japanese,
		[10] = '호스트를 기다리는 중' -- Korean
	}
	function getIndex(context)
        local element = context.gameObject.GetComponent('Element')
        local index = string.match(element.playerVariableName, "{(%d+)}")
        return tonumber(index)
    end
    for i, ft in pairs(fakeTravel) do
		ft.gameObject.SetActive(false)
		trueTravel[i].gameObject.SetActive(false)
	end
end

if callType == LuaCallType.SwitchDone then
	if context == startButton then
		if api.getLocalPlayer() == api.getMainPlayer() then
			for i, tt in pairs(trueTravel) do
				tt.gameObject.SetActive(true)
			end
		else
			for i, ft in pairs(fakeTravel) do
				ft.gameObject.SetActive(true)
			end
		end
	end
	if api.contains(fakeTravel, context) and context.isOn then
		api.levelNote(string.char(0x24D8)..' '..language[langIndex])
	end
	if api.contains(selectLanguage, context) and context.isOn then
		local index = getIndex(context)
		langIndex = index
	end
end