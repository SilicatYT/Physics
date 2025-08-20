# Get the features
    # Edge A
    $function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_xy/get_edge_a with storage physics:temp data.BlockEdge.$(FeatureA)

    # Edge B
    execute if score #Physics.Contact.FeatureB Physics matches 20 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_zy/get_edge_b {Edge:28b,StartCorner:0b,x:"Min",y:"Min",z:"Min"}
    execute if score #Physics.Contact.FeatureB Physics matches 21 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_zy/get_edge_b {Edge:29b,StartCorner:2b,x:"Max",y:"Min",z:"Min"}
    execute if score #Physics.Contact.FeatureB Physics matches 22 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_zy/get_edge_b {Edge:30b,StartCorner:4b,x:"Min",y:"Max",z:"Min"}
    function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_zy/get_edge_b {Edge:31b,StartCorner:6b,x:"Max",y:"Max",z:"Min"}
