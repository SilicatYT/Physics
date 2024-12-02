# Integration: Update every object
execute as @e[type=minecraft:block_display,tag=Physics.Object] run function physics:zprivate/integration/main
