--[[
    Author: GG3L (@GGӡL)
    Script: Clock
    Description: This script adds the ability to create functional hand clocks.
    
    All rights reserved by the author. Unauthorized distribution or modification is prohibited.
]]
if callType==LuaCallType.Init then a={}function b(c)d=c.gameObject.GetComponent('Element')e=string.match(d.playerVariableName,"{(%d+)}")return tonumber(e)end function f(g,h)if g then g.transform.rotation=h end end for _,i in ipairs(clock)do d=i.gameObject.GetComponent('Element')j=0 if d.elementName~=''then k,l=string.match(d.elementName,"(%d+):(%d+)")j=(k*3600)+(l*60)end table.insert(a,{m=false,n=j,o=0})end end if callType==LuaCallType.SwitchDone then if api.contains(clockToggle,context)and context.isOn then p=b(context)a[p].o=0 a[p].m=not a[p].m end end if callType==LuaCallType.Update then for q,r in ipairs(a)do if r.m and Time.time-r.o>=1 then s=math.floor(r.n/3600)t=math.floor((r.n % 3600)/60)u=r.n % 60 v=u*(360/60)w=(t*6)+(u*0.1)x=((s % 12)*30)+(t*0.5)+(u*(0.5/60))f(clockHourHand[q],Quaternion.Euler(0,0,-x))f(clockMinuteHand[q],Quaternion.Euler(0,0,-w))f(clockSecondHand[q],Quaternion.Euler(0,0,-v))if clockSound[q]then api.activateSwitch(clockSound[q])end r.n=r.n+1 r.o=Time.time end end end
