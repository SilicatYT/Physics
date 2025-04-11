# Get the edge (The deepest projection is the max)
scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_b {Edge:28b,StartCorner:0b}

scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis.xy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_b {Edge:29b,StartCorner:2b}

scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis.xy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_b {Edge:30b,StartCorner:4b}

scoreboard players operation #Physics.Projection.OtherObjectCorner6.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_b {Edge:31b,StartCorner:6b}
