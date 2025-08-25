data modify storage physics:resolution Contact.EffectiveMass set value [I;0,0,0]

# Calculate effective mass along the three orthonormal axes (InverseMass + Axis * (RelativeContactPos x (InverseInertiaTensorGlobal * (RelativeContactPos x Axis))))
# (Important): RelativeContactPos x Axis = a   |   InverseInertiaTensorGlobal * a = b   |   RelativeContactPos x b = c   |   Axis * c = d   |   InverseMass + d = EffectiveMass

    # RelativeContactPosition
    # (Important): ContactPoint - ObjectPos
    execute store result score #Physics.Maths.RelativeContactPos.x Physics run data get storage physics:resolution Contact.ContactPoint[0]
    execute store result score #Physics.Maths.RelativeContactPos.y Physics run data get storage physics:resolution Contact.ContactPoint[1]
    execute store result score #Physics.Maths.RelativeContactPos.z Physics run data get storage physics:resolution Contact.ContactPoint[2]
    scoreboard players operation #Physics.Maths.RelativeContactPos.x Physics -= @s Physics.Object.Pos.x
    execute store result score #Physics.Maths.a.z Physics run scoreboard players operation #Physics.Maths.RelativeContactPos.y Physics -= @s Physics.Object.Pos.y
    execute store result score #Physics.Maths.a.y Physics run scoreboard players operation #Physics.Maths.RelativeContactPos.z Physics -= @s Physics.Object.Pos.z

    # Axis 1: ContactNormal [±1.0, 0.0, 0.0]
        # a = RelativeContactPos x Axis
            # x-component
            # (Important): It's always 0.

            # y-component
            # (Important): It's already set during RelativeContactPosition calculation.
            execute if score #Physics.FeatureB Physics matches 10 run scoreboard players operation #Physics.Maths.a.y Physics *= #Physics.Constants.-1 Physics
            scoreboard players operation #Physics.Maths.b.z Physics = #Physics.Maths.a.y Physics

            # z-component
            execute if score #Physics.FeatureB Physics matches 11 run scoreboard players operation #Physics.Maths.a.z Physics *= #Physics.Constants.-1 Physics
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Maths.a.z Physics

        # b = InverseInertiaTensorGlobal * a
        # (Important): InverseInertiaTensorGlobal is scaled by 100,000x and a is scaled by 1,000x.
        # (Important): Because the next step calculates the cross product between the axis and b, and only the first component of that cross product will be used, I don't need to calculate the x component of b.
        # (Important): I overwrite a's scores for efficiency reasons. "a.y" is "b.y".
        scoreboard players operation #Physics.Maths.a.y Physics *= @s Physics.Object.InverseInertiaTensorGlobal.4
        scoreboard players operation #Physics.Maths.a.z Physics *= @s Physics.Object.InverseInertiaTensorGlobal.5
        scoreboard players operation #Physics.Maths.a.y Physics += #Physics.Maths.a.z Physics
        #scoreboard players operation #Physics.Maths.a.y Physics /= #Physics.Constants.100000 Physics

        scoreboard players operation #Physics.Maths.b.z Physics *= @s Physics.Object.InverseInertiaTensorGlobal.7
        scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.InverseInertiaTensorGlobal.8
        scoreboard players operation #Physics.Maths.b.z Physics += #Physics.Maths.Value1 Physics
        #scoreboard players operation #Physics.Maths.b.z Physics /= #Physics.Constants.100000 Physics

        # c = RelativeContactPos x b
        # (Important): Because of the next step, I only need the x component of the cross product. That's why in the previous calculation, I only calculated the y and z component, because only those are used in the cross product's first component.
        # (Important): I overwrite b's scores for efficiency reasons. "b.z" is "c.x".
        scoreboard players operation #Physics.Maths.b.z Physics *= #Physics.Maths.RelativeContactPos.y Physics
        scoreboard players operation #Physics.Maths.a.y Physics *= #Physics.Maths.RelativeContactPos.z Physics
        scoreboard players operation #Physics.Maths.b.z Physics -= #Physics.Maths.a.y Physics
        scoreboard players operation #Physics.Maths.b.z Physics /= #Physics.Constants.1000 Physics

        # d = Axis * c
        # (Important): I overwrite c's scores for efficiency reasons. "b.z" is "d.x".
        execute if score #Physics.FeatureB Physics matches 10 run scoreboard players operation #Physics.Maths.b.z Physics *= #Physics.Constants.-1 Physics
        # EffectiveMass = InverseMass + d
        #execute store result storage physics:resolution Contact.EffectiveMass[0] int 1 run scoreboard players operation #Physics.Maths.b.z Physics += @s Physics.Object.InverseMassScaled2
        # TEMP:
        scoreboard players add #Physics.Maths.b.z Physics 100000

        # AT THE CURRENT SCALE, THE INVERSE MASS WOULD BE 100000
tellraw @p {"score":{"name":"#Physics.Maths.b.z","objective":"Physics"}}

# => The value is correct now, but I need to figure out the scaling so it doesn't overflow but still has some accuracy.
