# Contact Normal
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[0] int -1 run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Axis.z.x
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[1] int -1 run scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Axis.z.y
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[2] int -1 run scoreboard players operation #Physics.Maths.Value3 Physics = @s Physics.Object.Axis.z.z
