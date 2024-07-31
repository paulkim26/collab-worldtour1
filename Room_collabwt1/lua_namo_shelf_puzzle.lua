if callType == LuaCallType.Init then
    -- api.levelNote("Hello World")
	lv_table_1 = 1
	lv_table_2 = 1
	lv_table_3 = 1
	lv_table_4 = 1
	lv_table_5 = 1
	lv_table_6 = 1
	lv_table_7 = 1
	dial_num = 0
	button_lock = false

	
elseif callType == LuaCallType.SwitchDone then

	if context == namo_shelf_up and namo_shelf_up.isOn and not button_lock then
		if dial_num == 0 then
			if not is_all_max(3,2,4) then
				api.activateSwitch(namo_active_table_sound)
				table_up(3)
				table_up(2)
				table_up(4)
			end
			
		elseif dial_num == 1 then
			if not is_all_max(1,5,4) then
				api.activateSwitch(namo_active_table_sound)
				table_up(1)
				table_up(5)
				table_up(4)
			end
			
		elseif dial_num == 2 then
			if not is_all_max(2,7,4) then
				api.activateSwitch(namo_active_table_sound)
				table_up(2)
				table_up(7)
				table_up(4)
			end
			
		elseif dial_num == 3 then
			if not is_all_max(5,6,4) then
				api.activateSwitch(namo_active_table_sound)
				table_up(5)
				table_up(6)
				table_up(4)
			end
			
		elseif dial_num == 4 then
			if not is_all_max(7,3,4) then
				api.activateSwitch(namo_active_table_sound)
				table_up(7)
				table_up(3)
				table_up(4)
			end
			
		elseif dial_num == 5 then
			if not is_all_max(6,1,4) then
				api.activateSwitch(namo_active_table_sound)
				table_up(6)
				table_up(1)
				table_up(4)
			end
								
		end	
		check_answer()

	
	elseif context == namo_shelf_down and namo_shelf_down.isOn and not button_lock then
		if dial_num == 0 then
			if not is_all_min(3,2,4) then
				api.activateSwitch(namo_active_table_sound)
				table_down(3)
				table_down(2)
				table_down(4)
			end
			
		elseif dial_num == 1 then
			if not is_all_min(1,5,4) then
				api.activateSwitch(namo_active_table_sound)
				table_down(1)
				table_down(5)
				table_down(4)
			end
			
		elseif dial_num == 2 then
			if not is_all_min(2,7,4) then
				api.activateSwitch(namo_active_table_sound)
				table_down(2)
				table_down(7)
				table_down(4)
			end			
			
		elseif dial_num == 3 then
			if not is_all_min(5,6,4) then
				api.activateSwitch(namo_active_table_sound)
				table_down(5)
				table_down(6)
				table_down(4)
			end
			
		elseif dial_num == 4 then
			if not is_all_min(7,3,4) then
				api.activateSwitch(namo_active_table_sound)
				table_down(7)
				table_down(3)
				table_down(4)
			end
			
		elseif dial_num == 5 then
			if not is_all_min(6,1,4) then
				api.activateSwitch(namo_active_table_sound)
				table_down(6)
				table_down(1)
				table_down(4)
			end					
		end	
		check_answer()
	end

elseif callType == LuaCallType.Unlock then
    if context == namo_dial_num and context.unlocked then
		dial_num = context.values[1]
        -- api.log(context.values[1])
	-- elseif context == namo_test_lock and context.unlocked then
		
	-- 	api.log(context.values[1])	
	-- 	api.log(context.values[2])
	-- 	api.log(context.values[3])
	-- 	api.log(context.values[4])
    end

end

function table_up(t)
	
	if _G["lv_table_" .. t] == 1 then
		api.activateSwitch(_G["namo_moving_table_" .. t .. "_1"])
		_G["lv_table_" .. t] = _G["lv_table_" .. t] + 1
	elseif _G["lv_table_" .. t] == 2 then
		api.activateSwitch(_G["namo_moving_table_" .. t .. "_2"])	
		_G["lv_table_" .. t] = _G["lv_table_" .. t] + 1
	end	
	
end

function is_all_max(t1,t2,t3)
	if _G["lv_table_" .. t1] == 3 and _G["lv_table_" .. t2] == 3 and _G["lv_table_" .. t3] == 3 then
		return true
	else 
		return false	
	end
end

function table_down(t)
	
	if _G["lv_table_" .. t] == 3 then
		api.activateSwitch(_G["namo_moving_table_" .. t .. "_2"])
		_G["lv_table_" .. t] = _G["lv_table_" .. t] - 1
	elseif _G["lv_table_" .. t] == 2 then
		api.activateSwitch(_G["namo_moving_table_" .. t .. "_1"])	
		_G["lv_table_" .. t] = _G["lv_table_" .. t] - 1
	end	
	
end

function is_all_min(t1,t2,t3)
	if _G["lv_table_" .. t1] == 1 and _G["lv_table_" .. t2] == 1 and _G["lv_table_" .. t3] == 1 then
		return true
	else 
		return false	
	end
end

function check_answer()
	if lv_table_1 == 1 and 
	lv_table_2 == 1 and
	lv_table_3 == 2 and
	lv_table_4 == 2 and
	lv_table_5 == 2 and
	lv_table_6 == 3 and
	lv_table_7 == 3 then
		button_lock = true
		api.setLockValue(namo_finish_shelf_puzzle,1,1)
	end
end
	