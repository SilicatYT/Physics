# Get the corner point
execute store result storage physics:temp data.NewContact.FeatureB int 1 store result storage physics:temp data.FeatureB int 1 run scoreboard players set #Physics.ObjectB.Feature Physics 7

# Copy the coordinates (For getting the Contact Point later)
scoreboard players operation #Physics.ContactPoint.x Physics = #Physics.Projection.Block.WorldAxis.x.Max Physics
scoreboard players operation #Physics.ContactPoint.y Physics = #Physics.Projection.Block.WorldAxis.y.Max Physics
scoreboard players operation #Physics.ContactPoint.z Physics = #Physics.Projection.Block.WorldAxis.z.Max Physics

# Calculate penetration depth (Setup)
scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.BlockCornerBase7.ObjectAxis.x Physics
scoreboard players operation #Physics.PenetrationDepth Physics += #Physics.Projection.BlockCenter.ObjectAxis.x Physics
execute if score #Physics.ObjectA.Feature Physics matches 100 run return run scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.ProjectionOwnAxis.x.Min
scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.ProjectionOwnAxis.x.Max
