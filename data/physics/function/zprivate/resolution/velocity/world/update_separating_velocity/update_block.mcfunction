# Iterate over every hitbox of the current block to update its contacts
# (Important): Just like in accumulation, I decided that 8 hitboxes is the upper limit for keeping contacts, so I don't need recursion.

# Hitbox 1
    # Contact 1
    # (Important): The very first updated contact is always the min, so I tag it without checking first. No other contacts have been tagged yet, except the newly resolved contact that is *still* tagged. I will remove the tag and check for whether it should get the tag later on in the process.
        # Setup
        $execute store result score #Physics.Maths.RelativeContactPos.x Physics run data get storage physics:temp UpdateBlocks[$(Index)].Hitboxes[0].Contacts[0].ContactPoint[0]
        $execute store result score #Physics.Maths.RelativeContactPos.y Physics run data get storage physics:temp UpdateBlocks[$(Index)].Hitboxes[0].Contacts[0].ContactPoint[1]
        $execute store result score #Physics.Maths.RelativeContactPos.z Physics run data get storage physics:temp UpdateBlocks[$(Index)].Hitboxes[0].Contacts[0].ContactPoint[2]
        scoreboard players operation #Physics.Maths.RelativeContactPos.x Physics -= @s Physics.Object.Pos.x
        scoreboard players operation #Physics.Maths.RelativeContactPos.y Physics -= @s Physics.Object.Pos.y
        scoreboard players operation #Physics.Maths.RelativeContactPos.z Physics -= @s Physics.Object.Pos.z

        scoreboard players operation #Physics.ContactVelocityChange.z Physics = #Physics.AngularVelocityChange.x Physics
        scoreboard players operation #Physics.ContactVelocityChange.x Physics = #Physics.AngularVelocityChange.y Physics
        scoreboard players operation #Physics.ContactVelocityChange.y Physics = #Physics.AngularVelocityChange.z Physics

        # Cross product
        scoreboard players operation #Physics.ContactVelocityChange.x Physics *= #Physics.Maths.RelativeContactPos.z Physics
        scoreboard players operation #Physics.Maths.RelativeContactPos.y Physics *= #Physics.AngularVelocityChange.z Physics
        scoreboard players operation #Physics.ContactVelocityChange.x Physics -= #Physics.Maths.RelativeContactPos.y Physics
        scoreboard players operation #Physics.ContactVelocityChange.x Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.ContactVelocityChange.y Physics *= #Physics.Maths.RelativeContactPos.x Physics
        scoreboard players operation #Physics.Maths.RelativeContactPos.z Physics *= #Physics.AngularVelocityChange.x Physics
        scoreboard players operation #Physics.ContactVelocityChange.y Physics -= #Physics.Maths.RelativeContactPos.z Physics
        scoreboard players operation #Physics.ContactVelocityChange.y Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.ContactVelocityChange.z Physics *= #Physics.Maths.RelativeContactPos.y Physics
        scoreboard players operation #Physics.Maths.RelativeContactPos.x Physics *= #Physics.AngularVelocityChange.y Physics
        scoreboard players operation #Physics.ContactVelocityChange.z Physics -= #Physics.Maths.RelativeContactPos.x Physics
        scoreboard players operation #Physics.ContactVelocityChange.z Physics /= #Physics.Constants.1000 Physics

        # Update ContactVelocity
        scoreboard players operation #Physics.ContactVelocityChange.x Physics += #Physics.LinearVelocityChange.x Physics
        scoreboard players operation #Physics.ContactVelocityChange.y Physics += #Physics.LinearVelocityChange.y Physics
        scoreboard players operation #Physics.ContactVelocityChange.z Physics += #Physics.LinearVelocityChange.z Physics

        $execute store result score #Physics.ContactVelocity.x Physics run data get storage physics:temp UpdateBlocks[$(Index)].Hitboxes[0].Contacts[0].ContactVelocity[0]
        $execute store result storage physics:temp UpdateBlocks[$(Index)].Hitboxes[0].Contacts[0].ContactVelocity[0] int 1 run scoreboard players operation #Physics.ContactVelocity.x Physics += #Physics.ContactVelocityChange.x Physics
        $execute store result storage physics:temp UpdateBlocks[$(Index)].Hitboxes[0].Contacts[0].ContactVelocity[1] int 1 run scoreboard players operation #Physics.ContactVelocity.y Physics += #Physics.ContactVelocityChange.y Physics
        $execute store result storage physics:temp UpdateBlocks[$(Index)].Hitboxes[0].Contacts[0].ContactVelocity[2] int 1 run scoreboard players operation #Physics.ContactVelocity.z Physics += #Physics.ContactVelocityChange.z Physics

        # Update SeparatingVelocity
        $execute store result score #Physics.ContactNormal.x Physics run data get storage physics:temp UpdateBlocks[$(Index)].Hitboxes[0].Contacts[0].ContactNormal[0]
        $execute store result score #Physics.ContactNormal.y Physics run data get storage physics:temp UpdateBlocks[$(Index)].Hitboxes[0].Contacts[0].ContactNormal[1]
        $execute store result score #Physics.ContactNormal.z Physics run data get storage physics:temp UpdateBlocks[$(Index)].Hitboxes[0].Contacts[0].ContactNormal[2]

        scoreboard players operation #Physics.ContactNormal.x Physics *= #Physics.ContactVelocity.x Physics
        scoreboard players operation #Physics.ContactNormal.y Physics *= #Physics.ContactVelocity.y Physics
        scoreboard players operation #Physics.ContactNormal.z Physics *= #Physics.ContactVelocity.z Physics
        scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.y Physics
        scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.z Physics
        $execute store result storage physics:temp UpdateBlocks[$(Index)].Hitboxes[0].Contacts[0].HasMinSeparatingVelocity byte 0 store result score @s Physics.Object.MinSeparatingVelocity run scoreboard players operation #Physics.ContactNormal.x Physics /= #Physics.Constants.1000 Physics




$data modify storage physics:temp UpdateHitbox set from storage physics:temp UpdateBlocks[$(Index)].Hitboxes[0]





# TODO: Do hitbox 1 in the main function to avoid a function call if only 1 hitbox is present
#       Also, do contact 1 in this function right here to avoid a function call if only 1 contact is present




# Note: At most 6 contacts per hitbox
