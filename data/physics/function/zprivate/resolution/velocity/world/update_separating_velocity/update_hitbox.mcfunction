# Iterate over every contact of the current hitbox to update its ContactVelocity and SeparatingVelocity
# (Important): Just like in accumulation, I decided that 6 contacts per hitbox is the upper limit, so I don't need recursion.
$execute store result score #Physics.ContactCount Physics if data storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[]

# Contact 1
    # Setup
    $execute store result score #Physics.Maths.RelativeContactPos.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[0].ContactPoint[0]
    $execute store result score #Physics.Maths.RelativeContactPos.y Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[0].ContactPoint[1]
    $execute store result score #Physics.Maths.RelativeContactPos.z Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[0].ContactPoint[2]
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

    $execute store result score #Physics.ContactVelocity.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[0].ContactVelocity[0]
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[0].ContactVelocity[0] int 1 run scoreboard players operation #Physics.ContactVelocity.x Physics += #Physics.ContactVelocityChange.x Physics
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[0].ContactVelocity[1] int 1 run scoreboard players operation #Physics.ContactVelocity.y Physics += #Physics.ContactVelocityChange.y Physics
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[0].ContactVelocity[2] int 1 run scoreboard players operation #Physics.ContactVelocity.z Physics += #Physics.ContactVelocityChange.z Physics

    # Update SeparatingVelocity
    $execute store result score #Physics.ContactNormal.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[0].ContactNormal[0]
    $execute store result score #Physics.ContactNormal.y Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[0].ContactNormal[1]
    $execute store result score #Physics.ContactNormal.z Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[0].ContactNormal[2]

    scoreboard players operation #Physics.ContactNormal.x Physics *= #Physics.ContactVelocity.x Physics
    scoreboard players operation #Physics.ContactNormal.y Physics *= #Physics.ContactVelocity.y Physics
    scoreboard players operation #Physics.ContactNormal.z Physics *= #Physics.ContactVelocity.z Physics
    scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.y Physics
    scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.z Physics

    $execute if score #Physics.ContactNormal.x Physics < @s Physics.Object.MinSeparatingVelocity store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[0].HasMinSeparatingVelocity byte 0 run data remove storage physics:resolution Object.Objects[0].Blocks[].Hitboxes[].Contacts[{HasMinSeparatingVelocity:0b}].HasMinSeparatingVelocity
    execute if score #Physics.ContactNormal.x Physics < @s Physics.Object.MinSeparatingVelocity run scoreboard players operation @s Physics.Object.MinSeparatingVelocity = #Physics.ContactNormal.x Physics

execute if score #Physics.ContactCount Physics matches 1 run return 0

# Contact 2
    # Setup
    $execute store result score #Physics.Maths.RelativeContactPos.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[1].ContactPoint[0]
    $execute store result score #Physics.Maths.RelativeContactPos.y Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[1].ContactPoint[1]
    $execute store result score #Physics.Maths.RelativeContactPos.z Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[1].ContactPoint[2]
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

    $execute store result score #Physics.ContactVelocity.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[1].ContactVelocity[0]
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[1].ContactVelocity[0] int 1 run scoreboard players operation #Physics.ContactVelocity.x Physics += #Physics.ContactVelocityChange.x Physics
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[1].ContactVelocity[1] int 1 run scoreboard players operation #Physics.ContactVelocity.y Physics += #Physics.ContactVelocityChange.y Physics
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[1].ContactVelocity[2] int 1 run scoreboard players operation #Physics.ContactVelocity.z Physics += #Physics.ContactVelocityChange.z Physics

    # Update SeparatingVelocity
    $execute store result score #Physics.ContactNormal.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[1].ContactNormal[0]
    $execute store result score #Physics.ContactNormal.y Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[1].ContactNormal[1]
    $execute store result score #Physics.ContactNormal.z Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[1].ContactNormal[2]

    scoreboard players operation #Physics.ContactNormal.x Physics *= #Physics.ContactVelocity.x Physics
    scoreboard players operation #Physics.ContactNormal.y Physics *= #Physics.ContactVelocity.y Physics
    scoreboard players operation #Physics.ContactNormal.z Physics *= #Physics.ContactVelocity.z Physics
    scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.y Physics
    scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.z Physics

    $execute if score #Physics.ContactNormal.x Physics < @s Physics.Object.MinSeparatingVelocity store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[1].HasMinSeparatingVelocity byte 0 run data remove storage physics:resolution Object.Objects[0].Blocks[].Hitboxes[].Contacts[{HasMinSeparatingVelocity:0b}].HasMinSeparatingVelocity
    execute if score #Physics.ContactNormal.x Physics < @s Physics.Object.MinSeparatingVelocity run scoreboard players operation @s Physics.Object.MinSeparatingVelocity = #Physics.ContactNormal.x Physics

