# Get ObjectA's feature (Edge that's closest to ObjectB)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.xz.Max Physics

    # Set the feature
    # (Important): Because only the min and max projections are scaled down, I need to scale the corner projections down here and turn the DeepestProjection relative again. In addition, to account for rounding errors that are different for positive and negative values (It matters whether I first multiply by -1 and then divide, or the other way around), I turn the min back to the max and just invert which corner matches which corner projection if it tries to get the min projection's corner.
    scoreboard players operation #Physics.DeepestProjection Physics -= #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics
    execute if score #Physics.Projection.OtherObject.CrossProductAxis.xz.Min Physics >= #Physics.Projection.Object.CrossProductAxis.xz.Min Physics run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xz/check_edge_a_max
    execute if score #Physics.Projection.OtherObject.CrossProductAxis.xz.Min Physics < #Physics.Projection.Object.CrossProductAxis.xz.Min Physics run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xz/check_edge_a_min

# Get ObjectB's feature (Edge that's closest to ObjectA)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.OtherObject.CrossProductAxis.xz.Max Physics

    # Set the feature
    # (Important): Because only the min and max projections are scaled down, I need to scale the corner projections down here and turn the DeepestProjection relative again. In addition, to account for rounding errors that are different for positive and negative values (It matters whether I first multiply by -1 and then divide, or the other way around), I turn the min back to the max and just invert which corner matches which corner projection if it tries to get the min projection's corner.
    scoreboard players operation #Physics.DeepestProjection Physics -= #Physics.Projection.OtherObjectCenter.CrossProductAxis.xz Physics
    execute if score #Physics.Projection.OtherObject.CrossProductAxis.xz.Min Physics >= #Physics.Projection.Object.CrossProductAxis.xz.Min Physics run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xz/check_edge_b_min
    execute if score #Physics.Projection.OtherObject.CrossProductAxis.xz.Min Physics < #Physics.Projection.Object.CrossProductAxis.xz.Min Physics run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xz/check_edge_b_max

# Contact Normal
# (Important): For edge-edge collisions, the contact normal is the cross product.
# (Important): Because the block's x axis only has its x component set, the cross product has an x component of 0 (Not stored in the score).
# (Important): In case ObjectA's projection is larger, it inverts the contact normal in "get_edge_b".
execute if score #Physics.ObjectA.EdgeProjection Physics < #Physics.ObjectB.EdgeProjection Physics store result storage physics:temp data.NewContact.ContactNormal[0] int 1 store result score #Physics.ContactNormal.x Physics run scoreboard players get #Physics.CrossProductAxis.xz.x Physics
execute if score #Physics.ObjectA.EdgeProjection Physics < #Physics.ObjectB.EdgeProjection Physics store result storage physics:temp data.NewContact.ContactNormal[1] int 1 store result score #Physics.ContactNormal.y Physics run scoreboard players get #Physics.CrossProductAxis.xz.y Physics
execute if score #Physics.ObjectA.EdgeProjection Physics < #Physics.ObjectB.EdgeProjection Physics store result storage physics:temp data.NewContact.ContactNormal[2] int 1 store result score #Physics.ContactNormal.z Physics run scoreboard players get #Physics.CrossProductAxis.xz.z Physics

