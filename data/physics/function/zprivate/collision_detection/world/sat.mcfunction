# (VERY IMPORTANT): Apparently, blindly using the axis of minimum overlap is not correct, and could lead to point-face contacts being detected where not a single corner intersects. After implementing resolution, check how much of a problem this is. To fix, either verify the proposed contact somehow, or use Ian Millington's method that doesn't use the axis of min overlap but instead checks every combination. Whatever is faster.
















# Note: All axis-vectors need to be normalized, including the cross product axes
# Note: Precalculation - The projection of the object onto the world-geometry block's 3 axes is the same as the object's min and max values for those axes, so the min and max of the bounding box.
# Note: Precalculation - The projection of the object onto its own 3 axes is -(dimension/2) for the min, and (dimension/2) for the max. Then just add the object center's projection onto the same axis to those min and max values.
# Note: Precalculation - The projection of a world-geometry block onto its own 3 axes is the same as the object's min and max. The value stored in the BlockPos score is the block's center (Not the hitbox center), so to get the min and max I add or subtract 0.5 (or 500 in this case, because it's scaled by 1,000x).
# Note: Precalculation - The 9 cross products between the 3 axes of the object and the world-geometry block can be precalculated once, as every block is not rotated.
# Note: Precalculation - The projection of the object onto the 9 cross product axes can be done once in total, as it stays constant throughout the tick.
# Note: Precalculation - The projection of the world-geometry block onto the 9 cross product axes and the axes of the object has to be done for each cube, but there's a trick: Precompute the projection of all 8 corner points of the block onto the axes, using only coordinates relative to the block hitbox center of the cube, then precompute the min and max for each axis. Then, for each block, scale the projections based on the block hitbox's scale and add its position to the precomputed min and max values. If the block position were the coordinate origin, one of the block's corners would always be at [0, 0, 0], relatively speaking. So I wouldn't have to project that one onto the axes, as it would always result in [0, 0, 0]. But overall it's faster to use the center position, because then I only have to project half the corner points onto each axis, calculate the max, and then just change the sign to get the min for each axis.

