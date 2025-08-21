# Get Edge B
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

# Contact Normal
execute unless score #Physics.ObjectA.EdgeProjection Physics > #Physics.ObjectB.EdgeProjection Physics store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[0] int 1 run scoreboard players get #Physics.CrossProductAxis.zy.x Physics
execute unless score #Physics.ObjectA.EdgeProjection Physics > #Physics.ObjectB.EdgeProjection Physics store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[1] int 1 run return run scoreboard players get #Physics.CrossProductAxis.zy.y Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[0] int -1 run scoreboard players get #Physics.CrossProductAxis.zy.x Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[1] int -1 run scoreboard players get #Physics.CrossProductAxis.zy.y Physics
