# This assumes there's only ever a single contact with that exact min separating velocity. Would need to account for multiple, which adds additional overhead
$data modify storage physics:test Contact set from storage physics:test ContactGroups[].Objects[0].Blocks[].Contacts[{MinSeparatingVelocity:$(MinSep)s}]


# IMPORTANT: Make a 2nd macro that also selects the object and the block, so it doesn't have to check them all.
