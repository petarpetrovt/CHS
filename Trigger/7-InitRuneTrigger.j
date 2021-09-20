function Trig_InitRuneTrigger takes nothing returns nothing
    local integer IdRune = 0
    set IdRune = LoadInteger(HT,GetItemTypeId(GetManipulatedItem()),1)
    if IdRune > 0 then
        set GLOB_RUNE_U = GetTriggerUnit()
        set GLOB_RUNE_POWER = GetRunePower(GetManipulatedItem())
        call CreateTextTagTimerColor( RunesName[IdRune] + " " + I2S(R2I(GLOB_RUNE_POWER*100))+"%"  ,1,GetUnitX(GLOB_RUNE_U),GetUnitY(GLOB_RUNE_U),50+GetRandomInt(0,150),1,122,50,255)
        call TriggerEvaluate(RunesTriggers[IdRune])
    endif
endfunction


function Trig_InitRuneTrigger_Actions takes nothing returns nothing
    call InitRuneId()
endfunction

//===========================================================================
function InitTrig_InitRuneTrigger takes nothing returns nothing
    local trigger ActI = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ( ActI, EVENT_PLAYER_UNIT_DROP_ITEM )
    call TriggerAddAction( ActI, function Trig_InitRuneTrigger )
    set gg_trg_InitRuneTrigger = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_InitRuneTrigger, 0.01 )
    call TriggerAddAction( gg_trg_InitRuneTrigger, function Trig_InitRuneTrigger_Actions )
endfunction
