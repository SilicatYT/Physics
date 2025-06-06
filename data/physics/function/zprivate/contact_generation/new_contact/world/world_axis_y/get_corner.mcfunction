# Get the corner point
$execute store result storage physics:temp data.NewContact.FeatureA byte 1 store result storage physics:temp data.FeatureA byte 1 run scoreboard players set #Physics.FeatureA Physics $(Corner)

# Copy the coordinates (For getting the Contact Point later)
$execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 run scoreboard players operation #Physics.ContactPoint.x Physics = @s Physics.Object.CornerPosGlobal.$(Corner).x
$execute store result storage physics:temp data.NewContact.ContactPoint[2] int 1 run scoreboard players operation #Physics.ContactPoint.z Physics = @s Physics.Object.CornerPosGlobal.$(Corner).z

# Calculate penetration depth (& copy the remaining contact point coordinates)
# (Important): The penetration depth depends on the contact normal, so if that one needs to be inverted, so does the penetration depth.
execute if score #Physics.FeatureB Physics matches 13 store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.Block.WorldAxis.y.Max Physics
$execute if score #Physics.FeatureB Physics matches 13 store result storage physics:temp data.NewContact.PenetrationDepth short 1 run return run scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.CornerPosGlobal.$(Corner).y

execute store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players get #Physics.Projection.Block.WorldAxis.y.Min Physics
$scoreboard players operation #Physics.PenetrationDepth Physics = @s Physics.Object.CornerPosGlobal.$(Corner).y
execute store result storage physics:temp data.NewContact.PenetrationDepth short 1 run scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.Projection.Block.WorldAxis.y.Min Physics
data modify storage physics:temp data.NewContact.ContactNormal set value [I;0,-1000,0]
scoreboard players set #Physics.ContactNormal.y Physics -1000
