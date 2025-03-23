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
execute if score #Physics.HitboxIsTouching Physics matches 1 run data modify storage physics:temp data.Hitbox set from storage physics:temp data.Block.Hitboxes[{ID:1b}]
execute if score #Physics.HitboxIsTouching Physics matches 1 run data remove storage physics:temp data.Block.Hitboxes[{ID:1b}]
execute if score #Physics.HitboxIsTouching Physics matches 1 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_hitbox

# Update the previous tick's contacts for hitboxes that aren't touching but belong to the same block
#function physics:zprivate/contact_generation/accumulate/world/touching/update_remaining_hitboxes
# CAN BE INLINED




# NOTE: IT SHOULD NOT REMOVE THE BLOCK FROM THE HITBOXES IF IT'S THERE'S ONLY ONE HITBOX (remaining?) ANYWAY.
