# Get the object's feature (Face that's closest to the world-geometry voxel)
# (Important): There are 2 candidate faces (those normal to the axis), and I select the correct one by looking at the projection of a single point of them and looking which is closer. If I look at the same point for both faces, I can easily get which face is closer.
execute if score #Physics.Projection.Voxel.ObjectAxis.x.Min Physics >= @s Physics.Object.ProjectionOwnAxis.x.Min run scoreboard players set #Physics.ObjectA.Feature Physics 10
execute if score #Physics.Projection.Voxel.ObjectAxis.x.Min Physics < @s Physics.Object.ProjectionOwnAxis.x.Min run scoreboard players set #Physics.ObjectA.Feature Physics 11

# Get the world-geometry voxel's feature (Corner that's closest to the object)
# (Important): I check which of the 8 corners' projection is the closest to the object's face.
    # Adjust point projections for the voxel position (They are currently relative)
    scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.x Physics = #Physics.Projection.VoxelCornerBase0.ObjectAxis.x Physics
    scoreboard players operation #Physics.Projection.VoxelCorner1.ObjectAxis.x Physics = #Physics.Projection.VoxelCornerBase1.ObjectAxis.x Physics
    scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.x Physics = #Physics.Projection.VoxelCornerBase2.ObjectAxis.x Physics
    scoreboard players operation #Physics.Projection.VoxelCorner3.ObjectAxis.x Physics = #Physics.Projection.VoxelCornerBase3.ObjectAxis.x Physics
    scoreboard players operation #Physics.Projection.VoxelCorner4.ObjectAxis.x Physics = #Physics.Projection.VoxelCornerBase4.ObjectAxis.x Physics
    scoreboard players operation #Physics.Projection.VoxelCorner5.ObjectAxis.x Physics = #Physics.Projection.VoxelCornerBase5.ObjectAxis.x Physics
    scoreboard players operation #Physics.Projection.VoxelCorner6.ObjectAxis.x Physics = #Physics.Projection.VoxelCornerBase6.ObjectAxis.x Physics
    scoreboard players operation #Physics.Projection.VoxelCorner7.ObjectAxis.x Physics = #Physics.Projection.VoxelCornerBase7.ObjectAxis.x Physics

    scoreboard players operation #Physics.Projection.VoxelCorner0.ObjectAxis.x Physics += #Physics.Projection.VoxelCenter.ObjectAxis.x Physics
    scoreboard players operation #Physics.Projection.VoxelCorner1.ObjectAxis.x Physics += #Physics.Projection.VoxelCenter.ObjectAxis.x Physics
    scoreboard players operation #Physics.Projection.VoxelCorner2.ObjectAxis.x Physics += #Physics.Projection.VoxelCenter.ObjectAxis.x Physics
    scoreboard players operation #Physics.Projection.VoxelCorner3.ObjectAxis.x Physics += #Physics.Projection.VoxelCenter.ObjectAxis.x Physics
    scoreboard players operation #Physics.Projection.VoxelCorner4.ObjectAxis.x Physics += #Physics.Projection.VoxelCenter.ObjectAxis.x Physics
    scoreboard players operation #Physics.Projection.VoxelCorner5.ObjectAxis.x Physics += #Physics.Projection.VoxelCenter.ObjectAxis.x Physics
    scoreboard players operation #Physics.Projection.VoxelCorner6.ObjectAxis.x Physics += #Physics.Projection.VoxelCenter.ObjectAxis.x Physics
    scoreboard players operation #Physics.Projection.VoxelCorner7.ObjectAxis.x Physics += #Physics.Projection.VoxelCenter.ObjectAxis.x Physics

    # Corner 0
    execute if score #Physics.ObjectA.Feature Physics matches 10 store result score #Physics.Maths.Value1 Physics store result score #Physics.Maths.Value2 Physics store result score #Physics.Maths.Value3 Physics store result score #Physics.Maths.Value4 Physics store result score #Physics.Maths.Value5 Physics store result score #Physics.Maths.Value6 Physics store result score #Physics.Maths.Value7 Physics run scoreboard players operation #Physics.MinPointDistance Physics = @s Physics.Object.ProjectionOwnAxis.x.Max
    execute if score #Physics.ObjectA.Feature Physics matches 11 store result score #Physics.Maths.Value1 Physics store result score #Physics.Maths.Value2 Physics store result score #Physics.Maths.Value3 Physics store result score #Physics.Maths.Value4 Physics store result score #Physics.Maths.Value5 Physics store result score #Physics.Maths.Value6 Physics store result score #Physics.Maths.Value7 Physics run scoreboard players operation #Physics.MinPointDistance Physics = @s Physics.Object.ProjectionOwnAxis.x.Min
    scoreboard players operation #Physics.MinPointDistance Physics -= #Physics.Projection.VoxelCorner0.ObjectAxis.x Physics
    execute if score #Physics.MinPointDistance Physics matches ..-1 run scoreboard players operation #Physics.MinPointDistance Physics *= #Physics.Constants.-1 Physics

    # Corner 1
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.VoxelCorner1.ObjectAxis.x Physics
    execute if score #Physics.Maths.Value1 Physics matches ..-1 run scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Constants.-1 Physics
    execute if score #Physics.MinPointDistance Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Maths.Value1 Physics

    # Corner 2
    scoreboard players operation #Physics.Maths.Value2 Physics -= #Physics.Projection.VoxelCorner2.ObjectAxis.x Physics
    execute if score #Physics.Maths.Value2 Physics matches ..-1 run scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Constants.-1 Physics
    execute if score #Physics.MinPointDistance Physics > #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Maths.Value2 Physics

    # Corner 3
    scoreboard players operation #Physics.Maths.Value3 Physics -= #Physics.Projection.VoxelCorner3.ObjectAxis.x Physics
    execute if score #Physics.Maths.Value3 Physics matches ..-1 run scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Constants.-1 Physics
    execute if score #Physics.MinPointDistance Physics > #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Maths.Value3 Physics

    # Corner 4
    scoreboard players operation #Physics.Maths.Value4 Physics -= #Physics.Projection.VoxelCorner4.ObjectAxis.x Physics
    execute if score #Physics.Maths.Value4 Physics matches ..-1 run scoreboard players operation #Physics.Maths.Value4 Physics *= #Physics.Constants.-1 Physics
    execute if score #Physics.MinPointDistance Physics > #Physics.Maths.Value4 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Maths.Value4 Physics

    # Corner 5
    scoreboard players operation #Physics.Maths.Value5 Physics -= #Physics.Projection.VoxelCorner5.ObjectAxis.x Physics
    execute if score #Physics.Maths.Value5 Physics matches ..-1 run scoreboard players operation #Physics.Maths.Value5 Physics *= #Physics.Constants.-1 Physics
    execute if score #Physics.MinPointDistance Physics > #Physics.Maths.Value5 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Maths.Value5 Physics

    # Corner 6
    scoreboard players operation #Physics.Maths.Value6 Physics -= #Physics.Projection.VoxelCorner6.ObjectAxis.x Physics
    execute if score #Physics.Maths.Value6 Physics matches ..-1 run scoreboard players operation #Physics.Maths.Value6 Physics *= #Physics.Constants.-1 Physics
    execute if score #Physics.MinPointDistance Physics > #Physics.Maths.Value6 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Maths.Value6 Physics

    # Corner 7
    scoreboard players operation #Physics.Maths.Value7 Physics -= #Physics.Projection.VoxelCorner7.ObjectAxis.x Physics
    execute if score #Physics.Maths.Value7 Physics matches ..-1 run scoreboard players operation #Physics.Maths.Value7 Physics *= #Physics.Constants.-1 Physics
    execute if score #Physics.MinPointDistance Physics > #Physics.Maths.Value7 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Maths.Value7 Physics

    # Set the feature
    scoreboard players set #Physics.ObjectB.Feature Physics 0
    execute if score #Physics.MinPointDistance Physics = #Physics.Maths.Value1 Physics run scoreboard players set #Physics.ObjectB.Feature Physics 1
    execute if score #Physics.MinPointDistance Physics = #Physics.Maths.Value2 Physics run scoreboard players set #Physics.ObjectB.Feature Physics 2
    execute if score #Physics.MinPointDistance Physics = #Physics.Maths.Value3 Physics run scoreboard players set #Physics.ObjectB.Feature Physics 3
    execute if score #Physics.MinPointDistance Physics = #Physics.Maths.Value4 Physics run scoreboard players set #Physics.ObjectB.Feature Physics 4
    execute if score #Physics.MinPointDistance Physics = #Physics.Maths.Value5 Physics run scoreboard players set #Physics.ObjectB.Feature Physics 5
    execute if score #Physics.MinPointDistance Physics = #Physics.Maths.Value6 Physics run scoreboard players set #Physics.ObjectB.Feature Physics 6
    execute if score #Physics.MinPointDistance Physics = #Physics.Maths.Value7 Physics run scoreboard players set #Physics.ObjectB.Feature Physics 7

# Debug: Show contact features
execute if score #Physics.Debug.ShowContactFeatures Physics matches 1 run function physics:debug/show_contact_features
