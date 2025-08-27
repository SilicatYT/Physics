# Calculate DeltaVelocity (Desired velocity change along the contact normal)
# (Important): -(1 + RestitutionCoefficient) * SeparatingVelocity
# (Important): DeltaVelocity is scaled up by 1,000x * 100x = 100,000x. I scale it up to 100,000,000x at the end so it has the same scaling as EffectiveMass. It should not overflow.
    # Set restitution coefficient to 0 if squared magnitude of contact velocity is too low
    scoreboard players operation #Physics.Maths.SquaredMagnitude Physics = #Physics.MinSeparatingVelocityTotal Physics
    execute store result score #Physics.Maths.ContactVelocityBackup.y Physics store result score #Physics.Maths.Value1 Physics store result score #Physics.Maths.ContactVelocity.y Physics run data get storage physics:resolution Contact.ContactVelocity[1]
    execute store result score #Physics.Maths.ContactVelocityBackup.z Physics store result score #Physics.Maths.Value2 Physics store result score #Physics.Maths.ContactVelocity.z Physics run data get storage physics:resolution Contact.ContactVelocity[2]

    scoreboard players operation #Physics.Maths.SquaredMagnitude Physics *= #Physics.Maths.SquaredMagnitude Physics
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.Value1 Physics
    scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics

    scoreboard players operation #Physics.Maths.SquaredMagnitude Physics += #Physics.Maths.Value1 Physics
    scoreboard players operation #Physics.Maths.SquaredMagnitude Physics += #Physics.Maths.Value2 Physics

    execute if score #Physics.Maths.SquaredMagnitude Physics <= #Physics.Settings.Resolution.RestitutionThreshold Physics run scoreboard players set #Physics.Maths.DeltaVelocity Physics 0
    execute unless score #Physics.Maths.SquaredMagnitude Physics <= #Physics.Settings.Resolution.RestitutionThreshold Physics store result score #Physics.Maths.DeltaVelocity Physics run data get storage physics:resolution Block.RestitutionCoefficient

scoreboard players add #Physics.Maths.DeltaVelocity Physics 100

scoreboard players operation #Physics.Maths.DeltaVelocity Physics *= #Physics.MinSeparatingVelocityTotal Physics
scoreboard players operation #Physics.Maths.DeltaVelocity Physics *= #Physics.Constants.-1000 Physics

# Calculate orthonormal basis
# (Important): The orthonormal basis is a 3x3 matrix. The first column is the contact normal, the 2nd and 3rd columns are tangents.
# (Important): For axis-aligned contact normals like here, this is trivial, so I just directly incorporate it into subsequent formulas for performance reasons. Here, it's: [[±1.0, 0.0, 0.0],[0.0, 1.0, 0.0],[0.0, 0.0, 1.0]]

# Transform ContactVelocity from world space to contact space
# (Important): To avoid matrix multiplication, I instead do: ContactVelocityContactSpace.<x/y/z> = ContactVelocity * <respective column of orthonormal basis> (Dot product)
# (Important): Here, the ContactVelocity is already in contact space.

# Calculate effective mass along the 3 contact axes (3 columns of the orthonormal basis)
# (Important): Because the effective mass stays the same if the contact normal doesn't change, I only calculate it once per tick for each contact.
execute store result score #Physics.Check Physics if data storage physics:resolution Contact.EffectiveMass
execute if score #Physics.Check Physics matches 0 run function physics:zprivate/resolution/velocity/world/world_axis_x/calculate_effective_mass
execute if score #Physics.Check Physics matches 1 store result score #Physics.Maths.a1.y Physics run data get storage physics:resolution Contact.EffectiveMass[0]
execute if score #Physics.Check Physics matches 1 store result score #Physics.Maths.a2.x Physics run data get storage physics:resolution Contact.EffectiveMass[1]
execute if score #Physics.Check Physics matches 1 store result score #Physics.Maths.a3.x Physics run data get storage physics:resolution Contact.EffectiveMass[2]

# Calculate required impulse for desired velocity change
# (Important): I overwrite DeltaVelocity and ContactVelocity to avoid having to copy over scores for performance reasons.
# (Important): Due to the dividend and divisor having the same scaling, the resulting values are scaled 1x. This is okay though.
scoreboard players operation #Physics.Maths.DeltaVelocity Physics /= #Physics.Maths.a1.y Physics
execute store result score #Physics.Maths.PlanarImpulse Physics run scoreboard players operation #Physics.Maths.ContactVelocity.y Physics /= #Physics.Maths.a2.x Physics
execute store result score #Physics.Maths.ImpulseCopy.z Physics run scoreboard players operation #Physics.Maths.ContactVelocity.z Physics /= #Physics.Maths.a3.x Physics

