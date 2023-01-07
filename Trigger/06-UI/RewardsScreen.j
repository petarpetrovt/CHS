library RewardsScreen initializer init requires PlayerTracking, IconFrames

    globals
        // Rewards static titles
        private constant string REWARDS_DESCRIPTION                     = "|cfffbff00After each normal round, your hero will permanently gain the selected stats above|r"
        private constant string REWARDS_TITLE                           = "|cff2ff1ffChoose your rewards!|r"

        // The X,Y coordinate for the top left of the main frame
        private constant real MAIN_FRAME_TOP_LEFT_X                     = 0.23
        private constant real MAIN_FRAME_TOP_LEFT_Y                     = 0.50
        private constant real MAIN_FRAME_X_MARGIN                       = 0.03
        private constant real MAIN_FRAME_Y_TOP_MARGIN                   = 0.03
        private constant real MAIN_FRAME_Y_BOTTOM_MARGIN                = 0.025
        private constant real TITLE_HEIGHT                              = 0.03

        // Specifications for a icon
        private constant real ICON_WIDTH                                = 0.032
        private constant real ICON_SPACING                              = 0.014
        private constant real CATEGORY_SPACING                          = 0.03

        // Specifications for a button
        private real BUTTON_WIDTH                                       = 0.116
        private real BUTTON_HEIGHT                                      = 0.035
        private real BUTTON_SPACER                                      = 0.01
        private real DESCRIPTION_SPACER                                 = 0.01
        private real AVAILABLE_POINTS_SPACER                            = 0.02

        // Specifications for a player name text
        private constant real TEXT_HEIGHT                               = 0.018
        private constant real DESCRIPTION_HEIGHT                        = 0.036
        private constant real AVAILABLE_POINTS_HEIGHT                   = 0.018

        // Column indexes
        private constant integer REWARD_BUFFER                          = 20 // Used to store all player selections in a single array. Just needs to be at least the reward count
        private constant integer OFFENSIVE_ATTACK_DAMAGE_1_INDEX        = 0
        private constant integer OFFENSIVE_PHYSICAL_POWER_2_INDEX       = 1
        private constant integer OFFENSIVE_MAGIC_POWER_3_INDEX          = 2
        private constant integer OFFENSIVE_STAT_4_INDEX                 = 3
        private constant integer DEFENSIVE_ARMOR_1_INDEX                = 4
        private constant integer DEFENSIVE_MAGIC_PROTECTION_2_INDEX     = 5
        private constant integer DEFENSIVE_BLOCK_3_INDEX                = 6
        private constant integer DEFENSIVE_STAT_4_INDEX                 = 7
        private constant integer UTILITY_HIT_POINTS_1_INDEX             = 8
        private constant integer UTILITY_HIT_POINTS_REGEN_2_INDEX       = 9
        private constant integer UTILITY_MANA_3_INDEX                   = 10
        private constant integer UTILITY_MANA_REGEN_4_INDEX             = 11

        // Reward icons
        private constant string OFFENSIVE_ATTACK_DAMAGE_1_ICON          = "ReplaceableTextures\\CommandButtons\\BTNClawsOfAttack.blp"
        private constant string OFFENSIVE_PHYSICAL_POWER_2_ICON         = "ReplaceableTextures\\CommandButtons\\BTNDeathPact.blp"
        private constant string OFFENSIVE_MAGIC_POWER_3_ICON            = "ReplaceableTextures\\CommandButtons\\BTNControlMagic.blp"
        private constant string OFFENSIVE_STAT_4_ICON                   = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOff.blp"
        private constant string DEFENSIVE_ARMOR_1_ICON                  = "ReplaceableTextures\\CommandButtons\\BTNAdvancedMoonArmor.blp"
        private constant string DEFENSIVE_MAGIC_PROTECTION_2_ICON       = "ReplaceableTextures\\CommandButtons\\BTNMagicImmunity.blp"
        private constant string DEFENSIVE_BLOCK_3_ICON                  = "ReplaceableTextures\\CommandButtons\\BTNSpell_Holy_DevotionAura.blp"
        private constant string DEFENSIVE_STAT_4_ICON                   = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOff.blp"
        private constant string UTILITY_HIT_POINTS_1_ICON               = "ReplaceableTextures\\CommandButtons\\BTNAnkh.blp"
        private constant string UTILITY_HIT_POINTS_REGEN_2_ICON         = "ReplaceableTextures\\CommandButtons\\BTNScrollOfRegenerationGreen.blp"
        private constant string UTILITY_MANA_3_ICON                     = "ReplaceableTextures\\CommandButtons\\BTNPendantOfMana.blp"
        private constant string UTILITY_MANA_REGEN_4_ICON               = "ReplaceableTextures\\CommandButtons\\BTNManaStone.blp"

        // Reward values
        private constant real ATTACK_DAMAGE_BONUS                       = 5.0
        private constant real PHYSICAL_POWER_BONUS                      = 0.5
        private constant real MAGIC_POWER_BONUS                         = 0.5
        private constant real OFFENSIVE_STAT_BONUS                      = 0.
        private constant real ARMOR_BONUS                               = 5.0
        private constant real MAGIC_PROTECTION_BONUS                    = 0.5
        private constant real BLOCK_BONUS                               = 10.0
        private constant real DEFENSIVE_STAT_BONUS                      = 0.
        private constant real HIT_POINTS_BONUS                          = 750.0
        private constant real HIT_POINTS_REGEN_BONUS                    = 10.0
        private constant real MANA_BONUS                                = 150.0
        private constant real MANA_REGION_BONUS                         = 10.0

        // Colors
        private constant string COLOR_END_TAG                           = "|r"
        private constant string OFFENSIVE_COLOR                         = "|cffff2a2a"
        private constant string DEFENSIVE_COLOR                         = "|cff1eff00"
        private constant string UTILITY_COLOR                           = "|cff4f95ff"
        private constant string AVAILABLE_POINTS_COLOR                  = "|cfff825ff"
        private constant string CLICK_ICON_COLOR                        = "|cffffae00"

        private integer CurrentCategoryIndex                            = 0
        private integer CurrentIconIndex                                = 0
        private integer CurrentRowIndex                                 = 0

        // The only trigger that handles hovering over icons
        private trigger IconEventTrigger

        // Save relavant information for each framehandle
        private hashtable IconEventHandles
        
        // Tooltip information
        private framehandle RewardsTooltipFrame
		private framehandle RewardsTooltipTitleFrame
		private framehandle RewardsTooltipTextFrame
        private string array RewardTitles
        private string array RewardDescriptions

        // Framehandles that need to be referenced later
        private integer SubmitHandleId
        private integer ResetHandleId
        private framehandle AvailablePointsFrame
        private framehandle array RewardSelectionFramehandles
        private framehandle array RewardSelectionParentFramehandles

        // Save what the player has selected, how many points they have, and the accumulation of rewards
        private integer array PlayerRewardSelection
        private integer array PlayerRewardPoints
        private real array PlayerTotalRewardValues
        private real array RewardIndexValues
    endglobals

    // Add additional reward points to a player
    public function RewardPoints takes integer playerId, integer points returns nothing
        set PlayerRewardPoints[playerId] = PlayerRewardPoints[playerId] + points

        if (GetLocalPlayer() == Player(playerId)) then	
            call BlzFrameSetText(AvailablePointsFrame, AVAILABLE_POINTS_COLOR + "Available Points: " + COLOR_END_TAG + I2S(PlayerRewardPoints[playerId])) 
        endif
    endfunction

    private function GetTopLeftX takes nothing returns real
        local real value = MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN + (CurrentCategoryIndex * CATEGORY_SPACING) + (CurrentCategoryIndex * (2 * ICON_WIDTH)) + (CurrentCategoryIndex * ICON_SPACING)

        // First column of rewards
        if (CurrentIconIndex == 1 or CurrentIconIndex == 3) then
            return value + ICON_WIDTH + ICON_SPACING
        endif

        return value
    endfunction

    private function GetTopLeftY takes nothing returns real
        local real value = MAIN_FRAME_TOP_LEFT_Y - MAIN_FRAME_Y_TOP_MARGIN

        // Header row
        if (CurrentRowIndex == 0) then
            return value
        endif

        set value = value - TEXT_HEIGHT

        // Second row of rewards
        if (CurrentIconIndex == 2 or CurrentIconIndex == 3) then
            return value - ICON_WIDTH - ICON_SPACING
        endif

        // TODO Add functionality for multiple rows of reward groups?

        return value
    endfunction

    private function CreateRewardIcon takes string iconPath, integer rewardIndex returns nothing
        local framehandle submitButtonFrameHandle
        local framehandle buttonBackdropFrameHandle
        local framehandle buttonCountFrameHandle
        local framehandle buttonCountBackdropFrameHandle
        local integer buttonHandleId
        local integer backdropHandleId

        // Create the icons frames and save them for later
        set submitButtonFrameHandle = BlzCreateFrame("ScriptDialogButton", RewardsFrameHandle, 0, 0) 
        set buttonBackdropFrameHandle = BlzCreateFrameByType("BACKDROP", "Backdrop", submitButtonFrameHandle, "", 1)
        set buttonHandleId = GetHandleId(submitButtonFrameHandle)
        set backdropHandleId = GetHandleId(buttonBackdropFrameHandle)

        // Dimensions for the button
        call BlzFrameSetAbsPoint(submitButtonFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY()) 
        call BlzFrameSetAbsPoint(submitButtonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + ICON_WIDTH, GetTopLeftY() - ICON_WIDTH) 

        // Reward count for the button. Save the framehandle for later to easily update the value
        set buttonCountBackdropFrameHandle = BlzCreateFrame("TooltipText", RewardsFrameHandle, 0, 0)
        set buttonCountFrameHandle = BlzGetFrameByName("TooltipTextTitle", 0)
        call BlzFrameSetLevel(buttonCountBackdropFrameHandle, 2) // To have it appear above the button
        call BlzFrameSetText(buttonCountFrameHandle, "0")
        call BlzFrameSetPoint(buttonCountBackdropFrameHandle, FRAMEPOINT_TOPLEFT, submitButtonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, -0.01, 0.01)
        call BlzFrameSetSize(buttonCountBackdropFrameHandle, 0.02, 0.02)

        set RewardSelectionFramehandles[rewardIndex] = buttonCountFrameHandle
        set RewardSelectionParentFramehandles[rewardIndex] = buttonCountBackdropFrameHandle

        // Save the handle of this button to look it up later for mouse events
        call SaveInteger(IconEventHandles, buttonHandleId, 1, rewardIndex)

        // Register with the single trigger about hovering over the icon
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, submitButtonFrameHandle, FRAMEEVENT_MOUSE_ENTER)
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, submitButtonFrameHandle, FRAMEEVENT_MOUSE_LEAVE)
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, submitButtonFrameHandle, FRAMEEVENT_CONTROL_CLICK)
        
        // Apply the icon
        call BlzFrameSetVisible(submitButtonFrameHandle, true)
        call BlzFrameSetTexture(buttonBackdropFrameHandle, iconPath, 0, true) 
        call BlzFrameSetAllPoints(buttonBackdropFrameHandle, submitButtonFrameHandle) 

        // Cleanup
        set submitButtonFrameHandle = null
        set buttonBackdropFrameHandle = null
        set buttonCountFrameHandle = null
        set buttonCountBackdropFrameHandle = null
    endfunction

    private function CreateCategoryText takes string value returns nothing
        local framehandle playerNameTextFrameHandle = BlzCreateFrameByType("TEXT", "RewardsText", RewardsFrameHandle, "", 0) 

        call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY())
        call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + (ICON_WIDTH * 2) + (ICON_SPACING), GetTopLeftY() - TEXT_HEIGHT) 
        call BlzFrameSetEnable(playerNameTextFrameHandle, false) 
        call BlzFrameSetScale(playerNameTextFrameHandle, 1.5) 
        call BlzFrameSetTextAlignment(playerNameTextFrameHandle, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER) 
        call BlzFrameSetText(playerNameTextFrameHandle, value) 

        // Cleanup
        set playerNameTextFrameHandle = null
    endfunction

    private function GetOrUpdateCurrentRewardBonus takes integer playerId, integer rewardIndex, boolean updateTotal returns real
        local real rewardValue = (PlayerRewardSelection[(REWARD_BUFFER * playerId) + rewardIndex]) * RewardIndexValues[rewardIndex]

        if (updateTotal) then
            set PlayerTotalRewardValues[(REWARD_BUFFER * playerId) + rewardIndex] = PlayerTotalRewardValues[(REWARD_BUFFER * playerId) + rewardIndex] + rewardValue
        endif

        return rewardValue
    endfunction

    private function RewardsMouseEventActions takes nothing returns nothing
        local framehandle currentFrameHandle = BlzGetTriggerFrame()
        local player triggerPlayer = GetTriggerPlayer()
        local integer triggerPlayerId = GetPlayerId(triggerPlayer)
        local integer handleId = GetHandleId(currentFrameHandle)
        local integer rewardIndex = LoadInteger(IconEventHandles, handleId, 1)
        local real tooltipWidth = 0.32
        local string tooltipDescription
        local string tooltipName
        local integer playerRewardIndex = 0
        local integer rewardCount = 0

        if (BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK) then
            if (GetLocalPlayer() == triggerPlayer) then	
				call BlzFrameSetEnable(currentFrameHandle, false)
				call BlzFrameSetEnable(currentFrameHandle, true)
			endif

            // Submit
            if (handleId == SubmitHandleId) then
                if (GetLocalPlayer() == triggerPlayer) then	
                    call BlzFrameSetVisible(RewardsFrameHandle, false) 
                    call PlayerStats.forPlayer(triggerPlayer).setHasRewardsOpen(false)
                endif

            // Reset
            elseif (handleId == ResetHandleId) then
                loop
                    set rewardCount = rewardCount + PlayerRewardSelection[(REWARD_BUFFER * triggerPlayerId) + playerRewardIndex]
                    set PlayerRewardSelection[(REWARD_BUFFER * triggerPlayerId) + playerRewardIndex] = 0

                    if (RewardSelectionFramehandles[playerRewardIndex] != null and GetLocalPlayer() == triggerPlayer) then	
                        call BlzFrameSetText(RewardSelectionFramehandles[playerRewardIndex], "0") 
                        call BlzFrameSetSize(RewardSelectionParentFramehandles[playerRewardIndex], 0.02, 0.02)
                    endif

                    set playerRewardIndex = playerRewardIndex + 1
                    exitwhen playerRewardIndex == REWARD_BUFFER
                endloop
            
                set PlayerRewardPoints[triggerPlayerId] = PlayerRewardPoints[triggerPlayerId] + rewardCount

                if (GetLocalPlayer() == triggerPlayer) then	
                    call BlzFrameSetText(AvailablePointsFrame, AVAILABLE_POINTS_COLOR + "Available Points: " + COLOR_END_TAG + I2S(PlayerRewardPoints[triggerPlayerId])) 
                endif
            // Select reward
            elseif (PlayerRewardPoints[triggerPlayerId] > 0) then
                set PlayerRewardPoints[triggerPlayerId] = PlayerRewardPoints[triggerPlayerId] - 1
                set PlayerRewardSelection[(REWARD_BUFFER * triggerPlayerId) + rewardIndex] = PlayerRewardSelection[(REWARD_BUFFER * triggerPlayerId) + rewardIndex] + 1

                if (GetLocalPlayer() == triggerPlayer) then	
                    call BlzFrameSetText(RewardSelectionFramehandles[rewardIndex], I2S(PlayerRewardSelection[(REWARD_BUFFER * triggerPlayerId) + rewardIndex])) 
                    call BlzFrameSetText(AvailablePointsFrame, AVAILABLE_POINTS_COLOR + "Available Points: " + COLOR_END_TAG + I2S(PlayerRewardPoints[triggerPlayerId])) 

                    if (PlayerRewardSelection[(REWARD_BUFFER * triggerPlayerId) + rewardIndex] >= 10) then
                        call BlzFrameSetSize(RewardSelectionParentFramehandles[rewardIndex], 0.03, 0.02)
                    endif
                endif
            endif
            
        elseif (BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_ENTER) then
            // Retrieve the cached information
            set tooltipName = RewardTitles[rewardIndex]

            if (PlayerRewardPoints[triggerPlayerId] > 0) then
                set tooltipName = tooltipName + CLICK_ICON_COLOR + " - Click to redeem!" + COLOR_END_TAG
            endif

            // Show how much value per round you get for this value
            set tooltipDescription = RewardDescriptions[rewardIndex] + "|n|nCurrent round bonus accumulated: " + R2S(GetOrUpdateCurrentRewardBonus(triggerPlayerId, rewardIndex, false))

            // Show the total accumulated for this reward
            set tooltipDescription = tooltipDescription + "|n|nTotal bonus accumulated: " + R2S(PlayerTotalRewardValues[(REWARD_BUFFER * triggerPlayerId) + rewardIndex])

            if (GetLocalPlayer() == triggerPlayer) then	
                call BlzFrameSetText(RewardsTooltipTitleFrame, tooltipName)
                call BlzFrameSetText(RewardsTooltipTextFrame, tooltipDescription)
                call BlzFrameSetPoint(RewardsTooltipFrame, FRAMEPOINT_TOP, currentFrameHandle, FRAMEPOINT_BOTTOM, 0, 0)
                call BlzFrameSetSize(RewardsTooltipFrame, tooltipWidth, GetTooltipSize(tooltipDescription))
                call BlzFrameSetVisible(RewardsTooltipFrame, true)
            endif

        elseif (BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_LEAVE) then
            // Empty the text box
            if (GetLocalPlayer() == triggerPlayer) then	
                call BlzFrameSetText(RewardsTooltipTitleFrame, "")
                call BlzFrameSetText(RewardsTooltipTextFrame, "")
                call BlzFrameSetVisible(RewardsTooltipFrame, false)
            endif
        endif

        // Cleanup
        set currentFrameHandle = null
        set triggerPlayer = null
    endfunction

    private function FinalizeMainFrame takes nothing returns nothing
        local real mainFrameBottomRightX
        local real mainFrameBottomRightY
        local framehandle titleFrameHandle
        local framehandle submitButtonFrameHandle
        local framehandle resetButtonFrameHandle
        local framehandle descriptionTextFrameHandle

        // Compute the main rewards box
        // Width - Main frame margins, all categories and their widths
        set mainFrameBottomRightX = MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN + ((CurrentCategoryIndex - 1) * CATEGORY_SPACING) + (CurrentCategoryIndex * (2 * ICON_WIDTH)) + (CurrentCategoryIndex * ICON_SPACING) + MAIN_FRAME_X_MARGIN
        // Height - Main frame margins, category text and category icons and their spacings
        set mainFrameBottomRightY = MAIN_FRAME_TOP_LEFT_Y - MAIN_FRAME_Y_TOP_MARGIN - TEXT_HEIGHT - (2 * ICON_WIDTH) - (ICON_SPACING) - AVAILABLE_POINTS_SPACER - AVAILABLE_POINTS_HEIGHT - DESCRIPTION_SPACER - DESCRIPTION_HEIGHT - BUTTON_SPACER - BUTTON_HEIGHT - MAIN_FRAME_Y_BOTTOM_MARGIN

        // Set the frame for the backdrop of the entire rewards
        call BlzFrameSetAbsPoint(RewardsFrameHandle, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X, MAIN_FRAME_TOP_LEFT_Y) 
        call BlzFrameSetAbsPoint(RewardsFrameHandle, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX, mainFrameBottomRightY) 

        // Create the rewards title
        set titleFrameHandle = BlzCreateFrameByType("GLUETEXTBUTTON", "RewardsTitle", RewardsFrameHandle, "ScriptDialogButton", 0) 
        call BlzFrameSetLevel(titleFrameHandle, 2) // To have it appear above the rewards
        call BlzFrameSetAbsPoint(titleFrameHandle, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X + (mainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) * 0.2, MAIN_FRAME_TOP_LEFT_Y + (TITLE_HEIGHT / 2)) 
        call BlzFrameSetAbsPoint(titleFrameHandle, FRAMEPOINT_BOTTOMRIGHT, MAIN_FRAME_TOP_LEFT_X + (mainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) * 0.8, MAIN_FRAME_TOP_LEFT_Y - TITLE_HEIGHT) 
        call BlzFrameSetEnable(titleFrameHandle, false) 
        call BlzFrameSetScale(titleFrameHandle, 1.2) 
        call BlzFrameSetText(titleFrameHandle, REWARDS_TITLE) 

        // Create the submit button
        set submitButtonFrameHandle = BlzCreateFrame("ScriptDialogButton", RewardsFrameHandle, 0, 0) 
        call BlzFrameSetAbsPoint(submitButtonFrameHandle, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN, mainFrameBottomRightY + MAIN_FRAME_Y_TOP_MARGIN + BUTTON_HEIGHT) 
        call BlzFrameSetAbsPoint(submitButtonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN + BUTTON_WIDTH, mainFrameBottomRightY + MAIN_FRAME_Y_BOTTOM_MARGIN) 
        call BlzFrameSetScale(submitButtonFrameHandle, 1.00) 
        call BlzFrameSetText(submitButtonFrameHandle, "|cff0dfc19Submit|r") 
        set SubmitHandleId = GetHandleId(submitButtonFrameHandle)
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, submitButtonFrameHandle, FRAMEEVENT_CONTROL_CLICK)

        // Create the reset button
        set resetButtonFrameHandle = BlzCreateFrame("ScriptDialogButton", RewardsFrameHandle, 0, 0) 
        call BlzFrameSetAbsPoint(resetButtonFrameHandle, FRAMEPOINT_TOPLEFT, mainFrameBottomRightX - MAIN_FRAME_X_MARGIN - BUTTON_WIDTH, mainFrameBottomRightY + MAIN_FRAME_Y_TOP_MARGIN + BUTTON_HEIGHT) 
        call BlzFrameSetAbsPoint(resetButtonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX - MAIN_FRAME_X_MARGIN, mainFrameBottomRightY + MAIN_FRAME_Y_BOTTOM_MARGIN) 
        call BlzFrameSetScale(resetButtonFrameHandle, 1.00) 
        call BlzFrameSetText(resetButtonFrameHandle, "|cfffc0d21Reset|r") 
        set ResetHandleId = GetHandleId(resetButtonFrameHandle)
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, resetButtonFrameHandle, FRAMEEVENT_CONTROL_CLICK)

        // Available points
        set AvailablePointsFrame = BlzCreateFrameByType("TEXT", "AvailablePointsText", RewardsFrameHandle, "", 0) 
        call BlzFrameSetAbsPoint(AvailablePointsFrame, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN, MAIN_FRAME_TOP_LEFT_Y - MAIN_FRAME_Y_TOP_MARGIN - TEXT_HEIGHT - (2 * ICON_WIDTH) - (ICON_SPACING) - AVAILABLE_POINTS_SPACER)
        call BlzFrameSetAbsPoint(AvailablePointsFrame, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX - MAIN_FRAME_X_MARGIN, MAIN_FRAME_TOP_LEFT_Y - MAIN_FRAME_Y_TOP_MARGIN - TEXT_HEIGHT - (2 * ICON_WIDTH) - (ICON_SPACING) - AVAILABLE_POINTS_SPACER - AVAILABLE_POINTS_HEIGHT) 
        call BlzFrameSetEnable(AvailablePointsFrame, false) 
        call BlzFrameSetScale(AvailablePointsFrame, 1.5) 
        call BlzFrameSetTextAlignment(AvailablePointsFrame, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER) 
        call BlzFrameSetText(AvailablePointsFrame, AVAILABLE_POINTS_COLOR + "Available Points: " + COLOR_END_TAG + "0") 

        // Rewards description
        set descriptionTextFrameHandle = BlzCreateFrameByType("TEXT", "RewardsText", RewardsFrameHandle, "", 0) 
        call BlzFrameSetAbsPoint(descriptionTextFrameHandle, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN, MAIN_FRAME_TOP_LEFT_Y - MAIN_FRAME_Y_TOP_MARGIN - TEXT_HEIGHT - (2 * ICON_WIDTH) - (ICON_SPACING) - AVAILABLE_POINTS_SPACER - AVAILABLE_POINTS_HEIGHT - DESCRIPTION_SPACER)
        call BlzFrameSetAbsPoint(descriptionTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX - MAIN_FRAME_X_MARGIN, MAIN_FRAME_TOP_LEFT_Y - MAIN_FRAME_Y_TOP_MARGIN - TEXT_HEIGHT - (2 * ICON_WIDTH) - (ICON_SPACING) - AVAILABLE_POINTS_SPACER - AVAILABLE_POINTS_HEIGHT - DESCRIPTION_SPACER - DESCRIPTION_HEIGHT) 
        call BlzFrameSetEnable(descriptionTextFrameHandle, false) 
        call BlzFrameSetScale(descriptionTextFrameHandle, 1.3) 
        call BlzFrameSetTextAlignment(descriptionTextFrameHandle, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER) 
        call BlzFrameSetText(descriptionTextFrameHandle, REWARDS_DESCRIPTION) 

        // Cleanup
        set submitButtonFrameHandle = null
        set resetButtonFrameHandle = null
        set titleFrameHandle = null
    endfunction
    
    private function CreateCategoryTitle takes string categoryTitle returns nothing
        set CurrentIconIndex = 0
        set CurrentRowIndex = 0
        call CreateCategoryText(categoryTitle)
        set CurrentRowIndex = 1
    endfunction

    private function CreateCategoryReward takes string iconPath, integer rewardIndex returns nothing
        call CreateRewardIcon(iconPath, rewardIndex)
        set CurrentIconIndex = CurrentIconIndex + 1
    endfunction

    private function CreateCategories takes nothing returns nothing
        // Offensive rewards
        call CreateCategoryTitle(OFFENSIVE_COLOR + "Offensive" + COLOR_END_TAG)
        call CreateCategoryReward(OFFENSIVE_ATTACK_DAMAGE_1_ICON, OFFENSIVE_ATTACK_DAMAGE_1_INDEX)
        call CreateCategoryReward(OFFENSIVE_PHYSICAL_POWER_2_ICON, OFFENSIVE_PHYSICAL_POWER_2_INDEX)
        call CreateCategoryReward(OFFENSIVE_MAGIC_POWER_3_ICON, OFFENSIVE_MAGIC_POWER_3_INDEX)
        // call CreateCategoryReward(OFFENSIVE_STAT_4_ICON, OFFENSIVE_STAT_4_INDEX)

        // Offensive tooltip information
        set RewardTitles[OFFENSIVE_ATTACK_DAMAGE_1_INDEX] = OFFENSIVE_COLOR + "Attack Damage" + COLOR_END_TAG
        set RewardTitles[OFFENSIVE_PHYSICAL_POWER_2_INDEX] = OFFENSIVE_COLOR + "Physical Power" + COLOR_END_TAG
        set RewardTitles[OFFENSIVE_MAGIC_POWER_3_INDEX] = OFFENSIVE_COLOR + "Magic Power" + COLOR_END_TAG
        // set RewardTitles[OFFENSIVE_STAT_4_INDEX] = "Offensive Stat 4"
        set RewardDescriptions[OFFENSIVE_ATTACK_DAMAGE_1_INDEX] = "Increase the Hero's base attack damage by " + R2S(ATTACK_DAMAGE_BONUS) + " per point"
        set RewardDescriptions[OFFENSIVE_PHYSICAL_POWER_2_INDEX] = "Increase the Hero's physical power by " + R2S(PHYSICAL_POWER_BONUS) + " per point"
        set RewardDescriptions[OFFENSIVE_MAGIC_POWER_3_INDEX] = "Increase the Hero's magic power by " + R2S(MAGIC_POWER_BONUS) + " per point"
        // set RewardDescriptions[OFFENSIVE_STAT_4_INDEX] = "Offensive Stat 4 Description"

        // Offensive index value mapping
        set RewardIndexValues[OFFENSIVE_ATTACK_DAMAGE_1_INDEX] = ATTACK_DAMAGE_BONUS
        set RewardIndexValues[OFFENSIVE_PHYSICAL_POWER_2_INDEX] = PHYSICAL_POWER_BONUS
        set RewardIndexValues[OFFENSIVE_MAGIC_POWER_3_INDEX] = MAGIC_POWER_BONUS
        // set RewardIndexValues[OFFENSIVE_STAT_4_INDEX] = OFFENSIVE_STAT_BONUS

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        // Defensive rewards
        call CreateCategoryTitle(DEFENSIVE_COLOR + "Defensive" + COLOR_END_TAG)
        call CreateCategoryReward(DEFENSIVE_ARMOR_1_ICON, DEFENSIVE_ARMOR_1_INDEX)
        call CreateCategoryReward(DEFENSIVE_MAGIC_PROTECTION_2_ICON, DEFENSIVE_MAGIC_PROTECTION_2_INDEX)
        call CreateCategoryReward(DEFENSIVE_BLOCK_3_ICON, DEFENSIVE_BLOCK_3_INDEX)
        // call CreateCategoryReward(DEFENSIVE_STAT_4_ICON, DEFENSIVE_STAT_4_INDEX)

        // Defensive tooltip information
        set RewardTitles[DEFENSIVE_ARMOR_1_INDEX] = DEFENSIVE_COLOR + "Armor" + COLOR_END_TAG
        set RewardTitles[DEFENSIVE_MAGIC_PROTECTION_2_INDEX] = DEFENSIVE_COLOR + "Magic Protection" + COLOR_END_TAG
        set RewardTitles[DEFENSIVE_BLOCK_3_INDEX] = DEFENSIVE_COLOR + "Block" + COLOR_END_TAG
        // set RewardTitles[DEFENSIVE_STAT_4_INDEX] = "Defensive Stat 4"
        set RewardDescriptions[DEFENSIVE_ARMOR_1_INDEX] = "Increase the Hero's armor by " + R2S(ARMOR_BONUS) + " per point"
        set RewardDescriptions[DEFENSIVE_MAGIC_PROTECTION_2_INDEX] = "Increase the Hero's magic protection by " + R2S(MAGIC_PROTECTION_BONUS) + " per point"
        set RewardDescriptions[DEFENSIVE_BLOCK_3_INDEX] = "Increase the Hero's block by " + R2S(BLOCK_BONUS) + " per point"
        // set RewardDescriptions[DEFENSIVE_STAT_4_INDEX] = "Defensive Stat 4 Description"

        // Defensive index value mapping
        set RewardIndexValues[DEFENSIVE_ARMOR_1_INDEX] = ARMOR_BONUS
        set RewardIndexValues[DEFENSIVE_MAGIC_PROTECTION_2_INDEX] = MAGIC_PROTECTION_BONUS
        set RewardIndexValues[DEFENSIVE_BLOCK_3_INDEX] = BLOCK_BONUS
        // set RewardIndexValues[DEFENSIVE_STAT_4_INDEX] = DEFENSIVE_STAT_BONUS

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        // Utility rewards
        call CreateCategoryTitle(UTILITY_COLOR + "Utility" + COLOR_END_TAG)
        call CreateCategoryReward(UTILITY_HIT_POINTS_1_ICON, UTILITY_HIT_POINTS_1_INDEX)
        call CreateCategoryReward(UTILITY_HIT_POINTS_REGEN_2_ICON, UTILITY_HIT_POINTS_REGEN_2_INDEX)
        call CreateCategoryReward(UTILITY_MANA_3_ICON, UTILITY_MANA_3_INDEX)
        call CreateCategoryReward(UTILITY_MANA_REGEN_4_ICON, UTILITY_MANA_REGEN_4_INDEX)

        // Utility tooltip information
        set RewardTitles[UTILITY_HIT_POINTS_1_INDEX] = UTILITY_COLOR + "Hit Points" + COLOR_END_TAG
        set RewardTitles[UTILITY_HIT_POINTS_REGEN_2_INDEX] = UTILITY_COLOR + "Hit Point Regeneration" + COLOR_END_TAG
        set RewardTitles[UTILITY_MANA_3_INDEX] = UTILITY_COLOR + "Mana" + COLOR_END_TAG
        set RewardTitles[UTILITY_MANA_REGEN_4_INDEX] = UTILITY_COLOR + "Mana Regeneration" + COLOR_END_TAG
        set RewardDescriptions[UTILITY_HIT_POINTS_1_INDEX] = "Increase the Hero's hit points by " + R2S(HIT_POINTS_BONUS) + " per point"
        set RewardDescriptions[UTILITY_HIT_POINTS_REGEN_2_INDEX] = "Increase the Hero's hit point regeneration by " + R2S(HIT_POINTS_REGEN_BONUS) + " per point"
        set RewardDescriptions[UTILITY_MANA_3_INDEX] = "Increase the Hero's mana by " + R2S(MANA_BONUS) + " per point"
        set RewardDescriptions[UTILITY_MANA_REGEN_4_INDEX] = "Increase the Hero's mana regeneration by " + R2S(MANA_REGION_BONUS) + " per point"

        // Utility index value mapping
        set RewardIndexValues[UTILITY_HIT_POINTS_1_INDEX] = HIT_POINTS_BONUS
        set RewardIndexValues[UTILITY_HIT_POINTS_REGEN_2_INDEX] = HIT_POINTS_REGEN_BONUS
        set RewardIndexValues[UTILITY_MANA_3_INDEX] = MANA_BONUS
        set RewardIndexValues[UTILITY_MANA_REGEN_4_INDEX] = MANA_REGION_BONUS

        set CurrentCategoryIndex = CurrentCategoryIndex + 1
    endfunction

    private function InitializeRewards takes nothing returns nothing
        set IconEventHandles = InitHashtable()

        // All buttons use the same trigger. However everything has a unique id to handle later on
        set IconEventTrigger = CreateTrigger()
        call TriggerAddAction(IconEventTrigger, function RewardsMouseEventActions)

        // Create the main frame. All elements use this frame as the parent
        set RewardsFrameHandle = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0) 
        call BlzFrameSetLevel(RewardsFrameHandle, 1)
        call BlzFrameSetVisible(RewardsFrameHandle, false) 

        // Create the primary tooltip window
        set RewardsTooltipFrame = BlzCreateFrame("TooltipText", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        set RewardsTooltipTitleFrame = BlzGetFrameByName("TooltipTextTitle", 0)
        set RewardsTooltipTextFrame = BlzGetFrameByName("TooltipTextValue", 0)
        call BlzFrameSetLevel(RewardsTooltipFrame, 3) // To have it appear above the rewards
        call BlzFrameSetVisible(RewardsTooltipFrame, false) 
        
        // Setup the rewards section
        call CreateCategories()

        // Finalize the main window
        call FinalizeMainFrame()
    endfunction

    private function GiveRewardPoints takes EventInfo eventInfo returns nothing
        local integer pid = GetPlayerId(eventInfo.p)
        local unit playerHero = PlayerHeroes[pid]
        local real rewardValue

        // Give points if this was a pvp round
        if (eventInfo.isPvp) then
            // First pvp round, give initial reward points
            if (RoundNumber == 5) then
                // Greedy golbin gets an additional initial reward point
                if (GetUnitTypeId(playerHero) == GREEDY_GOBLIN_UNIT_ID) then
                    set PlayerRewardPoints[pid] = 3
                else
                    set PlayerRewardPoints[pid] = 2
                endif
            else
                set PlayerRewardPoints[pid] = PlayerRewardPoints[pid] + 1
            endif

            // Show the rewards screen
            if (GetLocalPlayer() == Player(pid)) then	
                call BlzFrameSetText(AvailablePointsFrame, AVAILABLE_POINTS_COLOR + "Available Points: " + COLOR_END_TAG + I2S(PlayerRewardPoints[pid])) 
                call BlzFrameSetVisible(RewardsFrameHandle, true) 
                call PlayerStats.forPlayer(Player(pid)).setHasRewardsOpen(true)
            endif

        // Normal round end
        else
            // Attack damage
            if (PlayerRewardSelection[(REWARD_BUFFER * pid) + OFFENSIVE_ATTACK_DAMAGE_1_INDEX] > 0) then
                set rewardValue = GetOrUpdateCurrentRewardBonus(pid, OFFENSIVE_ATTACK_DAMAGE_1_INDEX, true)
                call BlzSetUnitBaseDamage(playerHero, BlzGetUnitBaseDamage(playerHero, 0) + R2I(rewardValue), 0)
            endif

            // Physical power
            if (PlayerRewardSelection[(REWARD_BUFFER * pid) + OFFENSIVE_PHYSICAL_POWER_2_INDEX] > 0) then
                set rewardValue = GetOrUpdateCurrentRewardBonus(pid, OFFENSIVE_PHYSICAL_POWER_2_INDEX, true)
                call AddUnitCustomState(playerHero, BONUS_PHYSPOW, rewardValue)
            endif

            // Magic power
            if (PlayerRewardSelection[(REWARD_BUFFER * pid) + OFFENSIVE_MAGIC_POWER_3_INDEX] > 0) then
                set rewardValue = GetOrUpdateCurrentRewardBonus(pid, OFFENSIVE_MAGIC_POWER_3_INDEX, true)
                call AddUnitCustomState(playerHero, BONUS_MAGICPOW, rewardValue)
            endif

            // Armor
            if (PlayerRewardSelection[(REWARD_BUFFER * pid) + DEFENSIVE_ARMOR_1_INDEX] > 0) then
                set rewardValue = GetOrUpdateCurrentRewardBonus(pid, DEFENSIVE_ARMOR_1_INDEX, true)
                call BlzSetUnitArmor(playerHero, BlzGetUnitArmor(playerHero) + DEFENSIVE_ARMOR_1_INDEX)
            endif

            // Magic protection
            if (PlayerRewardSelection[(REWARD_BUFFER * pid) + DEFENSIVE_MAGIC_PROTECTION_2_INDEX] > 0) then
                set rewardValue = GetOrUpdateCurrentRewardBonus(pid, DEFENSIVE_MAGIC_PROTECTION_2_INDEX, true)
                call AddUnitCustomState(playerHero, BONUS_MAGICRES, rewardValue)
            endif

            // Block
            if (PlayerRewardSelection[(REWARD_BUFFER * pid) + DEFENSIVE_BLOCK_3_INDEX] > 0) then
                set rewardValue = GetOrUpdateCurrentRewardBonus(pid, DEFENSIVE_BLOCK_3_INDEX, true)
                call AddUnitCustomState(playerHero, BONUS_BLOCK, rewardValue)
            endif

            // Hit points
            if (PlayerRewardSelection[(REWARD_BUFFER * pid) + UTILITY_HIT_POINTS_1_INDEX] > 0) then
                set rewardValue = GetOrUpdateCurrentRewardBonus(pid, UTILITY_HIT_POINTS_1_INDEX, true)
                call SetUnitMaxHp(playerHero, BlzGetUnitMaxHP(playerHero) + R2I(rewardValue))
            endif

            // Hit points regen
            if (PlayerRewardSelection[(REWARD_BUFFER * pid) + UTILITY_HIT_POINTS_REGEN_2_INDEX] > 0) then
                set rewardValue = GetOrUpdateCurrentRewardBonus(pid, UTILITY_HIT_POINTS_REGEN_2_INDEX, true)
                call AddUnitBonusReal(playerHero, BONUS_HEALTH_REGEN, rewardValue)
            endif

            // Mana
            if (PlayerRewardSelection[(REWARD_BUFFER * pid) + UTILITY_MANA_3_INDEX] > 0) then
                set rewardValue = GetOrUpdateCurrentRewardBonus(pid, UTILITY_MANA_3_INDEX, true)
                call BlzSetUnitMaxMana(playerHero, BlzGetUnitMaxMana(playerHero) + R2I(rewardValue))
            endif

            // Mana regen
            if (PlayerRewardSelection[(REWARD_BUFFER * pid) + UTILITY_MANA_REGEN_4_INDEX] > 0) then
                set rewardValue = GetOrUpdateCurrentRewardBonus(pid, UTILITY_MANA_REGEN_4_INDEX, true)
                call BlzSetUnitRealField(playerHero, ConvertUnitRealField('umpr'), BlzGetUnitRealField(playerHero, ConvertUnitRealField('umpr')) + rewardValue)
            endif
        endif

        // Cleanup
        set playerHero = null
    endfunction

    private function init takes nothing returns nothing
        call TimerStart(CreateTimer(), 2, false, function InitializeRewards)

        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_END, CustomEvent.GiveRewardPoints)
    endfunction

endlibrary
