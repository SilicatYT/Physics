# Get the object's feature (Face that's closest to the world-geometry block)
# (Important): There are 2 candidate faces (those normal to the axis), and I select the correct one by looking at the projection of a single point of them and looking which is closer. If I look at the same point for both faces, I can easily get which face is closer.
execute if score @s Physics.Object.BoundingBoxGlobalMin.x < #Physics.Projection.Block.WorldAxis.x.Min Physics store result storage physics:temp data.NewContact.FeatureB int 1 store result storage physics:temp data.FeatureB int 1 run scoreboard players set #Physics.ObjectB.Feature Physics 100
execute if score @s Physics.Object.BoundingBoxGlobalMin.x >= #Physics.Projection.Block.WorldAxis.x.Min Physics store result storage physics:temp data.NewContact.FeatureB int 1 store result storage physics:temp data.FeatureB int 1 run scoreboard players set #Physics.ObjectB.Feature Physics 101

# Get the world-geometry block's feature (Corner that's closest to the object)
# (Important): I check which of the 8 corners' projection is the closest to the object along the axis (furthest along the axis), so I have to get either the min or the max.
execute if score #Physics.ObjectB.Feature Physics matches 100 run scoreboard players operation #Physics.DeepestProjection Physics = @s Physics.Object.BoundingBoxGlobalMax.x
execute if score #Physics.ObjectB.Feature Physics matches 101 run scoreboard players operation #Physics.DeepestProjection Physics = @s Physics.Object.BoundingBoxGlobalMin.x

    # Set the feature
    # (Important): There are only 8 corners (and unique macro variable combinations), so everything is cached. Reduces duplicate files.
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.0.x run function physics:zprivate/contact_generation/new_contact/world/world_axis_x/get_corner {Corner:0}
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.1.x run function physics:zprivate/contact_generation/new_contact/world/world_axis_x/get_corner {Corner:1}
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.2.x run function physics:zprivate/contact_generation/new_contact/world/world_axis_x/get_corner {Corner:2}
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.3.x run function physics:zprivate/contact_generation/new_contact/world/world_axis_x/get_corner {Corner:3}
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.4.x run function physics:zprivate/contact_generation/new_contact/world/world_axis_x/get_corner {Corner:4}
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.5.x run function physics:zprivate/contact_generation/new_contact/world/world_axis_x/get_corner {Corner:5}
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.6.x run function physics:zprivate/contact_generation/new_contact/world/world_axis_x/get_corner {Corner:6}
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.7.x run function physics:zprivate/contact_generation/new_contact/world/world_axis_x/get_corner {Corner:7}

# Calculate Penetration Depth, Contact Normal, Contact Point & Separating Velocity
    # Penetration Depth
    # (Important): For point-face collisions, the penetration depth is the projection of (point - <any point on the face>) onto the contact normal. It's distributive, so I can also subtract the projection of any point on the face from the (already calculated) projection of the corner.
    # (Important): Calculations are done in "get_corner/..." to avoid redundant score checks and to utilize "return run".

    # Contact Normal
    # (Important): For point-face collisions, the contact normal is the face's normal. So it's the axis of minimum overlap.
    execute if score #Physics.ObjectB.Feature Physics matches 101 run data modify storage physics:temp data.NewContact.ContactNormal set value [I;1000,0,0]

    # Contact Point
    # (Important): For point-face collisions, the contact point is the point projected onto the surface (= moved along contact normal with the penetration depth as the amount).
    # (Important): I use the "execute store" from earlier to avoid an additional scoreboard call. Also, the point's coordinates are copied over in "get_corner/...".

    # Separating Velocity
    # (Important): The separating velocity is the contact point's relative velocity's component from the contact normal. The relative velocity is the cross product between the angular velocity and the contact point (relative to the object's center) that's added together with the object's linear velocity.
    # (Important): Because the static object is now the one with the face, the result of the separating velocity is inverted.
        # Calculate relative contact point
        scoreboard players operation #Physics.ContactPoint.y Physics -= @s Physics.Object.Pos.y
        scoreboard players operation #Physics.ContactPoint.z Physics -= @s Physics.Object.Pos.z

        # Calculate cross product between relative contact point and angular velocity
        # (Important): I overwrite the contact point scores here, as I don't need them anymore after this.
        # (Important): Because the contact normal only has 1 component and I take the dot product afterwards, I only calculate the point velocity's x component.
        # (Important): I store the final PointVelocity in ContactPoint.y to avoid a scoreboard operation.
        scoreboard players operation #Physics.ContactPoint.y Physics *= @s Physics.Object.AngularVelocity.z
        scoreboard players operation #Physics.ContactPoint.z Physics *= @s Physics.Object.AngularVelocity.y
        scoreboard players operation #Physics.ContactPoint.y Physics -= #Physics.ContactPoint.z Physics
        scoreboard players operation #Physics.ContactPoint.y Physics /= #Physics.Constants.1000 Physics

        # Add the linear velocity to obtain the relative velocity of the contact point
        scoreboard players operation #Physics.ContactPoint.y Physics += @s Physics.Object.Velocity.x

        # Take the dot product with the contact normal
        execute if score #Physics.ObjectB.Feature Physics matches 100 run scoreboard players operation #Physics.ContactPoint.y Physics *= #Physics.Constants.-1 Physics
        execute store result storage physics:temp data.NewContact.SeparatingVelocity int 1 run scoreboard players get #Physics.ContactPoint.y Physics

