# Check if the contact should be discarded
# (Important): Everything is cached, because there are only 8 possible corners.
    # Calculate the Penetration Depth
    $execute if score #Physics.Contact.FeatureB Physics matches 12 run scoreboard players operation #Physics.PenetrationDepth Physics = @s Physics.Object.CornerPosGlobal.$(FeatureA).y
    execute if score #Physics.Contact.FeatureB Physics matches 12 run scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.Projection.Block.WorldAxis.y.Min Physics
    execute if score #Physics.Contact.FeatureB Physics matches 13 run scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.Block.WorldAxis.y.Max Physics
    $execute if score #Physics.Contact.FeatureB Physics matches 13 run scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.CornerPosGlobal.$(FeatureA).y

    # Check if the Penetration Depth is within the threshold (Can be slightly negative)
    execute if score #Physics.PenetrationDepth Physics < #Physics.Global.MinPenetrationDepth Physics run return 0

# Update the contact
    # Update the Penetration Depth & Contact Normal
    execute store result storage physics:temp data.NewContact.PenetrationDepth short 1 run scoreboard players get #Physics.PenetrationDepth Physics

    # Update the Contact Point & Contact Normal
    # (Important): The ContactPoint is not set with the earlier FeatureB check because of the "early out". I don't want to run too many commands if the contact is thrown out anyway.
    data modify storage physics:temp data.NewContact.ContactNormal set value [I;0,-1000,0]
    $execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 run scoreboard players operation #Physics.ContactPoint.x Physics = @s Physics.Object.CornerPosGlobal.$(FeatureA).x
    execute if score #Physics.Contact.FeatureB Physics matches 12 store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players get #Physics.Projection.Block.WorldAxis.y.Min Physics
    execute if score #Physics.Contact.FeatureB Physics matches 13 store success storage physics:temp data.NewContact.ContactNormal[1] int 1000 store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players get #Physics.Projection.Block.WorldAxis.y.Max Physics
    $execute store result storage physics:temp data.NewContact.ContactPoint[2] int 1 run scoreboard players operation #Physics.ContactPoint.z Physics = @s Physics.Object.CornerPosGlobal.$(FeatureA).z

    # Update the Separating Velocity
        # Calculate relative contact point
        scoreboard players operation #Physics.ContactPoint.x Physics -= @s Physics.Object.Pos.x
        scoreboard players operation #Physics.ContactPoint.z Physics -= @s Physics.Object.Pos.z

        # Calculate cross product between relative contact point and angular velocity
        scoreboard players operation #Physics.ContactPoint.z Physics *= @s Physics.Object.AngularVelocity.x
        scoreboard players operation #Physics.ContactPoint.x Physics *= @s Physics.Object.AngularVelocity.z
        scoreboard players operation #Physics.ContactPoint.z Physics -= #Physics.ContactPoint.x Physics
        scoreboard players operation #Physics.ContactPoint.z Physics /= #Physics.Constants.1000 Physics

        # Add the linear velocity to obtain the relative velocity of the contact point
        scoreboard players operation #Physics.ContactPoint.z Physics += @s Physics.Object.Velocity.y

        # Take the dot product with the contact normal
        execute if score #Physics.FeatureB Physics matches 12 run scoreboard players operation #Physics.ContactPoint.z Physics *= #Physics.Constants.-1 Physics
        execute store result storage physics:temp data.NewContact.SeparatingVelocity short 1 run scoreboard players get #Physics.ContactPoint.z Physics

    # Store the contact
    data modify storage physics:zprivate data.ContactGroups[-1].Objects[-1].Blocks[-1].Hitboxes[-1].Contacts append from storage physics:temp data.NewContact

# Check if the Contact Point is within the hitbox
# (Important): This is necessary because the penetration depth could be positive even if the hitboxes aren't touching. So if they aren't touching, the contact should be ignored during resolution, but it should still be stored because we can't be sure whether the hitboxes are only slightly distanced or far away.
# (Important): A point is within a cuboid when the point's projections onto the cuboid's 3 axes all lie within the cuboid's min and max.
# (Important): The contact point's y component is defined to be the min or max, so I don't have to check for that.
scoreboard players set #Physics.IsInside Physics 0
$execute if score #Physics.Projection.Block.WorldAxis.x.Min Physics <= @s Physics.Object.CornerPosGlobal.$(FeatureA).x if score @s Physics.Object.CornerPosGlobal.$(FeatureA).x <= #Physics.Projection.Block.WorldAxis.x.Max Physics if score #Physics.Projection.Block.WorldAxis.z.Min Physics <= @s Physics.Object.CornerPosGlobal.$(FeatureA).z if score @s Physics.Object.CornerPosGlobal.$(FeatureA).z <= #Physics.Projection.Block.WorldAxis.z.Max Physics run scoreboard players set #Physics.IsInside Physics 1
execute if score #Physics.IsInside Physics matches 0 run return run data modify storage physics:zprivate data.ContactGroups[-1].Objects[-1].Blocks[-1].Hitboxes[-1].Contacts[-1].Invalid set value 1b

# Update the MinSeparatingVelocity
execute if score #Physics.MinSeparatingVelocity Physics <= #Physics.ContactPoint.z Physics run return 0
execute if score #Physics.ContactPoint.z Physics < #Physics.MinSeparatingVelocityTotal Physics store result storage physics:zprivate data.ContactGroups[-1].MinSeparatingVelocity short 1 store result score #Physics.MinSeparatingVelocity Physics run return run scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics = #Physics.ContactPoint.z Physics
execute store result storage physics:zprivate data.ContactGroups[-1].MinSeparatingVelocity short 1 run scoreboard players operation #Physics.MinSeparatingVelocity Physics = #Physics.ContactPoint.z Physics
