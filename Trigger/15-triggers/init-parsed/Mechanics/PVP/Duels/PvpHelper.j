library PvpHelper requires RandomShit, StartFunction, DebugCode, UnitFilteringUtility, VotingResults, OldInitialization

    globals
        integer array PreDuelItemIds
        integer array PreDuelItemCharges

        private boolean SpawnLeft
        private rect TempArena
    endglobals

    private function FilterNonDuelingPlayers takes nothing returns boolean
        local player currentPlayer = GetFilterPlayer()
        local unit playerHero = PlayerHeroes[GetPlayerId(currentPlayer) + 1] // Stored as converted player id. Rip.
        local boolean isNonDuelingPlayer = (IsUnitInGroup(playerHero, DuelingHeroes) == false) and (IsPlayerInForce(currentPlayer, DefeatedPlayers) != true)

        // Cleanup
        set currentPlayer = null
        set playerHero = null

        return isNonDuelingPlayer
    endfunction

    private function ShowBettingDialogForPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()

        if (GetPlayerState(currentPlayer, PLAYER_STATE_RESOURCE_GOLD) > 0 or GetPlayerState(currentPlayer, PLAYER_STATE_RESOURCE_LUMBER) > 0) then
            call DialogDisplayBJ(true, Dialogs[1], currentPlayer)
        endif

        // Cleanup
        set currentPlayer = null
    endfunction

    private function HideDialogsForPlayer takes nothing returns nothing
        local integer dialogIndex = 1

        loop
            exitwhen dialogIndex > 3
            call DialogDisplay(GetEnumPlayer(), Dialogs[dialogIndex], false)
            set dialogIndex = dialogIndex + 1
        endloop
    endfunction

    private function RefreshHero takes unit playerHero returns nothing
        // Hp/mana restore
        call SetUnitLifePercentBJ(playerHero,100)
        call SetUnitManaPercentBJ(playerHero,100)
    
        // Reset cooldowns
        call UnitResetCooldown(playerHero)
    
        // Remove all possible buffs. TODO Replace these static buffs with ids from the IdLibrary.j
        call UnitRemoveAbility(playerHero, 'Bvul')
        call UnitRemoveAbility(playerHero, 'Bam2')
        call UnitRemoveAbility(playerHero, 'BHav')
        call UnitRemoveAbility(playerHero, 'BHbn')
        call UnitRemoveAbility(playerHero, 'BNbr')
        call UnitRemoveAbility(playerHero, 'Bbsk')
        call UnitRemoveAbility(playerHero, 'Bapl')
        call UnitRemoveAbility(playerHero, 'Bplg')
        call UnitRemoveAbility(playerHero, 'Bena')
        call UnitRemoveAbility(playerHero, 'Beng')
        call UnitRemoveAbility(playerHero, 'BEer')
        call UnitRemoveAbility(playerHero, 'Bfae')
        call UnitRemoveAbility(playerHero, 'BUfa')
        call UnitRemoveAbility(playerHero, 'Binf')
        call UnitRemoveAbility(playerHero, 'Blsh')
        call UnitRemoveAbility(playerHero, 'Bliq')
        call UnitRemoveAbility(playerHero, 'Bpoi')
        call UnitRemoveAbility(playerHero, 'Bpsd')
        call UnitRemoveAbility(playerHero, 'Brej')
        call UnitRemoveAbility(playerHero, 'Bdef')
        call UnitRemoveAbility(playerHero, 'B002')
        call UnitRemoveAbility(playerHero, 'Bslo')
        call UnitRemoveAbility(playerHero, 'Bspl')
        call UnitRemoveAbility(playerHero, 'BSTN')
        call UnitRemoveAbility(playerHero, 'BPSE')
        call UnitRemoveAbility(playerHero, 'BHtc')
        call UnitRemoveAbility(playerHero, 'Buhf')
    
        // Remove any debuffs
        call RemoveDebuff(playerHero, 0)
    endfunction

    private function MoveCameraToArenaForPlayer takes nothing returns nothing
        local location arenaCenter = GetRectCenter(TempArena)

        call PanCameraToTimedLocForPlayer(GetEnumPlayer(), arenaCenter, 0.20)

        // Cleanup
        call RemoveLocation(arenaCenter)
        set arenaCenter = null
    endfunction

    private function SetupPlayerInArena takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local unit playerHero = PlayerHeroes[playerId + 1] // Stored as converted player id. Rip.
        local location arenaCenter = GetRectCenter(TempArena)
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)
        local integer itemSlotIndex = 0
        local item currentItem
        local location spawnOffset

        // Mark the player hero as fighting
        call GroupAddUnit(DuelingHeroes, playerHero)

        // Determine the spawn offset
        if (SpawnLeft) then
            set spawnOffset = OffsetLocation(arenaCenter, -500.00,0)
        else
            set spawnOffset = OffsetLocation(arenaCenter, 500.00,0)
        endif

        // Actually move the unit
        call SetUnitPositionLocFacingLocBJ(playerHero, spawnOffset, arenaCenter)

        // When this struct is created, it saves the current location of the unit as valid with the arena. PRevents players from somehow leaving during a duel
        call RectLeaveDetection.create(playerHero, TempArena)

        // Teleport the players unit
        if (ps.getPet() != null) then
            call SetUnitPositionLocFacingLocBJ(ps.getPet(), spawnOffset, arenaCenter)
        endif

        // Save debug logs for the player before the fight
        call DebugCode_SavePlayerDebug(currentPlayer)

        // Pause the unit, select it for the player, refresh the unit, add to group of dueling heroes
        call PauseUnit(playerHero, true)
        call SelectUnitForPlayerSingle(playerHero, currentPlayer)
        call RefreshHero(playerHero)
        call GroupAddUnit(DuelingHeroGroup, playerHero)

        // Save the items and item charges for the player before the duel starts. Make items unpawnable as well
        loop
            set currentItem = UnitItemInSlot(playerHero, itemSlotIndex)

            if (currentItem != null) then
                // Save all item information in a single array with the playerId as the offset
                set PreDuelItemIds[(6 * playerId) + itemSlotIndex] = GetItemTypeId(currentItem)
                set PreDuelItemCharges[(6 * playerId) + itemSlotIndex] = GetItemCharges(currentItem)
                call SetItemPawnable(currentItem, false)

                // Cleanup
                set currentItem = null
            else
                set PreDuelItemIds[(6 * playerId) + itemSlotIndex] = -1
                set PreDuelItemCharges[(6 * playerId) + itemSlotIndex] = -1
            endif

            set itemSlotIndex = itemSlotIndex + 1
            exitwhen itemSlotIndex == 6
        endloop

        // Cleanup
        call RemoveLocation(arenaCenter)
        call RemoveLocation(spawnOffset)
        set arenaCenter = null
        set spawnOffset = null
        set playerHero = null
        set currentPlayer = null
    endfunction

    private function RemoveItemFromArena takes nothing returns nothing
        call RemoveItem(GetEnumItem())
    endfunction

    private function StartFightForUnit takes nothing returns nothing
        local unit currentUnit = GetEnumUnit()
        local player currentPlayer = GetOwningPlayer(currentUnit)
        local integer playerId = GetPlayerId(currentPlayer)

        call SetUnitInvulnerable(currentUnit, false)
        call StartFunctionSpell(currentUnit, 4) // 4 = duels
        call PauseUnit(currentUnit, false)
        call SetCurrentlyFighting(currentPlayer, true)

        // Cleanup
        set currentUnit = null
        set currentPlayer = null
    endfunction

    private function InitializeFightBetweenForces takes force team1, force team2, rect arena returns nothing
        local string team1ForceString = ConvertForceToString(team1)
        local string team2ForceString = ConvertForceToString(team2)

        // Validate. Hopefully should never happen.
        if (CountPlayersInForceBJ(team1) == 0 or CountPlayersInForceBJ(team2) == 0) then
            call DisplayTimedTextToForce(GetPlayersAll(), 90, "|cfffd2727Duel Error|r: One of the forces are empty trying to start a duel")
            return
        endif

        // Save the temp global arena variable for use in other functions
        set TempArena = arena

        // Cleanup the arena
        call EnumItemsInRect(arena, null, function RemoveItemFromArena)

        // Teleport team1 to the left side of the arena, team2 to the right side of the arena
        set SpawnLeft = true
        call ForForce(team1, function SetupPlayerInArena)
        set SpawnLeft = false
        call ForForce(team2, function SetupPlayerInArena)

        // Set the alliances
        call SetForceAllianceStateBJ(team1, team2, bj_ALLIANCE_UNALLIED)
        call SetForceAllianceStateBJ(team2, team1, bj_ALLIANCE_UNALLIED)
        call SetForceAllianceStateBJ(team1, team1, bj_ALLIANCE_ALLIED)
        call SetForceAllianceStateBJ(team2, team2, bj_ALLIANCE_ALLIED)

        // Play a sound. Dunno what it is.
        call PlaySoundBJ(udg_sound08)

        // Either do actions for just the two teams, or everyone depending on the simlutaneous vote status
        if (SimultaneousDuelMode == 1 or DuelGameList.size() == 1) then // No simultaneous duels or there is only one duel (Only 2 people in game, or odd player duel)
            // Move the camera to the arena for everyone
            call ForForce(GetPlayersAll(), function MoveCameraToArenaForPlayer)

            // Display message to everyone about the duel
            call DisplayTextToForce(GetPlayersAll(), "|cffa0966dPvP Battle:|r " + team1ForceString + " vs " + team2ForceString)
        else
            // Only move the camera to the arena for the two forces
            call ForForce(team1, function MoveCameraToArenaForPlayer)
            call ForForce(team2, function MoveCameraToArenaForPlayer)

            // Display message to each force about who they are fighting
            call DisplayTextToForce(team1, "|cffa0966dPvP Battle:|r " + team1ForceString + " vs " + team2ForceString)
            call DisplayTextToForce(team2, "|cffa0966dPvP Battle:|r " + team2ForceString + " vs " + team1ForceString)
        endif

        // Cleanup the temp global variables
        set TempArena = null

        // Betting should only be enabled for non-simultaneous duels
        // team1 and team2 should only have one player in each. We don't support betting on duels with multiple people on each team
        set AllowBetSelection = true

        if (BettingEnabled == true) then
            call DialogClear(Dialogs[1])
            call DialogSetMessage(Dialogs[1], "Betting Menu")

            // Add the dueling hero player names to the betting menu
            set DialogButtons[1] = DialogAddButtonBJ(Dialogs[1], "<< " + ConvertForceToString(team1) + "|r   ")
            set DialogButtons[2] = DialogAddButtonBJ(Dialogs[1], "   " + ConvertForceToString(team2) + "|r >>")
            set DialogButtons[3] = DialogAddButtonBJ(Dialogs[1], "Skip")

            // Show the betting dialog to all non dueling players
            call ForForce(GetPlayersMatching(Condition(function FilterNonDuelingPlayers)), function ShowBettingDialogForPlayer)
        endif
    endfunction

    function StartDuels takes nothing returns nothing
        // Start the countdown timer for the actual fight
        call DestroyTimerDialog(GetLastCreatedTimerDialogBJ())
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "Prepare ...")
        call StartTimerBJ(GetLastCreatedTimerBJ(), false, 10.00)

        // Run the countdown timer
        call TriggerSleepAction(4.50)
        set CountdownCount = 5
        call ConditionalTriggerExecute(PvpCountdownTimerTrigger)
        call TriggerSleepAction(5.50)
        set AllowBetSelection = false

        // Hide all dialogs
        call ForForce(GetPlayersAll(), function HideDialogsForPlayer)
        call DestroyTimerDialog(GetLastCreatedTimerDialogBJ())

        // Reset sudden death properties
        set SuddenDeathTick = 0
        set SuddenDeathDamageMultiplier = 0.02
        call EnableTrigger(UpdatePvpSuddenDeathDamageTrigger)
        call EnableTrigger(ApplyPvpSuddenDeathDamageTrigger)
        call EnableTrigger(SinglePvpHeroDeathTrigger)
        call PvpStartSuddenDeathTimer()
        call PlaySoundBJ(udg_sound15)

        // Start the fight
        call ForGroup(DuelingHeroes, function StartFightForUnit)

        // Force any computer players to attack right away
        call TriggerExecute(ComputerPvpEnforceDuelTrigger)
    endfunction
    
    function InitializeDuelGame takes DuelGame duelGame returns nothing
        call InitializeFightBetweenForces(duelGame.team1, duelGame.team2, duelGame.arena)
    endfunction

endlibrary
