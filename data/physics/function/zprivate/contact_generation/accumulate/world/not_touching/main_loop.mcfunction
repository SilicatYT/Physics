# Carry over contacts from the previous tick for blocks that aren't touching
    # Iterate over all the blocks to check if the check with an extended AABB succeeds (Assuming a full block hitbox)
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
