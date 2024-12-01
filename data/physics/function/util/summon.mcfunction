# Summon a rigid-body physics object
summon minecraft:block_display ~ ~ ~ {width:1f,height:1f,interpolation_duration:1,teleport_duration:1,Tags:["Physics.Object","Physics.New"],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-0.5f,-0.5f,-0.5f],scale:[1f,1f,1f]},block_state:{Name:"minecraft:grass_block"}}

# Set default attributes
execute as @e[type=minecraft:block_display,tag=Physics.New,distance=..0.1,limit=1] run function physics:zprivate/new_object
