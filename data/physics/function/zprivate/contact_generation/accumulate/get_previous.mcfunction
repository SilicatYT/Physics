# Get all the contacts for the current object from the previous tick and copy them to a temporary storage
$data modify storage physics:temp data.ContactsPrevious set from storage physics:temp data.ContactGroupsPrevious[{A:$(A)}].Objects

# Append the world contacts to the current tick's final storage if they exist (To make sure the world contacts are always the 1st element)
execute unless data storage physics:temp data.ContactsPrevious[0].Blocks run return 0
data modify storage physics:temp data.Blocks set from storage physics:temp data.ContactsPrevious[0].Blocks
data remove storage physics:temp data.ContactsPrevious[0]
