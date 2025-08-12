# Get Edge B
    # Set the start point for calculating the distance between the two points (Penetration Depth)
    $scoreboard players operation #Physics.Maths.SquareRoot.Input Physics = #Physics.Projection.Block.WorldAxis.x.$(x) Physics
    $scoreboard players operation #Physics.Maths.Value4 Physics = #Physics.Projection.Block.WorldAxis.y.$(y) Physics
    $scoreboard players operation #Physics.Maths.Value5 Physics = #Physics.Projection.Block.WorldAxis.z.$(z) Physics

    # Subtract the start point from the other edge's start point for calculating (u - m)
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.SquareRoot.Input Physics
    scoreboard players operation #Physics.Maths.Value2 Physics -= #Physics.Maths.Value4 Physics
    scoreboard players operation #Physics.Maths.Value3 Physics -= #Physics.Maths.Value5 Physics

# Calculate Contact Point & Penetration Depth
# (Important): Their storage entries are set even if the contact is invalid, to avoid additional overhead (Additional 4 scoreboard gets for valid contacts). I'm not sure which would be faster, but it barely matters.
    # Contact Point
        # Calculate intermediate results (Dot products)
            # D = v * (u - m)
            scoreboard players operation #Physics.Maths.D Physics = @s Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.D Physics *= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value2 Physics

            scoreboard players operation #Physics.Maths.Value3 Physics *= @s Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value3 Physics

        # Calculate s (On ObjectA's edge)
            # CE - BD
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.Maths.s Physics = @s Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.s Physics *= #Physics.Maths.Value1 Physics
            scoreboard players operation #Physics.Maths.s Physics -= #Physics.Maths.D Physics

            # AB - CC
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.-1000 Physics
            scoreboard players add #Physics.Maths.Value2 Physics 1000

            # s = (CE - BD) / (AB - CC)
            scoreboard players operation #Physics.Maths.s Physics /= #Physics.Maths.Value2 Physics

        # Calculate the contact point with s
        scoreboard players operation #Physics.ContactPoint.x Physics = @s Physics.Object.Axis.x.x
        scoreboard players operation #Physics.ContactPoint.x Physics *= #Physics.Maths.s Physics
        scoreboard players operation #Physics.ContactPoint.x Physics /= #Physics.Constants.1000 Physics
        execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 run scoreboard players operation #Physics.ContactPoint.x Physics += #Physics.ObjectA.EdgeStart.x Physics

        scoreboard players operation #Physics.ContactPoint.y Physics = @s Physics.Object.Axis.x.y
        scoreboard players operation #Physics.ContactPoint.y Physics *= #Physics.Maths.s Physics
        scoreboard players operation #Physics.ContactPoint.y Physics /= #Physics.Constants.1000 Physics
        execute store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.ObjectA.EdgeStart.y Physics

        scoreboard players operation #Physics.ContactPoint.z Physics = @s Physics.Object.Axis.x.z
        scoreboard players operation #Physics.ContactPoint.z Physics *= #Physics.Maths.s Physics
        scoreboard players operation #Physics.ContactPoint.z Physics /= #Physics.Constants.1000 Physics
        execute store result storage physics:temp data.NewContact.ContactPoint[2] int 1 run scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.ObjectA.EdgeStart.z Physics

    # Penetration Depth
        # Calculate t (On ObjectB's edge)
            # AE - CD
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.D Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.D Physics *= @s Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.D Physics

            # t = (AE - CD) / (AB - CC)
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Maths.Value2 Physics

        # Calculate the distance
            # x2 - x1
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value1 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics -= #Physics.ContactPoint.x Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics

            # y2 - y1
            scoreboard players operation #Physics.Maths.Value4 Physics -= #Physics.ContactPoint.y Physics
            scoreboard players operation #Physics.Maths.Value4 Physics *= #Physics.Maths.Value4 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value4 Physics

            # z2 - z1
            scoreboard players operation #Physics.Maths.Value5 Physics -= #Physics.ContactPoint.z Physics
            scoreboard players operation #Physics.Maths.Value5 Physics *= #Physics.Maths.Value5 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value5 Physics

            # Square Root (= Distance, = Penetration Depth)
            function physics:zprivate/maths/get_square_root

