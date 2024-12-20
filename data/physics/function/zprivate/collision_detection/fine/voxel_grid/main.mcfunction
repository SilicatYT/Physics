# Note: The projection of my object onto its own 3 axes and the 9 cross product axes can be done ONCE in total, as the axes and the cube position stay the same
# Note: The projection of the cube onto its own 3 axes can be hardcoded (Simply the coordinate along that axis)
# Note: Need to normalize the vectors, incl. the cross products
# Note: Project all 8 vertices of the cube onto each axis *ahead of time* (once total), but use local coordinates relative to the center of the cube. Then calculate it together with the projection of the center onto each axis (for each block). Then the min and max for the range on that axis is the precomputed min and max, but += <projection of the center onto the axis>

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
