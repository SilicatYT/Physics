# Pre-calculate as much as possible for the voxel grid SAT
    # 9 cross products of the 3 axes of the object and the world-geometry voxel
    # (Important): Because for instance the x axis of the voxel (block) only has its x component set, this results in a cross product whose x component is not set. I make several of these implications directly and don't even set certain values if the solution is always the same value. Then I work with that value directly.
    # (Important): Just like in several other parts of the code, I use "execute store result" when a value is calculated to create copies, instead of manually running "scoreboard players operation ... = ...", because the former is faster.
        # Get scores
        # (Important): Using store result to prevent repeated scoreboard operations. I think it should still be faster this way, even if I have to run a "get" command instead of being able to prepend the store result to where the value is calculated?
        execute store result score #Physics.CrossProductAxis.yx.z Physics store result score #Physics.CrossProductAxis.zx.y Physics store result score #Physics.Maths.Value9 Physics run scoreboard players get @s Physics.Object.Axis.x.x
        execute store result score #Physics.CrossProductAxis.xx.z Physics store result score #Physics.Maths.Value3 Physics store result score #Physics.CrossProductAxis.zx.x Physics run scoreboard players get @s Physics.Object.Axis.x.y
        execute store result score #Physics.CrossProductAxis.xx.y Physics store result score #Physics.CrossProductAxis.yx.x Physics store result score #Physics.Maths.Value6 Physics run scoreboard players get @s Physics.Object.Axis.x.z

        execute store result score #Physics.CrossProductAxis.yy.z Physics store result score #Physics.CrossProductAxis.zy.y Physics store result score #Physics.Maths.Value10 Physics run scoreboard players get @s Physics.Object.Axis.y.x
        execute store result score #Physics.CrossProductAxis.xy.z Physics store result score #Physics.Maths.Value4 Physics store result score #Physics.CrossProductAxis.zy.x Physics run scoreboard players get @s Physics.Object.Axis.y.y
        execute store result score #Physics.CrossProductAxis.xy.y Physics store result score #Physics.CrossProductAxis.yy.x Physics store result score #Physics.Maths.Value7 Physics run scoreboard players get @s Physics.Object.Axis.y.z

        execute store result score #Physics.CrossProductAxis.yz.z Physics store result score #Physics.CrossProductAxis.zz.y Physics store result score #Physics.Maths.Value11 Physics run scoreboard players get @s Physics.Object.Axis.z.x
        execute store result score #Physics.CrossProductAxis.xz.z Physics store result score #Physics.Maths.Value5 Physics store result score #Physics.CrossProductAxis.zz.x Physics run scoreboard players get @s Physics.Object.Axis.z.y
        execute store result score #Physics.CrossProductAxis.xz.y Physics store result score #Physics.CrossProductAxis.yz.x Physics store result score #Physics.Maths.Value8 Physics run scoreboard players get @s Physics.Object.Axis.z.z

        # x_block x x_object
            # Calculation (x_block => The x component is always 0, the y component is -z from the object's axis, and the z component is y from the object's axis)
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.xx.y Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.xx.y Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.xx.z Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics store result score #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.xx Physics store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.xx Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics run scoreboard players operation #Physics.CrossProductAxis.xx.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value12 Physics store result score #Physics.Maths.Value13 Physics store result score #Physics.Maths.Value14 Physics store result score #Physics.Maths.Value15 Physics store result score #Physics.Maths.Value16 Physics run scoreboard players operation #Physics.CrossProductAxis.xx.z Physics /= #Physics.Maths.SquareRoot.Output Physics

        # x_block x y_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.xy.y Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value4 Physics *= #Physics.Maths.Value4 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value4 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.xy.y Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.xy.z Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.xy Physics store result score #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.xy Physics store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.xy Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics run scoreboard players operation #Physics.CrossProductAxis.xy.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value17 Physics store result score #Physics.Maths.Value18 Physics store result score #Physics.Maths.Value19 Physics store result score #Physics.Maths.Value20 Physics store result score #Physics.Maths.Value21 Physics run scoreboard players operation #Physics.CrossProductAxis.xy.z Physics /= #Physics.Maths.SquareRoot.Output Physics

        # x_block x z_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.xz.y Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value5 Physics *= #Physics.Maths.Value5 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value5 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.xz.y Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.xz.z Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.xz Physics store result score #Physics.Projection.ObjectCorner1.CrossProductAxis.xz Physics store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.xz Physics store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.xz Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics run scoreboard players operation #Physics.CrossProductAxis.xz.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value22 Physics store result score #Physics.Maths.Value23 Physics store result score #Physics.Maths.Value24 Physics store result score #Physics.Maths.Value25 Physics store result score #Physics.Maths.Value26 Physics run scoreboard players operation #Physics.CrossProductAxis.xz.z Physics /= #Physics.Maths.SquareRoot.Output Physics

        # y_block x x_object
            # Calculation (y_block => The x component is z from the object's axis, the y component is always 0, and the z component is -x from the object's axis)
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.yx.z Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value6 Physics *= #Physics.Maths.Value6 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value6 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.yx.x Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.yx.z Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.yx Physics store result score #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.yx Physics store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.yx Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics run scoreboard players operation #Physics.CrossProductAxis.yx.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value27 Physics store result score #Physics.Maths.Value28 Physics store result score #Physics.Maths.Value29 Physics store result score #Physics.Maths.Value30 Physics store result score #Physics.Maths.Value31 Physics run scoreboard players operation #Physics.CrossProductAxis.yx.z Physics /= #Physics.Maths.SquareRoot.Output Physics

        # y_block x y_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.yy.z Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value7 Physics *= #Physics.Maths.Value7 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value7 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.yy.x Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.yy.z Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics store result score #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics run scoreboard players operation #Physics.CrossProductAxis.yy.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value32 Physics store result score #Physics.Maths.Value33 Physics store result score #Physics.Maths.Value34 Physics store result score #Physics.Maths.Value35 Physics store result score #Physics.Maths.Value36 Physics run scoreboard players operation #Physics.CrossProductAxis.yy.z Physics /= #Physics.Maths.SquareRoot.Output Physics

        # y_block x z_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.yz.z Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value8 Physics *= #Physics.Maths.Value8 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value8 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.yz.x Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.yz.z Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics store result score #Physics.Projection.ObjectCorner1.CrossProductAxis.yz Physics store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.yz Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics run scoreboard players operation #Physics.CrossProductAxis.yz.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value37 Physics store result score #Physics.Maths.Value38 Physics store result score #Physics.Maths.Value39 Physics store result score #Physics.Maths.Value40 Physics store result score #Physics.Maths.Value41 Physics run scoreboard players operation #Physics.CrossProductAxis.yz.z Physics /= #Physics.Maths.SquareRoot.Output Physics

        # z_block x x_object
            # Calculation (z_block => The x component is -y from the object's axis, the y component is x from the object's axis, and the z component is always 0)
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.zx.x Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value9 Physics *= #Physics.Maths.Value9 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value9 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.zx.x Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.zx.y Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.zx Physics store result score #Physics.Projection.ObjectCorner1.CrossProductAxis.zx Physics store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.zx Physics store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.zx Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics run scoreboard players operation #Physics.CrossProductAxis.zx.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value42 Physics store result score #Physics.Maths.Value43 Physics store result score #Physics.Maths.Value44 Physics store result score #Physics.Maths.Value45 Physics store result score #Physics.Maths.Value46 Physics run scoreboard players operation #Physics.CrossProductAxis.zx.y Physics /= #Physics.Maths.SquareRoot.Output Physics

        # z_block x y_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.zy.x Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value10 Physics *= #Physics.Maths.Value10 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value10 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.zy.x Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.zy.y Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.zy Physics store result score #Physics.Projection.ObjectCorner1.CrossProductAxis.zy Physics store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.zy Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics run scoreboard players operation #Physics.CrossProductAxis.zy.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value47 Physics store result score #Physics.Maths.Value48 Physics store result score #Physics.Maths.Value49 Physics store result score #Physics.Maths.Value50 Physics store result score #Physics.Maths.Value51 Physics run scoreboard players operation #Physics.CrossProductAxis.zy.y Physics /= #Physics.Maths.SquareRoot.Output Physics

        # z_block x z_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.zz.x Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value11 Physics *= #Physics.Maths.Value11 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value11 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.zz.x Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.zz.y Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.zz Physics store result score #Physics.Projection.ObjectCorner1.CrossProductAxis.zz Physics store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.zz Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics run scoreboard players operation #Physics.CrossProductAxis.zz.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value52 Physics store result score #Physics.Maths.Value53 Physics store result score #Physics.Maths.Value54 Physics store result score #Physics.Maths.Value55 Physics store result score #Physics.Maths.Value56 Physics run scoreboard players operation #Physics.CrossProductAxis.zz.y Physics /= #Physics.Maths.SquareRoot.Output Physics

    # Project the 8 corner points of world-geometry voxels onto the 3 object axes and the 9 cross products, using relative coordinates from the voxel position
    # (Important): Because the position of the voxels is their center instead of their coordinate origin, the projections of 4 corners are the just mirrored versions of the other 4. This means I can simply project 4 points, flip the sign to get the other 4 points, then use those 8 points to get the max on that axis. Then flip the sign on the max again to get the min.
    # (Important): Some mid-results can be re-used using "execute store result ..." to prevent repeated calculation, because for instance -500*<y axis component>, -500*<x axis component>, 500*<x axis component>, -500*<z axis component> and 500*<z axis component> are used several times
        # x_object
            # Corner 0 [-500, -500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.ObjectAxis.x Physics -500
            execute store result score #Physics.Projection.VoxelCorner2.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.x Physics *= @s Physics.Object.Axis.x.y

            scoreboard players set #Physics.Maths.Value1 Physics -500
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.x
            execute store result score #Physics.Projection.VoxelCorner1.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

            scoreboard players set #Physics.Maths.Value2 Physics -500
            scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Axis.x.z
            execute store result score #Physics.Projection.VoxelCorner7 Physics store result score #Physics.Projection.Voxel.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.x Physics += #Physics.Maths.Value2 Physics

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner6 Physics run scoreboard players operation #Physics.Projection.VoxelCorner1.ObjectAxis.x Physics -= #Physics.Maths.Value2 Physics

            # Corner 2 [500, -500, -500]
            scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics
            execute store result score #Physics.Projection.VoxelCorner3.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics
            execute store result score #Physics.Projection.VoxelCorner5 Physics run scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.x Physics += #Physics.Maths.Value2 Physics

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner4 Physics run scoreboard players operation #Physics.Projection.VoxelCorner3.ObjectAxis.x Physics -= #Physics.Maths.Value2 Physics

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.VoxelCorner4.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner5.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner6.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner7.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.ObjectAxis.x Physics > #Physics.Projection.Voxel.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics = #Physics.Projection.VoxelCorner1.ObjectAxis.x Physics
            execute if score #Physics.Projection.VoxelCorner2.ObjectAxis.x Physics > #Physics.Projection.Voxel.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics = #Physics.Projection.VoxelCorner2.ObjectAxis.x Physics
            execute if score #Physics.Projection.VoxelCorner3.ObjectAxis.x Physics > #Physics.Projection.Voxel.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics = #Physics.Projection.VoxelCorner3.ObjectAxis.x Physics
            execute if score #Physics.Projection.VoxelCorner4.ObjectAxis.x Physics > #Physics.Projection.Voxel.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics = #Physics.Projection.VoxelCorner4.ObjectAxis.x Physics
            execute if score #Physics.Projection.VoxelCorner5.ObjectAxis.x Physics > #Physics.Projection.Voxel.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics = #Physics.Projection.VoxelCorner5.ObjectAxis.x Physics
            execute if score #Physics.Projection.VoxelCorner6.ObjectAxis.x Physics > #Physics.Projection.Voxel.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics = #Physics.Projection.VoxelCorner6.ObjectAxis.x Physics
            execute if score #Physics.Projection.VoxelCorner7.ObjectAxis.x Physics > #Physics.Projection.Voxel.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Max Physics = #Physics.Projection.VoxelCorner7.ObjectAxis.x Physics
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Min Physics = #Physics.Projection.Voxel.ObjectAxis.x.Max Physics
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.x.Min Physics *= #Physics.Constants.-1 Physics

        # y_object
            # Corner 0 [-500, -500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.ObjectAxis.y Physics -500
            execute store result score #Physics.Projection.VoxelCorner2.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.y Physics *= @s Physics.Object.Axis.y.y

            scoreboard players set #Physics.Maths.Value1 Physics -500
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.x
            execute store result score #Physics.Projection.VoxelCorner1.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

            scoreboard players set #Physics.Maths.Value2 Physics -500
            scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Axis.y.z
            execute store result score #Physics.Projection.VoxelCorner7 Physics store result score #Physics.Projection.Voxel.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.y Physics += #Physics.Maths.Value2 Physics

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner6 Physics run scoreboard players operation #Physics.Projection.VoxelCorner1.ObjectAxis.y Physics -= #Physics.Maths.Value2 Physics

            # Corner 2 [500, -500, -500]
            scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics
            execute store result score #Physics.Projection.VoxelCorner3.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics
            execute store result score #Physics.Projection.VoxelCorner5 Physics run scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.y Physics += #Physics.Maths.Value2 Physics

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner4 Physics run scoreboard players operation #Physics.Projection.VoxelCorner3.ObjectAxis.y Physics -= #Physics.Maths.Value2 Physics

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.VoxelCorner4.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner5.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner6.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner7.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.ObjectAxis.y Physics > #Physics.Projection.Voxel.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics = #Physics.Projection.VoxelCorner1.ObjectAxis.y Physics
            execute if score #Physics.Projection.VoxelCorner2.ObjectAxis.y Physics > #Physics.Projection.Voxel.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics = #Physics.Projection.VoxelCorner2.ObjectAxis.y Physics
            execute if score #Physics.Projection.VoxelCorner3.ObjectAxis.y Physics > #Physics.Projection.Voxel.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics = #Physics.Projection.VoxelCorner3.ObjectAxis.y Physics
            execute if score #Physics.Projection.VoxelCorner4.ObjectAxis.y Physics > #Physics.Projection.Voxel.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics = #Physics.Projection.VoxelCorner4.ObjectAxis.y Physics
            execute if score #Physics.Projection.VoxelCorner5.ObjectAxis.y Physics > #Physics.Projection.Voxel.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics = #Physics.Projection.VoxelCorner5.ObjectAxis.y Physics
            execute if score #Physics.Projection.VoxelCorner6.ObjectAxis.y Physics > #Physics.Projection.Voxel.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics = #Physics.Projection.VoxelCorner6.ObjectAxis.y Physics
            execute if score #Physics.Projection.VoxelCorner7.ObjectAxis.y Physics > #Physics.Projection.Voxel.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Max Physics = #Physics.Projection.VoxelCorner7.ObjectAxis.y Physics
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Min Physics = #Physics.Projection.Voxel.ObjectAxis.y.Max Physics
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.y.Min Physics *= #Physics.Constants.-1 Physics

        # z_object
            # Corner 0 [-500, -500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.ObjectAxis.z Physics -500
            execute store result score #Physics.Projection.VoxelCorner2.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.z Physics *= @s Physics.Object.Axis.z.y

            scoreboard players set #Physics.Maths.Value1 Physics -500
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.x
            execute store result score #Physics.Projection.VoxelCorner1.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

            scoreboard players set #Physics.Maths.Value2 Physics -500
            scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Axis.z.z
            execute store result score #Physics.Projection.VoxelCorner7 Physics store result score #Physics.Projection.Voxel.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.z Physics += #Physics.Maths.Value2 Physics

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner6 Physics run scoreboard players operation #Physics.Projection.VoxelCorner1.ObjectAxis.z Physics -= #Physics.Maths.Value2 Physics

            # Corner 2 [500, -500, -500]
            scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics
            execute store result score #Physics.Projection.VoxelCorner3.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics
            execute store result score #Physics.Projection.VoxelCorner5 Physics run scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.z Physics += #Physics.Maths.Value2 Physics

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.VoxelCorner4 Physics run scoreboard players operation #Physics.Projection.VoxelCorner3.ObjectAxis.z Physics -= #Physics.Maths.Value2 Physics

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.VoxelCorner4.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner5.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner6.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner7.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.ObjectAxis.z Physics > #Physics.Projection.Voxel.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics = #Physics.Projection.VoxelCorner1.ObjectAxis.z Physics
            execute if score #Physics.Projection.VoxelCorner2.ObjectAxis.z Physics > #Physics.Projection.Voxel.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics = #Physics.Projection.VoxelCorner2.ObjectAxis.z Physics
            execute if score #Physics.Projection.VoxelCorner3.ObjectAxis.z Physics > #Physics.Projection.Voxel.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics = #Physics.Projection.VoxelCorner3.ObjectAxis.z Physics
            execute if score #Physics.Projection.VoxelCorner4.ObjectAxis.z Physics > #Physics.Projection.Voxel.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics = #Physics.Projection.VoxelCorner4.ObjectAxis.z Physics
            execute if score #Physics.Projection.VoxelCorner5.ObjectAxis.z Physics > #Physics.Projection.Voxel.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics = #Physics.Projection.VoxelCorner5.ObjectAxis.z Physics
            execute if score #Physics.Projection.VoxelCorner6.ObjectAxis.z Physics > #Physics.Projection.Voxel.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics = #Physics.Projection.VoxelCorner6.ObjectAxis.z Physics
            execute if score #Physics.Projection.VoxelCorner7.ObjectAxis.z Physics > #Physics.Projection.Voxel.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Max Physics = #Physics.Projection.VoxelCorner7.ObjectAxis.z Physics
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Min Physics = #Physics.Projection.Voxel.ObjectAxis.z.Max Physics
            scoreboard players operation #Physics.Projection.Voxel.ObjectAxis.z.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: x_block x x_object
        # (Important): Cross product's x component is 0, so x can be ignored
            # Corner 0 [-500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.xx Physics -500
            execute store result score #Physics.Projection.VoxelCorner1.CrossProductAxis.xx Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.xx Physics *= #Physics.CrossProductAxis.xx.y Physics

            scoreboard players set #Physics.Maths.Value1 Physics -500
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.z Physics
            execute store result score #Physics.Projection.VoxelCorner5 Physics store result score #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, 500]
            execute store result score #Physics.Projection.VoxelCorner4.CrossProductAxis.xx Physics run scoreboard players operation #Physics.Projection.VoxelCorner1.CrossProductAxis.xx Physics -= #Physics.Maths.Value1 Physics

            # Corner 2 [-500, -500] (Same as 0)

            # Corner 3 [-500, 500] (Same as 1)

            # Corner 4 [500, -500] (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner4.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner5.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

            # Corner 6 [500, -500] (Same as 4)

            # Corner 7 [500, 500] (Same as 5)

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.CrossProductAxis.xx Physics > #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics = #Physics.Projection.VoxelCorner1.CrossProductAxis.xx Physics
            execute if score #Physics.Projection.VoxelCorner4.CrossProductAxis.xx Physics > #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics = #Physics.Projection.VoxelCorner4.CrossProductAxis.xx Physics
            execute if score #Physics.Projection.VoxelCorner5.CrossProductAxis.xx Physics > #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics = #Physics.Projection.VoxelCorner5.CrossProductAxis.xx Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Min Physics = #Physics.Projection.Voxel.CrossProductAxis.xx.Max Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xx.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: x_block x y_object
        # (Important): Cross product's x component is 0, so x can be ignored
            # Corner 0 [-500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.xy Physics -500
            execute store result score #Physics.Projection.VoxelCorner1.CrossProductAxis.xy Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.xy Physics *= #Physics.CrossProductAxis.xy.y Physics

            scoreboard players set #Physics.Maths.Value1 Physics -500
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xy.z Physics
            execute store result score #Physics.Projection.VoxelCorner5 Physics store result score #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, 500]
            execute store result score #Physics.Projection.VoxelCorner4.CrossProductAxis.xy Physics run scoreboard players operation #Physics.Projection.VoxelCorner1.CrossProductAxis.xy Physics -= #Physics.Maths.Value1 Physics

            # Corner 2 [-500, -500] (Same as 0)

            # Corner 3 [-500, 500] (Same as 1)

            # Corner 4 [500, -500] (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner4.CrossProductAxis.xy Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner5.CrossProductAxis.xy Physics *= #Physics.Constants.-1 Physics

            # Corner 6 [500, -500] (Same as 4)

            # Corner 7 [500, 500] (Same as 5)

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.CrossProductAxis.xy Physics > #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics = #Physics.Projection.VoxelCorner1.CrossProductAxis.xy Physics
            execute if score #Physics.Projection.VoxelCorner4.CrossProductAxis.xy Physics > #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics = #Physics.Projection.VoxelCorner4.CrossProductAxis.xy Physics
            execute if score #Physics.Projection.VoxelCorner5.CrossProductAxis.xy Physics > #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics = #Physics.Projection.VoxelCorner5.CrossProductAxis.xy Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Min Physics = #Physics.Projection.Voxel.CrossProductAxis.xy.Max Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xy.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: x_block x z_object
        # (Important): Cross product's x component is 0, so x can be ignored
            # Corner 0 [-500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.xz Physics -500
            execute store result score #Physics.Projection.VoxelCorner1.CrossProductAxis.xz Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.xz Physics *= #Physics.CrossProductAxis.xz.y Physics

            scoreboard players set #Physics.Maths.Value1 Physics -500
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xz.z Physics
            execute store result score #Physics.Projection.VoxelCorner5 Physics store result score #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, 500]
            execute store result score #Physics.Projection.VoxelCorner4.CrossProductAxis.xz Physics run scoreboard players operation #Physics.Projection.VoxelCorner1.CrossProductAxis.xz Physics -= #Physics.Maths.Value1 Physics

            # Corner 2 [-500, -500] (Same as 0)

            # Corner 3 [-500, 500] (Same as 1)

            # Corner 4 [500, -500] (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner4.CrossProductAxis.xz Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner5.CrossProductAxis.xz Physics *= #Physics.Constants.-1 Physics

            # Corner 6 [500, -500] (Same as 4)

            # Corner 7 [500, 500] (Same as 5)

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.CrossProductAxis.xz Physics > #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics = #Physics.Projection.VoxelCorner1.CrossProductAxis.xz Physics
            execute if score #Physics.Projection.VoxelCorner4.CrossProductAxis.xz Physics > #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics = #Physics.Projection.VoxelCorner4.CrossProductAxis.xz Physics
            execute if score #Physics.Projection.VoxelCorner5.CrossProductAxis.xz Physics > #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics = #Physics.Projection.VoxelCorner5.CrossProductAxis.xz Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Min Physics = #Physics.Projection.Voxel.CrossProductAxis.xz.Max Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.xz.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: y_block x x_object
        # (Important): Cross product's y component is 0, so y can be ignored
            # Corner 0 [-500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.yx Physics -500
            execute store result score #Physics.Projection.VoxelCorner1.CrossProductAxis.yx Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.yx Physics *= #Physics.CrossProductAxis.yx.x Physics

            scoreboard players set #Physics.Maths.Value1 Physics -500
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yx.z Physics
            execute store result score #Physics.Projection.VoxelCorner3.CrossProductAxis.yx Physics store result score #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, 500]
            execute store result score #Physics.Projection.VoxelCorner2 Physics run scoreboard players operation #Physics.Projection.VoxelCorner1.CrossProductAxis.yx Physics -= #Physics.Maths.Value1 Physics

            # Corner 2 [500, -500] (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.yx Physics *= #Physics.Constants.-1 Physics

            # Corner 3 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner3.CrossProductAxis.yx Physics *= #Physics.Constants.-1 Physics

            # Corner 4 [-500, -500] (Same as 0)

            # Corner 5 [-500, 500] (Same as 1)

            # Corner 6 [500, -500] (Same as 2)

            # Corner 7 [500, 500] (Same as 3)

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.CrossProductAxis.yx Physics > #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics = #Physics.Projection.VoxelCorner1.CrossProductAxis.yx Physics
            execute if score #Physics.Projection.VoxelCorner2.CrossProductAxis.yx Physics > #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics = #Physics.Projection.VoxelCorner2.CrossProductAxis.yx Physics
            execute if score #Physics.Projection.VoxelCorner3.CrossProductAxis.yx Physics > #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics = #Physics.Projection.VoxelCorner3.CrossProductAxis.yx Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Min Physics = #Physics.Projection.Voxel.CrossProductAxis.yx.Max Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yx.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: y_block x y_object
        # (Important): Cross product's y component is 0, so y can be ignored
            # Corner 0 [-500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.yy Physics -500
            execute store result score #Physics.Projection.VoxelCorner1.CrossProductAxis.yy Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.yy Physics *= #Physics.CrossProductAxis.yy.x Physics

            scoreboard players set #Physics.Maths.Value1 Physics -500
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yy.z Physics
            execute store result score #Physics.Projection.VoxelCorner3.CrossProductAxis.yy Physics store result score #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, 500]
            execute store result score #Physics.Projection.VoxelCorner2 Physics run scoreboard players operation #Physics.Projection.VoxelCorner1.CrossProductAxis.yy Physics -= #Physics.Maths.Value1 Physics

            # Corner 2 [500, -500] (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.yy Physics *= #Physics.Constants.-1 Physics

            # Corner 3 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner3.CrossProductAxis.yy Physics *= #Physics.Constants.-1 Physics

            # Corner 4 [-500, -500] (Same as 0)

            # Corner 5 [-500, 500] (Same as 1)

            # Corner 6 [500, -500] (Same as 2)

            # Corner 7 [500, 500] (Same as 3)

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.CrossProductAxis.yy Physics > #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics = #Physics.Projection.VoxelCorner1.CrossProductAxis.yy Physics
            execute if score #Physics.Projection.VoxelCorner2.CrossProductAxis.yy Physics > #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics = #Physics.Projection.VoxelCorner2.CrossProductAxis.yy Physics
            execute if score #Physics.Projection.VoxelCorner3.CrossProductAxis.yy Physics > #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics = #Physics.Projection.VoxelCorner3.CrossProductAxis.yy Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Min Physics = #Physics.Projection.Voxel.CrossProductAxis.yy.Max Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yy.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: y_block x z_object
        # (Important): Cross product's y component is 0, so y can be ignored
            # Corner 0 [-500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.yz Physics -500
            execute store result score #Physics.Projection.VoxelCorner1.CrossProductAxis.yz Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.yz Physics *= #Physics.CrossProductAxis.yz.x Physics

            scoreboard players set #Physics.Maths.Value1 Physics -500
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.z Physics
            execute store result score #Physics.Projection.VoxelCorner3.CrossProductAxis.yz Physics store result score #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, 500]
            execute store result score #Physics.Projection.VoxelCorner2 Physics run scoreboard players operation #Physics.Projection.VoxelCorner1.CrossProductAxis.yz Physics -= #Physics.Maths.Value1 Physics

            # Corner 2 [500, -500] (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.yz Physics *= #Physics.Constants.-1 Physics

            # Corner 3 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner3.CrossProductAxis.yz Physics *= #Physics.Constants.-1 Physics

            # Corner 4 [-500, -500] (Same as 0)

            # Corner 5 [-500, 500] (Same as 1)

            # Corner 6 [500, -500] (Same as 2)

            # Corner 7 [500, 500] (Same as 3)

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner1.CrossProductAxis.yz Physics > #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics = #Physics.Projection.VoxelCorner1.CrossProductAxis.yz Physics
            execute if score #Physics.Projection.VoxelCorner2.CrossProductAxis.yz Physics > #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics = #Physics.Projection.VoxelCorner2.CrossProductAxis.yz Physics
            execute if score #Physics.Projection.VoxelCorner3.CrossProductAxis.yz Physics > #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics = #Physics.Projection.VoxelCorner3.CrossProductAxis.yz Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Min Physics = #Physics.Projection.Voxel.CrossProductAxis.yz.Max Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.yz.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: z_block x x_object
        # (Important): Cross product's z component is 0, so z can be ignored
            # Corner 0 [-500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.zx Physics -500
            execute store result score #Physics.Projection.VoxelCorner2.CrossProductAxis.zx Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.zx Physics *= #Physics.CrossProductAxis.zx.y Physics

            scoreboard players set #Physics.Maths.Value1 Physics -500
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.x Physics
            execute store result score #Physics.Projection.VoxelCorner6.CrossProductAxis.zx Physics store result score #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, -500] (Same as 0)

            # Corner 2 [500, -500]
            execute store result score #Physics.Projection.VoxelCorner4.CrossProductAxis.zx Physics run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.zx Physics -= #Physics.Maths.Value1 Physics

            # Corner 3 [500, -500] (Same as 2)

            # Corner 4 [-500, 500] (Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner4.CrossProductAxis.zx Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [-500, 500] (Same as 4)

            # Corner 6 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner6.CrossProductAxis.zx Physics *= #Physics.Constants.-1 Physics

            # Corner 7 [500, 500] (Same as 6)

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner2.CrossProductAxis.zx Physics > #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics = #Physics.Projection.VoxelCorner2.CrossProductAxis.zx Physics
            execute if score #Physics.Projection.VoxelCorner4.CrossProductAxis.zx Physics > #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics = #Physics.Projection.VoxelCorner4.CrossProductAxis.zx Physics
            execute if score #Physics.Projection.VoxelCorner6.CrossProductAxis.zx Physics > #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics = #Physics.Projection.VoxelCorner6.CrossProductAxis.zx Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Min Physics = #Physics.Projection.Voxel.CrossProductAxis.zx.Max Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zx.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: z_block x y_object
        # (Important): Cross product's z component is 0, so z can be ignored
            # Corner 0 [-500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.zy Physics -500
            execute store result score #Physics.Projection.VoxelCorner2.CrossProductAxis.zy Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.zy Physics *= #Physics.CrossProductAxis.zy.y Physics

            scoreboard players set #Physics.Maths.Value1 Physics -500
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.x Physics
            execute store result score #Physics.Projection.VoxelCorner6.CrossProductAxis.zy Physics store result score #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, -500] (Same as 0)

            # Corner 2 [500, -500]
            execute store result score #Physics.Projection.VoxelCorner4.CrossProductAxis.zy Physics run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.zy Physics -= #Physics.Maths.Value1 Physics

            # Corner 3 [500, -500] (Same as 2)

            # Corner 4 [-500, 500] (Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner4.CrossProductAxis.zy Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [-500, 500] (Same as 4)

            # Corner 6 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner6.CrossProductAxis.zy Physics *= #Physics.Constants.-1 Physics

            # Corner 7 [500, 500] (Same as 6)

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner2.CrossProductAxis.zy Physics > #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics = #Physics.Projection.VoxelCorner2.CrossProductAxis.zy Physics
            execute if score #Physics.Projection.VoxelCorner4.CrossProductAxis.zy Physics > #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics = #Physics.Projection.VoxelCorner4.CrossProductAxis.zy Physics
            execute if score #Physics.Projection.VoxelCorner6.CrossProductAxis.zy Physics > #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics = #Physics.Projection.VoxelCorner6.CrossProductAxis.zy Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Min Physics = #Physics.Projection.Voxel.CrossProductAxis.zy.Max Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zy.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: z_block x z_object
        # (Important): Cross product's z component is 0, so z can be ignored
            # Corner 0 [-500, -500]
            scoreboard players set #Physics.Projection.VoxelCorner0.CrossProductAxis.zz Physics -500
            execute store result score #Physics.Projection.VoxelCorner2.CrossProductAxis.zz Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.zz Physics *= #Physics.CrossProductAxis.zz.y Physics

            scoreboard players set #Physics.Maths.Value1 Physics -500
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.x Physics
            execute store result score #Physics.Projection.VoxelCorner6.CrossProductAxis.zz Physics store result score #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.VoxelCorner0.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, -500] (Same as 0)

            # Corner 2 [500, -500]
            execute store result score #Physics.Projection.VoxelCorner4.CrossProductAxis.zz Physics run scoreboard players operation #Physics.Projection.VoxelCorner2.CrossProductAxis.zz Physics -= #Physics.Maths.Value1 Physics

            # Corner 3 [500, -500] (Same as 2)

            # Corner 4 [-500, 500] (Mirrored version of 2)
            scoreboard players operation #Physics.Projection.VoxelCorner4.CrossProductAxis.zz Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [-500, 500] (Same as 4)

            # Corner 6 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.VoxelCorner6.CrossProductAxis.zz Physics *= #Physics.Constants.-1 Physics

            # Corner 7 [500, 500] (Same as 6)

            # Find min and max
            execute if score #Physics.Projection.VoxelCorner2.CrossProductAxis.zz Physics > #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics = #Physics.Projection.VoxelCorner2.CrossProductAxis.zz Physics
            execute if score #Physics.Projection.VoxelCorner4.CrossProductAxis.zz Physics > #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics = #Physics.Projection.VoxelCorner4.CrossProductAxis.zz Physics
            execute if score #Physics.Projection.VoxelCorner6.CrossProductAxis.zz Physics > #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics = #Physics.Projection.VoxelCorner6.CrossProductAxis.zz Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Min Physics = #Physics.Projection.Voxel.CrossProductAxis.zz.Max Physics
            scoreboard players operation #Physics.Projection.Voxel.CrossProductAxis.zz.Min Physics *= #Physics.Constants.-1 Physics
























    # Project the object onto the cross product axes
    # (Important): I'm using the relative corner points, so I know that for example corner 7 is a mirrored version of corner 0, and corner 6 is mirrored corner 1. But note that this is not the same as the [-x, +z] notation; Two corners that both go into positive x can still have different x components, because they're rotated. Because of this, I can't do the same assumptions as before.
    # (Important): I used "execute store result ..." earlier to copy the cross product axis scores into temporary scores to prevent unnecessary "scoreboard players operation ... = ..." calls
    # (Important): These values are scaled 1,000x too big because of the multiplication. But I THINK I don't need the values directly anymore, so I only divide the min and max by 1000 instead of the 8 corner points.
        # Cross Product: x_block x x_object
        # (Important): Cross product's x component is 0, so x can be ignored
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics *= @s Physics.Object.CornerPosRelative.0.y

            scoreboard players operation #Physics.Maths.Value12 Physics *= @s Physics.Object.CornerPosRelative.0.z
            execute store result score #Physics.Projection.ObjectCorner7.CrossProductAxis.xx Physics store result score #Physics.Projection.Object.CrossProductAxis.xx.Min Physics store result score #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics += #Physics.Maths.Value12 Physics

            # Corner 1
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics *= @s Physics.Object.CornerPosRelative.1.y

            scoreboard players operation #Physics.Maths.Value13 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis.xx Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics += #Physics.Maths.Value13 Physics

            # Corner 2
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.xx Physics *= @s Physics.Object.CornerPosRelative.2.y

            scoreboard players operation #Physics.Maths.Value14 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.xx Physics += #Physics.Maths.Value14 Physics

            # Corner 3
            scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.xx Physics *= @s Physics.Object.CornerPosRelative.3.y

            scoreboard players operation #Physics.Maths.Value15 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.xx Physics += #Physics.Maths.Value15 Physics

            # Corner 4 (Mirrored version of 3)
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

            # Corner 5 (Mirrored version of 2)
            scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

            # Corner 6 (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

            # Corner 7 (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.ObjectCorner7.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

            # Find min and max (Relative to object center)
            execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics
            execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.xx Physics
            execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis.xx Physics
            execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics
            execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics
            execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.xx Physics
            execute if score #Physics.Projection.ObjectCorner7.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner7.CrossProductAxis.xx Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Min Physics = #Physics.Projection.Object.CrossProductAxis.xx.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the min and max global by projecting the center point onto the same axis and adding it to the min and max
            # (Important): I divide the projection by 1,000x to ensure consistent scaling, because multiplying a number that's scaled by 1,000x with another number that's scaled the same will result in a scaling of 1,000,000x.
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics *= @s Physics.Object.Pos.y

            scoreboard players operation #Physics.Maths.Value16 Physics *= @s Physics.Object.Pos.z
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics += #Physics.Maths.Value16 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics

        # Cross Product: x_block x y_object
        # (Important): Cross product's x component is 0, so x can be ignored
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xy Physics *= @s Physics.Object.CornerPosRelative.0.y

            scoreboard players operation #Physics.Maths.Value17 Physics *= @s Physics.Object.CornerPosRelative.0.z
            execute store result score #Physics.Projection.ObjectCorner7.CrossProductAxis.xy Physics store result score #Physics.Projection.Object.CrossProductAxis.xy.Min Physics store result score #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xy Physics += #Physics.Maths.Value17 Physics

            # Corner 1
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics *= @s Physics.Object.CornerPosRelative.1.y

            scoreboard players operation #Physics.Maths.Value18 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis.xy Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics += #Physics.Maths.Value18 Physics

            # Corner 2
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.xy Physics *= @s Physics.Object.CornerPosRelative.2.y

            scoreboard players operation #Physics.Maths.Value19 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.xy Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.xy Physics += #Physics.Maths.Value19 Physics

            # Corner 3
            scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.xy Physics *= @s Physics.Object.CornerPosRelative.3.y

            scoreboard players operation #Physics.Maths.Value20 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.xy Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.xy Physics += #Physics.Maths.Value20 Physics

            # Corner 4 (Mirrored version of 3)
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.xy Physics *= #Physics.Constants.-1 Physics

            # Corner 5 (Mirrored version of 2)
            scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.xy Physics *= #Physics.Constants.-1 Physics

            # Corner 6 (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.xy Physics *= #Physics.Constants.-1 Physics

            # Corner 7 (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.ObjectCorner7.CrossProductAxis.xy Physics *= #Physics.Constants.-1 Physics

            # Find min and max (Relative to object center)
            execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics > #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics
            execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.xy Physics > #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.xy Physics
            execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis.xy Physics > #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis.xy Physics
            execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.xy Physics > #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.xy Physics
            execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.xy Physics > #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.xy Physics
            execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis.xy Physics > #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.xy Physics
            execute if score #Physics.Projection.ObjectCorner7.CrossProductAxis.xy Physics > #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics = #Physics.Projection.ObjectCorner7.CrossProductAxis.xy Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Min Physics = #Physics.Projection.Object.CrossProductAxis.xy.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the min and max global by projecting the center point onto the same axis and adding it to the min and max
            # (Important): I divide the projection by 1,000x to ensure consistent scaling, because multiplying a number that's scaled by 1,000x with another number that's scaled the same will result in a scaling of 1,000,000x.
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics *= @s Physics.Object.Pos.y

            scoreboard players operation #Physics.Maths.Value21 Physics *= @s Physics.Object.Pos.z
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics += #Physics.Maths.Value21 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics

        # Cross Product: x_block x z_object
        # (Important): Cross product's x component is 0, so x can be ignored
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xz Physics *= @s Physics.Object.CornerPosRelative.0.y

            scoreboard players operation #Physics.Maths.Value22 Physics *= @s Physics.Object.CornerPosRelative.0.z
            execute store result score #Physics.Projection.ObjectCorner7.CrossProductAxis.xz Physics store result score #Physics.Projection.Object.CrossProductAxis.xz.Min Physics store result score #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xz Physics += #Physics.Maths.Value22 Physics

            # Corner 1
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xz Physics *= @s Physics.Object.CornerPosRelative.1.y

            scoreboard players operation #Physics.Maths.Value23 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis.xz Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xz Physics += #Physics.Maths.Value23 Physics

            # Corner 2
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.xz Physics *= @s Physics.Object.CornerPosRelative.2.y

            scoreboard players operation #Physics.Maths.Value24 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.xz Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.xz Physics += #Physics.Maths.Value24 Physics

            # Corner 3
            scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.xz Physics *= @s Physics.Object.CornerPosRelative.3.y

            scoreboard players operation #Physics.Maths.Value25 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.xz Physics += #Physics.Maths.Value25 Physics

            # Corner 4 (Mirrored version of 3)
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics *= #Physics.Constants.-1 Physics

            # Corner 5 (Mirrored version of 2)
            scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.xz Physics *= #Physics.Constants.-1 Physics

            # Corner 6 (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.xz Physics *= #Physics.Constants.-1 Physics

            # Corner 7 (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.ObjectCorner7.CrossProductAxis.xz Physics *= #Physics.Constants.-1 Physics

            # Find min and max (Relative to object center)
            execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.xz Physics > #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.xz Physics
            execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.xz Physics > #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.xz Physics
            execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis.xz Physics > #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis.xz Physics
            execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics > #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics
            execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.xz Physics > #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.xz Physics
            execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis.xz Physics > #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.xz Physics
            execute if score #Physics.Projection.ObjectCorner7.CrossProductAxis.xz Physics > #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics = #Physics.Projection.ObjectCorner7.CrossProductAxis.xz Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Min Physics = #Physics.Projection.Object.CrossProductAxis.xz.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the min and max global by projecting the center point onto the same axis and adding it to the min and max
            # (Important): I divide the projection by 1,000x to ensure consistent scaling, because multiplying a number that's scaled by 1,000x with another number that's scaled the same will result in a scaling of 1,000,000x.
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics *= @s Physics.Object.Pos.y

            scoreboard players operation #Physics.Maths.Value26 Physics *= @s Physics.Object.Pos.z
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics += #Physics.Maths.Value26 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics

        # Cross Product: y_block x x_object
        # (Important): Cross product's y component is 0, so y can be ignored
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yx Physics *= @s Physics.Object.CornerPosRelative.0.x

            scoreboard players operation #Physics.Maths.Value27 Physics *= @s Physics.Object.CornerPosRelative.0.z
            execute store result score #Physics.Projection.ObjectCorner7.CrossProductAxis.yx Physics store result score #Physics.Projection.Object.CrossProductAxis.yx.Min Physics store result score #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yx Physics += #Physics.Maths.Value27 Physics

            # Corner 1
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics *= @s Physics.Object.CornerPosRelative.1.x

            scoreboard players operation #Physics.Maths.Value28 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis.yx Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics += #Physics.Maths.Value28 Physics

            # Corner 2
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yx Physics *= @s Physics.Object.CornerPosRelative.2.x

            scoreboard players operation #Physics.Maths.Value29 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.yx Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yx Physics += #Physics.Maths.Value29 Physics

            # Corner 3
            scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.yx Physics *= @s Physics.Object.CornerPosRelative.3.x

            scoreboard players operation #Physics.Maths.Value30 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.yx Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.yx Physics += #Physics.Maths.Value30 Physics

            # Corner 4 (Mirrored version of 3)
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.yx Physics *= #Physics.Constants.-1 Physics

            # Corner 5 (Mirrored version of 2)
            scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.yx Physics *= #Physics.Constants.-1 Physics

            # Corner 6 (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.yx Physics *= #Physics.Constants.-1 Physics

            # Corner 7 (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.ObjectCorner7.CrossProductAxis.yx Physics *= #Physics.Constants.-1 Physics

            # Find min and max (Relative to object center)
            execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics > #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics
            execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.yx Physics > #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.yx Physics
            execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis.yx Physics > #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis.yx Physics
            execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.yx Physics > #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.yx Physics
            execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.yx Physics > #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.yx Physics
            execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis.yx Physics > #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.yx Physics
            execute if score #Physics.Projection.ObjectCorner7.CrossProductAxis.yx Physics > #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics = #Physics.Projection.ObjectCorner7.CrossProductAxis.yx Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Min Physics = #Physics.Projection.Object.CrossProductAxis.yx.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the min and max global by projecting the center point onto the same axis and adding it to the min and max
            # (Important): I divide the projection by 1,000x to ensure consistent scaling, because multiplying a number that's scaled by 1,000x with another number that's scaled the same will result in a scaling of 1,000,000x.
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics *= @s Physics.Object.Pos.x

            scoreboard players operation #Physics.Maths.Value31 Physics *= @s Physics.Object.Pos.z
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics += #Physics.Maths.Value31 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics

        # Cross Product: y_block x y_object
        # (Important): Cross product's y component is 0, so y can be ignored
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics *= @s Physics.Object.CornerPosRelative.0.x

            scoreboard players operation #Physics.Maths.Value32 Physics *= @s Physics.Object.CornerPosRelative.0.z
            execute store result score #Physics.Projection.ObjectCorner7.CrossProductAxis.yy Physics store result score #Physics.Projection.Object.CrossProductAxis.yy.Min Physics store result score #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics += #Physics.Maths.Value32 Physics

            # Corner 1
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics *= @s Physics.Object.CornerPosRelative.1.x

            scoreboard players operation #Physics.Maths.Value33 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis.yy Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics += #Physics.Maths.Value33 Physics

            # Corner 2
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics *= @s Physics.Object.CornerPosRelative.2.x

            scoreboard players operation #Physics.Maths.Value34 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.yy Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics += #Physics.Maths.Value34 Physics

            # Corner 3
            scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics *= @s Physics.Object.CornerPosRelative.3.x

            scoreboard players operation #Physics.Maths.Value35 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.yy Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics += #Physics.Maths.Value35 Physics

            # Corner 4 (Mirrored version of 3)
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.yy Physics *= #Physics.Constants.-1 Physics

            # Corner 5 (Mirrored version of 2)
            scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.yy Physics *= #Physics.Constants.-1 Physics

            # Corner 6 (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.yy Physics *= #Physics.Constants.-1 Physics

            # Corner 7 (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.ObjectCorner7.CrossProductAxis.yy Physics *= #Physics.Constants.-1 Physics

            # Find min and max (Relative to object center)
            execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics > #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics
            execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics > #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics
            execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics > #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics
            execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.yy Physics > #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.yy Physics
            execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.yy Physics > #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.yy Physics
            execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis.yy Physics > #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.yy Physics
            execute if score #Physics.Projection.ObjectCorner7.CrossProductAxis.yy Physics > #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics = #Physics.Projection.ObjectCorner7.CrossProductAxis.yy Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Min Physics = #Physics.Projection.Object.CrossProductAxis.yy.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the min and max global by projecting the center point onto the same axis and adding it to the min and max
            # (Important): I divide the projection by 1,000x to ensure consistent scaling, because multiplying a number that's scaled by 1,000x with another number that's scaled the same will result in a scaling of 1,000,000x.
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics *= @s Physics.Object.Pos.x

            scoreboard players operation #Physics.Maths.Value36 Physics *= @s Physics.Object.Pos.z
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics += #Physics.Maths.Value36 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics

        # Cross Product: y_block x z_object
        # (Important): Cross product's y component is 0, so y can be ignored
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics *= @s Physics.Object.CornerPosRelative.0.x

            scoreboard players operation #Physics.Maths.Value37 Physics *= @s Physics.Object.CornerPosRelative.0.z
            execute store result score #Physics.Projection.ObjectCorner7.CrossProductAxis.yz Physics store result score #Physics.Projection.Object.CrossProductAxis.yz.Min Physics store result score #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics += #Physics.Maths.Value37 Physics

            # Corner 1
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yz Physics *= @s Physics.Object.CornerPosRelative.1.x

            scoreboard players operation #Physics.Maths.Value38 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis.yz Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yz Physics += #Physics.Maths.Value38 Physics

            # Corner 2
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics *= @s Physics.Object.CornerPosRelative.2.x

            scoreboard players operation #Physics.Maths.Value39 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.yz Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics += #Physics.Maths.Value39 Physics

            # Corner 3
            scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.yz Physics *= @s Physics.Object.CornerPosRelative.3.x

            scoreboard players operation #Physics.Maths.Value40 Physics *= @s Physics.Object.CornerPosRelative.1.z
            execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.yz Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.yz Physics += #Physics.Maths.Value40 Physics

            # Corner 4 (Mirrored version of 3)
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.yz Physics *= #Physics.Constants.-1 Physics

            # Corner 5 (Mirrored version of 2)
            scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.yz Physics *= #Physics.Constants.-1 Physics

            # Corner 6 (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.yz Physics *= #Physics.Constants.-1 Physics

            # Corner 7 (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.ObjectCorner7.CrossProductAxis.yz Physics *= #Physics.Constants.-1 Physics

            # Find min and max (Relative to object center)
            execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.yz Physics > #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.yz Physics
            execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics > #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics
            execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis.yz Physics > #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis.yz Physics
            execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.yz Physics > #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.yz Physics
            execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.yz Physics > #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.yz Physics
            execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis.yz Physics > #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.yz Physics
            execute if score #Physics.Projection.ObjectCorner7.CrossProductAxis.yz Physics > #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics = #Physics.Projection.ObjectCorner7.CrossProductAxis.yz Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Min Physics = #Physics.Projection.Object.CrossProductAxis.yz.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the min and max global by projecting the center point onto the same axis and adding it to the min and max
            # (Important): I divide the projection by 1,000x to ensure consistent scaling, because multiplying a number that's scaled by 1,000x with another number that's scaled the same will result in a scaling of 1,000,000x.
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics *= @s Physics.Object.Pos.x

            scoreboard players operation #Physics.Maths.Value41 Physics *= @s Physics.Object.Pos.z
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics += #Physics.Maths.Value41 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics

        # Cross Product: z_block x x_object
        # (Important): Cross product's z component is 0, so z can be ignored
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zx Physics *= @s Physics.Object.CornerPosRelative.0.x

            scoreboard players operation #Physics.Maths.Value42 Physics *= @s Physics.Object.CornerPosRelative.0.y
            execute store result score #Physics.Projection.ObjectCorner7.CrossProductAxis.zx Physics store result score #Physics.Projection.Object.CrossProductAxis.zx.Min Physics store result score #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zx Physics += #Physics.Maths.Value42 Physics

            # Corner 1
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.zx Physics *= @s Physics.Object.CornerPosRelative.1.x

            scoreboard players operation #Physics.Maths.Value43 Physics *= @s Physics.Object.CornerPosRelative.1.y
            execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis.zx Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.zx Physics += #Physics.Maths.Value43 Physics

            # Corner 2
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zx Physics *= @s Physics.Object.CornerPosRelative.2.x

            scoreboard players operation #Physics.Maths.Value44 Physics *= @s Physics.Object.CornerPosRelative.1.y
            execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.zx Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zx Physics += #Physics.Maths.Value44 Physics

            # Corner 3
            scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.zx Physics *= @s Physics.Object.CornerPosRelative.3.x

            scoreboard players operation #Physics.Maths.Value45 Physics *= @s Physics.Object.CornerPosRelative.1.y
            execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.zx Physics += #Physics.Maths.Value45 Physics

            # Corner 4 (Mirrored version of 3)
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics *= #Physics.Constants.-1 Physics

            # Corner 5 (Mirrored version of 2)
            scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.zx Physics *= #Physics.Constants.-1 Physics

            # Corner 6 (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.zx Physics *= #Physics.Constants.-1 Physics

            # Corner 7 (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.ObjectCorner7.CrossProductAxis.zx Physics *= #Physics.Constants.-1 Physics

            # Find min and max (Relative to object center)
            execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.zx Physics > #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.zx Physics
            execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.zx Physics > #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.zx Physics
            execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis.zx Physics > #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis.zx Physics
            execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics > #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics
            execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.zx Physics > #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.zx Physics
            execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis.zx Physics > #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.zx Physics
            execute if score #Physics.Projection.ObjectCorner7.CrossProductAxis.zx Physics > #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics = #Physics.Projection.ObjectCorner7.CrossProductAxis.zx Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Min Physics = #Physics.Projection.Object.CrossProductAxis.zx.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the min and max global by projecting the center point onto the same axis and adding it to the min and max
            # (Important): I divide the projection by 1,000x to ensure consistent scaling, because multiplying a number that's scaled by 1,000x with another number that's scaled the same will result in a scaling of 1,000,000x.
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics *= @s Physics.Object.Pos.x

            scoreboard players operation #Physics.Maths.Value46 Physics *= @s Physics.Object.Pos.y
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics += #Physics.Maths.Value46 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics

        # Cross Product: z_block x y_object
        # (Important): Cross product's z component is 0, so z can be ignored
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zy Physics *= @s Physics.Object.CornerPosRelative.0.x

            scoreboard players operation #Physics.Maths.Value47 Physics *= @s Physics.Object.CornerPosRelative.0.y
            execute store result score #Physics.Projection.ObjectCorner7.CrossProductAxis.zy Physics store result score #Physics.Projection.Object.CrossProductAxis.zy.Min Physics store result score #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zy Physics += #Physics.Maths.Value47 Physics

            # Corner 1
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.zy Physics *= @s Physics.Object.CornerPosRelative.1.x

            scoreboard players operation #Physics.Maths.Value48 Physics *= @s Physics.Object.CornerPosRelative.1.y
            execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis.zy Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.zy Physics += #Physics.Maths.Value48 Physics

            # Corner 2
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics *= @s Physics.Object.CornerPosRelative.2.x

            scoreboard players operation #Physics.Maths.Value49 Physics *= @s Physics.Object.CornerPosRelative.1.y
            execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.zy Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics += #Physics.Maths.Value49 Physics

            # Corner 3
            scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.zy Physics *= @s Physics.Object.CornerPosRelative.3.x

            scoreboard players operation #Physics.Maths.Value50 Physics *= @s Physics.Object.CornerPosRelative.1.y
            execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.zy Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.zy Physics += #Physics.Maths.Value50 Physics

            # Corner 4 (Mirrored version of 3)
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.zy Physics *= #Physics.Constants.-1 Physics

            # Corner 5 (Mirrored version of 2)
            scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.zy Physics *= #Physics.Constants.-1 Physics

            # Corner 6 (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.zy Physics *= #Physics.Constants.-1 Physics

            # Corner 7 (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.ObjectCorner7.CrossProductAxis.zy Physics *= #Physics.Constants.-1 Physics

            # Find min and max (Relative to object center)
            execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.zy Physics > #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.zy Physics
            execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics > #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics
            execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis.zy Physics > #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis.zy Physics
            execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.zy Physics > #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.zy Physics
            execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.zy Physics > #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.zy Physics
            execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis.zy Physics > #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.zy Physics
            execute if score #Physics.Projection.ObjectCorner7.CrossProductAxis.zy Physics > #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics = #Physics.Projection.ObjectCorner7.CrossProductAxis.zy Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Min Physics = #Physics.Projection.Object.CrossProductAxis.zy.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the min and max global by projecting the center point onto the same axis and adding it to the min and max
            # (Important): I divide the projection by 1,000x to ensure consistent scaling, because multiplying a number that's scaled by 1,000x with another number that's scaled the same will result in a scaling of 1,000,000x.
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics *= @s Physics.Object.Pos.x

            scoreboard players operation #Physics.Maths.Value51 Physics *= @s Physics.Object.Pos.y
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics += #Physics.Maths.Value51 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics

        # Cross Product: z_block x z_object
        # (Important): Cross product's z component is 0, so z can be ignored
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zz Physics *= @s Physics.Object.CornerPosRelative.0.x

            scoreboard players operation #Physics.Maths.Value52 Physics *= @s Physics.Object.CornerPosRelative.0.y
            execute store result score #Physics.Projection.ObjectCorner7.CrossProductAxis.zz Physics store result score #Physics.Projection.Object.CrossProductAxis.zz.Min Physics store result score #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zz Physics += #Physics.Maths.Value52 Physics

            # Corner 1
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.zz Physics *= @s Physics.Object.CornerPosRelative.1.x

            scoreboard players operation #Physics.Maths.Value53 Physics *= @s Physics.Object.CornerPosRelative.1.y
            execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis.zz Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.zz Physics += #Physics.Maths.Value53 Physics

            # Corner 2
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics *= @s Physics.Object.CornerPosRelative.2.x

            scoreboard players operation #Physics.Maths.Value54 Physics *= @s Physics.Object.CornerPosRelative.1.y
            execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.zz Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics += #Physics.Maths.Value54 Physics

            # Corner 3
            scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.zz Physics *= @s Physics.Object.CornerPosRelative.3.x

            scoreboard players operation #Physics.Maths.Value55 Physics *= @s Physics.Object.CornerPosRelative.1.y
            execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.zz Physics += #Physics.Maths.Value55 Physics

            # Corner 4 (Mirrored version of 3)
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics *= #Physics.Constants.-1 Physics

            # Corner 5 (Mirrored version of 2)
            scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.zz Physics *= #Physics.Constants.-1 Physics

            # Corner 6 (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.zz Physics *= #Physics.Constants.-1 Physics

            # Corner 7 (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.ObjectCorner7.CrossProductAxis.zz Physics *= #Physics.Constants.-1 Physics

            # Find min and max (Relative to object center)
            execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.zz Physics > #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.zz Physics
            execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics > #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics
            execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis.zz Physics > #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis.zz Physics
            execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics > #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics
            execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.zz Physics > #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.zz Physics
            execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis.zz Physics > #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.zz Physics
            execute if score #Physics.Projection.ObjectCorner7.CrossProductAxis.zz Physics > #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics = #Physics.Projection.ObjectCorner7.CrossProductAxis.zz Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Min Physics = #Physics.Projection.Object.CrossProductAxis.zz.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the min and max global by projecting the center point onto the same axis and adding it to the min and max
            # (Important): I divide the projection by 1,000x to ensure consistent scaling, because multiplying a number that's scaled by 1,000x with another number that's scaled the same will result in a scaling of 1,000,000x.
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics *= @s Physics.Object.Pos.x

            scoreboard players operation #Physics.Maths.Value56 Physics *= @s Physics.Object.Pos.y
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics += #Physics.Maths.Value56 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics

# Iterate through every minecraft block that intersects with the interaction entity's hitbox (AABB), so I can then perform the Separating Axes Theorem (SAT) to check for fine collisions
# (Important): I only have the global coords for the bounding box, so instead of using a few scoreboard commands, I just don't use relative coordinates here. If I do need the relative coordinates later, I will change that
execute store result storage physics:temp data.StartX double 0.001 run scoreboard players get @s Physics.Object.BoundingBoxGlobalMin.x
execute store result storage physics:temp data.StartY double 0.001 run scoreboard players get @s Physics.Object.BoundingBoxGlobalMin.y
execute store result storage physics:temp data.StartZ double 0.001 run scoreboard players get @s Physics.Object.BoundingBoxGlobalMin.z
execute store result storage physics:temp data.StepCountX byte 1 run scoreboard players get @s Physics.Object.BoundingBoxStepCount.x
execute store result storage physics:temp data.StepCountY byte 1 run scoreboard players get @s Physics.Object.BoundingBoxStepCount.y
execute store result storage physics:temp data.StepCountZ byte 1 run scoreboard players get @s Physics.Object.BoundingBoxStepCount.z

execute at @s run function physics:zprivate/collision_detection/voxel_grid/main with storage physics:temp data

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
