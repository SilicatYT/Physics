# (Important): All the "reject the contact entirely" checks have to be run before the "keep the contact but mark it as invalid" checks.

# Check if the contact should be discarded
# (Important): Everything is cached, because there are only 8 possible corners.
# (Important): If the penetration depth is negative or the contact point is not inside the other object, the contact is just appended (so it can still be updated during resolution) without being updated. In that case, the separating velocity data is removed to avoid potential bugs.
    # Calculate the Penetration Depth
    $scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.BlockCornerBase$(FeatureB).ObjectAxis.x Physics
    scoreboard players operation #Physics.PenetrationDepth Physics += #Physics.Projection.BlockCenter.ObjectAxis.x Physics
    execute if score #Physics.Contact.FeatureA Physics matches 10 run scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.ProjectionOwnAxis.x.Min
    execute if score #Physics.Contact.FeatureA Physics matches 11 run scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.ProjectionOwnAxis.x.Max
    execute if score #Physics.Contact.FeatureA Physics matches 11 run scoreboard players operation #Physics.PenetrationDepth Physics *= #Physics.Constants.-1 Physics

    # Check if the Penetration Depth is within the threshold (Can be slightly negative)
    execute if score #Physics.PenetrationDepth Physics < #Physics.Settings.MinPenetrationDepth Physics run return 0

    # Check if the contact is still relevant
    # (Important): I project this contact's normal onto the current tick's contact's normal. If it's less than 70%, the contact is discarded completely for stability and performance reasons. If it's less than 90%, just carry over the contact without updating it (invalid contact).
    scoreboard players operation #Physics.DotProduct Physics = @s Physics.Object.Axis.x.x
    scoreboard players operation #Physics.DotProduct Physics *= #Physics.ContactNormal.x Physics

    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Axis.x.y
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ContactNormal.y Physics
    scoreboard players operation #Physics.DotProduct Physics += #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Axis.x.z
    scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.ContactNormal.z Physics
    scoreboard players operation #Physics.DotProduct Physics += #Physics.Maths.Value2 Physics

    execute if score #Physics.Contact.FeatureA Physics matches 10 run scoreboard players operation #Physics.DotProduct Physics *= #Physics.Constants.-1 Physics

    execute if score #Physics.DotProduct Physics matches ..700000 run return 0
    $execute if score #Physics.DotProduct Physics matches ..900000 run data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(FeatureB)b}
    execute if score #Physics.DotProduct Physics matches ..900000 store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run return run scoreboard players get #Physics.Contact.FeatureA Physics

    # Check if the PenetrationDepth is negative
    $execute if score #Physics.PenetrationDepth Physics matches ..-1 run data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(FeatureB)b}
    execute if score #Physics.PenetrationDepth Physics matches ..-1 store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run return run scoreboard players get #Physics.Contact.FeatureA Physics

    # Check if the Contact Corner is within the hitbox
    # (Important): This is necessary because the penetration depth could be positive even if the hitboxes aren't touching. So if they aren't touching, the contact should be ignored during resolution, but it should still be stored because we can't be sure whether the hitboxes are only slightly distanced or far away.
    # (Important): A point is within a cuboid when the point's projections onto the cuboid's 3 axes all lie within the cuboid's min and max.
    scoreboard players set #Physics.IsInside Physics 0
    execute if score #Physics.ContactCorner.x Physics <= @s Physics.Object.ProjectionOwnAxis.x.Max if score @s Physics.Object.ProjectionOwnAxis.x.Min <= #Physics.ContactCorner.x Physics if score #Physics.ContactCorner.y Physics <= @s Physics.Object.ProjectionOwnAxis.y.Max if score @s Physics.Object.ProjectionOwnAxis.y.Min <= #Physics.ContactCorner.y Physics if score #Physics.ContactCorner.z Physics <= @s Physics.Object.ProjectionOwnAxis.z.Max if score @s Physics.Object.ProjectionOwnAxis.z.Min <= #Physics.ContactCorner.z Physics run scoreboard players set #Physics.IsInside Physics 1
    $execute if score #Physics.IsInside Physics matches 0 run data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(FeatureB)b}
    execute if score #Physics.IsInside Physics matches 0 store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run return run scoreboard players get #Physics.Contact.FeatureA Physics

# Update the contact
    # Get the corner position
    # (Important): Updates the contact point, contact normal and separating velocity if the penetration depth is positive.
    $execute if score #Physics.Contact.FeatureA Physics matches 10 run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/object_axis_x/get_corner_negative with storage physics:temp data.BlockCorner[$(FeatureB)]
    $execute if score #Physics.Contact.FeatureA Physics matches 11 run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/object_axis_x/get_corner_positive with storage physics:temp data.BlockCorner[$(FeatureB)]

    # Store the contact
    data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append from storage physics:temp data.NewContact

# Update the MaxPenetrationDepth (& keep track of the contact with the MaxPenetrationDepth)
# (Important): The contact with the MaxPenetrationDepth has "HasMaxPenetrationDepth:0b" instead of 1b so the "store result storage ..." command works even if the command afterwards (to remove the previously tagged contact's tag) fails.
execute if score #Physics.PenetrationDepth Physics > @s Physics.Object.MaxPenetrationDepth store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].HasMaxPenetrationDepth byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[{HasMaxPenetrationDepth:0b}].HasMaxPenetrationDepth
execute if score #Physics.PenetrationDepth Physics > @s Physics.Object.MaxPenetrationDepth run scoreboard players operation @s Physics.Object.MaxPenetrationDepth = #Physics.PenetrationDepth Physics

# Process the separating velocity (Keep track of the most negative separating velocity for the current ObjectA & tag the contact with the lowest value)
# (Important): The contact with the MinSeparatingVelocity has "HasMinSeparatingVelocity:0b" for the same reason as "HasMaxPenetrationDepth".
execute if score #Physics.PointVelocity.x Physics >= @s Physics.Object.MinSeparatingVelocity run return 0
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].HasMinSeparatingVelocity byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[{HasMinSeparatingVelocity:0b}].HasMinSeparatingVelocity
scoreboard players operation @s Physics.Object.MinSeparatingVelocity = #Physics.PointVelocity.x Physics
