--bgFile = 'Interface\\AddOns\\\V+Actions\\test.tga', -- работает
--bgFile = 'Interface/AddOns/V+Actions/test.tga', -- не работает


CreateFrame('Frame', 'VPBGQ')
VPBGQ:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 0, 1)
VPBGQ:SetWidth(8)
VPBGQ:SetHeight(8)
VPBGQ:Hide()

SLASH_VBG1 = "/vbg"
SlashCmdList["VBG"] = function(cmd)

	DEFAULT_CHAT_FRAME:AddMessage(cmd)

	if cmd == "q" then
		VPBGQ:SetBackdrop({
			bgFile = "Interface\\AddOns\\V+Actions\\VPBGQ-1-None",
			insets = {left = 0, right = 0, top = 0, bottom = 0}
		})
		VPBGQ:Show()
	elseif cmd == "c1" then
		VPBGQ:SetBackdrop({
			bgFile = "Interface\\AddOns\\V+Actions\\VPBGQ-2-AB",
			insets = {left = 0, right = 0, top = 0, bottom = 0}
		})
		VPBGQ:Show()
	elseif cmd == "c2" then
		VPBGQ:SetBackdrop({
			bgFile = "Interface\\AddOns\\V+Actions\\VPBGQ-2-AC",
			insets = {left = 0, right = 0, top = 0, bottom = 0}
		})
		VPBGQ:Show()
	elseif cmd == "c3" then
		VPBGQ:SetBackdrop({
			bgFile = "Interface\\AddOns\\V+Actions\\VPBGQ-2-AV",
			insets = {left = 0, right = 0, top = 0, bottom = 0}
		})
		VPBGQ:Show()
	elseif cmd == "c4" then
		VPBGQ:SetBackdrop({
			bgFile = "Interface\\AddOns\\V+Actions\\VPBGQ-2-WG",
			insets = {left = 0, right = 0, top = 0, bottom = 0}
		})
		VPBGQ:Show()
	elseif cmd == "a1" then
		VPBGQ:SetBackdrop({
			bgFile = "Interface\\AddOns\\V+Actions\\VPBGQ-3-AB",
			insets = {left = 0, right = 0, top = 0, bottom = 0}
		})
		VPBGQ:Show()
	elseif cmd == "a2" then
		VPBGQ:SetBackdrop({
			bgFile = "Interface\\AddOns\\V+Actions\\VPBGQ-3-AC",
			insets = {left = 0, right = 0, top = 0, bottom = 0}
		})
		VPBGQ:Show()
	elseif cmd == "a3" then
		VPBGQ:SetBackdrop({
			bgFile = "Interface\\AddOns\\V+Actions\\VPBGQ-3-AV",
			insets = {left = 0, right = 0, top = 0, bottom = 0}
		})
		VPBGQ:Show()
	elseif cmd == "a4" then
		VPBGQ:SetBackdrop({
			bgFile = "Interface\\AddOns\\V+Actions\\VPBGQ-3-WG",
			insets = {left = 0, right = 0, top = 0, bottom = 0}
		})
		VPBGQ:Show()
	end




end







function GetAbbr(str)
	local r1, p2, p3, p4 = string.find(str, "(%u).+(%u)")
	if r1 then
		return p3 .. p4
	else
		return ''
	end
end











