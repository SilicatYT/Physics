# Check all blocks in the bounding box
    # Layer 1
    execute unless block ~ ~ ~ minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~ ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~ ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~ minecraft:air run function physics:zprivate/collision_detection/world/fine

    # Layer 2
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~ minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~1 ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~1 ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~ minecraft:air run function physics:zprivate/collision_detection/world/fine

    # Layer 3
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute unless block ~ ~2 ~ minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~2 ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~2 ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~ minecraft:air run function physics:zprivate/collision_detection/world/fine

    # Layer 4
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~3 ~ minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~3 ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~3 ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~3 ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~3 ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~3 ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~3 ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~3 ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~3 ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~ minecraft:air run function physics:zprivate/collision_detection/world/fine

    # Layer 5
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute unless block ~ ~4 ~ minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~4 ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~4 ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~4 ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~4 ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~4 ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~4 ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~4 ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~4 ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~4 ~ minecraft:air run function physics:zprivate/collision_detection/world/fine

    # Layer 6
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~5 ~ minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~5 ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~5 ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~5 ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~5 ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~5 ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~5 ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~5 ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~5 ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~ minecraft:air run function physics:zprivate/collision_detection/world/fine

    # Layer 7
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute unless block ~ ~6 ~ minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~6 ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~6 ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~6 ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~6 ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~6 ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~6 ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~6 ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~6 ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~6 ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~6 ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~6 ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~6 ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~6 ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~6 ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~6 ~ minecraft:air run function physics:zprivate/collision_detection/world/fine

    # Layer 8
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute if score #Physics.BlockPos.y Physics > #Physics.Maths.BoundingBoxLimit.y Physics run return 0

    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~7 ~ minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~7 ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~7 ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~7 ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~7 ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~7 ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~7 ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~7 ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~7 ~7 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~7 ~6 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~7 ~5 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~7 ~4 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~7 ~3 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~7 ~2 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~7 ~1 minecraft:air run function physics:zprivate/collision_detection/world/fine

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~7 ~ minecraft:air run function physics:zprivate/collision_detection/world/fine
