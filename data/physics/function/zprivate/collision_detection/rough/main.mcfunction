# (Important): Only checks objects in a range of 26.5 blocks so I can avoid an integer overflow in the calculation of the squared distance, while saving 3 divisions. This means that the maximum size an object can have is restricted to a max side length of 13.25 blocks.
tag @s add Physics.Checked
scoreboard players operation #Physics.OtherObject Physics.Object.ID = @s Physics.Object.ID
scoreboard players operation #Physics.OtherObject Physics.Object.Pos.x = @s Physics.Object.Pos.x
scoreboard players operation #Physics.OtherObject Physics.Object.Pos.y = @s Physics.Object.Pos.y
scoreboard players operation #Physics.OtherObject Physics.Object.Pos.z = @s Physics.Object.Pos.z
scoreboard players operation #Physics.OtherObject Physics.Object.HitboxRadiusSquared = @s Physics.Object.HitboxRadiusSquared
execute at @s as @e[type=minecraft:item_display,tag=Physics.Object,tag=!Physics.Checked,distance=..26.5] run function physics:zprivate/collision_detection/rough/check
