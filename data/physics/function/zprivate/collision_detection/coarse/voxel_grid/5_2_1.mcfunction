# Check all blocks in the bounding box
    # Layer 1
    execute unless block ~ ~ ~ minecraft:air run particle bubble_column_up ~ ~ ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~ ~ ~1 minecraft:air run particle bubble_column_up ~ ~ ~1

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~1 ~ ~1 minecraft:air run particle bubble_column_up ~1 ~ ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~ ~ minecraft:air run particle bubble_column_up ~1 ~ ~

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless block ~2 ~ ~ minecraft:air run particle bubble_column_up ~2 ~ ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~2 ~ ~1 minecraft:air run particle bubble_column_up ~2 ~ ~1

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~3 ~ ~1 minecraft:air run particle bubble_column_up ~3 ~ ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~3 ~ ~ minecraft:air run particle bubble_column_up ~3 ~ ~

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless block ~4 ~ ~ minecraft:air run particle bubble_column_up ~4 ~ ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~4 ~ ~1 minecraft:air run particle bubble_column_up ~4 ~ ~1

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~5 ~ ~1 minecraft:air run particle bubble_column_up ~5 ~ ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~5 ~ ~ minecraft:air run particle bubble_column_up ~5 ~ ~

    # Layer 2
    scoreboard players add #Physics.Maths.BlockPos.y Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~5 ~1 ~ minecraft:air run particle bubble_column_up ~5 ~1 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~5 ~1 ~1 minecraft:air run particle bubble_column_up ~5 ~1 ~1

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~4 ~1 ~1 minecraft:air run particle bubble_column_up ~4 ~1 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~4 ~1 ~ minecraft:air run particle bubble_column_up ~4 ~1 ~

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless block ~3 ~1 ~ minecraft:air run particle bubble_column_up ~3 ~1 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~3 ~1 ~1 minecraft:air run particle bubble_column_up ~3 ~1 ~1

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~2 ~1 ~1 minecraft:air run particle bubble_column_up ~2 ~1 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~1 ~ minecraft:air run particle bubble_column_up ~2 ~1 ~

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless block ~1 ~1 ~ minecraft:air run particle bubble_column_up ~1 ~1 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~1 ~1 ~1 minecraft:air run particle bubble_column_up ~1 ~1 ~1

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~ ~1 ~1 minecraft:air run particle bubble_column_up ~ ~1 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~1 ~ minecraft:air run particle bubble_column_up ~ ~1 ~

    # Layer 3
    scoreboard players add #Physics.Maths.BlockPos.y Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.y Physics.Value > @s Physics.Object.BoundingBoxGlobalMax.y run return 0

    execute unless block ~ ~2 ~ minecraft:air run particle bubble_column_up ~ ~2 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~ ~2 ~1 minecraft:air run particle bubble_column_up ~ ~2 ~1

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~1 ~2 ~1 minecraft:air run particle bubble_column_up ~1 ~2 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~2 ~ minecraft:air run particle bubble_column_up ~1 ~2 ~

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless block ~2 ~2 ~ minecraft:air run particle bubble_column_up ~2 ~2 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~2 ~2 ~1 minecraft:air run particle bubble_column_up ~2 ~2 ~1

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~3 ~2 ~1 minecraft:air run particle bubble_column_up ~3 ~2 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~3 ~2 ~ minecraft:air run particle bubble_column_up ~3 ~2 ~

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless block ~4 ~2 ~ minecraft:air run particle bubble_column_up ~4 ~2 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~4 ~2 ~1 minecraft:air run particle bubble_column_up ~4 ~2 ~1

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~5 ~2 ~1 minecraft:air run particle bubble_column_up ~5 ~2 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~5 ~2 ~ minecraft:air run particle bubble_column_up ~5 ~2 ~
