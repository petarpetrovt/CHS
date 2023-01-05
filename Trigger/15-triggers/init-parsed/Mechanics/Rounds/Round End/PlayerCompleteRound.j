library PlayerCompleteRound initializer init requires RandomShit, CustomGameEvent

    function EndroundForCreeps takes EventInfo eventInfo returns nothing
        if not eventInfo.isPvp then
            //destroy round creep groups to prevent leaks
            call ReleaseGroup(PlayerRoundCreeps[eventInfo.roundNumber].group[GetPlayerId(eventInfo.p)])
            set PlayerRoundCreeps[eventInfo.roundNumber].group[GetPlayerId(eventInfo.p)] = null
        endif
    endfunction

    private function CreepFilter takes nothing returns boolean
        return (UnitAlive(GetFilterUnit()) == true) and (GetOwningPlayer(GetFilterUnit()) == Player(11))
    endfunction

    private function PlayerCompleteRoundConditions takes nothing returns boolean
        local unit killingUnit = GetKillingUnit()
        local group playerArenaCreeps
        local boolean isValid
        local player currentPlayer

        if ((killingUnit == null) or (GetOwningPlayer(GetTriggerUnit()) != Player(11)) or (GetOwningPlayer(killingUnit) == Player(11))) then
            // Cleanup
            set killingUnit = null

            return false
        endif

        set playerArenaCreeps = GetUnitsInRectMatching(PlayerArenaRects[GetPlayerId(GetOwningPlayer(GetKillingUnit())) + 1], Condition(function CreepFilter))
        set currentPlayer = GetOwningPlayer(killingUnit)
        set isValid = (CountUnitsInGroup(playerArenaCreeps) == 0) and (IsPlayerInForce(currentPlayer, DefeatedPlayers) != true) and (IsPlayerInForce(currentPlayer, RoundPlayersCompleted) != true)
        
        // Cleanup
        call DestroyGroup(playerArenaCreeps)
        set killingUnit = null
        set currentPlayer = null

        return isValid
    endfunction

    private function PlayerCompleteRoundActions takes nothing returns nothing
        local player p = GetOwningPlayer(GetKillingUnit())
        local integer pid = GetPlayerId(p)
        local location arenaLocation = GetRectCenter(GetPlayableMapRect())
        local real duration = (T32_Tick - RoundStartTick) / 32
        local real playerCountSub = RMaxBJ(7 - (0.5 * duration), 0)
        local integer roundClearXpBonus = R2I(playerCountSub * (4 * Pow(RoundNumber, 2)))

        if (GetUnitTypeId(PlayerHeroes[pid + 1]) == TINKER_UNIT_ID) then
            set roundClearXpBonus = roundClearXpBonus * 2
        endif

        if (RoundNumber == 5) then
            set udg_boolean09 = false
        endif

        set BettingPlayerCount = PlayerCount / 2

        if (BettingPlayerCount > 3) then
            set BettingPlayerCount = 3
        endif

        call ForceAddPlayer(RoundPlayersCompleted, p)
        call SetCurrentlyFighting(p, false)
        call CustomGameEvent_FireEvent(EVENT_PLAYER_ROUND_COMPLETE, EventInfo.create(p, 0, RoundNumber))
        set RoundFinishedCount = RoundFinishedCount + 1
        call SetUnitInvulnerable(PlayerHeroes[pid + 1], true)
        
        if (RoundLiveLost[pid]) then
            set RoundLiveLost[pid] = false
            call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(p) + " |cffff7300died and lost a life!|r |cffbe5ffd" + I2S(Lives[pid]) + " remaining.|r")
        else
            if (roundClearXpBonus == 0) then
                call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(p) + " |cffffcc00survived the level!|r")
            else
                call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(p) + " |cffffcc00survived the level!|r |cff7bff00(+" + I2S(roundClearXpBonus) + " exp)|r")
                call AddHeroXPSwapped(roundClearXpBonus, PlayerHeroes[pid + 1], true)
            endif
        endif

        call CreateNUnitsAtLoc(1, PRIEST_1_UNIT_ID, p, arenaLocation, bj_UNIT_FACING)
        call UnitApplyTimedLifeBJ(2.00, 'BTLF', GetLastCreatedUnit())
        call GroupAddUnit(GroupEmptyArenaCheck, GetLastCreatedUnit())

        // Cleanup
        call RemoveLocation(arenaLocation)
        set arenaLocation = null
        set p = null
    endfunction

    private function init takes nothing returns nothing
        set PlayerCompleteRoundTrigger = CreateTrigger()
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_COMPLETE, CustomEvent.EndroundForCreeps)
        call TriggerRegisterAnyUnitEventBJ(PlayerCompleteRoundTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(PlayerCompleteRoundTrigger, Condition(function PlayerCompleteRoundConditions))
        call TriggerAddAction(PlayerCompleteRoundTrigger, function PlayerCompleteRoundActions)
    endfunction

endlibrary
