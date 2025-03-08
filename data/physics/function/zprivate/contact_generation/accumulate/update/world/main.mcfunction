# Update world contacts
# (Important): Instead of updating the contacts for one block and then calling the function again using recursion, I hardcode 100 blocks and use recursion if there are more than 100. This saves a lot of function calls, data and scoreboard operations. Once there are no more blocks, I just exit early.
# (Important): The updated contacts are stored in CurrentBlockContacts, because I don't know the index of the entry in data.Blocks[...] from inside the contacts_main function.
    # Block 1
    data modify storage physics:temp data.Contacts set from storage physics:temp data.Blocks[-1].Contacts
    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Contacts[]
    data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks append value {Contacts:[]}
    data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Pos set from storage physics:temp data.Blocks[-1].Pos

    execute store result score #Physics.BlockPos.x Physics run data get storage physics:temp data.Blocks[-1].Pos[0]
    execute store result score #Physics.BlockPos.y Physics run data get storage physics:temp data.Blocks[-1].Pos[1]
    execute store result score #Physics.BlockPos.z Physics run data get storage physics:temp data.Blocks[-1].Pos[2]

    function physics:zprivate/contact_generation/accumulate/update/world/contacts_main
    execute unless data storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts[0] run data remove storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1]

    execute if score #Physics.BlockCount Physics matches 1 run return 0

    # Block 2
    # ...

    # ...

    # Block 100
    # ...

# Next loop
# ...
