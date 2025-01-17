library LavaSpawn requires CustomState, SpellFormula
    function LavaSpawnStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + GetSpellValue(0, 8, abilityLevel) + (summonLevel * 100), 0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (8 / (10.1 + (totalLevel / 2))), 0)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + totalLevel * 800)
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 5 * totalLevel)

        call UnitAddAbility(u, 'A0C8')
        call SetUnitAbilityLevel(u, 'A0C8', IMinBJ(R2I(totalLevel / 3), 60))

        call UnitAddAbility(u, LAST_BREATHS_ABILITY_ID)
        call SetUnitAbilityLevel(u, LAST_BREATHS_ABILITY_ID, abilityLevel)
    endfunction
endlibrary