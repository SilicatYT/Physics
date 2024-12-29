# Additional command that was skipped in the previous function (Exclusive to zz)
scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.zz Physics

# Get the object's feature (Edge that's closest to the world-geometry voxel)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
execute if score #Physics.Projection.Voxel.CrossProductAxis.zz.Min Physics >= #Physics.Projection.Object.CrossProductAxis.zz.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.zz.Max Physics
execute if score #Physics.Projection.Voxel.CrossProductAxis.zz.Min Physics < #Physics.Projection.Object.CrossProductAxis.zz.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.zz.Min Physics

    # Set the feature
    scoreboard players set #Physics.ObjectA.Feature Physics 208
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics run scoreboard players set #Physics.ObjectA.Feature Physics 209
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics run scoreboard players set #Physics.ObjectA.Feature Physics 210
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.zz Physics run scoreboard players set #Physics.ObjectA.Feature Physics 211

# Get the world-geometry voxel's feature (Edge that's closest to the object)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
execute if score #Physics.Projection.Voxel.CrossProductAxis.zz.Min Physics >= #Physics.Projection.Object.CrossProductAxis.zz.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.VoxelBase.CrossProductAxis.zz.Min Physics
execute if score #Physics.Projection.Voxel.CrossProductAxis.zz.Min Physics < #Physics.Projection.Object.CrossProductAxis.zz.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.VoxelBase.CrossProductAxis.zz.Max Physics

    # Set the feature
    scoreboard players set #Physics.ObjectB.Feature Physics 208
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.VoxelCornerBase2.CrossProductAxis.zz Physics run scoreboard players set #Physics.ObjectB.Feature Physics 209
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.VoxelCornerBase4.CrossProductAxis.zz Physics run scoreboard players set #Physics.ObjectB.Feature Physics 210
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.VoxelCornerBase6.CrossProductAxis.zz Physics run scoreboard players set #Physics.ObjectB.Feature Physics 211

# Debug: Show contact features
execute if score #Physics.Debug.ShowContactFeatures Physics matches 1 run function physics:debug/show_contact_features
