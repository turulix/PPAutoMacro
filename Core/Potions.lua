local addonName, pp = ...

pp.UltimatePower1 = pp.Item.new(191381, "Elemental Potion of Ultimate Power")
pp.UltimatePower2 = pp.Item.new(191382, "Elemental Potion of Ultimate Power")
pp.UltimatePower3 = pp.Item.new(191383, "Elemental Potion of Ultimate Power")

pp.FleetUltimatePower1 = pp.Item.new(191912, "Fleeting Elemental Potion of Ultimate Power")
pp.FleetUltimatePower2 = pp.Item.new(191913, "Fleeting Elemental Potion of Ultimate Power")
pp.FleetUltimatePower3 = pp.Item.new(191914, "Fleeting Elemental Potion of Ultimate Power")

pp.Power1 = pp.Item.new(191387, "Elemental Potion of Power")
pp.Power2 = pp.Item.new(191388, "Elemental Potion of Power")
pp.Power3 = pp.Item.new(191389, "Elemental Potion of Power")

pp.FleetPower1 = pp.Item.new(191905, "Fleeting Elemental Potion of Power")
pp.FleetPower2 = pp.Item.new(191906, "Fleeting Elemental Potion of Power")
pp.FleetPower3 = pp.Item.new(191907, "Fleeting Elemental Potion of Power")

pp.Shocking1 = pp.Item.new(191399, "Potion of Shocking Disclosure")
pp.Shocking2 = pp.Item.new(191400, "Potion of Shocking Disclosure")
pp.Shocking3 = pp.Item.new(191401, "Potion of Shocking Disclosure")

function pp.getPots()
    local pots = {
        pp.FleetUltimatePower3,
        pp.FleetUltimatePower2,
        pp.FleetUltimatePower1,
        pp.FleetPower3,
        pp.FleetPower2,
        pp.FleetPower1,
        pp.UltimatePower3,
        pp.UltimatePower2,
        pp.UltimatePower1,
        pp.Power3,
        pp.Power2,
        pp.Power1
    }

    local _, type = GetInstanceInfo()
    if PPDB.useSchockingDiscolure and type == "party" then
        table.insert(pots, 0, pp.Shocking1)
        table.insert(pots, 0, pp.Shocking2)
        table.insert(pots, 0, pp.Shocking3)
    end
    return pots
end
