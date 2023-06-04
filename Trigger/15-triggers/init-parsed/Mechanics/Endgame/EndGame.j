library EndGame initializer init requires RandomShit, SaveCommand, Scoreboard, BattleRoyaleHelper

    private function IsOnlyOnePlayerRemaining takes nothing returns boolean
        return (IsTriggerEnabled(GetTriggeringTrigger()) == true) and (InitialPlayerCount > 1) and (PlayerCount == 1) and (GameComplete == false)
    endfunction

    private function IsShortGameComplete takes nothing returns boolean
        return (GameModeShort == true) and (RoundNumber == 25) and (ElimModeEnabled == false)
    endfunction

    private function IsLongGameComplete takes nothing returns boolean
        return (GameModeShort == false) and (RoundNumber == 50) and (ElimModeEnabled == false)
    endfunction

    private function IsShortOrLongGameComplete takes nothing returns boolean
        return IsShortGameComplete() or IsLongGameComplete()
    endfunction

    private function IsInitialSoloPlayerGame takes nothing returns boolean
        return (InitialPlayerCount == 1) and (PlayerCount == 1) and IsShortOrLongGameComplete()
    endfunction

    private function EndGameConditions takes nothing returns boolean
        return IsOnlyOnePlayerRemaining() or IsInitialSoloPlayerGame()
    endfunction

    private function ShowScoreboardForPlayer takes nothing returns nothing
        call PlayerStats.forPlayer(GetEnumPlayer()).setHasScoreboardOpen(true)
    endfunction

    private function AutoSaveForPlayer takes nothing returns nothing
        if (GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING) then
            call SaveCommand_SaveCodeForPlayer(GetEnumPlayer(), false)
        endif
    endfunction

    private function GetWinner takes nothing returns nothing
        local integer i = 0

        set WinningPlayer = Player(PLAYER_NEUTRAL_PASSIVE)

        loop
            if UnitAlive(PlayerHeroes[i]) then
                // call BJDebugMsg(GetPlayerName(Player(i)) + ", hero alive: " + GetUnitName(PlayerHeroes[i]))
                set WinningPlayer = Player(i)
            endif

            set i = i + 1
            exitwhen i == 8
        endloop

        if (WinningPlayer != Player(PLAYER_NEUTRAL_PASSIVE)) then
            call SetUnitInvulnerable(PlayerHeroes[GetPlayerId(WinningPlayer)], true)
        endif
    endfunction

    private function EndGameActions takes nothing returns nothing
        local PlayerStats ps

        set GameComplete = true
        call DisableTrigger(AllPlayersDeadTrigger)
        call DisableTrigger(PlayerHeroDeathTrigger)

        if (BrStarted == false) then
            call EnableTrigger(HeroDiesInRoundTrigger)
        endif

        call ConditionalTriggerExecute(IsGameFinishedTrigger)

        // Get the winner before the trigger sleep
        call GetWinner()
        call TriggerSleepAction(2)

        if (InitialPlayerCount == 1 and PlayerCount == 1) then
            call DisplayTimedTextToForce(GetPlayersAll(), 30, "|cffffcc00You survived all levels! Congratulations!!")
        else
            if (WinningPlayer != Player(PLAYER_NEUTRAL_PASSIVE)) then
                call UpdateScoreboardBrWinner(WinningPlayer)

                if (not IsFunBRRound) then
                    // Update the player's stats that they won a BR
                    set ps = PlayerStats.forPlayer(WinningPlayer)
                    call ps.addBRWin()
                endif

                call DisplayTimedTextToForce(GetPlayersAll(), 30, GameDescription)
                call DisplayTimedTextToForce(GetPlayersAll(), 30, GetPlayerNameColour(WinningPlayer) + " |cffffcc00survived longer than all other players with " + ps.getBRPVPKillCount() + " Congratulations!!")
                call DisplayTimedTextToForce(GetPlayersAll(), 30, GetPlayerNameColour(WinningPlayer) + " has |cffc2154f" + I2S(ps.getSeasonBRWins()) + "|r Battle Royale wins this season, |cffc2154f" + I2S(ps.getAllBRWins()) + "|r all time for this game mode")
            else
                call DisplayTimedTextToForce(GetPlayersAll(), 30, GameDescription)
                call DisplayTimedTextToForce(GetPlayersAll(), 30, "|cffff7b00No winner detected.|r |cffffcc00That sucks bro, the game ends here.")
            endif
        endif

        call PlaySoundBJ(udg_sound05)
        call TriggerSleepAction(2.00)

        // Save everyones codes
        if (not IsFunBRRound) then
            call DisplayTimedTextToForce(GetPlayersAll(), 30.00, "|cffffcc00Thank you for playing|r " + "|cff7bff00" + CurrentGameVersion.getVersionString() + "|r")
            call ForForce(GetPlayersAll(), function AutoSaveForPlayer)
        endif

        // Show the scoreboard to everyone
        call TriggerSleepAction(3.00)
        call ForForce(GetPlayersAll(), function ShowScoreboardForPlayer) 
        call BlzFrameSetVisible(ScoreboardFrameHandle, true)

        set IsFunBRRound = true

        call InitializeFunBattleRoyale()
    endfunction

    private function init takes nothing returns nothing
        set EndGameTrigger = CreateTrigger()
        call TriggerAddCondition(EndGameTrigger, Condition(function EndGameConditions))
        call TriggerAddAction(EndGameTrigger, function EndGameActions)
    endfunction

endlibrary
