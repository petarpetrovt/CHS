library PlayerLeavesGame initializer init requires RandomShit, Scoreboard, PlayerHeroSelected, HeroRefresh

    private function PlayerLeavesGameActions takes nothing returns nothing
        local player leaverPlayer = GetTriggerPlayer()
        local integer playerId = GetPlayerId(leaverPlayer)

        call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(leaverPlayer) + " |cffffcc00has left the game!|r")

        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayer(LeaverPlayers, leaverPlayer)
        call UpdateScoreboardPlayerLeaves(leaverPlayer)

        // Player is only decremented when a hero dies. If the hero doesn't exist yet the game gets messed up in the beginning
        if (ShopsCreated == false) then
            set PlayerCount = PlayerCount - 1
            call AllowSinglePlayerCommands()
            
            // Check if someone left during hero selection to prevent softlock
            if (AllPlayerHeroesSpawned == false and RoundNumber == 1 and SpawnedHeroCount == PlayerCount) then
                call PlayerHeroSelected_AllPlayersHaveHeroesActions()
            endif
        endif

        // Make sure the auto ready status is wiped
        set PlayerIsAlwaysReady[playerId] = false

        if (PlayerHeroes[playerId] != null) then
            call ResetHero(PlayerHeroes[playerId])
        endif

        // Find a new host
        if (HostPlayer == leaverPlayer) then
            call ConditionalTriggerExecute(SetHostPlayerTrigger)
        endif

        // Cleanup
        set leaverPlayer = null
    endfunction

    // kill players hero at start of round if they left
    private function OnRoundStart takes EventInfo eventInfo returns nothing
        if eventInfo.hero != null and (IsPlayerInForce(eventInfo.p, LeaverPlayers) or GetPlayerSlotState(eventInfo.p) != PLAYER_SLOT_STATE_PLAYING) then
            call SetUnitInvulnerable(eventInfo.hero, false)
            call KillUnit(eventInfo.hero)
        endif
    endfunction

    private function init takes nothing returns nothing
        set PlayerLeavesGameTrigger = CreateTrigger()
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(0))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(1))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(2))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(3))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(4))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(5))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(6))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(7))
        call TriggerAddAction(PlayerLeavesGameTrigger, function PlayerLeavesGameActions)
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_START, CustomEvent.OnRoundStart)
    endfunction

endlibrary
