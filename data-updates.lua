require "__FreightForwarding__/prototypes/crating-machine"
require "__FreightForwarding__/prototypes/inventory-sizes"
require "__FreightForwarding__/prototypes/stack-sizes"
require "__FreightForwarding__/prototypes/recipe-updates"

local collision_mask_util = require "__core__.lualib.collision-mask-util"

for _, tile in pairs(data.raw.tile) do
  tile.check_collision_with_entities = true
end

-- Prevent concrete, etc, from being placed on landfill because now that landfill is minable, it would return the item
local landfill_collision_mask = collision_mask_util.get_first_unused_layer()
log("FF landfill_collision_mask assigned to " .. landfill_collision_mask)

collision_mask_util.add_layer(data.raw.tile.landfill.collision_mask, landfill_collision_mask)  -- (tiles much have `collision_mask`)

for name, item in pairs(data.raw.item) do
  if item.place_as_tile and name ~= "landfill" then
    collision_mask_util.add_layer(item.place_as_tile.condition, landfill_collision_mask)
  end
end

-- Compatibility
require "__FreightForwarding__/compatibility/aai-industry/data-updates"
require "__FreightForwarding__/compatibility/aai-vehicles-ironclad/data-updates"
require "__FreightForwarding__/compatibility/big-mining-drill/data-updates"
require "__FreightForwarding__/compatibility/concentrated-solar/data-updates"
require "__FreightForwarding__/compatibility/krastorio2/data-updates"
require "__FreightForwarding__/compatibility/plutonium-energy/data-updates"
require "__FreightForwarding__/compatibility/rocket-silo-construction/data-updates"
require "__FreightForwarding__/compatibility/underwater-pipes/data-updates"