# Store the new contact
# (Important): The values are stored in their scaled up form, just like how I need them to process them.
# (Important): Note that I don't store the block's position scaled up, because it makes no difference compared to storing the center coords. I can't store the min projection either, because that would bug out for different block hitbox sizes.
    # Update the hitbox data (Min_x, Max_x, Min_y, Max_y, Min_z, Max_z)
    execute store result storage physics:temp data.BlockData.Hitbox[0] int 1 run scoreboard players get #Physics.Projection.Block.WorldAxis.x.Min Physics
    execute store result storage physics:temp data.BlockData.Hitbox[1] int 1 run scoreboard players get #Physics.Projection.Block.WorldAxis.x.Max Physics
    execute store result storage physics:temp data.BlockData.Hitbox[2] int 1 run scoreboard players get #Physics.Projection.Block.WorldAxis.y.Min Physics
    execute store result storage physics:temp data.BlockData.Hitbox[3] int 1 run scoreboard players get #Physics.Projection.Block.WorldAxis.y.Max Physics
    execute store result storage physics:temp data.BlockData.Hitbox[4] int 1 run scoreboard players get #Physics.Projection.Block.WorldAxis.z.Min Physics
    execute store result storage physics:temp data.BlockData.Hitbox[5] int 1 run scoreboard players get #Physics.Projection.Block.WorldAxis.z.Max Physics

execute store result storage physics:temp data.Pos[0] int 1 run scoreboard players get #Physics.BlockPos.x Physics
execute store result storage physics:temp data.Pos[1] int 1 run scoreboard players get #Physics.BlockPos.y Physics
execute store result storage physics:temp data.Pos[2] int 1 run scoreboard players get #Physics.BlockPos.z Physics
function physics:zprivate/contact_generation/new_contact/world/store with storage physics:temp data

# Process the separating velocity (Keep track of the most negative separating velocity for the current ObjectA, as well as global for all ObjectA's)
# (Important): The "#Physics.MinSeparatingVelocityTotal Physics" score keeps track of the overall most negative separating velocity across all ObjectA's, so I can efficiently target the most severe contact in contact resolution's 1st iteration.
execute store result score #Physics.MinSeparatingVelocity Physics run data get storage physics:zprivate data.ContactGroups[-1].MinSeparatingVelocity
execute if score #Physics.MinSeparatingVelocity Physics <= #Physics.ContactPoint.y Physics run return 0
execute if score #Physics.ContactPoint.y Physics < #Physics.MinSeparatingVelocityTotal Physics store result storage physics:zprivate data.ContactGroups[-1].MinSeparatingVelocity int 1 run return run scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics = #Physics.ContactPoint.y Physics
execute store result storage physics:zprivate data.ContactGroups[-1].MinSeparatingVelocity int 1 run scoreboard players get #Physics.ContactPoint.y Physics
