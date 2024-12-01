# Set the object's inverse mass
scoreboard players add #Physics.SetAttribute.InverseMass Physics.Value 0
execute if score #Physics.SetAttribute.InverseMass Physics.Value matches 1000000001.. run return run scoreboard players set @s Physics.Object.InverseMass 1000000000
execute if score #Physics.SetAttribute.InverseMass Physics.Value matches ..0 run return run scoreboard players set @s Physics.Object.InverseMass 1

scoreboard players operation @s Physics.Object.InverseMass = #Physics.SetAttribute.InverseMass Physics.Value