VPBGQ:RegisterEvent('UPDATE_BATTLEFIELD_STATUS')
VPBGQ:SetScript("OnEvent", function()
	--[[
	local status, mapName, instanceID, lowestlevel, highestlevel, teamSize, registeredMatch = GetBattlefieldStatus(1)
	DEFAULT_CHAT_FRAME:AddMessage('status - ' .. (status or ''))
	DEFAULT_CHAT_FRAME:AddMessage('mapName - ' .. (mapName or ''))
	DEFAULT_CHAT_FRAME:AddMessage('instanceID - ' .. (instanceID or ''))
	DEFAULT_CHAT_FRAME:AddMessage('lowestlevel - ' .. (lowestlevel or ''))
	DEFAULT_CHAT_FRAME:AddMessage('highestlevel - ' .. (highestlevel or ''))
	DEFAULT_CHAT_FRAME:AddMessage('teamSize - ' .. (teamSize or ''))
	DEFAULT_CHAT_FRAME:AddMessage('registeredMatch - ' .. (registeredMatch or ''))
	]]

	local statusBG, statusBGQ, nameBG, nameBGQ

	statusBGQ = 0
	nameBGQ = ''
	-- https://wowwiki-archive.fandom.com/wiki/API_GetBattlefieldStatus
	-- на 2022.03.01 MAX_BATTLEFIELD_QUEUES = 3
	for n = 1, MAX_BATTLEFIELD_QUEUES do
		statusBG, nameBG = GetBattlefieldStatus(n)
		if statusBG == 'queued' then
			if statusBGQ < 1 then
				statusBGQ = 1
				nameBGQ = 'None'
			end
		elseif statusBG == 'confirm' then
			if statusBGQ < 2 then
				statusBGQ = 2
				nameBGQ = GetAbbr(nameBG)
			end
		elseif statusBG == 'active' then
			if statusBGQ < 3 then
				statusBGQ = 3
				nameBGQ = GetAbbr(nameBG)
			end
		end
	end

	if statusBGQ ~= 0 then
		VPBGQ:SetBackdrop({
			bgFile = 'Interface\\AddOns\\\V+Actions\\VPBGQ-' .. statusBGQ .. '-' .. nameBGQ .. '.tga',
			insets = {left = 0, right = 0, top = 0, bottom = 0}
		})
		VPBGQ:Show()
	else
		VPBGQ:Hide()
	end




-- в очереди    - фуксия, красный, черный

-- вход на WSG  - фуксия, синий, желтый
-- вход на AB   - фуксия, синий, зеленый
-- вход на AC   - фуксия, синий, красный
-- вход на AV   - фуксия, синий, голубой

-- битва на WSG - фуксия, белый, желтый
-- битва на AB  - фуксия, белый, зеленый
-- битва на AC  - фуксия, белый, красный
-- битва на AV  - фуксия, белый, голубой

end)


--[[
000000 - черный

ff0000 - красный
00ff00 - зеленый
0000ff - синий

ffff00 - желтый
00ffff - голубой
ff00ff - фуксия

ffffff - белый
]]














SV_Emotes = SV_Emotes or {}
--[[
for i = 1, 170 do
	if	not SV_Emotes[i] then
		SV_Emotes[i] = {}
	end
	for j = 1, 10 do
		if getglobal('EMOTE'..i..'_CMD'..j) then
			table.insert(SV_Emotes[i], 'EMOTE'..i..'_CMD'..j..' = '..getglobal('EMOTE'..i..'_CMD'..j))
		end
	end
end
]]





--[[
SV_Emotes = SV_Emotes or {}

-- самостоятельно выбрать таргет

SLASH_EMOTES_PERSON_ONE1 = "/emo1"
SlashCmdList["EMOTES_PERSON_ONE"] = function()
	local i = 1
	local numEmo = 1
	local numMax = 21

    local frame = CreateFrame('Frame')
    frame:SetScript('OnUpdate', function()
        if i == 100 then
			SendChatMessage(numEmo, 'EMOTE')
		elseif i == 200 then
			DoEmote(_G['EMOTE'..numEmo..'_TOKEN'], 'none')
		elseif i == 300 then
			DoEmote(_G['EMOTE'..numEmo..'_TOKEN'])
		elseif i == 400 then
			i = 1
			numEmo = numEmo + 1
			if numEmo > numMax then
                frame:SetScript('OnUpdate', function() end)
            end
        end
    end)

end



local temp = {}

local emNum = 0
local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_EMOTE")
f:RegisterEvent("CHAT_MSG_TEXT_EMOTE")
f:SetScript("OnEvent", function()
    if event == 'CHAT_MSG_EMOTE' then
		if not SV_Emotes[arg1] then
			SV_Emotes[arg1] = {}
		end
        emNum = arg1
    elseif event == 'CHAT_MSG_TEXT_EMOTE' then
		table.insert(SV_Emotes[emNum], arg1)
    end
end)

]]









--[[

local BackdropMy = {
	--bgFile = 'Interface/DialogFrame/UI-DialogBox-Background', 
	insets = {left = 0, right = 0, top = 0, bottom = 0}
}

local BackdropTooltip = {
	bgFile = 'Interface/DialogFrame/UI-DialogBox-Background',
	--bgFile = 'Interface/Tooltips/UI-Tooltip-Background', 
	edgeFile = 'Interface/Tooltips/UI-Tooltip-Border',
	edgeSize = 16, insets = {left = 5, right = 5, top = 5, bottom = 5}
}


CreateFrame('Frame', 'VPFrmAddon')
VPFrmAddon:SetBackdrop(BackdropMy)
VPFrmAddon:SetPoint('CENTER', UIParent)
--VPFrmAddon:SetWidth(400)
--VPFrmAddon:SetHeight(200)

CreateFrame('Frame', 'VPFrm1', VPFrmAddon)
VPFrm1:SetBackdrop(BackdropTooltip)
VPFrm1:SetPoint('TOPLEFT', VPFrmAddon, 'TOPLEFT', 0, 0)
VPFrm1:SetWidth(140)
VPFrm1:SetHeight(122)

CreateFrame('Frame', 'VPFrm2', VPFrmAddon)
VPFrm2:SetBackdrop(BackdropTooltip)
VPFrm2:SetPoint('TOPLEFT', VPFrm1, 'TOPRIGHT', 0, 0)
VPFrm2:SetWidth(140)
VPFrm2:SetHeight(VPFrm1:GetHeight())

CreateFrame('Frame', 'VPFrm3', VPFrmAddon)
VPFrm3:SetBackdrop(BackdropTooltip)
VPFrm3:SetPoint('TOPLEFT', VPFrm2, 'TOPRIGHT', 0, 0)
VPFrm3:SetWidth(32)
VPFrm3:SetHeight(VPFrm1:GetHeight())

CreateFrame('Frame', 'VPFrm4', VPFrmAddon)
VPFrm4:SetBackdrop(BackdropTooltip)
VPFrm4:SetPoint('TOPLEFT', VPFrm1, 'BOTTOMLEFT', 0, 0)
VPFrm4:SetWidth(VPFrm1:GetWidth() + VPFrm2:GetWidth() + VPFrm3:GetWidth())
VPFrm4:SetHeight(50)



VPFrmAddon:SetWidth(VPFrm1:GetWidth() + VPFrm2:GetWidth() + VPFrm3:GetWidth())
VPFrmAddon:SetHeight(VPFrm1:GetHeight() + VPFrm4:GetHeight())






CreateFrame("Button", "VP_FrameMain2_2", VPFrm1, "UIPanelButtonTemplate")
VP_FrameMain2_2:SetPoint("TOP", VPFrm1, "TOP", 0, -15)
VP_FrameMain2_2:SetHeight(24)
VP_FrameMain2_2:SetWidth(120)
VP_FrameMain2_2:SetText("Warsong Gulch")
VP_FrameMain2_2:SetScript("OnClick", function(self)
	--PlaySound("igMainMenuClose")
	--SendChatMessage('.wsg')
	for i = 1, 170 do
		if	not SV_Emotes[i] then
			SV_Emotes[i] = {}
		end
		for j = 1, 10 do
			if getglobal('EMOTE'..i..'_CMD'..j) then
				table.insert(SV_Emotes[i], 'EMOTE'..i..'_CMD'..j..' = '..getglobal('EMOTE'..i..'_CMD'..j))
			end
		end
	end
end)

CreateFrame("Button", "VP_FrameMain2_3", VPFrm1, "UIPanelButtonTemplate")
VP_FrameMain2_3:SetPoint("TOP", VP_FrameMain2_2, "BOTTOM", 0, -10)
VP_FrameMain2_3:SetHeight(24)
VP_FrameMain2_3:SetWidth(120)
VP_FrameMain2_3:SetText("Arathi Basin")
VP_FrameMain2_3:SetScript("OnClick", function(self)
	PlaySound("igMainMenuClose")
	SendChatMessage('.ab')
end)

CreateFrame("Button", "VP_FrameMain2_4", VPFrm1, "UIPanelButtonTemplate")
VP_FrameMain2_4:SetPoint("TOP", VP_FrameMain2_3, "BOTTOM", 0, -10)
VP_FrameMain2_4:SetHeight(24)
VP_FrameMain2_4:SetWidth(120)
VP_FrameMain2_4:SetText("Azshara Crater")
VP_FrameMain2_4:SetScript("OnClick", function(self)
	PlaySound("igMainMenuClose")
	SendChatMessage('.ac')
end)

]]
































--[[

local BackdropDialogBox = {
	bgFile = 'Interface/DialogFrame/UI-DialogBox-Background', 
	edgeFile = 'Interface/DialogFrame/UI-DialogBox-Border',
	edgeSize = 32, insets = {left = 10, right = 10, top = 10, bottom = 10}
}


CreateFrame('Frame', 'VPFrmAddon')
--VPFrmMain:SetBackdrop(BackdropDialogBox)
VPFrmAddon:SetPoint('CENTER', UIParent)
VPFrmAddon:SetWidth(400)
VPFrmAddon:SetHeight(200)

CreateFrame('Frame', 'VPFrmMenu', VPFrmAddon)
VPFrmMenu:SetBackdrop(BackdropDialogBox)
VPFrmMenu:SetPoint('TOPLEFT', VPFrmAddon, 'TOPLEFT', 0, 0)
VPFrmMenu:SetWidth(132)
VPFrmMenu:SetHeight(200)

CreateFrame('Frame', 'VPFrmMain', VPFrmAddon)
VPFrmMain:SetBackdrop(BackdropDialogBox)
VPFrmMain:SetPoint('TOPRIGHT', VPFrmAddon, 'TOPRIGHT', 0, 0)
VPFrmMain:SetWidth(300)
VPFrmMain:SetHeight(200)


function VPFrmAddon:AddItem(itemName)
end
]]





--[[
CreateFrame('Frame', 'VPFrmAddon')
VPFrmAddon:SetBackdrop(BackdropDialogBox)
VPFrmAddon:SetPoint('CENTER', UIParent)
VPFrmAddon:SetWidth(500)
VPFrmAddon:SetHeight(300)


local BackdropTooltip = {
	edgeFile = 'Interface/Tooltips/UI-Tooltip-Border',
	edgeSize = 16
}

CreateFrame('Frame', 'VPFrmMenu', VPFrmAddon)
VPFrmMenu:SetBackdrop(BackdropTooltip)
VPFrmMenu:SetPoint('TOPLEFT', VPFrmAddon, 'TOPLEFT', 32, -32)
VPFrmMenu:SetWidth(100)
VPFrmMenu:SetHeight(236)

CreateFrame('Frame', 'VPFrmMain', VPFrmAddon)
VPFrmMain:SetBackdrop(BackdropTooltip)
VPFrmMain:SetPoint('TOPRIGHT', VPFrmAddon, 'TOPRIGHT', -32, -32)
VPFrmMain:SetWidth(300)
VPFrmMain:SetHeight(236)



CreateFrame("Button", "VP_MenuButton1", VPFrmMenu, "UIDropDownMenuButtonTemplate")
VP_MenuButton1:SetPoint("TOP", VPFrmMenu, "TOP", 0, -5)
VP_MenuButton1:SetWidth(100)
VP_MenuButton1:SetText("Server Info")
VP_MenuButton1:SetScript("OnClick", function()
end)
VP_MenuButton1Check:Hide()
]]









-- ================================================================================================

--[[
local BackdropDialogBox = {
	bgFile = 'Interface\\DialogFrame\\UI-DialogBox-Background', 
	edgeFile = 'Interface\\DialogFrame\\UI-DialogBox-Border',
	edgeSize = 32, insets = {left = 10, right = 10, top = 10, bottom = 10}
}

CreateFrame('Frame', 'VPFrmMain')
VPFrmMain:SetBackdrop(BackdropDialogBox)
VPFrmMain:SetPoint('CENTER', UIParent)
VPFrmMain:SetWidth(400)
VPFrmMain:SetHeight(200)
--VPFrmMain:SetScript('OnShow', VPFrmMain_OnShow)



CreateFrame('Button', 'VPBtnClose', VPFrmMain, 'UIDropDownMenuButtonTemplate')
VPBtnClose:SetPoint('BOTTOMLEFT', VPFrmMain, 'BOTTOMLEFT', 12, 12)
VPBtnClose:SetWidth(100)
VPBtnClose:SetText('Close')
--VPBtnClose:SetScript('OnClick', VPBtnClose_OnClick)
VPBtnCloseCheck:Hide()




local function VPBtnRequest_OnEnter(self)
	GameTooltip:SetOwner(VPBtnRequest, "ANCHOR_TOP")
	--GameTooltip:AddLine(HELP_BUTTON, 1, 1, 1)
	GameTooltip:AddLine(GetWowRandom(), 1, 1, 1)
	GameTooltip:Show()
end

local function VPBtnRequest_OnLeave(self)
	GameTooltip:Hide()
end

local function VPBtnRequest_OnClick(self)
	VPFrmMain:Hide()
end


CreateFrame('Button', 'VPBtnRequest', VPFrmMain, 'UIDropDownMenuButtonTemplate')
VPBtnRequest:SetPoint('BOTTOM', VPBtnClose, 'TOP', 0, 2)
VPBtnRequest:SetWidth(100)
VPBtnRequest:SetText(HELP_BUTTON)
VPBtnRequest:SetScript('OnEnter', VPBtnRequest_OnEnter) -- возможно правильнее обьявить здесь безвмянную функцую в которой вызывать одну глобальную функцию
VPBtnRequest:SetScript('OnLeave', VPBtnRequest_OnLeave) -- кажется делать функцию "VPBtnRequest_OnEnter" глобальной - не правильно
VPBtnRequest:SetScript('OnClick', VPBtnRequest_OnClick)
VPBtnRequestCheck:Hide()













CreateFrame('Button', 'VPBtnServer', VPFrmMain, 'UIDropDownMenuButtonTemplate')
VPBtnServer:SetPoint('TOPLEFT', VPFrmMain, 'TOPLEFT', 12, -12-2)
VPBtnServer:SetWidth(100)
VPBtnServer:SetText('Server Info')
VPBtnServer:SetScript('OnClick', VPBtnServer_OnClick)
VPBtnServerCheck:Hide()

CreateFrame('Button', 'VPBtnPvp', VPFrmMain, 'UIDropDownMenuButtonTemplate')
VPBtnPvp:SetPoint('TOP', VPBtnServer, 'BOTTOM', 0, -2)
VPBtnPvp:SetWidth(100)
VPBtnPvp:SetText("PvP")
VPBtnPvp:SetScript("OnClick", VPBtnPvp_OnClick)
VPBtnPvpCheck:Hide()

CreateFrame('Button', 'VPBtnPve', VPFrmMain, 'UIDropDownMenuButtonTemplate')
VPBtnPve:SetPoint('TOP', VPBtnPvp, 'BOTTOM', 0, -2)
VPBtnPve:SetWidth(100)
VPBtnPve:SetText("PvE")
VPBtnPve:SetScript("OnClick", VPBtnPve_OnClick)
VPBtnPveCheck:Hide()

]]








