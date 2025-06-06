# (Important): All the "reject the contact entirely" checks have to be run before the "keep the contact but mark it as invalid" checks.

# Check if the contact should be discarded
# (Important): Everything is cached, because there are only 8 possible corners.
# (Important): If the penetration depth is negative or the contact point is not inside the other object, the contact is just appended (so it can still be updated during resolution) without being updated. In that case, the separating velocity data is removed to avoid potential bugs.
    # Calculate the Penetration Depth
    $scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.BlockCornerBase$(FeatureB).ObjectAxis.y Physics
    scoreboard players operation #Physics.PenetrationDepth Physics += #Physics.Projection.BlockCenter.ObjectAxis.y Physics
    execute if score #Physics.Contact.FeatureA Physics matches 12 run scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.ProjectionOwnAxis.y.Min
    execute if score #Physics.Contact.FeatureA Physics matches 13 run scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.ProjectionOwnAxis.y.Max
    execute if score #Physics.Contact.FeatureA Physics matches 13 run scoreboard players operation #Physics.PenetrationDepth Physics *= #Physics.Constants.-1 Physics

    # Check if the Penetration Depth is within the threshold (Can be slightly negative)
    execute if score #Physics.PenetrationDepth Physics < #Physics.Settings.MinPenetrationDepth Physics run return 0

    # Check if the contact is still relevant
    # (Important): I project this contact's normal onto the current tick's contact's normal. If it's less than 70%, the contact is discarded completely for stability and performance reasons. If it's less than 90%, just carry over the contact without updating it (invalid contact).
    scoreboard players operation #Physics.DotProduct Physics = @s Physics.Object.Axis.y.x
    scoreboard players operation #Physics.DotProduct Physics *= #Physics.ContactNormal.x Physics

    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Axis.y.y
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ContactNormal.y Physics
    scoreboard players operation #Physics.DotProduct Physics += #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Axis.y.z
    scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.ContactNormal.z Physics
    scoreboard players operation #Physics.DotProduct Physics += #Physics.Maths.Value2 Physics

    execute if score #Physics.Contact.FeatureA Physics matches 12 run scoreboard players operation #Physics.DotProduct Physics *= #Physics.Constants.-1 Physics

    execute if score #Physics.DotProduct Physics matches ..700000 run return 0
    $execute if score #Physics.DotProduct Physics matches ..900000 run data modify storage physics:zprivate ContactGroups[-1].Objects[-1].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(FeatureB)b}
    execute if score #Physics.DotProduct Physics matches ..900000 store result storage physics:zprivate ContactGroups[-1].Objects[-1].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run return run scoreboard players get #Physics.Contact.FeatureA Physics

    # Check if the PenetrationDepth is negative
    $execute if score #Physics.PenetrationDepth Physics matches ..-1 run data modify storage physics:zprivate ContactGroups[-1].Objects[-1].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(FeatureB)b}
    execute if score #Physics.PenetrationDepth Physics matches ..-1 store result storage physics:zprivate ContactGroups[-1].Objects[-1].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run return run scoreboard players get #Physics.Contact.FeatureA Physics

    # Check if the Contact Corner is within the hitbox
    # (Important): This is necessary because the penetration depth could be positive even if the hitboxes aren't touching. So if they aren't touching, the contact should be ignored during resolution, but it should still be stored because we can't be sure whether the hitboxes are only slightly distanced or far away.
    # (Important): A point is within a cuboid when the point's projections onto the cuboid's 3 axes all lie within the cuboid's min and max.
    scoreboard players set #Physics.IsInside Physics 0
    execute if score #Physics.ContactCorner.x Physics <= @s Physics.Object.ProjectionOwnAxis.x.Max if score @s Physics.Object.ProjectionOwnAxis.x.Min <= #Physics.ContactCorner.x Physics if score #Physics.ContactCorner.y Physics <= @s Physics.Object.ProjectionOwnAxis.y.Max if score @s Physics.Object.ProjectionOwnAxis.y.Min <= #Physics.ContactCorner.y Physics if score #Physics.ContactCorner.z Physics <= @s Physics.Object.ProjectionOwnAxis.z.Max if score @s Physics.Object.ProjectionOwnAxis.z.Min <= #Physics.ContactCorner.z Physics run scoreboard players set #Physics.IsInside Physics 1
    $execute if score #Physics.IsInside Physics matches 0 run data modify storage physics:zprivate ContactGroups[-1].Objects[-1].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(FeatureB)b}
    execute if score #Physics.IsInside Physics matches 0 store result storage physics:zprivate ContactGroups[-1].Objects[-1].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run return run scoreboard players get #Physics.Contact.FeatureA Physics

# Update the MaxPenetrationDepth
execute if score #Physics.PenetrationDepth Physics > #Physics.MaxPenetrationDepthTotal Physics store result storage physics:zprivate ContactGroups[-1].MaxPenetrationDepth short 1 store result score #Physics.MaxPenetrationDepth Physics run scoreboard players operation #Physics.MaxPenetrationDepthTotal Physics = #Physics.PenetrationDepth Physics
execute if score #Physics.PenetrationDepth Physics > #Physics.MaxPenetrationDepth Physics store result storage physics:zprivate ContactGroups[-1].MaxPenetrationDepth short 1 run scoreboard players operation #Physics.MaxPenetrationDepth Physics = #Physics.PenetrationDepth Physics

# Update the contact
    # Get the corner position
    # (Important): Updates the contact point, contact normal and separating velocity if the penetration depth is positive.
    $execute if score #Physics.Contact.FeatureA Physics matches 12 run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/object_axis_y/get_corner_negative with storage physics:temp data.BlockCorner[$(FeatureB)]
    $execute if score #Physics.Contact.FeatureA Physics matches 13 run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/object_axis_y/get_corner_positive with storage physics:temp data.BlockCorner[$(FeatureB)]

    # Store the contact
    data modify storage physics:zprivate ContactGroups[-1].Objects[-1].Blocks[-1].Hitboxes[-1].Contacts append from storage physics:temp data.NewContact

# Update the MinSeparatingVelocity
execute if score #Physics.MinSeparatingVelocity Physics <= #Physics.PointVelocity.x Physics run return 0
execute if score #Physics.PointVelocity.x Physics < #Physics.MinSeparatingVelocityTotal Physics store result storage physics:zprivate ContactGroups[-1].MinSeparatingVelocity short 1 store result score #Physics.MinSeparatingVelocity Physics run return run scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics = #Physics.PointVelocity.x Physics
execute store result storage physics:zprivate ContactGroups[-1].MinSeparatingVelocity short 1 run scoreboard players operation #Physics.MinSeparatingVelocity Physics = #Physics.PointVelocity.x Physics
