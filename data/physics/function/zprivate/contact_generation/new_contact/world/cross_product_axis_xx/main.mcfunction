# Get the object's feature (Edge that's closest to the world-geometry block)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
execute if score #Physics.Projection.Block.CrossProductAxis.xx.Min Physics >= #Physics.Projection.Object.CrossProductAxis.xx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.xx.Max Physics
execute if score #Physics.Projection.Block.CrossProductAxis.xx.Min Physics < #Physics.Projection.Object.CrossProductAxis.xx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.xx.Min Physics

    # Set the feature
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_a {Edge:20b,StartCorner:0b}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_a {Edge:21b,StartCorner:1b}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_a {Edge:22b,StartCorner:4b}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_a {Edge:23b,StartCorner:5b}

# Get the world-geometry block's feature (Edge that's closest to the object)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
execute if score #Physics.Projection.Block.CrossProductAxis.xx.Min Physics >= #Physics.Projection.Object.CrossProductAxis.xx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.BlockBase.CrossProductAxis.xx.Min Physics
execute if score #Physics.Projection.Block.CrossProductAxis.xx.Min Physics < #Physics.Projection.Object.CrossProductAxis.xx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.BlockBase.CrossProductAxis.xx.Max Physics

    # Set the feature
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase0.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_b {Edge:20b,StartCorner:0b,x:"Min",y:"Min",z:"Min"}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase1.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_b {Edge:21b,StartCorner:1b,x:"Min",y:"Min",z:"Max"}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase4.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_b {Edge:22b,StartCorner:4b,x:"Min",y:"Max",z:"Min"}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase5.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_b {Edge:23b,StartCorner:5b,x:"Min",y:"Max",z:"Max"}

