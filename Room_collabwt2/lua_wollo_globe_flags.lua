if callType == LuaCallType.Init then
	GLOBE_ROTATION = .1 * Vector3.up

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

	flagToCountry = {}
	bonusFlagToCountry = {}

	for i, flag in pairs(wollo_globeFlag) do
		flagToCountry[flag] = i
	end

	for i, flag in pairs(wollo_globeBonusFlag) do
		bonusFlagToCountry[flag] = i
	end

	globeRotating = true

	function showSlide(slide)

		wollo_startingSlide.transform.position = wollo_hiddenSlideOrigin.transform.position

		for _, slide in ipairs(wollo_countrySlide) do
			slide.transform.position = wollo_hiddenSlideOrigin.transform.position
		end

		for _, slide in ipairs(wollo_countryBonusSlide) do
			slide.transform.position = wollo_hiddenSlideOrigin.transform.position
		end

		slide.transform.position = wollo_visibleSlideOrigin.transform.position

	end

	showSlide(wollo_startingSlide)

elseif callType == LuaCallType.SwitchStarted
then

	if context == delayTicker and globeRotating then
		wollo_globe.transform.Rotate(GLOBE_ROTATION);
		return
	end

	if not context.isOn then
		return
	end

	if flagToCountry[context] then

		country = flagToCountry[context]
		for _, off in ipairs(wollo_globe_lightOff) do
			api.toggleActivator( off )
		end

		showSlide(wollo_countrySlide[country])

		api.toggleActivator( wollo_globe_lightOn[country] )

	elseif bonusFlagToCountry[context] then

		country = bonusFlagToCountry[context]
		api.toggleActivator( wollo_globe_lightOn[country] )
		showSlide(wollo_countryBonusSlide[country])

	elseif context == wollo_globeRotationSwitch then

		globeRotating = not globeRotating

	end
end