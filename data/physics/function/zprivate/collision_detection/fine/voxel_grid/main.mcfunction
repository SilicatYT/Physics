# Note: All axis-vectors need to be normalized, including the cross product axes
# Note: Precalculation - The projection of the object onto its own 3 axes is the same as the object's min and max values for that axis, so the min and max of the bounding box.
# Note: Precalculation - The projection of a world-geometry voxel onto its own 3 axes is the same as the object's min and max. The value stored in the BlockPos score is the block's coordinate origin, so the min. Meaning I can just add 1 to get the max for each axis.
# Note: Precalculation - The 9 cross products between the 3 axes of the object and the world-geometry voxel can be precalculated once, as every voxel is not rotated.
# Note: Precalculation - The projection of the object onto the 9 cross product axes can be done once in total, as it stays constant throughout the tick.
# Note: Precalculation - The projection of the world-geometry voxel onto the 9 cross product axes and the axes of the object has to be done for each cube, but there's a trick: Precompute the projection of all 8 corner points of the voxel onto the axes, using only coordinates relative to the position of the cube (in this case the cube coordinate origin, not the center), then precompute the min and max for each axis. Then, for each voxel, project only the origin coordinate onto the axes and add that projection to the precomputed min and max values. Note that because the voxel position is the coordinate origin, one of the voxel's corners is always at [0, 0, 0], relatively speaking. So I don't have to project that one onto the axes, as it would always result in [0, 0, 0].

# Perform the Separating Axes Theorem (Simplified with pre-calculated cross products) to get whether there's a collision, and what kind of collision it is (Edge-Edge, Point-Face)
    # Project the block and the object onto the block's x, y and z axes (= world axes, because unrotated)
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
