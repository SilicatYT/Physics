# Update world contacts
scoreboard players remove #Physics.ContactCount Physics 1
execute store result score #Physics.BlockCount Physics if data storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[]




# IMPORTANT: I FIRST COPY ALL THE BLOCKS TO A TEMPORARY STORAGE, THEN ITERATE OVER THAT. IF IT PASSES THE AABB CHECK, APPEND THE RESPECTIVE BLOCK TO THE ACTUAL STORAGE AND CHECK ITS CONTACTS. IF NO CONTACTS ARE VALID, REMOVE IT FROM THE STORAGE AGAIN, BUT KEEP IT IN THE TEMPORARY STORAGE. FOR THE CONTACTS, AUTOMATICALLY ACCEPT THEM IF THE GAMETIME MATCHES. ACCEPTED CONTACTS SHOULD GET APPENDED TO THE FINAL STORAGE.
# In the "check contacts" function, hardcode it as well. But there can only be a certain number of contacts anyway. So I should only hardcode that number and don't even do any looping if there are more, because there can't be more. 8*6 (point-face) + 3*4*4 (edge-edge) => 96 contacts max
# ALSO IMPORTANT: When the block passes the AABB check, copy over all the relevant block data from the storage and do the necessary projections (the base projections are still stored as scores, but THE CROSS PRODUCT AXES ARE OVERWRITTEN FOR THE BLOCKS. IF THAT'S BAD, DO THE WORLD UPDATES BEFORE GATHERING OBJECT CONTACTS), so it doesn't have to be done repeatedly.

    # Main (Update)
    # (Important): I hardcoded it so it can handle up to 100 blocks without any extra function calls. This also reduces the number of scoreboard operations and data operations significantly. If there are any remaining elements at the end, it loops again.
        # Contact 0
        # (Important): There is guaranteed to be at least one contact in the block's storage.




        # (If contact 1 exists, run the looping function. In there, start with element [-2])


# AT THE END, REMOVE THE BLOCKS DATA IF NOTHING IS LEFT.
