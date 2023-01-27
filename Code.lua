local addonName, pp = ...
local macroName = "PPAutoPot"

local function createMacroIfMissing()
    local name = GetMacroInfo(macroName)
    if name == nil then
        CreateMacro(macroName, "INV_Misc_QuestionMark")
    end
end

local function updateMacro()
    local resetType = "combat"
    local itemsString = ""
    if next(pp.itemIdList) == nil then
        pp.macroStr = "#showtooltip"
    else
        if next(pp.itemIdList) ~= nil then
            for i, v in ipairs(pp.itemIdList) do
                if i == 1 then
                    itemsString = "item:" .. v;
                else
                    itemsString = itemsString .. ", " .. "item:" .. v;
                end
            end
        end
        pp.macroStr = "#showtooltip \n/castsequence reset=" .. resetType .. " "
        if itemsString ~= "" then
            pp.macroStr = pp.macroStr .. itemsString
        end
    end
    createMacroIfMissing()
    EditMacro(macroName, macroName, nil, pp.macroStr)
end

local function addPotIfAvailable()
    pots = pp.getPots()
    for iterator, value in ipairs(pots) do
        if value.getCount() > 0 then
            table.insert(pp.itemIdList, value.getId())
            --we break because all Pots share a cd so we only want the highest power potion
            break ;
        end
    end
end

local function updateAvailablePots()
    pp.itemIdList = {}
    addPotIfAvailable()
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
