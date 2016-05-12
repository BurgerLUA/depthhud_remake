resource.AddFile("resource/fonts/din.ttf")
resource.AddFile("resource/fonts/dinmed.ttf")



-- loaded
AddCSLuaFile()

////////////////////////////////////////////////
// -- Depth HUD : Inline                      //
// by Hurricaaane (Ha3)                       //
//                                            //
// http://www.youtube.com/user/Hurricaaane    //
//--------------------------------------------//
// Shared call file                           //
////////////////////////////////////////////////

if DHINLINE_DEBUG == nil then
	DHINLINE_DEBUG = false
end

DHINLINE_HOOK_HUDPAINT      = true
DHINLINE_HOOK_HUDSHOULDDRAW = true
DHINLINE_DEFAULTTHEME = "depthhud_classic"

DHINLINE_NAME = "DepthHUD Inline"
DHINLINE_THEMEDIR = "dhinline_themes/"

// SERVER INCLUSION FOR VERY SPECIAL CASES. DO NOT USE UNLESS AWARE OF ITS MAIN USES.

// You can OMIT adding those files to your gamemode i f running as a strap
// Official data/ folder.
// Official materials/ folder.
// Official resource/ folder.
// Lua file : control_presets.lua
// Lua file : preset_editor.lua
// Lua file : DhCheckPos.lua
// Lua file : cl_dhinline_cvar_custom.lua
// Lua file : cl_dhinline_elementpanel.lua
// Lua file : cl_dhinline_version.lua
// Official themes.
// All those cited directory and files DON'T NEED to be added in your gamemode.


// Don't turn DHINLINE_SPECIAL_SENDSTATICTOCLIENTS to true, unless
// you have reconfigured the theme directory,
// and also the default theme,
// and batch-replaced all match-case "dhinline" to a custom var name in all lua files,
// and also  replaced all match-case "DHINLINE" to a custom capital letters var name in all lua files,
// and MORE IMPORTANTLY, replace all "dhinline" from >> Lua Filenames <<, including this one.

// If you are including as part of a gamemode, set DHINLINE_SPECIAL_ISGAMEMODE_STRAP to true.

DHINLINE_SPECIAL_SENDSTATICTOCLIENTS = true
DHINLINE_SPECIAL_ISGAMEMODE_STRAP = false



AddCSLuaFile()
AddCSLuaFile("garbage_module.lua")
AddCSLuaFile("cl_dhinline_base.lua")
AddCSLuaFile("cl_dhinline_element.lua")
AddCSLuaFile("cl_dhinline_theme.lua")
AddCSLuaFile("cl_dhinline_cvar_static.lua")

local mainPath = DHINLINE_THEMEDIR
if DHINLINE_SPECIAL_ISGAMEMODE_STRAP then
	mainPath = string.Replace(GM.Folder, "gamemodes/", "") .. "/gamemode/" .. mainPath
end
for _,fileName in pairs(file.Find(mainPath .. "*_theme.lua","LUA")) do
	AddCSLuaFile(mainPath .. fileName)
	AddCSLuaFile(mainPath .. string.Replace(fileName, "_theme.lua", "_element.lua"))
	Msg("Server " .. DHINLINE_NAME .. " > Sending theme " .. string.Replace(fileName, "_theme.lua", "") .. "\n")
	local themePath = mainPath .. string.Replace(fileName, "_theme.lua", "/")
	
	local FileToFind = themePath .."*"
	
	print(FileToFind)
	
	for _,elementFile in pairs( file.Find(FileToFind,"LUA") ) do
		AddCSLuaFile(themePath .. elementFile)
		if (DHINLINE_DEBUG) then Msg("Server " .. DHINLINE_NAME .. " > Sending " .. themePath .. elementFile .. "\n") end
	end
end

print("sh_depthhud.lua loaded!")
