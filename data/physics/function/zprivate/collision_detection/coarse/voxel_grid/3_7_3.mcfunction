# Check all blocks in the bounding box
    # Layer 1
    execute unless block ~ ~ ~ minecraft:air run particle bubble_column_up ~ ~ ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~ ~1 minecraft:air run particle bubble_column_up ~ ~ ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~ ~2 minecraft:air run particle bubble_column_up ~ ~ ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~ ~ ~3 minecraft:air run particle bubble_column_up ~ ~ ~3

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~1 ~ ~3 minecraft:air run particle bubble_column_up ~1 ~ ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~ ~2 minecraft:air run particle bubble_column_up ~1 ~ ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~ ~1 minecraft:air run particle bubble_column_up ~1 ~ ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~ ~ minecraft:air run particle bubble_column_up ~1 ~ ~

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless block ~2 ~ ~ minecraft:air run particle bubble_column_up ~2 ~ ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~ ~1 minecraft:air run particle bubble_column_up ~2 ~ ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~ ~2 minecraft:air run particle bubble_column_up ~2 ~ ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~2 ~ ~3 minecraft:air run particle bubble_column_up ~2 ~ ~3

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~3 ~ ~3 minecraft:air run particle bubble_column_up ~3 ~ ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~ ~2 minecraft:air run particle bubble_column_up ~3 ~ ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~ ~1 minecraft:air run particle bubble_column_up ~3 ~ ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~ ~ minecraft:air run particle bubble_column_up ~3 ~ ~

    # Layer 2
    scoreboard players add #Physics.Maths.BlockPos.y Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~1 ~ minecraft:air run particle bubble_column_up ~3 ~1 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~1 ~1 minecraft:air run particle bubble_column_up ~3 ~1 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~1 ~2 minecraft:air run particle bubble_column_up ~3 ~1 ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~3 ~1 ~3 minecraft:air run particle bubble_column_up ~3 ~1 ~3

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~2 ~1 ~3 minecraft:air run particle bubble_column_up ~2 ~1 ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~1 ~2 minecraft:air run particle bubble_column_up ~2 ~1 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~1 ~1 minecraft:air run particle bubble_column_up ~2 ~1 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~1 ~ minecraft:air run particle bubble_column_up ~2 ~1 ~

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless block ~1 ~1 ~ minecraft:air run particle bubble_column_up ~1 ~1 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~1 ~1 minecraft:air run particle bubble_column_up ~1 ~1 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~1 ~2 minecraft:air run particle bubble_column_up ~1 ~1 ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~1 ~1 ~3 minecraft:air run particle bubble_column_up ~1 ~1 ~3

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~ ~1 ~3 minecraft:air run particle bubble_column_up ~ ~1 ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~1 ~2 minecraft:air run particle bubble_column_up ~ ~1 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~1 ~1 minecraft:air run particle bubble_column_up ~ ~1 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~1 ~ minecraft:air run particle bubble_column_up ~ ~1 ~

    # Layer 3
    scoreboard players add #Physics.Maths.BlockPos.y Physics.Value 1000
    execute unless block ~ ~2 ~ minecraft:air run particle bubble_column_up ~ ~2 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~2 ~1 minecraft:air run particle bubble_column_up ~ ~2 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~2 ~2 minecraft:air run particle bubble_column_up ~ ~2 ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~ ~2 ~3 minecraft:air run particle bubble_column_up ~ ~2 ~3

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~1 ~2 ~3 minecraft:air run particle bubble_column_up ~1 ~2 ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~2 ~2 minecraft:air run particle bubble_column_up ~1 ~2 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~2 ~1 minecraft:air run particle bubble_column_up ~1 ~2 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~2 ~ minecraft:air run particle bubble_column_up ~1 ~2 ~

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless block ~2 ~2 ~ minecraft:air run particle bubble_column_up ~2 ~2 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~2 ~1 minecraft:air run particle bubble_column_up ~2 ~2 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~2 ~2 minecraft:air run particle bubble_column_up ~2 ~2 ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~2 ~2 ~3 minecraft:air run particle bubble_column_up ~2 ~2 ~3

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~3 ~2 ~3 minecraft:air run particle bubble_column_up ~3 ~2 ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~2 ~2 minecraft:air run particle bubble_column_up ~3 ~2 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~2 ~1 minecraft:air run particle bubble_column_up ~3 ~2 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~2 ~ minecraft:air run particle bubble_column_up ~3 ~2 ~

    # Layer 4
    scoreboard players add #Physics.Maths.BlockPos.y Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~3 ~ minecraft:air run particle bubble_column_up ~3 ~3 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~3 ~1 minecraft:air run particle bubble_column_up ~3 ~3 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~3 ~2 minecraft:air run particle bubble_column_up ~3 ~3 ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~3 ~3 ~3 minecraft:air run particle bubble_column_up ~3 ~3 ~3

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~2 ~3 ~3 minecraft:air run particle bubble_column_up ~2 ~3 ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~3 ~2 minecraft:air run particle bubble_column_up ~2 ~3 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~3 ~1 minecraft:air run particle bubble_column_up ~2 ~3 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~3 ~ minecraft:air run particle bubble_column_up ~2 ~3 ~

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless block ~1 ~3 ~ minecraft:air run particle bubble_column_up ~1 ~3 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~3 ~1 minecraft:air run particle bubble_column_up ~1 ~3 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~3 ~2 minecraft:air run particle bubble_column_up ~1 ~3 ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~1 ~3 ~3 minecraft:air run particle bubble_column_up ~1 ~3 ~3

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~ ~3 ~3 minecraft:air run particle bubble_column_up ~ ~3 ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~3 ~2 minecraft:air run particle bubble_column_up ~ ~3 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~3 ~1 minecraft:air run particle bubble_column_up ~ ~3 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~3 ~ minecraft:air run particle bubble_column_up ~ ~3 ~

    # Layer 5
    scoreboard players add #Physics.Maths.BlockPos.y Physics.Value 1000
    execute unless block ~ ~4 ~ minecraft:air run particle bubble_column_up ~ ~4 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~4 ~1 minecraft:air run particle bubble_column_up ~ ~4 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~4 ~2 minecraft:air run particle bubble_column_up ~ ~4 ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~ ~4 ~3 minecraft:air run particle bubble_column_up ~ ~4 ~3

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~1 ~4 ~3 minecraft:air run particle bubble_column_up ~1 ~4 ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~4 ~2 minecraft:air run particle bubble_column_up ~1 ~4 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~4 ~1 minecraft:air run particle bubble_column_up ~1 ~4 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~4 ~ minecraft:air run particle bubble_column_up ~1 ~4 ~

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless block ~2 ~4 ~ minecraft:air run particle bubble_column_up ~2 ~4 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~4 ~1 minecraft:air run particle bubble_column_up ~2 ~4 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~4 ~2 minecraft:air run particle bubble_column_up ~2 ~4 ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~2 ~4 ~3 minecraft:air run particle bubble_column_up ~2 ~4 ~3

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~3 ~4 ~3 minecraft:air run particle bubble_column_up ~3 ~4 ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~4 ~2 minecraft:air run particle bubble_column_up ~3 ~4 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~4 ~1 minecraft:air run particle bubble_column_up ~3 ~4 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~4 ~ minecraft:air run particle bubble_column_up ~3 ~4 ~

    # Layer 6
    scoreboard players add #Physics.Maths.BlockPos.y Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~5 ~ minecraft:air run particle bubble_column_up ~3 ~5 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~5 ~1 minecraft:air run particle bubble_column_up ~3 ~5 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~5 ~2 minecraft:air run particle bubble_column_up ~3 ~5 ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~3 ~5 ~3 minecraft:air run particle bubble_column_up ~3 ~5 ~3

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~2 ~5 ~3 minecraft:air run particle bubble_column_up ~2 ~5 ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~5 ~2 minecraft:air run particle bubble_column_up ~2 ~5 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~5 ~1 minecraft:air run particle bubble_column_up ~2 ~5 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~5 ~ minecraft:air run particle bubble_column_up ~2 ~5 ~

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless block ~1 ~5 ~ minecraft:air run particle bubble_column_up ~1 ~5 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~5 ~1 minecraft:air run particle bubble_column_up ~1 ~5 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~5 ~2 minecraft:air run particle bubble_column_up ~1 ~5 ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~1 ~5 ~3 minecraft:air run particle bubble_column_up ~1 ~5 ~3

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~ ~5 ~3 minecraft:air run particle bubble_column_up ~ ~5 ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~5 ~2 minecraft:air run particle bubble_column_up ~ ~5 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~5 ~1 minecraft:air run particle bubble_column_up ~ ~5 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~5 ~ minecraft:air run particle bubble_column_up ~ ~5 ~

    # Layer 7
    scoreboard players add #Physics.Maths.BlockPos.y Physics.Value 1000
    execute unless block ~ ~6 ~ minecraft:air run particle bubble_column_up ~ ~6 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~6 ~1 minecraft:air run particle bubble_column_up ~ ~6 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~6 ~2 minecraft:air run particle bubble_column_up ~ ~6 ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~ ~6 ~3 minecraft:air run particle bubble_column_up ~ ~6 ~3

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~1 ~6 ~3 minecraft:air run particle bubble_column_up ~1 ~6 ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~6 ~2 minecraft:air run particle bubble_column_up ~1 ~6 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~6 ~1 minecraft:air run particle bubble_column_up ~1 ~6 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~6 ~ minecraft:air run particle bubble_column_up ~1 ~6 ~

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless block ~2 ~6 ~ minecraft:air run particle bubble_column_up ~2 ~6 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~6 ~1 minecraft:air run particle bubble_column_up ~2 ~6 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~6 ~2 minecraft:air run particle bubble_column_up ~2 ~6 ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~2 ~6 ~3 minecraft:air run particle bubble_column_up ~2 ~6 ~3

    scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~3 ~6 ~3 minecraft:air run particle bubble_column_up ~3 ~6 ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~6 ~2 minecraft:air run particle bubble_column_up ~3 ~6 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~6 ~1 minecraft:air run particle bubble_column_up ~3 ~6 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~6 ~ minecraft:air run particle bubble_column_up ~3 ~6 ~

    # Layer 8
    scoreboard players add #Physics.Maths.BlockPos.y Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.y Physics.Value > @s Physics.Object.BoundingBoxGlobalMax.y run return 0

    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~7 ~ minecraft:air run particle bubble_column_up ~3 ~7 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~7 ~1 minecraft:air run particle bubble_column_up ~3 ~7 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x unless block ~3 ~7 ~2 minecraft:air run particle bubble_column_up ~3 ~7 ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.x Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~3 ~7 ~3 minecraft:air run particle bubble_column_up ~3 ~7 ~3

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~2 ~7 ~3 minecraft:air run particle bubble_column_up ~2 ~7 ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~7 ~2 minecraft:air run particle bubble_column_up ~2 ~7 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~7 ~1 minecraft:air run particle bubble_column_up ~2 ~7 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~2 ~7 ~ minecraft:air run particle bubble_column_up ~2 ~7 ~

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute unless block ~1 ~7 ~ minecraft:air run particle bubble_column_up ~1 ~7 ~

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~7 ~1 minecraft:air run particle bubble_column_up ~1 ~7 ~1

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~1 ~7 ~2 minecraft:air run particle bubble_column_up ~1 ~7 ~2

    scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~1 ~7 ~3 minecraft:air run particle bubble_column_up ~1 ~7 ~3

    scoreboard players remove #Physics.Maths.BlockPos.x Physics.Value 1000
    execute if score #Physics.Maths.BlockPos.z Physics.Value <= @s Physics.Object.BoundingBoxGlobalMax.z unless block ~ ~7 ~3 minecraft:air run particle bubble_column_up ~ ~7 ~3

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~7 ~2 minecraft:air run particle bubble_column_up ~ ~7 ~2

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~7 ~1 minecraft:air run particle bubble_column_up ~ ~7 ~1

    scoreboard players remove #Physics.Maths.BlockPos.z Physics.Value 1000
    execute unless block ~ ~7 ~ minecraft:air run particle bubble_column_up ~ ~7 ~
