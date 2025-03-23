# Update all contacts for the current hitbox
# (Important): To save function calls and data + scoreboard operations, I hardcode the iterations. The number of contacts you can theoretically have is limited as well, so there's no need to recursively run this function multiple times. I limit it to 6 contacts per hitbox here, as I find it highly unlikely that it's reasonably possible to have more with the small contact distance threshold in mind, but it could be extended at any time.
# (Important): Only update if it's not the same contact that was generated in the current tick, as that one is already up to date.
execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]

    # Contact 1
    execute store result score #Physics.Contact.FeatureA Physics run data get storage physics:temp data.Hitbox.Contacts[-1].FeatureA
    execute store result score #Physics.Contact.FeatureB Physics run data get storage physics:temp data.Hitbox.Contacts[-1].FeatureB
    execute unless score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact with storage physics:temp data.Hitbox[-1]
    execute if score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics unless score #Physics.Contact.FeatureB Physics = #Physics.FeatureB Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact with storage physics:temp data.Hitbox[-1]
    execute if score #Physics.ContactCount Physics matches 1 run return 0

    # Contact 2
    data remove storage physics:temp data.Hitbox.Contacts[-1]
    execute store result score #Physics.Contact.FeatureA Physics run data get storage physics:temp data.Hitbox.Contacts[-1].FeatureA
    execute store result score #Physics.Contact.FeatureB Physics run data get storage physics:temp data.Hitbox.Contacts[-1].FeatureB
    execute unless score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact with storage physics:temp data.Hitbox[-1]
    execute if score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics unless score #Physics.Contact.FeatureB Physics = #Physics.FeatureB Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact with storage physics:temp data.Hitbox[-1]
    execute if score #Physics.ContactCount Physics matches 2 run return 0

    # Contact 3
    data remove storage physics:temp data.Hitbox.Contacts[-1]
    execute store result score #Physics.Contact.FeatureA Physics run data get storage physics:temp data.Hitbox.Contacts[-1].FeatureA
    execute store result score #Physics.Contact.FeatureB Physics run data get storage physics:temp data.Hitbox.Contacts[-1].FeatureB
    execute unless score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact with storage physics:temp data.Hitbox[-1]
    execute if score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics unless score #Physics.Contact.FeatureB Physics = #Physics.FeatureB Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact with storage physics:temp data.Hitbox[-1]
    execute if score #Physics.ContactCount Physics matches 3 run return 0

    # Contact 4
    data remove storage physics:temp data.Hitbox.Contacts[-1]
    execute store result score #Physics.Contact.FeatureA Physics run data get storage physics:temp data.Hitbox.Contacts[-1].FeatureA
    execute store result score #Physics.Contact.FeatureB Physics run data get storage physics:temp data.Hitbox.Contacts[-1].FeatureB
    execute unless score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact with storage physics:temp data.Hitbox[-1]
    execute if score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics unless score #Physics.Contact.FeatureB Physics = #Physics.FeatureB Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact with storage physics:temp data.Hitbox[-1]
    execute if score #Physics.ContactCount Physics matches 4 run return 0

    # Contact 5
    data remove storage physics:temp data.Hitbox.Contacts[-1]
    execute store result score #Physics.Contact.FeatureA Physics run data get storage physics:temp data.Hitbox.Contacts[-1].FeatureA
    execute store result score #Physics.Contact.FeatureB Physics run data get storage physics:temp data.Hitbox.Contacts[-1].FeatureB
    execute unless score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact with storage physics:temp data.Hitbox[-1]
    execute if score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics unless score #Physics.Contact.FeatureB Physics = #Physics.FeatureB Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact with storage physics:temp data.Hitbox[-1]
    execute if score #Physics.ContactCount Physics matches 5 run return 0

    # Contact 6
    data remove storage physics:temp data.Hitbox.Contacts[-1]
    execute store result score #Physics.Contact.FeatureA Physics run data get storage physics:temp data.Hitbox.Contacts[-1].FeatureA
    execute store result score #Physics.Contact.FeatureB Physics run data get storage physics:temp data.Hitbox.Contacts[-1].FeatureB
    execute unless score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact with storage physics:temp data.Hitbox[-1]
    execute if score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics unless score #Physics.Contact.FeatureB Physics = #Physics.FeatureB Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact with storage physics:temp data.Hitbox[-1]
