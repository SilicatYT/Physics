advancement revoke @s only physics:hit_object_interaction

# Find interaction entity
tag @s add Physics.This
scoreboard players set #Physics.Found Physics 0
execute as @e[type=minecraft:interaction,tag=Physics.Hitbox] run function physics:zprivate/forces/player_attack/check_interaction
tag @s remove Physics.This
