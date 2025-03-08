# Update all contacts for this block
# (Important): Instead of updating one contact and then running this function again using recursion, I hardcode 20 contacts and use recursion if there are more than 20. This saves a lot of function calls, data and scoreboard operations. Once there are no more contacts, I just exit early.
# (Important): This function is only run if the block isn't in contact, so there's no contact from the current tick. So I don't need to check the gametime data.
    # Contact 1
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-1]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 1 run return 0

    # Contact 2
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-2]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 2 run return 0

    # Contact 3
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-3]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 3 run return 0

    # Contact 4
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-4]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 4 run return 0

    # Contact 5
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-5]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 5 run return 0

    # Contact 6
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-6]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 6 run return 0

    # Contact 7
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-7]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 7 run return 0

    # Contact 8
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-8]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 8 run return 0

    # Contact 9
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-9]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 9 run return 0

    # Contact 10
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-10]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 10 run return 0

    # Contact 11
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-11]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 11 run return 0

    # Contact 12
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-12]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 12 run return 0

    # Contact 13
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-13]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 13 run return 0

    # Contact 14
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-14]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 14 run return 0

    # Contact 15
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-15]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 15 run return 0

    # Contact 16
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-16]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 16 run return 0

    # Contact 17
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-17]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 17 run return 0

    # Contact 18
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-18]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 18 run return 0

    # Contact 19
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-19]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 19 run return 0

    # Contact 20
    data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-20]
    function physics:zprivate/contact_generation/accumulate/update/world/update_contact
    execute if score #Physics.ContactCount Physics matches 20 run return 0

# Next loop
scoreboard players remove #Physics.ContactCount Physics 20
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
data remove storage physics:temp data.Contacts[-1]
function physics:zprivate/contact_generation/accumulate/update/world/contacts_main