--[[



CreateFrame('Frame', 'VP_FrameMain')
VP_FrameMain:SetPoint("CENTER", UIParent)
VP_FrameMain:SetWidth(400)
VP_FrameMain:SetHeight(200)

VP_FrameMain:SetBackdrop({
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	tileSize = 32, edgeSize = 32, 
	insets = {left=11, right=12, top=12, bottom=11}
})
VP_FrameMain:Hide()

VP_FrameMain:SetScript("OnShow", function()
	VP_MenuButton1:Click()
end)

CreateFrame("Button", "VP_MenuButton1", VP_FrameMain, "UIDropDownMenuButtonTemplate")
VP_MenuButton1:SetPoint("TOPLEFT", VP_FrameMain, "TOPLEFT", 10, -12)
VP_MenuButton1:SetWidth(100)
VP_MenuButton1:SetText("Server Info")
VP_MenuButton1:SetScript("OnClick", function()
	getglobal('VP_FrameMain' .. 1):Hide()
	getglobal('VP_FrameMain' .. 2):Hide()
	getglobal('VP_FrameMain' .. 3):Hide()
	getglobal('VP_FrameMain' .. 1):Show()
end)
VP_MenuButton1Check:Hide()

CreateFrame("Button", "VP_MenuButton2", VP_FrameMain, "UIDropDownMenuButtonTemplate")
VP_MenuButton2:SetPoint("TOP", VP_MenuButton1, "BOTTOM", 0, -2)
VP_MenuButton2:SetWidth(100)
VP_MenuButton2:SetText("PvP")
VP_MenuButton2:SetScript("OnClick", function()
	getglobal('VP_FrameMain' .. 1):Hide()
	getglobal('VP_FrameMain' .. 2):Hide()
	getglobal('VP_FrameMain' .. 3):Hide()
	getglobal('VP_FrameMain' .. 2):Show()
end)
VP_MenuButton2Check:Hide()

CreateFrame("Button", "VP_MenuButton3", VP_FrameMain, "UIDropDownMenuButtonTemplate")
VP_MenuButton3:SetPoint("TOP", VP_MenuButton2, "BOTTOM", 0, -2)
VP_MenuButton3:SetWidth(100)
VP_MenuButton3:SetText("PvE")
VP_MenuButton3:SetScript("OnClick", function()
	getglobal('VP_FrameMain' .. 1):Hide()
	getglobal('VP_FrameMain' .. 2):Hide()
	getglobal('VP_FrameMain' .. 3):Hide()
	getglobal('VP_FrameMain' .. 3):Show()
end)
VP_MenuButton3Check:Hide()

CreateFrame("Button", "VP_MenuButton4", VP_FrameMain, "UIDropDownMenuButtonTemplate")
VP_MenuButton4:SetPoint("TOP", VP_MenuButton3, "BOTTOM", 0, -2)
VP_MenuButton4:SetWidth(100)
VP_MenuButton4:SetText(HELP_BUTTON)
VP_MenuButton4:SetScript("OnClick", function()
	ShowUIPanel(HelpFrame)
    StaticPopup_Hide("HELP_TICKET_ABANDON_CONFIRM")
    StaticPopup_Hide("HELP_TICKET")
	VP_FrameMain:Hide()
end)
VP_MenuButton4Check:Hide()








CreateFrame("Button", "VP_MenuButton5", VP_FrameMain, "UIDropDownMenuButtonTemplate")
VP_MenuButton5:SetPoint("TOPLEFT", VP_FrameMain, "BOTTOMLEFT", 10, 0)
VP_MenuButton5:SetWidth(100)
VP_MenuButton5:SetText("Close")
VP_MenuButton5:SetScript("OnClick", function()
	VP_FrameMain:Hide()
end)
VP_MenuButton5Check:Hide() -- спрятать галочку









-- ------------------------------------------------------------------------------------------------

CreateFrame('Frame', 'VP_FrameMain1', VP_FrameMain)
VP_FrameMain1:SetPoint('TOPRIGHT', VP_FrameMain, 'TOPRIGHT', 0, 0)
VP_FrameMain1:SetHeight(200)
VP_FrameMain1:SetWidth(300)
VP_FrameMain1:SetBackdrop({
	--bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	tileSize = 32, edgeSize = 32, 
	insets = {left=11, right=12, top=12, bottom=11}
})
VP_FrameMain1:Hide()

VP_FrameMain1:SetScript("OnShow", function()
	local p1, p2 = GetGameTime()
	VP_FrameMain1_2:SetText('Server time: ' .. p1 .. ':' .. p2)
	SendChatMessage('.server info')
end)

VP_FrameMain1:CreateFontString("VP_FrameMain1_1", "OVERLAY", "GameFontNormalLarge")
VP_FrameMain1_1:SetPoint("TOP", VP_FrameMain1, "TOP", 0, -20)
VP_FrameMain1_1:SetText("Server Info")

VP_FrameMain1:CreateFontString("VP_FrameMain1_2", "OVERLAY", "GameFontHighlight")
VP_FrameMain1_2:SetPoint("TOPLEFT", VP_FrameMain1, "TOPLEFT", 20, -50)
VP_FrameMain1_2:SetText("")

VP_FrameMain1:CreateFontString("VP_FrameMain1_3", "OVERLAY", "GameFontHighlight")
VP_FrameMain1_3:SetPoint("TOPLEFT", VP_FrameMain1_2, "BOTTOMLEFT", 0, -10)
VP_FrameMain1_3:SetText("")

VP_FrameMain1:CreateFontString("VP_FrameMain1_4", "OVERLAY", "GameFontHighlight")
VP_FrameMain1_4:SetPoint("TOPLEFT", VP_FrameMain1_3, "BOTTOMLEFT", 0, -10)
VP_FrameMain1_4:SetText("")

VP_FrameMain1:CreateFontString("VP_FrameMain1_5", "OVERLAY", "GameFontHighlight")
VP_FrameMain1_5:SetPoint("TOPLEFT", VP_FrameMain1_4, "BOTTOMLEFT", 0, -10)
VP_FrameMain1_5:SetText("")

-- ------------------------------------------------------------------------------------------------

CreateFrame('Frame', 'VP_FrameMain2', VP_FrameMain)
VP_FrameMain2:SetPoint('TOPRIGHT', VP_FrameMain, 'TOPRIGHT', 0, 0)
VP_FrameMain2:SetHeight(200)
VP_FrameMain2:SetWidth(300)
VP_FrameMain2:SetBackdrop({
	--bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	tileSize = 32, edgeSize = 32, 
	insets = {left=11, right=12, top=12, bottom=11}
})
VP_FrameMain2:Hide()

VP_FrameMain2:CreateFontString("VP_FrameMain2_1", "OVERLAY", "GameFontNormalLarge")
VP_FrameMain2_1:SetPoint("TOP", VP_FrameMain2, "TOP", 0, -20)
VP_FrameMain2_1:SetText("Battlegrounds")

CreateFrame("Button", "VP_FrameMain2_2", VP_FrameMain2, "UIPanelButtonTemplate")
VP_FrameMain2_2:SetPoint("TOP", VP_FrameMain2, "TOP", 0, -50)
VP_FrameMain2_2:SetHeight(24)
VP_FrameMain2_2:SetWidth(120)
VP_FrameMain2_2:SetText("Warsong Gulch")
VP_FrameMain2_2:SetScript("OnClick", function(self)
	PlaySound("igMainMenuClose")
	SendChatMessage('.wsg')
end)

CreateFrame("Button", "VP_FrameMain2_3", VP_FrameMain2, "UIPanelButtonTemplate")
VP_FrameMain2_3:SetPoint("TOP", VP_FrameMain2_2, "BOTTOM", 0, -10)
VP_FrameMain2_3:SetHeight(24)
VP_FrameMain2_3:SetWidth(120)
VP_FrameMain2_3:SetText("Arathi Basin")
VP_FrameMain2_3:SetScript("OnClick", function(self)
	PlaySound("igMainMenuClose")
	SendChatMessage('.ab')
end)

CreateFrame("Button", "VP_FrameMain2_4", VP_FrameMain2, "UIPanelButtonTemplate")
VP_FrameMain2_4:SetPoint("TOP", VP_FrameMain2_3, "BOTTOM", 0, -10)
VP_FrameMain2_4:SetHeight(24)
VP_FrameMain2_4:SetWidth(120)
VP_FrameMain2_4:SetText("Azshara Crater")
VP_FrameMain2_4:SetScript("OnClick", function(self)
	PlaySound("igMainMenuClose")
	SendChatMessage('.ac')
end)

-- ------------------------------------------------------------------------------------------------

CreateFrame('Frame', 'VP_FrameMain3', VP_FrameMain)
VP_FrameMain3:SetPoint('TOPRIGHT', VP_FrameMain, 'TOPRIGHT', 0, 0)
VP_FrameMain3:SetHeight(200)
VP_FrameMain3:SetWidth(300)
VP_FrameMain3:SetBackdrop({
	--bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	tileSize = 32, edgeSize = 32, 
	insets = {left=11, right=12, top=12, bottom=11}
})
VP_FrameMain3:Hide()

VP_FrameMain3:CreateFontString("VP_FrameMain3_1", "OVERLAY", "GameFontNormalLarge")
VP_FrameMain3_1:SetPoint("TOP", VP_FrameMain3, "TOP", 0, -20)
VP_FrameMain3_1:SetText("Instances")

CreateFrame("Button", "VP_FrameMain3_2", VP_FrameMain3, "UIPanelButtonTemplate")
VP_FrameMain3_2:SetPoint("TOP", VP_FrameMain2, "TOP", 0, -50)
VP_FrameMain3_2:SetHeight(24)
VP_FrameMain3_2:SetWidth(140)
VP_FrameMain3_2:SetText(RESET_INSTANCES)
VP_FrameMain3_2:SetScript("OnClick", function(self)
	PlaySound("igMainMenuClose")
	ResetInstances()
end)

-- ------------------------------------------------------------------------------------------------

VP_FrameMain:RegisterEvent('PLAYER_LOGIN')
VP_FrameMain:RegisterEvent('CHAT_MSG_SYSTEM')
VP_FrameMain:SetScript("OnEvent", function()
	if event == 'PLAYER_LOGIN' then
		HelpMicroButton:SetNormalTexture("Interface\\AddOns\\\V+Main\\UI-MicroButtonVP-Up.tga")
		ToggleHelpFrame = function()
			if VP_FrameMain:IsVisible() then
				VP_FrameMain:Hide()
			  else
				VP_FrameMain:Show()
			  end
		end
	elseif event == 'CHAT_MSG_SYSTEM' then
		local strOnline1 = '^Players online: (.+)%. Max online: (.+)%.$'
		local strOnline2 = '^Server uptime: (.+)%.$'

		local posBeg, posEnd, param1, param2 = string.find(arg1, strOnline1)
		if posBeg then
			VP_FrameMain1_3:SetText('Players online: ' .. param1)
			VP_FrameMain1_4:SetText('Max online: ' .. param2)
		else
			posBeg, posEnd, param1 = string.find(arg1, strOnline2)
			if posBeg then
				VP_FrameMain1_5:SetText('Server uptime: ' .. param1)
			end
		end
	end
end)

]]