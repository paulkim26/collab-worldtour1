if callType == LuaCallType.Init then
    langIndex = 1
    language = {
        [1] = { -- English
            [1] = 'All tokens found!\nCongratulations, you found all the tokens in this area!',
            [2] = 'Token found!\nYou found a secret token! Look around to find more in this area!',
            [3] = 'A Secret room has been unlocked!',
            [4] = 'A Secret room has been unlocked. Head back home to discover what awaits you!',
            [5] = 'All tokens have been found in this area!',
            [6] = 'There are still tokens to be found in this area.'
        },
        [2] = { -- French
            [1] = 'Tous les jetons trouvés !\nFélicitations, vous avez trouvé tous les jetons dans cette zone !',
            [2] = "Jeton trouvé !\nVous avez trouvé un jeton secret ! Regardez autour de vous pour en trouver d'autres dans cette zone !",
            [3] = 'Une pièce secrète a été déverrouillée !',
            [4] = 'Une pièce secrète a été déverrouillée. Retournez chez vous pour découvrir ce qui vous attend !',
            [5] = 'Tous les jetons ont été trouvés dans cette zone !',
            [6] = 'Il reste encore des jetons à trouver dans cette zone.'
        },
        [3] = { -- German
            [1] = 'Alle Token gefunden!\nHerzlichen Glückwunsch, Sie haben alle Token in diesem Bereich gefunden!',
            [2] = 'Token gefunden!\nSie haben einen geheimen Token gefunden! Schauen Sie sich um, um weitere in diesem Bereich zu finden!',
            [3] = 'Ein geheimer Raum wurde freigeschaltet!',
            [4] = 'Ein geheimer Raum wurde freigeschaltet. Gehen Sie nach Hause, um zu entdecken, was Sie erwartet!',
            [5] = 'Alle Token wurden in diesem Bereich gefunden!',
            [6] = 'In diesem Bereich gibt es noch Token zu finden.'
        },
        [4] = { -- Italian
            [1] = "Tutti i token trovati!\nCongratulazioni, hai trovato tutti i token in quest'area!",
            [2] = "Token trovato!\nHai trovato un token segreto! Guardati intorno per trovarne altri in quest'area!",
            [3] = 'Una stanza segreta è stata sbloccata!',
            [4] = 'Una stanza segreta è stata sbloccata. Torna a casa per scoprire cosa ti aspetta!',
            [5] = "Tutti i token sono stati trovati in quest'area!",
            [6] = "Ci sono ancora token da trovare in quest'area."
        },
        [5] = { -- Spanish
            [1] = '¡Todos los tokens encontrados!\n¡Felicidades, has encontrado todos los tokens en esta área!',
            [2] = '¡Token encontrado!\n¡Has encontrado un token secreto! ¡Mira a tu alrededor para encontrar más en esta área!',
            [3] = '¡Se ha desbloqueado una sala secreta!',
            [4] = 'Se ha desbloqueado una sala secreta. ¡Regresa a casa para descubrir lo que te espera!',
            [5] = '¡Todos los tokens han sido encontrados en esta área!',
            [6] = 'Aún quedan tokens por encontrar en esta área.'
        },
        [6] = { -- Portuguese
            [1] = 'Todos os tokens encontrados!\nParabéns, você encontrou todos os tokens nesta área!',
            [2] = 'Token encontrado!\nVocê encontrou um token secreto! Olhe ao redor para encontrar mais nesta área!',
            [3] = 'Uma sala secreta foi desbloqueada!',
            [4] = 'Uma sala secreta foi desbloqueada. Volte para casa para descobrir o que te espera!',
            [5] = 'Todos os tokens foram encontrados nesta área!',
            [6] = 'Ainda há tokens para serem encontrados nesta área.'
        },
        [7] = { -- Turkish
            [1] = 'Tüm jetonlar bulundu!\nTebrikler, bu alandaki tüm jetonları buldunuz!',
            [2] = 'Jeton bulundu!\nGizli bir jeton buldunuz! Bu alanda daha fazlasını bulmak için etrafa bakın!',
            [3] = 'Gizli bir oda açıldı!',
            [4] = 'Gizli bir oda açıldı. Seni bekleyenleri keşfetmek için eve dön!',
            [5] = 'Bu alandaki tüm jetonlar bulundu!',
            [6] = 'Bu alanda hala bulunması gereken jetonlar var.'
        },
        [8] = { -- Chinese
            [1] = '所有代币已找到！\n恭喜，您找到了此区域的所有代币！',
            [2] = '代币已找到！\n你发现了一个秘密代币！四处看看，在此区域内找到更多代币！',
            [3] = '秘密房间已解锁！',
            [4] = '秘密房间已解锁。回家看看有什么在等着你吧！',
            [5] = '此区域的所有代币已找到！',
            [6] = '此区域还有代币尚未找到。'
        },
        [9] = { -- Japanese
            [1] = 'すべてのトークンが見つかりました！\nおめでとうございます、このエリアですべてのトークンを見つけました！',
            [2] = 'トークンが見つかりました！\n秘密のトークンを見つけました！このエリアでもっと探してみてください！',
            [3] = '秘密の部屋が解除されました！',
            [4] = '秘密の部屋が解除されました。家に帰って何が待っているのかを発見してください！',
            [5] = 'このエリアですべてのトークンが見つかりました！',
            [6] = 'このエリアにはまだ見つかるトークンがあります。'
        },
        [10] = { -- Korean
            [1] = '모든 토큰을 찾았습니다!\n축하합니다, 이 지역에서 모든 토큰을 찾았습니다!',
            [2] = '토큰을 찾았습니다!\n비밀 토큰을 찾았습니다! 이 지역에서 더 찾아보세요!',
            [3] = '비밀 방이 열렸습니다!',
            [4] = '비밀 방이 열렸습니다. 당신을 기다리는 것이 무엇인지 알아보려면 집으로 돌아가세요!',
            [5] = '이 지역에서 모든 토큰을 찾았습니다!',
            [6] = '이 지역에서 아직 찾을 토큰이 남아 있습니다.'
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
        if found == total then
            if zone == 1 then
                api.levelNote(string.char(0x24D8)..' '..language[langIndex][3])
            else
                api.levelNote(string.char(0x24D8)..' '..language[langIndex][4])
            end
	        index = getIndex(context)
            end
        end
    function tokenStatus(context)
        element = context.gameObject.GetComponent('Element')
        zone = tonumber(element.elementName)
        if areas[zone].found == areas[zone].total then
            api.levelNote(language[langIndex][5]..'\n'..string.char(9688)..' '..areas[zone].found..'/'..areas[zone].total)
        else
            api.levelNote(language[langIndex][6]..'\n'..string.char(9688)..' '..areas[zone].found..'/'..areas[zone].total)
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