# Apply friction to the impulse
    # Calculate squared planar impulse
    scoreboard players operation #Physics.Maths.PlanarImpulse Physics *= #Physics.Maths.PlanarImpulse Physics
    scoreboard players operation #Physics.Maths.ImpulseCopy.z Physics *= #Physics.Maths.ImpulseCopy.z Physics
    scoreboard players operation #Physics.Maths.PlanarImpulse Physics += #Physics.Maths.ImpulseCopy.z Physics

    # Calculate squared MaxFriction (& keep track of non-squared)
    # (Important): The scaling of MaxFrictionSquared is still 1x, same as PlanarImpulseSquared, but MaxFriction is 100x.
    execute store result score #Physics.Maths.MaxFrictionSquared Physics run data get storage physics:resolution Block.FrictionCoefficient
    execute store result score #Physics.Maths.MaxFriction Physics run scoreboard players operation #Physics.Maths.MaxFrictionSquared Physics *= #Physics.Maths.DeltaVelocity Physics
    scoreboard players operation #Physics.Maths.MaxFrictionSquared Physics /= #Physics.Constants.100 Physics
    scoreboard players operation #Physics.Maths.MaxFrictionSquared Physics *= #Physics.Maths.MaxFrictionSquared Physics

    # If PlanarImpulseSquared is greater than MaxFrictionSquared, apply dynamic friction
    execute store result score #Physics.Check Physics if score #Physics.Maths.PlanarImpulse Physics > #Physics.Maths.MaxFrictionSquared Physics
    execute if score #Physics.Check Physics matches 0 run function physics:zprivate/resolution/velocity/world/world_axis_x/static_friction
    execute if score #Physics.Check Physics matches 1 run function physics:zprivate/resolution/velocity/world/world_axis_x/dynamic_friction

# Transform impulse from contact space to world space
# (Important): To avoid matrix multiplication, I calculate: ImpulseWorldSpace = (ImpulseContactSpace.x * ContactNormal) + (ImpulseContactSpace.y * Tangent1) + (ImpulseContactSpace.z * Tangent2)
execute if score #Physics.FeatureB Physics matches 10 run scoreboard players operation #Physics.Maths.DeltaVelocity Physics *= #Physics.Constants.-1 Physics

