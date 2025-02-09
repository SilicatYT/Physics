# Get the object's feature (Edge that's closest to the world-geometry block)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
execute if score #Physics.Projection.Block.CrossProductAxis.xx.Min Physics >= #Physics.Projection.Object.CrossProductAxis.xx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.xx.Max Physics
execute if score #Physics.Projection.Block.CrossProductAxis.xx.Min Physics < #Physics.Projection.Object.CrossProductAxis.xx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.xx.Min Physics

    # Set the feature
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_a {Edge:200,StartCorner:0,EndCorner:2}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_a {Edge:201,StartCorner:1,EndCorner:3}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_a {Edge:202,StartCorner:4,EndCorner:6}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_a {Edge:203,StartCorner:5,EndCorner:7}

# Get the world-geometry block's feature (Edge that's closest to the object)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
execute if score #Physics.Projection.Block.CrossProductAxis.xx.Min Physics >= #Physics.Projection.Object.CrossProductAxis.xx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.BlockBase.CrossProductAxis.xx.Min Physics
execute if score #Physics.Projection.Block.CrossProductAxis.xx.Min Physics < #Physics.Projection.Object.CrossProductAxis.xx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.BlockBase.CrossProductAxis.xx.Max Physics

    # Set the feature
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase0.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_b {Edge:200,x:"Min",y:"Min",z:"Min"}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase1.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_b {Edge:201,x:"Min",y:"Min",z:"Max"}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase4.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_b {Edge:202,x:"Min",y:"Max",z:"Min"}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase5.CrossProductAxis.xx Physics run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/get_edge_b {Edge:203,x:"Min",y:"Max",z:"Max"}

# Calculate Penetration Depth, Contact Normal, Contact Point & Separating Velocity
    # Contact Normal
    # (Important): For edge-edge collisions, the contact normal is the vector product of both edges. So it's the axis of minimum overlap.

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
        scoreboard players operation #Physics.ContactPoint.x Physics += #Physics.ObjectA.EdgeStart.x Physics

        scoreboard players operation #Physics.ContactPoint.y Physics = @s Physics.Object.Axis.x.y
        scoreboard players operation #Physics.ContactPoint.y Physics *= #Physics.Maths.s Physics
        scoreboard players operation #Physics.ContactPoint.y Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.ObjectA.EdgeStart.y Physics

        scoreboard players operation #Physics.ContactPoint.z Physics = @s Physics.Object.Axis.x.z
        scoreboard players operation #Physics.ContactPoint.z Physics *= #Physics.Maths.s Physics
        scoreboard players operation #Physics.ContactPoint.z Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.ObjectA.EdgeStart.z Physics

    # Penetration Depth
    # (Important): For edge-edge collisions, the penetration depth is the distance between the two edges. It's calculated by taking the distance from the contact point to the other edge.
