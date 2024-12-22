# Pre-calculate as much as possible for the SAT (especially for the voxel grid SAT)
    # x, y and z axes of the object (Normalized)
    # Note: I use "scoreboard players operation ... = ..." here, even though I could put it in an "execute store result score ... run ..." statement in the integration step. But because other stuff can run between the integration and this, I can't store the value in a fake player, so I'd need to create 9 additional scoreboard objectives, at which point I'm not sure about the performance benefit anymore. I might need to benchmark.
    # (Important): Because of the squaring, the result is scaled too much, or rather dividing by the square root would get rid of the scaling. So I need to multiply the quaternions by 1,000x first.
        # x axis
            # Calculation
            scoreboard players operation #Physics.ObjectAxis.x.x Physics.Value = @s Physics.Object.CornerPos.2.x
            execute store result score #Physics.Maths.SquareRoot.Input Physics.Value run scoreboard players operation #Physics.ObjectAxis.x.x Physics.Value -= @s Physics.Object.CornerPos.0.x
            scoreboard players operation #Physics.ObjectAxis.x.y Physics.Value = @s Physics.Object.CornerPos.2.y
            execute store result score #Physics.Maths.Temp.Value1 Physics.Value run scoreboard players operation #Physics.ObjectAxis.x.y Physics.Value -= @s Physics.Object.CornerPos.0.y
            scoreboard players operation #Physics.ObjectAxis.x.z Physics.Value = @s Physics.Object.CornerPos.2.z
            execute store result score #Physics.Maths.Temp.Value2 Physics.Value run scoreboard players operation #Physics.ObjectAxis.x.z Physics.Value -= @s Physics.Object.CornerPos.0.z

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value *= #Physics.Maths.SquareRoot.Input Physics.Value
            scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Maths.Temp.Value1 Physics.Value
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
            scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.Maths.Temp.Value2 Physics.Value
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.ObjectAxis.x.x Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.ObjectAxis.x.y Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.ObjectAxis.x.z Physics.Value *= #Physics.Constants.1000 Physics.Value
            execute store result score #Physics.CrossProductAxis.yx.z Physics.Value store result score #Physics.CrossProductAxis.zx.y Physics.Value store result score #Physics.Maths.Temp.Value9 Physics.Value run scoreboard players operation #Physics.ObjectAxis.x.x Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
            execute store result score #Physics.CrossProductAxis.xx.z Physics.Value store result score #Physics.Maths.Temp.Value3 Physics.Value store result score #Physics.CrossProductAxis.zx.x Physics.Value run scoreboard players operation #Physics.ObjectAxis.x.y Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
            execute store result score #Physics.CrossProductAxis.xx.y Physics.Value store result score #Physics.CrossProductAxis.yx.x Physics.Value store result score #Physics.Maths.Temp.Value6 Physics.Value run scoreboard players operation #Physics.ObjectAxis.x.z Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value

        # y axis
            # Calculation
            scoreboard players operation #Physics.ObjectAxis.y.x Physics.Value = @s Physics.Object.CornerPos.4.x
            execute store result score #Physics.Maths.SquareRoot.Input Physics.Value run scoreboard players operation #Physics.ObjectAxis.y.x Physics.Value -= @s Physics.Object.CornerPos.0.x
            scoreboard players operation #Physics.ObjectAxis.y.y Physics.Value = @s Physics.Object.CornerPos.4.y
            execute store result score #Physics.Maths.Temp.Value1 Physics.Value run scoreboard players operation #Physics.ObjectAxis.y.y Physics.Value -= @s Physics.Object.CornerPos.0.y
            scoreboard players operation #Physics.ObjectAxis.y.z Physics.Value = @s Physics.Object.CornerPos.4.z
            execute store result score #Physics.Maths.Temp.Value2 Physics.Value run scoreboard players operation #Physics.ObjectAxis.y.z Physics.Value -= @s Physics.Object.CornerPos.0.z

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value *= #Physics.Maths.SquareRoot.Input Physics.Value
            scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Maths.Temp.Value1 Physics.Value
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
            scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.Maths.Temp.Value2 Physics.Value
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.ObjectAxis.y.x Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.ObjectAxis.y.y Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.ObjectAxis.y.z Physics.Value *= #Physics.Constants.1000 Physics.Value
            execute store result score #Physics.CrossProductAxis.yy.z Physics.Value store result score #Physics.CrossProductAxis.zy.y Physics.Value store result score #Physics.Maths.Temp.Value10 Physics.Value run scoreboard players operation #Physics.ObjectAxis.y.x Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
            execute store result score #Physics.CrossProductAxis.xy.z Physics.Value store result score #Physics.Maths.Temp.Value4 Physics.Value store result score #Physics.CrossProductAxis.zy.x Physics.Value run scoreboard players operation #Physics.ObjectAxis.y.y Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
            execute store result score #Physics.CrossProductAxis.xy.y Physics.Value store result score #Physics.CrossProductAxis.yy.x Physics.Value store result score #Physics.Maths.Temp.Value7 Physics.Value run scoreboard players operation #Physics.ObjectAxis.y.z Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value

        # z axis
            # Calculation
            scoreboard players operation #Physics.ObjectAxis.z.x Physics.Value = @s Physics.Object.CornerPos.1.x
            execute store result score #Physics.Maths.SquareRoot.Input Physics.Value run scoreboard players operation #Physics.ObjectAxis.z.x Physics.Value -= @s Physics.Object.CornerPos.0.x
            scoreboard players operation #Physics.ObjectAxis.z.y Physics.Value = @s Physics.Object.CornerPos.1.y
            execute store result score #Physics.Maths.Temp.Value1 Physics.Value run scoreboard players operation #Physics.ObjectAxis.z.y Physics.Value -= @s Physics.Object.CornerPos.0.y
            scoreboard players operation #Physics.ObjectAxis.z.z Physics.Value = @s Physics.Object.CornerPos.1.z
            execute store result score #Physics.Maths.Temp.Value2 Physics.Value run scoreboard players operation #Physics.ObjectAxis.z.z Physics.Value -= @s Physics.Object.CornerPos.0.z

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value *= #Physics.Maths.SquareRoot.Input Physics.Value
            scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Maths.Temp.Value1 Physics.Value
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
            scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.Maths.Temp.Value2 Physics.Value
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.ObjectAxis.z.x Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.ObjectAxis.z.y Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.ObjectAxis.z.z Physics.Value *= #Physics.Constants.1000 Physics.Value
            execute store result score #Physics.CrossProductAxis.yz.z Physics.Value store result score #Physics.CrossProductAxis.zz.y Physics.Value store result score #Physics.Maths.Temp.Value11 Physics.Value run scoreboard players operation #Physics.ObjectAxis.z.x Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
            execute store result score #Physics.CrossProductAxis.xz.z Physics.Value store result score #Physics.Maths.Temp.Value5 Physics.Value store result score #Physics.CrossProductAxis.zz.x Physics.Value run scoreboard players operation #Physics.ObjectAxis.z.y Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
            execute store result score #Physics.CrossProductAxis.xz.y Physics.Value store result score #Physics.CrossProductAxis.yz.x Physics.Value store result score #Physics.Maths.Temp.Value8 Physics.Value run scoreboard players operation #Physics.ObjectAxis.z.z Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value

    # 9 cross products of the 3 axes of the object and the world-geometry voxel
    # (Important): Because for instance the x axis of the voxel (block) only has its x component set, this results in a cross product whose x component is not set. I make several of these implications directly and don't even set certain values if the solution is always the same value. Then I work with that value directly.
    # (Important): Just like in several other parts of the code, I use "execute store result" when a value is calculated to create copies, instead of manually running "scoreboard players operation ... = ...", because the former is faster.
        # x_block x x_object
            # Calculation (x_block => The x component is always 0, the y component is -z from the object's axis, and the z component is y from the object's axis)
            execute store result score #Physics.Maths.SquareRoot.Input Physics.Value run scoreboard players operation #Physics.CrossProductAxis.xx.y Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value *= #Physics.Maths.SquareRoot.Input Physics.Value
            scoreboard players operation #Physics.Maths.Temp.Value3 Physics.Value *= #Physics.Maths.Temp.Value3 Physics.Value
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value3 Physics.Value
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.xx.y Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.xx.z Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.xx.y Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.xx.z Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value

        # x_block x y_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics.Value run scoreboard players operation #Physics.CrossProductAxis.xy.y Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value *= #Physics.Maths.SquareRoot.Input Physics.Value
            scoreboard players operation #Physics.Maths.Temp.Value4 Physics.Value *= #Physics.Maths.Temp.Value4 Physics.Value
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value4 Physics.Value
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.xy.y Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.xy.z Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.xy.y Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.xy.z Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value

        # x_block x z_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics.Value run scoreboard players operation #Physics.CrossProductAxis.xz.y Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value *= #Physics.Maths.SquareRoot.Input Physics.Value
            scoreboard players operation #Physics.Maths.Temp.Value5 Physics.Value *= #Physics.Maths.Temp.Value5 Physics.Value
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value5 Physics.Value
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.xz.y Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.xz.z Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.xz.y Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.xz.z Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value

        # y_block x x_object
            # Calculation (y_block => The x component is z from the object's axis, the y component is always 0, and the z component is -x from the object's axis)
            execute store result score #Physics.Maths.SquareRoot.Input Physics.Value run scoreboard players operation #Physics.CrossProductAxis.yx.z Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value *= #Physics.Maths.SquareRoot.Input Physics.Value
            scoreboard players operation #Physics.Maths.Temp.Value6 Physics.Value *= #Physics.Maths.Temp.Value6 Physics.Value
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value6 Physics.Value
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.yx.x Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.yx.z Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.yx.x Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.yx.z Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value

        # y_block x y_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics.Value run scoreboard players operation #Physics.CrossProductAxis.yy.z Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value *= #Physics.Maths.SquareRoot.Input Physics.Value
            scoreboard players operation #Physics.Maths.Temp.Value7 Physics.Value *= #Physics.Maths.Temp.Value7 Physics.Value
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value7 Physics.Value
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.yy.x Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.yy.z Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.yy.x Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.yy.z Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value

        # y_block x z_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics.Value run scoreboard players operation #Physics.CrossProductAxis.yz.z Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value *= #Physics.Maths.SquareRoot.Input Physics.Value
            scoreboard players operation #Physics.Maths.Temp.Value8 Physics.Value *= #Physics.Maths.Temp.Value8 Physics.Value
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value8 Physics.Value
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.yz.x Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.yz.z Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.yz.x Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.yz.z Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value

        # z_block x x_object
            # Calculation (z_block => The x component is -y from the object's axis, the y component is x from the object's axis, and the z component is always 0)
            execute store result score #Physics.Maths.SquareRoot.Input Physics.Value run scoreboard players operation #Physics.CrossProductAxis.zx.x Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value *= #Physics.Maths.SquareRoot.Input Physics.Value
            scoreboard players operation #Physics.Maths.Temp.Value9 Physics.Value *= #Physics.Maths.Temp.Value9 Physics.Value
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value9 Physics.Value
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.zx.x Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.zx.y Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.zx.x Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.zx.y Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value

        # z_block x y_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics.Value run scoreboard players operation #Physics.CrossProductAxis.zy.x Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value *= #Physics.Maths.SquareRoot.Input Physics.Value
            scoreboard players operation #Physics.Maths.Temp.Value10 Physics.Value *= #Physics.Maths.Temp.Value10 Physics.Value
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value10 Physics.Value
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.zy.x Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.zy.y Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.zy.x Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.zy.y Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value

        # z_block x z_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics.Value run scoreboard players operation #Physics.CrossProductAxis.zz.x Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value *= #Physics.Maths.SquareRoot.Input Physics.Value
            scoreboard players operation #Physics.Maths.Temp.Value11 Physics.Value *= #Physics.Maths.Temp.Value11 Physics.Value
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value11 Physics.Value
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.zz.x Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.zz.y Physics.Value *= #Physics.Constants.1000 Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.zz.x Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
            scoreboard players operation #Physics.CrossProductAxis.zz.y Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value

    # Project the 8 corner points of world-geometry voxels onto the 3 object axes and the 9 cross products, using relative coordinates from the voxel position
    # (Important): Because the position of the voxels is their center instead of their coordinate origin, the projections of 4 corners are the just mirrored versions of the other 4. This means I can simply project 4 points, flip the sign to get the other 4 points, then use those 8 points to get the max on that axis. Then flip the sign on the max again to get the min.
    # (Important): Some mid-results can be re-used using "execute store result ..." to prevent repeated calculation, because for instance -500*<y axis component>, -500*<x axis component>, 500*<x axis component>, -500*<z axis component> and 500*<z axis component> are used several times
        # x_object
            # Corner 0 [-500, -500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.ObjectAxis.x Physics.Value -500
            execute store result score #Physics.Projection.VoxelCorner2.ObjectAxis.x Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.x Physics.Value *= #Physics.ObjectAxis.x.y Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value1 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.ObjectAxis.x.x Physics.Value
            execute store result score #Physics.Projection.VoxelCorner1.ObjectAxis.x Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.x Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value2 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.ObjectAxis.x.z Physics.Value
            execute store result score #Physics.Projection.VoxelCorner7 Physics.Value store result score #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.x Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner6 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner1.ObjectAxis.x Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 2 [500, -500, -500]
            scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.x Physics.Value *= #Physics.Constants.-1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner3.ObjectAxis.x Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.x Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner5 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.x Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner4 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner3.ObjectAxis.x Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.VoxelCorner4.ObjectAxis.x Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner5.ObjectAxis.x Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner6.ObjectAxis.x Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner7.ObjectAxis.x Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.ObjectAxis.x Physics.Value > #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value = #Physics.Projection.VoxelCorner1.ObjectAxis.x Physics.Value
            execute if score #Physics.Projection.VoxelCorner2.ObjectAxis.x Physics.Value > #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value = #Physics.Projection.VoxelCorner2.ObjectAxis.x Physics.Value
            execute if score #Physics.Projection.VoxelCorner3.ObjectAxis.x Physics.Value > #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value = #Physics.Projection.VoxelCorner3.ObjectAxis.x Physics.Value
            execute if score #Physics.Projection.VoxelCorner4.ObjectAxis.x Physics.Value > #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value = #Physics.Projection.VoxelCorner4.ObjectAxis.x Physics.Value
            execute if score #Physics.Projection.VoxelCorner5.ObjectAxis.x Physics.Value > #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value = #Physics.Projection.VoxelCorner5.ObjectAxis.x Physics.Value
            execute if score #Physics.Projection.VoxelCorner6.ObjectAxis.x Physics.Value > #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value = #Physics.Projection.VoxelCorner6.ObjectAxis.x Physics.Value
            execute if score #Physics.Projection.VoxelCorner7.ObjectAxis.x Physics.Value > #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value = #Physics.Projection.VoxelCorner7.ObjectAxis.x Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Min Physics.Value = #Physics.Projection.Voxel.ObjectAxis.x.Max Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Min Physics.Value *= #Physics.Constants.-1 Physics.Value

        # y_object
            # Corner 0 [-500, -500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.ObjectAxis.y Physics.Value -500
            execute store result score #Physics.Projection.VoxelCorner2.ObjectAxis.y Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.y Physics.Value *= #Physics.ObjectAxis.y.y Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value1 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.ObjectAxis.y.x Physics.Value
            execute store result score #Physics.Projection.VoxelCorner1.ObjectAxis.y Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.y Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value2 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.ObjectAxis.y.z Physics.Value
            execute store result score #Physics.Projection.VoxelCorner7 Physics.Value store result score #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.y Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner6 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner1.ObjectAxis.y Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 2 [500, -500, -500]
            scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.y Physics.Value *= #Physics.Constants.-1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner3.ObjectAxis.y Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.y Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner5 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.y Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner4 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner3.ObjectAxis.y Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.VoxelCorner4.ObjectAxis.y Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner5.ObjectAxis.y Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner6.ObjectAxis.y Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner7.ObjectAxis.y Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.ObjectAxis.y Physics.Value > #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value = #Physics.Projection.VoxelCorner1.ObjectAxis.y Physics.Value
            execute if score #Physics.Projection.VoxelCorner2.ObjectAxis.y Physics.Value > #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value = #Physics.Projection.VoxelCorner2.ObjectAxis.y Physics.Value
            execute if score #Physics.Projection.VoxelCorner3.ObjectAxis.y Physics.Value > #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value = #Physics.Projection.VoxelCorner3.ObjectAxis.y Physics.Value
            execute if score #Physics.Projection.VoxelCorner4.ObjectAxis.y Physics.Value > #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value = #Physics.Projection.VoxelCorner4.ObjectAxis.y Physics.Value
            execute if score #Physics.Projection.VoxelCorner5.ObjectAxis.y Physics.Value > #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value = #Physics.Projection.VoxelCorner5.ObjectAxis.y Physics.Value
            execute if score #Physics.Projection.VoxelCorner6.ObjectAxis.y Physics.Value > #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value = #Physics.Projection.VoxelCorner6.ObjectAxis.y Physics.Value
            execute if score #Physics.Projection.VoxelCorner7.ObjectAxis.y Physics.Value > #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value = #Physics.Projection.VoxelCorner7.ObjectAxis.y Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Min Physics.Value = #Physics.Projection.Voxel.ObjectAxis.y.Max Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Min Physics.Value *= #Physics.Constants.-1 Physics.Value

        # z_object
            # Corner 0 [-500, -500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.ObjectAxis.z Physics.Value -500
            execute store result score #Physics.Projection.VoxelCorner2.ObjectAxis.z Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.z Physics.Value *= #Physics.ObjectAxis.z.y Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value1 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.ObjectAxis.z.x Physics.Value
            execute store result score #Physics.Projection.VoxelCorner1.ObjectAxis.z Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.z Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value2 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.ObjectAxis.z.z Physics.Value
            execute store result score #Physics.Projection.VoxelCorner7 Physics.Value store result score #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.z Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner6 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner1.ObjectAxis.z Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 2 [500, -500, -500]
            scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.z Physics.Value *= #Physics.Constants.-1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner3.ObjectAxis.z Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.z Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner5 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.z Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner4 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner3.ObjectAxis.z Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.VoxelCorner4.ObjectAxis.z Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner5.ObjectAxis.z Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner6.ObjectAxis.z Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner7.ObjectAxis.z Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.ObjectAxis.z Physics.Value > #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value = #Physics.Projection.VoxelCorner1.ObjectAxis.z Physics.Value
            execute if score #Physics.Projection.VoxelCorner2.ObjectAxis.z Physics.Value > #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value = #Physics.Projection.VoxelCorner2.ObjectAxis.z Physics.Value
            execute if score #Physics.Projection.VoxelCorner3.ObjectAxis.z Physics.Value > #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value = #Physics.Projection.VoxelCorner3.ObjectAxis.z Physics.Value
            execute if score #Physics.Projection.VoxelCorner4.ObjectAxis.z Physics.Value > #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value = #Physics.Projection.VoxelCorner4.ObjectAxis.z Physics.Value
            execute if score #Physics.Projection.VoxelCorner5.ObjectAxis.z Physics.Value > #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value = #Physics.Projection.VoxelCorner5.ObjectAxis.z Physics.Value
            execute if score #Physics.Projection.VoxelCorner6.ObjectAxis.z Physics.Value > #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value = #Physics.Projection.VoxelCorner6.ObjectAxis.z Physics.Value
            execute if score #Physics.Projection.VoxelCorner7.ObjectAxis.z Physics.Value > #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value = #Physics.Projection.VoxelCorner7.ObjectAxis.z Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Min Physics.Value = #Physics.Projection.Voxel.ObjectAxis.z.Max Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Min Physics.Value *= #Physics.Constants.-1 Physics.Value

        # Cross Product: x_block x x_object
            # Corner 0 [-500, -500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.xx Physics.Value -500
            execute store result score #Physics.Projection.VoxelCorner2.CrossProductAxis.xx Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.xx Physics.Value *= #Physics.CrossProductAxis.xx.y Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value1 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.CrossProductAxis.xx.x Physics.Value
            execute store result score #Physics.Projection.VoxelCorner1.CrossProductAxis.xx Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.xx Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value2 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.CrossProductAxis.xx.z Physics.Value
            execute store result score #Physics.Projection.VoxelCorner7 Physics.Value store result score #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.xx Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner6 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner1.CrossProductAxis.xx Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 2 [500, -500, -500]
            scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.xx Physics.Value *= #Physics.Constants.-1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner3.CrossProductAxis.xx Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.xx Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner5 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.xx Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner4 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner3.CrossProductAxis.xx Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.VoxelCorner4.CrossProductAxis.xx Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner5.CrossProductAxis.xx Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner6.CrossProductAxis.xx Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner7.CrossProductAxis.xx Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.CrossProductAxis.xx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value = #Physics.Projection.VoxelCorner1.CrossProductAxis.xx Physics.Value
            execute if score #Physics.Projection.VoxelCorner2.CrossProductAxis.xx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value = #Physics.Projection.VoxelCorner2.CrossProductAxis.xx Physics.Value
            execute if score #Physics.Projection.VoxelCorner3.CrossProductAxis.xx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value = #Physics.Projection.VoxelCorner3.CrossProductAxis.xx Physics.Value
            execute if score #Physics.Projection.VoxelCorner4.CrossProductAxis.xx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value = #Physics.Projection.VoxelCorner4.CrossProductAxis.xx Physics.Value
            execute if score #Physics.Projection.VoxelCorner5.CrossProductAxis.xx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value = #Physics.Projection.VoxelCorner5.CrossProductAxis.xx Physics.Value
            execute if score #Physics.Projection.VoxelCorner6.CrossProductAxis.xx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value = #Physics.Projection.VoxelCorner6.CrossProductAxis.xx Physics.Value
            execute if score #Physics.Projection.VoxelCorner7.CrossProductAxis.xx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value = #Physics.Projection.VoxelCorner7.CrossProductAxis.xx Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Min Physics.Value = #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Min Physics.Value *= #Physics.Constants.-1 Physics.Value

        # Cross Product: x_block x y_object
            # Corner 0 [-500, -500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.xy Physics.Value -500
            execute store result score #Physics.Projection.VoxelCorner2.CrossProductAxis.xy Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.xy Physics.Value *= #Physics.CrossProductAxis.xy.y Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value1 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.CrossProductAxis.xy.x Physics.Value
            execute store result score #Physics.Projection.VoxelCorner1.CrossProductAxis.xy Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.xy Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value2 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.CrossProductAxis.xy.z Physics.Value
            execute store result score #Physics.Projection.VoxelCorner7 Physics.Value store result score #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.xy Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner6 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner1.CrossProductAxis.xy Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 2 [500, -500, -500]
            scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.xy Physics.Value *= #Physics.Constants.-1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner3.CrossProductAxis.xy Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.xy Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner5 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.xy Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner4 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner3.CrossProductAxis.xy Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.VoxelCorner4.CrossProductAxis.xy Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner5.CrossProductAxis.xy Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner6.CrossProductAxis.xy Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner7.CrossProductAxis.xy Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.CrossProductAxis.xy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value = #Physics.Projection.VoxelCorner1.CrossProductAxis.xy Physics.Value
            execute if score #Physics.Projection.VoxelCorner2.CrossProductAxis.xy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value = #Physics.Projection.VoxelCorner2.CrossProductAxis.xy Physics.Value
            execute if score #Physics.Projection.VoxelCorner3.CrossProductAxis.xy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value = #Physics.Projection.VoxelCorner3.CrossProductAxis.xy Physics.Value
            execute if score #Physics.Projection.VoxelCorner4.CrossProductAxis.xy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value = #Physics.Projection.VoxelCorner4.CrossProductAxis.xy Physics.Value
            execute if score #Physics.Projection.VoxelCorner5.CrossProductAxis.xy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value = #Physics.Projection.VoxelCorner5.CrossProductAxis.xy Physics.Value
            execute if score #Physics.Projection.VoxelCorner6.CrossProductAxis.xy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value = #Physics.Projection.VoxelCorner6.CrossProductAxis.xy Physics.Value
            execute if score #Physics.Projection.VoxelCorner7.CrossProductAxis.xy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value = #Physics.Projection.VoxelCorner7.CrossProductAxis.xy Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Min Physics.Value = #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Min Physics.Value *= #Physics.Constants.-1 Physics.Value

        # Cross Product: x_block x z_object
            # Corner 0 [-500, -500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.xz Physics.Value -500
            execute store result score #Physics.Projection.VoxelCorner2.CrossProductAxis.xz Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.xz Physics.Value *= #Physics.CrossProductAxis.xz.y Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value1 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.CrossProductAxis.xz.x Physics.Value
            execute store result score #Physics.Projection.VoxelCorner1.CrossProductAxis.xz Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.xz Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value2 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.CrossProductAxis.xz.z Physics.Value
            execute store result score #Physics.Projection.VoxelCorner7 Physics.Value store result score #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.xz Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner6 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner1.CrossProductAxis.xz Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 2 [500, -500, -500]
            scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.xz Physics.Value *= #Physics.Constants.-1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner3.CrossProductAxis.xz Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.xz Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner5 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.xz Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner4 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner3.CrossProductAxis.xz Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.VoxelCorner4.CrossProductAxis.xz Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner5.CrossProductAxis.xz Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner6.CrossProductAxis.xz Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner7.CrossProductAxis.xz Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.CrossProductAxis.xz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value = #Physics.Projection.VoxelCorner1.CrossProductAxis.xz Physics.Value
            execute if score #Physics.Projection.VoxelCorner2.CrossProductAxis.xz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value = #Physics.Projection.VoxelCorner2.CrossProductAxis.xz Physics.Value
            execute if score #Physics.Projection.VoxelCorner3.CrossProductAxis.xz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value = #Physics.Projection.VoxelCorner3.CrossProductAxis.xz Physics.Value
            execute if score #Physics.Projection.VoxelCorner4.CrossProductAxis.xz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value = #Physics.Projection.VoxelCorner4.CrossProductAxis.xz Physics.Value
            execute if score #Physics.Projection.VoxelCorner5.CrossProductAxis.xz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value = #Physics.Projection.VoxelCorner5.CrossProductAxis.xz Physics.Value
            execute if score #Physics.Projection.VoxelCorner6.CrossProductAxis.xz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value = #Physics.Projection.VoxelCorner6.CrossProductAxis.xz Physics.Value
            execute if score #Physics.Projection.VoxelCorner7.CrossProductAxis.xz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value = #Physics.Projection.VoxelCorner7.CrossProductAxis.xz Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Min Physics.Value = #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Min Physics.Value *= #Physics.Constants.-1 Physics.Value

        # Cross Product: y_block x x_object
            # Corner 0 [-500, -500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.yx Physics.Value -500
            execute store result score #Physics.Projection.VoxelCorner2.CrossProductAxis.yx Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.yx Physics.Value *= #Physics.CrossProductAxis.yx.y Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value1 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.CrossProductAxis.yx.x Physics.Value
            execute store result score #Physics.Projection.VoxelCorner1.CrossProductAxis.yx Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.yx Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value2 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.CrossProductAxis.yx.z Physics.Value
            execute store result score #Physics.Projection.VoxelCorner7 Physics.Value store result score #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.yx Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner6 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner1.CrossProductAxis.yx Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 2 [500, -500, -500]
            scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.yx Physics.Value *= #Physics.Constants.-1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner3.CrossProductAxis.yx Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.yx Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner5 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.yx Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner4 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner3.CrossProductAxis.yx Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.VoxelCorner4.CrossProductAxis.yx Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner5.CrossProductAxis.yx Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner6.CrossProductAxis.yx Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner7.CrossProductAxis.yx Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.CrossProductAxis.yx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value = #Physics.Projection.VoxelCorner1.CrossProductAxis.yx Physics.Value
            execute if score #Physics.Projection.VoxelCorner2.CrossProductAxis.yx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value = #Physics.Projection.VoxelCorner2.CrossProductAxis.yx Physics.Value
            execute if score #Physics.Projection.VoxelCorner3.CrossProductAxis.yx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value = #Physics.Projection.VoxelCorner3.CrossProductAxis.yx Physics.Value
            execute if score #Physics.Projection.VoxelCorner4.CrossProductAxis.yx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value = #Physics.Projection.VoxelCorner4.CrossProductAxis.yx Physics.Value
            execute if score #Physics.Projection.VoxelCorner5.CrossProductAxis.yx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value = #Physics.Projection.VoxelCorner5.CrossProductAxis.yx Physics.Value
            execute if score #Physics.Projection.VoxelCorner6.CrossProductAxis.yx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value = #Physics.Projection.VoxelCorner6.CrossProductAxis.yx Physics.Value
            execute if score #Physics.Projection.VoxelCorner7.CrossProductAxis.yx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value = #Physics.Projection.VoxelCorner7.CrossProductAxis.yx Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Min Physics.Value = #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Min Physics.Value *= #Physics.Constants.-1 Physics.Value

        # Cross Product: y_block x y_object
            # Corner 0 [-500, -500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.yy Physics.Value -500
            execute store result score #Physics.Projection.VoxelCorner2.CrossProductAxis.yy Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.yy Physics.Value *= #Physics.CrossProductAxis.yy.y Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value1 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.CrossProductAxis.yy.x Physics.Value
            execute store result score #Physics.Projection.VoxelCorner1.CrossProductAxis.yy Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.yy Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value2 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.CrossProductAxis.yy.z Physics.Value
            execute store result score #Physics.Projection.VoxelCorner7 Physics.Value store result score #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.yy Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner6 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner1.CrossProductAxis.yy Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 2 [500, -500, -500]
            scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.yy Physics.Value *= #Physics.Constants.-1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner3.CrossProductAxis.yy Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.yy Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner5 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.yy Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner4 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner3.CrossProductAxis.yy Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.VoxelCorner4.CrossProductAxis.yy Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner5.CrossProductAxis.yy Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner6.CrossProductAxis.yy Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner7.CrossProductAxis.yy Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.CrossProductAxis.yy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value = #Physics.Projection.VoxelCorner1.CrossProductAxis.yy Physics.Value
            execute if score #Physics.Projection.VoxelCorner2.CrossProductAxis.yy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value = #Physics.Projection.VoxelCorner2.CrossProductAxis.yy Physics.Value
            execute if score #Physics.Projection.VoxelCorner3.CrossProductAxis.yy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value = #Physics.Projection.VoxelCorner3.CrossProductAxis.yy Physics.Value
            execute if score #Physics.Projection.VoxelCorner4.CrossProductAxis.yy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value = #Physics.Projection.VoxelCorner4.CrossProductAxis.yy Physics.Value
            execute if score #Physics.Projection.VoxelCorner5.CrossProductAxis.yy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value = #Physics.Projection.VoxelCorner5.CrossProductAxis.yy Physics.Value
            execute if score #Physics.Projection.VoxelCorner6.CrossProductAxis.yy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value = #Physics.Projection.VoxelCorner6.CrossProductAxis.yy Physics.Value
            execute if score #Physics.Projection.VoxelCorner7.CrossProductAxis.yy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value = #Physics.Projection.VoxelCorner7.CrossProductAxis.yy Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Min Physics.Value = #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Min Physics.Value *= #Physics.Constants.-1 Physics.Value

        # Cross Product: y_block x z_object
            # Corner 0 [-500, -500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.yz Physics.Value -500
            execute store result score #Physics.Projection.VoxelCorner2.CrossProductAxis.yz Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.yz Physics.Value *= #Physics.CrossProductAxis.yz.y Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value1 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.CrossProductAxis.yz.x Physics.Value
            execute store result score #Physics.Projection.VoxelCorner1.CrossProductAxis.yz Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.yz Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value2 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.CrossProductAxis.yz.z Physics.Value
            execute store result score #Physics.Projection.VoxelCorner7 Physics.Value store result score #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.yz Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner6 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner1.CrossProductAxis.yz Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 2 [500, -500, -500]
            scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.yz Physics.Value *= #Physics.Constants.-1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner3.CrossProductAxis.yz Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.yz Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner5 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.yz Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner4 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner3.CrossProductAxis.yz Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.VoxelCorner4.CrossProductAxis.yz Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner5.CrossProductAxis.yz Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner6.CrossProductAxis.yz Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner7.CrossProductAxis.yz Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.CrossProductAxis.yz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value = #Physics.Projection.VoxelCorner1.CrossProductAxis.yz Physics.Value
            execute if score #Physics.Projection.VoxelCorner2.CrossProductAxis.yz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value = #Physics.Projection.VoxelCorner2.CrossProductAxis.yz Physics.Value
            execute if score #Physics.Projection.VoxelCorner3.CrossProductAxis.yz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value = #Physics.Projection.VoxelCorner3.CrossProductAxis.yz Physics.Value
            execute if score #Physics.Projection.VoxelCorner4.CrossProductAxis.yz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value = #Physics.Projection.VoxelCorner4.CrossProductAxis.yz Physics.Value
            execute if score #Physics.Projection.VoxelCorner5.CrossProductAxis.yz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value = #Physics.Projection.VoxelCorner5.CrossProductAxis.yz Physics.Value
            execute if score #Physics.Projection.VoxelCorner6.CrossProductAxis.yz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value = #Physics.Projection.VoxelCorner6.CrossProductAxis.yz Physics.Value
            execute if score #Physics.Projection.VoxelCorner7.CrossProductAxis.yz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value = #Physics.Projection.VoxelCorner7.CrossProductAxis.yz Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Min Physics.Value = #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Min Physics.Value *= #Physics.Constants.-1 Physics.Value

        # Cross Product: z_block x x_object
            # Corner 0 [-500, -500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.zx Physics.Value -500
            execute store result score #Physics.Projection.VoxelCorner2.CrossProductAxis.zx Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.zx Physics.Value *= #Physics.CrossProductAxis.zx.y Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value1 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.CrossProductAxis.zx.x Physics.Value
            execute store result score #Physics.Projection.VoxelCorner1.CrossProductAxis.zx Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.zx Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value2 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.CrossProductAxis.zx.z Physics.Value
            execute store result score #Physics.Projection.VoxelCorner7 Physics.Value store result score #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.zx Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner6 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner1.CrossProductAxis.zx Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 2 [500, -500, -500]
            scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.zx Physics.Value *= #Physics.Constants.-1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner3.CrossProductAxis.zx Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.zx Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner5 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.zx Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner4 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner3.CrossProductAxis.zx Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.VoxelCorner4.CrossProductAxis.zx Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner5.CrossProductAxis.zx Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner6.CrossProductAxis.zx Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner7.CrossProductAxis.zx Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.CrossProductAxis.zx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value = #Physics.Projection.VoxelCorner1.CrossProductAxis.zx Physics.Value
            execute if score #Physics.Projection.VoxelCorner2.CrossProductAxis.zx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value = #Physics.Projection.VoxelCorner2.CrossProductAxis.zx Physics.Value
            execute if score #Physics.Projection.VoxelCorner3.CrossProductAxis.zx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value = #Physics.Projection.VoxelCorner3.CrossProductAxis.zx Physics.Value
            execute if score #Physics.Projection.VoxelCorner4.CrossProductAxis.zx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value = #Physics.Projection.VoxelCorner4.CrossProductAxis.zx Physics.Value
            execute if score #Physics.Projection.VoxelCorner5.CrossProductAxis.zx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value = #Physics.Projection.VoxelCorner5.CrossProductAxis.zx Physics.Value
            execute if score #Physics.Projection.VoxelCorner6.CrossProductAxis.zx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value = #Physics.Projection.VoxelCorner6.CrossProductAxis.zx Physics.Value
            execute if score #Physics.Projection.VoxelCorner7.CrossProductAxis.zx Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value = #Physics.Projection.VoxelCorner7.CrossProductAxis.zx Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Min Physics.Value = #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Min Physics.Value *= #Physics.Constants.-1 Physics.Value

        # Cross Product: z_block x y_object
            # Corner 0 [-500, -500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.zy Physics.Value -500
            execute store result score #Physics.Projection.VoxelCorner2.CrossProductAxis.zy Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.zy Physics.Value *= #Physics.CrossProductAxis.zy.y Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value1 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.CrossProductAxis.zy.x Physics.Value
            execute store result score #Physics.Projection.VoxelCorner1.CrossProductAxis.zy Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.zy Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value2 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.CrossProductAxis.zy.z Physics.Value
            execute store result score #Physics.Projection.VoxelCorner7 Physics.Value store result score #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.zy Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner6 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner1.CrossProductAxis.zy Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 2 [500, -500, -500]
            scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.zy Physics.Value *= #Physics.Constants.-1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner3.CrossProductAxis.zy Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.zy Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner5 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.zy Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner4 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner3.CrossProductAxis.zy Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.VoxelCorner4.CrossProductAxis.zy Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner5.CrossProductAxis.zy Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner6.CrossProductAxis.zy Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner7.CrossProductAxis.zy Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.CrossProductAxis.zy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value = #Physics.Projection.VoxelCorner1.CrossProductAxis.zy Physics.Value
            execute if score #Physics.Projection.VoxelCorner2.CrossProductAxis.zy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value = #Physics.Projection.VoxelCorner2.CrossProductAxis.zy Physics.Value
            execute if score #Physics.Projection.VoxelCorner3.CrossProductAxis.zy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value = #Physics.Projection.VoxelCorner3.CrossProductAxis.zy Physics.Value
            execute if score #Physics.Projection.VoxelCorner4.CrossProductAxis.zy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value = #Physics.Projection.VoxelCorner4.CrossProductAxis.zy Physics.Value
            execute if score #Physics.Projection.VoxelCorner5.CrossProductAxis.zy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value = #Physics.Projection.VoxelCorner5.CrossProductAxis.zy Physics.Value
            execute if score #Physics.Projection.VoxelCorner6.CrossProductAxis.zy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value = #Physics.Projection.VoxelCorner6.CrossProductAxis.zy Physics.Value
            execute if score #Physics.Projection.VoxelCorner7.CrossProductAxis.zy Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value = #Physics.Projection.VoxelCorner7.CrossProductAxis.zy Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Min Physics.Value = #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Min Physics.Value *= #Physics.Constants.-1 Physics.Value

        # Cross Product: z_block x z_object
            # Corner 0 [-500, -500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.zz Physics.Value -500
            execute store result score #Physics.Projection.VoxelCorner2.CrossProductAxis.zz Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.zz Physics.Value *= #Physics.CrossProductAxis.zz.y Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value1 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.CrossProductAxis.zz.x Physics.Value
            execute store result score #Physics.Projection.VoxelCorner1.CrossProductAxis.zz Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.zz Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value

            scoreboard players set #Physics.Maths.Temp.Value2 Physics.Value -500
            scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.CrossProductAxis.zz.z Physics.Value
            execute store result score #Physics.Projection.VoxelCorner7 Physics.Value store result score #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.zz Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner6 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner1.CrossProductAxis.zz Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 2 [500, -500, -500]
            scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.zz Physics.Value *= #Physics.Constants.-1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner3.CrossProductAxis.zz Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.zz Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
            execute store result score #Physics.Projection.VoxelCorner5 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.zz Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner4 Physics.Value run scoreboard players operation #Physics.Projection.VoxelCorner3.CrossProductAxis.zz Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.VoxelCorner4.CrossProductAxis.zz Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner5.CrossProductAxis.zz Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner6.CrossProductAxis.zz Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner7.CrossProductAxis.zz Physics.Value *= #Physics.Constants.-1 Physics.Value

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.CrossProductAxis.zz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value = #Physics.Projection.VoxelCorner1.CrossProductAxis.zz Physics.Value
            execute if score #Physics.Projection.VoxelCorner2.CrossProductAxis.zz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value = #Physics.Projection.VoxelCorner2.CrossProductAxis.zz Physics.Value
            execute if score #Physics.Projection.VoxelCorner3.CrossProductAxis.zz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value = #Physics.Projection.VoxelCorner3.CrossProductAxis.zz Physics.Value
            execute if score #Physics.Projection.VoxelCorner4.CrossProductAxis.zz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value = #Physics.Projection.VoxelCorner4.CrossProductAxis.zz Physics.Value
            execute if score #Physics.Projection.VoxelCorner5.CrossProductAxis.zz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value = #Physics.Projection.VoxelCorner5.CrossProductAxis.zz Physics.Value
            execute if score #Physics.Projection.VoxelCorner6.CrossProductAxis.zz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value = #Physics.Projection.VoxelCorner6.CrossProductAxis.zz Physics.Value
            execute if score #Physics.Projection.VoxelCorner7.CrossProductAxis.zz Physics.Value > #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value = #Physics.Projection.VoxelCorner7.CrossProductAxis.zz Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Min Physics.Value = #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics.Value
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Min Physics.Value *= #Physics.Constants.-1 Physics.Value

