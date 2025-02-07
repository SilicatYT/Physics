# Get the object's feature (Face that's closest to the world-geometry block)
# (Important): There are 2 candidate faces (those normal to the axis), and I select the correct one by looking at the projection of a single point of them and looking which is closer. If I look at the same point for both faces, I can easily get which face is closer.
execute if score #Physics.Projection.Block.ObjectAxis.x.Min Physics < @s Physics.Object.ProjectionOwnAxis.x.Min store result storage physics:temp data.NewContact.FeatureA int 1 store result storage physics:temp data.FeatureA int 1 run scoreboard players set #Physics.ObjectA.Feature Physics 100
execute if score #Physics.Projection.Block.ObjectAxis.x.Min Physics >= @s Physics.Object.ProjectionOwnAxis.x.Min store result storage physics:temp data.NewContact.FeatureA int 1 store result storage physics:temp data.FeatureA int 1 run scoreboard players set #Physics.ObjectA.Feature Physics 101

# Get the world-geometry block's feature (Corner that's closest to the object)
# (Important): I check which of the 8 corners' projection is the closest to the object along the axis (furthest along the axis), so I have to get either the min or the max.
execute if score #Physics.ObjectA.Feature Physics matches 100 run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics
execute if score #Physics.ObjectA.Feature Physics matches 101 run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.BlockBase.ObjectAxis.x.Min Physics

    # Set the feature
    # (Important): There are only 8 corners, so everything is cached. Reduces duplicate files.
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase0.ObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_x/get_corner {Corner:0}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase1.ObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_x/get_corner {Corner:1}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase2.ObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_x/get_corner {Corner:2}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase3.ObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_x/get_corner {Corner:3}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase4.ObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_x/get_corner {Corner:4}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase5.ObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_x/get_corner {Corner:5}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase6.ObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_x/get_corner {Corner:6}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase7.ObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_x/get_corner {Corner:7}

# Calculate Penetration Depth, Contact Normal, Contact Point & Separating Velocity
    # Penetration Depth
    # (Important): For point-face collisions, the penetration depth is the projection of (point - <any point on the face>) onto the contact normal. It's distributive, so I can also subtract the projection of any point on the face from the (already calculated) projection of the corner.
    # (Important): Calculations are done in "get_corner/..." to avoid redundant score checks and to utilize "return run".
    execute store result storage physics:temp data.NewContact.PenetrationDepth int 1 run scoreboard players get #Physics.PenetrationDepth Physics

    # Contact Normal
    # (Important): For point-face collisions, the contact normal is the face's normal. So it's the axis of minimum overlap.
    execute store result storage physics:temp data.NewContact.ContactNormal[0] int 1 store result score #Physics.Maths.Value1 Physics run scoreboard players get @s Physics.Object.Axis.x.x
    execute store result storage physics:temp data.NewContact.ContactNormal[1] int 1 store result score #Physics.Maths.Value2 Physics run scoreboard players get @s Physics.Object.Axis.x.y
    execute store result storage physics:temp data.NewContact.ContactNormal[2] int 1 store result score #Physics.Maths.Value3 Physics run scoreboard players get @s Physics.Object.Axis.x.z

    # Contact Point
    # (Important): For point-face collisions, the contact point is the point projected onto the surface (= moved along contact normal with the penetration depth as the amount).
    # (Important): I use the "execute store" from earlier to avoid an additional scoreboard call. Also, the point's coordinates are copied over in "get_corner/...".
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.PenetrationDepth Physics
    execute if score #Physics.ObjectA.Feature Physics matches 100 run scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.-1000 Physics
    execute if score #Physics.ObjectA.Feature Physics matches 101 run scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 run scoreboard players operation #Physics.ContactPoint.x Physics += #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.PenetrationDepth Physics
    execute if score #Physics.ObjectA.Feature Physics matches 100 run scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.-1000 Physics
    execute if score #Physics.ObjectA.Feature Physics matches 101 run scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.Maths.Value2 Physics

    scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.PenetrationDepth Physics
    execute if score #Physics.ObjectA.Feature Physics matches 100 run scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.-1000 Physics
    execute if score #Physics.ObjectA.Feature Physics matches 101 run scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.NewContact.ContactPoint[2] int 1 run scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.Maths.Value3 Physics

    # Separating Velocity
    # (Important): ???

# Store the new contact
# (Important): The values are stored in their scaled up form, just like how I need them to process them.
# (Important): Note that I store the block position scaled up by 1,000x, because I don't want to scale it back up manually later.
execute store result storage physics:temp data.NewContact.Gametime int 1 run time query gametime

execute store result storage physics:temp data.Pos[0] int 1 run scoreboard players get #Physics.BlockPos.x Physics
execute store result storage physics:temp data.Pos[1] int 1 run scoreboard players get #Physics.BlockPos.y Physics
execute store result storage physics:temp data.Pos[2] int 1 run scoreboard players get #Physics.BlockPos.z Physics

function physics:zprivate/contact_generation/new_contact/world/store with storage physics:temp data
