# Set default attributes
data modify storage physics:object data set from entity @s
execute store result score @s Physics.Object.Pos.x run data get storage physics:object data.Pos[0] 1000
execute store result score @s Physics.Object.Pos.y run data get storage physics:object data.Pos[1] 1000
execute store result score @s Physics.Object.Pos.z run data get storage physics:object data.Pos[2] 1000
scoreboard players set @s Physics.Object.InverseMass 100000
scoreboard players set @s Physics.Object.Dimension.x 10000
scoreboard players set @s Physics.Object.Dimension.y 10000
scoreboard players set @s Physics.Object.Dimension.z 10000
scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.0 6024096
scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.4 6024096
scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.8 6024096
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.0 6024096
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.1 0
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.2 0
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.3 0
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.4 6024096
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.5 0
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.6 0
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.7 0
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.8 6024096

# Remove tag
tag @s remove Physics.New
