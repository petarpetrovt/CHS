//! import "C:\CHS\CHS\Trigger\01-External Libraries\4-NewTable.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\Alloc.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\BigNum.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\Command.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\DamageEngine.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\DamageEngineConfig.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\DelayedPrinter.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\ErrorMessage.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\FileIO.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\GroupUtils.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\ListT.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\Math.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\MathRound.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\NewBonus.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\PlayerUtils.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\RecycleUnit.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\StaticQueue.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\StringFunctions.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\StringHashEx.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\T32.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\Terrain_Pathability.j"
//! import "C:\CHS\CHS\Trigger\01-External Libraries\TimerUtils.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\1-RandomShit.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\2-Multicast.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\7-PhoenixProccCheck.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\AbilityModifiers.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\AllowCasting.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\AreaDamage.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\CastSpellOnTarget.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\Debugabilities.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\DelayedBuffRemoval.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\DummySpellCasts.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\EditAbilityInfo.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\EventHelpers.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\FixUnits.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\ForceHelper.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\Generic.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\HeroAbilityTable.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\HeroForms.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\HpRegen.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\KnockbackHelper.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\LastSpellLearned.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\NewAbilityCooldown.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\PeriodicDamage.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\PlayerSummonGroups.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\RemoveBuffs.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\SellItem.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\TextTag.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\UnitFilteringUtility.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\UnitHelpers.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\UnitItems.j"
//! import "C:\CHS\CHS\Trigger\04-Helpers\Utility.j"
//! import "C:\CHS\CHS\Trigger\06-UI\AchievementsFrame.j"
//! import "C:\CHS\CHS\Trigger\06-UI\DiscordFrame.j"
//! import "C:\CHS\CHS\Trigger\06-UI\IconFrames.j"
//! import "C:\CHS\CHS\Trigger\06-UI\ReadyButton.j"
//! import "C:\CHS\CHS\Trigger\06-UI\RewardsScreen.j"
//! import "C:\CHS\CHS\Trigger\06-UI\TooltipFrame.j"
//! import "C:\CHS\CHS\Trigger\06-UI\UnitInfoPanel.j"
//! import "C:\CHS\CHS\Trigger\06-UI\XpBonusFrame.j"
//! import "C:\CHS\CHS\Trigger\09-Items\1-Full Restore.j"
//! import "C:\CHS\CHS\Trigger\09-Items\1-Urn.j"
//! import "C:\CHS\CHS\Trigger\09-Items\Ancient Axe.j"
//! import "C:\CHS\CHS\Trigger\09-Items\Ancient Dagger.j"
//! import "C:\CHS\CHS\Trigger\09-Items\Ancient Staff.j"
//! import "C:\CHS\CHS\Trigger\09-Items\AntiMagicFlag.j"
//! import "C:\CHS\CHS\Trigger\09-Items\ArcaneAbsorptionGauntlets.j"
//! import "C:\CHS\CHS\Trigger\09-Items\ArcaneInfusedSword.j"
//! import "C:\CHS\CHS\Trigger\09-Items\ArenaRing.j"
//! import "C:\CHS\CHS\Trigger\09-Items\ArmorOfAncestors.j"
//! import "C:\CHS\CHS\Trigger\09-Items\BattleRunestone and ArcaneGemstone.j"
//! import "C:\CHS\CHS\Trigger\09-Items\BlokkadesShield.j"
//! import "C:\CHS\CHS\Trigger\09-Items\BoneArmor.j"
//! import "C:\CHS\CHS\Trigger\09-Items\BookOfNecromancy.j"
//! import "C:\CHS\CHS\Trigger\09-Items\ChestOfGreed.j"
//! import "C:\CHS\CHS\Trigger\09-Items\ConqBambooStick.j"
//! import "C:\CHS\CHS\Trigger\09-Items\ContractOfTheLiving.j"
//! import "C:\CHS\CHS\Trigger\09-Items\DecayingScythe.j"
//! import "C:\CHS\CHS\Trigger\09-Items\DivineSource.j"
//! import "C:\CHS\CHS\Trigger\09-Items\DriedMushroom.j"
//! import "C:\CHS\CHS\Trigger\09-Items\DruidicFocus.j"
//! import "C:\CHS\CHS\Trigger\09-Items\ElementalOrb.j"
//! import "C:\CHS\CHS\Trigger\09-Items\Fan.j"
//! import "C:\CHS\CHS\Trigger\09-Items\FishingRod.j"
//! import "C:\CHS\CHS\Trigger\09-Items\FlimsyToken.j"
//! import "C:\CHS\CHS\Trigger\09-Items\GobletOfBlood.j"
//! import "C:\CHS\CHS\Trigger\09-Items\HolyShield.j"
//! import "C:\CHS\CHS\Trigger\09-Items\Lucky Pants.j"
//! import "C:\CHS\CHS\Trigger\09-Items\MagicNecklace.j"
//! import "C:\CHS\CHS\Trigger\09-Items\ManifoldStaff.j"
//! import "C:\CHS\CHS\Trigger\09-Items\MaskOfProtection.j"
//! import "C:\CHS\CHS\Trigger\09-Items\MaskOfVitality.j"
//! import "C:\CHS\CHS\Trigger\09-Items\MithrilHelmet.j"
//! import "C:\CHS\CHS\Trigger\09-Items\Moonstone.j"
//! import "C:\CHS\CHS\Trigger\09-Items\MysteriousRunestone.j"
//! import "C:\CHS\CHS\Trigger\09-Items\Non-Lucrative Tome.j"
//! import "C:\CHS\CHS\Trigger\09-Items\Packing Tape.j"
//! import "C:\CHS\CHS\Trigger\09-Items\Rune Mastery.j"
//! import "C:\CHS\CHS\Trigger\09-Items\ScepterOfConfusion.j"
//! import "C:\CHS\CHS\Trigger\09-Items\Scroll Of Transformation.j"
//! import "C:\CHS\CHS\Trigger\09-Items\Shadow blade.j"
//! import "C:\CHS\CHS\Trigger\09-Items\ShiningRunestone.j"
//! import "C:\CHS\CHS\Trigger\09-Items\SpellbaneToken.j"
//! import "C:\CHS\CHS\Trigger\09-Items\Staff of Lightning.j"
//! import "C:\CHS\CHS\Trigger\09-Items\Staff Of Power.j"
//! import "C:\CHS\CHS\Trigger\09-Items\Strong Chestmail.j"
//! import "C:\CHS\CHS\Trigger\09-Items\TerrestrialGlaive.j"
//! import "C:\CHS\CHS\Trigger\09-Items\VigourToken.j"
//! import "C:\CHS\CHS\Trigger\09-Items\VolcanicArmor.j"
//! import "C:\CHS\CHS\Trigger\09-Items\WisdomChestplate.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\07-InitHash.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\01-Generic\CustomGameEvent.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\01-Generic\RegionLeaveDetect.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\01-Generic\ReplaceTextLib.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\01-Generic\SelectedUnits.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\01-Generic\StructRecycleModule.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\02-Heroes\1-CustomState.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\02-Heroes\LevelUpStats.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\02-Heroes\TempElementBonus.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\02-Heroes\TempStateBonus.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\2-InitElements.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\AbilityCooldownBonusPerUse.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\AbilityDescription.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\BuffLevel.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\BuffRepository.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\DummyActiveSpell.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\DummyId.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\DummyOrder.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\FilteredSpellList.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\FollowUnitTeleport.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\FxCooldown.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\GetRandomUnit.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\HideEffects.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\HitCooldown.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\Knockback.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\Lightning.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\SpellFormula.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\TempAbilSystem.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\03-Abilities\ToggleAbility.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\04-Items\EndOfRoundItem.j"
//! import "C:\CHS\CHS\Trigger\02-Game Libraries\04-Items\ShopIndex.j"
//! import "C:\CHS\CHS\Trigger\03-Data\01-Generic\13-InitData.j"
//! import "C:\CHS\CHS\Trigger\03-Data\01-Generic\3-Quest.j"
//! import "C:\CHS\CHS\Trigger\03-Data\01-Generic\ElementColorCode.j"
//! import "C:\CHS\CHS\Trigger\03-Data\01-Generic\GetPlayerNames.j"
//! import "C:\CHS\CHS\Trigger\03-Data\01-Generic\IconUtility.j"
//! import "C:\CHS\CHS\Trigger\03-Data\01-Generic\IdLibrary.j"
//! import "C:\CHS\CHS\Trigger\03-Data\01-Generic\OrderIds.j"
//! import "C:\CHS\CHS\Trigger\03-Data\02-Heroes\HeroLvlTable.j"
//! import "C:\CHS\CHS\Trigger\03-Data\02-Heroes\HeroPassiveDesc.j"
//! import "C:\CHS\CHS\Trigger\03-Data\03-Abilities\1-AbilityData.j"
//! import "C:\CHS\CHS\Trigger\03-Data\03-Abilities\AbsoluteLimit.j"
//! import "C:\CHS\CHS\Trigger\03-Data\03-Abilities\Absolutes.j"
//! import "C:\CHS\CHS\Trigger\03-Data\03-Abilities\BuffRepositoryData.j"
//! import "C:\CHS\CHS\Trigger\03-Data\03-Abilities\ChronusSpells.j"
//! import "C:\CHS\CHS\Trigger\03-Data\03-Abilities\DamageOverTimeSpells.j"
//! import "C:\CHS\CHS\Trigger\03-Data\03-Abilities\StableSpells.j"
//! import "C:\CHS\CHS\Trigger\03-Data\03-Abilities\SummonInfo.j"
//! import "C:\CHS\CHS\Trigger\03-Data\03-Abilities\ToggleSpellList.j"
//! import "C:\CHS\CHS\Trigger\03-Data\04-Items\GloryItemCosts.j"
//! import "C:\CHS\CHS\Trigger\03-Data\04-Items\ItemAbilityCooldown.j"
//! import "C:\CHS\CHS\Trigger\03-Data\04-Items\ReplaceItem.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Abilities\04-Cooldown.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Abilities\6-AbsoluteAbilityLevelup.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Abilities\AbilityCommand.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Abilities\AbilityCooldown.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\CameraCommand.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\ClearCommand.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\DebugCommand.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\DebugCommands.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\DisableBets.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\DiscordAdCommand.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\Hints.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\LoadCommand.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\ModeCommand.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\NoCamMovement.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\NoIncomeText.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\PlaytimeCommand.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\SantaHat.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\SaveCommand.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\ShowDamageTextCommand.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\ShowLifestealTextCommand.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\SpacebarCamera.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\ToggleFxCommand.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Commands\Votekick.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Heroes\15-HeroLvl.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Heroes\PetFollow.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Items\1-ItemBonus.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Items\1-Toms.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Items\CreepAntagonisation.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Unsorted\1-StartFunction.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Unsorted\5-Functions.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Unsorted\UnitEnterMap.j"
//! import "C:\CHS\CHS\Trigger\06-UI\22-HeroSelector\BanningPhase.j"
//! import "C:\CHS\CHS\Trigger\06-UI\22-HeroSelector\CameraStart.j"
//! import "C:\CHS\CHS\Trigger\06-UI\22-HeroSelector\FrameLoader.j"
//! import "C:\CHS\CHS\Trigger\06-UI\22-HeroSelector\HeroInfo.j"
//! import "C:\CHS\CHS\Trigger\06-UI\22-HeroSelector\HeroSelector.j"
//! import "C:\CHS\CHS\Trigger\06-UI\22-HeroSelector\HeroSelectorAction.j"
//! import "C:\CHS\CHS\Trigger\06-UI\22-HeroSelector\PickingPhase.j"
//! import "C:\CHS\CHS\Trigger\06-UI\BattleCreator\BattleCreator.j"
//! import "C:\CHS\CHS\Trigger\06-UI\BattleCreator\BattleCreatorManager.j"
//! import "C:\CHS\CHS\Trigger\06-UI\Scoreboard\Scoreboard.j"
//! import "C:\CHS\CHS\Trigger\06-UI\Scoreboard\ScoreboardManager.j"
//! import "C:\CHS\CHS\Trigger\06-UI\Voting\VotingResults.j"
//! import "C:\CHS\CHS\Trigger\06-UI\Voting\VotingScreen.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\1-Lich\1-Event lich.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Abomination.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Blademaster.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Cold Knight.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\CryptLord.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Dark Avatar.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\DoomGuard.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Dreadlord.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Gnome.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Letinant.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Murloc.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Mystic.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\NagaSiren.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Pitlord.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Pyromancer.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\SkeletonBrute.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Sorcerer.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\SpiritTauren.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Thunder Witch.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Tinker.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\TrollBerserker.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\UrsaWarrior.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Witch Doctor.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\WolfRider.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Xesil.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Secrets\PandaSkin.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Secrets\RobotGoblin.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Secrets\SecretCheck.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Absolutes\AbsoluteArcane.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Absolutes\AbsoluteCold.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Absolutes\AbsoluteDark.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Absolutes\AbsolutePoison.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\04-Whirlwind.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\06-Frost Bolt.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\08-Sand Of Time.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\09-Purge.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Avatar.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\BattleRoar.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Blink Strike.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\BlockDestruction.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\CarrionSwarm.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\ContemporaryRunes.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Cyclone.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\DarkSeal.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Death Pact.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\DeathAndDecay.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Dousing Hex.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Drunken Haze.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Energy Lure.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\EnergyBombardment.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Eruption.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Extradimensional Cooperation.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\FanOfKnives.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Fog.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\HolyLight.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Inner Fire.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Lightning Shield.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Mana Starvation.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\MidasTouch.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Parasite.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Plague.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\Shockwave.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Active\SpiritLink.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Chronus Abilities\BlessedProtection.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Chronus Abilities\CheaterMagic.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Chronus Abilities\Grunts Grunt.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Chronus Abilities\HeroBuff.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Chronus Abilities\HolyEnlightenment.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Chronus Abilities\TempInvis.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Chronus Abilities\TempPower.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\General\1-ElementStartAbility.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\General\1-Multicast.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\General\ChronusSpellCast.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\General\OnSpellCast.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\General\Spell Effects.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\01-Stone Protection.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\02-Ancient Teaching.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\03-Reset Time.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\07-Martial Retribution.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\11-Last Breath.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\Ancient Blood.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\Ancient Element.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\Ancient Runes.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\Arcane Assault.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\Arcane Strike.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\Black Arrow.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\Chaos Magic.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\ColdWind.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\DivineBubble.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\DrainAura.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\EnergyShield.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\Learnability.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\MartialTheft.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\MegaSpeed.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\MysteriousTalent.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\NecromancerArmy.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\PowerOfWater.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\RetaliationAura.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\ShadowStep.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Passive\TimeManipulation.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\Bear.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\Black Arrow Melee Skeleton.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\Black Arrow Ranged Skeleton.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\Carrion Beetle.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\ClockwerkGoblin.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\FaerieDragon.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\FearlessDefenders.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\Hawk.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\Inferno.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\LavaSpawn.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\Locust.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\MountainGiant.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\Parasite.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\Phoenix.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\PocketFactory.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\Quilbeast.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\SerpentWard.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\Skeleton.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\SpiritWolf.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Summons\WaterElemental.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Toggle\ColdArrow.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Toggle\Immolation.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Toggle\Magnetic Oscillation.j"
//! import "C:\CHS\CHS\Trigger\08-Abilities\Toggle\Searing Arrows.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\6-InitRune.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\StatRuneBonus.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\GameInit.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\2-Damage System\0. CustomDamageTypes.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\2-Damage System\0. DamageEngineGlobals.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\2-Damage System\0. DamageEngineHelpers.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\2-Damage System\1. OnDamage.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\2-Damage System\2. ModifyDamageBeforeArmor.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\2-Damage System\2.a Crit.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\2-Damage System\2.b Evasion.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\2-Damage System\3. ModifyDamageAfterArmor.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\2-Damage System\4. LethalDamage.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\2-Damage System\5. AfterDamage.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\21-SaveCode\DebugCode.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\21-SaveCode\LoadSaveCommon.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\21-SaveCode\PlayerTracking.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\21-SaveCode\SaveCore.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\21-SaveCode\SaveFile.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\21-SaveCode\SaveHelperLib.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\21-SaveCode\SaveSystem.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\21-SaveCode\SyncHelper.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Draft Mode\DisabledSpells.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Draft Mode\EconomicSpellIndex.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Draft Mode\Functions.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Draft Mode\OnDraftBuy.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Unsorted\06-FixUnit.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Unsorted\1-AttackController.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Unsorted\1-VampirsmController.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Unsorted\2-ShortPeriodCheck.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Unsorted\3-LongPeriodCheck.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Unsorted\4-Killing.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Unsorted\AttackCooldown.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Unsorted\CreepDeath.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Unsorted\GetObjectElement.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Unsorted\Glory.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Unsorted\Hotkeys.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Unsorted\PvpSuddenDeath.j"
//! import "C:\CHS\CHS\Trigger\05-Game Functions\Mechanics\Unsorted\SuddenDeathTimerWindow.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Followers\FaerieDragonDies.j"
//! import "C:\CHS\CHS\Trigger\07-Heroes\Passives\Followers\WispActions.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\01-RuneOfAttack.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\02-RuneOfEarth.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\03-RuneOfPower.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\04-RuneOfHealing.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\05-RuneOfLife.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\06-RuneOfMagic.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\07-RuneOfFire.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\08-RuneOfChaos.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\09-RuneOfStorm.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\10-RuneOfAir.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\BloodRune.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\ColdRune.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\DarkRune.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\LightRune.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\PoisonRune.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\RuneOfMight.j"
//! import "C:\CHS\CHS\Trigger\09-Items\18-Rune\5-RuneItem\WildRune.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Dialog\Death\DeathDialogInitialization.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Dialog\Death\DeathDialogLeave.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Dialog\Placing Bets\CancelBetting.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Dialog\Placing Bets\DistributeBets.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Dialog\Placing Bets\InitializeBettingDialogs.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Dialog\Placing Bets\PlaceGoldBet.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Dialog\Placing Bets\PlacePercentageBet.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Dialog\Placing Bets\ResourceBettingMenus.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Dialog\Placing Bets\Team1Betting.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Dialog\Placing Bets\Team2Betting.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Abilities\DisableAbilities.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Creeps\CreepAutoCast.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Creeps\CreepDies.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Creeps\CreepPeriodicAttack.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Creeps\CreepPowerAndHp.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Creeps\CreepTypes.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Creeps\GenerateNextCreepLevel.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Creeps\ModifyCreepAbilities.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Endgame\AllPlayersDead.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Endgame\EndGame.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Endgame\IsGameFinished.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Endgame\PlayerLeavesGame.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\General\CenterArenaInvulnerability.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\General\CenterArenaRemoveUnit.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\General\HideShops.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\General\UnhideShops.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Heroes\HeroRefresh.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Initialization\AbilityUpgradeShop.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Initialization\EnterShopMode.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Initialization\InitializeDraftMode.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Initialization\PlayerInitialization.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Initialization\SetHostPlayer.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Initialization\SetupPlayerArenas.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Items\ItemOwnership.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Items\UpdateItems.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Dialog\Game Mode Selection\After Selection\GameModeQuestSetup.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Dialog\Game Mode Selection\Initialization\DialogInitialization.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Dialog\Game Mode Selection\Initialization\EveryoneVotes.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Dialog\Game Mode Selection\Initialization\HostSelectsMode.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Dialog\Game Mode Selection\Initialization\VotingRightsDialog.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Abilities\Learn and Unlearn\LearnAbility.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Abilities\Learn and Unlearn\LearnRandomAbility.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Abilities\Learn and Unlearn\TryLearnRandomAbility.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Abilities\Learn and Unlearn\UnlearnAbility.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Heroes\Death\HeroDiesInRound.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Heroes\Death\PandarenDeathSounds.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Heroes\Death\PandarenDies.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Heroes\Death\PetDeath.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Heroes\Death\PlayerHeroDeath.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Heroes\Hero Selection\PlayerHeroSelected.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Heroes\Hero Selection\PlayerLeavesGameBeforeHeroSelection.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\PVP\Battle Royal\BattleRoyaleHelper.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\PVP\Battle Royal\PlayerDiesInBattleRoyale.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\PVP\Battle Royal\PlayerShadeDeath.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\PVP\Duels\ComputerPvpEnforceDuel.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\PVP\Duels\DuelWinnerRewards.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\PVP\Duels\InitializePvp.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\PVP\Duels\PvpHelper.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\PVP\Duels\PvpHeroDeath.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\PVP\Duels\PvpRoundRobin.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Rounds\General\PlayerAntiStuck.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Rounds\General\SuddenDeathCreepTimer.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Rounds\Round End\AllPlayersCompletedRound.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Rounds\Round End\BonusExp.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Rounds\Round End\EconomyCreepBonus.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Rounds\Round End\PlayerCompleteRound.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Rounds\Round End\PlayerCompleteRoundMove.j"
//! import "C:\CHS\CHS\Trigger\15-triggers\init-parsed\Mechanics\Rounds\Round Start\StartLevel.j"
