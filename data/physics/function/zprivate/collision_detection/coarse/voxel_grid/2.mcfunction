# Set the BlockPos (= origin) of the first block I'm checking (which is at ~ ~ ~) and the BoundaryPos, which is the last block that it should check
# (Important): Even though I could just use the integer form of the BlockPos, I scale it back up for consistency in the calculations later on
# (Important): I don't know if I need the center coords or the block origin yet. Currently I'm getting the block origin
execute store result score #Physics.Maths.BoundaryPos.x Physics.Value run scoreboard players operation #Physics.Maths.BlockPos.x Physics.Value = @s Physics.Object.Pos.x
execute store result score #Physics.Maths.BoundaryPos.y Physics.Value run scoreboard players operation #Physics.Maths.BlockPos.y Physics.Value = @s Physics.Object.Pos.y
execute store result score #Physics.Maths.BoundaryPos.z Physics.Value run scoreboard players operation #Physics.Maths.BlockPos.z Physics.Value = @s Physics.Object.Pos.z

scoreboard players operation #Physics.Maths.BlockPos.x Physics.Value -= @s Physics.Object.HitboxRadius
scoreboard players operation #Physics.Maths.BlockPos.y Physics.Value -= @s Physics.Object.HitboxRadius
scoreboard players operation #Physics.Maths.BlockPos.z Physics.Value -= @s Physics.Object.HitboxRadius

scoreboard players operation #Physics.Maths.BlockPos.x Physics.Value /= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BlockPos.y Physics.Value /= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BlockPos.z Physics.Value /= #Physics.Constants.1000 Physics.Value

scoreboard players operation #Physics.Maths.BlockPos.x Physics.Value *= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BlockPos.y Physics.Value *= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BlockPos.z Physics.Value *= #Physics.Constants.1000 Physics.Value

scoreboard players operation #Physics.Maths.BoundaryPos.x Physics.Value += @s Physics.Object.HitboxRadius
scoreboard players operation #Physics.Maths.BoundaryPos.y Physics.Value += @s Physics.Object.HitboxRadius
scoreboard players operation #Physics.Maths.BoundaryPos.z Physics.Value += @s Physics.Object.HitboxRadius

scoreboard players operation #Physics.Maths.BoundaryPos.x Physics.Value /= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BoundaryPos.x Physics.Value *= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BoundaryPos.y Physics.Value /= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BoundaryPos.y Physics.Value *= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BoundaryPos.z Physics.Value /= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BoundaryPos.z Physics.Value *= #Physics.Constants.1000 Physics.Value

# Check all blocks that are inside the rough AABB check, to see if the SAT finds a collision (Use a snake pattern so only 1 scoreboard operation per moved block is necessary. And every layer undos the operations of the previous layer, meaning I can just copy paste the commands of layer 1 for layer 3, etc.)
    # Layer 1
    execute unless block ~ ~ ~ minecraft:air run particle bubble_column_up ~ ~ ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~ ~1 minecraft:air run particle bubble_column_up ~ ~ ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= #Physics.Maths.BoundaryPos.z Physics.Value unless block ~ ~ ~2 minecraft:air run particle bubble_column_up ~ ~ ~2

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= #Physics.Maths.BoundaryPos.z Physics.Value unless block ~1 ~ ~2 minecraft:air run particle bubble_column_up ~1 ~ ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~ ~1 minecraft:air run particle bubble_column_up ~1 ~ ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~ ~ minecraft:air run particle bubble_column_up ~1 ~ ~

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless score #Physics.Maths.BlockPos.x Physics.Value <= #Physics.Maths.BoundaryPos.x Physics.Value unless block ~2 ~ ~ minecraft:air run particle flame ~2 ~ ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= #Physics.Maths.BoundaryPos.x Physics.Value unless block ~2 ~ ~1 minecraft:air run particle bubble_column_up ~2 ~ ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= #Physics.Maths.BoundaryPos.x Physics.Value if score #Physics.Maths.BlockPos.z Physics.Value <= #Physics.Maths.BoundaryPos.z Physics.Value unless block ~2 ~ ~2 minecraft:air run particle bubble_column_up ~2 ~ ~2

    # Layer 2
    scoreboard players add #Physics.Maths.BlockPos.y Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= #Physics.Maths.BoundaryPos.x Physics.Value if score #Physics.Maths.BlockPos.z Physics.Value <= #Physics.Maths.BoundaryPos.z Physics.Value unless block ~2 ~1 ~2 minecraft:air run particle bubble_column_up ~2 ~1 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= #Physics.Maths.BoundaryPos.x Physics.Value unless block ~2 ~1 ~1 minecraft:air run particle bubble_column_up ~2 ~1 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= #Physics.Maths.BoundaryPos.x Physics.Value unless block ~2 ~1 ~ minecraft:air run particle bubble_column_up ~2 ~1 ~

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless block ~1 ~1 ~ minecraft:air run particle bubble_column_up ~1 ~1 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~1 ~1 minecraft:air run particle bubble_column_up ~1 ~1 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= #Physics.Maths.BoundaryPos.z Physics.Value unless block ~1 ~1 ~2 minecraft:air run particle bubble_column_up ~1 ~1 ~2

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= #Physics.Maths.BoundaryPos.z Physics.Value unless block ~ ~1 ~2 minecraft:air run particle bubble_column_up ~ ~1 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~1 ~1 minecraft:air run particle bubble_column_up ~ ~1 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~1 ~ minecraft:air run particle bubble_column_up ~ ~1 ~

    # Layer 3
    scoreboard players add #Physics.Maths.BlockPos.y Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.y Physics.Value > #Physics.Maths.BoundaryPos.y Physics.Value run return 0

    execute unless block ~ ~2 ~ minecraft:air run particle bubble_column_up ~ ~2 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~2 ~1 minecraft:air run particle bubble_column_up ~ ~2 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= #Physics.Maths.BoundaryPos.z Physics.Value unless block ~ ~2 ~2 minecraft:air run particle bubble_column_up ~ ~2 ~2

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= #Physics.Maths.BoundaryPos.z Physics.Value unless block ~1 ~2 ~2 minecraft:air run particle bubble_column_up ~1 ~2 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~2 ~1 minecraft:air run particle bubble_column_up ~1 ~2 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~2 ~ minecraft:air run particle bubble_column_up ~1 ~2 ~

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= #Physics.Maths.BoundaryPos.x Physics.Value unless block ~2 ~2 ~ minecraft:air run particle bubble_column_up ~2 ~2 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= #Physics.Maths.BoundaryPos.x Physics.Value unless block ~2 ~2 ~1 minecraft:air run particle bubble_column_up ~2 ~2 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= #Physics.Maths.BoundaryPos.x Physics.Value if score #Physics.Maths.BlockPos.z Physics.Value <= #Physics.Maths.BoundaryPos.z Physics.Value unless block ~2 ~2 ~2 minecraft:air run particle bubble_column_up ~2 ~2 ~2
