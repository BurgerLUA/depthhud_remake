-- Loaded

if (dhinline and dhinline.Unmount) then
	dhinline.Unmount()
end

dhinline = {}

include("cl_dhinline_base.lua")

if not DHINLINE_SPECIAL_SENDSTATICTOCLIENTS then
	// Load regular DepthHUD Inline for clients.
	include("cl_dhinline_version.lua")
	include("cl_dhinline_elementpanel.lua")
	include("cl_dhinline_cvar_custom.lua")
else
	// Load special serverside DepthHUD Inline.
	include("cl_dhinline_cvar_static.lua")
end

dhinline.Mount()


print("cl_depthhud.lua loaded!")