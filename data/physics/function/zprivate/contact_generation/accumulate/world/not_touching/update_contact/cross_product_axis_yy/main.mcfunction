# Get the features
    # Edge A
    $function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_xy/get_edge_a with storage physics:temp data.BlockEdge.$(FeatureA)

    # Edge B
    execute if score #Physics.Contact.FeatureB matches 24 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_yy/get_edge_b {Edge:24b,x:"Min",y:"Min",z:"Min"}
    execute if score #Physics.Contact.FeatureB matches 25 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_yy/get_edge_b {Edge:25b,x:"Min",y:"Min",z:"Max"}
    execute if score #Physics.Contact.FeatureB matches 26 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_yy/get_edge_b {Edge:26b,x:"Max",y:"Min",z:"Min"}
    function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_yy/get_edge_b {Edge:27b,x:"Max",y:"Min",z:"Max"}
