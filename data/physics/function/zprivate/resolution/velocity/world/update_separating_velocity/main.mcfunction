# Iterate over every block (except the block that contains the current iteration's resolved contact) to update the respective hitboxes

# Block 1
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block {Index:-1b}
execute if score #Physics.BlockCount Physics matches 1 run return run data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[0]

# Block 2
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block {Index:-2b}
execute if score #Physics.BlockCount Physics matches 2 run return run data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[]

# Block 3
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block {Index:-3b}
execute if score #Physics.BlockCount Physics matches 3 run return run data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[]

# Block 4
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block {Index:-4b}
execute if score #Physics.BlockCount Physics matches 4 run return run data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[]

# Block 5
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block {Index:-5b}
execute if score #Physics.BlockCount Physics matches 5 run return run data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[]

# Block 6
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block {Index:-6b}
execute if score #Physics.BlockCount Physics matches 6 run return run data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[]

# Block 7
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block {Index:-7b}
execute if score #Physics.BlockCount Physics matches 7 run return run data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[]

# Block 8
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block {Index:-8b}
execute if score #Physics.BlockCount Physics matches 8 run return run data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[]

# Next loop
scoreboard players remove #Physics.BlockCount Physics 8
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[-1]
data remove storage physics:temp UpdateBlocks[-1]
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[-1]
data remove storage physics:temp UpdateBlocks[-1]
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[-1]
data remove storage physics:temp UpdateBlocks[-1]
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[-1]
data remove storage physics:temp UpdateBlocks[-1]
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[-1]
data remove storage physics:temp UpdateBlocks[-1]
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[-1]
data remove storage physics:temp UpdateBlocks[-1]
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[-1]
data remove storage physics:temp UpdateBlocks[-1]
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp UpdateBlocks[-1]
data remove storage physics:temp UpdateBlocks[-1]
function physics:zprivate/resolution/velocity/world/update_separating_velocity/main
