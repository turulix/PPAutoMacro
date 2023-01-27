local addonName, pp = ...

local defaults = {
    useSchockingDiscolure = false,
}

local panel = CreateFrame("Frame")

function panel:OnEvent(event, addOnName)
    if addOnName == "PPAutoMacro" then
        PPDB = PPDB or CopyTable(defaults)
        self.db = PPDB
        self:InitializeOptions()
    end
end

panel:RegisterEvent("ADDON_LOADED")
panel:SetScript("OnEvent", panel.OnEvent)

function panel:InitializeOptions()
    self.panel = CreateFrame("Frame")
    self.panel.name = "Potion of Power Auto Macro"
    -- Title
    local title = self.panel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
    title:SetPoint("Top", 0, -5)
    title:SetText("Potion of Power Auto Macro")

    -- Subtitle
    local subtitle = self.panel:CreateFontString("ARTWORK", nil, "GameFontNormal")
    subtitle:SetPoint("TOPLEFT", 20, -30)
    subtitle:SetText("Here you can configure the behaviour of the Addon.")

    -- M+ Override
    local useSchockingDiscolureButton = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    useSchockingDiscolureButton:SetPoint("TOPLEFT", subtitle, 20, -30)
    useSchockingDiscolureButton.Text:SetText("Use Schocking Discolure in Dungeons")
    useSchockingDiscolureButton:HookScript("OnClick", function(_, btn, down)
        self.db.useSchockingDiscolure = useSchockingDiscolureButton:GetChecked()
        pp.PPAM_UPDATE(nil, nil)
    end)

    useSchockingDiscolureButton:SetChecked(self.db.useSchockingDiscolure)

    InterfaceOptions_AddCategory(self.panel)
end

SLASH_PPAM1 = "/ppam"
SlashCmdList.PPAM = function(msg, editBox)
    InterfaceOptionsFrame_OpenToCategory(panel.panel)
end
