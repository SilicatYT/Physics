execute if score #Physics.Contact.FeatureB Physics matches 10..11 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/world_axis_x
execute if score #Physics.Contact.FeatureB Physics matches 12..13 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/world_axis_y
execute if score #Physics.Contact.FeatureB Physics matches 14..15 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/world_axis_z

execute if score #Physics.Contact.FeatureA Physics matches 10..11 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/object_axis_x
execute if score #Physics.Contact.FeatureA Physics matches 12..13 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/object_axis_y
execute if score #Physics.Contact.FeatureA Physics matches 14..15 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/object_axis_z

execute if score #Physics.Contact.FeatureB Physics matches 20..23 if score #Physics.Contact.FeatureA Physics matches 20..23 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_xx
execute if score #Physics.Contact.FeatureB Physics matches 20..23 if score #Physics.Contact.FeatureA Physics matches 24..27 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_xy
execute if score #Physics.Contact.FeatureB Physics matches 20..23 if score #Physics.Contact.FeatureA Physics matches 28..31 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_xz

execute if score #Physics.Contact.FeatureB Physics matches 24..27 if score #Physics.Contact.FeatureA Physics matches 20..23 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_yx
execute if score #Physics.Contact.FeatureB Physics matches 24..27 if score #Physics.Contact.FeatureA Physics matches 24..27 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_yy
execute if score #Physics.Contact.FeatureB Physics matches 24..27 if score #Physics.Contact.FeatureA Physics matches 28..31 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_yz

execute if score #Physics.Contact.FeatureA Physics matches 20..23 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_zx
execute if score #Physics.Contact.FeatureA Physics matches 24..27 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_zy
function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_zz
