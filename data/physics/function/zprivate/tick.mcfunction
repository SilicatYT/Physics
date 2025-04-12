# Debug: Show axes
execute if score #Physics.Debug.ShowAxes Physics matches 1 as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:debug/show_axes

# Contact Generation: Setup
# (Important): The last command is run so the "HitboxHasPreviousContacts" score doesn't get set to 0 if the data matches the previous tick's data exactly (Which only really happens if only one object exists).
data modify storage physics:temp data.ContactGroupsPrevious set from storage physics:zprivate ContactGroups
data modify storage physics:zprivate ContactGroups set value []
data modify storage physics:temp data.Hitbox set value {}

# Collision Detection (Minecraft blocks & Dynamic objects) & Contact Generation
execute as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:zprivate/collision_detection/main
tag @e[type=minecraft:item_display,tag=Physics.Checked] remove Physics.Checked

# Contact Resolution
# ...

# Integration: Update every object
execute as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:zprivate/integration/main
