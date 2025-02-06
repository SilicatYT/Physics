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
            scoreboard players add #Physics.Projection.Voxel.WorldAxis.x.Max Physics 500

            # Projection: Object (= Global Bounding Box)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.WorldAxis.x.Min Physics <= @s Physics.Object.BoundingBoxGlobalMax.x run return 0
            execute unless score @s Physics.Object.BoundingBoxGlobalMin.x <= #Physics.Projection.Voxel.WorldAxis.x.Max Physics run return 0

        # y_block
            # Projection: Block
            execute store result score #Physics.Projection.Voxel.WorldAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Voxel.WorldAxis.y.Min Physics = #Physics.BlockPos.y Physics
            scoreboard players remove #Physics.Projection.Voxel.WorldAxis.y.Min Physics 500
            scoreboard players add #Physics.Projection.Voxel.WorldAxis.y.Max Physics 500

            # Projection: Object (= Global Bounding Box)

            # Overlap check
            execute unless score #Physics.Projection.Voxel.WorldAxis.y.Min Physics <= @s Physics.Object.BoundingBoxGlobalMax.y run return 0
            execute unless score @s Physics.Object.BoundingBoxGlobalMin.y <= #Physics.Projection.Voxel.WorldAxis.y.Max Physics run return 0

        # z_block
            # Projection: Block
            execute store result score #Physics.Projection.Voxel.WorldAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Voxel.WorldAxis.z.Min Physics = #Physics.BlockPos.z Physics
            scoreboard players remove #Physics.Projection.Voxel.WorldAxis.z.Min Physics 500
            scoreboard players add #Physics.Projection.Voxel.WorldAxis.z.Max Physics 500

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

execute store result storage test:test data.x double 0.001 run scoreboard players get #Physics.BlockPos.x Physics
execute store result storage test:test data.y double 0.001 run scoreboard players get #Physics.BlockPos.y Physics
execute store result storage test:test data.z double 0.001 run scoreboard players get #Physics.BlockPos.z Physics
function physics:zprivate/collision_detection/world/debug_set_glass with storage test:test data