# Calculate Penetration Depth, Contact Point & Separating Velocity
    # Contact Point
    # (Important): For edge-edge collisions, the contact point is the closest point on one edge to the other.
    # (Important): Calculation: Work with the edges as line definitions (starting point + variable * directional vector). Define the "squared distance" function and find its minimum (it's the only critical point, so setting the 1st derivative of the function to 0 is enough). I only calculate s for one edge, as I'm pretty sure it's guaranteed to correspond to a point that's within the edge's bounds. So I don't need a fallback for "If s is out of bounds, do the same for the other edge".
    # (Important): Edge1 = <Corner on the negative end> + s * <Corner on the positive end> => (u + s * v)    //    Edge2 = <Corner on the negative end> + t * <Corner on the positive end> => (m + t * n)
        # Calculate intermediate results (Dot products)
            # A = v * v
            # (Important): As ObjectA's axes are normalized, this is always 1.

            # B = n * n
            # (Important): As ObjectB's axes are normalized, this is always 1.

            # C = v * n
            execute store result score #Physics.Maths.D Physics run scoreboard players operation #Physics.Maths.C Physics = #Physics.ThisObject Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.C Physics *= @s Physics.Object.Axis.z.x

            execute store result score #Physics.Maths.Value7 Physics run scoreboard players operation #Physics.Maths.Value6 Physics = #Physics.ThisObject Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.Value6 Physics *= @s Physics.Object.Axis.z.y
            scoreboard players operation #Physics.Maths.C Physics += #Physics.Maths.Value6 Physics

            execute store result score #Physics.Maths.Value8 Physics run scoreboard players operation #Physics.Maths.Value6 Physics = #Physics.ThisObject Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value6 Physics *= @s Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.C Physics += #Physics.Maths.Value6 Physics
            execute store result score #Physics.Maths.s Physics store result score #Physics.Maths.Value9 Physics run scoreboard players operation #Physics.Maths.C Physics /= #Physics.Constants.1000 Physics

            # D = v * (u - m)
            # (Important): Value1-3 are the three components of (u - m), as calculated in the "get_edge_?" functions.
            # (Important): I need the numerator for s and t to be scaled 1,000x higher than the denominator. So keeping D scaled by 1,000x too much saves a few operations.
            scoreboard players operation #Physics.Maths.D Physics *= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.Maths.Value7 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value7 Physics

            scoreboard players operation #Physics.Maths.Value8 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value8 Physics

            # E = n * (u - m)
            # (Important): Because I don't need them afterwards, I overwrite Value1-3 to save 3 scoreboard operations. The resulting E is stored as Value1.
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.x

            scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Axis.z.y
            scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics

            scoreboard players operation #Physics.Maths.Value3 Physics *= @s Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics

        # Calculate s (On ObjectA's edge)
            # CE - BD
            scoreboard players operation #Physics.Maths.s Physics *= #Physics.Maths.Value1 Physics
            scoreboard players operation #Physics.Maths.s Physics -= #Physics.Maths.D Physics

            # AB - CC
            scoreboard players operation #Physics.Maths.Value9 Physics *= #Physics.Maths.Value9 Physics
            scoreboard players operation #Physics.Maths.Value9 Physics /= #Physics.Constants.-1000 Physics
            scoreboard players add #Physics.Maths.Value9 Physics 1000

            # s = (CE - BD) / (AB - CC)
            scoreboard players operation #Physics.Maths.s Physics /= #Physics.Maths.Value9 Physics

        # Calculate the contact point with s
        scoreboard players operation #Physics.ContactPoint.x Physics = #Physics.ThisObject Physics.Object.Axis.x.x
        scoreboard players operation #Physics.ContactPoint.x Physics *= #Physics.Maths.s Physics
        scoreboard players operation #Physics.ContactPoint.x Physics /= #Physics.Constants.1000 Physics
        execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 store result score #Physics.ContactPointCopy.x Physics run scoreboard players operation #Physics.ContactPoint.x Physics += #Physics.ObjectA.EdgeStart.x Physics

        scoreboard players operation #Physics.ContactPoint.y Physics = #Physics.ThisObject Physics.Object.Axis.x.y
        scoreboard players operation #Physics.ContactPoint.y Physics *= #Physics.Maths.s Physics
        scoreboard players operation #Physics.ContactPoint.y Physics /= #Physics.Constants.1000 Physics
        execute store result storage physics:temp data.NewContact.ContactPoint[1] int 1 store result score #Physics.ContactPointCopy.y Physics run scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.ObjectA.EdgeStart.y Physics

        scoreboard players operation #Physics.ContactPoint.z Physics = #Physics.ThisObject Physics.Object.Axis.x.z
        scoreboard players operation #Physics.ContactPoint.z Physics *= #Physics.Maths.s Physics
        scoreboard players operation #Physics.ContactPoint.z Physics /= #Physics.Constants.1000 Physics
        execute store result storage physics:temp data.NewContact.ContactPoint[2] int 1 store result score #Physics.ContactPointCopy.z Physics run scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.ObjectA.EdgeStart.z Physics

    # Penetration Depth
    # (Important): For edge-edge collisions, the penetration depth is the distance between the two edges. It's calculated by taking the distance from the contact point to the other edge.
    # (Important): I calculate t and the closest point on ObjectB's edge to ObjectA's edge, then compute the distance between both points.
        # Calculate t (On ObjectB's edge)
        # (Important): Some values are set in the "get_edge_b" function.
        # (Important): Because I don't need them later, I overwrite some values. t is scored in the #Physics.Maths.Value1 score.
            # AE - CD
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.D Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.C Physics *= #Physics.Maths.D Physics
            scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.C Physics

            # t = (AE - CD) / (AB - CC)
            execute store result score #Physics.Offset.y Physics store result score #Physics.Offset.z Physics run scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Maths.Value9 Physics

        # Calculate the distance (Point calculation with t is interweaved for performance reasons)
            # Calculate the offset for the 2nd contact point (On ObjectB's axis)
            # (Important): To save an operation, I overwrite Value1 instead of creating Offset.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.x
            scoreboard players operation #Physics.Offset.y Physics *= @s Physics.Object.Axis.z.y
            scoreboard players operation #Physics.Offset.z Physics *= @s Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Offset.y Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Offset.z Physics /= #Physics.Constants.1000 Physics

            # x2 - x1
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value1 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics -= #Physics.ContactPoint.x Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics

            # y2 - y1
            scoreboard players operation #Physics.Maths.Value4 Physics += #Physics.Offset.y Physics
            scoreboard players operation #Physics.Maths.Value4 Physics -= #Physics.ContactPoint.y Physics
            scoreboard players operation #Physics.Maths.Value4 Physics *= #Physics.Maths.Value4 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value4 Physics

            # z2 - z1
            scoreboard players operation #Physics.Maths.Value5 Physics += #Physics.Offset.z Physics
            scoreboard players operation #Physics.Maths.Value5 Physics -= #Physics.ContactPoint.z Physics
            scoreboard players operation #Physics.Maths.Value5 Physics *= #Physics.Maths.Value5 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value5 Physics

            # Square Root (= Distance, = Penetration Depth)
            function physics:zprivate/maths/get_square_root
            execute store result storage physics:temp data.NewContact.PenetrationDepth short 1 run scoreboard players get #Physics.Maths.SquareRoot.Output Physics

        # Update the MaxPenetrationDepth
        execute if score #Physics.Maths.SquareRoot.Output Physics > #Physics.MaxPenetrationDepthTotal Physics store result storage physics:zprivate data.ContactGroups[-1].MaxPenetrationDepth short 1 store result score #Physics.MaxPenetrationDepth Physics run scoreboard players operation #Physics.MaxPenetrationDepthTotal Physics = #Physics.Maths.SquareRoot.Output Physics
        execute if score #Physics.Maths.SquareRoot.Output Physics > #Physics.MaxPenetrationDepth Physics store result storage physics:zprivate data.ContactGroups[-1].MaxPenetrationDepth short 1 run scoreboard players operation #Physics.MaxPenetrationDepth Physics = #Physics.Maths.SquareRoot.Output Physics

    # Separating Velocity
    # (Important): The separating velocity for one object is the dot product between the contact point (relative to that object)'s relative velocity and the contact normal. The relative velocity is the cross product between the object's angular velocity and the contact point (relative to the object's center) that's added together with the object's linear velocity.
    # (Important): To get the actual separating velocity, I subtract ObjectA's separating velocity from ObjectB's (because they face different directions, they're sign-flipped), as both objects may be moving or rotating.
        # Separating Velocity for ObjectB
            # Calculate relative contact point
            execute store result score #Physics.PointVelocity.z Physics run scoreboard players operation #Physics.ContactPoint.x Physics -= @s Physics.Object.Pos.x
            execute store result score #Physics.PointVelocity.x Physics run scoreboard players operation #Physics.ContactPoint.y Physics -= @s Physics.Object.Pos.y
            execute store result score #Physics.PointVelocity.y Physics run scoreboard players operation #Physics.ContactPoint.z Physics -= @s Physics.Object.Pos.z

            # Calculate cross product between relative contact point and angular velocity
            # (Important): I overwrite the contact point scores here, as I don't need those values (relative to this object) anymore.
            scoreboard players operation #Physics.PointVelocity.x Physics *= @s Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.ContactPoint.z Physics *= @s Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.PointVelocity.x Physics -= #Physics.ContactPoint.z Physics
            scoreboard players operation #Physics.PointVelocity.x Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.PointVelocity.y Physics *= @s Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.ContactPoint.x Physics *= @s Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.PointVelocity.y Physics -= #Physics.ContactPoint.x Physics
            scoreboard players operation #Physics.PointVelocity.y Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.PointVelocity.z Physics *= @s Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.ContactPoint.y Physics *= @s Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.PointVelocity.z Physics -= #Physics.ContactPoint.y Physics
            scoreboard players operation #Physics.PointVelocity.z Physics /= #Physics.Constants.1000 Physics

            # Add the linear velocity to obtain the relative velocity of the contact point
            scoreboard players operation #Physics.PointVelocity.x Physics += @s Physics.Object.Velocity.x
            scoreboard players operation #Physics.PointVelocity.y Physics += @s Physics.Object.Velocity.y
            scoreboard players operation #Physics.PointVelocity.z Physics += @s Physics.Object.Velocity.z

            # Calculate the relative velocity's dot product with the contact normal to get the separation velocity (single number, not a vector) and store it
            # (Important): Because the contact normal scores (Physics.Object.Axis.?.?) are not adjusted to face away from the face, I may multiply the final result with -1.
            scoreboard players operation #Physics.PointVelocity.x Physics *= #Physics.ContactNormal.x Physics
            scoreboard players operation #Physics.PointVelocity.y Physics *= #Physics.ContactNormal.y Physics
            scoreboard players operation #Physics.PointVelocity.z Physics *= #Physics.ContactNormal.z Physics

            scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.PointVelocity.y Physics
            scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.PointVelocity.z Physics

        # Separating Velocity for ObjectA
            # Calculate relative contact point
            execute store result score #Physics.SeparatingVelocity.z Physics run scoreboard players operation #Physics.ContactPointCopy.x Physics -= #Physics.ThisObject Physics.Object.Pos.x
            execute store result score #Physics.SeparatingVelocity.x Physics run scoreboard players operation #Physics.ContactPointCopy.y Physics -= #Physics.ThisObject Physics.Object.Pos.y
            execute store result score #Physics.SeparatingVelocity.y Physics run scoreboard players operation #Physics.ContactPointCopy.z Physics -= #Physics.ThisObject Physics.Object.Pos.z

            # Calculate cross product between relative contact point and angular velocity
            # (Important): I overwrite the contact point scores here, as I don't need those values (relative to this object) anymore.
            scoreboard players operation #Physics.SeparatingVelocity.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.ContactPointCopy.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.SeparatingVelocity.x Physics -= #Physics.ContactPointCopy.z Physics
            scoreboard players operation #Physics.SeparatingVelocity.x Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.SeparatingVelocity.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.ContactPointCopy.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.SeparatingVelocity.y Physics -= #Physics.ContactPointCopy.x Physics
            scoreboard players operation #Physics.SeparatingVelocity.y Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.SeparatingVelocity.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.ContactPointCopy.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.SeparatingVelocity.z Physics -= #Physics.ContactPointCopy.y Physics
            scoreboard players operation #Physics.SeparatingVelocity.z Physics /= #Physics.Constants.1000 Physics

            # Add the linear velocity to obtain the relative velocity of the contact point
            scoreboard players operation #Physics.SeparatingVelocity.x Physics += #Physics.ThisObject Physics.Object.Velocity.x
            scoreboard players operation #Physics.SeparatingVelocity.y Physics += #Physics.ThisObject Physics.Object.Velocity.y
            scoreboard players operation #Physics.SeparatingVelocity.z Physics += #Physics.ThisObject Physics.Object.Velocity.z

            # Calculate the relative velocity's dot product with the contact normal to get the separation velocity (single number, not a vector) and store it
            scoreboard players operation #Physics.SeparatingVelocity.x Physics *= #Physics.ContactNormal.x Physics
            scoreboard players operation #Physics.SeparatingVelocity.y Physics *= #Physics.ContactNormal.y Physics
            scoreboard players operation #Physics.SeparatingVelocity.z Physics *= #Physics.ContactNormal.z Physics

            scoreboard players operation #Physics.SeparatingVelocity.x Physics += #Physics.SeparatingVelocity.y Physics
            scoreboard players operation #Physics.SeparatingVelocity.x Physics += #Physics.SeparatingVelocity.z Physics

        # Add the separating velocities together
        # (Important): I also adjust the scale and invert the number here instead of doing it for both individual velocities.
        # (Important): Because I directly inverted the contact normal scores in "get_edge_b" (if they needed to be inverted), I don't need to invert the resulting separating velocity anymore.
        scoreboard players operation #Physics.SeparatingVelocity.x Physics -= #Physics.PointVelocity.x Physics
        execute store result storage physics:temp data.NewContact.SeparatingVelocity short 1 run scoreboard players operation #Physics.SeparatingVelocity.x Physics /= #Physics.Constants.1000 Physics

