if callType == LuaCallType.Init then

    charset = " 0123456789ABCD" .. "EFGHIJKLMNOPQRSTU" .. "VWXYZabcdefghijk" .. "lmnopqrstuvwxyz." .. ":,;-_+*#’“”\"'<>!" .. "§$%&/()=?|@€[]{}" .. "¡¿áèéñóęłƐɔΑΒΓΚΠ" .. "ΣΧάέήίαγεζηθικλμ" .. "νοπρστυόύώกขคงฉช" .. "ดตทนมยรลวษสหอัาำ" .. "ิีุูเโไ็่้์"
    lines = 4
    cols = 30
    charPosMap = {}
    delayedChars = {}

    languages =
    {
        english = 1,
        german	= 2,
        greek = 3,
        italian = 4,
        krio = 5,
        polish = 6,
        spanish = 7,
        thai = 8

    }

    countryCount = 9

    phrases = {
        {
            -- English
            "Hello!",
            "Good Evening!",
            "Goodbye!",
            "I'm sorry",
            "Where is the bathroom?",
            "How much does that cost?",
            "Help!",
            "I need a doctor.",
            "Happy birthday!"
        },
        {
            -- German
            "Hallo!",
            "Guten Abend!",
            "Auf Wiedersehen!",
            "Es tut mir leid",
            "Wo sind die Toiletten?",
            "Wieviel kostet das?",
            "Hilfe!",
            "Ich brauche einen Arzt.",
            "Alles Gute zum Geburtstag!"
        },
        {
            -- Greek
            "Γειά σου!",
            "Καλησπέρα!",
            "Αντίο!",
            "Συγγνώμη",
            "Πού είναι το μπάνιο;",
            "Πόσο κοστίζει;",
            "Βοήθεια!",
            "Χρειάζομαι γιατρό.",
            "Χρόνια πολλά!"
        },
        {
            -- Italian
            "Ciao!",
            "Buonasera!",
            "Arrivederci!",
            "Mi dispiace",
            "Dov'è il bagno?",
            "Quanto costa?",
            "Aiuto!",
            "Ho bisogno di un dottore.",
            "Buon compleanno!"
        },
        {
            -- Krio (Sierra Leone)
            "Adu!",
            "Gud ivnin!",
            "Bye Bye!",
            "A sɔri",
            "Usay di batrum de?",
            "Aw mus dan dae kɔst?",
            "Ɛp!",
            "A nid dɔktɔ.",
            "Api batde!"
        },
        {
            -- Polish
            "Witaj!",
            "Dobry wieczór!",
            "Do widzenia!",
            "Przepraszam",
            "Gdzie jest łazienka?",
            "Ile to kosztuje?",
            "Pomocy!",
            "Potrzebuję lekarza.",
            "Wszystkiego najlepszego z okazji urodzin!"
        },
        {
            -- Spanish (Spain / Peru)
            "¡Hola!",
            "¡Buenas noches!",
            "¡Adiós!",
            "Lo siento",
            "¿Dónde está el baño?",
            "¿Cuánto cuesta eso?",
            "¡Ayuda!",
            "Necesito un médico.",
            "¡Feliz cumpleaños!"
        },
        {
            -- Thai
            "สวัสดี!",
            "สวัสดีตอนเย็น!",
            "ลาก่อน!",
            "ขอโทษที",
            "ห้องน้ำอยู่ไหน?",
            "ราคาเท่าไหร่?",
            "ช่วยด้วย!",
            "ฉันต้องการหมอ",
            "สุขสันต์วันเกิด!"
        }
    }

    currentPhrase = 0
    currentLanguage = languages.english

    for c = 1, string.len( charset ), 1 do
        charPosMap[string.sub(charset, c, c )] = c
    end

    buttonToPhrase = {}

    for i, btn in pairs(wollo_phraseButton) do
        buttonToPhrase[btn] = i
    end

    buttonToLanguage = {}

    for i, btn in pairs(wollo_languageButton) do
        buttonToLanguage[btn] = i
    end

    function showPhrase()

        if currentPhrase == 0 then
            return
        end

        -- clear screen
        delayedChars = {}
        for lockPos = 1, lines * cols, 1 do
            api.setLockValue( wollo_phraseScreenLock, 0, lockPos )
        end

        phrase = phrases[currentLanguage][currentPhrase]
        showLine(1, phrase)

        if currentLanguage ~= languages.english then
            phrase = phrases[languages.english][currentPhrase]
            showLine(3, phrase)
        end


    end

    function splitLine(text)
        splitLines = {text}
        if string.len( text ) > cols then
            for c = cols, 0, -1 do
                if string.sub( text, c, c ) == " " then
                    splitLines[2] = string.sub( text, c + 1 )
                    splitLines[1] = string.sub( text, 1, c - 1 )
                    return splitLines
                end
            end
        end
        return splitLines
    end

    function showLine(line, text)
        splitLines = splitLine(text)
        for l, t in ipairs(splitLines) do
            showLineInternal(line + l - 1, t)
        end
    end

    function showLineInternal(line, text)
        lockPos = (line - 1) * cols
        for c = 1, math.min(cols, string.len(text)), 1 do
            lockPos = lockPos + 1
            char = string.sub(text, c, c )
            charPos = charPosMap[char]
            if  charPos then
                table.insert( delayedChars, { charPos - 1, lockPos } )
            else
                --api.log( 'Message contains unknown character: '..char..' at position '..c )
            end
        end
    end

    function playPhraseSound()
        if currentPhrase == 0 then
            return
        end
        api.setLockValue(sfx_wollo_phrase[10*currentLanguage+currentPhrase], 1, 1)
    end

elseif callType == LuaCallType.SwitchStarted
then

    if context == delayTicker then
        if delayedChars[1] then
            api.setLockValue( wollo_phraseScreenLock, delayedChars[1][1], delayedChars[1][2] )
            table.remove(delayedChars, 1)
        end
    elseif buttonToPhrase[context] then

        if not context.isOn then
            return
        end

        btn = buttonToPhrase[context]

        for _, off in ipairs(wollo_phraseSpotOff) do
            api.toggleActivator( off )
        end
        api.toggleActivator( wollo_phraseSpotOn[btn] )
        currentPhrase = btn

        showPhrase()
        playPhraseSound()
    elseif buttonToLanguage[context] then

        if not context.isOn then
            return
        end

        btn = buttonToLanguage[context]
        for _, off in ipairs(wollo_languageSpotOff) do
            api.toggleActivator( off )
        end
        api.toggleActivator( wollo_languageSpotOn[btn] )

        currentLanguage = btn
        showPhrase()
        playPhraseSound()
    end
end