# Surface normal: [1,0,0]

# Rotate by the transformation matrix
execute store result score #Physics.Maths.SurfaceNormal.y Physics.Value store result score #Physics.Maths.SurfaceNormal.z Physics.Value run scoreboard players set #Physics.Maths.SurfaceNormal.x Physics.Value 1
scoreboard players operation #Physics.Maths.SurfaceNormal.x Physics.Value *= @s Physics.Object.RotationMatrix.0
scoreboard players operation #Physics.Maths.SurfaceNormal.y Physics.Value *= @s Physics.Object.RotationMatrix.3
scoreboard players operation #Physics.Maths.SurfaceNormal.z Physics.Value *= @s Physics.Object.RotationMatrix.6
