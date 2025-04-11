# Check if the contact is still relevant
# (Important): I project this contact's normal onto the current tick's contact's normal. If it's less than 70%, the contact is discarded completely for stability and performance reasons. If it's less than 90%, just carry over the contact without updating it (invalid contact).
scoreboard players operation #Physics.DotProduct Physics = #Physics.CrossProductAxis.xy.y Physics
scoreboard players operation #Physics.DotProduct Physics *= #Physics.ContactNormal.y Physics

scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.CrossProductAxis.xy.z Physics
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ContactNormal.z Physics
scoreboard players operation #Physics.DotProduct Physics += #Physics.Maths.Value1 Physics

execute if score #Physics.ObjectA.EdgeProjection Physics > #Physics.ObjectB.EdgeProjection run scoreboard players operation #Physics.DotProduct Physics *= #Physics.Constants.-1 Physics

execute if score #Physics.DotProduct Physics matches ..700000 run return 0
$execute if score #Physics.DotProduct Physics matches ..900000 run data modify storage physics:zprivate data.ContactGroups[-1].Objects[-1].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureA:$(FeatureA)b}
execute if score #Physics.DotProduct Physics matches ..900000 store result storage physics:zprivate data.ContactGroups[-1].Objects[-1].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureB byte 1 run return run scoreboard players get #Physics.Contact.FeatureB Physics

# Get the features
    # Edge A
    # (Important): Everything's cached, as there are only 4 possible values. So no "get_edge_a" function is necessary.
    $function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_xy/get_edge_a with storage physics:temp data.BlockEdge.$(FeatureA)

    # Edge B
    # (Important): To save scoreboard checks and to avoid further calculations if the contact is invalid anyway, the rest of the logic is performed in this function.
    execute if score #Physics.Contact.FeatureB matches 20 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_xy/get_edge_b {FeatureB:20b,StartCorner:0b,x:"Min",y:"Min",z:"Min"}
    execute if score #Physics.Contact.FeatureB matches 21 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_xy/get_edge_b {FeatureB:21b,StartCorner:1b,x:"Min",y:"Min",z:"Max"}
    execute if score #Physics.Contact.FeatureB matches 22 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_xy/get_edge_b {FeatureB:22b,StartCorner:4b,x:"Min",y:"Max",z:"Min"}
    function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_xy/get_edge_b {FeatureB:23b,StartCorner:5b,x:"Min",y:"Max",z:"Max"}
