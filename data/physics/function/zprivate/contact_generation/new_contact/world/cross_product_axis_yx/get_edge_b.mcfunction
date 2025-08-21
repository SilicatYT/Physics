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

# Check whether penetration depth and contact normal should be inverted
execute store success score #Physics.InvertValues Physics if score #Physics.Projection.Object.CrossProductAxis.yx.Min Physics = #Physics.PenetrationDepth Physics

# Calculate the Penetration Depth
# (Important): EdgeA projection - EdgeB projection
$scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.Projection.BlockCornerBase$(StartCorner).CrossProductAxis.yx Physics
scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.Projection.BlockCenter.CrossProductAxis.yx Physics

# Invert the penetration depth & contact normal if needed
execute if score #Physics.InvertValues Physics matches 0 store result storage physics:temp data.NewContact.PenetrationDepth short 1 run return run scoreboard players get #Physics.PenetrationDepth Physics
execute store result storage physics:temp data.NewContact.PenetrationDepth short 1 run scoreboard players operation #Physics.PenetrationDepth Physics *= #Physics.Constants.-1 Physics
execute store result storage physics:temp data.NewContact.ContactNormal[0] int -1 run scoreboard players operation #Physics.ContactNormal.x Physics = #Physics.CrossProductAxis.yx.x Physics
execute store result storage physics:temp data.NewContact.ContactNormal[2] int -1 run scoreboard players operation #Physics.ContactNormal.z Physics = #Physics.CrossProductAxis.yx.z Physics
scoreboard players operation #Physics.ContactNormal.x Physics *= #Physics.Constants.-1 Physics
scoreboard players operation #Physics.ContactNormal.z Physics *= #Physics.Constants.-1 Physics
