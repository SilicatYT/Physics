# Get the corner point
$execute store result storage physics:temp data.NewContact.FeatureA int 1 store result storage physics:temp data.FeatureA int 1 run scoreboard players set #Physics.ObjectA.Feature Physics $(Corner)

# Copy the coordinates (For getting the Contact Point later)
$execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 run scoreboard players get @s Physics.Object.CornerPosGlobal.$(Corner).x
$execute store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players operation #Physics.ContactPoint.y Physics = @s Physics.Object.CornerPosGlobal.$(Corner).y
execute if score #Physics.ObjectB.Feature Physics matches 104 store result storage physics:temp data.NewContact.ContactPoint[2] int 1 run scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.Block.WorldAxis.z.Min Physics
execute if score #Physics.ObjectB.Feature Physics matches 105 store result storage physics:temp data.NewContact.ContactPoint[2] int 1 run scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.Block.WorldAxis.z.Max Physics

# Calculate penetration depth
$execute store result storage physics:temp data.NewContact.PenetrationDepth int 1 run scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.CornerPosGlobal.$(Corner).z
