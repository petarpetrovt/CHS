library trigger122 initializer init requires RandomShit, SaveCommand

    function Trig_Victory_Func001Func001C takes nothing returns boolean
        if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
            return false
        endif
        if(not(InitialPlayerCount > 1))then
            return false
        endif
        if(not(PlayerCount==1))then
            return false
        endif
        if(not(udg_boolean11==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Victory_Func001Func002Func003Func001C takes nothing returns boolean
        if(not(udg_boolean08==true))then
            return false
        endif
        if(not(RoundNumber==25))then
            return false
        endif
        if(not(udg_boolean04==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Victory_Func001Func002Func003Func002C takes nothing returns boolean
        if(not(udg_boolean08==false))then
            return false
        endif
        if(not(RoundNumber==50))then
            return false
        endif
        if(not(udg_boolean04==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Victory_Func001Func002Func003C takes nothing returns boolean
        if(Trig_Victory_Func001Func002Func003Func001C())then
            return true
        endif
        if(Trig_Victory_Func001Func002Func003Func002C())then
            return true
        endif
        return false
    endfunction


    function Trig_Victory_Func001Func002C takes nothing returns boolean
        if(not(InitialPlayerCount==1))then
            return false
        endif
        if(not(PlayerCount==1))then
            return false
        endif
        if(not Trig_Victory_Func001Func002Func003C())then
            return false
        endif
        return true
    endfunction


    function Trig_Victory_Func001C takes nothing returns boolean
        if(Trig_Victory_Func001Func001C())then
            return true
        endif
        if(Trig_Victory_Func001Func002C())then
            return true
        endif
        return false
    endfunction


    function Trig_Victory_Conditions takes nothing returns boolean
        if(not Trig_Victory_Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Victory_Func006C takes nothing returns boolean
        if(not(udg_boolean02==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Victory_Func012C takes nothing returns boolean
        if(not(InitialPlayerCount==1))then
            return false
        endif
        if(not(PlayerCount==1))then
            return false
        endif
        return true
    endfunction

    private function AutoSaveForPlayer takes nothing returns nothing
        if (GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING) then
            call SaveCommand_SaveCodeForPlayer(GetEnumPlayer())
        endif
    endfunction

    function Trig_Victory_Actions takes nothing returns nothing
        local PlayerStats winningPlayer

        set udg_boolean11 = true
        call DisableTrigger(GetTriggeringTrigger())
        call DisableTrigger(udg_trigger118)
        call DisableTrigger(udg_trigger80)
        if(Trig_Victory_Func006C())then
            call EnableTrigger(udg_trigger81)
        else
        endif
        call ConditionalTriggerExecute(udg_trigger119)
        call TriggerSleepAction(2)
        if(Trig_Victory_Func012C())then
            call DisplayTimedTextToForce(GetPlayersAll(),30,("|cffffcc00" +("You survived all levels! Congratulations!!")))
        else
            call DisplayTimedTextToForce(GetPlayersAll(),30,((GetPlayerNameColour(WinningPlayer)+ " |cffffcc00survived longer than all other players! Congratulations!!")))
            
            // Update the player's stats that they won a BR
            set winningPlayer = PlayerStats.forPlayer(WinningPlayer)
            call winningPlayer.addBRWin()

            call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(WinningPlayer)+(" has |cffc2154f" + I2S(winningPlayer.getSeasonBRWins()) + "|r Battle Royale wins this season, |cffc2154f" + I2S(winningPlayer.getAllBRWins()) + "|r all time for this game mode"))))

        endif
        call EndThematicMusicBJ()
        call SetMusicVolumeBJ(0.00)
        call PlaySoundBJ(udg_sound05)
        call DisableTrigger(udg_trigger87)
        call TriggerSleepAction(2.00)
        call DisplayTimedTextToForce(GetPlayersAll(),26.00,"|cffffcc00Thank you for playing|r " + "|cff7bff00" + VERSION + "|r")

        // Save everyones codes
        call ForForce(GetPlayersAll(), function AutoSaveForPlayer)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger122 = CreateTrigger()
        call TriggerAddCondition(udg_trigger122,Condition(function Trig_Victory_Conditions))
        call TriggerAddAction(udg_trigger122,function Trig_Victory_Actions)
    endfunction


endlibrary
