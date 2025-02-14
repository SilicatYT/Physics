# Get the corner point
$execute store result storage physics:temp data.NewContact.FeatureA int 1 store result storage physics:temp data.FeatureA int 1 run scoreboard players set #Physics.ObjectA.Feature Physics $(Corner)

# Copy the coordinates (For getting the Contact Point later)
$execute store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players get @s Physics.Object.CornerPosGlobal.$(Corner).y
$execute store result storage physics:temp data.NewContact.ContactPoint[2] int 1 run scoreboard players operation #Physics.ContactPoint.z Physics = @s Physics.Object.CornerPosGlobal.$(Corner).z

# Calculate penetration depth (& copy the remaining contact point coordinates)
# (Important): The penetration depth depends on the contact normal, so if that one needs to be inverted, so does the penetration depth.
execute if score #Physics.ObjectB.Feature Physics matches 101 store result storage physics:temp data.NewContact.ContactPoint[0] int 1 run scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.Block.WorldAxis.x.Max Physics
$execute if score #Physics.ObjectB.Feature Physics matches 101 store result storage physics:temp data.NewContact.PenetrationDepth int 1 run return run scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.CornerPosGlobal.$(Corner).x

execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 run scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.Block.WorldAxis.x.Min Physics
$scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.CornerPosGlobal.$(Corner).x
execute store result storage physics:temp data.NewContact.PenetrationDepth int 1 run scoreboard players operation #Physics.PenetrationDepth Physics *= #Physics.Constants.-1 Physics
data modify storage physics:temp data.NewContact.ContactNormal set value [I;1000,0,0]
