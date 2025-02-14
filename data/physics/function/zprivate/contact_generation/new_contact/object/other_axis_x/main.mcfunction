# Get ObjectB's feature (Face that's closest to ObjectA)
# (Important): There are 2 candidate faces (those normal to the axis), and I select the correct one by looking at the projection of a single point of them and looking which is closer. If I look at the same point for both faces, I can easily get which face is closer.
execute if score #Physics.Projection.Object.OtherObjectAxis.x.Min Physics < @s Physics.Object.ProjectionOwnAxis.x.Min store result storage physics:temp data.NewContact.FeatureB int 1 store result storage physics:temp data.FeatureB int 1 run scoreboard players set #Physics.ObjectB.Feature Physics 100
execute if score #Physics.Projection.Object.OtherObjectAxis.x.Min Physics >= @s Physics.Object.ProjectionOwnAxis.x.Min store result storage physics:temp data.NewContact.FeatureB int 1 store result storage physics:temp data.FeatureB int 1 run scoreboard players set #Physics.ObjectB.Feature Physics 101

# Get ObjectA's feature (Corner that's closest to ObjectB)
# (Important): I check which of the 8 corners' projection is the closest to ObjectB along the axis (furthest along the axis), so I have to get either the min or the max.
execute if score #Physics.ObjectB.Feature Physics matches 100 run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.OtherObjectAxis.x.Max Physics
execute if score #Physics.ObjectB.Feature Physics matches 101 run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.OtherObjectAxis.x.Min Physics

    # Set the feature
    # (Important): There are only 8 corners (and unique macro variable combinations), so everything is cached. Reduces duplicate files.
    # (Important): Because only the min and max projections are scaled down, I need to scale the corner projections down here. In addition, to account for rounding errors that are different for positive and negative values, I invert DeepestProjection if the face is on the negative side of the axis. Because of this, I also change what corner projection corresponds to which corner.
    scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
    scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
    scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
    scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
    scoreboard players operation #Physics.Projection.ObjectCorner4.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
    scoreboard players operation #Physics.Projection.ObjectCorner5.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
    scoreboard players operation #Physics.Projection.ObjectCorner6.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
    scoreboard players operation #Physics.Projection.ObjectCorner7.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics

    scoreboard players operation #Physics.DeepestProjection Physics -= #Physics.Projection.ObjectCenter.OtherObjectAxis.x Physics
    execute if score #Physics.ObjectB.Feature Physics matches 101 run scoreboard players operation #Physics.DeepestProjection Physics *= #Physics.Constants.-1 Physics

    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner0.OtherObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/object/other_axis_x/get_corner {Corner:7}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner1.OtherObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/object/other_axis_x/get_corner {Corner:6}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner2.OtherObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/object/other_axis_x/get_corner {Corner:5}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner3.OtherObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/object/other_axis_x/get_corner {Corner:4}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner4.OtherObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/object/other_axis_x/get_corner {Corner:3}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner5.OtherObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/object/other_axis_x/get_corner {Corner:2}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner6.OtherObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/object/other_axis_x/get_corner {Corner:1}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner7.OtherObjectAxis.x Physics run function physics:zprivate/contact_generation/new_contact/object/other_axis_x/get_corner {Corner:0}

