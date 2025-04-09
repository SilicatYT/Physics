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

# Update the previous tick's contacts with that hitbox
# (Important): It needs to make sure that it only runs the "update" function if data for this hitbox was found, and remember that "set storage from storage" keeps the previous value if the source is empty or not found.
# (Important): In order to make sure the HitboxHasPreviousContacts score is not 0 if the data is exactly the same as before (even though it exists), it's set to {} at the start of the tick.
execute store success score #Physics.HitboxHasPreviousContacts Physics run data modify storage physics:temp data.Hitbox set from storage physics:temp data.Block.Hitboxes[{ID:1b}]
execute if score #Physics.HitboxHasPreviousContacts Physics matches 0 run return 0
execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
execute if score #Physics.ContactCount Physics matches 1.. run function physics:zprivate/contact_generation/accumulate/world/touching/update_hitbox
# ^ COULD BE INLINED, EVEN IF IT'S JUST FOR FULL BLOCKS
# IT COULD ALSO BE 1.. SOLELY BECAUSE OF THE CURRENT TICK'S CONTACT. BUT I THINK ADDING A SEPARATE CHECK FOR THAT WOULDN'T BE BETTER OVERALL


# Update the previous tick's contacts for hitboxes that aren't touching but belong to the same block
#execute store result score #Physics.BlockRemainingHitboxCount Physics if data storage physics:temp data.Block.Hitboxes[]
#execute if score #Physics.BlockRemainingHitboxCount Physics matches 1.. run function physics:zprivate/contact_generation/accumulate/world/touching/update_remaining_hitboxes
# CAN BE INLINED
# IS THIS EVEN NECESSARY? WHY CAN'T I SIMPLY RUN THE COMMANDS FROM ABOVE AFTER EACH HITBOX SAT?
# ALSO, WHY EXACTLY AM I ONLY RUNNING THE COMMANDS FROM ABOVE IF THE HITBOX IS TOUCHING (IT'S NOW CHANGED TO NO LONGER DO THAT)? IT SHOULD UPDATE THE CONTACTS FOR THAT HITBOX NO MATTER WHAT!



# NOTE: IT SHOULD NOT REMOVE THE BLOCK FROM THE HITBOXES IF IT'S THERE'S ONLY ONE HITBOX (remaining?) ANYWAY.
