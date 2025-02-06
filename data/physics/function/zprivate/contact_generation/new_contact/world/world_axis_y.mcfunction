# Get the world-geometry block's feature (Face that's closest to the object)
# (Important): There are 2 candidate faces (those normal to the axis), and I select the correct one by looking at the projection of a single point of them and looking which is closer. If I look at the same point for both faces, I can easily get which face is closer.
execute if score @s Physics.Object.BoundingBoxGlobalMin.y < #Physics.Projection.Block.WorldAxis.y.Min Physics run scoreboard players set #Physics.ObjectB.Feature Physics 102
execute if score @s Physics.Object.BoundingBoxGlobalMin.y >= #Physics.Projection.Block.WorldAxis.y.Min Physics run scoreboard players set #Physics.ObjectB.Feature Physics 103

# Get the object's feature (Corner that's closest to the world-geometry block)
# (Important): I check which of the 8 corners' projection is the closest to the world-geometry block (furthest along in either the positive or negative direction, depending on the face).
execute if score #Physics.ObjectB.Feature Physics matches 102 run scoreboard players operation #Physics.DeepestProjection Physics = @s Physics.Object.BoundingBoxGlobalMax.y
execute if score #Physics.ObjectB.Feature Physics matches 103 run scoreboard players operation #Physics.DeepestProjection Physics = @s Physics.Object.BoundingBoxGlobalMin.y

    # Set the feature
    scoreboard players set #Physics.ObjectA.Feature Physics 0
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.1.y run scoreboard players set #Physics.ObjectA.Feature Physics 1
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.2.y run scoreboard players set #Physics.ObjectA.Feature Physics 2
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.3.y run scoreboard players set #Physics.ObjectA.Feature Physics 3
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.4.y run scoreboard players set #Physics.ObjectA.Feature Physics 4
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.5.y run scoreboard players set #Physics.ObjectA.Feature Physics 5
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.6.y run scoreboard players set #Physics.ObjectA.Feature Physics 6
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.7.y run scoreboard players set #Physics.ObjectA.Feature Physics 7

# Debug: Show contact features
execute if score #Physics.Debug.ShowContactFeatures Physics matches 1 run function physics:debug/show_contact_features
