library trigger135 initializer init requires RandomShit, PlayerTracking, CreepDeath, AchievementsFrame

    function Trig_End_PvP_Conditions takes nothing returns boolean
        if(not(IsUnitInGroup(GetTriggerUnit(),DuelingHeroGroup)==true))then
            return false
        endif
        return true
    endfunction


    function Trig_End_PvP_Func001C takes nothing returns boolean
        if(not(DuelingHeroes[1]==GetTriggerUnit()))then
            return false
        endif
        return true
    endfunction


    function Trig_End_PvP_Func019A takes nothing returns nothing
        call PanCameraToTimedLocForPlayer(GetEnumPlayer(),GetRectCenter(udg_rect09),0.20)
    endfunction


    function Trig_End_PvP_Func021C takes nothing returns boolean
        if(not(udg_boolean07==false))then
            return false
        endif
        return true
    endfunction


    function Trig_End_PvP_Func021Func001Func001C takes nothing returns boolean
        if(not(DuelingHeroes[1]==udg_unit05))then
            return false
        endif
        return true
    endfunction


    function Trig_End_PvP_Func024Func001A takes nothing returns nothing
        call RemoveItem(GetEnumItem())
    endfunction


    function Trig_End_PvP_Func026C takes nothing returns boolean
        if(not(CountUnitsInGroup(PotentialDuelHeroes)==0))then
            return false
        endif
        return true
    endfunction


    function Trig_End_PvP_Func026Func007001002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction
    
    function Trig_End_PvP_Func026Func007001002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())==Player(11))
    endfunction
    
    function Trig_End_PvP_Func026Func007001002002002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_End_PvP_Func026Func007001002002002002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_End_PvP_Func026Func007001002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_End_PvP_Func026Func007001002002002001(),Trig_End_PvP_Func026Func007001002002002002())
    endfunction
    
    function Trig_End_PvP_Func026Func007001002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_End_PvP_Func026Func007001002002001(),Trig_End_PvP_Func026Func007001002002002())
    endfunction
    
    function Trig_End_PvP_Func026Func007001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_End_PvP_Func026Func007001002001(),Trig_End_PvP_Func026Func007001002002())
    endfunction


    function Trig_End_PvP_Func026Func007A takes nothing returns nothing
        local PlayerStats ps = PlayerStats.forPlayer(GetOwningPlayer(GetEnumUnit()))
        local location arenaLocation = GetRectCenter(udg_rect09)

        call SetUnitPositionLoc(GetEnumUnit(),arenaLocation)

        if (ps.getPet() != null) then
            call SetUnitPositionLoc(ps.getPet(),arenaLocation)
        endif

        call RemoveLocation(arenaLocation)
        set arenaLocation = null
    endfunction


    function Trig_End_PvP_Func026Func008C takes nothing returns boolean
        if(not(PlayerCount > 1))then
            return false
        endif
        return true
    endfunction


    function Trig_End_PvP_Func026Func016C takes nothing returns boolean
        if(not(udg_boolean08==true))then
            return false
        endif
        return true
    endfunction


    function Trig_End_PvP_Func026Func018C takes nothing returns boolean
        if(not(udg_boolean07==false))then
            return false
        endif
        return true
    endfunction


    function Trig_End_PvP_Func026Func018Func002A takes nothing returns nothing
        call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
    endfunction

    function Trig_End_PvP_Actions takes nothing returns nothing
        local real bonus = 1
        local item tempItem = null
        local PlayerStats ps
        local location arenaLocation = GetRectCenter(udg_rect09)

        if(Trig_End_PvP_Func001C())then
            set udg_unit05 = DuelingHeroes[2]
        else
            set udg_unit05 = DuelingHeroes[1]
        endif
        call DisableTrigger(udg_trigger140)
        call DisableTrigger(udg_trigger141)
        call DisableTrigger(udg_trigger135)
        call PvpStopSuddenDeathTimer()
        
        // Update the player's stats that they won a pvp match, and save
        set ps = PlayerStats.forPlayer(GetOwningPlayer(udg_unit05))
        call ps.addPVPWin()
        call SaveCommand_SaveCodeForPlayer(GetOwningPlayer(udg_unit05), false)

        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetOwningPlayer(udg_unit05))+(" |cffffcc00has defeated |r" +(GetPlayerNameColour(GetOwningPlayer(GetDyingUnit()))+ "|cffffcc00!!|r")))))
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetOwningPlayer(udg_unit05))+(" has |cffc2154f" + I2S(ps.getSeasonPVPWins()) + "|r PVP kills this season, |cffc2154f" + I2S(ps.getAllPVPWins()) + "|r all time for this game mode"))))

        call SetUnitInvulnerable(udg_unit05,true)
    
        //Midas Touch
        if GetMidasTouch(GetHandleId(GetDyingUnit())) != 0 then
            call CreepDeath_BountyText(udg_unit05, GetDyingUnit(), GetMidasTouch(GetHandleId(GetDyingUnit())).bonus)
            if ChestOfGreedBonus.boolean[GetHandleId(GetDyingUnit())] then
                set bonus = CgBonus
            endif
            call SetPlayerState(GetOwningPlayer(udg_unit05), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(udg_unit05), PLAYER_STATE_RESOURCE_GOLD) + R2I(GetMidasTouch(GetHandleId(GetDyingUnit())).bonus * bonus))
            set GetMidasTouch(GetHandleId(GetDyingUnit())).stop = true
        endif
    
        call TriggerSleepAction(4.00)
        if IsUnitInGroup(udg_unit05, DuelWinners) == false then
            call GroupAddUnitSimple(udg_unit05,DuelWinners)
        endif
        call FunWinner( udg_unit05 )
        //call GroupRemoveUnitSimple(GetDyingUnit(),DuelWinners)
        call GroupRemoveUnitSimple(udg_unit05,DuelingHeroGroup)
        call GroupRemoveUnitSimple(GetDyingUnit(),DuelingHeroGroup)
        call ForceAddPlayer(DuelLosers, GetOwningPlayer(GetDyingUnit()))
        call StopRectLeaveDetection(GetHandleId(DuelingHeroes[1]))
        call StopRectLeaveDetection(GetHandleId(DuelingHeroes[2]))
        call SetPlayerAllianceStateBJ(GetOwningPlayer(DuelingHeroes[1]),GetOwningPlayer(DuelingHeroes[2]),bj_ALLIANCE_UNALLIED)
        call SetPlayerAllianceStateBJ(GetOwningPlayer(DuelingHeroes[2]),GetOwningPlayer(DuelingHeroes[1]),bj_ALLIANCE_UNALLIED)
        call ForForce(GetPlayersAll(),function Trig_End_PvP_Func019A)
        call SetUnitPositionLoc(udg_unit05,arenaLocation)

        if (ps.getPet() != null) then
            call SetUnitPositionLoc(ps.getPet(),arenaLocation)
        endif

        if(Trig_End_PvP_Func021C())then
            set ps = PlayerStats.forPlayer(GetOwningPlayer(GetDyingUnit()))

            if (ps.getPet() != null) then
                call SetUnitPositionLoc(ps.getPet(),arenaLocation)
            endif
            
            call ReviveHeroLoc(GetDyingUnit(),arenaLocation,true)
            call AchievementsFrame_TryToSummonPet(ps.getPetIndex(), GetOwningPlayer(GetDyingUnit()), false)

            call FixDeath(GetDyingUnit())
            set PvpEndIndex = 1
            loop
                exitwhen PvpEndIndex > 6
                call RemoveItem(UnitItemInSlotBJ(DuelingHeroes[1],PvpEndIndex))
                call RemoveItem(UnitItemInSlotBJ(DuelingHeroes[2],PvpEndIndex))

                if GetPlayerSlotState(GetOwningPlayer(DuelingHeroes[1])) != PLAYER_SLOT_STATE_LEFT then
                    set tempItem = UnitAddItemByIdSwapped(DuelHeroItemIds1[PvpEndIndex],DuelingHeroes[1])

                    if ItemStacksP1[PvpEndIndex] > 1 then
                        call SetItemCharges(tempItem, ItemStacksP1[PvpEndIndex])
                    endif
                    
                    if UnitDropItemSlotBJ(DuelingHeroes[1],GetLastCreatedItem(),PvpEndIndex) then
                        //call BJDebugMsg("1a item move success")
                    else
                        //call BJDebugMsg("1a item move fail")
                    endif
                endif

                if GetPlayerSlotState(GetOwningPlayer(DuelingHeroes[2])) != PLAYER_SLOT_STATE_LEFT then
                    set tempItem = UnitAddItemByIdSwapped(DuelHeroItemIds2[PvpEndIndex],DuelingHeroes[2])

                    if ItemStacksP2[PvpEndIndex] > 1 then
                        call SetItemCharges(tempItem, ItemStacksP2[PvpEndIndex])
                    endif

                    if UnitDropItemSlotBJ(DuelingHeroes[2],GetLastCreatedItem(),PvpEndIndex) then
                        //call BJDebugMsg("2a item move success")
                    else
                        //call BJDebugMsg("2a item move fail")
                    endif
                endif
                set PvpEndIndex = PvpEndIndex + 1
            endloop
        else
            set PvpEndIndex = 1
            loop
                exitwhen PvpEndIndex > 6
                if(Trig_End_PvP_Func021Func001Func001C())then
                    call RemoveItem(UnitItemInSlotBJ(DuelingHeroes[1],PvpEndIndex))
                    call UnitAddItemByIdSwapped(DuelHeroItemIds1[PvpEndIndex],DuelingHeroes[1])
                    if UnitDropItemSlotBJ(DuelingHeroes[1],GetLastCreatedItem(),PvpEndIndex) then
                        //call BJDebugMsg("1b item move success")
                    else
                       //call BJDebugMsg("1b item move fail")
                    endif
                else
                    call RemoveItem(UnitItemInSlotBJ(DuelingHeroes[2],PvpEndIndex))
                    call UnitAddItemByIdSwapped(DuelHeroItemIds2[PvpEndIndex],DuelingHeroes[2])
                    if UnitDropItemSlotBJ(DuelingHeroes[2],GetLastCreatedItem(),PvpEndIndex) then
                        //call BJDebugMsg("2b item move success")
                    else
                        //call BJDebugMsg("2b item move fail")
                    endif
                endif
                call SetItemPawnable(UnitItemInSlotBJ(DuelingHeroes[1],PvpEndIndex), true)
                call SetItemPawnable(UnitItemInSlotBJ(DuelingHeroes[2],PvpEndIndex), true)
                set PvpEndIndex = PvpEndIndex + 1
            endloop
        endif

        call RemoveLocation(arenaLocation)
        set arenaLocation = null
        
        call GroupClear(ENUM_GROUP)
        
        call ConditionalTriggerExecute(udg_trigger54)
        call ConditionalTriggerExecute(udg_trigger122)
        set udg_integer38 = 1
        call RemoveUnitsInRect(bj_mapInitialPlayableArea)
        loop
            exitwhen udg_integer38 > 8
            call EnumItemsInRectBJ(PlayerArenaRects[udg_integer38],function Trig_End_PvP_Func024Func001A)
            set udg_integer38 = udg_integer38 + 1
        endloop
        set udg_unit05 = null
        call SetCurrentlyFighting(GetOwningPlayer(DuelingHeroes[1]), false)
        call SetCurrentlyFighting(GetOwningPlayer(DuelingHeroes[2]), false)
        if(Trig_End_PvP_Func026C())then
            call TriggerSleepAction(2)
            call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_End_PvP_Func026Func007001002)),function Trig_End_PvP_Func026Func007A)
            if(Trig_End_PvP_Func026Func008C())then
            else
                return
            endif
            call ForceClear(DuelLosers)
            set udg_integer41 =(udg_integer41 + 1)
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
            call TriggerSleepAction(1.00)
    
            if(Trig_End_PvP_Func026Func016C())then
                set udg_integer15 = DuelGoldReward[RoundNumber]
            else
                set udg_integer15 = DuelGoldReward[RoundNumber]		
            endif
            if(Trig_End_PvP_Func026Func018C())then
                call ForGroupBJ(DuelWinners,function Trig_End_PvP_Func026Func018Func002A)
            endif
            call PlaySoundBJ(udg_sound07)
            call ConditionalTriggerExecute(udg_trigger138)
            call DisplayTimedTextToForce(GetPlayersAll(),10.00,("|cffffcc00The PvP battles are over and all winners receive:|r |cff3bc739" + (I2S(udg_integer15) + " gold|r")))
            call ConditionalTriggerExecute(udg_trigger136)
        else
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
            call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Next PvP Battle ...")
            call StartTimerBJ(GetLastCreatedTimerBJ(),false,3.00)
            call TriggerSleepAction(3.00)
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
            call ConditionalTriggerExecute(udg_trigger136)
        endif

        set tempItem = null
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger135 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger135,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger135,Condition(function Trig_End_PvP_Conditions))
        call TriggerAddAction(udg_trigger135,function Trig_End_PvP_Actions)
    endfunction


endlibrary
