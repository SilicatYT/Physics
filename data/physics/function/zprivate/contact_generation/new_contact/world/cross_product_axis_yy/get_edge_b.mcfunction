# Get ObjectB's edge
# (Important): There are 4 possible edges, so everything is cached.
$execute store result storage physics:temp data.NewContact.FeatureB byte 1 store result storage physics:temp data.FeatureB byte 1 run scoreboard players set #Physics.FeatureB Physics $(Edge)

$scoreboard players operation #Physics.ObjectB.EdgeStart.x Physics = #Physics.Projection.Block.WorldAxis.x.$(x) Physics
$scoreboard players operation #Physics.ObjectB.EdgeStart.y Physics = #Physics.Projection.Block.WorldAxis.y.$(y) Physics
$scoreboard players operation #Physics.ObjectB.EdgeStart.z Physics = #Physics.Projection.Block.WorldAxis.z.$(z) Physics

# Subtract the start point from the other edge's start point for calculating (u - m)
scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.ObjectB.EdgeStart.x Physics
scoreboard players operation #Physics.Maths.Value2 Physics -= #Physics.ObjectB.EdgeStart.y Physics
scoreboard players operation #Physics.Maths.Value3 Physics -= #Physics.ObjectB.EdgeStart.z Physics

# Get the edge's projection (For inverting the contact normal if necessary)
$scoreboard players operation #Physics.ObjectB.EdgeProjection Physics = #Physics.Projection.BlockCornerBase$(StartCorner).CrossProductAxis.yy Physics
execute store result score #Physics.PenetrationDepth Physics run scoreboard players operation #Physics.ObjectB.EdgeProjection Physics += #Physics.Projection.BlockCenter.CrossProductAxis.yy Physics

# Calculate the Penetration Depth
scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.ObjectA.EdgeProjection Physics
execute if score #Physics.ObjectA.EdgeProjection Physics > #Physics.ObjectB.EdgeProjection Physics run scoreboard players operation #Physics.PenetrationDepth Physics *= #Physics.Constants.-1 Physics
execute store result storage physics:temp data.NewContact.PenetrationDepth short 1 run scoreboard players get #Physics.PenetrationDepth Physics

# Invert the contact normal if ObjectA's edge projection is larger than ObjectB's edge projection
execute if score #Physics.PenetrationDepth Physics matches 0.. run return 0
execute store result storage physics:temp data.NewContact.ContactNormal[0] int -1 store result score #Physics.ContactNormal.x Physics run scoreboard players get #Physics.CrossProductAxis.yy.x Physics
execute store result storage physics:temp data.NewContact.ContactNormal[2] int -1 store result score #Physics.ContactNormal.z Physics run scoreboard players get #Physics.CrossProductAxis.yy.z Physics
scoreboard players operation #Physics.ContactNormal.x Physics *= #Physics.Constants.-1 Physics
scoreboard players operation #Physics.ContactNormal.z Physics *= #Physics.Constants.-1 Physics