# Perform the Separating Axes Theorem (Simplified with pre-calculated values) to get whether there's a collision, the depth of the collision and what kind it is (Edge-Edge, Point-Face)
    # Check the different axes
        # x_block
            # Projection: Block (= Hitbox)

            # Projection: Object (= Global Bounding Box)

            # Overlap check
            execute unless score #Physics.Projection.Block.WorldAxis.x.Min Physics <= @s Physics.Object.BoundingBoxGlobalMax.x run return 0
            execute unless score @s Physics.Object.BoundingBoxGlobalMin.x <= #Physics.Projection.Block.WorldAxis.x.Max Physics run return 0

        # y_block
            # Projection: Block (= Hitbox)

            # Projection: Object (= Global Bounding Box)

            # Overlap check
            execute unless score #Physics.Projection.Block.WorldAxis.y.Min Physics <= @s Physics.Object.BoundingBoxGlobalMax.y run return 0
            execute unless score @s Physics.Object.BoundingBoxGlobalMin.y <= #Physics.Projection.Block.WorldAxis.y.Max Physics run return 0

        # z_block
            # Projection: Block (= Hitbox)

            # Projection: Object (= Global Bounding Box)

            # Overlap check
            execute unless score #Physics.Projection.Block.WorldAxis.z.Min Physics <= @s Physics.Object.BoundingBoxGlobalMax.z run return 0
            execute unless score @s Physics.Object.BoundingBoxGlobalMin.z <= #Physics.Projection.Block.WorldAxis.z.Max Physics run return 0

        # x_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Block.ObjectAxis.x.Min Physics = #Physics.Projection.BlockBase.ObjectAxis.x.Min Physics
            scoreboard players operation #Physics.Projection.Block.ObjectAxis.x.Max Physics = #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics

                # Project the center pos
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.x Physics = #Physics.BlockCenterPos.x Physics
                scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.x Physics *= @s Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.y Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
                scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.x Physics /= #Physics.Constants.1000 Physics

                # Adjust the min and max projections based on block dimensions & add the center pos projection
                # (Important): The min and max values are the endpoints of one of the block's diagonals' projections, and are precalculated assuming side lengths of 1. As all diagonals have the same length (BlockDiagonalLength) that is hardcoded in "get_hitbox", I multiply by that and then divide by the unit block's diagonal length (sqrt(3)).
                scoreboard players operation #Physics.Projection.Block.ObjectAxis.x.Min Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.ObjectAxis.x.Max Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.ObjectAxis.x.Min Physics /= #Physics.Constants.1732 Physics
                scoreboard players operation #Physics.Projection.Block.ObjectAxis.x.Max Physics /= #Physics.Constants.1732 Physics

                scoreboard players operation #Physics.Projection.Block.ObjectAxis.x.Min Physics += #Physics.Projection.BlockCenter.ObjectAxis.x Physics
                scoreboard players operation #Physics.Projection.Block.ObjectAxis.x.Max Physics += #Physics.Projection.BlockCenter.ObjectAxis.x Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Block.ObjectAxis.x.Min Physics <= @s Physics.Object.ProjectionOwnAxis.x.Max run return 0
            execute unless score @s Physics.Object.ProjectionOwnAxis.x.Min <= #Physics.Projection.Block.ObjectAxis.x.Max Physics run return 0

        # y_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Block.ObjectAxis.y.Min Physics = #Physics.Projection.BlockBase.ObjectAxis.y.Min Physics
            scoreboard players operation #Physics.Projection.Block.ObjectAxis.y.Max Physics = #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics

                # Project the center pos
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.y Physics = #Physics.BlockCenterPos.x Physics
                scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.y Physics *= @s Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.y Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
                scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.y Physics /= #Physics.Constants.1000 Physics

                # Adjust the min and max projections based on block dimensions & add the center pos projection
                # (Important): The min and max values are the endpoints of one of the block's diagonals' projections, and are precalculated assuming side lengths of 1. As all diagonals have the same length (BlockDiagonalLength) that is hardcoded in "get_hitbox", I multiply by that and then divide by the unit block's diagonal length (sqrt(3)).
                scoreboard players operation #Physics.Projection.Block.ObjectAxis.y.Min Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.ObjectAxis.y.Max Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.ObjectAxis.y.Min Physics /= #Physics.Constants.1732 Physics
                scoreboard players operation #Physics.Projection.Block.ObjectAxis.y.Max Physics /= #Physics.Constants.1732 Physics

                scoreboard players operation #Physics.Projection.Block.ObjectAxis.y.Min Physics += #Physics.Projection.BlockCenter.ObjectAxis.y Physics
                scoreboard players operation #Physics.Projection.Block.ObjectAxis.y.Max Physics += #Physics.Projection.BlockCenter.ObjectAxis.y Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Block.ObjectAxis.y.Min Physics <= @s Physics.Object.ProjectionOwnAxis.y.Max run return 0
            execute unless score @s Physics.Object.ProjectionOwnAxis.y.Min <= #Physics.Projection.Block.ObjectAxis.y.Max Physics run return 0

        # z_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Block.ObjectAxis.z.Min Physics = #Physics.Projection.BlockBase.ObjectAxis.z.Min Physics
            scoreboard players operation #Physics.Projection.Block.ObjectAxis.z.Max Physics = #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics

                # Project the center pos
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.z Physics = #Physics.BlockCenterPos.x Physics
                scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.z Physics *= @s Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.y Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
                scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.z Physics /= #Physics.Constants.1000 Physics

                # Adjust the min and max projections based on block dimensions & add the center pos projection
                # (Important): The min and max values are the endpoints of one of the block's diagonals' projections, and are precalculated assuming side lengths of 1. As all diagonals have the same length (BlockDiagonalLength) that is hardcoded in "get_hitbox", I multiply by that and then divide by the unit block's diagonal length (sqrt(3)).
                scoreboard players operation #Physics.Projection.Block.ObjectAxis.z.Min Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.ObjectAxis.z.Max Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.ObjectAxis.z.Min Physics /= #Physics.Constants.1732 Physics
                scoreboard players operation #Physics.Projection.Block.ObjectAxis.z.Max Physics /= #Physics.Constants.1732 Physics

                scoreboard players operation #Physics.Projection.Block.ObjectAxis.z.Min Physics += #Physics.Projection.BlockCenter.ObjectAxis.z Physics
                scoreboard players operation #Physics.Projection.Block.ObjectAxis.z.Max Physics += #Physics.Projection.BlockCenter.ObjectAxis.z Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Block.ObjectAxis.z.Min Physics <= @s Physics.Object.ProjectionOwnAxis.z.Max run return 0
            execute unless score @s Physics.Object.ProjectionOwnAxis.z.Min <= #Physics.Projection.Block.ObjectAxis.z.Max Physics run return 0

        # Cross Product: x_block x x_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xx.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.xx.Min Physics
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xx.Max Physics = #Physics.Projection.BlockBase.CrossProductAxis.xx.Max Physics

                # Project the center pos
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's x axis is 0, so x can be ignored
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.xx Physics = #Physics.BlockCenterPos.y Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.xx Physics *= #Physics.CrossProductAxis.xx.y Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.z Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.xx Physics /= #Physics.Constants.1000 Physics

                # Adjust the min and max projections based on block dimensions & add the center pos projection
                # (Important): The min and max values are the endpoints of one of the block's diagonals' projections, and are precalculated assuming side lengths of 1. As all diagonals have the same length (BlockDiagonalLength) that is hardcoded in "get_hitbox", I multiply by that and then divide by the unit block's diagonal length (sqrt(3)).
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xx.Min Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xx.Max Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xx.Min Physics /= #Physics.Constants.1732 Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xx.Max Physics /= #Physics.Constants.1732 Physics

                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xx.Min Physics += #Physics.Projection.BlockCenter.CrossProductAxis.xx Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xx.Max Physics += #Physics.Projection.BlockCenter.CrossProductAxis.xx Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Block.CrossProductAxis.xx.Min Physics <= #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.xx.Min Physics <= #Physics.Projection.Block.CrossProductAxis.xx.Max Physics run return 0

        # Cross Product: x_block x y_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xy.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.xy.Min Physics
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xy.Max Physics = #Physics.Projection.BlockBase.CrossProductAxis.xy.Max Physics

                # Project the center pos
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's x axis is 0, so x can be ignored
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.xy Physics = #Physics.BlockCenterPos.y Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.xy Physics *= #Physics.CrossProductAxis.xy.y Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xy.z Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics

                # Adjust the min and max projections based on block dimensions & add the center pos projection
                # (Important): The min and max values are the endpoints of one of the block's diagonals' projections, and are precalculated assuming side lengths of 1. As all diagonals have the same length (BlockDiagonalLength) that is hardcoded in "get_hitbox", I multiply by that and then divide by the unit block's diagonal length (sqrt(3)).
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xy.Min Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xy.Max Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xy.Min Physics /= #Physics.Constants.1732 Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xy.Max Physics /= #Physics.Constants.1732 Physics

                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xy.Min Physics += #Physics.Projection.BlockCenter.CrossProductAxis.xy Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xy.Max Physics += #Physics.Projection.BlockCenter.CrossProductAxis.xy Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Block.CrossProductAxis.xy.Min Physics <= #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.xy.Min Physics <= #Physics.Projection.Block.CrossProductAxis.xy.Max Physics run return 0

        # Cross Product: x_block x z_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xz.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.xz.Min Physics
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xz.Max Physics = #Physics.Projection.BlockBase.CrossProductAxis.xz.Max Physics

                # Project the center pos
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's x axis is 0, so x can be ignored
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.xz Physics = #Physics.BlockCenterPos.y Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.xz Physics *= #Physics.CrossProductAxis.xz.y Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xz.z Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.xz Physics /= #Physics.Constants.1000 Physics

                # Adjust the min and max projections based on block dimensions & add the center pos projection
                # (Important): The min and max values are the endpoints of one of the block's diagonals' projections, and are precalculated assuming side lengths of 1. As all diagonals have the same length (BlockDiagonalLength) that is hardcoded in "get_hitbox", I multiply by that and then divide by the unit block's diagonal length (sqrt(3)).
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xz.Min Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xz.Max Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xz.Min Physics /= #Physics.Constants.1732 Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xz.Max Physics /= #Physics.Constants.1732 Physics

                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xz.Min Physics += #Physics.Projection.BlockCenter.CrossProductAxis.xz Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.xz.Max Physics += #Physics.Projection.BlockCenter.CrossProductAxis.xz Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Block.CrossProductAxis.xz.Min Physics <= #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.xz.Min Physics <= #Physics.Projection.Block.CrossProductAxis.xz.Max Physics run return 0

        # Cross Product: y_block x x_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yx.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.yx.Min Physics
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yx.Max Physics = #Physics.Projection.BlockBase.CrossProductAxis.yx.Max Physics

                # Project the center pos
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's y axis is 0, so y can be ignored
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.yx Physics = #Physics.BlockCenterPos.x Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.yx Physics *= #Physics.CrossProductAxis.yx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yx.z Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.yx Physics /= #Physics.Constants.1000 Physics

                # Adjust the min and max projections based on block dimensions & add the center pos projection
                # (Important): The min and max values are the endpoints of one of the block's diagonals' projections, and are precalculated assuming side lengths of 1. As all diagonals have the same length (BlockDiagonalLength) that is hardcoded in "get_hitbox", I multiply by that and then divide by the unit block's diagonal length (sqrt(3)).
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yx.Min Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yx.Max Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yx.Min Physics /= #Physics.Constants.1732 Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yx.Max Physics /= #Physics.Constants.1732 Physics

                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yx.Min Physics += #Physics.Projection.BlockCenter.CrossProductAxis.yx Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yx.Max Physics += #Physics.Projection.BlockCenter.CrossProductAxis.yx Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Block.CrossProductAxis.yx.Min Physics <= #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.yx.Min Physics <= #Physics.Projection.Block.CrossProductAxis.yx.Max Physics run return 0

        # Cross Product: y_block x y_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yy.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.yy.Min Physics
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yy.Max Physics = #Physics.Projection.BlockBase.CrossProductAxis.yy.Max Physics

                # Project the center pos
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's y axis is 0, so y can be ignored
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.yy Physics = #Physics.BlockCenterPos.x Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.yy Physics *= #Physics.CrossProductAxis.yy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yy.z Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics

                # Adjust the min and max projections based on block dimensions & add the center pos projection
                # (Important): The min and max values are the endpoints of one of the block's diagonals' projections, and are precalculated assuming side lengths of 1. As all diagonals have the same length (BlockDiagonalLength) that is hardcoded in "get_hitbox", I multiply by that and then divide by the unit block's diagonal length (sqrt(3)).
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yy.Min Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yy.Max Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yy.Min Physics /= #Physics.Constants.1732 Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yy.Max Physics /= #Physics.Constants.1732 Physics

                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yy.Min Physics += #Physics.Projection.BlockCenter.CrossProductAxis.yy Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yy.Max Physics += #Physics.Projection.BlockCenter.CrossProductAxis.yy Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Block.CrossProductAxis.yy.Min Physics <= #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.yy.Min Physics <= #Physics.Projection.Block.CrossProductAxis.yy.Max Physics run return 0

        # Cross Product: y_block x z_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yz.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.yz.Min Physics
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yz.Max Physics = #Physics.Projection.BlockBase.CrossProductAxis.yz.Max Physics

                # Project the center pos
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's y axis is 0, so y can be ignored
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.yz Physics = #Physics.BlockCenterPos.x Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.yz Physics *= #Physics.CrossProductAxis.yz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.z Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.z Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics

                # Adjust the min and max projections based on block dimensions & add the center pos projection
                # (Important): The min and max values are the endpoints of one of the block's diagonals' projections, and are precalculated assuming side lengths of 1. As all diagonals have the same length (BlockDiagonalLength) that is hardcoded in "get_hitbox", I multiply by that and then divide by the unit block's diagonal length (sqrt(3)).
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yz.Min Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yz.Max Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yz.Min Physics /= #Physics.Constants.1732 Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yz.Max Physics /= #Physics.Constants.1732 Physics

                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yz.Min Physics += #Physics.Projection.BlockCenter.CrossProductAxis.yz Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.yz.Max Physics += #Physics.Projection.BlockCenter.CrossProductAxis.yz Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Block.CrossProductAxis.yz.Min Physics <= #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.yz.Min Physics <= #Physics.Projection.Block.CrossProductAxis.yz.Max Physics run return 0

        # Cross Product: z_block x x_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zx.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.zx.Min Physics
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zx.Max Physics = #Physics.Projection.BlockBase.CrossProductAxis.zx.Max Physics

                # Project the center pos
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's z axis is 0, so z can be ignored
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.zx Physics = #Physics.BlockCenterPos.x Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.zx Physics *= #Physics.CrossProductAxis.zx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.y Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zx.y Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics

                # Adjust the min and max projections based on block dimensions & add the center pos projection
                # (Important): The min and max values are the endpoints of one of the block's diagonals' projections, and are precalculated assuming side lengths of 1. As all diagonals have the same length (BlockDiagonalLength) that is hardcoded in "get_hitbox", I multiply by that and then divide by the unit block's diagonal length (sqrt(3)).
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zx.Min Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zx.Max Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zx.Min Physics /= #Physics.Constants.1732 Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zx.Max Physics /= #Physics.Constants.1732 Physics

                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zx.Min Physics += #Physics.Projection.BlockCenter.CrossProductAxis.zx Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zx.Max Physics += #Physics.Projection.BlockCenter.CrossProductAxis.zx Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Block.CrossProductAxis.zx.Min Physics <= #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.zx.Min Physics <= #Physics.Projection.Block.CrossProductAxis.zx.Max Physics run return 0

        # Cross Product: z_block x y_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zy.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.zy.Min Physics
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zy.Max Physics = #Physics.Projection.BlockBase.CrossProductAxis.zy.Max Physics

                # Project the center pos
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's z axis is 0, so z can be ignored
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.zy Physics = #Physics.BlockCenterPos.x Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.zy Physics *= #Physics.CrossProductAxis.zy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.y Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zy.y Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.zy Physics /= #Physics.Constants.1000 Physics

                # Adjust the min and max projections based on block dimensions & add the center pos projection
                # (Important): The min and max values are the endpoints of one of the block's diagonals' projections, and are precalculated assuming side lengths of 1. As all diagonals have the same length (BlockDiagonalLength) that is hardcoded in "get_hitbox", I multiply by that and then divide by the unit block's diagonal length (sqrt(3)).
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zy.Min Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zy.Max Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zy.Min Physics /= #Physics.Constants.1732 Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zy.Max Physics /= #Physics.Constants.1732 Physics

                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zy.Min Physics += #Physics.Projection.BlockCenter.CrossProductAxis.zy Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zy.Max Physics += #Physics.Projection.BlockCenter.CrossProductAxis.zy Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Block.CrossProductAxis.zy.Min Physics <= #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.zy.Min Physics <= #Physics.Projection.Block.CrossProductAxis.zy.Max Physics run return 0

        # Cross Product: z_block x z_object
            # Projection: Block
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zz.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.zz.Min Physics
            scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zz.Max Physics = #Physics.Projection.BlockBase.CrossProductAxis.zz.Max Physics

                # Project the center pos
                # (Important): I divide the result by 1,000x to ensure a consistent scaling
                # (Important): Cross product's z axis is 0, so z can be ignored
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.zz Physics = #Physics.BlockCenterPos.x Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.zz Physics *= #Physics.CrossProductAxis.zz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.y Physics
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zz.y Physics
                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.BlockCenter.CrossProductAxis.zz Physics /= #Physics.Constants.1000 Physics

                # Adjust the min and max projections based on block dimensions & add the center pos projection
                # (Important): The min and max values are the endpoints of one of the block's diagonals' projections, and are precalculated assuming side lengths of 1. As all diagonals have the same length (BlockDiagonalLength) that is hardcoded in "get_hitbox", I multiply by that and then divide by the unit block's diagonal length (sqrt(3)).
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zz.Min Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zz.Max Physics *= #Physics.BlockDiagonalLength Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zz.Min Physics /= #Physics.Constants.1732 Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zz.Max Physics /= #Physics.Constants.1732 Physics

                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zz.Min Physics += #Physics.Projection.BlockCenter.CrossProductAxis.zz Physics
                scoreboard players operation #Physics.Projection.Block.CrossProductAxis.zz.Max Physics += #Physics.Projection.BlockCenter.CrossProductAxis.zz Physics

            # Projection: Object (Precalculated)

            # Overlap check
            execute unless score #Physics.Projection.Block.CrossProductAxis.zz.Min Physics <= #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run return 0
            execute unless score #Physics.Projection.Object.CrossProductAxis.zz.Min Physics <= #Physics.Projection.Block.CrossProductAxis.zz.Max Physics run return 0

