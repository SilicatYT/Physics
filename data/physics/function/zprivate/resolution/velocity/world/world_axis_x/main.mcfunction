# Calculate DeltaVelocity (Desired velocity change along the contact normal)
# (Important): -(1 + RestitutionCoefficient) * SeparatingVelocity
# (Important): DeltaVelocity is scaled up by 1,000x * 100x = 100,000x. I scale it up to 100,000,000x at the end so it has the same scaling as EffectiveMass. It should not overflow.
    # Set restitution coefficient to 0 if squared magnitude of contact velocity is too low
    scoreboard players operation #Physics.Maths.SquaredMagnitude Physics = #Physics.MinSeparatingVelocityTotal Physics
    execute store result score #Physics.Maths.Value1 Physics store result score #Physics.Maths.ContactVelocity.y Physics run data get storage physics:resolution Contact.ContactVelocity[1]
    execute store result score #Physics.Maths.Value2 Physics store result score #Physics.Maths.ContactVelocity.z Physics run data get storage physics:resolution Contact.ContactVelocity[2]

    scoreboard players operation #Physics.Maths.SquaredMagnitude Physics *= #Physics.Maths.SquaredMagnitude Physics
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.Value1 Physics
    scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics

    scoreboard players operation #Physics.Maths.SquaredMagnitude Physics += #Physics.Maths.Value1 Physics
    scoreboard players operation #Physics.Maths.SquaredMagnitude Physics += #Physics.Maths.Value2 Physics

    execute if score #Physics.Maths.SquaredMagnitude Physics <= #Physics.Settings.Resolution.RestitutionThreshold Physics run scoreboard players set #Physics.Maths.DeltaVelocity Physics 0
    execute unless score #Physics.Maths.SquaredMagnitude Physics <= #Physics.Settings.Resolution.RestitutionThreshold Physics store result score #Physics.Maths.DeltaVelocity Physics run data get storage physics:resolution Contact.RestitutionCoefficient

scoreboard players add #Physics.Maths.DeltaVelocity Physics 100

scoreboard players operation #Physics.Maths.DeltaVelocity Physics *= #Physics.MinSeparatingVelocityTotal Physics
scoreboard players operation #Physics.Maths.DeltaVelocity Physics *= #Physics.Constants.-1000 Physics

# Calculate orthonormal basis
# (Important): The orthonormal basis is a 3x3 matrix. The first column is the contact normal, the 2nd and 3rd columns are tangents.
# (Important): For axis-aligned contact normals like here, this is trivial, so I just directly incorporate it into subsequent formulas for performance reasons. Here, it's: [[±1.0, 0.0, 0.0],[0.0, 1.0, 0.0],[0.0, 0.0, 1.0]]

# Transform ContactVelocity from world space to contact space
# (Important): To avoid matrix multiplication, I instead do: ContactVelocity.<x/y/z> = ContactVelocity * <respective column of orthonormal basis> (Dot product)
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
    execute store result score #Physics.Maths.MaxFrictionSquared Physics run data get storage physics:resolution Contact.FrictionCoefficient
    execute store result score #Physics.Maths.MaxFriction Physics run scoreboard players operation #Physics.Maths.MaxFrictionSquared Physics *= #Physics.Maths.DeltaVelocity Physics
    scoreboard players operation #Physics.Maths.MaxFrictionSquared Physics /= #Physics.Constants.100 Physics
    scoreboard players operation #Physics.Maths.MaxFrictionSquared Physics *= #Physics.Maths.MaxFrictionSquared Physics

    # If PlanarImpulseSquared is greater than MaxFrictionSquared, apply dynamic friction
    execute if score #Physics.Maths.PlanarImpulse Physics > #Physics.Maths.MaxFrictionSquared Physics run function physics:zprivate/resolution/velocity/world/world_axis_x/dynamic_friction

# Transform impulse from contact space to world space
