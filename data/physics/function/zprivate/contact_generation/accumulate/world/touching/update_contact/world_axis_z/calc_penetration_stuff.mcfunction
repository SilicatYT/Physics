# Append the contact
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {ContactNormal:[I;0,0,-1000],ContactPoint:[I;0,0,0]}
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run scoreboard players get #Physics.Contact.FeatureA Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureB byte 1 run scoreboard players get #Physics.Contact.FeatureB Physics

# Update the Penetration Depth
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].PenetrationDepth short 1 run scoreboard players get #Physics.PenetrationDepth Physics

# Update the Contact Point & Contact Normal
# (Important): The ContactPoint is not set with the earlier FeatureB check because of the "early out". I don't want to run too many commands if the contact is thrown out anyway.
$execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactPoint[0] int 1 run scoreboard players get #Physics.ThisObject Physics.Object.CornerPosGlobal.$(FeatureA).x
$execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactPoint[1] int 1 run scoreboard players get #Physics.ThisObject Physics.Object.CornerPosGlobal.$(FeatureA).y
execute if score #Physics.Contact.FeatureB Physics matches 14 store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactPoint[2] int 1 run return run scoreboard players get #Physics.Projection.Block.WorldAxis.z.Min Physics
execute store success storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[2] int 1000 store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactPoint[21] int 1 run scoreboard players get #Physics.Projection.Block.WorldAxis.z.Max Physics
