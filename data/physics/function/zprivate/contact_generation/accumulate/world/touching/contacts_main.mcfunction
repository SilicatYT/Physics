# Update all contacts for this block
# (Important): Instead of updating one contact and then running this function again using recursion, I hardcode 20 contacts and use recursion if there are more than 20. This saves a lot of function calls, data and scoreboard operations. Once there are no more contacts, I just exit early.
# (Important): This function is only run if the blocks are in contact, so I need to check if the contact has already been updated (because it's the current tick's newly added contact), by checking the gametime data.
    # Contact 1
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-1].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-1]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-1]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 1 run return 0

    # Contact 2
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-2].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-2]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-2]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 2 run return 0

    # Contact 3
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-3].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-3]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-3]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 3 run return 0

    # Contact 4
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-4].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-4]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-4]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 4 run return 0

    # Contact 5
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-5].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-5]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-5]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 5 run return 0

    # Contact 6
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-6].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-6]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-6]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 6 run return 0

    # Contact 7
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-7].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-7]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-7]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 7 run return 0

    # Contact 8
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-8].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-8]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-8]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 8 run return 0

    # Contact 9
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-9].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-9]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-9]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 9 run return 0

    # Contact 10
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-10].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-10]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-10]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 10 run return 0

    # Contact 11
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-11].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-11]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-11]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 11 run return 0

    # Contact 12
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-12].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-12]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-12]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 12 run return 0

    # Contact 13
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-13].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-13]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-13]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 13 run return 0

    # Contact 14
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-14].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-14]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-14]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 14 run return 0

    # Contact 15
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-15].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-15]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-15]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 15 run return 0

    # Contact 16
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-16].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-16]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-16]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 16 run return 0

    # Contact 17
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-17].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-17]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-17]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 17 run return 0

    # Contact 18
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-18].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-18]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-18]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 18 run return 0

    # Contact 19
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-19].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-19]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-19]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
    execute if score #Physics.ContactCount Physics matches 19 run return 0

    # Contact 20
    execute store result score #Physics.Contact.Gametime Physics run data get storage physics:temp data.Contacts[-20].Gametime
    execute if score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.Contacts[-20]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run data modify storage physics:temp data.CurrentContact set from storage physics:temp data.Contacts[-20]
    execute unless score #Physics.Contact.Gametime Physics = #Physics.Gametime Physics run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact
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
function physics:zprivate/contact_generation/accumulate/world/touching/contacts_main