# Apply the impulse
# (Important): The backups for the tangential impulses are set in dynamic_friction or static_friction.
scoreboard players operation #Physics.Maths.Impulse.x Physics = #Physics.Maths.DeltaVelocity Physics

    # LinearVelocityChange = Impulse * InverseMass
    # (Important): The tangential impulses are still scaled 1,000x from the friction calculations (I manually scaled them up if friction calculations didn't happen) so they keep more precision. No overflow should occur.
    scoreboard players operation #Physics.Maths.DeltaVelocity Physics *= @s Physics.Object.InverseMassScaled
    execute store result score #Physics.LinearVelocityChange.x Physics run scoreboard players operation #Physics.Maths.DeltaVelocity Physics /= #Physics.Constants.100 Physics

    scoreboard players operation #Physics.Maths.ContactVelocity.y Physics *= @s Physics.Object.InverseMassScaled
    execute store result score #Physics.LinearVelocityChange.y Physics run scoreboard players operation #Physics.Maths.ContactVelocity.y Physics /= #Physics.Constants.100000 Physics

    scoreboard players operation #Physics.Maths.ContactVelocity.z Physics *= @s Physics.Object.InverseMassScaled
    execute store result score #Physics.LinearVelocityChange.z Physics run scoreboard players operation #Physics.Maths.ContactVelocity.z Physics /= #Physics.Constants.100000 Physics

    scoreboard players operation @s Physics.Object.Velocity.x += #Physics.LinearVelocityChange.x Physics
    scoreboard players operation @s Physics.Object.Velocity.y += #Physics.LinearVelocityChange.y Physics
    scoreboard players operation @s Physics.Object.Velocity.z += #Physics.LinearVelocityChange.z Physics

    # ImpulsiveTorque = RelativeContactPos x Impulse
    execute store result score #Physics.Maths.Torque.z Physics run data get storage physics:resolution Contact.ContactPoint[0]
    execute store result score #Physics.AngularVelocityChange.x Physics run data get storage physics:resolution Contact.ContactPoint[1]
    execute store result score #Physics.Maths.Torque.y Physics run data get storage physics:resolution Contact.ContactPoint[2]
    execute store result score #Physics.Maths.RelativeContactPos.x Physics store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.Maths.Torque.z Physics -= @s Physics.Object.Pos.x
    execute store result score #Physics.Maths.RelativeContactPos.y Physics store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.AngularVelocityChange.x Physics -= @s Physics.Object.Pos.y
    execute store result score #Physics.Maths.RelativeContactPos.z Physics store result score #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Maths.Torque.y Physics -= @s Physics.Object.Pos.z

    scoreboard players operation #Physics.AngularVelocityChange.x Physics *= #Physics.Maths.Impulse.z Physics
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.Impulse.y Physics
    execute store result score #Physics.AngularVelocityChange.z Physics store result score #Physics.AngularVelocityChange.y Physics run scoreboard players operation #Physics.AngularVelocityChange.x Physics -= #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.Maths.Torque.y Physics *= #Physics.Maths.Impulse.x Physics
    scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Impulse.z Physics
    execute store result score #Physics.Maths.Value6 Physics store result score #Physics.Maths.Value4 Physics run scoreboard players operation #Physics.Maths.Torque.y Physics -= #Physics.Maths.Value2 Physics

    scoreboard players operation #Physics.Maths.Torque.z Physics *= #Physics.Maths.Impulse.y Physics
    scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Impulse.x Physics
    execute store result score #Physics.Maths.Value7 Physics store result score #Physics.Maths.Value5 Physics run scoreboard players operation #Physics.Maths.Torque.z Physics -= #Physics.Maths.Value3 Physics

    # AngularVelocityChange = InverseInertiaTensorGlobal * ImpulsiveTorque
    scoreboard players operation #Physics.AngularVelocityChange.x Physics *= @s Physics.Object.InverseInertiaTensorGlobal.0
    scoreboard players operation #Physics.Maths.Torque.y Physics *= @s Physics.Object.InverseInertiaTensorGlobal.1
    scoreboard players operation #Physics.AngularVelocityChange.x Physics += #Physics.Maths.Torque.y Physics
    scoreboard players operation #Physics.Maths.Torque.z Physics *= @s Physics.Object.InverseInertiaTensorGlobal.2
    scoreboard players operation #Physics.AngularVelocityChange.x Physics += #Physics.Maths.Torque.z Physics
    execute store result score #Physics.Maths.Value9 Physics store result score #Physics.ContactVelocityChange.z Physics run scoreboard players operation #Physics.AngularVelocityChange.x Physics /= #Physics.Constants.100000 Physics

    scoreboard players operation #Physics.AngularVelocityChange.y Physics *= @s Physics.Object.InverseInertiaTensorGlobal.3
    scoreboard players operation #Physics.Maths.Value4 Physics *= @s Physics.Object.InverseInertiaTensorGlobal.4
    scoreboard players operation #Physics.AngularVelocityChange.y Physics += #Physics.Maths.Value4 Physics
    scoreboard players operation #Physics.Maths.Value5 Physics *= @s Physics.Object.InverseInertiaTensorGlobal.5
    scoreboard players operation #Physics.AngularVelocityChange.y Physics += #Physics.Maths.Value5 Physics
    execute store result score #Physics.Maths.Value10 Physics store result score #Physics.ContactVelocityChange.x Physics run scoreboard players operation #Physics.AngularVelocityChange.y Physics /= #Physics.Constants.100000 Physics

    scoreboard players operation #Physics.AngularVelocityChange.z Physics *= @s Physics.Object.InverseInertiaTensorGlobal.6
    scoreboard players operation #Physics.Maths.Value6 Physics *= @s Physics.Object.InverseInertiaTensorGlobal.7
    scoreboard players operation #Physics.AngularVelocityChange.z Physics += #Physics.Maths.Value6 Physics
    scoreboard players operation #Physics.Maths.Value7 Physics *= @s Physics.Object.InverseInertiaTensorGlobal.8
    scoreboard players operation #Physics.AngularVelocityChange.z Physics += #Physics.Maths.Value7 Physics
    execute store result score #Physics.Maths.Value8 Physics store result score #Physics.ContactVelocityChange.y Physics run scoreboard players operation #Physics.AngularVelocityChange.z Physics /= #Physics.Constants.100000 Physics

    scoreboard players operation @s Physics.Object.AngularVelocity.x += #Physics.AngularVelocityChange.x Physics
    scoreboard players operation @s Physics.Object.AngularVelocity.y += #Physics.AngularVelocityChange.y Physics
    scoreboard players operation @s Physics.Object.AngularVelocity.z += #Physics.AngularVelocityChange.z Physics

