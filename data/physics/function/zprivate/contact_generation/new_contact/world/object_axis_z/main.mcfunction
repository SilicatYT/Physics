# Get the object's feature (Face that's closest to the world-geometry block)
# (Important): There are 2 candidate faces (those normal to the axis), and I select the correct one by looking at the projection of a single point of them and looking which is closer. If I look at the same point for both faces, I can easily get which face is closer.
execute if score #Physics.Projection.Block.ObjectAxis.z.Min Physics < #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Min store result storage physics:temp data.NewContact.FeatureA byte 1 store result storage physics:temp data.FeatureA byte 1 run scoreboard players set #Physics.FeatureA Physics 14
execute if score #Physics.Projection.Block.ObjectAxis.z.Min Physics >= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Min store result storage physics:temp data.NewContact.FeatureA byte 1 store result storage physics:temp data.FeatureA byte 1 run scoreboard players set #Physics.FeatureA Physics 15

# Get the world-geometry block's feature (Corner that's closest to the object)
# (Important): I check which of the 8 corners' projection is the closest to the object along the axis (furthest along the axis), so I have to get either the min or the max.
execute if score #Physics.FeatureA Physics matches 14 run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics
execute if score #Physics.FeatureA Physics matches 15 run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.BlockBase.ObjectAxis.z.Min Physics

    # Set the feature
    # (Important): There are only 8 corners (and unique macro variable combinations), so everything is cached. Reduces duplicate files.
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase0.ObjectAxis.z Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_z/get_corner {Corner:0,x:"Min",y:"Min",z:"Min"}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase1.ObjectAxis.z Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_z/get_corner {Corner:1,x:"Min",y:"Min",z:"Max"}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase2.ObjectAxis.z Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_z/get_corner {Corner:2,x:"Max",y:"Min",z:"Min"}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase3.ObjectAxis.z Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_z/get_corner {Corner:3,x:"Max",y:"Min",z:"Max"}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase4.ObjectAxis.z Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_z/get_corner {Corner:4,x:"Min",y:"Max",z:"Min"}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase5.ObjectAxis.z Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_z/get_corner {Corner:5,x:"Min",y:"Max",z:"Max"}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase6.ObjectAxis.z Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_z/get_corner {Corner:6,x:"Max",y:"Max",z:"Min"}
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase7.ObjectAxis.z Physics run function physics:zprivate/contact_generation/new_contact/world/object_axis_z/get_corner {Corner:7,x:"Max",y:"Max",z:"Max"}

