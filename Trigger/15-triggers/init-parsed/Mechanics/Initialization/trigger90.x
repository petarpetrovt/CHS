library trigger90 initializer init requires RandomShit, MouseHoverInfo

    function Trig_Melee_Initialization_Conditions takes nothing returns boolean
        if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
            return false
        endif
        return true
    endfunction

    function Trig_Melee_Initialization_Func010Func003001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction
    
    function Trig_Melee_Initialization_Func010Func003001001001002 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(11))
    endfunction
    
    function Trig_Melee_Initialization_Func010Func003001001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Melee_Initialization_Func010Func003001001001001(),Trig_Melee_Initialization_Func010Func003001001001002())
    endfunction
    
    function Trig_Melee_Initialization_Func010Func003001001002001001 takes nothing returns boolean
        return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
    endfunction
    
    function Trig_Melee_Initialization_Func010Func003001001002001002 takes nothing returns boolean
        return(IsPlayerInForce(GetFilterPlayer(),udg_force07)==true)
    endfunction
    
    function Trig_Melee_Initialization_Func010Func003001001002001 takes nothing returns boolean
        return GetBooleanOr(Trig_Melee_Initialization_Func010Func003001001002001001(),Trig_Melee_Initialization_Func010Func003001001002001002())
    endfunction
    
    function Trig_Melee_Initialization_Func010Func003001001002002 takes nothing returns boolean
        return(IsPlayerInForce(GetFilterPlayer(),udg_PlayersWithHero)!=true)
    endfunction
    
    function Trig_Melee_Initialization_Func010Func003001001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Melee_Initialization_Func010Func003001001002001(),Trig_Melee_Initialization_Func010Func003001001002002())
    endfunction
    
    function Trig_Melee_Initialization_Func010Func003001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Melee_Initialization_Func010Func003001001001(),Trig_Melee_Initialization_Func010Func003001001002())
    endfunction


    function Trig_Melee_Initialization_Func010Func003Func001Func003Func002001001002001 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_Melee_Initialization_Func010Func003Func001Func003Func002001001002002 takes nothing returns boolean
        return(UnitAlive(GetFilterUnit())==true)
    endfunction
    
    function Trig_Melee_Initialization_Func010Func003Func001Func003Func002001001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Melee_Initialization_Func010Func003Func001Func003Func002001001002001(),Trig_Melee_Initialization_Func010Func003Func001Func003Func002001001002002())
    endfunction


    function Trig_Melee_Initialization_Func010Func003Func001Func003C takes nothing returns boolean
        if(not(PlayerHeroPicked[GetConvertedPlayerId(GetEnumPlayer())]==false))then
            return false
        endif
        if(not(CountUnitsInGroup(GetUnitsOfPlayerMatching(GetEnumPlayer(),Condition(function Trig_Melee_Initialization_Func010Func003Func001Func003Func002001001002)))==0))then
            return false
        endif
        return true
    endfunction


    function Trig_Melee_Initialization_Func010Func003Func001C takes nothing returns boolean
        if(not Trig_Melee_Initialization_Func010Func003Func001Func003C())then
            return false
        endif
        return true
    endfunction


    function Trig_Melee_Initialization_Func010Func003A takes nothing returns nothing
        if(Trig_Melee_Initialization_Func010Func003Func001C())then
            set udg_player02 = GetEnumPlayer()
            call ConditionalTriggerExecute(udg_trigger79)
        endif
    endfunction


    function Trig_Melee_Initialization_Actions takes nothing returns nothing
        call DisableTrigger(GetTriggeringTrigger())
        call TriggerSleepAction(0.50)

        if(SpawnedHeroCount < PlayerCount)then
            if(RandomHeroMode)then
                return
            endif

            call PlaySoundBJ(udg_sound14)
            call EnableTrigger(udg_trigger78)
            // call MouseHoverInfo_ActivateMouseHover()
            // call DisplayTimedTextToForce(GetPlayersAll(),8.00,"|cffffcc00Select your hero! (click again to confirm)|r")
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
            // call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Game starting in ...")
            // call StartTimerBJ(GetLastCreatedTimerBJ(),false,30.00)
        endif

        call TriggerSleepAction(24.50)
        set udg_location01 = OffsetLocation(GetRectCenter(GetPlayableMapRect()),- 40.00,- 50.00)
        set CountdownCount = 5
        call ConditionalTriggerExecute(PvpCountdownTimerTrigger)
        call TriggerSleepAction(5.00)

        if(SpawnedHeroCount < PlayerCount and RoundNumber != 1) then
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
            call PlaySoundBJ(udg_sound11)
            call ForForce(GetPlayersMatching(Condition(function Trig_Melee_Initialization_Func010Func003001001)),function Trig_Melee_Initialization_Func010Func003A)
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger90 = CreateTrigger()
        call TriggerAddCondition(udg_trigger90,Condition(function Trig_Melee_Initialization_Conditions))
        call TriggerAddAction(udg_trigger90,function Trig_Melee_Initialization_Actions)
    endfunction


endlibrary