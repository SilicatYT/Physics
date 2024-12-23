# Check all blocks in the bounding box
    # Layer 1
    execute unless block ~ ~ ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~ ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.Maths.BlockPos.x Physics 1000
    execute if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~ ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.Maths.BlockPos.x Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~2 ~ ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~ ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    # Layer 2
    scoreboard players add #Physics.Maths.BlockPos.y Physics 1000
    execute if score #Physics.Maths.BlockPos.y Physics > #Physics.Maths.BoundingBoxLimit.y Physics run return 0

    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~1 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~2 ~1 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.Maths.BlockPos.x Physics 1000
    execute unless block ~1 ~1 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players add #Physics.Maths.BlockPos.z Physics 1000
    execute if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~1 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.Maths.BlockPos.x Physics 1000
    execute if score #Physics.Maths.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~1 ~1 minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine

    scoreboard players remove #Physics.Maths.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~ minecraft:air run function physics:zprivate/collision_detection/voxel_grid/fine
