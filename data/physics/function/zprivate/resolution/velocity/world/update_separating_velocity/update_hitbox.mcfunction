# Iterate over every contact of the current hitbox to update its ContactVelocity and SeparatingVelocity
# (Important): Just like in accumulation, I decided that 6 contacts per hitbox is the upper limit, so I don't need recursion.

# Contact 1
$data get storage physics:temp UpdateBlocks[$(Index)].Hitboxes[0]
#waait, I can't access the block now. I need to copy the hitbox somewhere

# TODO: Do hitbox 1 in the main function to avoid a function call if only 1 hitbox is present


# Note: At most 6 contacts per hitbox
