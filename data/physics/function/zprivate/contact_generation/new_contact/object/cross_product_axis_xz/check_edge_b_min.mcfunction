# Get the edge (The deepest projection is the min)
scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_b {Edge:31,StartCorner:6}

scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis.xy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_b {Edge:30,StartCorner:4}

scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis.xy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_b {Edge:29,StartCorner:2}

scoreboard players operation #Physics.Projection.OtherObjectCorner6.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_b {Edge:28,StartCorner:0}
