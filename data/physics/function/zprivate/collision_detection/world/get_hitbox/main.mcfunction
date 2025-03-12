# Get the hitbox of the block at ~ ~ ~ and store it in the '#Physics.Projection.Block.WorldAxis.<AXIS>.Min/Max Physics' scores (Absolute coordinates, not relative to the block position). Then get the HitboxType and run the SAT for each part of the hitbox.
# (Important): This version is used during the SAT and doesn't include "ignored" tag checks, because that's already been done by this point.
# (Important): Despite the above, it can still return "HitboxType = 0", for example if it's an open fence gate.
execute store result score #Physics.Projection.Block.WorldAxis.x.Max Physics store result score #Physics.BlockCenterPos.x Physics run scoreboard players operation #Physics.Projection.Block.WorldAxis.x.Min Physics = #Physics.BlockPos.x Physics
execute store result score #Physics.Projection.Block.WorldAxis.y.Max Physics store result score #Physics.BlockCenterPos.y Physics run scoreboard players operation #Physics.Projection.Block.WorldAxis.y.Min Physics = #Physics.BlockPos.y Physics
execute store result score #Physics.Projection.Block.WorldAxis.z.Max Physics store result score #Physics.BlockCenterPos.z Physics run scoreboard players operation #Physics.Projection.Block.WorldAxis.z.Min Physics = #Physics.BlockPos.z Physics

    # Full block
    execute store result storage physics:temp data.HitboxType byte 1 run scoreboard players set #Physics.HitboxType Physics 5
    scoreboard players set #Physics.BlockDiagonalLength Physics 1732

        # Block Center Pos Offset (None here)

        # Block Hitbox (Change min and max)
        scoreboard players remove #Physics.Projection.Block.WorldAxis.x.Min Physics 500
        scoreboard players add #Physics.Projection.Block.WorldAxis.x.Max Physics 500
        scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Min Physics 500
        execute unless block ~ ~ ~ minecraft:water run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 500
        scoreboard players remove #Physics.Projection.Block.WorldAxis.z.Min Physics 500
        scoreboard players add #Physics.Projection.Block.WorldAxis.z.Max Physics 500

    # TEMPORARY: Water
    execute if block ~ ~ ~ minecraft:water run scoreboard players set #Physics.BlockDiagonalLength Physics 1670

    execute if block ~ ~ ~ minecraft:water store result storage physics:temp data.HitboxType byte 1 run scoreboard players set #Physics.HitboxType Physics 2
    execute if block ~ ~ ~ minecraft:water[level=0] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
    execute if block ~ ~ ~ minecraft:water[level=0] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
    execute if block ~ ~ ~ minecraft:water[level=0] run scoreboard players set #Physics.BlockDiagonalLength Physics 1670

    execute if block ~ ~ ~ minecraft:water[level=1] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 277
    execute if block ~ ~ ~ minecraft:water[level=1] run scoreboard players remove #Physics.BlockCenterPos.y Physics 111
    execute if block ~ ~ ~ minecraft:water[level=1] run scoreboard players set #Physics.BlockDiagonalLength Physics 1613

    execute if block ~ ~ ~ minecraft:water[level=2] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 166
    execute if block ~ ~ ~ minecraft:water[level=2] run scoreboard players remove #Physics.BlockCenterPos.y Physics 166
    execute if block ~ ~ ~ minecraft:water[level=2] run scoreboard players set #Physics.BlockDiagonalLength Physics 1563

    execute if block ~ ~ ~ minecraft:water[level=3] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 55
    execute if block ~ ~ ~ minecraft:water[level=3] run scoreboard players remove #Physics.BlockCenterPos.y Physics 222
    execute if block ~ ~ ~ minecraft:water[level=3] run scoreboard players set #Physics.BlockDiagonalLength Physics 1519

    execute if block ~ ~ ~ minecraft:water[level=4] run scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Max Physics 55
    execute if block ~ ~ ~ minecraft:water[level=4] run scoreboard players remove #Physics.BlockCenterPos.y Physics 277
    execute if block ~ ~ ~ minecraft:water[level=4] run scoreboard players set #Physics.BlockDiagonalLength Physics 1482

    execute if block ~ ~ ~ minecraft:water[level=5] run scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Max Physics 166
    execute if block ~ ~ ~ minecraft:water[level=5] run scoreboard players remove #Physics.BlockCenterPos.y Physics 333
    execute if block ~ ~ ~ minecraft:water[level=5] run scoreboard players set #Physics.BlockDiagonalLength Physics 1452

    execute if block ~ ~ ~ minecraft:water[level=6] run scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Max Physics 277
    execute if block ~ ~ ~ minecraft:water[level=6] run scoreboard players remove #Physics.BlockCenterPos.y Physics 388
    execute if block ~ ~ ~ minecraft:water[level=6] run scoreboard players set #Physics.BlockDiagonalLength Physics 1431

    execute if block ~ ~ ~ minecraft:water[level=7] run scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Max Physics 388
    execute if block ~ ~ ~ minecraft:water[level=7] run scoreboard players remove #Physics.BlockCenterPos.y Physics 444
    execute if block ~ ~ ~ minecraft:water[level=7] run scoreboard players set #Physics.BlockDiagonalLength Physics 1418

    execute if block ~ ~ ~ minecraft:water[level=8] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
    execute if block ~ ~ ~ minecraft:water[level=9] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
    execute if block ~ ~ ~ minecraft:water[level=10] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
    execute if block ~ ~ ~ minecraft:water[level=11] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
    execute if block ~ ~ ~ minecraft:water[level=12] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
    execute if block ~ ~ ~ minecraft:water[level=13] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
    execute if block ~ ~ ~ minecraft:water[level=14] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
    execute if block ~ ~ ~ minecraft:water[level=15] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
    execute if block ~ ~ ~ minecraft:water[level=8] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
    execute if block ~ ~ ~ minecraft:water[level=9] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
    execute if block ~ ~ ~ minecraft:water[level=10] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
    execute if block ~ ~ ~ minecraft:water[level=11] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
    execute if block ~ ~ ~ minecraft:water[level=12] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
    execute if block ~ ~ ~ minecraft:water[level=13] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
    execute if block ~ ~ ~ minecraft:water[level=14] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
    execute if block ~ ~ ~ minecraft:water[level=15] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55

    function physics:zprivate/collision_detection/world/sat

# W.I.P.