# Get how much each axis is overlapping & get the least overlap
    # x_block
    scoreboard players operation #Physics.Overlap.WorldAxis.x Physics = @s Physics.Object.BoundingBoxGlobalMax.x
    scoreboard players operation #Physics.Overlap.WorldAxis.x Physics -= #Physics.Projection.Voxel.WorldAxis.x.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Voxel.WorldAxis.x.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.BoundingBoxGlobalMin.x
    execute if score #Physics.Overlap.WorldAxis.x Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.WorldAxis.x Physics = #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.x Physics

    # y_block
    scoreboard players operation #Physics.Overlap.WorldAxis.y Physics = @s Physics.Object.BoundingBoxGlobalMax.y
    scoreboard players operation #Physics.Overlap.WorldAxis.y Physics -= #Physics.Projection.Voxel.WorldAxis.y.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Voxel.WorldAxis.y.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.BoundingBoxGlobalMin.y
    execute if score #Physics.Overlap.WorldAxis.y Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.WorldAxis.y Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.WorldAxis.y Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.y Physics

    # z_block
    scoreboard players operation #Physics.Overlap.WorldAxis.z Physics = @s Physics.Object.BoundingBoxGlobalMax.z
    scoreboard players operation #Physics.Overlap.WorldAxis.z Physics -= #Physics.Projection.Voxel.WorldAxis.z.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Voxel.WorldAxis.z.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.BoundingBoxGlobalMin.z
    execute if score #Physics.Overlap.WorldAxis.z Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.WorldAxis.z Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.WorldAxis.z Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.z Physics

    # x_object
    scoreboard players operation #Physics.Overlap.ObjectAxis.x Physics = @s Physics.Object.ProjectionOwnAxis.x.Max
    scoreboard players operation #Physics.Overlap.ObjectAxis.x Physics -= #Physics.Projection.Voxel.ObjectAxis.x.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Voxel.ObjectAxis.x.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.ProjectionOwnAxis.x.Min
    execute if score #Physics.Overlap.ObjectAxis.x Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.ObjectAxis.x Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.ObjectAxis.x Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.x Physics

    # y_object
    scoreboard players operation #Physics.Overlap.ObjectAxis.y Physics = @s Physics.Object.ProjectionOwnAxis.y.Max
    scoreboard players operation #Physics.Overlap.ObjectAxis.y Physics -= #Physics.Projection.Voxel.ObjectAxis.y.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Voxel.ObjectAxis.y.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.ProjectionOwnAxis.y.Min
    execute if score #Physics.Overlap.ObjectAxis.y Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.ObjectAxis.y Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.ObjectAxis.y Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.y Physics

    # z_object
    scoreboard players operation #Physics.Overlap.ObjectAxis.z Physics = @s Physics.Object.ProjectionOwnAxis.z.Max
    scoreboard players operation #Physics.Overlap.ObjectAxis.z Physics -= #Physics.Projection.Voxel.ObjectAxis.z.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Voxel.ObjectAxis.z.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.ProjectionOwnAxis.z.Min
    execute if score #Physics.Overlap.ObjectAxis.z Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.ObjectAxis.z Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.ObjectAxis.z Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.z Physics

    # Cross product: x_block x x_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xx Physics = #Physics.Projection.Object.CrossProductAxis.xx.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xx Physics -= #Physics.Projection.Voxel.CrossProductAxis.xx.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.xx.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.xx Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.xx Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.xx Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xx Physics

    # Cross product: x_block x y_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xy Physics = #Physics.Projection.Object.CrossProductAxis.xy.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xy Physics -= #Physics.Projection.Voxel.CrossProductAxis.xy.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.xy.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.xy Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.xy Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.xy Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xy Physics

    # Cross product: x_block x z_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xz Physics = #Physics.Projection.Object.CrossProductAxis.xz.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xz Physics -= #Physics.Projection.Voxel.CrossProductAxis.xz.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.xz.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.xz Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.xz Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.xz Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xz Physics

    # Cross product: y_block x x_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yx Physics = #Physics.Projection.Object.CrossProductAxis.yx.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yx Physics -= #Physics.Projection.Voxel.CrossProductAxis.yx.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.yx.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.yx Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.yx Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.yx Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yx Physics

    # Cross product: y_block x y_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yy Physics = #Physics.Projection.Object.CrossProductAxis.yy.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yy Physics -= #Physics.Projection.Voxel.CrossProductAxis.yy.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.yy.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.yy Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.yy Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.yy Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yy Physics

    # Cross product: y_block x z_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yz Physics = #Physics.Projection.Object.CrossProductAxis.yz.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yz Physics -= #Physics.Projection.Voxel.CrossProductAxis.yz.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.yz.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.yz Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.yz Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.yz Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yz Physics

    # Cross product: z_block x x_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zx Physics = #Physics.Projection.Object.CrossProductAxis.zx.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zx Physics -= #Physics.Projection.Voxel.CrossProductAxis.zx.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.zx.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.zx Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.zx Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.zx Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.zx Physics

    # Cross product: z_block x y_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zy Physics = #Physics.Projection.Object.CrossProductAxis.zy.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zy Physics -= #Physics.Projection.Voxel.CrossProductAxis.zy.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.zy.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.zy Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.zy Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.zy Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.zy Physics

    # Cross product: z_block x z_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zz Physics = #Physics.Projection.Object.CrossProductAxis.zz.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zz Physics -= #Physics.Projection.Voxel.CrossProductAxis.zz.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.zz.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.zz Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.zz Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.zz Physics run return run function physics:zprivate/contact_generation/get_features/cross_product_axis_zz

# Get the involved features of both objects
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.x Physics run return run function physics:zprivate/contact_generation/get_features/world/world_axis_x
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.y Physics run return run function physics:zprivate/contact_generation/get_features/world/world_axis_y
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.z Physics run return run function physics:zprivate/contact_generation/get_features/world/world_axis_z
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.x Physics run return run function physics:zprivate/contact_generation/get_features/world/object_axis_x
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.y Physics run return run function physics:zprivate/contact_generation/get_features/world/object_axis_y
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.z Physics run return run function physics:zprivate/contact_generation/get_features/world/object_axis_z
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xx Physics run return run function physics:zprivate/contact_generation/get_features/world/cross_product_axis_xx
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xy Physics run return run function physics:zprivate/contact_generation/get_features/world/cross_product_axis_xy
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xz Physics run return run function physics:zprivate/contact_generation/get_features/world/cross_product_axis_xz
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yx Physics run return run function physics:zprivate/contact_generation/get_features/world/cross_product_axis_yx
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yy Physics run return run function physics:zprivate/contact_generation/get_features/world/cross_product_axis_yy
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yz Physics run return run function physics:zprivate/contact_generation/get_features/world/cross_product_axis_yz
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.zx Physics run return run function physics:zprivate/contact_generation/get_features/world/cross_product_axis_zx
function physics:zprivate/contact_generation/get_features/world/cross_product_axis_zy
