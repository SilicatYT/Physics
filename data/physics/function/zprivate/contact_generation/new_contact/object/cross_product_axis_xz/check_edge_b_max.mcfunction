# Get the edge (The deepest projection is the max)
scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.xy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.xy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_b {Edge:208,StartCorner:0}

scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.xy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.xy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_b {Edge:209,StartCorner:2}

scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.xy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.xy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_b {Edge:210,StartCorner:4}

scoreboard players operation #Physics.Projection.OtherObjectCorner6.CrossProductAxis2.xy Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_b {Edge:211,StartCorner:6}
