library LoadCommand initializer init uses Command, RandomShit, PlayerTracking, SaveCore

    // This is responsible for parsing the input and determining how to load the code
    // An event is fired from the savecode library once it is done loading
    private function LoadCode takes Args args returns nothing
        set SaveTempString = SubStringBJ(GetEventPlayerChatString(), 7, 999)
        set SaveTempInt = S2I(SaveTempString)
        if (StringLength(SaveTempString) == 1) then
            // Do nothing?
        else
            if (StringLength(SaveTempString) > 1) then
                set SaveLoadEvent_Code = SaveTempString
                set SaveLoadEvent_Player = GetTriggerPlayer()
                set SaveLoadEvent = 1.00 // We probably don't need to do this? Could probably call LoadCodeValues directly?
                set SaveLoadEvent = 0.00
                return
            else
                set SaveTempInt = -1
            endif
        endif

        if (not File.ReadEnabled) then
            call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60000, LocalFiles_WarningMessage)
        endif

        call LoadSaveSlot(GetTriggerPlayer(), SaveTempInt)
    endfunction
	
    private function LoadNextBasicValue takes nothing returns integer 
        set SaveCount = SaveCount + 1
        set SaveMaxValue[SaveCount] = MAX_SAVE_VALUE
        call SaveHelper.GUILoadNext()
        return SaveValue[SaveCount]
    endfunction

    // Once the code is finally read by the savecode system and parsed, this function gets called
    // The main idea in loading is understanding what values we stored in the SaveCommand
    // We must load the values in the REVERSE order as we saved them
    private function LoadCodeValues takes nothing returns nothing
        local PlayerStats ps = PlayerStats.forPlayer(SaveLoadEvent_Player)
        set SaveCount = -1
        set SaveTempInt = integer(Savecode.create())

        // Try to load the code
        if not (Savecode(SaveTempInt).Load(SaveLoadEvent_Player, SaveLoadEvent_Code, 1)) then
            call DisplayTextToForce(GetForceOfPlayer(SaveLoadEvent_Player), "Invalid load code.")
            return
        endif

        // Load Game Version
        call ps.setMapVersion(LoadNextBasicValue())

        // Check if the game version is different. If so, reset current map version values
        if (ps.getMapVersion() != CURRENT_GAME_VERSION) then
            // Trying to load a code that is older than the curret version
            if (ps.getMapVersion() < CURRENT_GAME_VERSION) then
                call DisplayTimedTextToPlayer(SaveLoadEvent_Player,0,0,30,"Your Save Code is for an older version of CHS. Resetting Map Version wins.")
            else
                // Trying to load a code that is newer than the curret version
                call DisplayTimedTextToPlayer(SaveLoadEvent_Player,0,0,30,"Your Save Code is for a newer version of CHS. Resetting Map Version wins.")
            endif

            call DisplayTimedTextToPlayer(SaveLoadEvent_Player,0,0,30,"Current Map Version: " + GetMapVersionName(CURRENT_GAME_VERSION))
            call DisplayTimedTextToPlayer(SaveLoadEvent_Player,0,0,30,"Your Map Version: " + GetMapVersionName(ps.getMapVersion()))
            call ps.resetSeasonStats()
            call ps.setMapVersion(CURRENT_GAME_VERSION)
        endif

        // Load camera settings
        call ps.setCameraZoom(LoadNextBasicValue())

        // The camera setting should be saved correct already, but validate against bad values to prevent errors
        if (ps.getCameraZoom() > 3000) then
            call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,3000.00,0.50)
            call ps.setCameraZoom(3000)
        elseif (ps.getCameraZoom() < 1700) then
            call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,1700.00,0.50)
            call ps.setCameraZoom(1700)
        else 
            call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,I2R(ps.getCameraZoom()),0.50)
        endif

        // Draft Save Values
        call ps.setDraftPVPSeasonWins(LoadNextBasicValue())
        call ps.setDraftBRSeasonWins(LoadNextBasicValue())
        call ps.setDraftPVPAllWins(LoadNextBasicValue())
        call ps.setDraftBRAllWins(LoadNextBasicValue())

        // All Random Save Values
        call ps.setARPVPSeasonWins(LoadNextBasicValue())
        call ps.setARBRSeasonWins(LoadNextBasicValue())
        call ps.setARPVPAllWins(LoadNextBasicValue())
        call ps.setARBRAllWins(LoadNextBasicValue())

        // All Pick Save Values
        call ps.setAPPVPSeasonWins(LoadNextBasicValue())
        call ps.setAPBRSeasonWins(LoadNextBasicValue())
        call ps.setAPPVPAllWins(LoadNextBasicValue())
        call ps.setAPBRAllWins(LoadNextBasicValue())

        call Savecode(SaveTempInt).destroy()
    endfunction

	private function init takes nothing returns nothing
        local trigger syncEventTrigger = CreateTrigger()
        call TriggerRegisterVariableEvent(syncEventTrigger, "SaveLoadEvent", EQUAL, 1.00)
        call TriggerAddAction(syncEventTrigger, function LoadCodeValues)
        set syncEventTrigger = null

		call Command.create(CommandHandler.LoadCode).name("load").handles("load").help("load <code>", "loads your progress from your save code")
	endfunction

endlibrary
