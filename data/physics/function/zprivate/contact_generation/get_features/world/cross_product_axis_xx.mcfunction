# Get the object's feature (Edge that's closest to the world-geometry voxel)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
execute if score #Physics.Projection.Voxel.CrossProductAxis.xx.Min Physics >= #Physics.Projection.Object.CrossProductAxis.xx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.xx.Max Physics
execute if score #Physics.Projection.Voxel.CrossProductAxis.xx.Min Physics < #Physics.Projection.Object.CrossProductAxis.xx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.xx.Min Physics

    # Set the feature
    scoreboard players set #Physics.ObjectA.Feature Physics 200
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics run scoreboard players set #Physics.ObjectA.Feature Physics 201
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics run scoreboard players set #Physics.ObjectA.Feature Physics 202
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics run scoreboard players set #Physics.ObjectA.Feature Physics 203

# Get the world-geometry voxel's feature (Edge that's closest to the object)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
execute if score #Physics.Projection.Voxel.CrossProductAxis.xx.Min Physics >= #Physics.Projection.Object.CrossProductAxis.xx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.VoxelBase.CrossProductAxis.xx.Min Physics
execute if score #Physics.Projection.Voxel.CrossProductAxis.xx.Min Physics < #Physics.Projection.Object.CrossProductAxis.xx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.VoxelBase.CrossProductAxis.xx.Max Physics

    # Set the feature
    scoreboard players set #Physics.ObjectB.Feature Physics 200
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.VoxelCornerBase1.CrossProductAxis.xx Physics run scoreboard players set #Physics.ObjectB.Feature Physics 201
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.VoxelCornerBase4.CrossProductAxis.xx Physics run scoreboard players set #Physics.ObjectB.Feature Physics 202
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.VoxelCornerBase5.CrossProductAxis.xx Physics run scoreboard players set #Physics.ObjectB.Feature Physics 203

# Debug: Show contact features
execute if score #Physics.Debug.ShowContactFeatures Physics matches 1 run function physics:debug/show_contact_features
