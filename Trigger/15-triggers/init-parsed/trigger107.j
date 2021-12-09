library trigger107 initializer init requires RandomShit

    function Trig_Complete_Level_Player_Conditions takes nothing returns boolean
        if(not Trig_Complete_Level_Player_Func006C())then
            return false
        endif
        return true
    endfunction


    function Trig_Complete_Level_Player_Actions takes nothing returns nothing
        local player p = GetOwningPlayer(GetKillingUnit())
        local integer pid = GetPlayerId(p)
    
        if(Trig_Complete_Level_Player_Func001001())then
            set udg_boolean09 = false
        else
            call DoNothing()
        endif
        set udg_integer56 =(udg_integer06 / 2)
        if(Trig_Complete_Level_Player_Func004001())then
            set udg_integer56 = 3
        else
            call DoNothing()
        endif
        if(Trig_Complete_Level_Player_Func005C())then
            set udg_integer48 =((udg_integer06 -(1 + CountPlayersInForceBJ(udg_force03)))*(udg_integer02 * 5))
            set udg_integer48 =(udg_integer48 * udg_integer02)
            if(Trig_Complete_Level_Player_Func005Func004001())then
                set udg_integer48 =(udg_integer48 / 2)
            else
                call DoNothing()
            endif
        else
            set udg_integer48 = 0
        endif
        call ForceAddPlayerSimple(p,udg_force03)
        call SetCurrentlyFighting(p, false)
        set udg_integer08 =(udg_integer08 + 1)
        call SetUnitInvulnerable(udg_units01[pid + 1],true)
        if RoundLiveLost[pid] then
            set RoundLiveLost[pid] = false
            call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ " |cffff7300died and lost a life!|r |cffbe5ffd" + I2S(Lives[pid]) + " remaining.|r")))
        else
            if(Trig_Complete_Level_Player_Func010C())then
                call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ " |cffffcc00survived the level!|r")))
            else
                call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+(" |cffffcc00survived the level!|r |cff7bff00(+" +(I2S(udg_integer48)+ " exp)|r")))))
                call AddHeroXPSwapped(udg_integer48,udg_units01[pid + 1],true)
            endif
        endif
        call CreateNUnitsAtLoc(1,'h015',p,GetRectCenter(GetPlayableMapRect()),bj_UNIT_FACING)
        call UnitApplyTimedLifeBJ(2.00,'BTLF',GetLastCreatedUnit())
        call GroupAddUnitSimple(GetLastCreatedUnit(),udg_group08)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger107 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger107,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger107,Condition(function Trig_Complete_Level_Player_Conditions))
        call TriggerAddAction(udg_trigger107,function Trig_Complete_Level_Player_Actions)
    endfunction


endlibrary
