if callType == LuaCallType.Init then
	initCharacterModels = false
	characterModels = {}
    language = {
		[1] = { -- English
			soundButton = 'Sound',
			narrationButton = 'Test narration',
			musicButton = 'Test music',
			languageButton = 'Language',
			startButton = 'Start'
		},
		[2] = { -- French
			soundButton = 'Son',
			narrationButton = 'Test de narration',
			musicButton = 'Test de musique',
			languageButton = 'Langue',
			startButton = 'Démarrer'
		},
		[3] = { -- German
			soundButton = 'Ton',
			narrationButton = 'Erzählungstest',
			musicButton = 'Musiktest',
			languageButton = 'Sprache',
			startButton = 'Starten'
		},
		[4] = { -- Italian
			soundButton = 'Suono',
			narrationButton = 'Test di narrazione',
			musicButton = 'Test di musica',
			languageButton = 'Lingua',
			startButton = 'Avvia'
		},
		[5] = { -- Spanish
			soundButton = 'Sonido',
			narrationButton = 'Prueba de narración',
			musicButton = 'Prueba de música',
			languageButton = 'Idioma',
			startButton = 'Comenzar'
		},
		[6] = { -- Portuguese
			soundButton = 'Som',
			narrationButton = 'Teste de narração',
			musicButton = 'Teste de música',
			languageButton = 'Língua',
			startButton = 'Iniciar'
		},
		[7] = { -- Turkish
			soundButton = 'Ses',
			narrationButton = 'Anlatım testi',
			musicButton = 'Müzik testi',
			languageButton = 'Dil',
			startButton = 'Başlat'
		},
		[8] = { -- Chinese
			soundButton = '声音',
			narrationButton = '叙述测试',
			musicButton = '音乐测试',
			languageButton = '语言',
			startButton = '开始'
		},
		[9] = { -- Japanese
			soundButton = '音',
			narrationButton = 'ナレーションテスト',
			musicButton = '音楽テスト',
			languageButton = '言語',
			startButton = '開始'
		},
		[10] = { -- Korean
			soundButton = '소리',
			narrationButton = '내레이션 테스트',
			musicButton = '음악 테스트',
			languageButton = '언어',
			startButton = '시작'
		}
	}
	function toggleCharacterModels(state)
		for _, cm in ipairs(characterModels) do
			cm.SetActive(state)
		end
	end
	function getIndex(context)
        local element = context.gameObject.GetComponent('Element')
        local index = string.match(element.playerVariableName, "{(%d+)}")
        return tonumber(index)
    end
end
if callType == LuaCallType.Update then
	if not initCharacterModels then
		local cm = transform.gameObject.Find('done')
		if cm then
			table.insert(characterModels, cm.gameObject)
			characterModels[#characterModels].SetActive(false)
			cm.transform.name = 'done2'
		end
	end
end
if callType == LuaCallType.SwitchDone then
	if context == toggleUI[1] then
		toggleCharacterModels(false)
	end
end
if callType == LuaCallType.SwitchDone then
	if api.contains(selectLanguage, context) and context.isOn then
		local index = getIndex(context)
		local nbElem = narrationButton.gameObject.GetComponent('Element')
		nbElem.elementName = language[index].narrationButton
		local mbElem = musicButton.gameObject.GetComponent('Element')
		mbElem.elementName = language[index].musicButton
		local pbElem = startButton.gameObject.GetComponent('Element')
		pbElem.elementName = language[index].startButton
		initCharacterModels = true
	end
	if context == toggleCM then
		toggleCharacterModels(true)
	end
	if context == toggleUI[1] then
		toggleCharacterModels(true)
	end
end
