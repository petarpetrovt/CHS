scope Killing initializer init    
    function TimerMagDmg takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = LoadUnitHandle(HT,GetHandleId(t),1)

        call AddUnitMagicDmg(u,- 15 * LoadInteger(HT,GetHandleId(t),2))


        call FlushChildHashtable(HT,GetHandleId(t))
        call ReleaseTimer(t)

        set t = null
        set u = null
    endfunction

    function Trig_Killing_Actions takes nothing returns nothing
        local unit target = GetTriggerUnit()
        local integer targetId = GetHandleId(target)
        local unit killer = GetKillingUnit()
        local player targetPlayer = GetOwningPlayer(target)
        local player killingPlayer = GetOwningPlayer(killer)
        local integer targetPid = GetPlayerId(targetPlayer)
        local integer killingPid = GetPlayerId(killingPlayer)
        local unit targetHero = udg_units01[targetPid + 1]
        local unit killingHero = udg_units01[killingPid + 1]
        local integer i = 0
        local timer t
        local effect fx

        if GetUnitAbilityLevel(target, 'Aloc') > 0 or GetUnitTypeId(target) == 'uplg' or (killingPlayer != Player(11) and HasPlayerFinishedLevel(killer, killingPlayer)) or (killingPlayer == Player(11) and HasPlayerFinishedLevel(target, targetPlayer)) then
            set target = null
            set killer = null
            set killingHero = null
            set targetHero = null
            set targetPlayer = null
            set killingPlayer = null
            return
        endif

        //Incinerate
        if LoadInteger(HT,GetHandleId(target),- 300004)+ 160 > T32_Tick then
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl", target, "head"))
            call AreaDamage(LoadUnitHandle(HT,targetId,- 300003),GetUnitX(target),GetUnitY(target),LoadInteger(HT,targetId,- 300002),300, true, 'B014')
        endif
        
        //Black Arrow
        set i = GetUnitAbilityLevel(killingHero, BLACK_ARROW_PASSIVE_ABILITY_ID)
        if i > 0 and killer != null and IsUnitEnemy(killer, targetPlayer) then
            call CastBlackArrow(killingHero, target, i)
        endif   

        if IsHeroUnitId(GetUnitTypeId(target)) == false then

            //Skeleton Brute
            if GetUnitTypeId(targetHero) == SKELETON_BRUTE_UNIT_ID then
                call SetUnitState(targetHero, UNIT_STATE_LIFE, GetUnitState(targetHero, UNIT_STATE_LIFE) + ( (0.02 + (0.0005 * GetHeroLevel(targetHero))) * BlzGetUnitMaxHP(targetHero)))
                call AreaDamage(targetHero, GetUnitX(target), GetUnitY(target), 20 + (30 * GetHeroLevel(targetHero)), 400, false, SKELETON_BRUTE_UNIT_ID)
                set fx = AddSpecialEffect("war3mapImported\\Arcane Explosion.mdx", GetUnitX(target), GetUnitY(target))
                call BlzSetSpecialEffectTimeScale(fx, 2)
                call DestroyEffect(fx)
                set fx = null
            endif

            //Necromancer's Army
            set i = GetUnitAbilityLevel(targetHero, 'A0B0')
            if i > 0 and IsUnitType(target, UNIT_TYPE_UNDEAD) == false then
                call ActivateNecromancerArmy(targetHero, target, i)
            endif

            //Strong Chest Mail
            set i = UnitHasItemI(killingHero,'I079') 
            if i > 0 and killer != null then
                call Vamp(killingHero, target, BlzGetUnitMaxHP(killingHero)* 0.1 * I2R(i))
                call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", killingHero, "chest"))      
            endif

            //Amulet of the Night
            set i = UnitHasItemI( killingHero,'I07E') 
            if i > 0 and GetOwningPlayer(target) == Player(11) then

                call AddUnitMagicDmg(killingHero,i * 15)

                set t = NewTimer()
                call SaveUnitHandle(HT,GetHandleId(t),1,killingHero)
                call SaveInteger(HT,GetHandleId(t),2,i)
                call TimerStart(t,10,false,function TimerMagDmg )
            endif

            //Not sure what this is for
            call FixUnit(GetTriggerUnit())
        endif
        set t = null
        set target = null
        set killer = null
        set killingHero = null
        set targetHero = null
        set targetPlayer = null
        set killingPlayer = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_DEATH )
        call TriggerAddAction( trg, function Trig_Killing_Actions )
        set trg = null
    endfunction
endscope