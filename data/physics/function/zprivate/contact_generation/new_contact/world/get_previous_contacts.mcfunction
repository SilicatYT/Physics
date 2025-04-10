# Copy the previous tick's contacts for that block to a temporary storage & remove the entry that is copied over
# (Important): Because this function can also be run if there is no data for that block, the "data.Block" storage would keep the previous data, leading to bugs. So it's set to {} preemptively.
data modify storage physics:temp data.Block set value {}
$data modify storage physics:temp data.Block set from storage physics:temp data.Blocks[{Pos:$(Pos)}]
$data remove storage physics:temp data.Blocks[{Pos:$(Pos)}]
