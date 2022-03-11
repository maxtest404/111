-- https://wowwiki-archive.fandom.com/wiki/Using_bindings.xml_to_create_key_bindings_for_your_addon
-- https://www.youtube.com/watch?v=jAKkIfLBJ4g
-- https://github.com/Geigerkind/VCB - интересный интерфейс для окна аддона
-- https://github.com/oppahansi/WoW-UIs/tree/master/Vanilla - различные интефейсы для самой игры
-- https://github.com/mrrosh/VanillaGraphicBoost


function GetWowRandom()
	return '111'
end


function VPBtnRequest_OnEnter(self)
	GameTooltip:SetOwner(VPBtnRequest, "ANCHOR_TOP")
	--GameTooltip:AddLine(HELP_BUTTON, 1, 1, 1)
	GameTooltip:AddLine(GetWowRandom(), 1, 1, 1)
	GameTooltip:Show()
end

function VPBtnRequest_OnLeave(self)
	GameTooltip:Hide()
end

function VPBtnRequest_OnClick(self)
	VPFrmMain:Hide()
end