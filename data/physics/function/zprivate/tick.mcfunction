# Collision detection
execute as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:zprivate/collision_detection/rough/main
tag @e[type=minecraft:item_display,tag=Physics.Checked] remove Physics.Checked

# Integration: Update every object
execute as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:zprivate/integration/main
