# Get MinSeparatingVelocity of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MinSeparatingVelocityTotal Physics 2147483647
scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics < @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MinSeparatingVelocity
execute if score #Physics.MinSeparatingVelocityTotal Physics > #Physics.Settings.Resolution.MinSeparatingVelocity Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_min_separating_velocity,limit=1] run function physics:zprivate/resolution/velocity/found_object_a
