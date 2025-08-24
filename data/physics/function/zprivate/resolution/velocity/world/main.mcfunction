# Get the block data that contains the contact to be resolved & remove the original
data modify storage physics:resolution Block set from storage physics:resolution Object.Objects[0].Blocks[{Hitboxes:[{Contacts:[{HasMinSeparatingVelocity:0b}]}]}]
data remove storage physics:resolution Object.Objects[0].Blocks[{Hitboxes:[{Contacts:[{HasMinSeparatingVelocity:0b}]}]}]

# Repeat for the hitbox
data modify storage physics:resolution Hitbox set from storage physics:resolution Block.Hitboxes[{Contacts:[{HasMinSeparatingVelocity:0b}]}]
data remove storage physics:resolution Block.Hitboxes[{Contacts:[{HasMinSeparatingVelocity:0b}]}]

# Get the contact to be resolved & remove the original
data modify storage physics:resolution Contact set from storage physics:resolution Hitbox.Contacts[{HasMinSeparatingVelocity:0b}]
data remove storage physics:resolution Hitbox.Contacts[{HasMinSeparatingVelocity:0b}]

# Resolve the contact
# x
