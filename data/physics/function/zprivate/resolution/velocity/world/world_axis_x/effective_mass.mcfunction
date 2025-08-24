# Calculate effective mass along the three orthonormal axes
    # RelativeContactPosition
    # (Important): ContactPoint - ObjectPos
    execute store result score #Physics.Maths.RelativeContactPos.x Physics run data get storage physics:resolution Contact.ContactPos[0]
    execute store result score #Physics.Maths.RelativeContactPos.y Physics run data get storage physics:resolution Contact.ContactPos[1]
    execute store result score #Physics.Maths.RelativeContactPos.z Physics run data get storage physics:resolution Contact.ContactPos[2]
    scoreboard players operation #Physics.Maths.RelativeContactPos.x Physics -= @s Physics.Object.Pos.x
    execute store result score #Physics.Maths.EffectiveMassAxis1.z Physics run scoreboard players operation #Physics.Maths.RelativeContactPos.y Physics -= @s Physics.Object.Pos.y
    execute store result score #Physics.Maths.EffectiveMassAxis1.y Physics run scoreboard players operation #Physics.Maths.RelativeContactPos.z Physics -= @s Physics.Object.Pos.z

    # Axis 1: ContactNormal
        # w = RelativeContactPos x Axis
            # x-component
            # (Important): It's always 0.

            # y-component
            # (Important): It's already set during RelativeContactPosition calculation.

            # z-component
            scoreboard players operation #Physics.Maths.EffectiveMassAxis1.z Physics *= #Physics.Constants.-1 Physics

        # ang = InverseInertiaTensorWorld * w
