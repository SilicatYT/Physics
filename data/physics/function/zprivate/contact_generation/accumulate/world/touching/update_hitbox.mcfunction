# Update all contacts for the current hitbox recursively, one contact at a time
# (Important): Only update if it's not the same contact that was generated in the current tick, as that one is already up to date.
# (Important): Instead of using recursion, I hardcoded up to 6 contacts to save a few operations (esp. being able to exit early in the "main" function).

# Contact 1
execute store result score #Physics.Contact.FeatureA Physics run data get storage physics:temp data.Hitbox.Contacts[-1].FeatureA
execute store result score #Physics.Contact.FeatureB Physics run data get storage physics:temp data.Hitbox.Contacts[-1].FeatureB
execute unless score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/main {Index:-1b}
execute if score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics unless score #Physics.Contact.FeatureB Physics = #Physics.FeatureB Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/main {Index:-1b}
execute if score #Physics.ContactCount Physics matches 1 run return 0

# Contact 2
execute store result score #Physics.Contact.FeatureA Physics run data get storage physics:temp data.Hitbox.Contacts[-2].FeatureA
execute store result score #Physics.Contact.FeatureB Physics run data get storage physics:temp data.Hitbox.Contacts[-2].FeatureB
execute unless score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/main {Index:-2b}
execute if score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics unless score #Physics.Contact.FeatureB Physics = #Physics.FeatureB Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/main {Index:-2b}
execute if score #Physics.ContactCount Physics matches 2 run return 0

# Contact 3
execute store result score #Physics.Contact.FeatureA Physics run data get storage physics:temp data.Hitbox.Contacts[-3].FeatureA
execute store result score #Physics.Contact.FeatureB Physics run data get storage physics:temp data.Hitbox.Contacts[-3].FeatureB
execute unless score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/main {Index:-3b}
execute if score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics unless score #Physics.Contact.FeatureB Physics = #Physics.FeatureB Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/main {Index:-3b}
execute if score #Physics.ContactCount Physics matches 3 run return 0

# Contact 4
execute store result score #Physics.Contact.FeatureA Physics run data get storage physics:temp data.Hitbox.Contacts[-4].FeatureA
execute store result score #Physics.Contact.FeatureB Physics run data get storage physics:temp data.Hitbox.Contacts[-4].FeatureB
execute unless score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/main {Index:-4b}
execute if score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics unless score #Physics.Contact.FeatureB Physics = #Physics.FeatureB Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/main {Index:-4b}
execute if score #Physics.ContactCount Physics matches 4 run return 0

# Contact 5
execute store result score #Physics.Contact.FeatureA Physics run data get storage physics:temp data.Hitbox.Contacts[-5].FeatureA
execute store result score #Physics.Contact.FeatureB Physics run data get storage physics:temp data.Hitbox.Contacts[-5].FeatureB
execute unless score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/main {Index:-5b}
execute if score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics unless score #Physics.Contact.FeatureB Physics = #Physics.FeatureB Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/main {Index:-5b}
execute if score #Physics.ContactCount Physics matches 5 run return 0

# Contact 6
execute store result score #Physics.Contact.FeatureA Physics run data get storage physics:temp data.Hitbox.Contacts[-6].FeatureA
execute store result score #Physics.Contact.FeatureB Physics run data get storage physics:temp data.Hitbox.Contacts[-6].FeatureB
execute unless score #Physics.Contact.FeatureA Physics = #Physics.FeatureA Physics run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/main {Index:-6b}
function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/main {Index:-6b}
