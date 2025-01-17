library TooltipFrame initializer init requires StringFunctions
    
    globals
        framehandle TooltipFrame = null
		framehandle TooltipTitleFrame
		framehandle TooltipTextFrame

		constant real TooltipX = 0
		constant real TooltipY = 0.165

		real DEFAULT_SIZE = 0.020
		real LINE_SIZE = 0.012

		Table TooltipYSize
    endglobals

	function SellAllItemsTooltip takes nothing returns string
		return "Sell all your items for 100% gold/glory cost (|cff77f3fcCtrl+E|r)"
	endfunction

	function GetObjectTooltipSize takes integer objectId returns real
		return GetTooltipSize(BlzGetAbilityExtendedTooltip(objectId, 0))
	endfunction

    function CreateTooltipFrame takes nothing returns nothing
        set TooltipFrame = BlzCreateFrame("TooltipText", GameUI  , 0, 0)
        set TooltipTitleFrame = BlzGetFrameByName("TooltipTextTitle", 0)
        set TooltipTextFrame = BlzGetFrameByName("TooltipTextValue", 0)
    
        call BlzFrameSetSize(TooltipFrame, 0.29, 0.03)
        call BlzFrameSetPoint(TooltipFrame, FRAMEPOINT_BOTTOMRIGHT, GameUI, FRAMEPOINT_BOTTOMRIGHT, TooltipX, TooltipY)
        call BlzFrameSetVisible(TooltipFrame, false)   
    endfunction

    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterTimerEventSingle(trg, 1.1)
        call TriggerAddAction(trg, function CreateTooltipFrame)

        set TooltipYSize = Table.create()
        set trg = null
    endfunction

endlibrary
