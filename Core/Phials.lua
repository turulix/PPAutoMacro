local addonName, pp = ...

local prefix = "Phial"
-- Lower => Higher priority
phialData = {
    useAlacrity = {
        { key = "Alacrity", tierIDs = { 191348, 191349, 191350 }, desc = "Charged Phial of Alacrity" };
        { key = "FleetAlacrity", tierIDs = { 204667, 204668, 204669 }, desc = "Fleeting Charged Phial of Alacrity" };
    },
    useCorruptingRage = {
        { key = "CorruptingRage", tierIDs = { 191327, 191328, 191329 }, desc = "Iced Phial of Corrupting Rage" };
        { key = "FleetCorruptingRage", tierIDs = { 204652, 204653, 204654 }, desc = "Fleeting Iced Phial of Corrupting Rage" };
    },
    useChargedIsolation = {
        { key = "ChargedIsolation", tierIDs = { 191330, 191331, 191332 }, desc = "Phial of Charged Isolation" };
        { key = "FleetChargedIsolation", tierIDs = { 204655, 204656, 204657 }, desc = "Fleeting Phial of Charged Isolation" };
    },
    useElementalChaos = {
        { key = "ElementalChaos", tierIDs = { 191357, 191358, 191359 }, desc = "Phial of Elemental Chaos" };
        { key = "FleetElementalChaos", tierIDs = { 204670, 204671, 204672 }, desc = "Fleeting Phial of Elemental Chaos" };
    },
    useGlacialFury = {
        { key = "GlacialFury", tierIDs = { 191333, 191334, 191335 }, desc = "Phial of Glacial Fury" };
        { key = "FleetGlacialFury", tierIDs = { 204658, 204659, 204660 }, desc = "Fleeting Phial of Glacial Fury" };
    },
    useIcyPreservation = {
        { key = "IcyPreservation", tierIDs = { 191324, 191325, 191326 }, desc = "Phial of Icy Preservation" };
        { key = "FleetIcyPreservation", tierIDs = { 204649, 204650, 204651 }, desc = "Fleeting Phial of Icy Preservation" };
    },
    useStaticEmpowerment = {
        { key = "StaticEmpowerment", tierIDs = { 191336, 191337, 191338 }, desc = "Phial of Static Empowerment" };
        { key = "FleetStaticEmpowerment", tierIDs = { 204661, 204662, 204663 }, desc = "Fleeting Phial of Static Empowerment" };
    },
    useStillAir = {
        { key = "StillAir", tierIDs = { 191321, 191322, 191323 }, desc = "Phial of Still Air" };
        { key = "FleetStillAir", tierIDs = { 204646, 204647, 204648 }, desc = "Fleeting Phial of Still Air" };
    },
    useTepidVersatility = {
        { key = "TepidVersatility", tierIDs = { 191339, 191340, 191341 }, desc = "Phial of Tepid Versatility" };
        { key = "FleetTepidVersatility", tierIDs = { 204664, 204665, 204666 }, desc = "Fleeting Phial of Tepid Versatility" };
    },
    useEyeStorm = {
        { key = "EyeStorm", tierIDs = { 191318, 191319, 191320 }, desc = "Phial of the Eye in the Storm" };
        { key = "FleetEyeStorm", tierIDs = { 204643, 204644, 204645 }, desc = "Fleeting Phial of the Eye in the Storm" };
    }
}

for _, phialRoots in pairs(phialData) do
    for _, potion in ipairs(phialRoots) do
        for index, id in ipairs(potion.tierIDs) do
            pp[prefix .. potion.key .. index] = pp.Item.new(id, potion.desc)
        end
    end
end

function pp.getPhials()
    local phials = {}

    for settingsKey, phialRoots in pairs(phialData) do
        for _, phial in ipairs(phialRoots) do
            for index, _ in ipairs(phial.tierIDs) do
                if PPDB["Phial"][settingsKey] then
                    table.insert(phials, 1, pp[prefix .. phial.key .. index])
                end
            end
        end
    end

    return phials
end
