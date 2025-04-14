# Get which object has the closest intersection point
# (Important): The distance selector is <entity_interaction_range in creative mode> + sqrt(3*<largest allowed side length>^2)/2
scoreboard players set #Physics.GotRayPos Physics 0
execute store result score #Physics.EntityInteractionRange Physics run attribute @s minecraft:entity_interaction_range get 1000
execute anchored eyes positioned ^ ^ ^ as @e[type=minecraft:item_display,tag=Physics.Object,distance=..8.464] run function physics:zprivate/line_of_sight/check_aabb_intersection

# Check if an intersection happened
execute unless score @s Physics.Player.LookingAtID matches 1.. run return run execute if entity @s[tag=Physics.HasHitbox] run function physics:zprivate/line_of_sight/kill_hitbox

# An intersection happened
    # Try to teleport the interaction entity
    execute if entity @s[tag=Physics.HasHitbox] run say function teleport
    execute if score #Physics.TeleportSuccess Physics matches 1 run return run scoreboard players set #Physics.MinDistance Physics 2147483647

    # Summon a new interaction entity
    scoreboard players operation #Physics.NewHitbox Physics.Player.ID = @s Physics.Player.ID
    #execute summon minecraft:interaction run function physics:zprivate/line_of_sight/summon_hitbox

scoreboard players set #Physics.MinDistance Physics 2147483647
