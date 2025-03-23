if callType == LuaCallType.Init then
    langIndex = 1
    language = {
        [1] = { -- English
            [1] = 'All tokens found!\nCongratulations, you found all the tokens in this area!',
            [2] = 'Token found!\nYou found a secret token! Look around to find more in this area!',
            [3] = 'All tokens have been found in this area!',
            [4] = 'There are still tokens to be found in this area.'
        },
        [2] = { -- French
            [1] = 'Tous les jetons trouvés !\nFélicitations, vous avez trouvé tous les jetons dans cette zone !',
            [2] = "Jeton trouvé !\nVous avez trouvé un jeton secret ! Regardez autour de vous pour en trouver d'autres dans cette zone !",
            [3] = 'Tous les jetons ont été trouvés dans cette zone !',
            [4] = 'Il reste encore des jetons à trouver dans cette zone.'
        },
        [3] = { -- German
            [1] = 'Alle Token gefunden!\nHerzlichen Glückwunsch, Sie haben alle Token in diesem Bereich gefunden!',
            [2] = 'Token gefunden!\nSie haben einen geheimen Token gefunden! Schauen Sie sich um, um weitere in diesem Bereich zu finden!',
            [3] = 'Alle Token wurden in diesem Bereich gefunden!',
            [4] = 'In diesem Bereich gibt es noch Token zu finden.'
        },
        [4] = { -- Italian
            [1] = "Tutti i token trovati!\nCongratulazioni, hai trovato tutti i token in quest'area!",
            [2] = "Token trovato!\nHai trovato un token segreto! Guardati intorno per trovarne altri in quest'area!",
            [3] = "Tutti i token sono stati trovati in quest'area!",
            [4] = "Ci sono ancora token da trovare in quest'area."
        },
        [5] = { -- Spanish
            [1] = '¡Todos los tokens encontrados!\n¡Felicidades, has encontrado todos los tokens en esta área!',
            [2] = '¡Token encontrado!\n¡Has encontrado un token secreto! ¡Mira a tu alrededor para encontrar más en esta área!',
            [3] = '¡Todos los tokens han sido encontrados en esta área!',
            [4] = 'Aún quedan tokens por encontrar en esta área.'
        },
        [6] = { -- Portuguese
            [1] = 'Todos os tokens encontrados!\nParabéns, você encontrou todos os tokens nesta área!',
            [2] = 'Token encontrado!\nVocê encontrou um token secreto! Olhe ao redor para encontrar mais nesta área!',
            [3] = 'Todos os tokens foram encontrados nesta área!',
            [4] = 'Ainda há tokens para serem encontrados nesta área.'
        },
        [7] = { -- Turkish
            [1] = 'Tüm jetonlar bulundu!\nTebrikler, bu alandaki tüm jetonları buldunuz!',
            [2] = 'Jeton bulundu!\nGizli bir jeton buldunuz! Bu alanda daha fazlasını bulmak için etrafa bakın!',
            [3] = 'Bu alandaki tüm jetonlar bulundu!',
            [4] = 'Bu alanda hala bulunması gereken jetonlar var.'
        },
        [8] = { -- Chinese
            [1] = '所有代币已找到！\n恭喜，您找到了此区域的所有代币！',
            [2] = '代币已找到！\n你发现了一个秘密代币！四处看看，在此区域内找到更多代币！',
            [3] = '此区域的所有代币已找到！',
            [4] = '此区域还有代币尚未找到。'
        },
        [9] = { -- Japanese
            [1] = 'すべてのトークンが見つかりました！\nおめでとうございます、このエリアですべてのトークンを見つけました！',
            [2] = 'トークンが見つかりました！\n秘密のトークンを見つけました！このエリアでもっと探してみてください！',
            [3] = 'このエリアですべてのトークンが見つかりました！',
            [4] = 'このエリアにはまだ見つかるトークンがあります。'
        },
        [10] = { -- Korean
            [1] = '모든 토큰을 찾았습니다!\n축하합니다, 이 지역에서 모든 토큰을 찾았습니다!',
            [2] = '토큰을 찾았습니다!\n비밀 토큰을 찾았습니다! 이 지역에서 더 찾아보세요!',
            [3] = '이 지역에서 모든 토큰을 찾았습니다!',
            [4] = '이 지역에서 아직 찾을 토큰이 남아 있습니다.'
        }
	}
    areas = {}
    for i, tk in pairs(token) do
        element = tk.gameObject.GetComponent('Element')
		element.collectionId = 1350
		element.soundPickup = 'event:/SFX/ADVENTURE/ADVENTURE01/SFX/COINS/coinPickup'
		element.soundPlace = 'event:/SFX/ADVENTURE/ADVENTURE01/SFX/COINS/coinPlace'
		element.soundOrbit = 'event:/SFX/ADVENTURE/ADVENTURE01/SFX/COINS/coinOrbit'
		element.soundHit = 'event:/SFX/ADVENTURE/ADVENTURE01/SFX/COINS/coinHit'
		element.groundEulerAngles = api.vector3(90, 0, 0)
		element.zoomScaleModifier = 0.66
        zone = tonumber(element.elementName)
        tk.transform.name = zone
        element.elementName = ''
        if not areas[zone] then
            areas[zone] = {
                found = 0,
                total = 1
            }
        else
            areas[zone].total = areas[zone].total + 1
        end
    end
    function getIndex(context)
        local element = context.gameObject.GetComponent('Element')
        local index = string.match(element.playerVariableName, "{(%d+)}")
        return tonumber(index)
    end
	function collectToken(context)
        zone = tonumber(context.transform.name)
        areas[zone].found = areas[zone].found + 1
        if areas[zone].found == areas[zone].total then
            api.levelNote(language[langIndex][1]..'\n'..string.char(9688)..' '..areas[zone].found..'/'..areas[zone].total)
        else
            api.levelNote(language[langIndex][2]..'\n'..string.char(9688)..' '..areas[zone].found..'/'..areas[zone].total)
        end
        found = 0
        total = 0
        for _, a in pairs(areas) do
            found = found + a.found
            total = total + a.total
        end
	end
    function tokenStatus(context)
        element = context.gameObject.GetComponent('Element')
        zone = tonumber(element.elementName)
        if areas[zone].found == areas[zone].total then
            api.levelNote(language[langIndex][3]..'\n'..string.char(9688)..' '..areas[zone].found..'/'..areas[zone].total)
        else
            api.levelNote(language[langIndex][4]..'\n'..string.char(9688)..' '..areas[zone].found..'/'..areas[zone].total)
        end
    end
end

if callType == LuaCallType.SwitchDone then
	if api.contains(token, context) and context.isOn then
		collectToken(context)
	end
    if api.contains(tokenArea, context) and context.isOn then
		tokenStatus(context)
	end
    if api.contains(selectLanguage, context) and context.isOn then
		local index = getIndex(context)
		langIndex = index
	end
end

--if callType == LuaCallType.TriggerExit then
--    if api.contains(tokenTrigger, context) then
--		collectToken(context);
--	end
--end