# Check if the contact is valid
    # Check if the Contact Point is within the hitbox
    scoreboard players set #Physics.IsInside Physics 0
    execute if score #Physics.Projection.Block.WorldAxis.x.Min Physics <= #Physics.ContactPoint.x Physics if score #Physics.ContactPoint.x Physics <= #Physics.Projection.Block.WorldAxis.x.Max Physics if score #Physics.Projection.Block.WorldAxis.y.Min Physics <= #Physics.ContactPoint.y Physics if score #Physics.ContactPoint.y Physics <= #Physics.Projection.Block.WorldAxis.y.Max Physics if score #Physics.Projection.Block.WorldAxis.z.Min Physics <= #Physics.ContactPoint.z Physics if score #Physics.ContactPoint.z Physics <= #Physics.Projection.Block.WorldAxis.z.Max Physics run scoreboard players set #Physics.IsInside Physics 1
    execute if score #Physics.IsInside Physics matches 0 run scoreboard players operation #Physics.Maths.SquareRoot.Output Physics *= #Physics.Constants.-1 Physics

    # Check if the Penetration Depth is within the threshold (Can be slightly negative)
    # (Important): A negative PenetrationDepth accounts for the "Is not inside" case too, because it's only multiplied by -1 if it's not inside the block.
    execute if score #Physics.Maths.SquareRoot.Output Physics < #Physics.Settings.MinPenetrationDepth Physics run return 0

    # Check if the contact is still relevant (Part 2)
    $execute if score #Physics.DotProduct Physics matches ..900000 run data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(Edge)b}
    execute if score #Physics.DotProduct Physics matches ..900000 store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run return run scoreboard players get #Physics.Contact.FeatureA Physics

    # Check if the PenetrationDepth is negative
    $execute if score #Physics.Maths.SquareRoot.Output Physics matches ..-1 run data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(Edge)b}
    execute if score #Physics.Maths.SquareRoot.Output Physics matches ..-1 store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run return run scoreboard players get #Physics.Contact.FeatureA Physics

execute store result storage physics:temp data.NewContact.PenetrationDepth short 1 run scoreboard players get #Physics.Maths.SquareRoot.Output Physics

# Get Edge B (Part 2: Electric boogaloo)
    # Get the edge's projection (For inverting the contact normal if necessary)
    $scoreboard players operation #Physics.ObjectB.EdgeProjection Physics = #Physics.Projection.BlockCornerBase$(StartCorner).CrossProductAxis.xx Physics
    scoreboard players operation #Physics.ObjectB.EdgeProjection Physics += #Physics.Projection.BlockCenter.CrossProductAxis.xx Physics

