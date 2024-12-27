# Get the world-geometry voxel's feature (Face that's closest to the object)
# (Important): There are 2 candidate faces (those normal to the axis), and I select the correct one by looking at the projection of a single point of them and looking which is closer. If I look at the same point for both faces, I can easily get which face is closer.
execute if score @s Physics.Object.BoundingBoxGlobalMin.y >= #Physics.Projection.Voxel.WorldAxis.y.Min Physics run scoreboard players set #Physics.ObjectB.Feature Physics 12
execute if score @s Physics.Object.BoundingBoxGlobalMin.y < #Physics.Projection.Voxel.WorldAxis.y.Min Physics run scoreboard players set #Physics.ObjectB.Feature Physics 13

# Get the object's feature (Corner that's closest to the world-geometry voxel)
# (Important): I check which of the 8 corners' projection is the closest to the world-geometry voxel's face. Basically, I get the smallest distance coming from both directions for each point, and compare which point has the smallest distance.
    # Corner 0
    execute if score #Physics.ObjectB.Feature Physics matches 12 store result score #Physics.Maths.Value1 Physics store result score #Physics.Maths.Value2 Physics store result score #Physics.Maths.Value3 Physics store result score #Physics.Maths.Value4 Physics store result score #Physics.Maths.Value5 Physics store result score #Physics.Maths.Value6 Physics store result score #Physics.Maths.Value7 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Projection.Voxel.WorldAxis.y.Max Physics
    execute if score #Physics.ObjectB.Feature Physics matches 13 store result score #Physics.Maths.Value1 Physics store result score #Physics.Maths.Value2 Physics store result score #Physics.Maths.Value3 Physics store result score #Physics.Maths.Value4 Physics store result score #Physics.Maths.Value5 Physics store result score #Physics.Maths.Value6 Physics store result score #Physics.Maths.Value7 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Projection.Voxel.WorldAxis.y.Min Physics
    scoreboard players operation #Physics.MinPointDistance Physics -= @s Physics.Object.CornerPosGlobal.0.y
    execute if score #Physics.MinPointDistance Physics matches ..-1 run scoreboard players operation #Physics.MinPointDistance Physics *= #Physics.Constants.-1 Physics

    # Corner 1
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.CornerPosGlobal.1.y
    execute if score #Physics.Maths.Value1 Physics matches ..-1 run scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Constants.-1 Physics
    execute if score #Physics.MinPointDistance Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Maths.Value1 Physics

    # Corner 2
    scoreboard players operation #Physics.Maths.Value2 Physics -= @s Physics.Object.CornerPosGlobal.2.y
    execute if score #Physics.Maths.Value2 Physics matches ..-1 run scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Constants.-1 Physics
    execute if score #Physics.MinPointDistance Physics > #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Maths.Value2 Physics

    # Corner 3
    scoreboard players operation #Physics.Maths.Value3 Physics -= @s Physics.Object.CornerPosGlobal.3.y
    execute if score #Physics.Maths.Value3 Physics matches ..-1 run scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Constants.-1 Physics
    execute if score #Physics.MinPointDistance Physics > #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Maths.Value3 Physics

    # Corner 4
    scoreboard players operation #Physics.Maths.Value4 Physics -= @s Physics.Object.CornerPosGlobal.4.y
    execute if score #Physics.Maths.Value4 Physics matches ..-1 run scoreboard players operation #Physics.Maths.Value4 Physics *= #Physics.Constants.-1 Physics
    execute if score #Physics.MinPointDistance Physics > #Physics.Maths.Value4 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Maths.Value4 Physics

    # Corner 5
    scoreboard players operation #Physics.Maths.Value5 Physics -= @s Physics.Object.CornerPosGlobal.5.y
    execute if score #Physics.Maths.Value5 Physics matches ..-1 run scoreboard players operation #Physics.Maths.Value5 Physics *= #Physics.Constants.-1 Physics
    execute if score #Physics.MinPointDistance Physics > #Physics.Maths.Value5 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Maths.Value5 Physics

    # Corner 6
    scoreboard players operation #Physics.Maths.Value6 Physics -= @s Physics.Object.CornerPosGlobal.6.y
    execute if score #Physics.Maths.Value6 Physics matches ..-1 run scoreboard players operation #Physics.Maths.Value6 Physics *= #Physics.Constants.-1 Physics
    execute if score #Physics.MinPointDistance Physics > #Physics.Maths.Value6 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Maths.Value6 Physics

    # Corner 7
    scoreboard players operation #Physics.Maths.Value7 Physics -= @s Physics.Object.CornerPosGlobal.7.y
    execute if score #Physics.Maths.Value7 Physics matches ..-1 run scoreboard players operation #Physics.Maths.Value7 Physics *= #Physics.Constants.-1 Physics
    execute if score #Physics.MinPointDistance Physics > #Physics.Maths.Value7 Physics run scoreboard players operation #Physics.MinPointDistance Physics = #Physics.Maths.Value7 Physics

    # Set the feature
    scoreboard players set #Physics.ObjectA.Feature Physics 0
    execute if score #Physics.MinPointDistance Physics = #Physics.Maths.Value1 Physics run scoreboard players set #Physics.ObjectA.Feature Physics 1
    execute if score #Physics.MinPointDistance Physics = #Physics.Maths.Value2 Physics run scoreboard players set #Physics.ObjectA.Feature Physics 2
    execute if score #Physics.MinPointDistance Physics = #Physics.Maths.Value3 Physics run scoreboard players set #Physics.ObjectA.Feature Physics 3
    execute if score #Physics.MinPointDistance Physics = #Physics.Maths.Value4 Physics run scoreboard players set #Physics.ObjectA.Feature Physics 4
    execute if score #Physics.MinPointDistance Physics = #Physics.Maths.Value5 Physics run scoreboard players set #Physics.ObjectA.Feature Physics 5
    execute if score #Physics.MinPointDistance Physics = #Physics.Maths.Value6 Physics run scoreboard players set #Physics.ObjectA.Feature Physics 6
    execute if score #Physics.MinPointDistance Physics = #Physics.Maths.Value7 Physics run scoreboard players set #Physics.ObjectA.Feature Physics 7

# Debug: Show contact features
execute if score #Physics.Debug.ShowContactFeatures Physics matches 1 run function physics:debug/show_contact_features
