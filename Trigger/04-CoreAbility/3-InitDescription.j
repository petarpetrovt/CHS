globals
    string array ClassAbil

endglobals



function Trig_InitDescription_Actions takes nothing returns nothing
    set ClassAbil[1] = "[|cffff0000Fire|r]"
    set ClassAbil[2] = "[|cff000080Water|r]"
    set ClassAbil[3] = "[|cffc0c0c0Wind|r]"
    set ClassAbil[4] = "[|cffd45e19Earth|r]"
    set ClassAbil[5] = "[|cff008000Wild|r]"
    set ClassAbil[6] = "[|cff008080Energy|r]"
    set ClassAbil[7] = "[|cff000000Dark|r]"
    set ClassAbil[8] = "[|cffd2d2d2Light|r]"
    set ClassAbil[9] = "[|cff8080ffCold|r]"
    set ClassAbil[10] = "[|cff104c0fPoison|r]"
    set ClassAbil[11] = "[|cff800000Blood|r]"   
    
    set ClassAbil[12] = "[|cffffff96Divinity|r]"
    set ClassAbil[13] = "[|cff6f2583Arcane|r]"
    set ClassAbil[14] = "[|cff7a85ffTime|r]"
    set ClassAbil[15] = "[|cffc0dec0Spirit|r]"
    
    
//    set ClassAbil[20] = "[|cff800000Warrior|r]"   
//    set ClassAbil[21] = "[|cff800000Rogue|r]"   
//    set ClassAbil[22] = "[|cff800000Paladin|r]"   
//    set ClassAbil[23] = "[|cff800000Archer|r]"   
//    set ClassAbil[24] = "[|cff800000Barbarian|r]"   


endfunction

function InitTrig_InitDescription takes nothing returns nothing
    set gg_trg_InitDescription = CreateTrigger(  )
    call TriggerAddAction( gg_trg_InitDescription, function Trig_InitDescription_Actions )
endfunction

