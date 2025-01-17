library SantaHat initializer init requires Command
    //===========================================================================
    globals
        boolean EnableSantaMode = false
        boolean SantaHatOn = false
        weathereffect snow
    endglobals

    function SantaHat takes Args args returns nothing
        if SantaHatOn then
            set SantaHatOn = false
        else
            set SantaHatOn = true
        endif

        call EnableWeatherEffect(snow, SantaHatOn)

        call DisplayTextToForce(GetPlayersAll(), "|cffff6161Merry Christmas!|r")
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        if EnableSantaMode then
            set snow = AddWeatherEffect(GetPlayableMapRect(), 'SNhs')
            call EnableWeatherEffect(snow, false)
            call Command.create(CommandHandler.SantaHat).name("SantaMode").handles("santa").handles("christmas").handles("holidays").help("santa", "Toggles christmas mode.")
        endif
    endfunction
endlibrary