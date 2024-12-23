execute store result storage test:test data.x double 0.001 run scoreboard players get #Physics.BlockPos.x Physics
execute store result storage test:test data.y double 0.001 run scoreboard players get #Physics.BlockPos.y Physics
execute store result storage test:test data.z double 0.001 run scoreboard players get #Physics.BlockPos.z Physics
function physics:zprivate/collision_detection/voxel_grid/spawn_particle_2 with storage test:test data

# Note: All axis-vectors need to be normalized, including the cross product axes
# Note: Precalculation - The projection of the object onto the world-geometry voxel's 3 axes is the same as the object's min and max values for those axes, so the min and max of the bounding box.
# Note: Precalculation - The projection of the object onto its own 3 axes is -(dimension/2) for the min, and (dimension/2) for the max. Then just add the object center's projection onto the same axis to those min and max values.
# Note: Precalculation - The projection of a world-geometry voxel onto its own 3 axes is the same as the object's min and max. The value stored in the BlockPos score is the block's center, so to get the min and max I add or subtract 0.5 (or 500 in this case, because it's scaled by 1,000x).
# Note: Precalculation - The 9 cross products between the 3 axes of the object and the world-geometry voxel can be precalculated once, as every voxel is not rotated.
# Note: Precalculation - The projection of the object onto the 9 cross product axes can be done once in total, as it stays constant throughout the tick.
# Note: Precalculation - The projection of the world-geometry voxel onto the 9 cross product axes and the axes of the object has to be done for each cube, but there's a trick: Precompute the projection of all 8 corner points of the voxel onto the axes, using only coordinates relative to the position of the cube (in this case the cube center, not the coordinate origin), then precompute the min and max for each axis. Then, for each voxel, add its position to the precomputed min and max values. If the voxel position were the coordinate origin, one of the voxel's corners would always be at [0, 0, 0], relatively speaking. So I wouldn't have to project that one onto the axes, as it would always result in [0, 0, 0]. But overall it's faster to use the center position, because then I only have to project half the corner points onto each axis, calculate the max, and then just change the sign to get the min for each axis.

