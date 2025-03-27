if callType == LuaCallType.Init then


	charset = " 0123456789ABCD" .. "EFGHIJKLMNOPQRSTU" .. "VWXYZabcdefghijk" .. "lmnopqrstuvwxyz." .. ":,;-_+*#’“”\"'<>!" .. "§$%&/()=?|@€[]{}" .. "ⒶⒷⒸⒹ"
			lines = 20
	cols = 40
	charPosMap = {}
	delayedChars = {}

	function q(question, answers)
		qq ={}
		qq.question = question
		qq.answers = answers
		return qq
	end

	countries =
	{
		canada = 1,
		germany	= 2,
		greece = 3,
		italy = 4,
		peru = 5,
		poland = 6,
		sierraLeone = 7,
		spain = 8,
		thailand = 9
	}

	countryCount = 9

	questions = {
		q("What is your vice?",
			{ "Alcohol",
			  "Chocolate",
			  "Cigarettes",
			  "Sleep" }),
		q( "Why do friends visit you?",
			{ "Because I'm fun",
			  "Because I'm reliable",
			  "Because I'm kind",
			  "Because I serve the best food" }),
		q( "What is your favorite time of the year?",
			{ "Spring",
			  "Summer",
			  "Autumn",
			  "Winter" }),
		q( "Which of the seven Dwarves are you?",
			{ "Sleepy",
			  "Happy",
			  "Grumpy",
			  "Dopey" }),
		q( "What is your favorite pet?",
			{ "Elephant",
			  "Lion",
			  "Llama",
			  "Beaver" }),
		q( "What's your perfect date?",
			{ "Wining and Dining",
			  "Dancing",
			  "A stroll under the stars",
			  "Movie night" }),
		q( "What is your favourite Escape Simulator DLC?",
			{ "Wild West",
			  "Magic",
			  "Steampunk",
			  "Mayan" }),
		q( "What do you like to do on your national holidays?",
			{ "Reflect or pray",
			  "Celebrate",
			  "Parade",
			  "Stay in bed" }),
		q( "When you go out for music, they better play...",
			{ "Hard Rock",
			  "Classical",
			  "Punk",
			  "Soft Pop" }),
		q( "I am as..",
			{ "deep as the sea",
			  "clear as the sky",
			  "dark as the night",
			  "pretty as a flower" })
	}

	answerValues = {
		{
			{ 6, 6, 2, 5 },
			{ 2, 4, 7, 3 },
			{ 4, 5, 7, 10 },
			{ 6, 4, 6, 8 },
			{ 0, 0, 0, 10 },
			{ 8, 3, 8, 7 },
			{ 7, 5, 7, 3 },
			{ 4, 5, 6, 4 },
			{ 6, 0, 1, 5 },
			{ 0, 6, 4, 0 }
		},
		{
			{ 7, 5, 3, 2 },
			{ 0, 10, 2, 4 },
			{ 7, 5, 7, 5 },
			{ 0, 3, 9, 3 },
			{ 0, 0, 6, 8 },
			{ 10, 3, 5, 8 },
			{ 7, 7, 1, 3 },
			{ 9, 1, 0, 6 },
			{ 2, 8, 0, 6 },
			{ 8, 4, 6, 2 }
		},
		{
			{ 7, 3, 7, 6 },
			{ 8, 4, 7, 10 },
			{ 7, 10, 3, 2 },
			{ 5, 9, 4, 3 },
			{ 0, 2, 0, 1 },
			{ 9, 8, 7, 5 },
			{ 3, 7, 2, 5 },
			{ 7, 8, 8, 1 },
			{ 3, 6, 2, 4 },
			{ 10, 8, 3, 7 }
		},
		{
			{ 8, 5, 7, 7 },
			{ 8, 1, 3, 10 },
			{ 7, 9, 4, 2 },
			{ 7, 8, 3, 5 },
			{ 0, 0, 0, 4 },
			{ 10, 6, 7, 5 },
			{ 2, 6, 10, 3 },
			{ 8, 6, 0, 4 },
			{ 5, 8, 0, 7 },
			{ 9, 3, 2, 5 }
		},
		{
			{ 6, 8, 3, 2 },
			{ 5, 6, 6, 4 },
			{ 6, 8, 5, 2 },
			{ 6, 7, 3, 4 },
			{ 0, 4, 10, 0 },
			{ 4, 7, 5, 3 },
			{ 0, 0, 0, 10 },
			{ 5, 7, 8, 1 },
			{ 0, 1, 1, 3 },
			{ 3, 7, 5, 4 }
		},
		{
			{ 8, 5, 4, 3 },
			{ 3, 5, 8, 7 },
			{ 6, 4, 8, 5 },
			{ 3, 3, 5, 7 },
			{ 0, 3, 0, 10 },
			{ 5, 5, 5, 5 },
			{ 8, 6, 2, 4 },
			{ 5, 5, 5, 5 },
			{ 5, 5, 5, 5 },
			{ 5, 5, 5, 5 }
		},
		{
			{ 5, 10, 4, 2 },
			{ 10, 7, 9, 8 },
			{ 7, 10, 6, 0 },
			{ 2, 7, 0, 0 },
			{ 7, 10, 2, 0 },
			{ 8, 10, 6, 3 },
			{ 2, 7, 2, 7 },
			{ 2, 10, 8, 0 },
			{ 2, 3, 4, 6 },
			{ 9, 6, 6, 6 }
		},
		{
			{ 7, 4, 5, 10 },
			{ 8, 2, 6, 7 },
			{ 7, 9, 5, 2 },
			{ 10, 7, 2, 5 },
			{ 3, 4, 2, 1 },
			{ 5, 5, 5, 5 },
			{ 2, 4, 3, 5 },
			{ 5, 5, 5, 5 },
			{ 5, 5, 5, 5 },
			{ 5, 5, 5, 5 }
		},
		{
			{ 6, 4, 7, 3 },
			{ 6, 7, 8, 10 },
			{ 5, 0, 5, 10 },
			{ 4, 6, 5, 8 },
			{ 10, 2, 2, 0 },
			{ 9, 5, 7, 2 },
			{ 6, 9, 2, 5 },
			{ 10, 6, 1, 4 },
			{ 5, 4, 3, 5 },
			{ 2, 5, 9, 6 }
		}
	}

	currentQuestion = 0
	correctCount = 0
	scores = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
	states =
	{
		startScreen = 1,
		welcomeScreen = 2,
		awaitingAnswer = 3,
		questionResult = 4,
		endScreen = 5,
		ignoreInput = 6
	}
	state = states.startScreen

	for c = 1, string.len( charset ), 1 do
		charPosMap[string.sub(charset, c, c )] = c
	end
