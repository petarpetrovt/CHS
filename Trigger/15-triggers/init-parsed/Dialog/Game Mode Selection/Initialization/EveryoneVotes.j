library EveryoneVotes initializer init requires RandomShit

    private function EveryoneVotesConditions takes nothing returns boolean
        return GetClickedButton() == udg_buttons04[0]
    endfunction

    private function EveryoneVotesActions takes nothing returns nothing
        set udg_boolean15 = true
        call ConditionalTriggerExecute(DialogInitializationTrigger)
    endfunction

    private function init takes nothing returns nothing
        set EveryoneVotesTrigger = CreateTrigger()
        call TriggerRegisterDialogEventBJ(EveryoneVotesTrigger, udg_dialog06)
        call TriggerAddCondition(EveryoneVotesTrigger, Condition(function EveryoneVotesConditions))
        call TriggerAddAction(EveryoneVotesTrigger, function EveryoneVotesActions)
    endfunction

endlibrary
