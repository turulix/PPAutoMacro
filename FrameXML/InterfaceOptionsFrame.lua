local addonName, pp = ...

buttonPrefix = "Button"
pp[buttonPrefix] = {}
pp[buttonPrefix][potionPrefix] = {}
pp[buttonPrefix][phialPrefix] = {}

local rowOffset = -30

local panel = CreateFrame("Frame")

function panel:OnEvent(event, addOnName)
    if addOnName == "PPAutoMacro" then
        if not PPDB then
            PPDB = {}
        end

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

    for settingsKey, potionRoot in pairs(potionData) do
        iterCounter = iterCounter + 1
        local button = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
        button:SetPoint("TOPLEFT", subtitle, 20, iterCounter * rowOffset)
        --- @type PPItem
        local item = pp[potionPrefix][potionRoot[1].tierIDs[3]]

        item.getItem():ContinueOnItemLoad(function()
            button.Text:SetText("Use " .. item.getName())
        end)

        button:HookScript("OnEnter", function()
            GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
            GameTooltip:SetItemByID(item.getId())
            GameTooltip:Show()
        end)
        button:HookScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        button:HookScript("OnClick", function(_, btn, down)

            for setKey, _ in pairs(PPDB[potionPrefix]) do
                PPDB[potionPrefix][setKey] = false
                if pp[buttonPrefix][potionPrefix][setKey] then
                    pp[buttonPrefix][potionPrefix][setKey]:SetChecked(false)
                else
                    -- Remove old settings
                    PPDB[potionPrefix][setKey] = nil
                end
            end

            PPDB[potionPrefix][settingsKey] = true
            pp[buttonPrefix][potionPrefix][settingsKey]:SetChecked(PPDB[potionPrefix][settingsKey])
            pp.PPAM_UPDATE(nil, nil)
        end)

        button:SetChecked(PPDB[potionPrefix][settingsKey])
        pp[buttonPrefix][potionPrefix][settingsKey] = button
    end

    iterCounter = iterCounter + 1
    local phialText = self.panel:CreateFontString("ARTWORK", nil, "GameFontNormal")
    phialText:SetPoint("TOPLEFT", subtitle, 20, rowOffset * iterCounter - 10)
    phialText:SetText("------ Phials to use ------")

    for settingsKey, phialRoot in pairs(phialData) do
        iterCounter = iterCounter + 1
        local button = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
        button:SetPoint("TOPLEFT", subtitle, 20, iterCounter * rowOffset)
        --- @type PPItem
        local item = pp[phialPrefix][phialRoot[1].tierIDs[3]]

        item.getItem():ContinueOnItemLoad(function()
            button.Text:SetText("Use " .. item.getName())
        end)

        button:HookScript("OnEnter", function()
            GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
            GameTooltip:SetItemByID(item.getId())
            GameTooltip:Show()
        end)
        button:HookScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        button:HookScript("OnClick", function(_, btn, down)

            for setKey, _ in pairs(PPDB[phialPrefix]) do
                PPDB[phialPrefix][setKey] = false
                if pp[buttonPrefix][phialPrefix][setKey] then
                    pp[buttonPrefix][phialPrefix][setKey]:SetChecked(false)
                else
                    -- Remove old settings
                    PPDB[phialPrefix][setKey] = nil
                end
            end

            PPDB[phialPrefix][settingsKey] = true
            pp[buttonPrefix][phialPrefix][settingsKey]:SetChecked(PPDB[phialPrefix][settingsKey])
            pp.PPAM_UPDATE(nil, nil)
        end)

        button:SetChecked(PPDB[phialPrefix][settingsKey])
        pp[buttonPrefix][phialPrefix][settingsKey] = button
    end

    local category, layout = Settings.RegisterCanvasLayoutCategory(self.panel, "PPAutoMacro");
    Settings.RegisterAddOnCategory(category);
    categoryId = category:GetID()
end

SLASH_PPAM1 = "/ppam"
SlashCmdList.PPAM = function(msg, editBox)
    Settings.OpenToCategory(categoryId)
end
