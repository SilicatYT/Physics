# IDEA: Take the player's reach into account (Currently they can hit any point of the object as long as they can hit the interaction entity at all)
# IDEA: Also check hits for other display entities whose interaction hitbox are in the path of the player's reach
# IDEA: Use the iris library to check for blocks that would be in the way, so you can't hit through walls if the interaction entity hitbox sticks out
# Note: These calculations assume a friction coefficient of 1 for simplicity. See the older commits (Dec 10, 2024) to see a rough implementation of the contact force.

# Check if this is the interaction entity that was hit
execute if score #Physics.Found Physics matches 1 run return 0
execute on attacker if entity @s[tag=Physics.This] run scoreboard players set #Physics.Found Physics 1
execute if score #Physics.Found Physics matches 0 run return 0

# Found: Initiate a check to see if the player hit the model
execute on attacker at @s anchored eyes run tp 0-0-0-0-0 ^ ^ ^ ~ ~
data remove entity @s attack

    # Transform the unit ray from the player's eyes to the object's local coordinates
        # Get ray origin relative to the object
        # (Important): For the scaling, look at the notes from below
        data modify storage physics:temp data.PlayerAttack.RayPos set from entity 0-0-0-0-0 Pos
        execute in minecraft:overworld positioned 0.0 0.0 0.0 rotated as 0-0-0-0-0 run tp 0-0-0-0-0 ^ ^ ^1
        data modify storage physics:temp data.PlayerAttack.RayDirection set from entity 0-0-0-0-0 Pos
        execute store result score #Physics.Maths.RayPos.x Physics store result score #Physics.Maths.RayPosCopy.x Physics run data get storage physics:temp data.PlayerAttack.RayPos[0] 1000
        execute store result score #Physics.Maths.RayPos.y Physics store result score #Physics.Maths.RayPosCopy.y Physics run data get storage physics:temp data.PlayerAttack.RayPos[1] 1000
        execute store result score #Physics.Maths.RayPos.z Physics store result score #Physics.Maths.RayPosCopy.z Physics run data get storage physics:temp data.PlayerAttack.RayPos[2] 1000
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayPos.x Physics -= @s Physics.Object.Pos.x
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayPos.y Physics -= @s Physics.Object.Pos.y
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayPos.z Physics -= @s Physics.Object.Pos.z

        # Get ray direction
        execute store result score #Physics.Maths.RayDirection.x Physics store result score #Physics.Maths.RayDirectionCopy.x Physics run data get storage physics:temp data.PlayerAttack.RayDirection[0] 1000
        execute store result score #Physics.Maths.RayDirection.y Physics store result score #Physics.Maths.RayDirectionCopy.y Physics run data get storage physics:temp data.PlayerAttack.RayDirection[1] 1000
        execute store result score #Physics.Maths.RayDirection.z Physics store result score #Physics.Maths.RayDirectionCopy.z Physics run data get storage physics:temp data.PlayerAttack.RayDirection[2] 1000

        # Transform the relative ray origin with the transpose of the rotation matrix (Transpose because I convert from world to local coordinates)
        # (Important): Because of the multiplication, I need to divide the result by 1,000 to keep the 1,000x scaling. But the next step requires a multiplication by 2, so I only divide by 500 here.
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayPosLocal.x Physics = @s Physics.Object.RotationMatrixTranspose.0
        scoreboard players operation #Physics.Maths.RayPosLocal.x Physics *= #Physics.Maths.RayPos.x Physics
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.1
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayPos.y Physics
        scoreboard players operation #Physics.Maths.RayPosLocal.x Physics += #Physics.Maths.Value1 Physics
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.2
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayPos.z Physics
        scoreboard players operation #Physics.Maths.RayPosLocal.x Physics += #Physics.Maths.Value1 Physics

        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayPosLocal.y Physics = @s Physics.Object.RotationMatrixTranspose.3
        scoreboard players operation #Physics.Maths.RayPosLocal.y Physics *= #Physics.Maths.RayPos.x Physics
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.4
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayPos.y Physics
        scoreboard players operation #Physics.Maths.RayPosLocal.y Physics += #Physics.Maths.Value1 Physics
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.5
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayPos.z Physics
        scoreboard players operation #Physics.Maths.RayPosLocal.y Physics += #Physics.Maths.Value1 Physics

        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayPosLocal.z Physics = @s Physics.Object.RotationMatrixTranspose.6
        scoreboard players operation #Physics.Maths.RayPosLocal.z Physics *= #Physics.Maths.RayPos.x Physics
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.7
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayPos.y Physics
        scoreboard players operation #Physics.Maths.RayPosLocal.z Physics += #Physics.Maths.Value1 Physics
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.8
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayPos.z Physics
        scoreboard players operation #Physics.Maths.RayPosLocal.z Physics += #Physics.Maths.Value1 Physics

        # Transform the ray direction with the transpose of the rotation matrix (Transpose because I convert from world to local coordinates)
        # (Important): Because of the multiplication, I need to divide the result by 1,000 to keep the 1,000x scaling. But the next step requires a multiplication by 2, so I only divide by 500 here.
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayDirectionLocal.x Physics = @s Physics.Object.RotationMatrixTranspose.0
        scoreboard players operation #Physics.Maths.RayDirectionLocal.x Physics *= #Physics.Maths.RayDirection.x Physics
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.1
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayDirection.y Physics
        scoreboard players operation #Physics.Maths.RayDirectionLocal.x Physics += #Physics.Maths.Value1 Physics
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.2
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayDirection.z Physics
        scoreboard players operation #Physics.Maths.RayDirectionLocal.x Physics += #Physics.Maths.Value1 Physics

        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayDirectionLocal.y Physics = @s Physics.Object.RotationMatrixTranspose.3
        scoreboard players operation #Physics.Maths.RayDirectionLocal.y Physics *= #Physics.Maths.RayDirection.x Physics
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.4
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayDirection.y Physics
        scoreboard players operation #Physics.Maths.RayDirectionLocal.y Physics += #Physics.Maths.Value1 Physics
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.5
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayDirection.z Physics
        scoreboard players operation #Physics.Maths.RayDirectionLocal.y Physics += #Physics.Maths.Value1 Physics

        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayDirectionLocal.z Physics = @s Physics.Object.RotationMatrixTranspose.6
        scoreboard players operation #Physics.Maths.RayDirectionLocal.z Physics *= #Physics.Maths.RayDirection.x Physics
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.7
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayDirection.y Physics
        scoreboard players operation #Physics.Maths.RayDirectionLocal.z Physics += #Physics.Maths.Value1 Physics
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.8
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayDirection.z Physics
        scoreboard players operation #Physics.Maths.RayDirectionLocal.z Physics += #Physics.Maths.Value1 Physics

        # Compress the object's dimensions to a unit cube, and adjust the ray origin and direction accordingly
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayPosLocal.x Physics /= @s Physics.Object.Dimension.x
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayPosLocal.y Physics /= @s Physics.Object.Dimension.y
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayPosLocal.z Physics /= @s Physics.Object.Dimension.z
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayDirectionLocal.x Physics /= @s Physics.Object.Dimension.x
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayDirectionLocal.y Physics /= @s Physics.Object.Dimension.y
        execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayDirectionLocal.z Physics /= @s Physics.Object.Dimension.z

    # Check if / where the ray hits the object
    # (Important): Position is scaled up by 1,000x (So 1,000,000x in total) to provide accuracy when calculating t
    scoreboard players operation #Physics.Maths.RayPosLocalScaled.x Physics = #Physics.Maths.RayPosLocal.x Physics
    scoreboard players operation #Physics.Maths.RayPosLocalScaled.y Physics = #Physics.Maths.RayPosLocal.y Physics
    scoreboard players operation #Physics.Maths.RayPosLocalScaled.z Physics = #Physics.Maths.RayPosLocal.z Physics

    scoreboard players operation #Physics.Maths.RayPosLocalScaled.x Physics *= #Physics.Constants.1000 Physics
    scoreboard players operation #Physics.Maths.RayPosLocalScaled.y Physics *= #Physics.Constants.1000 Physics
    scoreboard players operation #Physics.Maths.RayPosLocalScaled.z Physics *= #Physics.Constants.1000 Physics

    function physics:zprivate/forces/player_attack/check_ray_intersections/0
    function physics:zprivate/forces/player_attack/check_ray_intersections/1
    function physics:zprivate/forces/player_attack/check_ray_intersections/2
    function physics:zprivate/forces/player_attack/check_ray_intersections/3
    function physics:zprivate/forces/player_attack/check_ray_intersections/4
    function physics:zprivate/forces/player_attack/check_ray_intersections/5

    # Check if no intersection happened
    execute if score #Physics.Maths.RayIntersection.t0 Physics matches 2147483647 if score #Physics.Maths.RayIntersection.t1 Physics matches 2147483647 if score #Physics.Maths.RayIntersection.t2 Physics matches 2147483647 if score #Physics.Maths.RayIntersection.t3 Physics matches 2147483647 if score #Physics.Maths.RayIntersection.t4 Physics matches 2147483647 if score #Physics.Maths.RayIntersection.t5 Physics matches 2147483647 run return 0

    # Get the earliest intersection
    scoreboard players operation #Physics.Maths.RayIntersection.Earliest Physics = #Physics.Maths.RayIntersection.t0 Physics
    execute if score #Physics.Maths.RayIntersection.t1 Physics < #Physics.Maths.RayIntersection.Earliest Physics run scoreboard players operation #Physics.Maths.RayIntersection.Earliest Physics = #Physics.Maths.RayIntersection.t1 Physics
    execute if score #Physics.Maths.RayIntersection.t2 Physics < #Physics.Maths.RayIntersection.Earliest Physics run scoreboard players operation #Physics.Maths.RayIntersection.Earliest Physics = #Physics.Maths.RayIntersection.t2 Physics
    execute if score #Physics.Maths.RayIntersection.t3 Physics < #Physics.Maths.RayIntersection.Earliest Physics run scoreboard players operation #Physics.Maths.RayIntersection.Earliest Physics = #Physics.Maths.RayIntersection.t3 Physics
    execute if score #Physics.Maths.RayIntersection.t4 Physics < #Physics.Maths.RayIntersection.Earliest Physics run scoreboard players operation #Physics.Maths.RayIntersection.Earliest Physics = #Physics.Maths.RayIntersection.t4 Physics
    execute if score #Physics.Maths.RayIntersection.t5 Physics < #Physics.Maths.RayIntersection.Earliest Physics run scoreboard players operation #Physics.Maths.RayIntersection.Earliest Physics = #Physics.Maths.RayIntersection.t5 Physics

    # Get the global coordinates of the intersection
    scoreboard players operation #Physics.Maths.RayDirectionCopy.x Physics *= #Physics.Maths.RayIntersection.Earliest Physics
    scoreboard players operation #Physics.Maths.RayPosCopy.x Physics *= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.IntersectionPosGlobal[0] double 0.000001 run scoreboard players operation #Physics.Maths.RayPosCopy.x Physics += #Physics.Maths.RayDirectionCopy.x Physics

    scoreboard players operation #Physics.Maths.RayDirectionCopy.y Physics *= #Physics.Maths.RayIntersection.Earliest Physics
    scoreboard players operation #Physics.Maths.RayPosCopy.y Physics *= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.IntersectionPosGlobal[1] double 0.000001 run scoreboard players operation #Physics.Maths.RayPosCopy.y Physics += #Physics.Maths.RayDirectionCopy.y Physics

    scoreboard players operation #Physics.Maths.RayDirectionCopy.z Physics *= #Physics.Maths.RayIntersection.Earliest Physics
    scoreboard players operation #Physics.Maths.RayPosCopy.z Physics *= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.IntersectionPosGlobal[2] double 0.000001 run scoreboard players operation #Physics.Maths.RayPosCopy.z Physics += #Physics.Maths.RayDirectionCopy.z Physics

    # Display a crit particle at the intersection coordinates
    tp 0-0-0-0-0 @s
    data modify entity 0-0-0-0-0 Pos set from storage physics:temp data.IntersectionPosGlobal
    execute positioned as 0-0-0-0-0 run particle minecraft:crit ~ ~ ~ 0.1 0.1 0.1 0 3
    execute positioned as 0-0-0-0-0 run playsound minecraft:entity.player.attack.strong block @a ~ ~ ~
    execute in minecraft:overworld run tp 0-0-0-0-0 0.0 0.0 0.0

    # Calculate the physics of the attack
    # (Important): I now scale the RayDirection to match the force the player punched with. Now it's the force that's applied on the hit point.
    execute store result score #Physics.Maths.ForceTangential.x Physics run scoreboard players operation #Physics.Maths.RayDirection.x Physics *= #Physics.Global.PlayerAttackForceMagnitude Physics
    execute store result score #Physics.Maths.ForceTangential.y Physics run scoreboard players operation #Physics.Maths.RayDirection.y Physics *= #Physics.Global.PlayerAttackForceMagnitude Physics
    execute store result score #Physics.Maths.ForceTangential.z Physics run scoreboard players operation #Physics.Maths.RayDirection.z Physics *= #Physics.Global.PlayerAttackForceMagnitude Physics

        # Torque
            # Get the relative coordinates of the intersection (intersection_pos - object_pos). In other words, the vector from the object's center of mass to the intersection point that I hit, in global coordinates.
            scoreboard players operation #Physics.Maths.RayPosCopy.x Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.RayPosCopy.y Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.RayPosCopy.z Physics /= #Physics.Constants.1000 Physics
            execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayPosCopy.x Physics -= @s Physics.Object.Pos.x
            execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayPosCopy.y Physics -= @s Physics.Object.Pos.y
            execute on vehicle on vehicle run scoreboard players operation #Physics.Maths.RayPosCopy.z Physics -= @s Physics.Object.Pos.z

            # Torque = r x force (With r being the vector from the object origin to the global point that was hit)
            # (Important): Because both Pos and Direction are scaled by 1,000x, this means their product is scaled by 1,000,000x. So I have to divide the result by 1,000x before adding it to the accumulated torque.
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Maths.RayPosCopy.y Physics
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayDirection.z Physics
            scoreboard players operation #Physics.Maths.Value2 Physics = #Physics.Maths.RayPosCopy.z Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.RayDirection.y Physics
            scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
            execute on vehicle on vehicle run scoreboard players operation @s Physics.Object.AccumulatedTorque.x += #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Maths.RayPosCopy.z Physics
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayDirection.x Physics
            scoreboard players operation #Physics.Maths.Value2 Physics = #Physics.Maths.RayPosCopy.x Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.RayDirection.z Physics
            scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
            execute on vehicle on vehicle run scoreboard players operation @s Physics.Object.AccumulatedTorque.y += #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Maths.RayPosCopy.x Physics
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayDirection.y Physics
            scoreboard players operation #Physics.Maths.Value2 Physics = #Physics.Maths.RayPosCopy.y Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.RayDirection.x Physics
            scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
            execute on vehicle on vehicle run scoreboard players operation @s Physics.Object.AccumulatedTorque.z += #Physics.Maths.Value1 Physics

        # Linear force
        execute on vehicle on vehicle run scoreboard players operation @s Physics.Object.AccumulatedForce.x += #Physics.Maths.RayDirection.x Physics
        execute on vehicle on vehicle run scoreboard players operation @s Physics.Object.AccumulatedForce.y += #Physics.Maths.RayDirection.y Physics
        execute on vehicle on vehicle run scoreboard players operation @s Physics.Object.AccumulatedForce.z += #Physics.Maths.RayDirection.z Physics
