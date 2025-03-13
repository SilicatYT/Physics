# Copy the previous tick's contacts for that block to a temporary storage & remove the entry that is copied over
$data modify storage physics:temp data.Block set from storage physics:temp data.Blocks[{Pos:$(Pos)}]
$data remove storage physics:temp data.Blocks[{Pos:$(Pos)}]
