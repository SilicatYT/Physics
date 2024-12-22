# Set default attributes
execute store result score @s Physics.Object.ID run scoreboard players add #Physics.ObjectID Physics 1

data modify storage physics:temp data.Object set from entity @s
execute store result score @s Physics.Object.Pos.x run data get storage physics:temp data.Object.Pos[0] 1000
execute store result score @s Physics.Object.Pos.y run data get storage physics:temp data.Object.Pos[1] 1000
execute store result score @s Physics.Object.Pos.z run data get storage physics:temp data.Object.Pos[2] 1000
scoreboard players set @s Physics.Object.InverseMass 100000
scoreboard players operation @s Physics.Object.Gravity = #Physics.Global.DefaultGravity Physics
scoreboard players set @s Physics.Object.Dimension.x 1000
scoreboard players set @s Physics.Object.Dimension.y 1000
scoreboard players set @s Physics.Object.Dimension.z 1000
scoreboard players set @s Physics.Object.Orientation.x 0
scoreboard players set @s Physics.Object.Orientation.y 0
scoreboard players set @s Physics.Object.Orientation.z 0
scoreboard players set @s Physics.Object.Orientation.a 1000
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
scoreboard players set @s Physics.Object.BoundingBoxLocalMin.x -500
scoreboard players set @s Physics.Object.BoundingBoxLocalMax.x 500
scoreboard players set @s Physics.Object.BoundingBoxLocalMin.y -500
scoreboard players set @s Physics.Object.BoundingBoxLocalMax.y 500
scoreboard players set @s Physics.Object.BoundingBoxLocalMin.z -500
scoreboard players set @s Physics.Object.BoundingBoxLocalMax.z 500
scoreboard players set @s Physics.Object.BoundingBoxStepCount.x 2
scoreboard players set @s Physics.Object.BoundingBoxStepCount.y 2
scoreboard players set @s Physics.Object.BoundingBoxStepCount.z 2

# Summon interaction entity (Width and height is set so that the entire model is inside the hitbox, no matter the orientation. The interaction entity acts as a rough hitbox for punches and collision detection between objects, its width and height being the diagonal between the corners of the object.)
summon minecraft:interaction ~ ~ ~ {Tags:["Physics.HitboxOffset","Physics.New"],height:-0.86602540378f,width:0f}
summon minecraft:interaction ~ ~ ~ {Tags:["Physics.Hitbox","Physics.New"],height:1.73205080757f,width:1.73205080757f}

ride @e[type=minecraft:interaction,tag=Physics.New,tag=Physics.HitboxOffset,distance=..0.1,limit=1] mount @s
execute on passengers run ride @e[type=minecraft:interaction,tag=Physics.New,tag=Physics.Hitbox,distance=..0.1,limit=1] mount @s

# Remove tag
tag @s remove Physics.New
execute on passengers run tag @s remove Physics.New
execute on passengers on passengers run tag @s remove Physics.New
