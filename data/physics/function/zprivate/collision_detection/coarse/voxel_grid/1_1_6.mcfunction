# Check all blocks in the bounding box
    # Layer 1
    execute unless block ~ ~ ~ minecraft:air run particle bubble_column_up ~ ~ ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~ ~1 minecraft:air run particle bubble_column_up ~ ~ ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~ ~2 minecraft:air run particle bubble_column_up ~ ~ ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~ ~3 minecraft:air run particle bubble_column_up ~ ~ ~3

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~ ~4 minecraft:air run particle bubble_column_up ~ ~ ~4

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~ ~5 minecraft:air run particle bubble_column_up ~ ~ ~5

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~ ~ ~6 minecraft:air run particle bubble_column_up ~ ~ ~6

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~1 ~ ~6 minecraft:air run particle bubble_column_up ~1 ~ ~6

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~1 ~ ~5 minecraft:air run particle bubble_column_up ~1 ~ ~5

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~1 ~ ~4 minecraft:air run particle bubble_column_up ~1 ~ ~4

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~1 ~ ~3 minecraft:air run particle bubble_column_up ~1 ~ ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~1 ~ ~2 minecraft:air run particle bubble_column_up ~1 ~ ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~1 ~ ~1 minecraft:air run particle bubble_column_up ~1 ~ ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~1 ~ ~ minecraft:air run particle bubble_column_up ~1 ~ ~

    # Layer 2
    scoreboard players add #Physics.Maths.BlockPos.y Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.y Physics.Value > @s Physics.Object.BoundingBoxGlobalMax.y run return 0

    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~1 ~1 ~ minecraft:air run particle bubble_column_up ~1 ~1 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~1 ~1 ~1 minecraft:air run particle bubble_column_up ~1 ~1 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~1 ~1 ~2 minecraft:air run particle bubble_column_up ~1 ~1 ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~1 ~1 ~3 minecraft:air run particle bubble_column_up ~1 ~1 ~3

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~1 ~1 ~4 minecraft:air run particle bubble_column_up ~1 ~1 ~4

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~1 ~1 ~5 minecraft:air run particle bubble_column_up ~1 ~1 ~5

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~1 ~1 ~6 minecraft:air run particle bubble_column_up ~1 ~1 ~6

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~ ~1 ~6 minecraft:air run particle bubble_column_up ~ ~1 ~6

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~1 ~5 minecraft:air run particle bubble_column_up ~ ~1 ~5

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~1 ~4 minecraft:air run particle bubble_column_up ~ ~1 ~4

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~1 ~3 minecraft:air run particle bubble_column_up ~ ~1 ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~1 ~2 minecraft:air run particle bubble_column_up ~ ~1 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~1 ~1 minecraft:air run particle bubble_column_up ~ ~1 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~1 ~ minecraft:air run particle bubble_column_up ~ ~1 ~
