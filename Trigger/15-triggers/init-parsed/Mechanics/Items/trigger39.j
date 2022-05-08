library trigger39 initializer init requires RandomShit

    function Trig_Drop_Item_Func001C takes nothing returns boolean
        if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)!=true))then
            return false
        endif
        if(not(GetUnitTypeId(GetTriggerUnit())!=SUDDEN_DEATH_UNIT_ID))then
            return false
        endif
        if(not(GetUnitTypeId(GetTriggerUnit())!=PRIEST_1_UNIT_ID))then
            return false
        endif
        if(not(GetUnitTypeId(GetTriggerUnit())!=SELL_ITEM_DUMMY))then
            return false
        endif
        if(not(GetItemType(GetManipulatedItem())!=ITEM_TYPE_POWERUP))then
            return false
        endif
        return true
    endfunction


    function Trig_Drop_Item_Conditions takes nothing returns boolean
        if(not Trig_Drop_Item_Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Drop_Item_Func002C takes nothing returns boolean
        if(not(GetItemUserData(GetManipulatedItem())==0))then
            return false
        endif
        return true
    endfunction


    function Trig_Drop_Item_Actions takes nothing returns nothing
        if(Trig_Drop_Item_Func002C())then
            call BJDebugMsg("di a" + GetUnitName(GetTriggerUnit()))
            set udg_location02 = GetItemLoc(GetManipulatedItem())
            call UnitRemoveItemSwapped(GetManipulatedItem(),GetTriggerUnit())
            call SetItemPositionLoc(GetManipulatedItem(),udg_location02)
        else
            call BJDebugMsg("di b" + GetUnitName(GetTriggerUnit()))
            call UnitRemoveItemSwapped(GetManipulatedItem(),GetTriggerUnit())
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger39 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger39,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddCondition(udg_trigger39,Condition(function Trig_Drop_Item_Conditions))
        call TriggerAddAction(udg_trigger39,function Trig_Drop_Item_Actions)
    endfunction


endlibrary
