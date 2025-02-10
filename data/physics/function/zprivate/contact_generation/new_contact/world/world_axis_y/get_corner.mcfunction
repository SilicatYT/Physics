# Get the corner point
$execute store result storage physics:temp data.NewContact.FeatureA int 1 store result storage physics:temp data.FeatureA int 1 run scoreboard players set #Physics.ObjectA.Feature Physics $(Corner)

# Copy the coordinates (For getting the Contact Point later)
$execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 run scoreboard players operation #Physics.ContactPoint.x Physics = @s Physics.Object.CornerPosGlobal.$(Corner).x
execute if score #Physics.ObjectB.Feature Physics matches 102 store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.Block.WorldAxis.y.Min Physics
execute if score #Physics.ObjectB.Feature Physics matches 103 store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.Block.WorldAxis.y.Max Physics
$execute store result storage physics:temp data.NewContact.ContactPoint[2] int 1 run scoreboard players get @s Physics.Object.CornerPosGlobal.$(Corner).z

# Calculate penetration depth
$execute store result storage physics:temp data.NewContact.PenetrationDepth int 1 run scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.CornerPosGlobal.$(Corner).y
