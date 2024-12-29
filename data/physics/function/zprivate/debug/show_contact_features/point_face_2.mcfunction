# Get point (Voxel)
execute if score #Physics.ObjectB.Feature Physics matches 0 store result storage physics:debug data.show_contact_features.Point_x double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.x.Min Physics
execute if score #Physics.ObjectB.Feature Physics matches 0 store result storage physics:debug data.show_contact_features.Point_z double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.z.Min Physics
execute if score #Physics.ObjectB.Feature Physics matches 1 store result storage physics:debug data.show_contact_features.Point_x double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.x.Min Physics
execute if score #Physics.ObjectB.Feature Physics matches 1 store result storage physics:debug data.show_contact_features.Point_z double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.z.Max Physics
execute if score #Physics.ObjectB.Feature Physics matches 2 store result storage physics:debug data.show_contact_features.Point_x double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.x.Max Physics
execute if score #Physics.ObjectB.Feature Physics matches 2 store result storage physics:debug data.show_contact_features.Point_z double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.z.Min Physics
execute if score #Physics.ObjectB.Feature Physics matches 3 store result storage physics:debug data.show_contact_features.Point_x double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.x.Max Physics
execute if score #Physics.ObjectB.Feature Physics matches 3 store result storage physics:debug data.show_contact_features.Point_z double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.z.Max Physics

execute if score #Physics.ObjectB.Feature Physics matches 4 store result storage physics:debug data.show_contact_features.Point_x double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.x.Min Physics
execute if score #Physics.ObjectB.Feature Physics matches 4 store result storage physics:debug data.show_contact_features.Point_z double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.z.Min Physics
execute if score #Physics.ObjectB.Feature Physics matches 5 store result storage physics:debug data.show_contact_features.Point_x double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.x.Min Physics
execute if score #Physics.ObjectB.Feature Physics matches 5 store result storage physics:debug data.show_contact_features.Point_z double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.z.Max Physics
execute if score #Physics.ObjectB.Feature Physics matches 6 store result storage physics:debug data.show_contact_features.Point_x double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.x.Max Physics
execute if score #Physics.ObjectB.Feature Physics matches 6 store result storage physics:debug data.show_contact_features.Point_z double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.z.Min Physics
execute if score #Physics.ObjectB.Feature Physics matches 7 store result storage physics:debug data.show_contact_features.Point_x double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.x.Max Physics
execute if score #Physics.ObjectB.Feature Physics matches 7 store result storage physics:debug data.show_contact_features.Point_z double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.z.Max Physics

execute if score #Physics.ObjectB.Feature Physics matches 0..3 store result storage physics:debug data.show_contact_features.Point_y double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.y.Min Physics
execute if score #Physics.ObjectB.Feature Physics matches 4..7 store result storage physics:debug data.show_contact_features.Point_y double 0.001 run scoreboard players get #Physics.Projection.Voxel.WorldAxis.y.Max Physics

# Get face (Object)
execute if score #Physics.ObjectA.Feature Physics matches 100 store result storage physics:debug data.show_contact_features.Face_Start1_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.3.x
execute if score #Physics.ObjectA.Feature Physics matches 100 store result storage physics:debug data.show_contact_features.Face_Start1_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.3.y
execute if score #Physics.ObjectA.Feature Physics matches 100 store result storage physics:debug data.show_contact_features.Face_Start1_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.3.z
execute if score #Physics.ObjectA.Feature Physics matches 100 store result storage physics:debug data.show_contact_features.Face_Stop1_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.6.x
execute if score #Physics.ObjectA.Feature Physics matches 100 store result storage physics:debug data.show_contact_features.Face_Stop1_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.6.y
execute if score #Physics.ObjectA.Feature Physics matches 100 store result storage physics:debug data.show_contact_features.Face_Stop1_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.6.z

