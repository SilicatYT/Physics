# Get the object's feature (Edge that's closest to the world-geometry block)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
execute if score #Physics.Projection.Block.CrossProductAxis.xz.Min Physics >= #Physics.Projection.Object.CrossProductAxis.xz.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.xz.Max Physics
execute if score #Physics.Projection.Block.CrossProductAxis.xz.Min Physics < #Physics.Projection.Object.CrossProductAxis.xz.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.xz.Min Physics

    # Set the feature
    scoreboard players set #Physics.ObjectA.Feature Physics 208
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.xz Physics run scoreboard players set #Physics.ObjectA.Feature Physics 209
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics run scoreboard players set #Physics.ObjectA.Feature Physics 210
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.xz Physics run scoreboard players set #Physics.ObjectA.Feature Physics 211

# Get the world-geometry block's feature (Edge that's closest to the object)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
execute if score #Physics.Projection.Block.CrossProductAxis.xz.Min Physics >= #Physics.Projection.Object.CrossProductAxis.xz.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.BlockBase.CrossProductAxis.xz.Min Physics
execute if score #Physics.Projection.Block.CrossProductAxis.xz.Min Physics < #Physics.Projection.Object.CrossProductAxis.xz.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.BlockBase.CrossProductAxis.xz.Max Physics

    # Set the feature
    scoreboard players set #Physics.ObjectB.Feature Physics 200
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase1.CrossProductAxis.xz Physics run scoreboard players set #Physics.ObjectB.Feature Physics 201
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase4.CrossProductAxis.xz Physics run scoreboard players set #Physics.ObjectB.Feature Physics 202
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase5.CrossProductAxis.xz Physics run scoreboard players set #Physics.ObjectB.Feature Physics 203

# Debug: Show contact features
execute if score #Physics.Debug.ShowContactFeatures Physics matches 1 run function physics:debug/show_contact_features
