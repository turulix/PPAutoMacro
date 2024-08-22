local addonName, pp = ...

pp[phialPrefix] = {}
-- Lower => Higher priority
phialData = {
    useAlchemicalChaos = {
        { key = "AlchemicalChaos", tierIDs = { 212281, 212282, 212283 } };
        { key = "FleetAlchemicalChaos", tierIDs = { 212739, 212740, 212741 } };
    },
    useTemperedMastery = {
        { key = "TemperedMastery", tierIDs = { 212278, 212279, 212280 } };
        { key = "FleetTemperedMastery", tierIDs = { 212735, 212736, 212738 } };
    },
    useTemperedSwiftness = {
        { key = "TemperedSwiftness", tierIDs = { 212272, 212273, 212274 } };
        { key = "FleetTemperedSwiftness", tierIDs = { 212729, 212730, 212731 } };
    },
    useTemperedVersatility = {
        { key = "TemperedVersatility", tierIDs = { 212275, 212276, 212277 } };
        { key = "FleetTemperedVersatility", tierIDs = { 212732, 212733, 212734 } };
    },
    useTemperedAggression = {
        { key = "TemperedAggression", tierIDs = { 212269, 212270, 212271 } };
        { key = "FleetTemperedAggression", tierIDs = { 212725, 212727, 212728 } };
    },
    useSavingGraces = {
        { key = "SavingGraces", tierIDs = { 212299, 212300, 212301 } };
        { key = "FleetSavingGraces", tierIDs = { 212745, 212746, 212747 } };
    }
}

for _, phialRoots in pairs(phialData) do
    for _, phial in ipairs(phialRoots) do
        for _, id in ipairs(phial.tierIDs) do
            pp[phialPrefix][id] = pp.PPItem.new(id)
        end
    end
end

function pp.getPhials()
    local phials = {}

    for settingsKey, phialRoots in pairs(phialData) do
        -- phialType is a table with key and tierIDs
        for _, phialType in pairs(phialRoots) do
            for _, id in ipairs(phialType.tierIDs) do
                if PPDB[phialPrefix][settingsKey] then
                    table.insert(phials, 1, pp[phialPrefix][id])
                end
            end
        end
    end

    return phials
end
