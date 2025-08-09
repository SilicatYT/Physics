# Get corner position
$execute store result score #Physics.ContactCorner.x Physics run scoreboard players operation #Physics.ContactPoint.x Physics = #Physics.Projection.Block.WorldAxis.x.$(x) Physics
$execute store result score #Physics.ContactCorner.y Physics run scoreboard players operation #Physics.ContactPoint.y Physics = #Physics.Projection.Block.WorldAxis.y.$(y) Physics
$execute store result score #Physics.ContactCorner.z Physics run scoreboard players operation #Physics.ContactPoint.z Physics = #Physics.Projection.Block.WorldAxis.z.$(z) Physics

# Update the penetration depth storage, contact normal, contact point & separating velocity
# (Important): Only update them if the penetration depth is positive.
    # Penetration Depth
    execute store result storage physics:temp data.NewContact.PenetrationDepth short 1 run scoreboard players get #Physics.PenetrationDepth Physics

    # Contact Normal
    execute store result storage physics:temp data.NewContact.ContactNormal[0] int 1 run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Axis.y.x
    execute store result storage physics:temp data.NewContact.ContactNormal[1] int 1 run scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Axis.y.y
    execute store result storage physics:temp data.NewContact.ContactNormal[2] int 1 run scoreboard players operation #Physics.Maths.Value3 Physics = @s Physics.Object.Axis.y.z

    # Contact Point
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 run scoreboard players operation #Physics.ContactPoint.x Physics += #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.Maths.Value2 Physics

    scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.NewContact.ContactPoint[2] int 1 run scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.Maths.Value3 Physics

    # Separating Velocity
        # Calculate relative contact point
        execute store result score #Physics.PointVelocity.z Physics run scoreboard players operation #Physics.ContactPoint.x Physics -= @s Physics.Object.Pos.x
        execute store result score #Physics.PointVelocity.x Physics run scoreboard players operation #Physics.ContactPoint.y Physics -= @s Physics.Object.Pos.y
        execute store result score #Physics.PointVelocity.y Physics run scoreboard players operation #Physics.ContactPoint.z Physics -= @s Physics.Object.Pos.z

        # Calculate cross product between angular velocity and relative contact point
        # (Important): I messed up the order (relativeContactPoint x angularVelocity instead of angularVelocity x relativeContactPoint). To accomodate for that without spending hours rewriting it, I divide by -1000 instead of 1000.
        scoreboard players operation #Physics.PointVelocity.x Physics *= @s Physics.Object.AngularVelocity.z
        scoreboard players operation #Physics.ContactPoint.z Physics *= @s Physics.Object.AngularVelocity.y
        scoreboard players operation #Physics.PointVelocity.x Physics -= #Physics.ContactPoint.z Physics
        scoreboard players operation #Physics.PointVelocity.x Physics /= #Physics.Constants.-1000 Physics

        scoreboard players operation #Physics.PointVelocity.y Physics *= @s Physics.Object.AngularVelocity.x
        scoreboard players operation #Physics.ContactPoint.x Physics *= @s Physics.Object.AngularVelocity.z
        scoreboard players operation #Physics.PointVelocity.y Physics -= #Physics.ContactPoint.x Physics
        scoreboard players operation #Physics.PointVelocity.y Physics /= #Physics.Constants.-1000 Physics

        scoreboard players operation #Physics.PointVelocity.z Physics *= @s Physics.Object.AngularVelocity.y
        scoreboard players operation #Physics.ContactPoint.y Physics *= @s Physics.Object.AngularVelocity.x
        scoreboard players operation #Physics.PointVelocity.z Physics -= #Physics.ContactPoint.y Physics
        scoreboard players operation #Physics.PointVelocity.z Physics /= #Physics.Constants.-1000 Physics

        # Add the linear velocity to obtain the relative velocity of the contact point
        scoreboard players operation #Physics.PointVelocity.x Physics += @s Physics.Object.Velocity.x
        scoreboard players operation #Physics.PointVelocity.y Physics += @s Physics.Object.Velocity.y
        scoreboard players operation #Physics.PointVelocity.z Physics += @s Physics.Object.Velocity.z

        # Calculate the relative velocity's dot product with the contact normal to get the separation velocity (single number, not a vector) and store it
        scoreboard players operation #Physics.PointVelocity.x Physics *= @s Physics.Object.Axis.x.x
        scoreboard players operation #Physics.PointVelocity.y Physics *= @s Physics.Object.Axis.x.y
        scoreboard players operation #Physics.PointVelocity.z Physics *= @s Physics.Object.Axis.x.z

        scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.PointVelocity.y Physics
        scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.PointVelocity.z Physics

        execute store result storage physics:temp data.NewContact.SeparatingVelocity short 1 run scoreboard players operation #Physics.PointVelocity.x Physics /= #Physics.Constants.1000 Physics