execute if score #Physics.ObjectA.Feature Physics matches 100 store result storage physics:debug data.show_contact_features.Face_Start2_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.7.x
execute if score #Physics.ObjectA.Feature Physics matches 100 store result storage physics:debug data.show_contact_features.Face_Start2_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.7.y
execute if score #Physics.ObjectA.Feature Physics matches 100 store result storage physics:debug data.show_contact_features.Face_Start2_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.7.z
execute if score #Physics.ObjectA.Feature Physics matches 100 store result storage physics:debug data.show_contact_features.Face_Stop2_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.2.x
execute if score #Physics.ObjectA.Feature Physics matches 100 store result storage physics:debug data.show_contact_features.Face_Stop2_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.2.y
execute if score #Physics.ObjectA.Feature Physics matches 100 store result storage physics:debug data.show_contact_features.Face_Stop2_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.2.z

execute if score #Physics.ObjectA.Feature Physics matches 101 store result storage physics:debug data.show_contact_features.Face_Start1_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.1.x
execute if score #Physics.ObjectA.Feature Physics matches 101 store result storage physics:debug data.show_contact_features.Face_Start1_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.1.y
execute if score #Physics.ObjectA.Feature Physics matches 101 store result storage physics:debug data.show_contact_features.Face_Start1_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.1.z
execute if score #Physics.ObjectA.Feature Physics matches 101 store result storage physics:debug data.show_contact_features.Face_Stop1_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.4.x
execute if score #Physics.ObjectA.Feature Physics matches 101 store result storage physics:debug data.show_contact_features.Face_Stop1_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.4.y
execute if score #Physics.ObjectA.Feature Physics matches 101 store result storage physics:debug data.show_contact_features.Face_Stop1_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.4.z

execute if score #Physics.ObjectA.Feature Physics matches 101 store result storage physics:debug data.show_contact_features.Face_Start2_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.5.x
execute if score #Physics.ObjectA.Feature Physics matches 101 store result storage physics:debug data.show_contact_features.Face_Start2_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.5.y
execute if score #Physics.ObjectA.Feature Physics matches 101 store result storage physics:debug data.show_contact_features.Face_Start2_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.5.z
execute if score #Physics.ObjectA.Feature Physics matches 101 store result storage physics:debug data.show_contact_features.Face_Stop2_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.0.x
execute if score #Physics.ObjectA.Feature Physics matches 101 store result storage physics:debug data.show_contact_features.Face_Stop2_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.0.y
execute if score #Physics.ObjectA.Feature Physics matches 101 store result storage physics:debug data.show_contact_features.Face_Stop2_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.0.z

execute if score #Physics.ObjectA.Feature Physics matches 102 store result storage physics:debug data.show_contact_features.Face_Start1_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.4.x
execute if score #Physics.ObjectA.Feature Physics matches 102 store result storage physics:debug data.show_contact_features.Face_Start1_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.4.y
execute if score #Physics.ObjectA.Feature Physics matches 102 store result storage physics:debug data.show_contact_features.Face_Start1_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.4.z
execute if score #Physics.ObjectA.Feature Physics matches 102 store result storage physics:debug data.show_contact_features.Face_Stop1_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.7.x
execute if score #Physics.ObjectA.Feature Physics matches 102 store result storage physics:debug data.show_contact_features.Face_Stop1_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.7.y
execute if score #Physics.ObjectA.Feature Physics matches 102 store result storage physics:debug data.show_contact_features.Face_Stop1_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.7.z

execute if score #Physics.ObjectA.Feature Physics matches 102 store result storage physics:debug data.show_contact_features.Face_Start2_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.5.x
execute if score #Physics.ObjectA.Feature Physics matches 102 store result storage physics:debug data.show_contact_features.Face_Start2_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.5.y
execute if score #Physics.ObjectA.Feature Physics matches 102 store result storage physics:debug data.show_contact_features.Face_Start2_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.5.z
execute if score #Physics.ObjectA.Feature Physics matches 102 store result storage physics:debug data.show_contact_features.Face_Stop2_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.6.x
execute if score #Physics.ObjectA.Feature Physics matches 102 store result storage physics:debug data.show_contact_features.Face_Stop2_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.6.y
execute if score #Physics.ObjectA.Feature Physics matches 102 store result storage physics:debug data.show_contact_features.Face_Stop2_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.6.z