# Calculate Penetration Depth, Contact Normal, Contact Point & Separating Velocity
    # Penetration Depth
    # (Important): For point-face collisions, the penetration depth is the projection of (point - <any point on the face>) onto the contact normal. It's distributive, so I can also subtract the projection of any point on the face from the (already calculated) projection of the corner.
    # (Important): Calculations are done in "get_corner/..." to avoid redundant score checks and to utilize "return run".

    # Contact Normal
    # (Important): For point-face collisions, the contact normal is the face's normal. So it's the axis of minimum overlap.

    # Contact Point
    # (Important): For point-face collisions, the contact point is the point projected onto the surface (= moved along contact normal with the penetration depth as the amount).
    # (Important): I use the "execute store" from earlier to avoid an additional scoreboard call. Also, the point's coordinates are copied over in "get_corner/...".
    # (Important): I need to invert the contact normal scores so they always face away from the face, but instead I invert the penetration depth. This is faster, and I don't need the score later anyway.
    execute if score #Physics.FeatureA Physics matches 14 run scoreboard players operation #Physics.PenetrationDepth Physics *= #Physics.Constants.-1 Physics

    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 run scoreboard players operation #Physics.ContactPoint.x Physics += #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.Maths.Value2 Physics

    scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.NewContact.ContactPoint[2] int 1 run scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.Maths.Value3 Physics

    # Separating Velocity
    # (Important): The separating velocity is the dot product between the contact point's relative velocity and the contact normal. The relative velocity is the cross product between the angular velocity and the contact point (relative to the object's center) that's added together with the object's linear velocity.
        # Calculate relative contact point
        execute store result score #Physics.PointVelocity.z Physics run scoreboard players operation #Physics.ContactPoint.x Physics -= #Physics.ThisObject Physics.Object.Pos.x
        execute store result score #Physics.PointVelocity.x Physics run scoreboard players operation #Physics.ContactPoint.y Physics -= #Physics.ThisObject Physics.Object.Pos.y
        execute store result score #Physics.PointVelocity.y Physics run scoreboard players operation #Physics.ContactPoint.z Physics -= #Physics.ThisObject Physics.Object.Pos.z

        # Calculate cross product between angular velocity and relative contact point
        # (Important): I overwrite the contact point scores here, as I don't need them anymore after this.
        # (Important): I messed up the order (relativeContactPoint x angularVelocity instead of angularVelocity x relativeContactPoint). To accomodate for that without spending hours rewriting it, I divide by -1000 instead of 1000.
        # (Important): ContactVelocity is B - A, so I invert the calculations again so the SeparatingVelocity is really just the projection of the ContactVelocity (uniformly).
        scoreboard players operation #Physics.PointVelocity.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
        scoreboard players operation #Physics.ContactPoint.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
        scoreboard players operation #Physics.PointVelocity.x Physics -= #Physics.ContactPoint.z Physics
        scoreboard players operation #Physics.PointVelocity.x Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.PointVelocity.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
        scoreboard players operation #Physics.ContactPoint.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
        scoreboard players operation #Physics.PointVelocity.y Physics -= #Physics.ContactPoint.x Physics
        scoreboard players operation #Physics.PointVelocity.y Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.PointVelocity.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
        scoreboard players operation #Physics.ContactPoint.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
        scoreboard players operation #Physics.PointVelocity.z Physics -= #Physics.ContactPoint.y Physics
        scoreboard players operation #Physics.PointVelocity.z Physics /= #Physics.Constants.1000 Physics

        # Subtract velocity from acceleration along contact normal
        # (Important): Normally you just subtract it from SeparatingVelocity so that ContactVelocity remains intact (the tangents need to be untouched!), but if I subtract the projection from both, then I don't have to repeatedly do that during each iteration of resolution.
        # (Important): I project the VelocityFromAcceleration (currently only gravity) onto the contactNormal. Then I multiply this scalar with the ContactNormal, and subtract this new vector from the ContactVelocity. This means the SeparatingVelocity will already be adjusted once it's calculated, and I don't have to apply the projection every time it resolves a contact.
        scoreboard players operation #Physics.VelocityFromAcceleration.y Physics = #Physics.ThisObject Physics.Object.DefactoGravity
        scoreboard players operation #Physics.VelocityFromAcceleration.y Physics *= #Physics.ContactNormal.y Physics
        execute store result score #Physics.SubtractVector.x Physics store result score #Physics.SubtractVector.y Physics store result score #Physics.SubtractVector.z Physics run scoreboard players operation #Physics.VelocityFromAcceleration.y Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.SubtractVector.x Physics *= #Physics.ContactNormal.x Physics
        scoreboard players operation #Physics.SubtractVector.y Physics *= #Physics.ContactNormal.y Physics
        scoreboard players operation #Physics.SubtractVector.z Physics *= #Physics.ContactNormal.z Physics
        scoreboard players operation #Physics.SubtractVector.x Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.SubtractVector.y Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.SubtractVector.z Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.SubtractVector.x Physics
        scoreboard players operation #Physics.PointVelocity.y Physics += #Physics.SubtractVector.y Physics
        scoreboard players operation #Physics.PointVelocity.z Physics += #Physics.SubtractVector.z Physics

        # Add the linear velocity to obtain the relative velocity of the contact point
        execute store result storage physics:temp data.NewContact.ContactVelocity[0] int 1 run scoreboard players operation #Physics.PointVelocity.x Physics -= #Physics.ThisObject Physics.Object.Velocity.x
        execute store result storage physics:temp data.NewContact.ContactVelocity[1] int 1 run scoreboard players operation #Physics.PointVelocity.y Physics -= #Physics.ThisObject Physics.Object.Velocity.y
        execute store result storage physics:temp data.NewContact.ContactVelocity[2] int 1 run scoreboard players operation #Physics.PointVelocity.z Physics -= #Physics.ThisObject Physics.Object.Velocity.z

        # Calculate the relative velocity's dot product with the contact normal to get the separation velocity (single number, not a vector) and store it
        # (Important): Now, I multiply by ContactNormal, not by Object.Axis.?. Because of this, I now *always* invert the SeparatingVelocity, which I do by dividing by -1000 instead of 1000.
        scoreboard players operation #Physics.PointVelocity.x Physics *= #Physics.ContactNormal.x Physics
        scoreboard players operation #Physics.PointVelocity.y Physics *= #Physics.ContactNormal.y Physics
        scoreboard players operation #Physics.PointVelocity.z Physics *= #Physics.ContactNormal.z Physics

        scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.PointVelocity.y Physics
        scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.PointVelocity.z Physics

        execute store result storage physics:temp data.NewContact.SeparatingVelocity short 1 run scoreboard players operation #Physics.PointVelocity.x Physics /= #Physics.Constants.1000 Physics

# Store the contact
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append from storage physics:temp data.NewContact

# Update the MaxPenetrationDepth (& keep track of the contact with the MaxPenetrationDepth)
# (Important): The contact with the MaxPenetrationDepth has "HasMaxPenetrationDepth:0b" instead of 1b so the "store result storage ..." command works even if the command afterwards (to remove the previously tagged contact's tag) fails.
execute if score #Physics.PenetrationDepth Physics > #Physics.ThisObject Physics.Object.MaxPenetrationDepth store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].HasMaxPenetrationDepth byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[{HasMaxPenetrationDepth:0b}].HasMaxPenetrationDepth
execute if score #Physics.PenetrationDepth Physics > #Physics.ThisObject Physics.Object.MaxPenetrationDepth run scoreboard players operation #Physics.ThisObject Physics.Object.MaxPenetrationDepth = #Physics.PenetrationDepth Physics

# Process the separating velocity (Keep track of the most negative separating velocity for the current ObjectA & tag the contact with the lowest value)
# (Important): The contact with the MinSeparatingVelocity has "HasMinSeparatingVelocity:0b" for the same reason as "HasMaxPenetrationDepth".
execute if score #Physics.PointVelocity.x Physics >= #Physics.ThisObject Physics.Object.MinSeparatingVelocity run return 0
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].HasMinSeparatingVelocity byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[{HasMinSeparatingVelocity:0b}].HasMinSeparatingVelocity
scoreboard players operation #Physics.ThisObject Physics.Object.MinSeparatingVelocity = #Physics.PointVelocity.x Physics
