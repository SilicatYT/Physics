# x axis
$execute store result score #Physics.Projection.Block.WorldAxis.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Blocks[$(Index)].Pos[0]
scoreboard players operation #Physics.Projection.Block.WorldAxis.x.Min Physics -= #Physics.Global.MinPenetrationDepth.Offset Physics
scoreboard players operation #Physics.Projection.Block.WorldAxis.x.Max Physics += #Physics.Global.MinPenetrationDepth.Offset Physics

execute unless score #Physics.Projection.Block.WorldAxis.x.Min Physics <= @s Physics.Object.BoundingBoxGlobalMax.x run return 0
execute unless score @s Physics.Object.BoundingBoxGlobalMin.x <= #Physics.Projection.Block.WorldAxis.x.Max Physics run return 0

# y axis
$execute store result score #Physics.Projection.Block.WorldAxis.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Blocks[$(Index)].Pos[1]
scoreboard players operation #Physics.Projection.Block.WorldAxis.y.Min Physics -= #Physics.Global.MinPenetrationDepth.Offset Physics
scoreboard players operation #Physics.Projection.Block.WorldAxis.y.Max Physics += #Physics.Global.MinPenetrationDepth.Offset Physics

execute unless score #Physics.Projection.Block.WorldAxis.y.Min Physics <= @s Physics.Object.BoundingBoxGlobalMax.y run return 0
execute unless score @s Physics.Object.BoundingBoxGlobalMin.y <= #Physics.Projection.Block.WorldAxis.y.Max Physics run return 0

# z axis
$execute store result score #Physics.Projection.Block.WorldAxis.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Blocks[$(Index)].Pos[2]
scoreboard players operation #Physics.Projection.Block.WorldAxis.z.Min Physics -= #Physics.Global.MinPenetrationDepth.Offset Physics
scoreboard players operation #Physics.Projection.Block.WorldAxis.z.Max Physics += #Physics.Global.MinPenetrationDepth.Offset Physics

execute unless score #Physics.Projection.Block.WorldAxis.z.Min Physics <= @s Physics.Object.BoundingBoxGlobalMax.z run return 0
execute unless score @s Physics.Object.BoundingBoxGlobalMin.z <= #Physics.Projection.Block.WorldAxis.z.Max Physics run return 0

# Success: Carry over the contacts
$data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks append from storage physics:temp data.Blocks[$(Index)]