execute if score #Physics.ObjectA.Feature Physics matches 103 store result storage physics:debug data.show_contact_features.Face_Start1_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.0.x
execute if score #Physics.ObjectA.Feature Physics matches 103 store result storage physics:debug data.show_contact_features.Face_Start1_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.0.y
execute if score #Physics.ObjectA.Feature Physics matches 103 store result storage physics:debug data.show_contact_features.Face_Start1_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.0.z
execute if score #Physics.ObjectA.Feature Physics matches 103 store result storage physics:debug data.show_contact_features.Face_Stop1_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.3.x
execute if score #Physics.ObjectA.Feature Physics matches 103 store result storage physics:debug data.show_contact_features.Face_Stop1_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.3.y
execute if score #Physics.ObjectA.Feature Physics matches 103 store result storage physics:debug data.show_contact_features.Face_Stop1_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.3.z

execute if score #Physics.ObjectA.Feature Physics matches 103 store result storage physics:debug data.show_contact_features.Face_Start2_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.1.x
execute if score #Physics.ObjectA.Feature Physics matches 103 store result storage physics:debug data.show_contact_features.Face_Start2_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.1.y
execute if score #Physics.ObjectA.Feature Physics matches 103 store result storage physics:debug data.show_contact_features.Face_Start2_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.1.z
execute if score #Physics.ObjectA.Feature Physics matches 103 store result storage physics:debug data.show_contact_features.Face_Stop2_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.2.x
execute if score #Physics.ObjectA.Feature Physics matches 103 store result storage physics:debug data.show_contact_features.Face_Stop2_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.2.y
execute if score #Physics.ObjectA.Feature Physics matches 103 store result storage physics:debug data.show_contact_features.Face_Stop2_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.2.z

execute if score #Physics.ObjectA.Feature Physics matches 104 store result storage physics:debug data.show_contact_features.Face_Start1_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.3.x
execute if score #Physics.ObjectA.Feature Physics matches 104 store result storage physics:debug data.show_contact_features.Face_Start1_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.3.y
execute if score #Physics.ObjectA.Feature Physics matches 104 store result storage physics:debug data.show_contact_features.Face_Start1_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.3.z
execute if score #Physics.ObjectA.Feature Physics matches 104 store result storage physics:debug data.show_contact_features.Face_Stop1_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.5.x
execute if score #Physics.ObjectA.Feature Physics matches 104 store result storage physics:debug data.show_contact_features.Face_Stop1_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.5.y
execute if score #Physics.ObjectA.Feature Physics matches 104 store result storage physics:debug data.show_contact_features.Face_Stop1_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.5.z

execute if score #Physics.ObjectA.Feature Physics matches 104 store result storage physics:debug data.show_contact_features.Face_Start2_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.7.x
execute if score #Physics.ObjectA.Feature Physics matches 104 store result storage physics:debug data.show_contact_features.Face_Start2_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.7.y
execute if score #Physics.ObjectA.Feature Physics matches 104 store result storage physics:debug data.show_contact_features.Face_Start2_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.7.z
execute if score #Physics.ObjectA.Feature Physics matches 104 store result storage physics:debug data.show_contact_features.Face_Stop2_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.1.x
execute if score #Physics.ObjectA.Feature Physics matches 104 store result storage physics:debug data.show_contact_features.Face_Stop2_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.1.y
execute if score #Physics.ObjectA.Feature Physics matches 104 store result storage physics:debug data.show_contact_features.Face_Stop2_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.1.z

