# Check all blocks in the bounding box
    # Layer 1
    execute unless block ~ ~ ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~ ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~ ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~2 ~ ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~ ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~ ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~ ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~4 ~ ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~ ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~ ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~5 ~ ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~6 ~ ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~ ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~6 ~ ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~7 ~ ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~ ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~ ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    # Layer 2
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~1 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~1 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~7 ~1 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~6 ~1 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~1 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~1 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~5 ~1 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~1 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~5 ~1 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~1 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~3 ~1 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~1 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~1 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~1 ~1 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~1 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~1 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~1 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    # Layer 3
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute unless block ~ ~2 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~2 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~2 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~2 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~2 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~2 ~2 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~2 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~2 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~2 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~2 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~2 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~4 ~2 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~2 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~2 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~5 ~2 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~2 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~2 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~6 ~2 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~2 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~6 ~2 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~7 ~2 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~2 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~2 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    # Layer 4
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~3 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~3 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~7 ~3 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~6 ~3 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~3 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~3 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~5 ~3 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~3 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~5 ~3 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~3 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~3 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~3 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~3 ~3 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~3 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~3 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~3 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~3 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~3 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~1 ~3 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~3 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~3 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~3 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    # Layer 5
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute if score #Physics.BlockPos.y Physics > #Physics.Maths.BoundingBoxLimit.y Physics run return 0

    execute unless block ~ ~4 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~4 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~4 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~4 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~4 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~2 ~4 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~4 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~4 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~4 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~4 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~4 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~4 ~4 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~4 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~4 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~5 ~4 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~4 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~4 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~6 ~4 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~4 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~6 ~4 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~7 ~4 ~2 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~4 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~4 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine
