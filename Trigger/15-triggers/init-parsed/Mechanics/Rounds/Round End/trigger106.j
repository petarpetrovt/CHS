library trigger106 initializer init requires RandomShit, Functions

    function Trig_Complete_Level_Move_Conditions takes nothing returns boolean
        if(not(IsUnitInGroup(GetTriggerUnit(),GroupEmptyArenaCheck)==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Complete_Level_Move_Func003C takes nothing returns boolean
        if(not(IsPlayerInForce(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),DefeatedPlayers)!=true))then
            return false
        endif
        return true
    endfunction


    function Trig_Complete_Level_Move_Func005Func001C takes nothing returns boolean
        if((ElimModeEnabled==true))then
            return true
        endif
        if((GameModeShort==true))then
            return true
        endif
        return false
    endfunction


    function Trig_Complete_Level_Move_Func005C takes nothing returns boolean
        if(not Trig_Complete_Level_Move_Func005Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Complete_Level_Move_Func005Func003C takes nothing returns boolean
        if(not(RoundNumber <= 1))then
            return false
        endif
        return true
    endfunction


    function Trig_Complete_Level_Move_Func005Func003Func001C takes nothing returns boolean
        if(not(RoundNumber < 4))then
            return false
        endif
        return true
    endfunction


    function Trig_Complete_Level_Move_Func005Func002C takes nothing returns boolean
        if(not(RoundNumber <= 1))then
            return false
        endif
        return true
    endfunction


    function Trig_Complete_Level_Move_Func005Func002Func001C takes nothing returns boolean
        if(not(RoundNumber < 8))then
            return false
        endif
        return true
    endfunction


    function Trig_Complete_Level_Move_Actions takes nothing returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        local PlayerStats ps = PlayerStats.forPlayer(GetOwningPlayer(GetTriggerUnit()))
        local location arenaLocation

        if(Trig_Complete_Level_Move_Func003C())then
            set arenaLocation = GetRectCenter(RectMidArena)

            call RemoveDebuff(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], 0)
            call SetUnitPositionLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],arenaLocation)

            if (ps.getPet() != null) then
                call SetUnitPositionLoc(ps.getPet(),arenaLocation)
            endif

            call PanCameraToTimedLocForPlayer(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),arenaLocation,0.20)

            call RemoveLocation(arenaLocation)
            set arenaLocation = null
        endif
        if(Trig_Complete_Level_Move_Func005C())then
            if(Trig_Complete_Level_Move_Func005Func003C())then
                set LumberGained[pid] = 21 * RoundNumber
                call AdjustPlayerStateBJ((21 * RoundNumber),ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),PLAYER_STATE_RESOURCE_LUMBER)
                //call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 20, "|cff00aa0e+" + I2S(21*RoundNumber) + " lumber|r")
                call ResourseRefresh(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))) )
            else
                if(Trig_Complete_Level_Move_Func005Func003Func001C())then
                    set LumberGained[pid] = 11 * RoundNumber
                    call AdjustPlayerStateBJ((11 * RoundNumber),ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))) )
                else
                    set LumberGained[pid] = R2I((I2R(RoundNumber)/ 2.00))* 6
                    call AdjustPlayerStateBJ((R2I((I2R(RoundNumber)/ 2.00))* 6),ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))) )
                endif
            endif
        else
            if(Trig_Complete_Level_Move_Func005Func002C())then
                set LumberGained[pid] = 10 * RoundNumber
                call AdjustPlayerStateBJ((10 * RoundNumber),ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),PLAYER_STATE_RESOURCE_LUMBER)
                //call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 20, "|cff00aa0e+" + I2S(10*RoundNumber) + " lumber|r")
                call ResourseRefresh(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))) )
            else
                if(Trig_Complete_Level_Move_Func005Func002Func001C())then
                    set LumberGained[pid] = 6 * RoundNumber
                    call AdjustPlayerStateBJ((6 * RoundNumber),ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),PLAYER_STATE_RESOURCE_LUMBER)
                    //call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 20, "|cff00aa0e+" + I2S(6*RoundNumber) + " lumber|r")
                    call ResourseRefresh(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))) )
                else
                    set LumberGained[pid] = R2I((I2R(RoundNumber)/ 4.00))* 6
                    call AdjustPlayerStateBJ((R2I((I2R(RoundNumber)/ 4.00))* 6),ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),PLAYER_STATE_RESOURCE_LUMBER)
                    //call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 20, "|cff00aa0e+" + I2S((R2I((I2R(RoundNumber)/4.00))*6)) + " lumber|r")
                    call ResourseRefresh(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))) )
                endif
            endif
        endif
        call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, ("|cffffcc00Level Completed!"))
        call Func_completeLevel(  PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] )

        //remove end round dummy
        call DeleteUnit(GetTriggerUnit())
        call ConditionalTriggerExecute(udg_trigger108)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger106 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger106,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger106,Condition(function Trig_Complete_Level_Move_Conditions))
        call TriggerAddAction(udg_trigger106,function Trig_Complete_Level_Move_Actions)
    endfunction


endlibrary
