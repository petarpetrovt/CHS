library AbsoluteArcane requires CustomState, DivineBubble
    
    struct AbsoluteArcaneStruct extends array
        unit source
        unit target
        integer endTick
        real bonus
    
        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or IsUnitDivineBubbled(this.target) or IsUnitSpellTargetCheck(this.target, GetOwningPlayer(this.source)) == false or GetUnitAbilityLevel(this.source, NULL_VOID_ORB_BUFF_ID) > 0  then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        static method create takes unit source, unit target returns thistype
            local thistype this
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif
            set this.source = source
            set this.target = target
            if IsUnitType(this.target, UNIT_TYPE_HERO) then
                set this.bonus = 1 * GetClassUnitSpell(this.source, Element_Arcane)
            else
                set this.bonus = 0.1 * GetClassUnitSpell(this.source, Element_Arcane)
            endif
            if GetUnitMagicDmg(this.target) - this.bonus > 0 then
                call AddUnitMagicDmg(this.source, this.bonus)
                call AddUnitMagicDmg(this.target, 0 - this.bonus)
            else
                set this.bonus = 0
            endif

            set this.endTick = T32_Tick + R2I(10*32)   
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call AddUnitMagicDmg(this.source, 0 - this.bonus)
            call AddUnitMagicDmg(this.target, this.bonus)
            set this.source = null
            set this.target = null
            set recycleNext = recycle
            set recycle = this
        endmethod
    
        implement T32x
    endstruct

    function AbsoluteArcaneDrain takes unit caster returns nothing
        local unit p = null
        call GroupClear(ENUM_GROUP)

        call GroupEnumUnitsInArea(ENUM_GROUP, GetUnitX(caster), GetUnitY(caster), 400, null)

        loop
            set p = FirstOfGroup(ENUM_GROUP)
            exitwhen p == null
            if IsUnitEnemy(p, GetOwningPlayer(caster)) and IsUnitSpellTargetCheck(p, GetOwningPlayer(caster)) then
                call AbsoluteArcaneStruct.create(caster, p)
            endif
            call GroupRemoveUnit(ENUM_GROUP, p)
        endloop
    endfunction
endlibrary