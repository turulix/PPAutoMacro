local addonName, pp = ...

local prefix = "Potion"
-- Lower => Higher priority
potionData = {
    { key = "Power", tierIDs = { 191387, 191388, 191389 }, skip = false, desc = "Elemental Potion of Power" };
    { key = "UltimatePower", tierIDs = { 191381, 191382, 191383 }, skip = false, desc = "Elemental Potion of Ultimate Power" };
    { key = "FleetPower", tierIDs = { 191905, 191906, 191907 }, skip = false, desc = "Fleeting Elemental Potion of Power" };
    { key = "FleetUltimatePower", tierIDs = { 191912, 191913, 191914 }, skip = false, desc = "Fleeting Elemental Potion of Ultimate Power" };
    { key = "ShockingDisclosure", tierIDs = { 191399, 191400, 191401 }, skip = true, desc = "Potion of Shocking Disclosure" };
}

for _, potion in pairs(potionData) do
    for tier, id in ipairs(potion.tierIDs) do
        pp[prefix .. potion.key .. tier] = pp.Item.new(id, potion.desc)
    end
end

function pp.getPots()
    local pots = {}

    for _, potion in pairs(potionData) do
        for index, _ in ipairs(potion.tierIDs) do
            if not potion.skip then
                table.insert(pots, 1, pp[prefix .. potion.key .. index])
            end
        end
    end

    local _, type = GetInstanceInfo()
    if PPDB["Potion"]["useShockingDisclosureInDungeons"] and type == "party" then
        table.insert(pots, 1, pp["PotionShockingDisclosure1"])
        table.insert(pots, 1, pp["PotionShockingDisclosure2"])
        table.insert(pots, 1, pp["PotionShockingDisclosure3"])
    end
    return pots
end