execute if score #Physics.ContactCount Physics matches 2 run return 0

# Contact 3
    # Setup
    $execute store result score #Physics.Maths.RelativeContactPos.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[2].ContactPoint[0]
    $execute store result score #Physics.Maths.RelativeContactPos.y Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[2].ContactPoint[1]
    $execute store result score #Physics.Maths.RelativeContactPos.z Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[2].ContactPoint[2]
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

    $execute store result score #Physics.ContactVelocity.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[2].ContactVelocity[0]
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[2].ContactVelocity[0] int 1 run scoreboard players operation #Physics.ContactVelocity.x Physics += #Physics.ContactVelocityChange.x Physics
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[2].ContactVelocity[1] int 1 run scoreboard players operation #Physics.ContactVelocity.y Physics += #Physics.ContactVelocityChange.y Physics
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[2].ContactVelocity[2] int 1 run scoreboard players operation #Physics.ContactVelocity.z Physics += #Physics.ContactVelocityChange.z Physics

    # Update SeparatingVelocity
    $execute store result score #Physics.ContactNormal.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[2].ContactNormal[0]
    $execute store result score #Physics.ContactNormal.y Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[2].ContactNormal[1]
    $execute store result score #Physics.ContactNormal.z Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[2].ContactNormal[2]

    scoreboard players operation #Physics.ContactNormal.x Physics *= #Physics.ContactVelocity.x Physics
    scoreboard players operation #Physics.ContactNormal.y Physics *= #Physics.ContactVelocity.y Physics
    scoreboard players operation #Physics.ContactNormal.z Physics *= #Physics.ContactVelocity.z Physics
    scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.y Physics
    scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.z Physics

    $execute if score #Physics.ContactNormal.x Physics < @s Physics.Object.MinSeparatingVelocity store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[2].HasMinSeparatingVelocity byte 0 run data remove storage physics:resolution Object.Objects[0].Blocks[].Hitboxes[].Contacts[{HasMinSeparatingVelocity:0b}].HasMinSeparatingVelocity
    execute if score #Physics.ContactNormal.x Physics < @s Physics.Object.MinSeparatingVelocity run scoreboard players operation @s Physics.Object.MinSeparatingVelocity = #Physics.ContactNormal.x Physics

execute if score #Physics.ContactCount Physics matches 3 run return 0

# Contact 4
    # Setup
    $execute store result score #Physics.Maths.RelativeContactPos.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].ContactPoint[0]
    $execute store result score #Physics.Maths.RelativeContactPos.y Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].ContactPoint[1]
    $execute store result score #Physics.Maths.RelativeContactPos.z Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].ContactPoint[2]
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

    $execute store result score #Physics.ContactVelocity.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].ContactVelocity[0]
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].ContactVelocity[0] int 1 run scoreboard players operation #Physics.ContactVelocity.x Physics += #Physics.ContactVelocityChange.x Physics
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].ContactVelocity[1] int 1 run scoreboard players operation #Physics.ContactVelocity.y Physics += #Physics.ContactVelocityChange.y Physics
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].ContactVelocity[2] int 1 run scoreboard players operation #Physics.ContactVelocity.z Physics += #Physics.ContactVelocityChange.z Physics

    # Update SeparatingVelocity
    $execute store result score #Physics.ContactNormal.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].ContactNormal[0]
    $execute store result score #Physics.ContactNormal.y Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].ContactNormal[1]
    $execute store result score #Physics.ContactNormal.z Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].ContactNormal[2]

    scoreboard players operation #Physics.ContactNormal.x Physics *= #Physics.ContactVelocity.x Physics
    scoreboard players operation #Physics.ContactNormal.y Physics *= #Physics.ContactVelocity.y Physics
    scoreboard players operation #Physics.ContactNormal.z Physics *= #Physics.ContactVelocity.z Physics
    scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.y Physics
    scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.z Physics

    $execute if score #Physics.ContactNormal.x Physics < @s Physics.Object.MinSeparatingVelocity store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].HasMinSeparatingVelocity byte 0 run data remove storage physics:resolution Object.Objects[0].Blocks[].Hitboxes[].Contacts[{HasMinSeparatingVelocity:0b}].HasMinSeparatingVelocity
    execute if score #Physics.ContactNormal.x Physics < @s Physics.Object.MinSeparatingVelocity run scoreboard players operation @s Physics.Object.MinSeparatingVelocity = #Physics.ContactNormal.x Physics

