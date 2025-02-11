# Get the corner point
$execute store result storage physics:temp data.NewContact.FeatureB int 1 store result storage physics:temp data.FeatureB int 1 run scoreboard players set #Physics.ObjectB.Feature Physics $(Corner)

# Copy the coordinates (For getting the Contact Point later)
$scoreboard players operation #Physics.ContactPoint.x Physics = #Physics.Projection.Block.WorldAxis.x.$(x) Physics
$scoreboard players operation #Physics.ContactPoint.y Physics = #Physics.Projection.Block.WorldAxis.y.$(y) Physics
$scoreboard players operation #Physics.ContactPoint.z Physics = #Physics.Projection.Block.WorldAxis.z.$(z) Physics

# Calculate penetration depth & get contact normal
# (Important): Getting the contact normal here (but only if the face is pointing toward the positive axis direction) is done to avoid 3 score checks.
$scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.BlockCornerBase$(Corner).ObjectAxis.x Physics
scoreboard players operation #Physics.PenetrationDepth Physics += #Physics.Projection.BlockCenter.ObjectAxis.x Physics
execute if score #Physics.ObjectA.Feature Physics matches 100 run return run execute store result storage physics:temp data.NewContact.PenetrationDepth int 1 run scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.ProjectionOwnAxis.x.Min
execute store result storage physics:temp data.NewContact.PenetrationDepth int 1 run scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.ProjectionOwnAxis.x.Max

execute store result storage physics:temp data.NewContact.ContactNormal[0] int 1 run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Axis.x.x
execute store result storage physics:temp data.NewContact.ContactNormal[1] int 1 run scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Axis.x.y
execute store result storage physics:temp data.NewContact.ContactNormal[2] int 1 run scoreboard players operation #Physics.Maths.Value3 Physics = @s Physics.Object.Axis.x.z
