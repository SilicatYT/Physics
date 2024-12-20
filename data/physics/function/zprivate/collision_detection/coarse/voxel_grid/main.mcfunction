# Set the BlockPos (= origin) of the first block I'm checking (which is at ~ ~ ~)
scoreboard players operation #Physics.Maths.BlockPos.x Physics.Value = @s Physics.Object.Pos.x
scoreboard players operation #Physics.Maths.BlockPos.y Physics.Value = @s Physics.Object.Pos.y
scoreboard players operation #Physics.Maths.BlockPos.z Physics.Value = @s Physics.Object.Pos.z

scoreboard players operation #Physics.Maths.BlockPos.x Physics.Value -= @s Physics.Object.BoundingBoxLocalMax.x
scoreboard players operation #Physics.Maths.BlockPos.y Physics.Value -= @s Physics.Object.BoundingBoxLocalMax.y
scoreboard players operation #Physics.Maths.BlockPos.z Physics.Value -= @s Physics.Object.BoundingBoxLocalMax.z

scoreboard players operation #Physics.Maths.BlockPos.x Physics.Value /= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BlockPos.y Physics.Value /= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BlockPos.z Physics.Value /= #Physics.Constants.1000 Physics.Value

scoreboard players operation #Physics.Maths.BlockPos.x Physics.Value *= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BlockPos.y Physics.Value *= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BlockPos.z Physics.Value *= #Physics.Constants.1000 Physics.Value

# Iterate through every single voxel that collides with the object's AABB
# Note: I could remove the $(Offset), but it would mean that either ~ or ~<StepCount> for any axis could be outside the bounding box, instead of only ~<StepCount>. This would require lots of score checks, even if it would make it cache a lot more. I don't think it's worth it, especially considering larger objects where the number of extra score checks would dramatically increase.
$execute positioned $(OffsetX) $(OffsetY) $(OffsetZ) run function physics:zprivate/collision_detection/coarse/voxel_grid/$(StepCountX)_$(StepCountY)_$(StepCountZ)