# Store the new contact
# (Important): The values are stored in their scaled up form, just like how I need them to process them.
# (Important): The object's entry in the final storage is already created after the SAT.
data modify storage physics:zprivate data.ContactGroups[-1].Objects[-1].Contacts append from storage physics:temp data.NewContact

# Set up contact accumulation for that object
function physics:zprivate/contact_generation/new_contact/object/get_previous_contacts with storage physics:zprivate data.ContactGroups[-1].Objects[-1]

# Process the separating velocity (Keep track of the most negative separating velocity for the current ObjectA, as well as global for all ObjectA's)
# (Important): The "#Physics.MinSeparatingVelocityTotal Physics" score keeps track of the overall most negative separating velocity across all ObjectA's, so I can efficiently target the most severe contact in contact resolution's 1st iteration.
execute if score #Physics.MinSeparatingVelocity Physics <= #Physics.SeparatingVelocity.x Physics run return 0
execute if score #Physics.SeparatingVelocity.x Physics < #Physics.MinSeparatingVelocityTotal Physics store result storage physics:zprivate data.ContactGroups[-1].MinSeparatingVelocity short 1 store result score #Physics.MinSeparatingVelocity Physics run return run scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics = #Physics.SeparatingVelocity.x Physics
execute store result storage physics:zprivate data.ContactGroups[-1].MinSeparatingVelocity short 1 run scoreboard players operation #Physics.MinSeparatingVelocity Physics = #Physics.SeparatingVelocity.x Physics
