# Iterate through every minecraft block that intersects with the interaction entity's hitbox (AABB), so I can then perform the Separating Axes Theorem (SAT) to check for fine collisions
execute store result storage physics:temp data.OffsetX double 0.001 run scoreboard players get @s Physics.Object.BoundingBoxHalvedNegative.x
execute store result storage physics:temp data.OffsetY double 0.001 run scoreboard players get @s Physics.Object.BoundingBoxHalvedNegative.y
execute store result storage physics:temp data.OffsetZ double 0.001 run scoreboard players get @s Physics.Object.BoundingBoxHalvedNegative.z
execute store result storage physics:temp data.StepCountX byte 1 run scoreboard players get @s Physics.Object.BoundingBoxStepCount.x
execute store result storage physics:temp data.StepCountY byte 1 run scoreboard players get @s Physics.Object.BoundingBoxStepCount.y
execute store result storage physics:temp data.StepCountZ byte 1 run scoreboard players get @s Physics.Object.BoundingBoxStepCount.z

execute at @s run function physics:zprivate/collision_detection/coarse/voxel_grid/main with storage physics:temp data

# Check for coarse collisions with other dynamic objects, so I can then perform the SAT to check for fine collisions
# (Important): Only checks objects in a range of 26.5 blocks. This means that the maximum size an object can have is restricted to a max side length of 15.3 blocks. The max size should probably be reduced even further though.
tag @s add Physics.Checked
scoreboard players operation #Physics.OtherObject Physics.Object.ID = @s Physics.Object.ID
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxMin.x = @s Physics.Object.BoundingBoxMin.x
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxMax.x = @s Physics.Object.BoundingBoxMax.x
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxMin.y = @s Physics.Object.BoundingBoxMin.y
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxMax.y = @s Physics.Object.BoundingBoxMax.y
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxMin.z = @s Physics.Object.BoundingBoxMin.z
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxMax.z = @s Physics.Object.BoundingBoxMax.z
execute at @s as @e[type=minecraft:item_display,tag=Physics.Object,tag=!Physics.Checked,distance=..26.5] if score @s Physics.Object.BoundingBoxMin.x <= #Physics.OtherObject Physics.Object.BoundingBoxMax.x if score #Physics.OtherObject Physics.Object.BoundingBoxMin.x <= @s Physics.Object.BoundingBoxMax.x if score @s Physics.Object.BoundingBoxMin.z <= #Physics.OtherObject Physics.Object.BoundingBoxMax.z if score #Physics.OtherObject Physics.Object.BoundingBoxMin.z <= @s Physics.Object.BoundingBoxMax.z if score @s Physics.Object.BoundingBoxMin.y <= #Physics.OtherObject Physics.Object.BoundingBoxMax.y if score #Physics.OtherObject Physics.Object.BoundingBoxMin.y <= @s Physics.Object.BoundingBoxMax.y run particle flame ~ ~ ~ 0.3 0.3 0.3 0 1
