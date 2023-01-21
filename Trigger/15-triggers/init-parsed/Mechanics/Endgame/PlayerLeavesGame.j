library PlayerLeavesGame initializer init requires RandomShit

    private function ResetHero takes unit u returns nothing
        if IsUnitType(u, UNIT_TYPE_HERO) then
            call RemoveItem(UnitItemInSlot(u, 0))
            call RemoveItem(UnitItemInSlot(u, 1))
            call RemoveItem(UnitItemInSlot(u, 2))
            call RemoveItem(UnitItemInSlot(u, 3))
            call RemoveItem(UnitItemInSlot(u, 4))
            call RemoveItem(UnitItemInSlot(u, 5))
    
            call RemoveHeroAbilities(u)
        endif

        call UnitRemoveAbility(u, REINCARNATION_ABILITY_ID)
    endfunction

    private function RemovePlayerUnit takes nothing returns nothing
        call RemoveUnit(GetEnumUnit())
    endfunction

    private function PlayerLeavesGameActions takes nothing returns nothing
        local player leaverPlayer = GetTriggerPlayer()
        local integer playerId = GetPlayerId(leaverPlayer)

        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayer(LeaverPlayers, leaverPlayer)

        // Make sure the auto ready status is wiped
        set PlayerIsAlwaysReady[GetPlayerId(leaverPlayer)] = false

        call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(leaverPlayer) + " |cffffcc00has left the game!|r")
        call ResetHero(PlayerHeroes[playerId])

        // Find a new host
        if (HostPlayer == leaverPlayer) then
            call ConditionalTriggerExecute(SetHostPlayerTrigger)
        endif

        // Cleanup
        set leaverPlayer = null
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
    endfunction

endlibrary
