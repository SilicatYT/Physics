# Get the object's feature (Face that's closest to the world-geometry voxel)
# (Important): There are 2 candidate faces (those normal to the axis), and I select the correct one by looking at the projection of a single point of them and looking which is closer. If I look at the same point for both faces, I can easily get which face is closer.
execute if score #Physics.Projection.Voxel.ObjectAxis.z.Min Physics >= @s Physics.Object.ProjectionOwnAxis.z.Min run scoreboard players set #Physics.ObjectA.Feature Physics 104
execute if score #Physics.Projection.Voxel.ObjectAxis.z.Min Physics < @s Physics.Object.ProjectionOwnAxis.z.Min run scoreboard players set #Physics.ObjectA.Feature Physics 105

# Get the world-geometry voxel's feature (Corner that's closest to the object)
# (Important): I check which of the 8 corners' projection is the closest to the object along the axis (furthest along the axis), so I have to get either the min or the max.
execute if score #Physics.ObjectA.Feature Physics matches 104 run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.VoxelBase.ObjectAxis.z.Min Physics
execute if score #Physics.ObjectA.Feature Physics matches 105 run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.VoxelBase.ObjectAxis.z.Max Physics

    # Set the feature
    scoreboard players set #Physics.ObjectB.Feature Physics 0
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.VoxelCornerBase1.ObjectAxis.z Physics run scoreboard players set #Physics.ObjectB.Feature Physics 1
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.VoxelCornerBase2.ObjectAxis.z Physics run scoreboard players set #Physics.ObjectB.Feature Physics 2
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.VoxelCornerBase3.ObjectAxis.z Physics run scoreboard players set #Physics.ObjectB.Feature Physics 3
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.VoxelCornerBase4.ObjectAxis.z Physics run scoreboard players set #Physics.ObjectB.Feature Physics 4
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.VoxelCornerBase5.ObjectAxis.z Physics run scoreboard players set #Physics.ObjectB.Feature Physics 5
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.VoxelCornerBase6.ObjectAxis.z Physics run scoreboard players set #Physics.ObjectB.Feature Physics 6
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.VoxelCornerBase7.ObjectAxis.z Physics run scoreboard players set #Physics.ObjectB.Feature Physics 7

# Debug: Show contact features
execute if score #Physics.Debug.ShowContactFeatures Physics matches 1 run function physics:debug/show_contact_features
