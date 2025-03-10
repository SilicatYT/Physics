# Check all blocks in the bounding box
    # Layer 1
    execute unless block ~ ~ ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~ ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~ ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~2 ~ ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~ ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~ ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~ ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~ ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~ ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~ ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~ ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~ ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~4 ~ ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~ ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~ ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~ ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~ ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~ ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~ ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~ ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~5 ~ ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~6 ~ ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~ ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~ ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~ ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~ ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~ ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~ ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~6 ~ ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~7 ~ ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~ ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~ ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~ ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~ ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~ ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~ ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~ ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    # Layer 2
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute if score #Physics.BlockPos.y Physics > #Physics.Maths.BoundingBoxLimit.y Physics run return 0

    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~1 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~1 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~1 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~1 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~1 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~1 ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~7 ~1 ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~7 ~1 ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~6 ~1 ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~1 ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~1 ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~1 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~1 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~1 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~1 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~6 ~1 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~5 ~1 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~1 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~1 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~1 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~1 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~1 ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~1 ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~5 ~1 ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~1 ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~3 ~1 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~1 ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~1 ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~1 ~1 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~1 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~1 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~1 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~1 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~1 ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~1 ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~1 ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~1 ~7 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~6 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~5 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check
