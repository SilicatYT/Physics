# Get the features
    # Edge A
    $function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_xy/get_edge_a with storage physics:temp data.BlockEdge.$(FeatureA)

    # Edge B
    execute if score #Physics.Contact.FeatureB Physics matches 20 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_xy/get_edge_b {Edge:20b,StartCorner:0b,x:"Min",y:"Min",z:"Min"}
    execute if score #Physics.Contact.FeatureB Physics matches 21 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_xy/get_edge_b {Edge:21b,StartCorner:1b,x:"Min",y:"Min",z:"Max"}
    execute if score #Physics.Contact.FeatureB Physics matches 22 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_xy/get_edge_b {Edge:22b,StartCorner:4b,x:"Min",y:"Max",z:"Min"}
    function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_xy/get_edge_b {Edge:23b,StartCorner:5b,x:"Min",y:"Max",z:"Max"}
