# Get the edge (The deepest projection is the max)
scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zx/get_edge_b {Edge:20,StartCorner:0}

scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zx/get_edge_b {Edge:21,StartCorner:1}

scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis.zx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zx/get_edge_b {Edge:22,StartCorner:4}

scoreboard players operation #Physics.Projection.OtherObjectCorner5.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zx/get_edge_b {Edge:23,StartCorner:5}
