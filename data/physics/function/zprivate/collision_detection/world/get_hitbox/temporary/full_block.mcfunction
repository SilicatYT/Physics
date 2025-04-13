# SET THESE AT THE END OF THE PREVIOUS BLOCK IF ITS DATA WAS DIFFERENT, SO THESE SCORES DONT HAVE TO BE SET EVERY TIME
scoreboard players set #Physics.BlockDiagonalLength Physics 1732

# Block Hitbox (Change min and max)
scoreboard players remove #Physics.Projection.Block.WorldAxis.x.Min Physics 500
scoreboard players add #Physics.Projection.Block.WorldAxis.x.Max Physics 500
scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Min Physics 500
scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 500
scoreboard players remove #Physics.Projection.Block.WorldAxis.z.Min Physics 500
scoreboard players add #Physics.Projection.Block.WorldAxis.z.Max Physics 500

# Run SAT
function physics:zprivate/collision_detection/world/sat
execute if score #Physics.Touching Physics matches 0 run return 0

# IT SHOULD ONLY RUN THE OPERATIONS ON "data.Block" IF A HITBOX PRIOR TO THOSE CHECKS HAS PASSED THE SAT, BECAUSE ONLY THEN IS THE STORAGE SET.



# Carry over the previous tick's contacts with that (entire) block if it's not in contact
# (Important): Mark those contacts as invalid by removing all data except the feature pair.
#execute if score #Physics.Touching Physics matches 0 run return run tellraw @p {nbt:"data.Block",storage:"physics:temp"}
#data remove storage physics:temp data.Block.Hitboxes[].Contacts[].SeparatingVelocity


# THE STORAGE 'data.Block' IS NOT SET IF THE BLOCK IS NOT TOUCHING. SO I NEED TO GO A DIFFERENT ROUTE. I DON'T WANT TO RUN A FUNCTION AND 2 MACROS FOR EACH BLOCK IN THE AABB.
# => INSTEAD, WHAT IF I DO: data remove storage physics:temp data.Blocks[].Hitboxes[].Contacts[].SeparatingVelocity (And the same for PenetrationDepth) AFTER THE SATs ARE FULLY DONE?
# => THEN I LOOP OVER THE BLOCKS TO SEE WHICH ARE OUTSIDE THE EXTENDED AABB, AND DISCARD THOSE








# Update the previous tick's contacts with that hitbox
# (Important): It needs to make sure that it only runs the "update" function if data for this hitbox was found, and remember that "set storage from storage" keeps the previous value if the source is empty or not found.
# (Important): In order to make sure the HitboxHasPreviousContacts score is not 0 if the data is exactly the same as before (even though it exists), it's cleared at the start of the tick.

# BUG: data.Block IS NOT SET (Previous stale data) IF THE BLOCK IS NOT TOUCHING, BUT IT STILL CHECKS IT. I NEED TO EARLY OUT IF THE SAT FAILED. BUT I ALSO NEED TO UPDATE THE CONTACTS...
# => If the block is touching, the "data.Block" storage is set, so I can do stuff as intended for all hitboxes.
# => If the block is not touching, I could spend a macro here to set the "data.Blocks" entry's hitbox data and update the contacts properly. However, that would be 1 macro per block in the AABB that's not touching.
#    Instead, I should run an alternative "get_hitbox" function in "physics:zprivate/contact_generation/accumulate/world/not_touching/main" for each block in the "data.Blocks" storage. This is just 1 macro per block that already has contacts (+ the "get hitbox" overhead of course).

# data.Hitbox is NOT reset at the start because two separate objects can't have the exact same data (same feature pair, same contact point etc), so it'll always be overwritten

execute store success score #Physics.HitboxHasPreviousContacts Physics run data modify storage physics:temp data.Hitbox set from storage physics:temp data.Block.Hitboxes[0]
execute if score #Physics.HitboxHasPreviousContacts Physics matches 0 run return 0
execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
execute if score #Physics.ContactCount Physics matches 1.. run function physics:zprivate/contact_generation/accumulate/world/touching/update_hitbox
data remove storage physics:temp data.Block

# THE "data.Block" STORAGE IS CLEARED AFTER USAGE SO THE NEXT BLOCK DOESN'T WORK WITH STALE DATA IF IT'S NOT IN CONTACT.





# INSTEAD OF Hitboxes[ID:1b], JUST USE Hitboxes[0] FOR SINGLE-HITBOX BLOCKS




# NOTE: IT SHOULD NOT REMOVE THE BLOCK FROM THE HITBOXES IF IT'S THERE'S ONLY ONE HITBOX (remaining?) ANYWAY.
