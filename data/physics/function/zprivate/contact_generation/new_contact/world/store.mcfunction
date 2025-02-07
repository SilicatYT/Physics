# Store the new contact
$data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[{Pos:$(Pos)}].Contacts[{FeatureA:$(FeatureA),FeatureB:$(FeatureB)}] set from storage physics:temp data.NewContact
