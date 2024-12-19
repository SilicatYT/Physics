# Iterate through every minecraft block that intersects with the interaction entity's hitbox (AABB), so I can then perform the Separating Axes Theorem (SAT) to check for fine collisions
execute store result storage physics:temp data.Offset double -0.0000005 run scoreboard players get @s Physics.Object.HitboxSideLength
execute store result storage physics:temp data.StepCount byte 1 run scoreboard players get @s Physics.Object.HitboxStepCount

execute at @s run function physics:zprivate/collision_detection/coarse/voxel_grid/main with storage physics:temp data

# Check for coarse collisions with other dynamic objects, so I can then perform the SAT to check for fine collisions
# (Important): Only checks objects in a range of 26.5 blocks so I can avoid an integer overflow in the calculation of the squared distance, while saving 3 divisions. This means that the maximum size an object can have is restricted to a max side length of 13.25 blocks.
tag @s add Physics.Checked
scoreboard players operation #Physics.OtherObject Physics.Object.ID = @s Physics.Object.ID
scoreboard players operation #Physics.OtherObject Physics.Object.Pos.x = @s Physics.Object.Pos.x
scoreboard players operation #Physics.OtherObject Physics.Object.Pos.y = @s Physics.Object.Pos.y
scoreboard players operation #Physics.OtherObject Physics.Object.Pos.z = @s Physics.Object.Pos.z
scoreboard players operation #Physics.OtherObject Physics.Object.HitboxRadius = @s Physics.Object.HitboxRadius
execute at @s as @e[type=minecraft:item_display,tag=Physics.Object,tag=!Physics.Checked,distance=..26.5] run function physics:zprivate/collision_detection/coarse/objects/check
