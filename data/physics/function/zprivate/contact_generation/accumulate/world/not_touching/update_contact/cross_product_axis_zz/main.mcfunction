# Get the features
    # Edge A
    $function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_xz/get_edge_a with storage physics:temp data.BlockEdge.$(FeatureA)

    # Edge B
    execute if score #Physics.Contact.FeatureB matches 20 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_zz/get_edge_b {Edge:28b,x:"Min",y:"Min",z:"Min"}
    execute if score #Physics.Contact.FeatureB matches 21 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_zz/get_edge_b {Edge:29b,x:"Max",y:"Min",z:"Min"}
    execute if score #Physics.Contact.FeatureB matches 22 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_zz/get_edge_b {Edge:30b,x:"Min",y:"Max",z:"Min"}
    function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_zz/get_edge_b {Edge:31b,x:"Max",y:"Max",z:"Min"}