execute if score #Physics.ObjectA.Feature Physics matches 105 store result storage physics:debug data.show_contact_features.Face_Start1_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.0.x
execute if score #Physics.ObjectA.Feature Physics matches 105 store result storage physics:debug data.show_contact_features.Face_Start1_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.0.y
execute if score #Physics.ObjectA.Feature Physics matches 105 store result storage physics:debug data.show_contact_features.Face_Start1_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.0.z
execute if score #Physics.ObjectA.Feature Physics matches 105 store result storage physics:debug data.show_contact_features.Face_Stop1_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.6.x
execute if score #Physics.ObjectA.Feature Physics matches 105 store result storage physics:debug data.show_contact_features.Face_Stop1_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.6.y
execute if score #Physics.ObjectA.Feature Physics matches 105 store result storage physics:debug data.show_contact_features.Face_Stop1_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.6.z

execute if score #Physics.ObjectA.Feature Physics matches 105 store result storage physics:debug data.show_contact_features.Face_Start2_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.4.x
execute if score #Physics.ObjectA.Feature Physics matches 105 store result storage physics:debug data.show_contact_features.Face_Start2_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.4.y
execute if score #Physics.ObjectA.Feature Physics matches 105 store result storage physics:debug data.show_contact_features.Face_Start2_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.4.z
execute if score #Physics.ObjectA.Feature Physics matches 105 store result storage physics:debug data.show_contact_features.Face_Stop2_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.2.x
execute if score #Physics.ObjectA.Feature Physics matches 105 store result storage physics:debug data.show_contact_features.Face_Stop2_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.2.y
execute if score #Physics.ObjectA.Feature Physics matches 105 store result storage physics:debug data.show_contact_features.Face_Stop2_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.2.z

# Convert to string (So .0 doesn't turn into .5)
data modify storage physics:debug data.show_contact_features.Point_x set string storage physics:debug data.show_contact_features.Point_x 0 -1
data modify storage physics:debug data.show_contact_features.Point_y set string storage physics:debug data.show_contact_features.Point_y 0 -1
data modify storage physics:debug data.show_contact_features.Point_z set string storage physics:debug data.show_contact_features.Point_z 0 -1
data modify storage physics:debug data.show_contact_features.Face_Start1_x set string storage physics:debug data.show_contact_features.Face_Start1_x 0 -1
data modify storage physics:debug data.show_contact_features.Face_Start1_y set string storage physics:debug data.show_contact_features.Face_Start1_y 0 -1
data modify storage physics:debug data.show_contact_features.Face_Start1_z set string storage physics:debug data.show_contact_features.Face_Start1_z 0 -1
data modify storage physics:debug data.show_contact_features.Face_Stop1_x set string storage physics:debug data.show_contact_features.Face_Stop1_x 0 -1
data modify storage physics:debug data.show_contact_features.Face_Stop1_y set string storage physics:debug data.show_contact_features.Face_Stop1_y 0 -1
data modify storage physics:debug data.show_contact_features.Face_Stop1_z set string storage physics:debug data.show_contact_features.Face_Stop1_z 0 -1
data modify storage physics:debug data.show_contact_features.Face_Start2_x set string storage physics:debug data.show_contact_features.Face_Start2_x 0 -1
data modify storage physics:debug data.show_contact_features.Face_Start2_y set string storage physics:debug data.show_contact_features.Face_Start2_y 0 -1
data modify storage physics:debug data.show_contact_features.Face_Start2_z set string storage physics:debug data.show_contact_features.Face_Start2_z 0 -1
data modify storage physics:debug data.show_contact_features.Face_Stop2_x set string storage physics:debug data.show_contact_features.Face_Stop2_x 0 -1
data modify storage physics:debug data.show_contact_features.Face_Stop2_y set string storage physics:debug data.show_contact_features.Face_Stop2_y 0 -1
data modify storage physics:debug data.show_contact_features.Face_Stop2_z set string storage physics:debug data.show_contact_features.Face_Stop2_z 0 -1

# Show
function physics:zprivate/debug/show_contact_features/show_point_face with storage physics:debug data.show_contact_features
