library trigger48 initializer init requires RandomShit

    function Trig_Place_Bet_Gold_Conditions takes nothing returns boolean
        if(not Trig_Place_Bet_Gold_Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_Gold_Actions takes nothing returns nothing
        if(Trig_Place_Bet_Gold_Func001C())then
            call DialogSetMessageBJ(udg_dialogs01[3],"Betting Menu")
            call DialogDisplayBJ(true,udg_dialogs01[3],GetTriggerPlayer())
            set udg_booleans04[GetConvertedPlayerId(GetTriggerPlayer())]= true
            set udg_booleans05[GetConvertedPlayerId(GetTriggerPlayer())]= false
        else
            if(Trig_Place_Bet_Gold_Func001Func001001())then
                return
            else
                call DoNothing()
            endif
            call DialogDisplayBJ(true,udg_dialogs01[2],GetTriggerPlayer())
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger48 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger48,udg_dialogs01[2])
        call TriggerAddCondition(udg_trigger48,Condition(function Trig_Place_Bet_Gold_Conditions))
        call TriggerAddAction(udg_trigger48,function Trig_Place_Bet_Gold_Actions)
    endfunction


endlibrary