execute if score #Physics.ContactCount Physics matches 4 run return 0

# Contact 5
    # Setup
    $execute store result score #Physics.Maths.RelativeContactPos.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactPoint[0]
    $execute store result score #Physics.Maths.RelativeContactPos.y Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactPoint[1]
    $execute store result score #Physics.Maths.RelativeContactPos.z Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactPoint[2]
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

    $execute store result score #Physics.ContactVelocity.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactVelocity[0]
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactVelocity[0] int 1 run scoreboard players operation #Physics.ContactVelocity.x Physics += #Physics.ContactVelocityChange.x Physics
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactVelocity[1] int 1 run scoreboard players operation #Physics.ContactVelocity.y Physics += #Physics.ContactVelocityChange.y Physics
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactVelocity[2] int 1 run scoreboard players operation #Physics.ContactVelocity.z Physics += #Physics.ContactVelocityChange.z Physics

    # Update SeparatingVelocity
    $execute store result score #Physics.ContactNormal.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactNormal[0]
    $execute store result score #Physics.ContactNormal.y Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactNormal[1]
    $execute store result score #Physics.ContactNormal.z Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactNormal[2]

    scoreboard players operation #Physics.ContactNormal.x Physics *= #Physics.ContactVelocity.x Physics
    scoreboard players operation #Physics.ContactNormal.y Physics *= #Physics.ContactVelocity.y Physics
    scoreboard players operation #Physics.ContactNormal.z Physics *= #Physics.ContactVelocity.z Physics
    scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.y Physics
    scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.z Physics

    $execute if score #Physics.ContactNormal.x Physics < @s Physics.Object.MinSeparatingVelocity store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].HasMinSeparatingVelocity byte 0 run data remove storage physics:resolution Object.Objects[0].Blocks[].Hitboxes[].Contacts[{HasMinSeparatingVelocity:0b}].HasMinSeparatingVelocity
    execute if score #Physics.ContactNormal.x Physics < @s Physics.Object.MinSeparatingVelocity run scoreboard players operation @s Physics.Object.MinSeparatingVelocity = #Physics.ContactNormal.x Physics

execute if score #Physics.ContactCount Physics matches 5 run return 0

# Contact 6
    # Setup
    $execute store result score #Physics.Maths.RelativeContactPos.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[5].ContactPoint[0]
    $execute store result score #Physics.Maths.RelativeContactPos.y Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[5].ContactPoint[1]
    $execute store result score #Physics.Maths.RelativeContactPos.z Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[5].ContactPoint[2]
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

    $execute store result score #Physics.ContactVelocity.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[5].ContactVelocity[0]
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[5].ContactVelocity[0] int 1 run scoreboard players operation #Physics.ContactVelocity.x Physics += #Physics.ContactVelocityChange.x Physics
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[5].ContactVelocity[1] int 1 run scoreboard players operation #Physics.ContactVelocity.y Physics += #Physics.ContactVelocityChange.y Physics
    $execute store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[5].ContactVelocity[2] int 1 run scoreboard players operation #Physics.ContactVelocity.z Physics += #Physics.ContactVelocityChange.z Physics

    # Update SeparatingVelocity
    $execute store result score #Physics.ContactNormal.x Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[5].ContactNormal[0]
    $execute store result score #Physics.ContactNormal.y Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[5].ContactNormal[1]
    $execute store result score #Physics.ContactNormal.z Physics run data get storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[5].ContactNormal[2]

    scoreboard players operation #Physics.ContactNormal.x Physics *= #Physics.ContactVelocity.x Physics
    scoreboard players operation #Physics.ContactNormal.y Physics *= #Physics.ContactVelocity.y Physics
    scoreboard players operation #Physics.ContactNormal.z Physics *= #Physics.ContactVelocity.z Physics
    scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.y Physics
    scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.z Physics

    $execute if score #Physics.ContactNormal.x Physics < @s Physics.Object.MinSeparatingVelocity store result storage physics:temp UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[5].HasMinSeparatingVelocity byte 0 run data remove storage physics:resolution Object.Objects[0].Blocks[].Hitboxes[].Contacts[{HasMinSeparatingVelocity:0b}].HasMinSeparatingVelocity
    execute if score #Physics.ContactNormal.x Physics < @s Physics.Object.MinSeparatingVelocity run scoreboard players operation @s Physics.Object.MinSeparatingVelocity = #Physics.ContactNormal.x Physics
