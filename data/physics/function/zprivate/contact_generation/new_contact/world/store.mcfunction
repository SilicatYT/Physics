# Store the new contact
# (Important): I store the contact with "merge", as "set" only works for the 1st contact of the Block (Doesn't create any subsequent entries if they don't already exist).
# (Important): It also updates the block's hitbox data and sets "InContact" to 1b, so I know that I don't have to update its hitbox data when updating the block's contacts. As I only add a single contact per block per tick, this logic also only runs once per block.
# (Important): This could be optimized in the future (it runs 2 macros even if there are only few blocks).
$data modify storage physics:temp data.Blocks[{Pos:$(Pos)}].Contacts[{FeatureA:$(FeatureA),FeatureB:$(FeatureB)}] merge from storage physics:temp data.NewContact
$data modify storage physics:temp data.Blocks[{Pos:$(Pos)}].Hitbox set from storage physics:temp data.Hitbox

# TODO: The hitbox command still needs to be changed (According to the new pseudocode)
