# Debug: Show axes
execute if score #Physics.Debug.ShowAxes Physics matches 1 as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:debug/show_axes

# New Player: Set PlayerID
# (Important): It's not an advancement because the scoreboard objective gets removed when running 'uninstall', which would break it (Players lose their ID). I can't revoke advancements from offline players, and running 'uninstall' doesn't remove the advancement either.
execute as @a unless score @s Physics.Player.ID matches 1.. run function physics:zprivate/new_player

# Line of sight: Spawn or teleport punchable interaction hitboxes
    # Spawn hitboxes
    execute store result score #Physics.Gametime Physics run time query gametime
    scoreboard players set #Physics.SuccessfulTeleports Physics 0
    execute as @a run function physics:zprivate/line_of_sight/main

    # Kill leftover hitboxes
    # (Important): Because interaction entities can unload, players can leave etc.
    execute if score #Physics.InteractionCount Physics > #Physics.SuccessfulTeleports Physics as @e[type=minecraft:interaction,tag=Physics.Hitbox] unless score @s Physics.Hitbox.Gametime = #Physics.Gametime Physics run function physics:zprivate/line_of_sight/kill_leftover

# Contact Generation: Setup
# (Important): The last command is run so the "HitboxHasPreviousContacts" score doesn't get set to 0 if the data matches the previous tick's data exactly (Which only really happens if only one object exists).
data modify storage physics:temp data.ContactGroupsPrevious set from storage physics:zprivate ContactGroups
data modify storage physics:zprivate ContactGroups set value []
data remove storage physics:temp data.Hitbox

# Collision Detection (Minecraft blocks & Dynamic objects) & Contact Generation
execute as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:zprivate/collision_detection/main
tag @e[type=minecraft:item_display,tag=Physics.Checked] remove Physics.Checked

# Contact Resolution
# ...

# Integration: Update every object
execute as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:zprivate/integration/main
