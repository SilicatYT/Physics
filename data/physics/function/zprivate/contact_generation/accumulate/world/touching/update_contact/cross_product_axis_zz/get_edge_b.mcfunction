# Get Edge B
    # Set the start point
    $scoreboard players operation #Physics.ObjectB.EdgeStart.x Physics = #Physics.Projection.Block.WorldAxis.x.$(x) Physics
    $scoreboard players operation #Physics.ObjectB.EdgeStart.y Physics = #Physics.Projection.Block.WorldAxis.y.$(y) Physics
    $scoreboard players operation #Physics.ObjectB.EdgeStart.z Physics = #Physics.Projection.Block.WorldAxis.z.$(z) Physics

    # Subtract the start point from the other edge's start point for calculating (u - m)
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.ObjectB.EdgeStart.x Physics
    scoreboard players operation #Physics.Maths.Value2 Physics -= #Physics.ObjectB.EdgeStart.y Physics
    scoreboard players operation #Physics.Maths.Value3 Physics -= #Physics.ObjectB.EdgeStart.z Physics

    # Get the edge's projection (For inverting the contact normal if necessary)
    $scoreboard players operation #Physics.ObjectB.EdgeProjection Physics = #Physics.Projection.BlockCornerBase$(StartCorner).CrossProductAxis.zz Physics
    execute store result score #Physics.PenetrationDepth Physics run scoreboard players operation #Physics.ObjectB.EdgeProjection Physics += #Physics.Projection.BlockCenter.CrossProductAxis.zz Physics

# Contact Point
    # Calculate intermediate results (Dot products)
        # D = v * (u - m)
        scoreboard players operation #Physics.Maths.D Physics = @s Physics.Object.Axis.z.x
        scoreboard players operation #Physics.Maths.D Physics *= #Physics.Maths.Value1 Physics

        scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Axis.z.y
        scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value2 Physics

        scoreboard players operation #Physics.Maths.Value3 Physics *= @s Physics.Object.Axis.z.z
        scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value3 Physics

    # Calculate s (On ObjectA's edge)
        # CE - BD
        execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.Maths.s Physics = @s Physics.Object.Axis.z.x
        scoreboard players operation #Physics.Maths.s Physics *= #Physics.Maths.Value1 Physics
        scoreboard players operation #Physics.Maths.s Physics -= #Physics.Maths.D Physics

        # AB - CC
        scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
        scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.-1000 Physics
        scoreboard players add #Physics.Maths.Value2 Physics 1000

        # s = (CE - BD) / (AB - CC)
        execute store result score #Physics.ContactPoint.y Physics store result score #Physics.ContactPoint.z Physics run scoreboard players operation #Physics.Maths.s Physics /= #Physics.Maths.Value2 Physics

    # Calculate t (On ObjectB's edge)
        # AE - CD
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.Maths.D Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.Maths.D Physics *= @s Physics.Object.Axis.z.x
        scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.D Physics

        # t = (AE - CD) / (AB - CC)
        scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Maths.Value2 Physics

    # Calculate the contact point (Middle between points on edges A and B)
        # Point on EdgeA
        scoreboard players operation #Physics.Maths.s Physics *= @s Physics.Object.Axis.z.x
        scoreboard players operation #Physics.Maths.s Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.Maths.s Physics += #Physics.ObjectA.EdgeStart.x Physics

        scoreboard players operation #Physics.ContactPoint.y Physics *= @s Physics.Object.Axis.z.y
        scoreboard players operation #Physics.ContactPoint.y Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.ObjectA.EdgeStart.y Physics

        scoreboard players operation #Physics.ContactPoint.z Physics *= @s Physics.Object.Axis.z.z
        scoreboard players operation #Physics.ContactPoint.z Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.ObjectA.EdgeStart.z Physics

        # Point on EdgeB & Get average
        # (Important): The ObjectB axis only goes along the z direction, so I can just add the EdgeStart for the other components and then divide by 2.
        scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.Maths.Value1 Physics
        execute store result storage physics:temp data.NewContact.ContactPoint[0] int 0.5 run scoreboard players operation #Physics.Maths.s Physics += #Physics.ObjectB.EdgeStart.x Physics
        execute store result storage physics:temp data.NewContact.ContactPoint[1] int 0.5 run scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.ObjectB.EdgeStart.y Physics
        execute store result storage physics:temp data.NewContact.ContactPoint[2] int 0.5 run scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.ObjectB.EdgeStart.z Physics

# Contact Normal
data modify storage physics:temp data.NewContact.ContactNormal[2] set value 0

# Check if the contact is valid (Part 2)
    # Check if the PenetrationDepth is negative
    execute if score #Physics.PenetrationDepth Physics matches ..-1 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_zz/penetration_depth_negative

execute store result storage physics:temp data.NewContact.ContactNormal[0] int 1 run scoreboard players get #Physics.CrossProductAxis.zz.x Physics
execute store result storage physics:temp data.NewContact.ContactNormal[1] int 1 run scoreboard players get #Physics.CrossProductAxis.zz.y Physics

