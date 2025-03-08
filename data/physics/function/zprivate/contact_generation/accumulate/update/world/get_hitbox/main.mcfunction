# Get block hitbox and check if it still exists
execute store result storage physics:temp data.BlockPos.x double 0.001 run data get storage physics:temp data.Blocks[-1].Pos[0]
execute store result storage physics:temp data.BlockPos.y double 0.001 run data get storage physics:temp data.Blocks[-1].Pos[1]
execute store result storage physics:temp data.BlockPos.z double 0.001 run data get storage physics:temp data.Blocks[-1].Pos[2]

function physics:zprivate/contact_generation/accumulate/update/world/get_hitbox/get with storage physics:temp data.BlockPos
