# Get the features
    # Edge A
    $function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_yz/get_edge_a with storage physics:temp data.BlockEdge.$(FeatureA)

    # Edge B
    execute if score #Physics.Contact.FeatureB Physics matches 24 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_yz/get_edge_b {Edge:24b,StartCorner:0b}
    execute if score #Physics.Contact.FeatureB Physics matches 25 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_yz/get_edge_b {Edge:25b,StartCorner:1b}
    execute if score #Physics.Contact.FeatureB Physics matches 26 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_yz/get_edge_b {Edge:26b,StartCorner:2b}
    function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_yz/get_edge_b {Edge:27b,StartCorner:3b}
