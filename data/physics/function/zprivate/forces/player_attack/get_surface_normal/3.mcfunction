# Surface normal: [0,-1,0]

# Rotate by the transformation matrix
execute store result score #Physics.Maths.SurfaceNormal.y Physics.Value store result score #Physics.Maths.SurfaceNormal.z Physics.Value run scoreboard players set #Physics.Maths.SurfaceNormal.x Physics.Value -1
scoreboard players operation #Physics.Maths.SurfaceNormal.x Physics.Value *= @s Physics.Object.RotationMatrix.1
scoreboard players operation #Physics.Maths.SurfaceNormal.y Physics.Value *= @s Physics.Object.RotationMatrix.4
scoreboard players operation #Physics.Maths.SurfaceNormal.z Physics.Value *= @s Physics.Object.RotationMatrix.7
