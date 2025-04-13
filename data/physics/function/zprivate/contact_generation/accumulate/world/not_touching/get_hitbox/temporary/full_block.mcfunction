# Update each hitbox's contacts
    # Hitbox 1
        # Change Min and Max
        scoreboard players remove #Physics.Projection.Block.WorldAxis.x.Min Physics 500
        scoreboard players add #Physics.Projection.Block.WorldAxis.x.Max Physics 500
        scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Min Physics 500
        scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 500
        scoreboard players remove #Physics.Projection.Block.WorldAxis.z.Min Physics 500
        scoreboard players add #Physics.Projection.Block.WorldAxis.z.Max Physics 500

        # Update its contacts
        # NO! I don't know if I have data for ID:1b, I only know that I have data for **A** hitbox. So I still need to run the "HasContacts" checks from the regular "get_hitbox" function
        # Although.. If I use Hitboxes[0], what then? Then I know for sure, and most of the time the block won't have changed, so the ID should match (IF ITS A SINGLE HITBOX BLOCK).
        # But if the ID doesn't match, what should I do? Try to update the contacts regardless, or just scrap them completely?
        # Need to make sure I account for Hitboxes[{ID:1b}] being empty, causing data from the previous block to get re-used.
        # I could say: Get {ID:1b} (and use store success). If there is data, ...
        data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[0]
        execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
        function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox

# (Perhaps inline this?)
# Don't I need to get the hitbox's data first? Like... the actual contact data for {ID:1} or smth
# If there were more hitboxes, I'd need to do the "HasPreviousContacts" check.
# But I *THINK* I can just use Hitboxes[0] if it's a single-hitbox block (Because the odds that the block has updated in this specific tick are very low, so that extra performance cost is worth it).


# WAIT (SAME PROBLEM EXISTS IN THE ORIGINAL GET_HITBOX), WHAT IF TWO OBJECTS JUST TOUCH THE SAME BLOCK? THEN THE "execute store success" FOR THE HITBOX MIGHT FAIL BECAUSE THE DATA IS THE SAME.
# SO I THINK I HAVE TO COMPLETELY REMOVE THE "data.Hitbox" DATA BEFORE.
