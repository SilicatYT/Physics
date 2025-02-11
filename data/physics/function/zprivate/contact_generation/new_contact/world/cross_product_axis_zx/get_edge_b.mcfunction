# Get ObjectB's edge
# (Important): There are 4 possible edges, so everything is cached.
$execute store result storage physics:temp data.NewContact.FeatureB int 1 store result storage physics:temp data.FeatureB int 1 run scoreboard players set #Physics.ObjectB.Feature Physics $(Edge)

# Set the start point for calculating the distance between the two points (Penetration Depth)
$scoreboard players operation #Physics.Maths.SquareRoot.Input Physics = #Physics.Projection.Block.WorldAxis.x.$(x) Physics
$scoreboard players operation #Physics.Maths.Value4 Physics = #Physics.Projection.Block.WorldAxis.y.$(y) Physics
$scoreboard players operation #Physics.Maths.Value5 Physics = #Physics.Projection.Block.WorldAxis.z.$(z) Physics

# Subtract the start point from the other edge's start point for calculating (u - m)
scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.SquareRoot.Input Physics
scoreboard players operation #Physics.Maths.Value2 Physics -= #Physics.Maths.Value4 Physics
scoreboard players operation #Physics.Maths.Value3 Physics -= #Physics.Maths.Value5 Physics
