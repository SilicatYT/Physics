# Store the new contact
# (Important): I store the contact with "merge", as "set" only works for the 1st contact of the ObjectB (Doesn't create any subsequent entries if they don't already exist).
$data modify storage physics:zprivate data.ContactGroups[-1].Objects[{B:$(B)}].Contacts[{FeatureA:$(FeatureA),FeatureB:$(FeatureB)}] merge from storage physics:temp data.NewContact
