if callType == LuaCallType.Init then
	langIndex = 1
    language = {
		[1] = { -- English
			['fakeTravel[1]'] = 'Travel',
			['fakeTravel[2]'] = 'Return Home',
			['fakeTravel[3]'] = 'Return Home',
			['fakeTravel[4]'] = 'Return Home',
			['fakeTravel[5]'] = 'Return Home',
			['trueTravel[1]'] = 'Travel',
			['trueTravel[2]'] = 'Return Home',
			['trueTravel[3]'] = 'Return Home',
			['trueTravel[4]'] = 'Return Home',
			['trueTravel[5]'] = 'Return Home'
		},
		[2] = { -- French
			['fakeTravel[1]'] = 'Voyager',
			['fakeTravel[2]'] = 'Retour à la maison',
			['fakeTravel[3]'] = 'Retour à la maison',
			['fakeTravel[4]'] = 'Retour à la maison',
			['fakeTravel[5]'] = 'Retour à la maison',
			['trueTravel[1]'] = 'Voyager',
			['trueTravel[2]'] = 'Retour à la maison',
			['trueTravel[3]'] = 'Retour à la maison',
			['trueTravel[4]'] = 'Retour à la maison',
			['trueTravel[5]'] = 'Retour à la maison'
		},
		[3] = { -- German
			['fakeTravel[1]'] = 'Reisen',
			['fakeTravel[2]'] = 'Nach Hause zurückkehren',
			['fakeTravel[3]'] = 'Nach Hause zurückkehren',
			['fakeTravel[4]'] = 'Nach Hause zurückkehren',
			['fakeTravel[5]'] = 'Nach Hause zurückkehren',
			['trueTravel[1]'] = 'Reisen',
			['trueTravel[2]'] = 'Nach Hause zurückkehren',
			['trueTravel[3]'] = 'Nach Hause zurückkehren',
			['trueTravel[4]'] = 'Nach Hause zurückkehren',
			['trueTravel[5]'] = 'Nach Hause zurückkehren'
		},
		[4] = { -- Italian
			['fakeTravel[1]'] = 'Viaggiare',
			['fakeTravel[2]'] = 'Tornare a casa',
			['fakeTravel[3]'] = 'Tornare a casa',
			['fakeTravel[4]'] = 'Tornare a casa',
			['fakeTravel[5]'] = 'Tornare a casa',
			['trueTravel[1]'] = 'Viaggiare',
			['trueTravel[2]'] = 'Tornare a casa',
			['trueTravel[3]'] = 'Tornare a casa',
			['trueTravel[4]'] = 'Tornare a casa',
			['trueTravel[5]'] = 'Tornare a casa'
		},
		[5] = { -- Spanish
			['fakeTravel[1]'] = 'Viajar',
			['fakeTravel[2]'] = 'Volver a casa',
			['fakeTravel[3]'] = 'Volver a casa',
			['fakeTravel[4]'] = 'Volver a casa',
			['fakeTravel[5]'] = 'Volver a casa',
			['trueTravel[1]'] = 'Viajar',
			['trueTravel[2]'] = 'Volver a casa',
			['trueTravel[3]'] = 'Volver a casa',
			['trueTravel[4]'] = 'Volver a casa',
			['trueTravel[5]'] = 'Volver a casa'
		},
		[6] = { -- Portuguese
			['fakeTravel[1]'] = 'Viajar',
			['fakeTravel[2]'] = 'Voltar para casa',
			['fakeTravel[3]'] = 'Voltar para casa',
			['fakeTravel[4]'] = 'Voltar para casa',
			['fakeTravel[5]'] = 'Voltar para casa',
			['trueTravel[1]'] = 'Viajar',
			['trueTravel[2]'] = 'Voltar para casa',
			['trueTravel[3]'] = 'Voltar para casa',
			['trueTravel[4]'] = 'Voltar para casa',
			['trueTravel[5]'] = 'Voltar para casa'
		},
		[7] = { -- Turkish
			['fakeTravel[1]'] = 'Seyahat etmek',
			['fakeTravel[2]'] = 'Eve dönmek',
			['fakeTravel[3]'] = 'Eve dönmek',
			['fakeTravel[4]'] = 'Eve dönmek',
			['fakeTravel[5]'] = 'Eve dönmek',
			['trueTravel[1]'] = 'Seyahat etmek',
			['trueTravel[2]'] = 'Eve dönmek',
			['trueTravel[3]'] = 'Eve dönmek',
			['trueTravel[4]'] = 'Eve dönmek',
			['trueTravel[5]'] = 'Eve dönmek'
		},
		[8] = { -- Chinese
			['fakeTravel[1]'] = '旅行',
			['fakeTravel[2]'] = '回家',
			['fakeTravel[3]'] = '回家',
			['fakeTravel[4]'] = '回家',
			['fakeTravel[5]'] = '回家',
			['trueTravel[1]'] = '旅行',
			['trueTravel[2]'] = '回家',
			['trueTravel[3]'] = '回家',
			['trueTravel[4]'] = '回家',
			['trueTravel[5]'] = '回家'
		},
		[9] = { -- Japanese
			['fakeTravel[1]'] = '旅行する',
			['fakeTravel[2]'] = '帰宅する',
			['fakeTravel[3]'] = '帰宅する',
			['fakeTravel[4]'] = '帰宅する',
			['fakeTravel[5]'] = '帰宅する',
			['trueTravel[1]'] = '旅行する',
			['trueTravel[2]'] = '帰宅する',
			['trueTravel[3]'] = '帰宅する',
			['trueTravel[4]'] = '帰宅する',
			['trueTravel[5]'] = '帰宅する'
		},
		[10] = { -- Korean
			['fakeTravel[1]'] = '여행하다',
			['fakeTravel[2]'] = '집으로 돌아가다',
			['fakeTravel[3]'] = '집으로 돌아가다',
			['fakeTravel[4]'] = '집으로 돌아가다',
			['fakeTravel[5]'] = '집으로 돌아가다',
			['trueTravel[1]'] = '여행하다',
			['trueTravel[2]'] = '집으로 돌아가다',
			['trueTravel[3]'] = '집으로 돌아가다',
			['trueTravel[4]'] = '집으로 돌아가다',
			['trueTravel[5]'] = '집으로 돌아가다'
		}
	}
	function getIndex(context)
        local element = context.gameObject.GetComponent('Element')
        local index = string.match(element.playerVariableName, "{(%d+)}")
        return tonumber(index)
    end
end

if callType == LuaCallType.SwitchDone then
	if api.contains(selectLanguage, context) and context.isOn then
		local index = getIndex(context)
		langIndex = index
	end
	if context == startButton then
		for j, l in pairs(language[langIndex]) do
			local table = j:match("^(%w+)%[")
			local index = tonumber(j:match("%[(%d+)%]"))
			local obj = nil
			if table then
				obj = _G[table][index]
			else
				obj = _G[j]
			end
			if obj then
				if j == 'trueTravel[1]' then
					obj = obj.transform.GetChild(0)
				end
				local element = obj.gameObject.GetComponent('Element')
				element.elementName = l
			end
		end
	end
end