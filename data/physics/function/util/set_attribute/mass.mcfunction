# Set the object's inverse mass based on its mass
scoreboard players add #Physics.SetAttribute.InverseMass Physics.Value 0
execute if score #Physics.SetAttribute.Mass Physics.Value matches ..0 run return run scoreboard players set @s Physics.Object.InverseMass 1

scoreboard players set @s Physics.Object.InverseMass 1000000000
scoreboard players operation @s Physics.Object.InverseMass /= #Physics.SetAttribute.Mass Physics.Value
