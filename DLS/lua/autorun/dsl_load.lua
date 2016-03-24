if (SERVER) then
	AddCSLuaFile("DLS_config.lua")
	include("DLS_config.lua")
	
	local message = [[
	
	-------------------------------
	| Lottery Tickets             |
	| Made By: ♕ Dilly ✄        |
	| Project started: 1/16/2016  |
	| Version: 1.0                |
	-------------------------------	
	
	]]
	
	MsgC(Color(140,0,255), message) 	
end

if (CLIENT) then
	include("DLS_config.lua")
	
	local message = [[
	
	-------------------------------
	| Lottery Tickets             |
	| Made By: ♕ Dilly ✄        |
	| Project started: 3/24/2016  |
	| Version: 1.0                |
	-------------------------------	
	
	]]
	
	MsgC(Color(140,0,255), message) 	
end