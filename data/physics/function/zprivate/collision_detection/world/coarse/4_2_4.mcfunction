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
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~ ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~ ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

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
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~ ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~ ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~4 ~ ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~4 ~ ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~4 ~ ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~4 ~ ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~ ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    # Layer 2
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~1 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~4 ~1 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~4 ~1 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~4 ~1 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~4 ~1 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~3 ~1 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~1 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~1 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

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
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~1 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~1 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    # Layer 3
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute if score #Physics.BlockPos.y Physics > #Physics.Maths.BoundingBoxLimit.y Physics run return 0

    execute unless block ~ ~2 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~2 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~2 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~2 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~2 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~2 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~2 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~2 ~2 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~2 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~2 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~2 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~2 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~2 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~2 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~2 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~2 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~2 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~4 ~2 ~ #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~4 ~2 ~1 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~4 ~2 ~2 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~4 ~2 ~3 #physics:ignored run function physics:zprivate/collision_detection/world/check

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~2 ~4 #physics:ignored run function physics:zprivate/collision_detection/world/check
