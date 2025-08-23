# (Tick order explanation): The ideal order of operations would be: 1. Integration (Calculate values & apply constant forces like gravity), 2. Collision Detection, 3. Contact Generation, 4. Apply contact-dependent forces like buoyancy, 5. Contact Resolution, 6. Update visuals
#                           However, step 4 would require updating the separating velocities again (or reworking a lot of code), so I'd rather do that in step 1. It shouldn't make much of a difference.
#                           And I can do step 1 inside step 6 to avoid an @e call, with the downside that newly spawned objects won't collide properly in their first tick. This can be resolved in other ways though, so that's the order I went with.
#                           (It increased the delay for punching, gravity and stuff by 1 tick. If that ends up being too noticeable, maybe there could be made exceptions for specific force types)
#                           Edit: When I punched the object, it didn't update the internal value for position & orientation until the end of the tick (after resolution). So it actually does make it a bit more responsive to calculate the internal values (not visuals) before collision detection happens, even if it requires an additional @e call and 1 function call per object.

# Debug: Show axes
execute if score #Physics.Debug.ShowAxes Physics matches 1 as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:debug/show_axes

# New Player: Set PlayerID
# (Important): It's not an advancement because the scoreboard objective gets removed when running 'uninstall', which would break it (Players lose their ID). I can't revoke advancements from offline players, and running 'uninstall' doesn't remove the advancement either.
execute as @a unless score @s Physics.Player.ID matches 1.. run function physics:zprivate/new_player

# Line of sight: Spawn or teleport punchable interaction hitboxes
    # Spawn or teleport hitboxes
    execute store result score #Physics.Gametime Physics run time query gametime
    scoreboard players set #Physics.SuccessfulTeleports Physics 0
    execute as @a run function physics:zprivate/line_of_sight/main

    # Kill leftover hitboxes
    # (Important): Because interaction entities can unload, players can leave etc.
    execute if score #Physics.InteractionCount Physics > #Physics.SuccessfulTeleports Physics as @e[type=minecraft:interaction,tag=Physics.Hitbox] unless score @s Physics.Hitbox.Gametime = #Physics.Gametime Physics run function physics:zprivate/line_of_sight/kill_leftover

# Integration (Part 1): Update internal values
execute as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:zprivate/integration/1

# Contact Generation: Setup
# (Important): The last command is run so the "HitboxHasPreviousContacts" score doesn't get set to 0 if the data matches the previous tick's data exactly (Which only really happens if only one object exists).
    # Remove the Invalid:1b tag from all contacts
    data remove storage physics:temp data.ContactGroups[].Objects[].Contacts[].Invalid
    data remove storage physics:temp data.ContactGroups[].Objects[].Blocks[].Hitboxes[].Contacts[].Invalid

data modify storage physics:temp data.ContactGroupsPrevious set from storage physics:zprivate ContactGroups
data modify storage physics:zprivate ContactGroups set value []
data remove storage physics:temp data.Hitbox

# Collision Detection (Minecraft blocks & Dynamic objects) & Contact Generation
execute as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:zprivate/collision_detection/main

# Contact Resolution
# ...

# Integration (Part 2): Update visual state
execute as @e[type=minecraft:item_display,tag=Physics.Object] run function physics:zprivate/integration/2
