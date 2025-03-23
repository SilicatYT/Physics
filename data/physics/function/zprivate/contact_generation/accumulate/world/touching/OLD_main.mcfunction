# Update world contacts
# (Important): Instead of updating the contacts for one block and then calling the function again using recursion, I hardcode 100 blocks and use recursion if there are more than 100. This saves a lot of function calls, data and scoreboard operations. Once there are no more blocks, I just exit early.
# (Important): The updated contacts are stored in CurrentBlockContacts, because I don't know the index of the entry in data.Blocks[...] from inside the contacts_main function.
# (Important): Iterate over the contacts and add the updated ones to the final storage.
    # Block 1
    return 0
    data modify storage physics:temp data.Contacts set from storage physics:temp data.Blocks[-1].Contacts
    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Contacts[]
    execute if score #Physics.HitboxType Physics matches 1 run function physics:zprivate/contact_generation/accumulate/world/touching/contacts_main

    execute if score #Physics.BlockCount Physics matches 1 run return 0

    # Block 2
    # ...

    # ...

    # Block 100
    # ...

# Next loop
# ...

# IMPORTANT: IT ONLY UPDATES THE CURRENT HITBOX. SO NO ITERATION NECESSARY
