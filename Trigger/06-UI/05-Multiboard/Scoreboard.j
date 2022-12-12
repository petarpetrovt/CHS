library Scoreboard requires PlayerTracking, HeroAbilityTable

    globals
        private string INITIAL_BOARD_NAME

        // The X,Y coordinate for the top left of the main frame
        private constant real MainFrameTopLeftX              = 0.26
        private constant real MainFrameTopLeftY              = 0.5
        private constant real MainFrameMargin                = 0.014

        // Specifications for a button
        private constant real ButtonWidth                    = 0.013
        private constant real ButtonSpacing                  = 0.003
        private constant real HeroIconSpacing                = 0.003

        // Specifications for a player name text
        private real TextHeight                              = 0.016
        private real TextWidth                               = 0.12

        // Column widths
        private constant real HeroIconWidth                  = 0.012
        private constant real PlayerNameWidth                = 0.12
        private constant real DuelsWidth                     = 0.038
        private constant real ITEM_START_COLUMN_INDEX        = 0.015
        private constant real SPACER_COLUMN_INDEX            = 0.015
        private constant real ABILITY_START_COLUMN_INDEX     = 0.015

        // Colors
        private constant string COLOR_END_TAG                = "|r"
        private constant string HEADER_COLOR                 = "|cff00ffff"
        private constant string PVP_LOSSES_COLOR             = "|cffdd2c00"
        private constant string PVP_WINS_COLOR               = "|cffbfff81"
        private constant string LEAVER_COLOR                 = "|cff404040"	
        private constant string SLASH 			 	         = "|cff4a4a4a/|r"

        // Specifications about the rows/columns
        private integer CurrentRowIndex                      = 0
        private integer CurrentColumnIndex                   = 0

        private integer TotalAchievementCount                = 0
        private integer GameMultiboardCurrentPlayerCount     = 0

        // Array to keep track of what player id belongs where on the multiboard. A fast lookup
        private integer array PlayerMultiboardLookup

        // The only trigger that handles hovering over items/abilities/heroes
        private trigger IconEventTrigger

        private hashtable HeroButtonEventHandles
        private hashtable ItemButtonEventHandles
        private hashtable AbilityButtonEventHandles
    endglobals

    function UpdateMultiboardPVPCounts takes player playingPlayer returns nothing
        local PlayerStats ps = PlayerStats.forPlayer(playingPlayer)
        local string duelStats = PVP_WINS_COLOR + I2S(ps.getPVPWins()) + COLOR_END_TAG + SLASH + PVP_LOSSES_COLOR + I2S(ps.getPVPLosses()) + COLOR_END_TAG

        // Set the PVP stats
        //call SetColumnRowValue(PlayerMultiboardLookup[GetPlayerId(playingPlayer)], DuelsWidth, duelStats)
    endfunction

    function UpdateMultiboardPlayerLeaves takes player playingPlayer returns nothing
        // Set the player name
       // call SetColumnRowValueAndColor(PlayerMultiboardLookup[GetPlayerId(playingPlayer)], PlayerNameWidth, GetPlayerName(playingPlayer), LEAVER_COLOR)
    endfunction

    private function ValidPlayerFilter takes nothing returns boolean
        return GetPlayerId(GetFilterPlayer()) < 8
    endfunction

    private function GetTopLeftX takes nothing returns real
        local real value = MainFrameTopLeftX + MainFrameMargin

        if (CurrentColumnIndex >= 1) then
            set value = value + HeroIconWidth + HeroIconSpacing
        endif

        if (CurrentColumnIndex >= 2) then
            set value = value + PlayerNameWidth
        endif

        if (CurrentColumnIndex >= 3) then
            set value = value + DuelsWidth + ((CurrentColumnIndex - 3) * (ButtonWidth * 0.5))
        endif

        if (CurrentColumnIndex >= 14) then
            set value = value + ButtonWidth
        endif

        return value
    endfunction

    private function GetTopLeftY takes nothing returns real
        return MainFrameTopLeftY - MainFrameMargin - (ButtonWidth * CurrentRowIndex) - (ButtonSpacing * CurrentRowIndex)
    endfunction

    private function CreateIcon takes string iconPath, hashtable buttonEventHandles returns nothing
        local framehandle buttonFrameHandle = BlzCreateFrame("ScriptDialogButton", ScoreboardFrameHandle, 0, 0) 
        local framehandle buttonBackdropFrameHandle = BlzCreateFrameByType("BACKDROP", "Backdrop", buttonFrameHandle, "", 1)
        local integer buttonHandleId = GetHandleId(buttonFrameHandle)
        local integer backdropHandleId = GetHandleId(buttonBackdropFrameHandle)

        // Keep a count of every icon we make
        // set TotalAchievementCount = TotalAchievementCount + 1

        // Dimensions for the button
        call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY()) 
        call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + ButtonWidth, GetTopLeftY() - ButtonWidth) 

        // Apply the icon
        call BlzFrameSetAllPoints(buttonBackdropFrameHandle, buttonFrameHandle) 
        // call BlzFrameSetTexture(buttonBackdropFrameHandle, GetIconPath(iconPath), 0, true) 
        call BlzFrameSetTexture(buttonBackdropFrameHandle, iconPath, 0, true) 
        // set AchievementIconPaths.string[TotalAchievementCount] = iconPath

        // Save the handle of this button to look it up later for mouse events
        call SaveInteger(buttonEventHandles, buttonHandleId, 1, TotalAchievementCount)
        // set AchievementButtonHandleIds.integer[TotalAchievementCount] = buttonHandleId
        
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, buttonFrameHandle, FRAMEEVENT_CONTROL_CLICK)
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_ENTER)
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_LEAVE)
        
        set CurrentColumnIndex = CurrentColumnIndex + 1

        // Cleanup
        set buttonFrameHandle = null
        set buttonBackdropFrameHandle = null
    endfunction

    private function CreateText takes string value returns nothing
        local framehandle playerNameTextFrameHandle = BlzCreateFrameByType("TEXT", "PlayerName", ScoreboardFrameHandle, "", 0) 

        call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY() - 0.002) // The 0.002 moves the text down a tiny bit
        call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + TextWidth, GetTopLeftY() - TextHeight) 
        call BlzFrameSetText(playerNameTextFrameHandle, value) 
        call BlzFrameSetEnable(playerNameTextFrameHandle, false) 
        call BlzFrameSetScale(playerNameTextFrameHandle, 1.00) 
        call BlzFrameSetTextAlignment(playerNameTextFrameHandle, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 

        set CurrentColumnIndex = CurrentColumnIndex + 1

        // Cleanup
        set playerNameTextFrameHandle = null
    endfunction

    function UpdatePlayerItems takes player playingPlayer returns nothing
        local integer itemSlotIndex = 0
        local unit playerHero = PlayerHeroes[GetPlayerId(playingPlayer) + 1]
        local item currentItem

        loop
            exitwhen itemSlotIndex > 5

            set currentItem = UnitItemInSlot(playerHero, itemSlotIndex)

            if (currentItem != null) then
                // Display the icon
                call CreateIcon(BlzGetItemIconPath(currentItem), ItemButtonEventHandles)
            else
                // Display the icon

                call CreateIcon(BlzGetItemIconPath(CreateItem('I099', 0, 0)), ItemButtonEventHandles)
            endif

            set itemSlotIndex = itemSlotIndex + 1
            set CurrentColumnIndex = CurrentColumnIndex + 1
        endloop

        // Cleanup
        set playerHero = null
        set currentItem = null
    endfunction

    function UpdatePlayerAbilities takes player playingPlayer returns nothing
        local integer abilityIndex = 1
        local unit playerHero = PlayerHeroes[GetPlayerId(playingPlayer) + 1]
        local integer currentAbility

        loop
            exitwhen abilityIndex > 10

            // Check if there is a valid ability in the next slot
            set currentAbility = GetHeroSpellAtPosition(playerHero, abilityIndex)

            if (currentAbility != 0) then
                // Display the icon
                call CreateIcon(BlzGetAbilityIcon(currentAbility), AbilityButtonEventHandles)
            else
                call CreateIcon(BlzGetAbilityIcon('ANab'), AbilityButtonEventHandles)
            endif

            set abilityIndex = abilityIndex + 1
            set CurrentColumnIndex = CurrentColumnIndex + 1
        endloop

        // Cleanup
        set playerHero = null
    endfunction

    private function AddPlayerToMultiboard takes nothing returns nothing
        local player playingPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(playingPlayer)
        local unit playerHero = PlayerHeroes[GetPlayerId(playingPlayer) + 1]

        // This function was called when it was not supposed to. Should only be called when all heroes are selected
        if (playerHero == null) then
            // Cleanup
            set playingPlayer = null
            set playerHero = null

            return
        endif

        set CurrentColumnIndex = 0

        // Increment the amount of players that we have added to the multiboard to know how to save them for lookup in the future
        set GameMultiboardCurrentPlayerCount = GameMultiboardCurrentPlayerCount + 1

        // Save where this player is in the multiboard for lookup in the future
        set PlayerMultiboardLookup[playerId] = GameMultiboardCurrentPlayerCount

        // Set the player hero icon
        call CreateIcon(BlzGetAbilityIcon(GetUnitTypeId(playerHero)), HeroButtonEventHandles)

        // Set the player name
        call CreateText(GetPlayerNameColour(playingPlayer))

        // Set the PVP stats
        call CreateText(PVP_WINS_COLOR + "0" + COLOR_END_TAG + SLASH + PVP_LOSSES_COLOR + "0" + COLOR_END_TAG)

        // Set the player items
        call UpdatePlayerItems(playingPlayer)

        // Set the player abilities
        call UpdatePlayerAbilities(playingPlayer)

        set CurrentRowIndex = CurrentRowIndex + 1

        // Cleanup
        set playingPlayer = null
        set playerHero = null
    endfunction

    private function VotingMouseEventActions takes nothing returns nothing
		/*local integer index = GetIndex(GetHandleId(BlzGetTriggerFrame()))
        local integer achievementType = GetAchievementType(GetHandleId(BlzGetTriggerFrame()))
        local PlayerStats ps = PlayerStats.forPlayer(GetTriggerPlayer())
        local Requirements hr = Requirements.forIndex(index)
        local string requirementDescription

        if BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK then
            if GetLocalPlayer() == GetTriggerPlayer() then
				call BlzFrameSetEnable(BlzGetTriggerFrame(), false)
				call BlzFrameSetEnable(BlzGetTriggerFrame(), true)
			endif

            // Is hat
            if (achievementType == 1) then
                call TryToWearHat(index, GetTriggerPlayer(), true)
            // Is pet
            else // achievementType == 2
                call TryToSummonPet(index, GetTriggerPlayer(), true)
            endif
        elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_ENTER then
            set requirementDescription = hr.getRequirementDescription(ps)

            // We are hijacking the tooltip window that we use for almost everything else in the game from IconFrames
            if GetLocalPlayer() == GetTriggerPlayer() then	
                call BlzFrameSetText(TooltipTitleFrame, requirementDescription)
                call BlzFrameSetSize(TooltipFrame, 0.29, GetTooltipSize(requirementDescription))
                call BlzFrameSetVisible(TooltipFrame, true)
            endif
        elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_LEAVE then
            // Empty the text box
            if GetLocalPlayer() == GetTriggerPlayer() then	
                call BlzFrameSetText(TooltipTextFrame, "")
                call BlzFrameSetVisible(TooltipFrame, false)
            endif
        endif*/
    endfunction

    private function CreateHeaderRow takes nothing returns nothing
        set CurrentRowIndex = 0

        set CurrentColumnIndex = 1
        call CreateText(HEADER_COLOR + "Player" + COLOR_END_TAG)
        set CurrentColumnIndex = 2
        call CreateText(HEADER_COLOR + "Duels" + COLOR_END_TAG)
        set CurrentColumnIndex = 3
        call CreateText(HEADER_COLOR + "Items" + COLOR_END_TAG)
        set CurrentColumnIndex = 15
        call CreateText(HEADER_COLOR + "Abilities" + COLOR_END_TAG)

        set CurrentRowIndex = 1
    endfunction

    private function InitializeDefaultValues takes nothing returns nothing
        local force playersOrComputersForce = GetPlayersMatching(Condition(function ValidPlayerFilter))
        local real mainFrameBottomRightX
        local real mainFrameBottomRightY

        // All buttons use the same trigger. However everything has a unique id to handle later on
        set IconEventTrigger = CreateTrigger()
        call TriggerAddAction(IconEventTrigger, function VotingMouseEventActions)

        // Create the main frame. All elements use this frame as the parent
        set ScoreboardFrameHandle = BlzCreateFrame("CheckListBox", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0) 

        call CreateHeaderRow()

        // Populate the rows with actual player data
        call ForForce(playersOrComputersForce, function AddPlayerToMultiboard)

        // Compute the main voting box based on how many buttons there are and the column restrictions
        set mainFrameBottomRightX = MainFrameTopLeftX + (2 * MainFrameMargin) + HeroIconWidth + PlayerNameWidth + DuelsWidth + (16 * ButtonWidth) + ButtonWidth + HeroIconSpacing
        set mainFrameBottomRightY = MainFrameTopLeftY - (2 * MainFrameMargin) - (CurrentRowIndex * ButtonWidth) - (CurrentRowIndex * ButtonSpacing)

        // Set the frame for the backdrop of the entire scoreboard
        call BlzFrameSetAbsPoint(ScoreboardFrameHandle, FRAMEPOINT_TOPLEFT, MainFrameTopLeftX, MainFrameTopLeftY) 
        call BlzFrameSetAbsPoint(ScoreboardFrameHandle, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX, mainFrameBottomRightY) 

        // Cleanup
        call DestroyForce(playersOrComputersForce)
        set playersOrComputersForce = null
    endfunction
    
    function InitializeMultiboard takes nothing returns nothing
        set INITIAL_BOARD_NAME = "|cff2ff1ffCustom Hero Survival - |r |cffadff2f" + GetMapVersionName(CURRENT_GAME_VERSION) + "|r"

        set AbilityButtonEventHandles = InitHashtable()
        set ItemButtonEventHandles = InitHashtable()
        set HeroButtonEventHandles = InitHashtable()

        call InitializeDefaultValues()
    endfunction

endlibrary