# Perform the Separating Axes Theorem (Simplified with pre-calculated values) to get whether there's a collision, the depth of the collision and what kind it is (Edge-Edge, Point-Face)
    # Check the different axes
        # x_block
            # Projection: Block
            execute store result score #Physics.Projection.Voxel.WorldAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Voxel.WorldAxis.x.Min Physics = #Physics.BlockPos.x Physics
            scoreboard players remove #Physics.Projection.Voxel.WorldAxis.x.Min Physics 500
            scoreboard players add #Physics.Projection.Voxel.WorldAxis.x.Min Physics 500

            # Projection: Object (= Global Bounding Box)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.WorldAxis.x.Min Physics <= @s Physics.Object.BoundingBoxGlobalMax.x run return 0
            execute unless score @s Physics.Object.BoundingBoxGlobalMin.x <= #Physics.Projection.Voxel.WorldAxis.x.Max Physics run return 0

        # y_block
            # Projection: Block
            execute store result score #Physics.Projection.Voxel.WorldAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Voxel.WorldAxis.y.Min Physics = #Physics.BlockPos.y Physics
            scoreboard players remove #Physics.Projection.Voxel.WorldAxis.y.Min Physics 500
            scoreboard players add #Physics.Projection.Voxel.WorldAxis.y.Min Physics 500

            # Projection: Object (= Global Bounding Box)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.WorldAxis.y.Min Physics <= @s Physics.Object.BoundingBoxGlobalMax.y run return 0
            execute unless score @s Physics.Object.BoundingBoxGlobalMin.y <= #Physics.Projection.Voxel.WorldAxis.y.Max Physics run return 0

        # z_block
            # Projection: Block
            execute store result score #Physics.Projection.Voxel.WorldAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Voxel.WorldAxis.z.Min Physics = #Physics.BlockPos.z Physics
            scoreboard players remove #Physics.Projection.Voxel.WorldAxis.z.Min Physics 500
            scoreboard players add #Physics.Projection.Voxel.WorldAxis.z.Min Physics 500

            # Projection: Object (= Global Bounding Box)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.WorldAxis.z.Min Physics <= @s Physics.Object.BoundingBoxGlobalMax.z run return 0
            execute unless score @s Physics.Object.BoundingBoxGlobalMin.z <= #Physics.Projection.Voxel.WorldAxis.z.Max Physics run return 0

        # x_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Min Physics = #Physics.Projection.VoxelBase.ObjectAxis.x.Min Physics
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics = #Physics.Projection.VoxelBase.ObjectAxis.x.Max Physics

                # Project the center pos and add the projection to the min and max
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                scoreboard players operation #Physics.Projection.VoxelCenter.ObjectAxis.x Physics = #Physics.BlockPos.x Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.ObjectAxis.x Physics *= @s Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockPos.y Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.VoxelCenter.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
                scoreboard players operation #Physics.Projection.VoxelCenter.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.VoxelCenter.ObjectAxis.x Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Min Physics += #Physics.Projection.VoxelCenter.ObjectAxis.x Physics
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics += #Physics.Projection.VoxelCenter.ObjectAxis.x Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.ObjectAxis.x.Min Physics <= @s Physics.Object.ProjectionOwnAxis.x.Max run return 0
            execute unless score @s Physics.Object.ProjectionOwnAxis.x.Min <= #Physics.Projection.Voxel.ObjectAxis.x.Max Physics run return 0

        # y_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Min Physics = #Physics.Projection.VoxelBase.ObjectAxis.y.Min Physics
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics = #Physics.Projection.VoxelBase.ObjectAxis.y.Max Physics

                # Project the center pos and add the projection to the min and max
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                scoreboard players operation #Physics.Projection.VoxelCenter.ObjectAxis.y Physics = #Physics.BlockPos.x Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.ObjectAxis.y Physics *= @s Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockPos.y Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.VoxelCenter.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
                scoreboard players operation #Physics.Projection.VoxelCenter.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.VoxelCenter.ObjectAxis.y Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Min Physics += #Physics.Projection.VoxelCenter.ObjectAxis.y Physics
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics += #Physics.Projection.VoxelCenter.ObjectAxis.y Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.ObjectAxis.y.Min Physics <= @s Physics.Object.ProjectionOwnAxis.y.Max run return 0
            execute unless score @s Physics.Object.ProjectionOwnAxis.y.Min <= #Physics.Projection.Voxel.ObjectAxis.y.Max Physics run return 0

        # z_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Min Physics = #Physics.Projection.VoxelBase.ObjectAxis.z.Min Physics
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics = #Physics.Projection.VoxelBase.ObjectAxis.z.Max Physics

                # Project the center pos and add the projection to the min and max
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                scoreboard players operation #Physics.Projection.VoxelCenter.ObjectAxis.z Physics = #Physics.BlockPos.x Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.ObjectAxis.z Physics *= @s Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockPos.y Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.VoxelCenter.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
                scoreboard players operation #Physics.Projection.VoxelCenter.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.VoxelCenter.ObjectAxis.z Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Min Physics += #Physics.Projection.VoxelCenter.ObjectAxis.z Physics
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics += #Physics.Projection.VoxelCenter.ObjectAxis.z Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.ObjectAxis.z.Min Physics <= @s Physics.Object.ProjectionOwnAxis.z.Max run return 0
            execute unless score @s Physics.Object.ProjectionOwnAxis.z.Min <= #Physics.Projection.Voxel.ObjectAxis.z.Max Physics run return 0

        # Cross Product: x_block x x_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Min Physics = #Physics.Projection.VoxelBase.CrossProductAxis.xx.Min Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics = #Physics.Projection.VoxelBase.CrossProductAxis.xx.Max Physics

                # Project the center pos and add the projection to the min and max
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's x axis is 0, so x can be ignored
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.xx Physics = #Physics.BlockPos.y Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.xx Physics *= #Physics.CrossProductAxis.xx.y Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.z Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.xx Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Min Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.xx Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.xx Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.CrossProductAxis.xx.Min Physics <= #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.xx.Min Physics <= #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics run return 0

        # Cross Product: x_block x y_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Min Physics = #Physics.Projection.VoxelBase.CrossProductAxis.xy.Min Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics = #Physics.Projection.VoxelBase.CrossProductAxis.xy.Max Physics

                # Project the center pos and add the projection to the min and max
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's x axis is 0, so x can be ignored
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.xy Physics = #Physics.BlockPos.y Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.xy Physics *= #Physics.CrossProductAxis.xy.y Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xy.z Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Min Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.xy Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.xy Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.CrossProductAxis.xy.Min Physics <= #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.xy.Min Physics <= #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics run return 0

        # Cross Product: x_block x z_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Min Physics = #Physics.Projection.VoxelBase.CrossProductAxis.xz.Min Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics = #Physics.Projection.VoxelBase.CrossProductAxis.xz.Max Physics

                # Project the center pos and add the projection to the min and max
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's x axis is 0, so x can be ignored
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.xz Physics = #Physics.BlockPos.y Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.xz Physics *= #Physics.CrossProductAxis.xz.y Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xz.z Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.xz Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Min Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.xz Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.xz Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.CrossProductAxis.xz.Min Physics <= #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.xz.Min Physics <= #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics run return 0

        # Cross Product: y_block x x_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Min Physics = #Physics.Projection.VoxelBase.CrossProductAxis.yx.Min Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics = #Physics.Projection.VoxelBase.CrossProductAxis.yx.Max Physics

                # Project the center pos and add the projection to the min and max
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's y axis is 0, so y can be ignored
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.yx Physics = #Physics.BlockPos.x Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.yx Physics *= #Physics.CrossProductAxis.yx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yx.z Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.yx Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Min Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.yx Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.yx Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.CrossProductAxis.yx.Min Physics <= #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.yx.Min Physics <= #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics run return 0

        # Cross Product: y_block x y_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Min Physics = #Physics.Projection.VoxelBase.CrossProductAxis.yy.Min Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics = #Physics.Projection.VoxelBase.CrossProductAxis.yy.Max Physics

                # Project the center pos and add the projection to the min and max
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's y axis is 0, so y can be ignored
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.yy Physics = #Physics.BlockPos.x Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.yy Physics *= #Physics.CrossProductAxis.yy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yy.z Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Min Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.yy Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.yy Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.CrossProductAxis.yy.Min Physics <= #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.yy.Min Physics <= #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics run return 0

        # Cross Product: y_block x z_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Min Physics = #Physics.Projection.VoxelBase.CrossProductAxis.yz.Min Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics = #Physics.Projection.VoxelBase.CrossProductAxis.yz.Max Physics

                # Project the center pos and add the projection to the min and max
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's y axis is 0, so y can be ignored
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.yz Physics = #Physics.BlockPos.x Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.yz Physics *= #Physics.CrossProductAxis.yz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.z Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Min Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.yz Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.yz Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.CrossProductAxis.yz.Min Physics <= #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.yz.Min Physics <= #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics run return 0

        # Cross Product: z_block x x_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Min Physics = #Physics.Projection.VoxelBase.CrossProductAxis.zx.Min Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics = #Physics.Projection.VoxelBase.CrossProductAxis.zx.Max Physics

                # Project the center pos and add the projection to the min and max
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's z axis is 0, so z can be ignored
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.zx Physics = #Physics.BlockPos.x Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.zx Physics *= #Physics.CrossProductAxis.zx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockPos.y Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zx.y Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Min Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.zx Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.zx Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.CrossProductAxis.zx.Min Physics <= #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.zx.Min Physics <= #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics run return 0

        # Cross Product: z_block x y_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Min Physics = #Physics.Projection.VoxelBase.CrossProductAxis.zy.Min Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics = #Physics.Projection.VoxelBase.CrossProductAxis.zy.Max Physics

                # Project the center pos and add the projection to the min and max
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's z axis is 0, so z can be ignored
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.zy Physics = #Physics.BlockPos.x Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.zy Physics *= #Physics.CrossProductAxis.zy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockPos.y Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zy.y Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.zy Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Min Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.zy Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.zy Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.CrossProductAxis.zy.Min Physics <= #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.zy.Min Physics <= #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics run return 0

        # Cross Product: z_block x z_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Min Physics = #Physics.Projection.VoxelBase.CrossProductAxis.zz.Min Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics = #Physics.Projection.VoxelBase.CrossProductAxis.zz.Max Physics

                # Project the center pos and add the projection to the min and max
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's z axis is 0, so z can be ignored
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.zz Physics = #Physics.BlockPos.x Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.zz Physics *= #Physics.CrossProductAxis.zz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockPos.y Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zz.y Physics
                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.VoxelCenter.CrossProductAxis.zz Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Min Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.zz Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics += #Physics.Projection.VoxelCenter.CrossProductAxis.zz Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.CrossProductAxis.zz.Min Physics <= #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.zz.Min Physics <= #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics run return 0

#tellraw @a "Block is intersecting"
# if a.Min <= b.Max and b.Min <= a.Max: Success (Axis is not separating)

function physics:zprivate/collision_detection/voxel_grid/spawn_particle with storage test:test data
