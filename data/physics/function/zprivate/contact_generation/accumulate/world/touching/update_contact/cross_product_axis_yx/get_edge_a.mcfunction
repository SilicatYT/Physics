# Get Edge A
$execute store result score #Physics.ObjectA.EdgeStart.x Physics run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosGlobal.$(StartCorner).x
$execute store result score #Physics.ObjectA.EdgeStart.y Physics run scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.CornerPosGlobal.$(StartCorner).y
$execute store result score #Physics.ObjectA.EdgeStart.z Physics run scoreboard players operation #Physics.Maths.Value3 Physics = @s Physics.Object.CornerPosGlobal.$(StartCorner).z

$scoreboard players operation #Physics.ObjectA.EdgeProjection Physics = #Physics.Projection.ObjectCorner$(StartCorner).CrossProductAxis.yx Physics