# Update this contact's ContactVelocity & SeparatingVelocity
# (Important): ContactVelocityChange = LinearVelocityChange + (AngularVelocityChange x RelativeContactPos)
scoreboard players operation #Physics.ContactVelocityChange.x Physics *= #Physics.Maths.RelativeContactPos.z Physics
scoreboard players operation #Physics.Maths.Value8 Physics *= #Physics.Maths.RelativeContactPos.y Physics
scoreboard players operation #Physics.ContactVelocityChange.x Physics -= #Physics.Maths.Value8 Physics
scoreboard players operation #Physics.ContactVelocityChange.x Physics /= #Physics.Constants.1000 Physics

scoreboard players operation #Physics.ContactVelocityChange.y Physics *= #Physics.Maths.RelativeContactPos.x Physics
scoreboard players operation #Physics.Maths.Value9 Physics *= #Physics.Maths.RelativeContactPos.z Physics
scoreboard players operation #Physics.ContactVelocityChange.y Physics -= #Physics.Maths.Value9 Physics
scoreboard players operation #Physics.ContactVelocityChange.y Physics /= #Physics.Constants.1000 Physics

scoreboard players operation #Physics.ContactVelocityChange.z Physics *= #Physics.Maths.RelativeContactPos.y Physics
scoreboard players operation #Physics.Maths.Value10 Physics *= #Physics.Maths.RelativeContactPos.x Physics
scoreboard players operation #Physics.ContactVelocityChange.z Physics -= #Physics.Maths.Value10 Physics
scoreboard players operation #Physics.ContactVelocityChange.z Physics /= #Physics.Constants.1000 Physics

scoreboard players operation #Physics.ContactVelocityChange.x Physics += #Physics.LinearVelocityChange.x Physics
scoreboard players operation #Physics.ContactVelocityChange.y Physics += #Physics.LinearVelocityChange.y Physics
scoreboard players operation #Physics.ContactVelocityChange.z Physics += #Physics.LinearVelocityChange.z Physics

execute if score #Physics.FeatureB Physics matches 10 store result score @s Physics.Object.MinSeparatingVelocity store result storage physics:resolution Contact.SeparatingVelocity short 1 store result storage physics:resolution Contact.ContactVelocity[0] int -1 run scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics -= #Physics.ContactVelocityChange.x Physics
execute if score #Physics.FeatureB Physics matches 11 store result score @s Physics.Object.MinSeparatingVelocity store result storage physics:resolution Contact.SeparatingVelocity short 1 store result storage physics:resolution Contact.ContactVelocity[0] int 1 run scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics += #Physics.ContactVelocityChange.x Physics
execute store result storage physics:resolution Contact.ContactVelocity[1] int 1 run scoreboard players operation #Physics.Maths.ContactVelocityBackup.y Physics += #Physics.ContactVelocityChange.y Physics
execute store result storage physics:resolution Contact.ContactVelocity[2] int 1 run scoreboard players operation #Physics.Maths.ContactVelocityBackup.z Physics += #Physics.ContactVelocityChange.z Physics

# Update other contacts' ContactVelocity & SeparatingVelocity
    # World contacts
        # Update the contacts from the current hitbox

        # Update the contacts from the current block

        # Update the contacts from the remaining blocks
        execute store result score #Physics.BlockCount Physics if data storage physics:resolution Object.Objects[0].Blocks[]
        execute if score #Physics.BlockCount Physics matches 1.. run function physics:zprivate/resolution/velocity/world/update_separating_velocity/main

    # Object-object contacts
    # ...








    # Order: 1. Update this contact's separatingvelocity and contactvelocity, and set the object's MinSeparatingVelocity to it. (DONE)
    #        2. Update the other contacts from this hitbox
    #        3. Update the other contacts from this block
    #        4. Update the other blocks (Will code that one first because maybe I can re-use the same functions for 2 and 3)
    #        5. Append the current contact to the hitbox, then append the hitbox to the block, then append the block to the other blocks in the final storage
    #        6. Don't forget to set the MinSeparatingVelocityTotal.World score to MinSeparatingVelocityTotal after updating every world contact! Because afterwards, object-object contacts would be updated
