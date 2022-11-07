library DebuffTypes

    //Remove all positive buffs from unit u
    function PositiveBuffs takes unit u returns nothing
        call UnitRemoveAbility(u, INVULNERABLE_BUFF_ID)
        call UnitRemoveAbility(u, ANTI_MAGIC_SHELL_BUFF_ID)
        call UnitRemoveAbility(u, AVATAR_BUFF_ID)
        call UnitRemoveAbility(u, BATTLE_ROAR_BUFF_ID)
        call UnitRemoveAbility(u, BERSERK_BUFF_ID)
        call UnitRemoveAbility(u, FROST_ARMOR_BUFF_ID)
        call UnitRemoveAbility(u, INNER_FIRE_BUFF_ID)
        call UnitRemoveAbility(u, LIGHTNING_SHIELD_BUFF_ID)
        call UnitRemoveAbility(u, REJUVENATION_BUFF_ID)
        call UnitRemoveAbility(u, SCROLL_OF_PROTECTION_BUFF_ID)
        call UnitRemoveAbility(u, SENSATUS_SHIELD_OF_HONOR_BUFF_ID)
        call UnitRemoveAbility(u, SPIRIT_LINK_BUFF_ID)
        call UnitRemoveAbility(u, 'A09H')
        call UnitRemoveAbility(u, 'A09R')
        call UnitRemoveAbility(u, 'A09S')
        call UnitRemoveAbility(u, EXTRADIMENSIONAL_COOPERATION_BUFF_ID)
        call UnitRemoveAbility(u, LUCKY_PANTS_BUFF_ID)
        call UnitRemoveAbility(u, MANA_STARVATION_BUFF_ID)
        call UnitRemoveAbility(u, WISDOM_CHESTPLATE_BUFF_ID)
        call UnitRemoveAbility(u, 'A08G')
        call UnitRemoveAbility(u, CHEATER_MAGIC_BUFF_ID)
        call UnitRemoveAbility(u, HERO_BUFF_ID)
        call UnitRemoveAbility(u, SPEED_BLADE_BUFF_ID)
        call UnitRemoveAbility(u, 'A0CI')
        call UnitRemoveAbility(u, CONTRACT_LIVING_BUFF_ID)
    endfunction

    //Remove all negative buffs from unit u
    function NegativeBuffs takes unit u returns nothing
        call UnitRemoveAbility(u, CLOUD_BUFF_ID)
        call UnitRemoveAbility(u, POLYMORPH_BUFF_ID)
        call UnitRemoveAbility(u, SLOW_BUFF_ID)
        call UnitRemoveAbility(u, BLIZZARD_BUFF_ID)
        call UnitRemoveAbility(u, FLAME_STRIKE_BUFF_ID)
        call UnitRemoveAbility(u, BANISH_BUFF_ID)
        call UnitRemoveAbility(u, BURNING_OIL_BUFF_ID)
        call UnitRemoveAbility(u, LIQUID_FIRE_BUFF_ID)
        call UnitRemoveAbility(u, ENSNARE_GENERAL_BUFF_ID)
        call UnitRemoveAbility(u, HEX_BUFF_ID)
        call UnitRemoveAbility(u, EARTHQUAKE_BUFF_ID)
        call UnitRemoveAbility(u, CRIPPLE_BUFF_ID)
        call UnitRemoveAbility(u, WEB_GROUND_BUFF_ID)
        call UnitRemoveAbility(u, WEB_AIR_BUFF_ID)
        call UnitRemoveAbility(u, DISEASE_BUFF_ID)
        call UnitRemoveAbility(u, SLEEP_BUFF_ID)
        call UnitRemoveAbility(u, DEATH_AND_DECAY_BUFF_ID)
        call UnitRemoveAbility(u, SLOW_POISON_STACKING_BUFF_ID)
        call UnitRemoveAbility(u, SLOW_POISON_NON_STACKING_BUFF_ID)
        call UnitRemoveAbility(u, CORROSIZE_BREATH_BUFF_ID)
        call UnitRemoveAbility(u, FAERIE_FIRE_BUFF_ID)
        call UnitRemoveAbility(u, ENTANGLING_ROOTS_BUFF_ID)
        call UnitRemoveAbility(u, SHADOW_STRIKE_BUFF_ID)
        call UnitRemoveAbility(u, POISON_STACKING_BUFF_ID)
        call UnitRemoveAbility(u, POISON_NON_STACKING_BUFF_ID)
        call UnitRemoveAbility(u, BLACK_ARROW_BUFF_ID)
        call UnitRemoveAbility(u, DRUNKEN_HAZE_BUFF_ID)
        call UnitRemoveAbility(u, HOWL_OF_TERROR_BUFF_ID)
        call UnitRemoveAbility(u, TORNADO_SLOW_AURA_BUFF_ID)
        call UnitRemoveAbility(u, DOOM_BUFF_ID)
        call UnitRemoveAbility(u, BREATH_OF_FIRE_BUFF_ID)
        call UnitRemoveAbility(u, RAIN_OF_FIRE_BUFF_ID)
        call UnitRemoveAbility(u, STUNNED_BUFF_ID)
        call UnitRemoveAbility(u, PARASITE_MINION_BUFF_ID)
        // call UnitRemoveAbility(u, 'BPpa') Does not exist
        call UnitRemoveAbility(u, RAIN_OF_FIRE_BUFF_ID)
        call UnitRemoveAbility(u, STUNNED_PAUSE_BUFF_ID)
        call UnitRemoveAbility(u, SILENCE_BUFF_ID)
        call UnitRemoveAbility(u, COLD_ARROWS_STACKING_BUFF_ID)
        call UnitRemoveAbility(u, COLD_ARROWS_NON_STACKING_BUFF_ID)
        call UnitRemoveAbility(u, HOWL_OF_TERROR_BUFF_ID)
        call UnitRemoveAbility(u, BREATH_OF_FROST_BUFF_ID)
        call UnitRemoveAbility(u, SLOWED_BUFF_ID)
        call UnitRemoveAbility(u, 'Blcb')
        call UnitRemoveAbility(u, SOUL_BURN_BUFF_ID)
        call UnitRemoveAbility(u, ACID_BOMB_BUFF_ID)
        call UnitRemoveAbility(u, INCINERATE_BUFF_ID)
        call UnitRemoveAbility(u, STUNNED_CUSTOM_BUFF_ID)
        call UnitRemoveAbility(u, FEAR_AURA_BUFF_ID)
        call UnitRemoveAbility(u, SLOW_AURA_BUFF_ID)
        call UnitRemoveAbility(u, WHIRLWIND_BUFF_ID)
        call UnitRemoveAbility(u, THE_CURSE_OF_DEMONS_BUFF_ID)
        call UnitRemoveAbility(u, IMMOBILITY_BUFF_ID)
        call UnitRemoveAbility(u, 'A06L')
        call UnitRemoveAbility(u, 'A06P')
        call UnitRemoveAbility(u, 'A06R')
        call UnitRemoveAbility(u, INCINERATE_CUSTOM_BUFF_ID)
        call UnitRemoveAbility(u, POISON_NON_STACKING_CUSTOM_BUFF_ID)
        call UnitRemoveAbility(u, LIQUID_FIRE_CUSTOM_BUFF_ID)
        call UnitRemoveAbility(u, DISEASE_CLOUD_BUFF_ID)
        call UnitRemoveAbility(u, ENSNARE_AIR_BUFF_ID)
        call UnitRemoveAbility(u, ENSNARE_GROUND_BUFF_ID)
        call UnitRemoveAbility(u, THUNDER_CLAP_BUFF_ID)
        call UnitRemoveAbility(u, UNHOLY_FRENZY_BUFF_ID)
        call UnitRemoveAbility(u, BLEED_BUFF_ID)
        call UnitRemoveAbility(u, NULL_VOID_ORB_BUFF_ID)
        call UnitRemoveAbility(u, ANCIENT_KNIFE_OF_THE_GODS_BUFF_ID)
        call UnitRemoveAbility(u, FLIMSY_TOKEN_BUFF_ID)
        call UnitRemoveAbility(u, SPELLBANE_TOKEN_BUFF_ID)
        call UnitRemoveAbility(u, VIGOUR_TOKEN_BUFF_ID)
        call UnitRemoveAbility(u, BLOODSTONE_BUFF_ID)
        call UnitRemoveAbility(u, DOUSING_HEX_BUFF_ID)
        call UnitRemoveAbility(u, MANA_STARVATION_NERF_BUFF_ID)
        call UnitRemoveAbility(u, MIDAS_TOUCH_BUFF_ID)
        call UnitRemoveAbility(u, 'A09B')
        call UnitRemoveAbility(u, 'A08O')
        call UnitRemoveAbility(u, 'A03V')
        call UnitRemoveAbility(u, CONTRACT_LIVING_BUFF_ID)
        call UnitRemoveAbility(u, FAN_OF_KNIVES_BUFF_ID)
    endfunction

    //Remove all buffs of buffType from unit u
    //0 = all, 1 = negative, 2 = positive
    function RemoveDebuff takes unit u, integer buffType returns nothing
        if buffType == 0 or buffType == 1 then
            call NegativeBuffs(u)
        endif

        if buffType == 0 or buffType == 2 then
            call PositiveBuffs(u)
        endif
    endfunction
endlibrary
