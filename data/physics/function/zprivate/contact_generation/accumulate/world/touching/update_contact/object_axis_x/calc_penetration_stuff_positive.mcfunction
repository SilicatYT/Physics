# Append contact
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {ContactNormal:[I;0,0,0],ContactPoint:[I;0,0,0]}
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run scoreboard players get #Physics.Contact.FeatureA Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureB byte 1 run scoreboard players get #Physics.Contact.FeatureB Physics

# Get corner position
$execute store result score #Physics.ContactCorner.x Physics run scoreboard players operation #Physics.ContactPoint.x Physics = #Physics.Projection.Block.WorldAxis.x.$(x) Physics
$execute store result score #Physics.ContactCorner.y Physics run scoreboard players operation #Physics.ContactPoint.y Physics = #Physics.Projection.Block.WorldAxis.y.$(y) Physics
$execute store result score #Physics.ContactCorner.z Physics run scoreboard players operation #Physics.ContactPoint.z Physics = #Physics.Projection.Block.WorldAxis.z.$(z) Physics

# Update the penetration depth storage, contact normal, contact point & separating velocity
# (Important): Only update them if the penetration depth is positive.
    # Penetration Depth
    execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].PenetrationDepth short 1 run scoreboard players get #Physics.PenetrationDepth Physics

    # Contact Normal
    execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[0] int 1 run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Axis.x.x
    execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[1] int 1 run scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Axis.x.y
    execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[2] int 1 run scoreboard players operation #Physics.Maths.Value3 Physics = @s Physics.Object.Axis.x.z

    # Contact Point
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactPoint[0] int 1 run scoreboard players operation #Physics.ContactPoint.x Physics += #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactPoint[1] int 1 run scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.Maths.Value2 Physics

    scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactPoint[2] int 1 run scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.Maths.Value3 Physics
