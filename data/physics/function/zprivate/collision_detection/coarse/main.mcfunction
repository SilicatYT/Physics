# Iterate through every minecraft block that intersects with the interaction entity's hitbox (AABB), so I can then perform the Separating Axes Theorem (SAT) to check for fine collisions
# (Important): I only have the global coords for the bounding box, so instead of using a few scoreboard commands, I just don't use relative coordinates here. If I do need the relative coordinates later, I will change that
execute store result storage physics:temp data.StartX double 0.001 run scoreboard players get @s Physics.Object.BoundingBoxGlobalMin.x
execute store result storage physics:temp data.StartY double 0.001 run scoreboard players get @s Physics.Object.BoundingBoxGlobalMin.y
execute store result storage physics:temp data.StartZ double 0.001 run scoreboard players get @s Physics.Object.BoundingBoxGlobalMin.z
execute store result storage physics:temp data.StepCountX byte 1 run scoreboard players get @s Physics.Object.BoundingBoxStepCount.x
execute store result storage physics:temp data.StepCountY byte 1 run scoreboard players get @s Physics.Object.BoundingBoxStepCount.y
execute store result storage physics:temp data.StepCountZ byte 1 run scoreboard players get @s Physics.Object.BoundingBoxStepCount.z

execute at @s run function physics:zprivate/collision_detection/coarse/main_voxel_grid with storage physics:temp data

# Check for coarse collisions with other dynamic objects, so I can then perform the SAT to check for fine collisions
# (Important): Only checks objects in a range of 6.929 blocks, which is the sum of both objects' maximum supported bounding box, assuming I cap the dimensions at 4 blocks. The reasoning is explained in the set_attributes/dimension function.
tag @s add Physics.Checked
scoreboard players operation #Physics.OtherObject Physics.Object.ID = @s Physics.Object.ID
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxGlobalMin.x = @s Physics.Object.BoundingBoxGlobalMin.x
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxGlobalMax.x = @s Physics.Object.BoundingBoxGlobalMax.x
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxGlobalMin.y = @s Physics.Object.BoundingBoxGlobalMin.y
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxGlobalMax.y = @s Physics.Object.BoundingBoxGlobalMax.y
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxGlobalMin.z = @s Physics.Object.BoundingBoxGlobalMin.z
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxGlobalMax.z = @s Physics.Object.BoundingBoxGlobalMax.z
execute at @s as @e[type=minecraft:item_display,tag=Physics.Object,tag=!Physics.Checked,distance=..6.929] if score @s Physics.Object.BoundingBoxGlobalMin.x <= #Physics.OtherObject Physics.Object.BoundingBoxGlobalMax.x if score #Physics.OtherObject Physics.Object.BoundingBoxGlobalMin.x <= @s Physics.Object.BoundingBoxGlobalMax.x if score @s Physics.Object.BoundingBoxGlobalMin.z <= #Physics.OtherObject Physics.Object.BoundingBoxGlobalMax.z if score #Physics.OtherObject Physics.Object.BoundingBoxGlobalMin.z <= @s Physics.Object.BoundingBoxGlobalMax.z if score @s Physics.Object.BoundingBoxGlobalMin.y <= #Physics.OtherObject Physics.Object.BoundingBoxGlobalMax.y if score #Physics.OtherObject Physics.Object.BoundingBoxGlobalMin.y <= @s Physics.Object.BoundingBoxGlobalMax.y run particle flame ~ ~ ~ 0.3 0.3 0.3 0 1
