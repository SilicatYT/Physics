# Get the features
    # Edge A
    # (Important): Everything's cached, as there are only 4 possible values. So no "get_edge_a" function is necessary.
    $execute store result score #Physics.ObjectA.EdgeStart.x Physics run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosGlobal.$(FeatureA).x
    $execute store result score #Physics.ObjectA.EdgeStart.y Physics run scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.CornerPosGlobal.$(FeatureA).y
    $execute store result score #Physics.ObjectA.EdgeStart.z Physics run scoreboard players operation #Physics.Maths.Value3 Physics = @s Physics.Object.CornerPosGlobal.$(FeatureA).z

    $scoreboard players operation #Physics.ObjectA.EdgeProjection Physics = #Physics.Projection.ObjectCorner$(FeatureA).CrossProductAxis.xx Physics

    # Edge B
    # (Important): To save scoreboard checks and to avoid further calculations if the contact is invalid anyway, the rest of the logic is performed in this function.
    execute if score #Physics.Contact.FeatureB matches 20 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_xx/get_edge_b {StartCorner:0,x:"Min",y:"Min",z:"Min"}
    execute if score #Physics.Contact.FeatureB matches 21 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_xx/get_edge_b {StartCorner:1,x:"Min",y:"Min",z:"Max"}
    execute if score #Physics.Contact.FeatureB matches 22 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_xx/get_edge_b {StartCorner:4,x:"Min",y:"Max",z:"Min"}
    function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_xx/get_edge_b {StartCorner:5,x:"Min",y:"Max",z:"Max"}
