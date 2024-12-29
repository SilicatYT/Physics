# Get the world-geometry voxel's feature (Face that's closest to the object)
# (Important): There are 2 candidate faces (those normal to the axis), and I select the correct one by looking at the projection of a single point of them and looking which is closer. If I look at the same point for both faces, I can easily get which face is closer.
execute if score @s Physics.Object.BoundingBoxGlobalMin.z >= #Physics.Projection.Voxel.WorldAxis.z.Min Physics run scoreboard players set #Physics.ObjectB.Feature Physics 104
execute if score @s Physics.Object.BoundingBoxGlobalMin.z < #Physics.Projection.Voxel.WorldAxis.z.Min Physics run scoreboard players set #Physics.ObjectB.Feature Physics 105

# Get the object's feature (Corner that's closest to the world-geometry voxel)
# (Important): I check which of the 8 corners' projection is the closest to the world-geometry voxel (furthest along in either the positive or negative direction, depending on the face).
execute if score #Physics.ObjectB.Feature Physics matches 104 run scoreboard players operation #Physics.DeepestProjection Physics = @s Physics.Object.BoundingBoxGlobalMin.z
execute if score #Physics.ObjectB.Feature Physics matches 105 run scoreboard players operation #Physics.DeepestProjection Physics = @s Physics.Object.BoundingBoxGlobalMax.z

    # Set the feature
    scoreboard players set #Physics.ObjectA.Feature Physics 0
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.1.z run scoreboard players set #Physics.ObjectA.Feature Physics 1
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.2.z run scoreboard players set #Physics.ObjectA.Feature Physics 2
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.3.z run scoreboard players set #Physics.ObjectA.Feature Physics 3
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.4.z run scoreboard players set #Physics.ObjectA.Feature Physics 4
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.5.z run scoreboard players set #Physics.ObjectA.Feature Physics 5
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.6.z run scoreboard players set #Physics.ObjectA.Feature Physics 6
    execute if score #Physics.DeepestProjection Physics = @s Physics.Object.CornerPosGlobal.7.z run scoreboard players set #Physics.ObjectA.Feature Physics 7

# Debug: Show contact features
execute if score #Physics.Debug.ShowContactFeatures Physics matches 1 run function physics:debug/show_contact_features
