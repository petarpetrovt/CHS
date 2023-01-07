library ConversionHotkeys initializer init requires Table, SellItems, PlayerHeroSelected, Scoreboard
    //detects hotkey presses
    
    globals
        //integer array PlayerHotkeys
        boolean array HoldShift
        boolean array HoldTab
        Table HoldShiftStructTable
        //boolean array HotKeyMode
    endglobals

    
    function GetHoldShiftStruct takes integer pid returns HoldShiftStruct
        return HoldShiftStructTable[pid]
    endfunction

    struct HoldShiftStruct extends array
        integer pid
        integer endTick

        method update takes nothing returns nothing
            set this.endTick = T32_Tick + 12
        endmethod

        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or HoldShift[this.pid] == false then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        static method create takes integer pid returns thistype
            local thistype this = thistype.setup()
            set this.pid = pid

            set this.endTick = T32_Tick + 12
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            if HoldShift[this.pid] then
                set HoldShift[this.pid] = false
            endif
            set HoldShiftStructTable[this.pid] = 0
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct

    globals
        integer lastTick = 0
    endglobals

    private function ShiftDown takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        set HoldShift[pid] = true
        set lastTick = T32_Tick
        if GetHoldShiftStruct(pid) == 0 then
            set HoldShiftStructTable[pid] = HoldShiftStruct.create(pid)
        else
            call GetHoldShiftStruct(pid).update()
        endif
    endfunction

    private function ShiftRelease takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        if HoldShift[pid] == true then
            set HoldShift[pid] = false
        endif
    endfunction

    private function ConvertLumber takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        local integer lumber = 0
        set lumber = GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER)
        call SetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER,0)
        call SetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD)  + lumber * 30)
        call ResourseRefresh(Player(pid)) 
    endfunction

    private function ConvertGold takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        local integer gold = 0
        set gold = GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD)/ 30

        call SetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD) - gold * 30  )
        call SetPlayerState(Player(pid), PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER) + gold)
        call ResourseRefresh(Player(pid)) 
    endfunction

    private function SellAllItems takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())

        if (ShopsCreated) then
            call SellItemsFromHero(PlayerHeroes[pid])
            call ResourseRefresh(Player(pid)) 
        endif
    endfunction

    private function ToggleRewards takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())

        if (RewardsFrameHandle != null and GetLocalPlayer() == GetTriggerPlayer()) then
            call BlzFrameSetVisible(RewardsFrameHandle, PlayerStats.forPlayer(GetTriggerPlayer()).toggleHasRewardsOpen()) 
        endif
    endfunction

    private function ToggleViewScoreboard takes nothing returns nothing
        if ((not HoldTab[GetPlayerId(GetTriggerPlayer())]) and ScoreboardFrameHandle != null and GetLocalPlayer() == GetTriggerPlayer()) then
            set HoldTab[GetPlayerId(GetTriggerPlayer())] = true
            call PlayerStats.forPlayer(GetTriggerPlayer()).setHasScoreboardOpen(true)
            call BlzFrameSetVisible(ScoreboardFrameHandle, true) 
        endif
    endfunction

    private function ToggleHideScoreboard takes nothing returns nothing
        if (ScoreboardFrameHandle != null and GetLocalPlayer() == GetTriggerPlayer()) then
            set HoldTab[GetPlayerId(GetTriggerPlayer())] = false
            call PlayerStats.forPlayer(GetTriggerPlayer()).setHasScoreboardOpen(false)
            call BlzFrameSetVisible(ScoreboardFrameHandle, false) 
        endif
    endfunction

    private function HotKeyInit takes nothing returns nothing
        local trigger shiftDownTrigger = CreateTrigger()
        local trigger shiftReleaseTrigger = CreateTrigger()
        local trigger qTrigger = CreateTrigger()
        local trigger wTrigger = CreateTrigger()
        local trigger eTrigger = CreateTrigger()
        local trigger tTrigger = CreateTrigger()
        local trigger scoreboardToggleViewTrigger = CreateTrigger()
        local trigger scoreboardToggleHideTrigger = CreateTrigger()
        local integer i = 0
        
        set HoldShiftStructTable = Table.create()

        loop
            call BlzTriggerRegisterPlayerKeyEvent(qTrigger, Player(i), OSKEY_Q, 2, true)
            call BlzTriggerRegisterPlayerKeyEvent(wTrigger, Player(i), OSKEY_W, 2, true)
            call BlzTriggerRegisterPlayerKeyEvent(eTrigger, Player(i), OSKEY_E, 2, true)
            call BlzTriggerRegisterPlayerKeyEvent(tTrigger, Player(i), OSKEY_T, 2, true)
            call BlzTriggerRegisterPlayerKeyEvent(shiftDownTrigger, Player(i), OSKEY_LSHIFT, 1, true)
            call BlzTriggerRegisterPlayerKeyEvent(shiftReleaseTrigger, Player(i), OSKEY_LSHIFT, 0, false)
            call BlzTriggerRegisterPlayerKeyEvent(shiftDownTrigger, Player(i), OSKEY_RSHIFT, 1, true)
            call BlzTriggerRegisterPlayerKeyEvent(shiftReleaseTrigger, Player(i), OSKEY_RSHIFT, 0, false)
            call BlzTriggerRegisterPlayerKeyEvent(scoreboardToggleViewTrigger, Player(i), OSKEY_TAB, 0, true)
            call BlzTriggerRegisterPlayerKeyEvent(scoreboardToggleHideTrigger, Player(i), OSKEY_TAB, 0, false)
            set i = i + 1
            exitwhen i == 8
        endloop

        call TriggerAddAction(qTrigger, function ConvertLumber)
        call TriggerAddAction(wTrigger, function ConvertGold)
        call TriggerAddAction(eTrigger, function SellAllItems)
        call TriggerAddAction(tTrigger, function ToggleRewards)
        call TriggerAddAction(shiftDownTrigger, function ShiftDown)
        call TriggerAddAction(shiftReleaseTrigger, function ShiftRelease)
        call TriggerAddAction(scoreboardToggleViewTrigger, function ToggleViewScoreboard)
        call TriggerAddAction(scoreboardToggleHideTrigger, function ToggleHideScoreboard)

        // Cleanup
        set qTrigger = null
        set wTrigger = null
        set eTrigger = null
        set tTrigger = null
        set shiftDownTrigger = null
        set shiftReleaseTrigger = null
        set scoreboardToggleViewTrigger = null
        set scoreboardToggleHideTrigger = null
    endfunction

    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterTimerEvent(trg, 1., false)
        call TriggerAddAction(trg, function HotKeyInit)
        set trg = null
    endfunction
endlibrary