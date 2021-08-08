function ResetAbility_A05U takes unit u,integer id returns nothing
    if BlzGetUnitAbilityCooldownRemaining(u,'A05U')<= 0.001 and   GetUnitAbilityLevel(u,'A05U') > 0 then
    
        call  AbilStartCD(u,'A05U',BlzGetUnitAbilityCooldownRemaining(u,id)*(4-0.1*I2R(GetUnitAbilityLevel(u,'A05U')))) 
        call BlzEndUnitAbilityCooldown(u,id)
    
    endif
    

endfunction


function ResetAbilit_Ec takes nothing returns nothing
call ResetAbility_A05U(Global_u,Global_i)
endfunction




function A05U_Reset_Timer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit U = LoadUnitHandle(HT,GetHandleId(t),2)
    local integer Id = LoadInteger(HT,GetHandleId(t),1)

    call ResetAbility_A05U(U,Id)

    call FlushChildHashtable(HT,GetHandleId(t))
    call DestroyTimer(t)
    set t =null
    set U = null
endfunction






function Trig_AbilityCast_Copy_Actions takes nothing returns nothing
    local unit U =  GetTriggerUnit()
    local integer Id = GetSpellAbilityId()
    local timer t = null



	if GetUnitTypeId(GetTriggerUnit() ) == 'H008' then
        call USOrderA(GetTriggerUnit(),GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()),'A037',"fanofknives",  GetHeroLevel(GetTriggerUnit())*50 , ConvertAbilityRealLevelField('Ocl1') )
	endif

if Id != 'A024' then
    if GetUnitAbilityLevel(U,'A05U')>0 and BlzGetUnitAbilityCooldownRemaining(U,'A05U')<=0.001 then
        set t = CreateTimer()
        call SaveInteger(HT,GetHandleId(t),1,Id)
        call SaveUnitHandle(HT,GetHandleId(t),2, U)
        call TimerStart(t,0,false,function A05U_Reset_Timer)
        
    endif
endif

set U = null
set t = null
endfunction

//===========================================================================
function InitTrig_AbilityCast_Copy takes nothing returns nothing
    set gg_trg_AbilityCast_Copy = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_AbilityCast_Copy, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction( gg_trg_AbilityCast_Copy, function Trig_AbilityCast_Copy_Actions )
endfunction

