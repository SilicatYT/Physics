# Note: All axis-vectors need to be normalized, including the cross product axes
# Note: Precalculation - The projection of the object onto the world-geometry voxel's 3 axes is the same as the object's min and max values for those axes, so the min and max of the bounding box.
# Note: Precalculation - The projection of the object onto its own 3 axes is -(dimension/2) for the min, and (dimension/2) for the max. Then just add the object center's projection onto the same axis to those min and max values.
# Note: Precalculation - The projection of a world-geometry voxel onto its own 3 axes is the same as the object's min and max. The value stored in the BlockPos score is the block's center, so to get the min and max I add or subtract 0.5 (or 500 in this case, because it's scaled by 1,000x).
# Note: Precalculation - The 9 cross products between the 3 axes of the object and the world-geometry voxel can be precalculated once, as every voxel is not rotated.
# Note: Precalculation - The projection of the object onto the 9 cross product axes can be done once in total, as it stays constant throughout the tick.
# Note: Precalculation - The projection of the world-geometry voxel onto the 9 cross product axes and the axes of the object has to be done for each cube, but there's a trick: Precompute the projection of all 8 corner points of the voxel onto the axes, using only coordinates relative to the position of the cube (in this case the cube center, not the coordinate origin), then precompute the min and max for each axis. Then, for each voxel, add its position to the precomputed min and max values. If the voxel position were the coordinate origin, one of the voxel's corners would always be at [0, 0, 0], relatively speaking. So I wouldn't have to project that one onto the axes, as it would always result in [0, 0, 0]. But overall it's faster to use the center position, because then I only have to project half the corner points onto each axis, calculate the max, and then just change the sign to get the min for each axis.

# Perform the Separating Axes Theorem (Simplified with pre-calculated values) to get whether there's a collision, the depth of the collision and what kind it is (Edge-Edge, Point-Face)
    # Project the block and the object onto the block's x, y and z axes
        # x axis
            # Block
            # Object

        # y axis
            # Block
            # Object

        # z axis
            # Block
            # Object

    # Project the block and the object onto the object's x, y and z axes
        # x axis
            # Block
            # Object

        # y axis
            # Block
            # Object

        # z axis
            # Block
            # Object

    # Project the block and the object onto the cross projects of their axes
        # x_block x x_object
            # Block
            # Object

        # x_block x y_object
            # Block
            # Object

        # x_block x z_object
            # Block
            # Object

        # y_block x x_object
            # Block
            # Object

        # y_block x y_object
            # Block
            # Object

        # y_block x z_object
            # Block
            # Object

        # z_block x x_object
            # Block
            # Object

        # z_block x y_object
            # Block
            # Object

        # z_block x z_object
            # Block
            # Object
