# Check all blocks in the bounding box
    # Layer 1
    execute unless block ~ ~ ~ minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~ ~1 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~ ~2 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~ ~3 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~ ~4 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~ ~5 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~ ~6 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~ ~7 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.x Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~ ~7 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~6 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~5 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~4 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~3 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~2 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~1 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~ minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    # Layer 2
    scoreboard players add #Physics.Maths.BlockPos.y Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~ minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~1 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~2 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~3 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~4 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~5 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~6 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~1 ~7 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.x Physics 1000
    execute if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~1 ~7 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~6 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~5 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~4 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~3 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~2 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~1 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~ minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    # Layer 3
    scoreboard players add #Physics.Maths.BlockPos.y Physics 1000
    execute unless block ~ ~2 ~ minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~1 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~2 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~3 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~4 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~5 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~6 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~2 ~7 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.x Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~2 ~7 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~6 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~5 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~4 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~3 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~2 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~1 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~ minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    # Layer 4
    scoreboard players add #Physics.Maths.BlockPos.y Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~3 ~ minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~3 ~1 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~3 ~2 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~3 ~3 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~3 ~4 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~3 ~5 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~3 ~6 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~3 ~7 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.x Physics 1000
    execute if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~3 ~7 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~6 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~5 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~4 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~3 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~2 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~1 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~ minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    # Layer 5
    scoreboard players add #Physics.Maths.BlockPos.y Physics 1000
    execute unless block ~ ~4 ~ minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~1 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~2 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~3 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~4 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~5 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~6 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~4 ~7 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.x Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~4 ~7 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~4 ~6 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~4 ~5 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~4 ~4 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~4 ~3 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~4 ~2 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~4 ~1 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~4 ~ minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    # Layer 6
    scoreboard players add #Physics.Maths.BlockPos.y Physics 1000
    execute if score #Physics.Maths.BlockPos.y Physics > #Physics.Maths.BoundingBoxLimit.y Physics run return 0

    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~5 ~ minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~5 ~1 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~5 ~2 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~5 ~3 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~5 ~4 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~5 ~5 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~5 ~6 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~5 ~7 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.x Physics 1000
    execute if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~5 ~7 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~6 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~5 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~4 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~3 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~2 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~1 minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~ minecraft:air run function physics:zprivate/collision_detection/fine/voxel_grid/main
