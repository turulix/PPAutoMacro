local addonName, pp = ...

local prefix = "Potion"

potionData = {
    useElementalPotionOfUltimatePower = {
        { key = "UltimatePower", tierIDs = { 191381, 191382, 191383 }, skip = false, desc = "Elemental Potion of Ultimate Power" };
        { key = "FleetUltimatePower", tierIDs = { 191912, 191913, 191914 }, skip = false, desc = "Fleeting Elemental Potion of Ultimate Power" };
    },
    useElementalPotionOfPower = {
        { key = "Power", tierIDs = { 191387, 191388, 191389 }, skip = false, desc = "Elemental Potion of Power" };
        { key = "FleetPower", tierIDs = { 191905, 191906, 191907 }, skip = false, desc = "Fleeting Elemental Potion of Power" };
    },
    useShockingDisclosure = {
        { key = "ShockingDisclosure", tierIDs = { 191399, 191400, 191401 }, skip = true, desc = "Potion of Shocking Disclosure" };
    }
}

for root, vars in pairs(potionData) do
    for _, ph in ipairs(vars) do
        for tier, id in ipairs(ph.tierIDs) do
            pp[prefix .. ph.key .. tier] = pp.Item.new(id, ph.desc)
        end
    end
end

function pp.getPots()
    local pots = {}

    for _, vars in pairs(potionData) do
        for _, ph in ipairs(vars) do
            for tier, id in ipairs(ph.tierIDs) do
                if not ph.skip then
                    table.insert(pots, 1, pp[prefix .. ph.key .. tier])
                end
            end
        end
    end

    local _, type = GetInstanceInfo()
    if PPDB["Potion"]["useSchockingDisclosureInDungeons"] and type == "party" then
        table.insert(pots, 1, pp["PotionShockingDisclosure1"])
        table.insert(pots, 1, pp["PotionShockingDisclosure2"])
        table.insert(pots, 1, pp["PotionShockingDisclosure3"])
    end
    return pots
end
