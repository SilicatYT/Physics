# Get ObjectB's edge
# (Important): There are 4 possible edges, so everything is cached.
$scoreboard players set #Physics.ObjectB.Feature Physics $(Edge)

$scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Block.WorldAxis.x.$(x) Physics
$scoreboard players operation #Physics.Maths.Value2 Physics -= #Physics.Projection.Block.WorldAxis.y.$(y) Physics
$scoreboard players operation #Physics.Maths.Value3 Physics -= #Physics.Projection.Block.WorldAxis.z.$(z) Physics
