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
    # Contact Point
        # Calculate intermediate results (Dot products)
            # D = v * (u - m)
            scoreboard players operation #Physics.Maths.D Physics = @s Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.D Physics *= #Physics.Maths.Value3 Physics

            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.x
            scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Axis.y.y
            scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value2 Physics

        # Calculate s (On ObjectA's edge)
            # CE - BD
            execute store result score #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Maths.s Physics = @s Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.s Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.s Physics -= #Physics.Maths.D Physics

            # AB - CC
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.Value1 Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.-1000 Physics
            scoreboard players add #Physics.Maths.Value1 Physics 1000

            # s = (CE - BD) / (AB - CC)
            scoreboard players operation #Physics.Maths.s Physics /= #Physics.Maths.Value1 Physics

        # Calculate the contact point with s
        scoreboard players operation #Physics.ContactPoint.x Physics = @s Physics.Object.Axis.y.x
        scoreboard players operation #Physics.ContactPoint.x Physics *= #Physics.Maths.s Physics
        scoreboard players operation #Physics.ContactPoint.x Physics /= #Physics.Constants.1000 Physics
        execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 run scoreboard players operation #Physics.ContactPoint.x Physics += #Physics.ObjectA.EdgeStart.x Physics

        scoreboard players operation #Physics.ContactPoint.y Physics = @s Physics.Object.Axis.y.y
        scoreboard players operation #Physics.ContactPoint.y Physics *= #Physics.Maths.s Physics
        scoreboard players operation #Physics.ContactPoint.y Physics /= #Physics.Constants.1000 Physics
        execute store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.ObjectA.EdgeStart.y Physics

        scoreboard players operation #Physics.ContactPoint.z Physics = @s Physics.Object.Axis.y.z
        scoreboard players operation #Physics.ContactPoint.z Physics *= #Physics.Maths.s Physics
        scoreboard players operation #Physics.ContactPoint.z Physics /= #Physics.Constants.1000 Physics
        execute store result storage physics:temp data.NewContact.ContactPoint[2] int 1 run scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.ObjectA.EdgeStart.z Physics

    # Penetration Depth
        # Calculate t (On ObjectB's edge)
            # AE - CD
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.D Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.D Physics *= @s Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.Value3 Physics -= #Physics.Maths.D Physics

            # t = (AE - CD) / (AB - CC)
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Maths.Value1 Physics

        # Calculate the distance (Point calculation with t is interweaved for performance reasons)
            # x2 - x1
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics -= #Physics.ContactPoint.x Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics

            # y2 - y1
            scoreboard players operation #Physics.Maths.Value4 Physics -= #Physics.ContactPoint.y Physics
            scoreboard players operation #Physics.Maths.Value4 Physics *= #Physics.Maths.Value4 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value4 Physics

            # z2 - z1
            scoreboard players operation #Physics.Maths.Value5 Physics += #Physics.Maths.Value3 Physics
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
    execute if score #Physics.Maths.SquareRoot.Output Physics < #Physics.Settings.MinPenetrationDepth Physics run return 0

# Append the contact
$data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(Edge)b}
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run scoreboard players get #Physics.Contact.FeatureA Physics
