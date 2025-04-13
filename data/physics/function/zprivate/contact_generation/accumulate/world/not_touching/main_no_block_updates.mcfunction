# (Important): It iterates over all hitboxes in a hardcoded (not recursive) way to save performance. The limit for the number of hitboxes is arbitrarily set to 8.

# Setup
execute store result score #Physics.HitboxCount Physics if data storage physics:temp data.Blocks[-1].Hitboxes[]

# Hitbox 1
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-1]

    # Get the projections
    execute store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.Bottom[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.Bottom[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.Bottom[2]
    execute store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.Top[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.Top[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.Top[2]

    # Update the hitbox's contacts
    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox

# Hitbox 2
execute if score #Physics.HitboxCount Physics matches 1 run return 0
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-2]

    # Get the projections
    execute store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.Bottom[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.Bottom[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.Bottom[2]
    execute store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.Top[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.Top[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.Top[2]

    # Update the hitbox's contacts
    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox

# Hitbox 3
execute if score #Physics.HitboxCount Physics matches 2 run return 0
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-3]

    # Get the projections
    execute store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.Bottom[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.Bottom[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.Bottom[2]
    execute store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.Top[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.Top[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.Top[2]

    # Update the hitbox's contacts
    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox

# Hitbox 4
execute if score #Physics.HitboxCount Physics matches 3 run return 0
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-4]

    # Get the projections
    execute store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.Bottom[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.Bottom[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.Bottom[2]
    execute store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.Top[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.Top[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.Top[2]

    # Update the hitbox's contacts
    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox

# Hitbox 5
execute if score #Physics.HitboxCount Physics matches 4 run return 0
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-5]

    # Get the projections
    execute store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.Bottom[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.Bottom[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.Bottom[2]
    execute store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.Top[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.Top[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.Top[2]

    # Update the hitbox's contacts
    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox

# Hitbox 6
execute if score #Physics.HitboxCount Physics matches 5 run return 0
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-6]

    # Get the projections
    execute store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.Bottom[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.Bottom[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.Bottom[2]
    execute store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.Top[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.Top[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.Top[2]

    # Update the hitbox's contacts
    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox

# Hitbox 7
execute if score #Physics.HitboxCount Physics matches 6 run return 0
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-7]

    # Get the projections
    execute store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.Bottom[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.Bottom[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.Bottom[2]
    execute store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.Top[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.Top[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.Top[2]

    # Update the hitbox's contacts
    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox

# Hitbox 8
execute if score #Physics.HitboxCount Physics matches 7 run return 0
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-8]

    # Get the projections
    execute store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.Bottom[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.Bottom[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.Bottom[2]
    execute store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.Top[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.Top[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.Top[2]

    # Update the hitbox's contacts
    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox
