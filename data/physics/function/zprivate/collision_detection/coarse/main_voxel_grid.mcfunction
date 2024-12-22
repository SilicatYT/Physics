# Set the BlockPos (= origin) of the first block I'm checking (which is at ~ ~ ~)
# (Important): The BlockPos is at the center of the block, so I need to offset the BoundingBoxLimit by half a block as well
scoreboard players operation #Physics.Maths.BlockPos.x Physics.Value = @s Physics.Object.BoundingBoxGlobalMin.x
scoreboard players operation #Physics.Maths.BlockPos.y Physics.Value = @s Physics.Object.BoundingBoxGlobalMin.y
scoreboard players operation #Physics.Maths.BlockPos.z Physics.Value = @s Physics.Object.BoundingBoxGlobalMin.z

scoreboard players operation #Physics.Maths.BlockPos.x Physics.Value /= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BlockPos.y Physics.Value /= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BlockPos.z Physics.Value /= #Physics.Constants.1000 Physics.Value

scoreboard players operation #Physics.Maths.BlockPos.x Physics.Value *= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BlockPos.y Physics.Value *= #Physics.Constants.1000 Physics.Value
scoreboard players operation #Physics.Maths.BlockPos.z Physics.Value *= #Physics.Constants.1000 Physics.Value

scoreboard players add #Physics.Maths.BlockPos.x Physics.Value 500
scoreboard players add #Physics.Maths.BlockPos.y Physics.Value 500
scoreboard players add #Physics.Maths.BlockPos.z Physics.Value 500

scoreboard players operation #Physics.Maths.BoundingBoxLimit.x Physics.Value = @s Physics.Object.BoundingBoxGlobalMax.x
scoreboard players operation #Physics.Maths.BoundingBoxLimit.y Physics.Value = @s Physics.Object.BoundingBoxGlobalMax.y
scoreboard players operation #Physics.Maths.BoundingBoxLimit.z Physics.Value = @s Physics.Object.BoundingBoxGlobalMax.z

scoreboard players add #Physics.Maths.BoundingBoxLimit.x Physics.Value 500
scoreboard players add #Physics.Maths.BoundingBoxLimit.y Physics.Value 500
scoreboard players add #Physics.Maths.BoundingBoxLimit.z Physics.Value 500

# Iterate through every single voxel that collides with the object's AABB
# Note: I could remove the $(Offset), but it would mean that either ~ or ~<StepCount> for any axis could be outside the bounding box, instead of only ~<StepCount>. This would require lots of score checks, even if it would make it cache a lot more. I don't think it's worth it, especially considering larger objects where the number of extra score checks would dramatically increase.
$execute positioned $(StartX) $(StartY) $(StartZ) run function physics:zprivate/collision_detection/coarse/voxel_grid/$(StepCountX)_$(StepCountY)_$(StepCountZ)
