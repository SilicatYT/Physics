# Collision detection (Minecraft blocks & Dynamic objects)
execute as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:zprivate/collision_detection/main
tag @e[type=minecraft:item_display,tag=Physics.Checked] remove Physics.Checked

# Integration: Update every object
execute as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:zprivate/integration/main
