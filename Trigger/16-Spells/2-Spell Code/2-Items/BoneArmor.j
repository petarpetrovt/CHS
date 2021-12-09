library BoneArmor initializer init requires Utility
    globals
        Table BoneArmorTable
    endglobals

    private function BoneArmorFilter takes nothing returns boolean
        return UnitAlive(GetFilterUnit()) and GetUnitTypeId(GetFilterUnit()) == 'u003'
    endfunction

    function GetBoneArmorStruct takes integer id returns BoneArmorStruct
        return BoneArmorTable[id]
    endfunction

    struct BoneArmorStruct extends array
        unit source
        group boneArmorUnits
        integer groupSize
        integer tick
        integer endTick
        integer pid
        boolean enabled
    
        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        private method refreshGroup takes nothing returns nothing
            call GroupClear(this.boneArmorUnits)
            call GroupEnumUnitsOfPlayer(this.boneArmorUnits, Player(this.pid), Condition(function BoneArmorFilter))
            set this.groupSize = BlzGroupGetSize(this.boneArmorUnits)
            //call BJDebugMsg(I2S(this.pid) + " ba size: " + I2S(this.groupSize))
        endmethod
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.tick then
                set this.tick = T32_Tick + 32
                call this.refreshGroup()
            endif
            if T32_Tick > this.endTick or HasPlayerFinishedLevel(this.source, Player(this.pid)) or this.groupSize == 0 then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 
    
        static method create takes unit source returns thistype
            local thistype this
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif
            
            set this.source = source
            set this.boneArmorUnits = CreateGroup()
            set this.pid = GetPlayerId(GetOwningPlayer(this.source))
            //call BJDebugMsg(I2S(this.pid) + " ba start")

            call this.refreshGroup()

            set this.enabled = true
            set this.tick = T32_Tick + 32
            set this.endTick = T32_Tick + R2I(60 * 32)   
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.enabled = false
            set BoneArmorTable[GetHandleId(this.source)] = 0
            set this.source = null
            call DestroyGroup(this.boneArmorUnits)
            set this.boneArmorUnits = null
            set this.groupSize = 0
            //call BJDebugMsg("ba end")
            set recycleNext = recycle
            set recycle = this
        endmethod
    
        implement T32x
    endstruct

    function StartBoneArmor takes unit caster returns nothing
        local integer hid = GetHandleId(caster)
        if GetBoneArmorStruct(hid).enabled == false then
            set BoneArmorTable[hid] = BoneArmorStruct.create(caster)
        elseif GetBoneArmorStruct(hid).enabled then
            //call BJDebugMsg("ba dur update")
            set GetBoneArmorStruct(hid).endTick = T32_Tick + R2I(60 * 32)
        endif
    endfunction

    private function init takes nothing returns nothing
        set BoneArmorTable = Table.create()
    endfunction
endlibrary