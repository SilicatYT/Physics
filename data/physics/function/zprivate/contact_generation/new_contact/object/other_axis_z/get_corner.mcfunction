# Get the corner point
$execute store result storage physics:temp data.NewContact.FeatureA byte 1 store result storage physics:temp data.FeatureA byte 1 run scoreboard players set #Physics.FeatureA Physics $(Corner)

# Copy the coordinates (For getting the Contact Point later)
$scoreboard players operation #Physics.ContactPoint.x Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).x
$scoreboard players operation #Physics.ContactPoint.y Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).y
$scoreboard players operation #Physics.ContactPoint.z Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).z

# Calculate penetration depth & get contact normal
# (Important): The contact normal scores are set for accumulation later.
$scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.ObjectCorner$(Corner).OtherObjectAxis.z Physics
scoreboard players operation #Physics.PenetrationDepth Physics += #Physics.Projection.ObjectCenter.OtherObjectAxis.z Physics
execute if score #Physics.FeatureB Physics matches 15 store result storage physics:temp data.NewContact.ContactNormal[0] int 1 store result score #Physics.ContactNormal.x Physics run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Axis.z.x
execute if score #Physics.FeatureB Physics matches 15 store result storage physics:temp data.NewContact.ContactNormal[1] int 1 store result score #Physics.ContactNormal.y Physics run scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Axis.z.y
execute if score #Physics.FeatureB Physics matches 15 store result storage physics:temp data.NewContact.ContactNormal[2] int 1 store result score #Physics.ContactNormal.z Physics run scoreboard players operation #Physics.Maths.Value3 Physics = @s Physics.Object.Axis.z.z
execute if score #Physics.FeatureB Physics matches 15 run scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Max
execute if score #Physics.FeatureB Physics matches 15 store result storage physics:temp data.NewContact.PenetrationDepth short 1 store result storage physics:zprivate ContactGroups[-1].Objects[-1].MaxPenetrationDepth short 1 run return run scoreboard players operation #Physics.PenetrationDepth Physics *= #Physics.Constants.-1 Physics

execute store result storage physics:temp data.NewContact.PenetrationDepth short 1 store result storage physics:zprivate ContactGroups[-1].Objects[-1].MaxPenetrationDepth short 1 run scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Min
execute store result storage physics:temp data.NewContact.ContactNormal[0] int -1 store result score #Physics.ContactNormal.x Physics run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Axis.z.x
execute store result storage physics:temp data.NewContact.ContactNormal[1] int -1 store result score #Physics.ContactNormal.y Physics run scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Axis.z.y
execute store result storage physics:temp data.NewContact.ContactNormal[2] int -1 store result score #Physics.ContactNormal.z Physics run scoreboard players operation #Physics.Maths.Value3 Physics = @s Physics.Object.Axis.z.z
scoreboard players operation #Physics.ContactNormal.x Physics *= #Physics.Constants.-1 Physics
scoreboard players operation #Physics.ContactNormal.y Physics *= #Physics.Constants.-1 Physics
scoreboard players operation #Physics.ContactNormal.z Physics *= #Physics.Constants.-1 Physics
