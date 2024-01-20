local addonName, pp = ...
local potionMacroName = "PPAutoPot"
local phialMacroName = "PPAutoPhial"

local function createMacroIfMissing()
    if GetMacroInfo(potionMacroName) == nil then
        CreateMacro(potionMacroName, "INV_Misc_QuestionMark")
    end
    if GetMacroInfo(phialMacroName) == nil then
        CreateMacro(phialMacroName, "INV_Misc_QuestionMark")
    end
end

local function buildMacroString(items)
    local resetType = "combat"
    local itemsString = ""
    if next(items) == nil then
        return "#showtooltip"
    else
        if next(items) ~= nil then
            for i, v in ipairs(items) do
                if i == 1 then
                    itemsString = "item:" .. v;
                else
                    itemsString = itemsString .. ", " .. "item:" .. v;
                end
            end
        end
        return "#showtooltip \n/castsequence reset=" .. resetType .. " " .. itemsString
    end
end

local function updateMacro()
    createMacroIfMissing()
    EditMacro(potionMacroName, potionMacroName, nil, buildMacroString(pp.availablePotions))
    EditMacro(phialMacroName, phialMacroName, nil, buildMacroString(pp.availablePhials))
end

local function addPotionIfAvailable()
    pots = pp.getPots()
    for iterator, value in ipairs(pots) do
        if value.getCount() > 0 then
            table.insert(pp.availablePotions, value.getId())
            --we break because all Pots share a cd so we only want the highest power potion
            break ;
        end
    end
end

local function addPhialIfAvailable()
    phials = pp.getPhials()
    for iterator, value in ipairs(phials) do
        if value.getCount() > 0 then
            table.insert(pp.availablePhials, value.getId())
            --we break because all Pots share a cd so we only want the highest power potion
            break ;
        end
    end
end

local function updateAvailablePots()
    pp.availablePotions = {}
    pp.availablePhials = {}
    addPotionIfAvailable()
    addPhialIfAvailable()
end

local onCombat = true
function pp.PPAM_UPDATE(self, event, ...)
    if event == "PLAYER_LOGIN" then
        onCombat = false
    end
    if event == "PLAYER_REGEN_DISABLED" then
        onCombat = true
        return
    end
    if event == "PLAYER_REGEN_ENABLED" then
        onCombat = false
    end

    if onCombat == false then
        updateAvailablePots()
        updateMacro()
    end
end

local PPAutoPotIcon = CreateFrame("Frame")
PPAutoPotIcon:RegisterEvent("BAG_UPDATE")
PPAutoPotIcon:RegisterEvent("PLAYER_LOGIN")
PPAutoPotIcon:RegisterEvent("TRAIT_CONFIG_UPDATED")
PPAutoPotIcon:RegisterEvent("PLAYER_REGEN_ENABLED")
PPAutoPotIcon:RegisterEvent("PLAYER_REGEN_DISABLED")
PPAutoPotIcon:SetScript("OnEvent", pp.PPAM_UPDATE)
