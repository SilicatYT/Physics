# Debug: Show axes
execute if score #Physics.Debug.ShowAxes Physics matches 1 as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:debug/show_axes

# Contact Generation: Setup
data modify storage physics:temp data.ContactGroupsPrevious set from storage physics:zprivate data.ContactGroups
data modify storage physics:zprivate data.ContactGroups set value []

# Collision Detection (Minecraft blocks & Dynamic objects) & Contact Generation
execute as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:zprivate/collision_detection/main
tag @e[type=minecraft:item_display,tag=Physics.Checked] remove Physics.Checked

# Contact Resolution
# ...

# Integration: Update every object
execute as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:zprivate/integration/main
