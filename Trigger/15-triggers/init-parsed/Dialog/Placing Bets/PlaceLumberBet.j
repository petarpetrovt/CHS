library PlaceLumberBet initializer init requires RandomShit

    private function PlaceLumberBetConditions takes nothing returns boolean
        return GetClickedButton() == DialogButtons[4]
    endfunction

    private function PlaceLumberBetActions takes nothing returns nothing
        local player currentPlayer = GetTriggerPlayer()
        local integer playerId = GetConvertedPlayerId(currentPlayer)

        // Check the player actually has any lumber
        if (GetPlayerState(currentPlayer, PLAYER_STATE_RESOURCE_LUMBER) > 0) then
            call DialogSetMessage(Dialogs[3], "Betting Menu")
            call DialogDisplay(currentPlayer, Dialogs[3], true)
            set PlayerPlacedGoldBet[playerId] = false
            set PlayerPlacedLumberBet[playerId] = true
        else
            // Check if they took too long trying to bet
            if (AllowBetSelection == true) then
                // Go to the next dialog
                call DialogDisplay(currentPlayer, Dialogs[2], true)
            endif
        endif

        // Cleanup
        set currentPlayer = null
    endfunction

    private function init takes nothing returns nothing
        set PlaceLumberBetTrigger = CreateTrigger()
        call TriggerRegisterDialogEventBJ(PlaceLumberBetTrigger, Dialogs[2])
        call TriggerAddCondition(PlaceLumberBetTrigger, Condition(function PlaceLumberBetConditions))
        call TriggerAddAction(PlaceLumberBetTrigger, function PlaceLumberBetActions)
    endfunction

endlibrary
