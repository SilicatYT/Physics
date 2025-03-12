# Get the corner point
$execute store result storage physics:temp data.NewContact.FeatureA byte 1 store result storage physics:temp data.FeatureA byte 1 run scoreboard players set #Physics.FeatureA Physics $(Corner)

# Copy the coordinates (For getting the Contact Point later)
$scoreboard players operation #Physics.ContactPoint.x Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).x
$scoreboard players operation #Physics.ContactPoint.y Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).y
$scoreboard players operation #Physics.ContactPoint.z Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).z

# Calculate penetration depth & get contact normal
# (Important): Getting the contact normal here (but only if the face is pointing toward the positive axis direction) is done to avoid 3 score checks.
$scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.ObjectCorner$(Corner).OtherObjectAxis.y Physics
scoreboard players operation #Physics.PenetrationDepth Physics += #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics
execute if score #Physics.FeatureB Physics matches 12 store result storage physics:temp data.NewContact.PenetrationDepth short 1 run return run scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.ProjectionOwnAxis.y.Min
scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.ProjectionOwnAxis.y.Max
execute store result storage physics:temp data.NewContact.PenetrationDepth short 1 run scoreboard players operation #Physics.PenetrationDepth Physics *= #Physics.Constants.-1 Physics

execute store result storage physics:temp data.NewContact.ContactNormal[0] int 1 run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Axis.y.x
execute store result storage physics:temp data.NewContact.ContactNormal[1] int 1 run scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Axis.y.y
execute store result storage physics:temp data.NewContact.ContactNormal[2] int 1 run scoreboard players operation #Physics.Maths.Value3 Physics = @s Physics.Object.Axis.y.z
