if callType == LuaCallType.Init then

   --Sound Library :)
   	Robin_paperSound = 'event:/SFX/VICTORIAN/VICTORIAN1/PAPER/paperPickup'
	Robin_bookSound =  'event:/SFX/VICTORIAN/VICTORIAN1/Book/bookPickUp'
	Robin_tockSound =  'event:/SFX/ISLAND/coconut_drop'
	
	--Laptop Zoom Light and Zoom Sounds
	Robin_LaptopLid.lightStrengthMultiplier= 0.5
	
	Robin_LaptopLid.soundPickup = Robin_tockSound
    Robin_LaptopLid.soundPlace = Robin_tockSound
   
	--Scrapbook Zoom Light and Zoom Sounds
    Robin_scrapbookElement = api.getElement(scrapbookMain)
	
    Robin_scrapbookElement.lightStrengthMultiplier= 0.5
	
	Robin_scrapbookElement.soundPickup = Robin_bookSound
    Robin_scrapbookElement.soundPlace = Robin_bookSound

	--Scrapbook Cover Sounds
    Robin_ScrapbookCover.soundTurnOn = Robin_bookSound
    Robin_ScrapbookCover.soundTurnOff = Robin_bookSound
	
	--Scrapbook Page Sounds
    Robin_Page1.soundTurnOn = Robin_paperSound
    Robin_Page1.soundTurnOff = Robin_paperSound
	
	Robin_Page2.soundTurnOn = Robin_paperSound
    Robin_Page2.soundTurnOff = Robin_paperSound
	
	Robin_Page3.soundTurnOn = Robin_paperSound
    Robin_Page3.soundTurnOff = Robin_paperSound
	
	Robin_Page4.soundTurnOn = Robin_paperSound
    Robin_Page4.soundTurnOff = Robin_paperSound
	
	Robin_Page5.soundTurnOn = Robin_paperSound
    Robin_Page5.soundTurnOff = Robin_paperSound
	
	Robin_Page6.soundTurnOn = Robin_paperSound
    Robin_Page6.soundTurnOff = Robin_paperSound
	
	Robin_Page7.soundTurnOn = Robin_paperSound
    Robin_Page7.soundTurnOff = Robin_paperSound
	
	Robin_Page8.soundTurnOn = Robin_paperSound
    Robin_Page8.soundTurnOff = Robin_paperSound

	end