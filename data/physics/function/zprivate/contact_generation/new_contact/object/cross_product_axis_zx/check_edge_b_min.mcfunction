# Get the edge (The deepest projection is the min)
scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zx/get_edge_b {Edge:23b,StartCorner:5b}

scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zx/get_edge_b {Edge:22b,StartCorner:4b}

scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis.zx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zx/get_edge_b {Edge:21b,StartCorner:1b}

scoreboard players operation #Physics.Projection.OtherObjectCorner5.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zx/get_edge_b {Edge:20b,StartCorner:0b}