# Calculate Penetration Depth, Contact Normal, Contact Point & Separating Velocity
    # Contact Point
    # (Important): For edge-edge collisions, the contact point is the closest point on one edge to the other.
    # (Important): Calculation: Work with the edges as line definitions (starting point + variable * directional vector). Define the "squared distance" function and find its minimum (it's the only critical point, so setting the 1st derivative of the function to 0 is enough). I only calculate s for one edge, as I'm pretty sure it's guaranteed to correspond to a point that's within the edge's bounds. So I don't need a fallback for "If s is out of bounds, do the same for the other edge".
    # (Important): Edge1 = <Corner on the negative end> + s * <Corner on the positive end> => (u + s * v)    //    Edge2 = <Corner on the negative end> + t * <Corner on the positive end> => (m + t * n)
    # (Important): The direction is either the object's axis (Already stored) or 1 along that axis (For world blocks). Because I use 1 instead of 1,000, I have to be aware of the scaling.
        # Calculate intermediate results (Dot products)
            # A = v * v
            # (Important): As the object's axes are normalized, this is always 1.

            # B = n * n
            # (Important): As the block is axis-aligned, this is defined as 1.

            # C = v * n
            # (Important): Because the block is axis-aligned, its edge's directional vector only has one component that is also 1. So C is the same as that component from ObjectA's axis, which is the x component in this case.

            # D = v * (u - m)
            # (Important): Value1-3 are the three components of (u - m), as calculated in the "get_edge_?" functions.
            # (Important): Because I only need to keep the x component of (u - m) for the calculation of E, I can overwrite the other 2 components to save 2 scoreboard operations.
            # (Important): I need the numerator for s and t to be scaled 1,000x higher than the denominator. So keeping D scaled by 1,000x too much saves a few operations.
            scoreboard players operation #Physics.Maths.D Physics = @s Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.D Physics *= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value2 Physics

            scoreboard players operation #Physics.Maths.Value3 Physics *= @s Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value3 Physics

            # E = n * (u - m)
            # (Important): Because the block is axis-aligned, its edge's directional vector only has one component that is also 1. So E is that component from (u - m), which is Value1 in this case.

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
    # (Important): For edge-edge collisions, the penetration depth is the distance between the two edges. It's calculated by taking the distance from the contact point to the other edge.
    # (Important): I calculate t and the closest point on ObjectB's edge to ObjectA's edge, then compute the distance between both points.
        # Calculate t (On ObjectB's edge)
        # (Important): Some values are set in the "get_edge_b" function.
            # AE - CD
            # (Important): AE condenses down to Value1, which isn't scaled high enough. I directly change its value, as I don't need it anymore after this.
            # (Important): I calculate t directly inside the #Physics.Maths.Value1 score, as I don't want to waste an operation copying it over. I also adjust the scaling of D and overwrite it for the CD calculation, as I don't need it anymore after this.
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.D Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.D Physics *= @s Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.D Physics

            # t = (AE - CD) / (AB - CC)
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Maths.Value2 Physics

        # Calculate the distance (Point calculation with t is interweaved for performance reasons)
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
            execute store result storage physics:temp data.NewContact.PenetrationDepth short 1 run scoreboard players get #Physics.Maths.SquareRoot.Output Physics

    # Contact Normal
    # (Important): For edge-edge collisions, the contact normal is the cross product.
    # (Important): Because the block's x axis only has its x component set, the cross product has an x component of 0 (Not stored in the score).
    # (Important): In case ObjectA's projection is larger, it inverts the contact normal in "get_edge_b".
    # (Important): The contact normal scores are set for accumulation later.
    execute store result score #Physics.ContactNormal.x Physics run data modify storage physics:temp data.NewContact.ContactNormal[0] set value 0
    execute if score #Physics.ObjectA.EdgeProjection Physics < #Physics.ObjectB.EdgeProjection Physics store result storage physics:temp data.NewContact.ContactNormal[1] int 1 store result score #Physics.ContactNormal.y Physics run scoreboard players get #Physics.CrossProductAxis.xx.y Physics
    execute if score #Physics.ObjectA.EdgeProjection Physics < #Physics.ObjectB.EdgeProjection Physics store result storage physics:temp data.NewContact.ContactNormal[2] int 1 store result score #Physics.ContactNormal.z Physics run scoreboard players get #Physics.CrossProductAxis.xx.z Physics

    # Separating Velocity
    # (Important): The separating velocity is the dot product between the contact point's relative velocity and the contact normal. The relative velocity is the cross product between the angular velocity and the contact point (relative to the object's center) that's added together with the object's linear velocity.
        # Calculate relative contact point
        execute store result score #Physics.PointVelocity.z Physics run scoreboard players operation #Physics.ContactPoint.x Physics -= @s Physics.Object.Pos.x
        execute store result score #Physics.PointVelocity.x Physics run scoreboard players operation #Physics.ContactPoint.y Physics -= @s Physics.Object.Pos.y
        execute store result score #Physics.PointVelocity.y Physics run scoreboard players operation #Physics.ContactPoint.z Physics -= @s Physics.Object.Pos.z

        # Calculate cross product between angular velocity and relative contact point
        # (Important): I overwrite the contact point scores here, as I don't need them anymore after this.
        # (Important): Because the block's x axis component is 1, the contact normal's x component is 0. Because I only need the point velocity for the dot product later on, I could ignore calculating the x component. However, it's still necessary during contact resolution (friction calculation for the impulse), so I calculate them all.
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
        execute store result storage physics:temp data.NewContact.ContactVelocity[0] int 1 run scoreboard players operation #Physics.PointVelocity.x Physics += @s Physics.Object.Velocity.x
        execute store result storage physics:temp data.NewContact.ContactVelocity[1] int 1 run scoreboard players operation #Physics.PointVelocity.y Physics += @s Physics.Object.Velocity.y
        execute store result storage physics:temp data.NewContact.ContactVelocity[2] int 1 run scoreboard players operation #Physics.PointVelocity.z Physics += @s Physics.Object.Velocity.z

        # Calculate the relative velocity's dot product with the contact normal to get the separation velocity (single number, not a vector) and store it
        # (Important): Because the block's x axis component is 1, the contact normal's x component is 0. So this is simplified.
        scoreboard players operation #Physics.PointVelocity.y Physics *= #Physics.CrossProductAxis.xx.y Physics
        scoreboard players operation #Physics.PointVelocity.z Physics *= #Physics.CrossProductAxis.xx.z Physics

        scoreboard players operation #Physics.PointVelocity.y Physics += #Physics.PointVelocity.z Physics
        execute if score #Physics.ObjectA.EdgeProjection Physics >= #Physics.ObjectB.EdgeProjection Physics run scoreboard players operation #Physics.PointVelocity.y Physics *= #Physics.Constants.-1 Physics
        execute store result storage physics:temp data.NewContact.SeparatingVelocity short 1 run scoreboard players operation #Physics.PointVelocity.y Physics /= #Physics.Constants.1000 Physics

# Store the contact
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append from storage physics:temp data.NewContact

# Update the MaxPenetrationDepth (& keep track of the contact with the MaxPenetrationDepth)
# (Important): The contact with the MaxPenetrationDepth has "HasMaxPenetrationDepth:0b" instead of 1b so the "store result storage ..." command works even if the command afterwards (to remove the previously tagged contact's tag) fails.
execute if score #Physics.Maths.SquareRoot.Output Physics > @s Physics.Object.MaxPenetrationDepth store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].HasMaxPenetrationDepth byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[{HasMaxPenetrationDepth:0b}].HasMaxPenetrationDepth
execute if score #Physics.Maths.SquareRoot.Output Physics > @s Physics.Object.MaxPenetrationDepth run scoreboard players operation @s Physics.Object.MaxPenetrationDepth = #Physics.Maths.SquareRoot.Output Physics

# Process the separating velocity (Keep track of the most negative separating velocity for the current ObjectA & tag the contact with the lowest value)
# (Important): The contact with the MinSeparatingVelocity has "HasMinSeparatingVelocity:0b" for the same reason as "HasMaxPenetrationDepth".
execute if score #Physics.PointVelocity.y Physics >= @s Physics.Object.MinSeparatingVelocity run return 0
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].HasMinSeparatingVelocity byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[{HasMinSeparatingVelocity:0b}].HasMinSeparatingVelocity
scoreboard players operation @s Physics.Object.MinSeparatingVelocity = #Physics.PointVelocity.y Physics