# Run different actions depending on the hitbox type (fluid, sticky etc) except Solid
# (Important): Because this is only run when HitboxType is not 1, the 1 doesn't have to be stored in the storage and be run with this macro (& the 1 can be inlined after this to avoid a function call).
execute unless score #Physics.HitboxType Physics matches 1 run return run function physics:zprivate/collision_detection/world/hitbox_type/check with storage physics:temp data

# Additional "Solid" commands
    # Add the block to the final data if it's the first contact / hitbox for that block
    execute if score #Physics.Touching Physics matches 0 run function physics:zprivate/collision_detection/world/new_block

# Additional "Solid" commands: Run contact generation
# HitboxType 1 (Solid)

# Add the hitbox to the data (Indexes 0-2 are the bottom corner, 3-5 are the top corner)
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes append value {BoundingBox:[I;0,0,0,0,0,0]}
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].ID byte 1 run scoreboard players get #Physics.HitboxID Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].BoundingBox[0] int 1 run scoreboard players get #Physics.Projection.Block.WorldAxis.x.Min Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].BoundingBox[1] int 1 run scoreboard players get #Physics.Projection.Block.WorldAxis.y.Min Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].BoundingBox[2] int 1 run scoreboard players get #Physics.Projection.Block.WorldAxis.z.Min Physics