---------####5####0####5####0####5####0####5####0
	msgStart = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"  Which country",
		"  are you?",
		"  Find out in only ",
		"  10 questions!",
		"",
		"",
		"Insert token to play"
}

	msgWelcome = {
		"Welcome to WHAT IN THE WORLD?",
		"-----------------------------",
		"Did you ever wonder which country you might be?",
		"We will give you 10 questions. Based on your choices, we will tell you which country you are.",
		"Sounds like fun? Let's go!",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"Press any button to start..."
	}

	function showImage( index )
		api.setLockValue( wollo_countryScreenBGLock, index, 1 )
	end

	function showMessage( msg )
		-- assert length
		for i, s in ipairs( msg ) do
			if string.len( s ) > cols then
				splitDone = false
				for c = cols, 0, -1 do
					if not splitDone and string.sub( s, c, c ) == " " then
						nextS = string.sub( s, c + 1 )
						s = string.sub( s, 1, c - 1 )
						msg[i] = s
						table.insert( msg, i + 1, nextS )
						splitDone = true
					end
				end
			end
		end

		-- clear screen
		delayedChars = {}
		for lockPos = 1, lines * cols, 1 do
			api.setLockValue( wollo_countryScreenLock, 0, lockPos )
		end

		lockPos = 0
		for l = 1, lines, 1 do
			for c = 1, cols, 1 do
				--lockPos = (l - 1) * cols + c
				lockPos = lockPos + 1
				if msg[l] and string.len(msg[l]) >= c then
					char = string.sub(msg[l], c, c )
					charPos = charPosMap[char]
					if  charPos then
						table.insert( delayedChars, { charPos - 1, lockPos } )
					else
						api.log( 'WCAY - Message ' .. msg[l] .. ' contains unknown character: '..char..' at '.. l ..'/' .. c )
					end
				end
			end
		end
	end

	afterMsgImg = nil

	function waitForMessage( img )
		afterMsgImg = img
	end

	function nextQuestion()
		currentQuestion = currentQuestion + 1

		if not questions[currentQuestion] then
			--currentQuestion = 1
			highestCountry = 0
			highestScore = 0
			for country = 1, countryCount, 1 do
				if scores[country] > highestScore then
					highestCountry = country
					highestScore = scores[country]
				end
			end

			--api.toggleActivator( wollo_globe_bonusOn[highestCountry] )
			state = states.endScreen
			waitForMessage( highestCountry )
			showMessage(
					{
						"Based on your selected answers and a substantial amount of complicated calculations and scientific research, we have determined that...",
						"                                       ",
						"                                       ",
						"",
						"                YOU ARE",
						"                                       ",
						"                                       ",
						"                                       ",
						"                                       ",
						"a",
						"",
						"",
						"",
						"",
						"",
						"",
						"Insert token to play again"
					}
			)
			scores = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
			wollo_quizTokenSlot.gameObject.setActive(true)
			api.setLockValue(wollo_midiAnthem[highestCountry], 1, 1)
			return
		end

		question = questions[currentQuestion]
		showMessage({
			question.question,
			"",
			"Ⓐ "..question.answers[1],
			"",
			"Ⓑ "..question.answers[2],
			"",
			"Ⓒ "..question.answers[3],
			"",
			"Ⓓ "..question.answers[4],
			"",
			"",
			"",
			"Please select an answer."
		})
		state = states.awaitingAnswer
	end

	buttonAnswerMapping = {}
	buttonAnswerMapping[wollo_quizButtonA] = 1
	buttonAnswerMapping[wollo_quizButtonB] = 2
	buttonAnswerMapping[wollo_quizButtonC] = 3
	buttonAnswerMapping[wollo_quizButtonD] = 4

	showMessage(msgStart)
	showImage( 0 )

