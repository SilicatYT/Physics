data modify storage physics:resolution Contact.EffectiveMass set value [I;0,0,0]

# Calculate effective mass along the three orthonormal axes (InverseMass + Axis * (RelativeContactPos x (InverseInertiaTensorGlobal * (RelativeContactPos x Axis))))
# (Important): RelativeContactPos x Axis = a   |   InverseInertiaTensorGlobal * a = b   |   RelativeContactPos x b = c   |   Axis * c = d   |   InverseMass + d = EffectiveMass
# (Important): For world_axis_?, the effective mass calculations are scaled up just enough so that InverseMass can be added to it without needing to scale it down. The calculations don't overflow for reasonable numbers. The scaling is different from non-axis-aligned contact normals.

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
        scoreboard players operation #Physics.Maths.a.y Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.Maths.b.z Physics *= @s Physics.Object.InverseInertiaTensorGlobal.7
        scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.InverseInertiaTensorGlobal.8
        scoreboard players operation #Physics.Maths.b.z Physics += #Physics.Maths.Value1 Physics
        scoreboard players operation #Physics.Maths.b.z Physics /= #Physics.Constants.1000 Physics

        # c = RelativeContactPos x b
        # (Important): Because of the next step, I only need the x component of the cross product. That's why in the previous calculation, I only calculated the y and z component, because only those are used in the cross product's first component.
        # (Important): I overwrite b's scores for efficiency reasons. "b.z" is "c.x".
        scoreboard players operation #Physics.Maths.b.z Physics *= #Physics.Maths.RelativeContactPos.y Physics
        scoreboard players operation #Physics.Maths.a.y Physics *= #Physics.Maths.RelativeContactPos.z Physics
        scoreboard players operation #Physics.Maths.b.z Physics -= #Physics.Maths.a.y Physics

        # d = Axis * c
        # (Important): I overwrite c's scores for efficiency reasons. "b.z" is "d.x".
        execute if score #Physics.FeatureB Physics matches 10 run scoreboard players operation #Physics.Maths.b.z Physics *= #Physics.Constants.-1 Physics

        # EffectiveMass = InverseMass + d
        execute store result storage physics:resolution Contact.EffectiveMass[0] int 1 run scoreboard players operation #Physics.Maths.b.z Physics += @s Physics.Object.InverseMass

#tellraw @p {"score":{"name":"#Physics.Maths.b.z","objective":"Physics"}}

# Scale check (gilt nur für axis-aligned contact normal, nicht für edge-edge):
# - RelativeContactPos will ich bis zu 10 Blöcke supporten idealerweise (5 würde auch gehen, weils relative ist und trzdem 10-block-lange Objekte erlauben würde), also kann RelativeContactPos bis zu 10000 sein.
# => a ist maximal 10000
# - InverseInertiaTensor ist 100k für nen 0.1x0.1x0.1 Würfel, 630 für nen 1x1x1 Würfel und 36 für nen 4x4x4 Würfel. Bei nem normalen Punch overflowed es bei 0.1x0.1x0.1 sowieso, also supporte ich mal bis zu 20k (12k overflowed nicht bei Punches, für 0.25x0.25x0.25 Würfel)
# => b ist maximal 20,000 * 10,000 * 2 = 400,000,000
# - Bei c rechne ich *= 10,000 maximal, also sag ich mal, ich dividiere b durch 1,000, so dass es *fast* aufgehen würde. Muss ich halt annehmen, dass es nicht ganz 20-Block-Lange Objekte erlaubt, aber ok

# => Das Scale, so wie es jetzt ist, müsste klappen

# Hinweis: Könnte vlt sogar noch weiter gehen, weil hoher InverseInertiaTensor und hohe RelativeContactPos schliessen sich aus (zumindest wenn es nur 1 Objekt hat. Bei zweien könnte es anders sein)



# Der echte ist 0.00056, also ist das Scaling 100,000,000x

#If separating velocity is -2.0, I calculate -(-2.0) / 0.00056 = 3571.
#Then I multiply this with the inverse mass to receive the linear velocity change: 3571 * 0.001 = 3.571

#Then I add this to the velocity (I will just add it to the separating velocity in this example for demonstration purposes) and you get +1.571

# The comma digits I cut off from 3571.xyz probably did no difference, so it doesn't matter if the scaling is 1x (instead of 1000x) after calculating the impulse.
