# Get the hitbox of the block at ~ ~ ~ and store it in the '#Physics.Projection.Block.WorldAxis.<AXIS>.Min/Max Physics' scores (Absolute coordinates, not relative to the block position)
# (Important): This version is used during the contact accumulation and includes air checks, because the block might not exist anymore.
execute if block ~ ~ ~ minecraft:air run return run scoreboard players set #Physics.NoHitbox Physics 1

execute store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Block.WorldAxis.x.Min Physics = #Physics.BlockPos.x Physics
execute store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Block.WorldAxis.y.Min Physics = #Physics.BlockPos.y Physics
execute store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Block.WorldAxis.z.Min Physics = #Physics.BlockPos.z Physics

    # Full block
    scoreboard players remove #Physics.Projection.Block.WorldAxis.x.Min Physics -500
    scoreboard players add #Physics.Projection.Block.WorldAxis.x.Max Physics 500

    scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Min Physics -500
    scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 500

    scoreboard players remove #Physics.Projection.Block.WorldAxis.z.Min Physics -500
    scoreboard players add #Physics.Projection.Block.WorldAxis.z.Max Physics 500

# W.I.P.
