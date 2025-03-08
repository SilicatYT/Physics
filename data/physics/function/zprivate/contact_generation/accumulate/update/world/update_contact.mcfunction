# Update the current contact
# (Important): Contacts that are barely not touching will get carried over to the final storage, but they won't be updated. I need them in case they become relevant in the next tick, so they provide stability. But if they're out of touch in the current tick, I won't resolve them anyway. If they do get in touch again because of the resolution of other contacts, then they'll automatically get updated by the resolver anyway.
    # Check if the contact point is inside the respective object
    # (Important): This is done by checking if the contact point's projection along the 3 axes of the respective object is within the respective object's projection limits. A small threshold score is added to the limits, so barely separated contacts still get kept. If it's an edge-edge contact, the contact point has to be inside the block. If it's point-face, it depends.
    execute store result score #Physics.Contact.FeatureA Physics run data get storage physics:temp data.CurrentContact.FeatureA
    execute store result score #Physics.Contact.FeatureB Physics run data get storage physics:temp data.CurrentContact.FeatureB

# Where is the hitbox size stored? Currently nowhere, right?

# Temp
#data modify storage physics:zprivate data.ContactGroups[-1].Objects[0].Blocks[-1].Contacts append from storage physics:temp data.CurrentContact