elseif callType == LuaCallType.SwitchStarted
then
	if context == wollo_quizCoinPlaced then
		insertedToken = wollo_quizTokenSlot.insertedKey.gameObject.GetComponent('Switch')
		wollo_quizTokenSlot.gameObject.setActive(false)

	elseif context == wollo_quizCoinInserted then

		insertedToken = wollo_quizTokenSlot.insertedKey.gameObject.GetComponent('Switch')
		insertedToken.gameObject.setActive(false)
		wollo_quizTokenSlot.insertedKey = nil

		currentQuestion = 0

		showMessage(msgWelcome)
		showImage( 11 )
		state = states.welcomeScreen
		api.setLockValue(wollo_midiStart, 1, 1)
	elseif context == delayTicker then
		if delayedChars[1] then
			api.setLockValue( wollo_countryScreenLock, delayedChars[1][1], delayedChars[1][2] )
			table.remove(delayedChars, 1)
		end
		if delayedChars[1] then
			api.setLockValue( wollo_countryScreenLock, delayedChars[1][1], delayedChars[1][2] )
			table.remove(delayedChars, 1)
		end
		if not delayedChars[1] and afterMsgImg then
			showImage(afterMsgImg)
			afterMsgImg = nil
		end
	elseif buttonAnswerMapping[context] then

		if not context.isOn then
			return
		end

		if afterMsgImg then
			return
		end

		if state == states.startScreen then

		elseif state == states.endScreen then
			showMessage(msgStart)
			showImage( 0 )
			state = states.startScreen

		elseif state == states.welcomeScreen or state == states.questionResult then
			if currentQuestion < 10 then
				nextQuestion()
			else

			end

		elseif state == states.awaitingAnswer then
			-- todo evaluate answer
			answer = buttonAnswerMapping[context]
			for country = 1, countryCount, 1 do
				scores[country] = scores[country] + answerValues[country][currentQuestion][answer];
			end
			--scores

			nextQuestion()
		end

	end
end