# Separating Velocity
    # Calculate relative contact point
    execute store result score #Physics.PointVelocity.z Physics run scoreboard players operation #Physics.ContactPoint.x Physics -= #Physics.ThisObject Physics.Object.Pos.x
    execute store result score #Physics.PointVelocity.x Physics run scoreboard players operation #Physics.ContactPoint.y Physics -= #Physics.ThisObject Physics.Object.Pos.y
    execute store result score #Physics.PointVelocity.y Physics run scoreboard players operation #Physics.ContactPoint.z Physics -= #Physics.ThisObject Physics.Object.Pos.z

    # Calculate cross product between angular velocity and relative contact point
    # (Important): I messed up the order (relativeContactPoint x angularVelocity instead of angularVelocity x relativeContactPoint). To accomodate for that without spending hours rewriting it, I divide by -1000 instead of 1000.
    scoreboard players operation #Physics.PointVelocity.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
    scoreboard players operation #Physics.ContactPoint.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
    scoreboard players operation #Physics.PointVelocity.x Physics -= #Physics.ContactPoint.z Physics
    scoreboard players operation #Physics.PointVelocity.x Physics /= #Physics.Constants.-1000 Physics

    scoreboard players operation #Physics.PointVelocity.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
    scoreboard players operation #Physics.ContactPoint.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
    scoreboard players operation #Physics.PointVelocity.y Physics -= #Physics.ContactPoint.x Physics
    scoreboard players operation #Physics.PointVelocity.y Physics /= #Physics.Constants.-1000 Physics

    scoreboard players operation #Physics.PointVelocity.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
    scoreboard players operation #Physics.ContactPoint.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
    scoreboard players operation #Physics.PointVelocity.z Physics -= #Physics.ContactPoint.y Physics
    scoreboard players operation #Physics.PointVelocity.z Physics /= #Physics.Constants.-1000 Physics

    # Add the linear velocity to obtain the relative velocity of the contact point
    execute store result storage physics:temp data.NewContact.ContactVelocity[0] int 1 run scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.ThisObject Physics.Object.Velocity.x
    execute store result storage physics:temp data.NewContact.ContactVelocity[1] int 1 run scoreboard players operation #Physics.PointVelocity.y Physics += #Physics.ThisObject Physics.Object.Velocity.y
    execute store result storage physics:temp data.NewContact.ContactVelocity[2] int 1 run scoreboard players operation #Physics.PointVelocity.z Physics += #Physics.ThisObject Physics.Object.Velocity.z

    # Calculate the relative velocity's dot product with the contact normal to get the separation velocity (single number, not a vector) and store it
    # (Important): Because the block's z axis component is 1, the contact normal's z component is 0. So this is simplified.
    # (Important): If the PenetrationDepth is negative, I don't need to store the SeparatingVelocity, so I don't need to invert it if it's negative.
    scoreboard players operation #Physics.PointVelocity.x Physics *= #Physics.CrossProductAxis.zz.x Physics
    scoreboard players operation #Physics.PointVelocity.y Physics *= #Physics.CrossProductAxis.zz.y Physics

    scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.PointVelocity.y Physics
    execute store result storage physics:temp data.NewContact.SeparatingVelocity short 1 run scoreboard players operation #Physics.PointVelocity.x Physics /= #Physics.Constants.1000 Physics

# Store the contact
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append from storage physics:temp data.NewContact

# Update the MaxPenetrationDepth (& keep track of the contact with the MaxPenetrationDepth)
# (Important): The contact with the MaxPenetrationDepth has "HasMaxPenetrationDepth:0b" instead of 1b so the "store result storage ..." command works even if the command afterwards (to remove the previously tagged contact's tag) fails.
execute if score #Physics.PenetrationDepth Physics > #Physics.ThisObject Physics.Object.MaxPenetrationDepth store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].HasMaxPenetrationDepth byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[{HasMaxPenetrationDepth:0b}].HasMaxPenetrationDepth
execute if score #Physics.PenetrationDepth Physics > #Physics.ThisObject Physics.Object.MaxPenetrationDepth run scoreboard players operation #Physics.ThisObject Physics.Object.MaxPenetrationDepth = #Physics.PenetrationDepth Physics

# Process the separating velocity (Keep track of the most negative separating velocity for the current ObjectA & tag the contact with the lowest value)
# (Important): The contact with the MinSeparatingVelocity has "HasMinSeparatingVelocity:0b" for the same reason as "HasMaxPenetrationDepth".
execute if score #Physics.PointVelocity.x Physics >= #Physics.ThisObject Physics.Object.MinSeparatingVelocity run return 0
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].HasMinSeparatingVelocity byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[{HasMinSeparatingVelocity:0b}].HasMinSeparatingVelocity
scoreboard players operation #Physics.ThisObject Physics.Object.MinSeparatingVelocity = #Physics.PointVelocity.x Physics
