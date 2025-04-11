# Get ObjectB's edge
# (Important): There are 4 possible edges, so everything is cached.
$execute store result storage physics:temp data.NewContact.FeatureB byte 1 store result storage physics:temp data.FeatureB byte 1 run scoreboard players set #Physics.FeatureB Physics $(Edge)

# Set the start point for calculating the distance between the two points (Penetration Depth)
$scoreboard players operation #Physics.Maths.SquareRoot.Input Physics = @s Physics.Object.CornerPosGlobal.$(StartCorner).x
$scoreboard players operation #Physics.Maths.Value4 Physics = @s Physics.Object.CornerPosGlobal.$(StartCorner).y
$scoreboard players operation #Physics.Maths.Value5 Physics = @s Physics.Object.CornerPosGlobal.$(StartCorner).z

# Subtract the start point from the other edge's start point for calculating (u - m)
scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.SquareRoot.Input Physics
scoreboard players operation #Physics.Maths.Value2 Physics -= #Physics.Maths.Value4 Physics
scoreboard players operation #Physics.Maths.Value3 Physics -= #Physics.Maths.Value5 Physics

# Get the edge's projection (For inverting the contact normal if necessary)
$scoreboard players operation #Physics.ObjectB.EdgeProjection Physics = #Physics.Projection.OtherObjectCorner$(StartCorner).CrossProductAxis.yz Physics
scoreboard players operation #Physics.ObjectB.EdgeProjection Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.yz Physics

# Invert the contact normal if ObjectA's edge projection is larger than ObjectB's edge projection
execute if score #Physics.ObjectA.EdgeProjection Physics < #Physics.ObjectB.EdgeProjection Physics run return 0
scoreboard players operation #Physics.ContactNormal.x Physics = #Physics.CrossProductAxis.yz.x Physics
scoreboard players operation #Physics.ContactNormal.y Physics = #Physics.CrossProductAxis.yz.y Physics
scoreboard players operation #Physics.ContactNormal.z Physics = #Physics.CrossProductAxis.yz.z Physics
execute store result storage physics:temp data.NewContact.ContactNormal[0] int 1 run scoreboard players operation #Physics.ContactNormal.x Physics *= #Physics.Constants.-1 Physics
execute store result storage physics:temp data.NewContact.ContactNormal[1] int 1 run scoreboard players operation #Physics.ContactNormal.y Physics *= #Physics.Constants.-1 Physics
execute store result storage physics:temp data.NewContact.ContactNormal[2] int 1 run scoreboard players operation #Physics.ContactNormal.z Physics *= #Physics.Constants.-1 Physics