# Calculate Contact Normal & Separating Velocity
    # Contact Normal
    data modify storage physics:temp data.NewContact.ContactNormal[0] set value 0
    execute if score #Physics.ObjectA.EdgeProjection Physics < #Physics.ObjectB.EdgeProjection Physics store result storage physics:temp data.NewContact.ContactNormal[1] int 1 run scoreboard players get #Physics.CrossProductAxis.xx.y Physics
    execute if score #Physics.ObjectA.EdgeProjection Physics < #Physics.ObjectB.EdgeProjection Physics store result storage physics:temp data.NewContact.ContactNormal[2] int 1 run scoreboard players get #Physics.CrossProductAxis.xx.z Physics
    execute if score #Physics.ObjectA.EdgeProjection Physics > #Physics.ObjectB.EdgeProjection Physics store result storage physics:temp data.NewContact.ContactNormal[1] int -1 run scoreboard players get #Physics.CrossProductAxis.xx.y Physics
    execute if score #Physics.ObjectA.EdgeProjection Physics > #Physics.ObjectB.EdgeProjection Physics store result storage physics:temp data.NewContact.ContactNormal[2] int -1 run scoreboard players get #Physics.CrossProductAxis.xx.z Physics

    # Separating Velocity
        # Calculate relative contact point
        execute store result score #Physics.PointVelocity.z Physics run scoreboard players operation #Physics.ContactPoint.x Physics -= @s Physics.Object.Pos.x
        scoreboard players operation #Physics.ContactPoint.y Physics -= @s Physics.Object.Pos.y
        scoreboard players operation #Physics.ContactPoint.z Physics -= @s Physics.Object.Pos.z

        # Calculate cross product between angular velocity and relative contact point
        # (Important): I messed up the order (relativeContactPoint x angularVelocity instead of angularVelocity x relativeContactPoint). To accomodate for that without spending hours rewriting it, I divide by -1000 instead of 1000.
        scoreboard players operation #Physics.ContactPoint.z Physics *= @s Physics.Object.AngularVelocity.x
        scoreboard players operation #Physics.ContactPoint.x Physics *= @s Physics.Object.AngularVelocity.z
        scoreboard players operation #Physics.ContactPoint.z Physics -= #Physics.ContactPoint.x Physics
        scoreboard players operation #Physics.ContactPoint.z Physics /= #Physics.Constants.-1000 Physics

        scoreboard players operation #Physics.PointVelocity.z Physics *= @s Physics.Object.AngularVelocity.y
        scoreboard players operation #Physics.ContactPoint.y Physics *= @s Physics.Object.AngularVelocity.x
        scoreboard players operation #Physics.PointVelocity.z Physics -= #Physics.ContactPoint.y Physics
        scoreboard players operation #Physics.PointVelocity.z Physics /= #Physics.Constants.-1000 Physics

        # Add the linear velocity to obtain the relative velocity of the contact point
        scoreboard players operation #Physics.ContactPoint.z Physics += @s Physics.Object.Velocity.y
        scoreboard players operation #Physics.PointVelocity.z Physics += @s Physics.Object.Velocity.z

        # Calculate the relative velocity's dot product with the contact normal to get the separation velocity (single number, not a vector) and store it
        scoreboard players operation #Physics.ContactPoint.z Physics *= #Physics.CrossProductAxis.xx.y Physics
        scoreboard players operation #Physics.PointVelocity.z Physics *= #Physics.CrossProductAxis.xx.z Physics

        scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.PointVelocity.z Physics
        execute if score #Physics.ObjectA.EdgeProjection Physics >= #Physics.ObjectB.EdgeProjection Physics run scoreboard players operation #Physics.ContactPoint.z Physics *= #Physics.Constants.-1 Physics
        execute store result storage physics:temp data.NewContact.SeparatingVelocity short 1 run scoreboard players operation #Physics.ContactPoint.z Physics /= #Physics.Constants.1000 Physics

# Store the contact
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append from storage physics:temp data.NewContact

# Update the MaxPenetrationDepth (& keep track of the contact with the MaxPenetrationDepth)
# (Important): The contact with the MaxPenetrationDepth has "HasMaxPenetrationDepth:0b" instead of 1b so the "store result storage ..." command works even if the command afterwards (to remove the previously tagged contact's tag) fails.
execute if score #Physics.Maths.SquareRoot.Output Physics > @s Physics.Object.MaxPenetrationDepth store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].HasMaxPenetrationDepth byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[{HasMaxPenetrationDepth:0b}].HasMaxPenetrationDepth
execute if score #Physics.Maths.SquareRoot.Output Physics > @s Physics.Object.MaxPenetrationDepth run scoreboard players operation @s Physics.Object.MaxPenetrationDepth = #Physics.Maths.SquareRoot.Output Physics

# Process the separating velocity (Keep track of the most negative separating velocity for the current ObjectA & tag the contact with the lowest value)
# (Important): The contact with the MinSeparatingVelocity has "HasMinSeparatingVelocity:0b" for the same reason as "HasMaxPenetrationDepth".
execute if score #Physics.ContactPoint.z Physics >= @s Physics.Object.MinSeparatingVelocity run return 0
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].HasMinSeparatingVelocity byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[{HasMinSeparatingVelocity:0b}].HasMinSeparatingVelocity
scoreboard players operation @s Physics.Object.MinSeparatingVelocity = #Physics.ContactPoint.z Physics
