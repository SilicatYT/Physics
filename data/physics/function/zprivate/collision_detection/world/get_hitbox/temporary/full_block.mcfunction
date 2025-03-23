# SET THESE AT THE END OF THE PREVIOUS BLOCK IF ITS DATA WAS DIFFERENT, SO THESE SCORES DONT HAVE TO BE SET EVERY TIME
scoreboard players set #Physics.BlockDiagonalLength Physics 1732
scoreboard players set #Physics.HitboxIsTouching Physics 0

# Block Hitbox (Change min and max)
scoreboard players remove #Physics.Projection.Block.WorldAxis.x.Min Physics 500
scoreboard players add #Physics.Projection.Block.WorldAxis.x.Max Physics 500
scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Min Physics 500
scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 500
scoreboard players remove #Physics.Projection.Block.WorldAxis.z.Min Physics 500
scoreboard players add #Physics.Projection.Block.WorldAxis.z.Max Physics 500

# Run SAT
function physics:zprivate/collision_detection/world/sat

# Update the previous tick's contacts with that hitbox
# (Important): It needs to make sure that it only runs the "update" function if data for this hitbox was found, and remember that "set storage from storage" keeps the previous value if the source is empty or not found.
execute if score #Physics.HitboxIsTouching Physics matches 1 store success score #Physics.HitboxHasPreviousContacts Physics run data modify storage physics:temp data.Hitbox set from storage physics:temp data.Block.Hitboxes[{ID:1b}]
execute if score #Physics.HitboxIsTouching Physics matches 1 if score #Physics.HitboxHasPreviousContacts Physics matches 1 run data remove storage physics:temp data.Block.Hitboxes[{ID:1b}]
execute if score #Physics.HitboxIsTouching Physics matches 1 if score #Physics.HitboxHasPreviousContacts Physics matches 1 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_hitbox

# Update the previous tick's contacts for hitboxes that aren't touching but belong to the same block
execute store result score #Physics.BlockRemainingHitboxCount Physics if data storage physics:temp data.Block.Hitboxes[]
#execute if score #Physics.BlockRemainingHitboxCount Physics matches 1.. run function physics:zprivate/contact_generation/accumulate/world/touching/update_remaining_hitboxes
# CAN BE INLINED




# NOTE: IT SHOULD NOT REMOVE THE BLOCK FROM THE HITBOXES IF IT'S THERE'S ONLY ONE HITBOX (remaining?) ANYWAY.

# NOTE: (RESOLVED) I should initially clear the physics:temp data.Hitbox storage or smth like that (or use store success), BECAUSE IT CAN KEEP THE PREVIOUS HITBOX'S DATA IF NONE IS SET.
# NOTE: (RESOLVED) ^ SAME WITH new_contact/get_previous_contacts (& IS THERE EVEN CODE IN CASE THE BLOCK HAS NO DATA? LIKE, DOES IT NOT RUN ACCUMULATION THEN?)
# NOTE: (RESOLVED) ^ SAME WITH accumulate/get_previous_contacts (If the object had no contacts in the previous tick? What then?)