# Calculate Penetration Depth, Contact Normal, Contact Point & Separating Velocity
    # Penetration Depth
    # (Important): For point-face collisions, the penetration depth is the projection of (point - <any point on the face>) onto the contact normal. It's distributive, so I can also subtract the projection of any point on the face from the (already calculated) projection of the corner.
    # (Important): Calculations are done in "get_corner/..." to avoid redundant score checks and to utilize "return run".

    # Contact Normal
    # (Important): For point-face collisions, the contact normal is the face's normal. So it's the axis of minimum overlap.
    execute if score #Physics.ObjectB.Feature Physics matches 100 store result storage physics:temp data.NewContact.ContactNormal[0] int -1 run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Axis.x.x
    execute if score #Physics.ObjectB.Feature Physics matches 100 store result storage physics:temp data.NewContact.ContactNormal[1] int -1 run scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Axis.x.y
    execute if score #Physics.ObjectB.Feature Physics matches 100 store result storage physics:temp data.NewContact.ContactNormal[2] int -1 run scoreboard players operation #Physics.Maths.Value3 Physics = @s Physics.Object.Axis.x.z

    # Contact Point
    # (Important): For point-face collisions, the contact point is the point projected onto the surface (= moved along contact normal with the penetration depth as the amount).
    # (Important): I use the "execute store" from earlier to avoid an additional scoreboard call. Also, the point's coordinates are copied over in "get_corner/...".
    # (Important): I need to invert the contact normal scores so they always face away from the face, but instead I invert the penetration depth. This is faster, and I don't need the score later anyway.
    execute if score #Physics.ObjectB.Feature Physics matches 100 run scoreboard players operation #Physics.PenetrationDepth Physics *= #Physics.Constants.-1 Physics

    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 store result score #Physics.ContactPointCopy.x Physics run scoreboard players operation #Physics.ContactPoint.x Physics += #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.NewContact.ContactPoint[1] int 1 store result score #Physics.ContactPointCopy.y Physics run scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.Maths.Value2 Physics

    scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.NewContact.ContactPoint[2] int 1 store result score #Physics.ContactPointCopy.z Physics run scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.Maths.Value3 Physics

    # Separating Velocity
    # (Important): The separating velocity for one object is the dot product between the contact point (relative to that object)'s relative velocity and the contact normal. The relative velocity is the cross product between the object's angular velocity and the contact point (relative to the object's center) that's added together with the object's linear velocity.
    # (Important): To get the actual separating velocity, I subtract ObjectA's separating velocity from ObjectB's (because they face different directions, they're sign-flipped), as both objects may be moving or rotating.
        # Separating Velocity for ObjectB
            # Calculate relative contact point
            execute store result score #Physics.PointVelocity.z Physics run scoreboard players operation #Physics.ContactPoint.x Physics -= @s Physics.Object.Pos.x
            execute store result score #Physics.PointVelocity.x Physics run scoreboard players operation #Physics.ContactPoint.y Physics -= @s Physics.Object.Pos.y
            execute store result score #Physics.PointVelocity.y Physics run scoreboard players operation #Physics.ContactPoint.z Physics -= @s Physics.Object.Pos.z

            # Calculate cross product between relative contact point and angular velocity
            # (Important): I overwrite the contact point scores here, as I don't need those values (relative to this object) anymore.
            scoreboard players operation #Physics.PointVelocity.x Physics *= @s Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.ContactPoint.z Physics *= @s Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.PointVelocity.x Physics -= #Physics.ContactPoint.z Physics
            scoreboard players operation #Physics.PointVelocity.x Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.PointVelocity.y Physics *= @s Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.ContactPoint.x Physics *= @s Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.PointVelocity.y Physics -= #Physics.ContactPoint.x Physics
            scoreboard players operation #Physics.PointVelocity.y Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.PointVelocity.z Physics *= @s Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.ContactPoint.y Physics *= @s Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.PointVelocity.z Physics -= #Physics.ContactPoint.y Physics
            scoreboard players operation #Physics.PointVelocity.z Physics /= #Physics.Constants.1000 Physics

            # Add the linear velocity to obtain the relative velocity of the contact point
            scoreboard players operation #Physics.PointVelocity.x Physics += @s Physics.Object.Velocity.x
            scoreboard players operation #Physics.PointVelocity.y Physics += @s Physics.Object.Velocity.y
            scoreboard players operation #Physics.PointVelocity.z Physics += @s Physics.Object.Velocity.z

            # Calculate the relative velocity's dot product with the contact normal to get the separation velocity (single number, not a vector) and store it
            # (Important): Because the contact normal scores (Physics.Object.Axis.?.?) are not adjusted to face away from the face, I may multiply the final result with -1.
            scoreboard players operation #Physics.PointVelocity.x Physics *= @s Physics.Object.Axis.x.x
            scoreboard players operation #Physics.PointVelocity.y Physics *= @s Physics.Object.Axis.x.y
            scoreboard players operation #Physics.PointVelocity.z Physics *= @s Physics.Object.Axis.x.z

            scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.PointVelocity.y Physics
            scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.PointVelocity.z Physics

        # Separating Velocity for ObjectA
            # Calculate relative contact point
            execute store result score #Physics.SeparatingVelocity.z Physics run scoreboard players operation #Physics.ContactPointCopy.x Physics -= #Physics.ThisObject Physics.Object.Pos.x
            execute store result score #Physics.SeparatingVelocity.x Physics run scoreboard players operation #Physics.ContactPointCopy.y Physics -= #Physics.ThisObject Physics.Object.Pos.y
            execute store result score #Physics.SeparatingVelocity.y Physics run scoreboard players operation #Physics.ContactPointCopy.z Physics -= #Physics.ThisObject Physics.Object.Pos.z

            # Calculate cross product between relative contact point and angular velocity
            # (Important): I overwrite the contact point scores here, as I don't need those values (relative to this object) anymore.
            scoreboard players operation #Physics.SeparatingVelocity.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.ContactPointCopy.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.SeparatingVelocity.x Physics -= #Physics.ContactPointCopy.z Physics
            scoreboard players operation #Physics.SeparatingVelocity.x Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.SeparatingVelocity.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.ContactPointCopy.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.SeparatingVelocity.y Physics -= #Physics.ContactPointCopy.x Physics
            scoreboard players operation #Physics.SeparatingVelocity.y Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.SeparatingVelocity.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.ContactPointCopy.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.SeparatingVelocity.z Physics -= #Physics.ContactPointCopy.y Physics
            scoreboard players operation #Physics.SeparatingVelocity.z Physics /= #Physics.Constants.1000 Physics

            # Add the linear velocity to obtain the relative velocity of the contact point
            scoreboard players operation #Physics.SeparatingVelocity.x Physics += #Physics.ThisObject Physics.Object.Velocity.x
            scoreboard players operation #Physics.SeparatingVelocity.y Physics += #Physics.ThisObject Physics.Object.Velocity.y
            scoreboard players operation #Physics.SeparatingVelocity.z Physics += #Physics.ThisObject Physics.Object.Velocity.z

            # Calculate the relative velocity's dot product with the contact normal to get the separation velocity (single number, not a vector) and store it
            # (Important): Because the contact normal scores (Physics.Object.Axis.?.?) are not adjusted to face away from the face, I may multiply the final result with -1.
            scoreboard players operation #Physics.SeparatingVelocity.x Physics *= @s Physics.Object.Axis.x.x
            scoreboard players operation #Physics.SeparatingVelocity.y Physics *= @s Physics.Object.Axis.x.y
            scoreboard players operation #Physics.SeparatingVelocity.z Physics *= @s Physics.Object.Axis.x.z

            scoreboard players operation #Physics.SeparatingVelocity.x Physics += #Physics.SeparatingVelocity.y Physics
            scoreboard players operation #Physics.SeparatingVelocity.x Physics += #Physics.SeparatingVelocity.z Physics

        # Add the separating velocities together
        # (Important): I also adjust the scale and invert the number here instead of doing it for both individual velocities.
        scoreboard players operation #Physics.SeparatingVelocity.x Physics -= #Physics.PointVelocity.x Physics
        execute if score #Physics.ObjectB.Feature Physics matches 100 run scoreboard players operation #Physics.SeparatingVelocity.x Physics *= #Physics.Constants.-1 Physics
        execute store result storage physics:temp data.NewContact.SeparatingVelocity int 1 run scoreboard players operation #Physics.SeparatingVelocity.x Physics /= #Physics.Constants.1000 Physics

# Store the new contact
# (Important): The values are stored in their scaled up form, just like how I need them to process them.
function physics:zprivate/contact_generation/new_contact/object/store with storage physics:temp data

# Process the separating velocity (Keep track of the most negative separating velocity for the current ObjectA, as well as global for all ObjectA's)
# (Important): The "#Physics.MinSeparatingVelocityTotal Physics" score keeps track of the overall most negative separating velocity across all ObjectA's, so I can efficiently target the most severe contact in contact resolution's 1st iteration.
execute store result score #Physics.MinSeparatingVelocity Physics run data get storage physics:zprivate data.ContactGroups[0].MinSeparatingVelocity
execute if score #Physics.MinSeparatingVelocity Physics <= #Physics.SeparatingVelocity.x Physics run return 0
execute if score #Physics.SeparatingVelocity.x Physics < #Physics.MinSeparatingVelocityTotal Physics store result storage physics:zprivate data.ContactGroups[0].MinSeparatingVelocity int 1 run return run scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics = #Physics.SeparatingVelocity.x Physics
execute store result storage physics:zprivate data.ContactGroups[0].MinSeparatingVelocity int 1 run scoreboard players get #Physics.SeparatingVelocity.x Physics
