# Invert contact normal & store contact
execute store result storage physics:temp data.NewContact.ContactNormal[1] int -1 run scoreboard players get #Physics.CrossProductAxis.xy.y Physics
execute store result storage physics:temp data.NewContact.ContactNormal[2] int -1 run scoreboard players get #Physics.CrossProductAxis.xy.z Physics

data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append from storage physics:temp data.NewContact
data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].SeparatingVelocity
data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactVelocity
