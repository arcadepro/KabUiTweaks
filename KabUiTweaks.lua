local f 			= CreateFrame("Frame")
local events 		= {}
local runonce = 0

local function applysettings()
	ChatFrame1EditBox:SetAttribute("chatType", "GUILD")
	ChatFrame1EditBox:SetAttribute("stickyType", "GUILD")
	for i=1,9 do _G["ChatFrame"..i]:SetFading(false) end

	PlayerFrame:UnregisterEvent("UNIT_COMBAT")
	PetFrame:UnregisterEvent("UNIT_COMBAT")
	BossBanner:UnregisterEvent("ENCOUNTER_LOOT_RECEIVED")
	SetDungeonDifficultyID(23)
	SetCVar("Sound_MaxCacheSizeInBytes", "268435456")
	SetCVar("Sound_NumChannels", "128")
	SetCVar("rawMouseEnable", "1")
	SetCVar("rawMouseAccelerationEnable", "0")
	SetCVar("rawMouseRate", "1000")
	SetCVar("rawMouseResolution", "1200")
	SetCVar("whisperMode","inline")

	SetCVar("nameplateGlobalScale", "1.2")
	SetCVar("nameplateMinAlpha", "1")
	SetCVar("nameplateMotion", "1")
	SetCVar("nameplateMotionSpeed", "0.05")
	SetCVar("nameplateSelectedScale", "1")
	SetCVar("threatShowNumeric", "1")

	UIErrorsFrame:Hide()
	--AddonCharacterDropDown:Hide()
	WorldMapFrame.BlackoutFrame.Blackout:SetAlpha(0)
	--WorldMapFrame.BlackoutFrame:SetScript("OnShow", function(self) self:Hide() end)
	--SetCVar("cursorSizePreferred", "1")
	--C_TransmogCollection.SetShowMissingSourceInItemTooltips(true)
	--SendMailNameEditBox.autoCompleteParams = AUTOCOMPLETE_LIST_TEMPLATES.FRIEND
	--WorldMapFrame.BorderFrame.MaximizeMinimizeFrame:Hide()
	--SendMailNameEditBox.autoCompleteParams = AUTOCOMPLETE_LIST_TEMPLATES.FRIEND_AND_GUILD
	--IconIntroTracker:UnregisterEvent("SPELL_PUSHED_TO_ACTIONBAR")
	--InterfaceOptionsFrameCancel:Hide()
	--InterfaceOptionsFrameOkay:SetAllPoints(InterfaceOptionsFrameCancel)
	LoadAddOn("Blizzard_GuildUI")
	--LoadAddOn("Blizzard_Worldmap")
	--LoadAddOn("Blizzard_SharedMapDataProviders")
	--LoadAddOn("Blizzard_AdventureMap")
	--LoadAddOn("Blizzard_SecureTransferUI")
end

function events:PLAYER_ENTERING_WORLD(...)
	if runonce == 0 then
		applysettings()
		runonce = 1
	end
	--if ObjectiveTrackerBlocksFrame:IsVisible() then ObjectiveTrackerFrame.HeaderMenu.MinimizeButton:Click() end
end

--[[ function events:VARIABLES_LOADED(...)
		f:UnregisterEvent("VARIABLES_LOADED")
		C_Timer.After(2, applysettings)
end --]]

--[[ function events:PLAYER_REGEN_ENABLED(...)
		--C_Timer.After(1, checkStatus)
		checkStatus()
end --]]

--[[ function events:ZONE_CHANGED_NEW_AREA(...)
		checkStatus()
end
 --]]
function events:PLAYER_TARGET_CHANGED(...)
	TargetFrameNameBackground:SetAlpha(0.6)
end

function events:PLAYER_FOCUS_CHANGED(...)
	FocusFrameNameBackground:SetAlpha(0.6)
end

MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
Minimap:EnableMouseWheel(true) -- enable mousewheel on minimap
Minimap:SetScript('OnMouseWheel', function(self, delta)
	if delta > 0 then
		Minimap_ZoomIn()
	else
		Minimap_ZoomOut()
	end
end)

--[[ for k,v in pairs(_G) do
    if type(v)=="table" and type(v.SetDrawBling)=="function" then
        v:SetDrawBling(true)
    end
end --]]

--[[ hooksecurefunc(getmetatable(ActionButton1Cooldown).__index, 'SetCooldown', function(self)
    --self:SetDrawBling(false)
	self:SetSwipeColor(0,0,0,0.7)
end) --]]

f:SetScript("OnEvent", function(self, event, ...)
	events[event](self, ...) -- call one of the functions above
end)

for j, u in pairs(events) do
	f:RegisterEvent(j); -- Register all events for which handlers have been defined
end

SlashCmdList["READYCHECK"] = function()
	if IsInGroup() then
		DoReadyCheck()
	else
		print("|cFFFFFF00Not in a group!|r")
	end
end

SLASH_READYCHECK1          	= '/rc'
SlashCmdList["RELOADUI"]	= function() ReloadUI() end
SLASH_RELOADUI1 			= '/rl'
