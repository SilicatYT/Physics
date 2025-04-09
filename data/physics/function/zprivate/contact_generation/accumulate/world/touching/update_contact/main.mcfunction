# Everything is cached because there are only 6 possible contacts
$execute if score #Physics.Contact.FeatureB Physics matches 10..11 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/world_axis_x with storage physics:temp data.Hitbox.Contacts[$(Index)]
$execute if score #Physics.Contact.FeatureB Physics matches 12..13 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/world_axis_y with storage physics:temp data.Hitbox.Contacts[$(Index)]
$execute if score #Physics.Contact.FeatureB Physics matches 14..15 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/world_axis_z with storage physics:temp data.Hitbox.Contacts[$(Index)]

$execute if score #Physics.Contact.FeatureA Physics matches 10..11 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/object_axis_x with storage physics:temp data.Hitbox.Contacts[$(Index)]
$execute if score #Physics.Contact.FeatureA Physics matches 12..13 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/object_axis_y with storage physics:temp data.Hitbox.Contacts[$(Index)]
$execute if score #Physics.Contact.FeatureA Physics matches 14..15 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/object_axis_z with storage physics:temp data.Hitbox.Contacts[$(Index)]

$execute if score #Physics.Contact.FeatureB Physics matches 20..23 if score #Physics.Contact.FeatureA Physics matches 20..23 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_xx with storage physics:temp data.Hitbox.Contacts[$(Index)]
$execute if score #Physics.Contact.FeatureB Physics matches 20..23 if score #Physics.Contact.FeatureA Physics matches 24..27 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_xy with storage physics:temp data.Hitbox.Contacts[$(Index)]
$execute if score #Physics.Contact.FeatureB Physics matches 20..23 if score #Physics.Contact.FeatureA Physics matches 28..31 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_xz with storage physics:temp data.Hitbox.Contacts[$(Index)]

$execute if score #Physics.Contact.FeatureB Physics matches 24..27 if score #Physics.Contact.FeatureA Physics matches 20..23 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_yx with storage physics:temp data.Hitbox.Contacts[$(Index)]
$execute if score #Physics.Contact.FeatureB Physics matches 24..27 if score #Physics.Contact.FeatureA Physics matches 24..27 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_yy with storage physics:temp data.Hitbox.Contacts[$(Index)]
$execute if score #Physics.Contact.FeatureB Physics matches 24..27 if score #Physics.Contact.FeatureA Physics matches 28..31 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_yz with storage physics:temp data.Hitbox.Contacts[$(Index)]

$execute if score #Physics.Contact.FeatureA Physics matches 20..23 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_zx with storage physics:temp data.Hitbox.Contacts[$(Index)]
$execute if score #Physics.Contact.FeatureA Physics matches 24..27 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_zy with storage physics:temp data.Hitbox.Contacts[$(Index)]
$function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_zz with storage physics:temp data.Hitbox.Contacts[$(Index)]
