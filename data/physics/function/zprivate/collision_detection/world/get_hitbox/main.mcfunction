# Get the hitbox of the block at ~ ~ ~ and store it in the '#Physics.Projection.Block.WorldAxis.<AXIS>.Min/Max Physics' scores (Absolute coordinates, not relative to the block position). Then get the HitboxType and run the SAT for each part of the hitbox.
# (Important): This version is used during the SAT and doesn't include "ignored" tag checks, because that's already been done by this point.
# (Important): Despite the above, it can still return "HitboxType = 0", for example if it's an open fence gate.
execute store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Block.WorldAxis.x.Min Physics = #Physics.BlockPos.x Physics
execute store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Block.WorldAxis.y.Min Physics = #Physics.BlockPos.y Physics
execute store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Block.WorldAxis.z.Min Physics = #Physics.BlockPos.z Physics

    # Full block
    execute store result storage physics:temp data.HitboxType byte 1 run scoreboard players set #Physics.HitboxType Physics 1

    scoreboard players remove #Physics.Projection.Block.WorldAxis.x.Min Physics 500
    scoreboard players add #Physics.Projection.Block.WorldAxis.x.Max Physics 500
    scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Min Physics 500
    scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 500
    scoreboard players remove #Physics.Projection.Block.WorldAxis.z.Min Physics 500
    scoreboard players add #Physics.Projection.Block.WorldAxis.z.Max Physics 500

    function physics:zprivate/collision_detection/world/sat

# W.I.P.
