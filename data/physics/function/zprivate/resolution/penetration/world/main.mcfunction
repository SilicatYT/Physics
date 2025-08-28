# Get the block data that contains the contact to be resolved & remove the original
data modify storage physics:resolution Block set from storage physics:resolution Object.Objects[0].Blocks[{Hitboxes:[{Contacts:[{HasMaxPenetrationDepth:0b}]}]}]
data remove storage physics:resolution Object.Objects[0].Blocks[{Hitboxes:[{Contacts:[{HasMaxPenetrationDepth:0b}]}]}]

# Repeat for the hitbox
data modify storage physics:resolution Hitbox set from storage physics:resolution Block.Hitboxes[{Contacts:[{HasMaxPenetrationDepth:0b}]}]
data remove storage physics:resolution Block.Hitboxes[{Contacts:[{HasMaxPenetrationDepth:0b}]}]

# Get the contact to be resolved & remove the original
data modify storage physics:resolution Contact set from storage physics:resolution Hitbox.Contacts[{HasMaxPenetrationDepth:0b}]
data remove storage physics:resolution Hitbox.Contacts[{HasMaxPenetrationDepth:0b}]

# Resolve the contact
    # Calculate movement (Vector)
    # (Important): PenetrationDepth * ContactNormal
    execute store result score #Physics.Movement.x Physics run data get storage physics:resolution Contact.ContactNormal[0]
    execute store result score #Physics.Movement.y Physics run data get storage physics:resolution Contact.ContactNormal[1]
    execute store result score #Physics.Movement.z Physics run data get storage physics:resolution Contact.ContactNormal[2]
    execute store result score #Physics.PenetrationDepth Physics run data get storage physics:resolution Contact.PenetrationDepth

    scoreboard players operation #Physics.Movement.x Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Movement.y Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Movement.z Physics *= #Physics.PenetrationDepth Physics

    scoreboard players operation #Physics.Movement.x Physics /= #Physics.Constants.1000 Physics
    scoreboard players operation #Physics.Movement.y Physics /= #Physics.Constants.1000 Physics
    scoreboard players operation #Physics.Movement.z Physics /= #Physics.Constants.1000 Physics

    # Apply movement
    scoreboard players operation @s Physics.Object.Pos.x += #Physics.Movement.x Physics
    scoreboard players operation @s Physics.Object.Pos.y += #Physics.Movement.y Physics
    scoreboard players operation @s Physics.Object.Pos.z += #Physics.Movement.z Physics

data modify storage physics:resolution Contact.PenetrationDepth set value 0s

# Update other contacts' PenetrationDepth
scoreboard players set @s Physics.Object.MaxPenetrationDepth -2147483648

    # World contacts
        # Update the contacts from the remaining blocks (Blocks that don't contain the newly resolved contact)
        data modify storage physics:temp data.UpdateBlocks set from storage physics:resolution Object.Objects[0].Blocks
        execute store result score #Physics.BlockCount Physics if data storage physics:temp data.UpdateBlocks[]
        execute if score #Physics.BlockCount Physics matches 1.. run data modify storage physics:resolution Object.Objects[0].Blocks set value []
        execute if score #Physics.BlockCount Physics matches 1.. run function physics:zprivate/resolution/penetration/world/update_penetration_depth/main

        # Update the contacts from the current block & hitbox
        # (Important): I can't add the current block & hitbox to the previous step because I have to recursively iterate over the blocks, which means the order of entries will not necessarily stay the same. So I wouldn't be able to find the correct hitbox without tagging it. And tagging it might be slower than doing this separately.
        data modify storage physics:temp data.UpdateBlocks append from storage physics:resolution Block
        data modify storage physics:temp data.UpdateBlocks[-1].Hitboxes append from storage physics:resolution Hitbox
        execute if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[0].Contacts[0] run function physics:zprivate/resolution/penetration/world/update_penetration_depth/update_block
        data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp data.UpdateBlocks[-1]

        # Tag the newly resolved contact if necessary and add it to the hitbox
        execute if score @s Physics.Object.MaxPenetrationDepth matches 0.. run data remove storage physics:resolution Contact.HasMaxPenetrationDepth
        execute if score @s Physics.Object.MaxPenetrationDepth matches ..-1 run data remove storage physics:resolution Object.Objects[0].Blocks[].Hitboxes[].Contacts[].HasMaxPenetrationDepth
        execute if score @s Physics.Object.MaxPenetrationDepth matches ..-1 run scoreboard players set @s Physics.Object.MaxPenetrationDepth 0
        data modify storage physics:resolution Object.Objects[0].Blocks[-1].Hitboxes[-1].Contacts append from storage physics:resolution Contact

        # Set the MaxPenetrationDepth.World
        scoreboard players operation @s Physics.Object.MaxPenetrationDepth.World = @s Physics.Object.MaxPenetrationDepth

    # Object-object contacts
    # ...

    # Add the object data back to the final storage
    data modify storage physics:zprivate ContactGroups append from storage physics:resolution Object
