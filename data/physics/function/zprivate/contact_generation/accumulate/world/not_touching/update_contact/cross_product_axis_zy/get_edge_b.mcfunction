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
    $scoreboard players operation #Physics.ObjectB.EdgeProjection Physics = #Physics.Projection.BlockCornerBase$(StartCorner).CrossProductAxis.zy Physics
    execute store result score #Physics.PenetrationDepth Physics run scoreboard players operation #Physics.ObjectB.EdgeProjection Physics += #Physics.Projection.BlockCenter.CrossProductAxis.zy Physics

# Calculate Penetration Depth
scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.ObjectA.EdgeProjection Physics
execute if score #Physics.ObjectA.EdgeProjection Physics > #Physics.ObjectB.EdgeProjection Physics run scoreboard players operation #Physics.PenetrationDepth Physics *= #Physics.Constants.-1 Physics

# Check if the Penetration Depth is within the threshold (Can be slightly negative)
execute if score #Physics.PenetrationDepth Physics < #Physics.Settings.MinPenetrationDepth Physics run return 0

# Append the contact
$data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(Edge)b,ContactNormal:[I;0,0,0]}
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run scoreboard players get #Physics.Contact.FeatureA Physics

execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].PenetrationDepth short 1 run scoreboard players get #Physics.PenetrationDepth Physics

# Contact Point
    # Calculate intermediate results (Dot products)
        # D = v * (u - m)
        scoreboard players operation #Physics.Maths.D Physics = @s Physics.Object.Axis.y.x
        scoreboard players operation #Physics.Maths.D Physics *= #Physics.Maths.Value1 Physics

        scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Axis.y.y
        scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value2 Physics

        scoreboard players operation #Physics.Maths.Value3 Physics *= @s Physics.Object.Axis.y.z
        scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value3 Physics

    # Calculate s (On ObjectA's edge)
        # CE - BD
        execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.Maths.s Physics = @s Physics.Object.Axis.y.x
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
        scoreboard players operation #Physics.Maths.D Physics *= @s Physics.Object.Axis.y.x
        scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.D Physics

        # t = (AE - CD) / (AB - CC)
        scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Maths.Value2 Physics

    # Calculate the contact point (Middle between points on edges A and B)
        # Point on EdgeA
        scoreboard players operation #Physics.Maths.s Physics *= @s Physics.Object.Axis.y.x
        scoreboard players operation #Physics.Maths.s Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.Maths.s Physics += #Physics.ObjectA.EdgeStart.x Physics

        scoreboard players operation #Physics.ContactPoint.y Physics *= @s Physics.Object.Axis.y.y
        scoreboard players operation #Physics.ContactPoint.y Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.ObjectA.EdgeStart.y Physics

        scoreboard players operation #Physics.ContactPoint.z Physics *= @s Physics.Object.Axis.y.z
        scoreboard players operation #Physics.ContactPoint.z Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.ObjectA.EdgeStart.z Physics

        # Point on EdgeB & Get average
        # (Important): The ObjectB axis only goes along the z direction, so I can just add the EdgeStart for the other components and then divide by 2.
        scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.Maths.Value1 Physics
        execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactPoint[0] int 0.5 run scoreboard players operation #Physics.Maths.s Physics += #Physics.ObjectB.EdgeStart.x Physics
        execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactPoint[1] int 0.5 run scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.ObjectB.EdgeStart.y Physics
        execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactPoint[2] int 0.5 run scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.ObjectB.EdgeStart.z Physics

# Contact Normal
execute unless score #Physics.ObjectA.EdgeProjection Physics > #Physics.ObjectB.EdgeProjection Physics store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[0] int 1 run scoreboard players get #Physics.CrossProductAxis.zy.x Physics
execute unless score #Physics.ObjectA.EdgeProjection Physics > #Physics.ObjectB.EdgeProjection Physics store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[1] int 1 run return run scoreboard players get #Physics.CrossProductAxis.zy.y Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[0] int -1 run scoreboard players get #Physics.CrossProductAxis.zy.x Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[1] int -1 run scoreboard players get #Physics.CrossProductAxis.zy.y Physics
