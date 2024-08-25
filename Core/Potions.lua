local addonName, pp = ...

pp[potionPrefix] = {}

-- Lower => Higher priority
potionData = {
    useFrontlinePotion = {
        { key = "FrontlinePower", tierIDs = { 212260, 212261, 212262 } };
        { key = "FleetFrontlinePower", tierIDs = { 212966, 212967, 212968 } };
    },
    useGrotesqueVials = {
        { key = "GrotesqueVials", tierIDs = { 212254, 212255, 212256 } };
        { key = "FleetGrotesqueVials", tierIDs = { 212960, 212961, 212962 } };
    },
    useTemperedPotions = {
        { key = "TemperedPotions", tierIDs = { 212263, 212264, 212265 } };
        { key = "FleetTemperedPotions", tierIDs = { 212969, 212970, 212971 } };
    },
    usePotionOfUnwaveringFocus = {
        { key = "PotionOfUnwaveringFocus", tierIDs = { 212257, 212258, 212259 } };
        { key = "FleetPotionOfUnwaveringFocus", tierIDs = { 212963, 212964, 212965 } };
    },
}

for _, potionRoot in pairs(potionData) do
    for _, potion in ipairs(potionRoot) do
        for _, id in ipairs(potion.tierIDs) do
            pp[potionPrefix][id] = pp.PPItem.new(id)
        end
    end
end

function pp.getPots()
    local pots = {}

    for settingsKey, potionRoot in pairs(potionData) do
        for _, potion in ipairs(potionRoot) do
            for _, id in ipairs(potion.tierIDs) do
                if PPDB[potionPrefix][settingsKey] then
                    table.insert(pots, 1, pp[potionPrefix][id])
                end
            end
        end
    end

    --local _, type = GetInstanceInfo()
    --if PPDB["Potion"]["useShockingDisclosureInDungeons"] and type == "party" then
    --    table.insert(pots, 1, pp["PotionShockingDisclosure1"])
    --    table.insert(pots, 1, pp["PotionShockingDisclosure2"])
    --    table.insert(pots, 1, pp["PotionShockingDisclosure3"])
    --end
    return pots
end
