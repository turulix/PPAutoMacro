local addonName, pp = ...

local rowOffset = -30
local categoryId = nil
local potionSettings = {
    { name = "useShockingDisclosureInDungeons", default = false, desc = "Use Potion of Shocking Disclosure in dungeons" };
}
local phialSettings = {
    { name = "useAlacrity", default = false, desc = "Use Charged Phial of Alacrity" };
    { name = "useCorruptingRage", default = false, desc = "Use Iced Phial of Corrupting Rage" };
    { name = "useChargedIsolation", default = false, desc = "Use Phial of Charged Isolation" };
    { name = "useElementalChaos", default = false, desc = "Use Phial of Elemental Chaos" };
    { name = "useGlacialFury", default = false, desc = "Use Phial of Glacial Fury" };
    { name = "useIcyPreservation", default = false, desc = "Use Phial of Icy Preservation" };
    { name = "useStaticEmpowerment", default = false, desc = "Use Phial of Static Empowerment" };
    { name = "useStillAir", default = false, desc = "Use Phial of Still Air" };
    { name = "useTepidVersatility", default = true, desc = "Use Phial of Tepid Versatility" };
    { name = "useEyeStorm", default = false, desc = "Use Phial of the Eye in the Storm" };
}

local settings = {
    { key = "Potion", values = potionSettings };
    { key = "Phial", values = phialSettings };
}

local panel = CreateFrame("Frame")

function panel:OnEvent(event, addOnName)
    if addOnName == "PPAutoMacro" then
        if not PPDB then
            PPDB = {}
        end

        for _, setting in ipairs(settings) do
            if PPDB[setting.key] == nil then
                PPDB[setting.key] = {}
            end

            for _, v in ipairs(setting.values) do
                if PPDB[setting.key][v.name] == nil then
                    PPDB[setting.key][v.name] = v.default
                end
            end
        end
        self.db = PPDB
        self:InitializeOptions()
    end
end

panel:RegisterEvent("ADDON_LOADED")
panel:SetScript("OnEvent", panel.OnEvent)

function panel:InitializeOptions()
    self.panel = CreateFrame("Frame")
    self.panel.name = "Potion & Phial Auto Macro"
    -- Title
    local title = self.panel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
    title:SetPoint("Top", 0, -5)
    title:SetText("Potion & Phial Auto Macro")

    local iterCounter = 1

    -- Subtitle
    local subtitle = self.panel:CreateFontString("ARTWORK", nil, "GameFontNormal")
    subtitle:SetPoint("TOPLEFT", 20, iterCounter * rowOffset)
    subtitle:SetText("Here you can configure the behaviour of the Addon.")


    for _, v in ipairs(potionSettings) do
        iterCounter = iterCounter + 1
        local button = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
        button:SetPoint("TOPLEFT", subtitle, 20, iterCounter * rowOffset)
        button.Text:SetText(v.desc)
        button:SetChecked(self.db["Potion"][v.name])
        button:HookScript("OnClick", function(_, btn, down)
            self.db["Potion"][v.name] = not self.db["Potion"][v.name]
            pp[v.name .. "Button"]:SetChecked(self.db["Potion"][v.name])
            pp.PPAM_UPDATE(nil, nil)
        end)

        pp[v.name .. "Button"] = button
    end

    iterCounter = iterCounter + 1
    local phialText = self.panel:CreateFontString("ARTWORK", nil, "GameFontNormal")
    phialText:SetPoint("TOPLEFT", subtitle, 20, rowOffset * iterCounter - 10)
    phialText:SetText("------ Phials to use ------")


    for _, v in ipairs(phialSettings) do
        iterCounter = iterCounter + 1
        local button = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
        button:SetPoint("TOPLEFT", subtitle, 20, iterCounter * rowOffset)
        button.Text:SetText(v.desc)
        button:SetChecked(self.db["Phial"][v.name])
        button:HookScript("OnClick", function(_, btn, down)
            local name = v.name
            for k in pairs(self.db["Phial"]) do
                self.db["Phial"][k] = false
                pp[k .. 'Button']:SetChecked(false)
            end
            self.db["Phial"][name] = true
            pp[name .. "Button"]:SetChecked(self.db["Phial"][name])
            pp.PPAM_UPDATE(nil, nil)
        end)

        pp[v.name .. "Button"] = button

    end

    local category, layout = Settings.RegisterCanvasLayoutCategory(self.panel, "PPAutoMacro");
	Settings.RegisterAddOnCategory(category);
	categoryId = category:GetID()
end

SLASH_PPAM1 = "/ppam"
SlashCmdList.PPAM = function(msg, editBox)
	Settings.OpenToCategory(categoryId)
end
