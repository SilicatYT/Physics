# Get the object's feature (Edge that's closest to the world-geometry block)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
execute if score #Physics.Projection.Block.CrossProductAxis.zx.Min Physics >= #Physics.Projection.Object.CrossProductAxis.zx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.zx.Max Physics
execute if score #Physics.Projection.Block.CrossProductAxis.zx.Min Physics < #Physics.Projection.Object.CrossProductAxis.zx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.zx.Min Physics

    # Set the feature
    scoreboard players set #Physics.ObjectA.Feature Physics 200
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.zx Physics run scoreboard players set #Physics.ObjectA.Feature Physics 201
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics run scoreboard players set #Physics.ObjectA.Feature Physics 202
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.zx Physics run scoreboard players set #Physics.ObjectA.Feature Physics 203

# Get the world-geometry block's feature (Edge that's closest to the object)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
execute if score #Physics.Projection.Block.CrossProductAxis.zx.Min Physics >= #Physics.Projection.Object.CrossProductAxis.zx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.BlockBase.CrossProductAxis.zx.Min Physics
execute if score #Physics.Projection.Block.CrossProductAxis.zx.Min Physics < #Physics.Projection.Object.CrossProductAxis.zx.Min Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.BlockBase.CrossProductAxis.zx.Max Physics

    # Set the feature
    scoreboard players set #Physics.ObjectB.Feature Physics 208
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase2.CrossProductAxis.zx Physics run scoreboard players set #Physics.ObjectB.Feature Physics 209
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase4.CrossProductAxis.zx Physics run scoreboard players set #Physics.ObjectB.Feature Physics 210
    execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase6.CrossProductAxis.zx Physics run scoreboard players set #Physics.ObjectB.Feature Physics 211

# Debug: Show contact features
execute if score #Physics.Debug.ShowContactFeatures Physics matches 1 run function physics:debug/show_contact_features
