-- basiccube's Default Weapon Base Extension

CreateConVar("dwbext_autoreload", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Enable weapon auto reload.", 0, 1)
CreateConVar("dwbext_crosshair", 1, {FCVAR_ARCHIVE}, "Enable crosshair.", 0, 1)

hook.Add("AddToolMenuCategories", "dwbext", function()
    spawnmenu.AddToolCategory( "Options", "DWBExtension", "#DWBExtension")
end)

hook.Add("PopulateToolMenu", "dwbext_settingsmenu", function()
    spawnmenu.AddToolMenuOption("Options", "DWBExtension", "dwbext_settings", "Settings", "", "", function(pnl)
        pnl:Clear()
        pnl:Help("DWBExtension settings.")

        pnl:CheckBox("Enable weapon auto reload", "dwbext_autoreload")
        pnl:CheckBox("Enable weapon crosshair", "dwbext_crosshair")
    end)
end)