# Get how much each axis is overlapping & get the least overlap
# (Important): If two axes are exactly parallel to each other (Like if the objects are resting ontop of each other), their cross product is [0,0,0]. I'm unsure if discarding cross products with an overlap of 0 or with a value of [0,0,0] is more stable, so I'll revisit it once the resolver is done. For now, I discard cross products with an overlap of 0.
    # x_block
    scoreboard players operation #Physics.Overlap.WorldAxis.x Physics = @s Physics.Object.BoundingBoxGlobalMax.x
    scoreboard players operation #Physics.Overlap.WorldAxis.x Physics -= #Physics.Projection.Block.WorldAxis.x.Min Physics
    execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].BoundingBox[3] int 1 run scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.WorldAxis.x.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.BoundingBoxGlobalMin.x
    execute if score #Physics.Overlap.WorldAxis.x Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.WorldAxis.x Physics = #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.x Physics

    # y_block
    scoreboard players operation #Physics.Overlap.WorldAxis.y Physics = @s Physics.Object.BoundingBoxGlobalMax.y
    scoreboard players operation #Physics.Overlap.WorldAxis.y Physics -= #Physics.Projection.Block.WorldAxis.y.Min Physics
    execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].BoundingBox[4] int 1 run scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.WorldAxis.y.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.BoundingBoxGlobalMin.y
    execute if score #Physics.Overlap.WorldAxis.y Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.WorldAxis.y Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.WorldAxis.y Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.y Physics

    # z_block
    scoreboard players operation #Physics.Overlap.WorldAxis.z Physics = @s Physics.Object.BoundingBoxGlobalMax.z
    scoreboard players operation #Physics.Overlap.WorldAxis.z Physics -= #Physics.Projection.Block.WorldAxis.z.Min Physics
    execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].BoundingBox[5] int 1 run scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.WorldAxis.z.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.BoundingBoxGlobalMin.z
    execute if score #Physics.Overlap.WorldAxis.z Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.WorldAxis.z Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.WorldAxis.z Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.z Physics

    # x_object
    scoreboard players operation #Physics.Overlap.ObjectAxis.x Physics = @s Physics.Object.ProjectionOwnAxis.x.Max
    scoreboard players operation #Physics.Overlap.ObjectAxis.x Physics -= #Physics.Projection.Block.ObjectAxis.x.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.ObjectAxis.x.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.ProjectionOwnAxis.x.Min
    execute if score #Physics.Overlap.ObjectAxis.x Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.ObjectAxis.x Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.ObjectAxis.x Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.x Physics

    # y_object
    scoreboard players operation #Physics.Overlap.ObjectAxis.y Physics = @s Physics.Object.ProjectionOwnAxis.y.Max
    scoreboard players operation #Physics.Overlap.ObjectAxis.y Physics -= #Physics.Projection.Block.ObjectAxis.y.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.ObjectAxis.y.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.ProjectionOwnAxis.y.Min
    execute if score #Physics.Overlap.ObjectAxis.y Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.ObjectAxis.y Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.ObjectAxis.y Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.y Physics

    # z_object
    scoreboard players operation #Physics.Overlap.ObjectAxis.z Physics = @s Physics.Object.ProjectionOwnAxis.z.Max
    scoreboard players operation #Physics.Overlap.ObjectAxis.z Physics -= #Physics.Projection.Block.ObjectAxis.z.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.ObjectAxis.z.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.ProjectionOwnAxis.z.Min
    execute if score #Physics.Overlap.ObjectAxis.z Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.ObjectAxis.z Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.ObjectAxis.z Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.z Physics

    # Cross product: x_block x x_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xx Physics = #Physics.Projection.Object.CrossProductAxis.xx.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xx Physics -= #Physics.Projection.Block.CrossProductAxis.xx.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.xx.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.xx.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.xx Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.xx Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.xx Physics unless score #Physics.Overlap.CrossProductAxis.xx Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xx Physics

    # Cross product: x_block x y_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xy Physics = #Physics.Projection.Object.CrossProductAxis.xy.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xy Physics -= #Physics.Projection.Block.CrossProductAxis.xy.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.xy.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.xy.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.xy Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.xy Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.xy Physics unless score #Physics.Overlap.CrossProductAxis.xy Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xy Physics

    # Cross product: x_block x z_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xz Physics = #Physics.Projection.Object.CrossProductAxis.xz.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xz Physics -= #Physics.Projection.Block.CrossProductAxis.xz.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.xz.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.xz.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.xz Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.xz Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.xz Physics unless score #Physics.Overlap.CrossProductAxis.xz Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xz Physics

    # Cross product: y_block x x_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yx Physics = #Physics.Projection.Object.CrossProductAxis.yx.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yx Physics -= #Physics.Projection.Block.CrossProductAxis.yx.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.yx.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.yx.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.yx Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.yx Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.yx Physics unless score #Physics.Overlap.CrossProductAxis.yx Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yx Physics

    # Cross product: y_block x y_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yy Physics = #Physics.Projection.Object.CrossProductAxis.yy.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yy Physics -= #Physics.Projection.Block.CrossProductAxis.yy.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.yy.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.yy.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.yy Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.yy Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.yy Physics unless score #Physics.Overlap.CrossProductAxis.yy Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yy Physics

    # Cross product: y_block x z_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yz Physics = #Physics.Projection.Object.CrossProductAxis.yz.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yz Physics -= #Physics.Projection.Block.CrossProductAxis.yz.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.yz.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.yz.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.yz Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.yz Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.yz Physics unless score #Physics.Overlap.CrossProductAxis.yz Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yz Physics

    # Cross product: z_block x x_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zx Physics = #Physics.Projection.Object.CrossProductAxis.zx.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zx Physics -= #Physics.Projection.Block.CrossProductAxis.zx.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.zx.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.zx.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.zx Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.zx Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.zx Physics unless score #Physics.Overlap.CrossProductAxis.zx Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.zx Physics

    # Cross product: z_block x y_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zy Physics = #Physics.Projection.Object.CrossProductAxis.zy.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zy Physics -= #Physics.Projection.Block.CrossProductAxis.zy.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.zy.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.zy.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.zy Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.zy Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.zy Physics unless score #Physics.Overlap.CrossProductAxis.zy Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.zy Physics

    # Cross product: z_block x z_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zz Physics = #Physics.Projection.Object.CrossProductAxis.zz.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zz Physics -= #Physics.Projection.Block.CrossProductAxis.zz.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.zz.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.zz.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.zz Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.zz Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.zz Physics unless score #Physics.Overlap.CrossProductAxis.zz Physics matches 0 run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_zz/main

# Get the involved features of both objects
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/world/world_axis_y/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.x Physics run return run function physics:zprivate/contact_generation/new_contact/world/world_axis_x/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.z Physics run return run function physics:zprivate/contact_generation/new_contact/world/world_axis_z/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.x Physics run return run function physics:zprivate/contact_generation/new_contact/world/object_axis_x/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/world/object_axis_y/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.z Physics run return run function physics:zprivate/contact_generation/new_contact/world/object_axis_z/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xx Physics run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xy Physics run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xy/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xz Physics run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xz/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yx Physics run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_yx/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yy Physics run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_yy/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yz Physics run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_yz/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.zx Physics run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_zx/main
function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_zy/main
