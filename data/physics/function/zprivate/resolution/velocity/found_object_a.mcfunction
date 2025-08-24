# Tag the object data for this object so it can be copied over in its entirety (& remove the original)
execute store result storage physics:temp data.A int 1 run scoreboard players get @s Physics.Object.ID
function physics:zprivate/resolution/velocity/get_object_data with storage physics:temp data
data modify storage physics:resolution Object set from storage physics:zprivate ContactGroups[{R:1b}]
#data remove storage physics:zprivate ContactGroups[{R:1b}]
data remove storage physics:resolution Object.R

# Select the type of contact that needs to be resolved (World or object-object)
execute store result score #Physics.ContactType Physics if data storage physics:resolution Object.Objects[0].Blocks[].Hitboxes[].Contacts[{HasMinSeparatingVelocity:0b}]
execute if score #Physics.ContactType Physics matches 1 run function physics:zprivate/resolution/velocity/world/main
execute if score #Physics.ContactType Physics matches 0 run function physics:zprivate/resolution/velocity/object/main

# Start next resolution iteration
execute if score #Physics.RemainingIterations Physics matches 1 run return 0
scoreboard players remove #Physics.RemainingIterations Physics 1
function physics:zprivate/resolution/velocity/main
