# Get the edge (The deepest projection is the max)
scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.yx Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner0.CrossProductAxis.yx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yx/get_edge_b {Edge:20,StartCorner:0}

scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.yx Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis.yx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yx/get_edge_b {Edge:21,StartCorner:1}

scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis.yx Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis.yx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yx/get_edge_b {Edge:22,StartCorner:4}

scoreboard players operation #Physics.Projection.OtherObjectCorner5.CrossProductAxis.yx Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yx/get_edge_b {Edge:23,StartCorner:5}
