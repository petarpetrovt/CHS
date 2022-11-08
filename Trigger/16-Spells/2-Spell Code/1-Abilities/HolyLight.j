library HolyLight requires SpellFormula
    function CastHolyLight takes unit caster, unit target, integer level returns nothing
        local real value = GetSpellValue(200, 100, level)

        call DestroyEffect(AddLocalizedSpecialEffect("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", GetUnitX(target), GetUnitY(target)))
        if IsUnitEnemy(target, GetOwningPlayer(caster)) then
            set udg_NextDamageAbilitySource = HOLY_LIGHT_ABILITY_ID
            call Damage.applyMagic(caster, target, value * 0.5, DAMAGE_TYPE_MAGIC)
        else
            call SetUnitState(target, UNIT_STATE_LIFE, GetUnitState(target, UNIT_STATE_LIFE) + value)
        endif
    endfunction
endlibrary