# Carry over contacts from the previous tick for blocks that aren't touching
# (Important): All the contacts will either be discarded or carried over as "invalid" contacts.
    # Mark all remaining contacts as invalid
    data remove storage physics:temp data.Blocks[].Hitboxes[].Contacts[].SeparatingVelocity
    data remove storage physics:temp data.Blocks[].Hitboxes[].Contacts[].PenetrationDepth
    data remove storage physics:temp data.Blocks[].Hitboxes[].Contacts[].ContactNormal
    data remove storage physics:temp data.Blocks[].Hitboxes[].Contacts[].ContactPoint




    # I FORGOT: I NEED TO CHECK IF THAT BLOCK IS EVEN THERE ANYMORE.
    # If I didn't do the check, would it change anything? Perhaps it's even faster if I ignore it? (No macro, and blocks don't change often)
    # Although... the contact IS carried over, so what does the resolver do when updating a contact?
    # DO I HAVE TO SEND THE HITBOX DATA TO THE RESOLVER TOO?
    # DOES THE RESOLVER HAVE TO CALCULATE THE CROSS PRODUCTS AND STUFF LIKE THAT?
    # IF YES, I SHOULD JUST KEEP THOSE VALUES AND USE SEPARATE SCORE NAMES SO IT DOESN'T GET OVERWRITTEN BY OBJECT CONTACTS. THEN I DONT HAVE TO RECALCULATE EVERYTHING
    # I ASSUME THE DATA IN THE Hitboxes:[{ID:1,Contacts:[{...}]}] FORMAT HAS TO BE CORRECT. BUT TO UPDATE CONTACTS DURING RESOLUTION, DON'T I NEED THE HITBOX BOUNDARIES TOO? OTHERWISE, HOW WOULD I GET THE PENETRATION DEPTH AND STUFF LIKE THAT?
    # => USE A DIFFERENT SCORE NAME FOR WORLD CROSS PRODUCTS (TO AVOID GETTING OVERWRITTEN BEFORE RESOLUTION) AND STORE EACH HITBOX'S BOUNDING BOX IN NewContact. ALSO, GET EACH BLOCK'S HITBOX WHEN ACCUMULATING "Not Touching". HOW SHOULD I DO THAT FOR BLOCKS WITHIN THE AABB? AND WHAT IF ONE HITBOX IS TOUCHING BUT NOT THE OTHER?



    # Iterate over all the blocks to check if the check with an extended AABB succeeds (Assuming a full block hitbox)
    # (Important): It also assumes a full-block hitbox for blocks that are in the AABB (whose hitbox is already known).
    # (Important): 8 blocks (can't do more at once because of macro caching) are hardcoded to improve performance (less function calls, data operations and score checks). If there are more, another function will be called at the end that loops.
        # Block 1
        function physics:zprivate/contact_generation/accumulate/world/not_touching/check_aabb {Index:-1b}
        execute if score #Physics.BlockCount Physics matches 1 run return 0

        # Block 2
        function physics:zprivate/contact_generation/accumulate/world/not_touching/check_aabb {Index:-2b}
        execute if score #Physics.BlockCount Physics matches 2 run return 0

        # Block 3
        function physics:zprivate/contact_generation/accumulate/world/not_touching/check_aabb {Index:-3b}
        execute if score #Physics.BlockCount Physics matches 3 run return 0

        # Block 4
        function physics:zprivate/contact_generation/accumulate/world/not_touching/check_aabb {Index:-4b}
        execute if score #Physics.BlockCount Physics matches 4 run return 0

        # Block 5
        function physics:zprivate/contact_generation/accumulate/world/not_touching/check_aabb {Index:-5b}
        execute if score #Physics.BlockCount Physics matches 5 run return 0

        # Block 6
        function physics:zprivate/contact_generation/accumulate/world/not_touching/check_aabb {Index:-6b}
        execute if score #Physics.BlockCount Physics matches 6 run return 0

        # Block 7
        function physics:zprivate/contact_generation/accumulate/world/not_touching/check_aabb {Index:-7b}
        execute if score #Physics.BlockCount Physics matches 7 run return 0

        # Block 8
        function physics:zprivate/contact_generation/accumulate/world/not_touching/check_aabb {Index:-8b}
        execute if score #Physics.BlockCount Physics matches 8 run return 0

        # Start next loop
        scoreboard players remove #Physics.BlockCount Physics 8
        data remove storage physics:temp data.Blocks[-1]
        data remove storage physics:temp data.Blocks[-1]
        data remove storage physics:temp data.Blocks[-1]
        data remove storage physics:temp data.Blocks[-1]
        data remove storage physics:temp data.Blocks[-1]
        data remove storage physics:temp data.Blocks[-1]
        data remove storage physics:temp data.Blocks[-1]
        data remove storage physics:temp data.Blocks[-1]
        function physics:zprivate/contact_generation/accumulate/world/not_touching/main_loop