# Iterate through every minecraft block that intersects with the interaction entity's hitbox (AABB), so I can then perform the Separating Axes Theorem (SAT) to check for fine collisions
# (Important): I only have the global coords for the bounding box, so instead of using a few scoreboard commands, I just don't use relative coordinates here. If I do need the relative coordinates later, I will change that
execute store result storage physics:temp data.StartX double 0.001 run scoreboard players get @s Physics.Object.BoundingBoxGlobalMin.x
execute store result storage physics:temp data.StartY double 0.001 run scoreboard players get @s Physics.Object.BoundingBoxGlobalMin.y
execute store result storage physics:temp data.StartZ double 0.001 run scoreboard players get @s Physics.Object.BoundingBoxGlobalMin.z
execute store result storage physics:temp data.StepCountX byte 1 run scoreboard players get @s Physics.Object.BoundingBoxStepCount.x
execute store result storage physics:temp data.StepCountY byte 1 run scoreboard players get @s Physics.Object.BoundingBoxStepCount.y
execute store result storage physics:temp data.StepCountZ byte 1 run scoreboard players get @s Physics.Object.BoundingBoxStepCount.z

execute at @s run function physics:zprivate/collision_detection/coarse/main_voxel_grid with storage physics:temp data

# Check for coarse collisions with other dynamic objects, so I can then perform the SAT to check for fine collisions
# (Important): Only checks objects in a range of 6.929 blocks, which is the sum of both objects' maximum supported bounding box divided by 2 (so from the center of both entities), assuming I cap the dimensions at 4 blocks. The reasoning is explained in the set_attributes/dimension function.
tag @s add Physics.Checked
scoreboard players operation #Physics.OtherObject Physics.Object.ID = @s Physics.Object.ID
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxGlobalMin.x = @s Physics.Object.BoundingBoxGlobalMin.x
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxGlobalMax.x = @s Physics.Object.BoundingBoxGlobalMax.x
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxGlobalMin.y = @s Physics.Object.BoundingBoxGlobalMin.y
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxGlobalMax.y = @s Physics.Object.BoundingBoxGlobalMax.y
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxGlobalMin.z = @s Physics.Object.BoundingBoxGlobalMin.z
scoreboard players operation #Physics.OtherObject Physics.Object.BoundingBoxGlobalMax.z = @s Physics.Object.BoundingBoxGlobalMax.z
execute at @s as @e[type=minecraft:item_display,tag=Physics.Object,tag=!Physics.Checked,distance=..6.929] if score @s Physics.Object.BoundingBoxGlobalMin.x <= #Physics.OtherObject Physics.Object.BoundingBoxGlobalMax.x if score #Physics.OtherObject Physics.Object.BoundingBoxGlobalMin.x <= @s Physics.Object.BoundingBoxGlobalMax.x if score @s Physics.Object.BoundingBoxGlobalMin.z <= #Physics.OtherObject Physics.Object.BoundingBoxGlobalMax.z if score #Physics.OtherObject Physics.Object.BoundingBoxGlobalMin.z <= @s Physics.Object.BoundingBoxGlobalMax.z if score @s Physics.Object.BoundingBoxGlobalMin.y <= #Physics.OtherObject Physics.Object.BoundingBoxGlobalMax.y if score #Physics.OtherObject Physics.Object.BoundingBoxGlobalMin.y <= @s Physics.Object.BoundingBoxGlobalMax.y run particle flame ~ ~ ~ 0.3 0.3 0.3 0 1
